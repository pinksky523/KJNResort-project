package com.kjnresort.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kjnresort.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	// 첨부파일의 삭제 처리
		@PreAuthorize("isAuthenticated()")
		@PostMapping("/deleteFile")
		@ResponseBody
		public ResponseEntity<String> deleteFile(String fileName, String type) {
			try {
				File file = new File("C:\\upload\\"+ URLDecoder.decode(fileName, "UTF-8"));
				
				file.delete();
				
				if(type.equals("image")) {										// 이미지 파일이면 원본 이미지 삭제
					file = new File(file.getAbsolutePath().replace("s_", ""));
					file.delete();
				}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			return new ResponseEntity<String>("deleted",HttpStatus.OK);
			
		}
	
	// 첨부파일의 다운로드 처리
		@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
		@ResponseBody
		public ResponseEntity<Resource> downloadFile(String fileName, @RequestHeader("User-Agent") String userAgent) {
		log.info("download file: " + fileName);
		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
		log.info("resource : " + resource);
		
	//	resource가 없으면 상태 코드 404 반환
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	//	UUID 제거하고 저장
		String resourceName = resource.getFilename().substring(resource.getFilename().indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		String downloadName = "";
		try {
			if(userAgent.contains("Trident")) {						//	IE의 경우
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceName, "UTF-8").replaceAll("\\+", " ");
			} else if(userAgent.contains("Edge")){					//	Edge의 경우
				log.info("Edge brower");
				downloadName = URLEncoder.encode(resourceName, "UTF-8");
				log.info("Edge name:" + downloadName);
			} else {												//	Chrome의 경우
				log.info("Chrome browser");
				downloadName = new String(resourceName.getBytes(),"ISO-8859-1");
			}
			headers.add("Content-Disposition", "attachment; fileName=" + downloadName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}
	
	
	//	섬네일 이미지 전송
		@GetMapping("/display")
		@ResponseBody
		public ResponseEntity<byte[]> getFile(String fileName) {
			
			File file = new File("C:\\upload\\" + fileName);
			
			ResponseEntity<byte[]> result = null;
			
			try {
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Type", Files.probeContentType(file.toPath()));
				result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return result;
		}
	
	private String getFolder() {					// 현재 시점의 연\\월\\일 폴더 경로 문자열 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {		// 이미지 파일 여부 확인
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody				//RestController가 아니라서 붙여준다.
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxAction(MultipartFile[] uploadFile) {
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		
		log.info("update ajax post -----");
		
		String uploadFolder = "C:\\upload";
		
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path" + uploadPath);
		
		if(uploadPath.exists() == false) {			//	연\\월\\일 폴더가 없으면
			uploadPath.mkdirs();  					//	생성
		}
		
		for(MultipartFile multipartfile : uploadFile) {
			AttachFileDTO att = new AttachFileDTO();
			
			log.info("------------------------------");
			log.info("Upload File Name : " + multipartfile.getOriginalFilename());
			log.info("Upload File Size : " + multipartfile.getSize());
			
			UUID uuid = UUID.randomUUID();
			att.setUuid(uuid.toString());
			att.setUploadPath(getFolder());
			att.setFileName(multipartfile.getOriginalFilename());
			log.info("uuid : " + uuid);
			
			String uploadFileName = multipartfile.getOriginalFilename();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartfile.transferTo(saveFile);
				// check image type file
				if(checkImageType(saveFile)) {
					att.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartfile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				//list에 AttachFileDTO 추가
				list.add(att);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}	//End catch
			
		}	//End for
		return new ResponseEntity<>(list, HttpStatus.OK);
	}	//End uploadAjaxAction()
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
		log.info("uploadAjax()");
		
	}	//End GetMapping
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = "C:\\upload";
		
		for(MultipartFile multipartfile : uploadFile) {
			log.info("------------------------------");
			log.info("Upload File Name : " + multipartfile.getOriginalFilename());
			log.info("Upload File Size : " + multipartfile.getSize());
			
			File saveFile = new File(uploadFolder, multipartfile.getOriginalFilename());
			
			try {
				multipartfile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
	}	//End PostMapping
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		
		log.info("upload form()");
	}	//End GetMapping

}
