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
	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/uploadAjaxAction")
	@ResponseBody	//만약 맨 위에 @RestController를 썼더라면 이건 안써도 됨
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		List<AttachFileDTO> list = new ArrayList<>();
		
		String uploadFolder = "C:\\upload";
		String uploadFolderPath = getFolder();
		
		//make folder
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path: " + uploadPath);
		
		if(uploadPath.exists() == false) {	//연\\월\\일 폴더가 없으면
			uploadPath.mkdirs();	//생성
		}
		//make yyyy/MM/dd folder
		
		log.info("uploadAjaxPost()");
		for(MultipartFile multipartFile : uploadFile) {
			AttachFileDTO aFileDTO = new AttachFileDTO();
			
			log.info("---------------------------------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//Chrome에서는 multipartFile.getOriginalFilename()을 하면 파일명만 가져와지는데, Internet Explorer는 파일 경로와 파일명이 다같이 나옴
			//Internet Explorer에서 파일명만 가져오고 싶을 때는 아래와 같이 마지막 '\'을 기준으로 잘라낸 문자열이 파일명이 됨
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			
			aFileDTO.setFileName(uploadFileName);
			
			//유효 아이디(예: 01f137a7-0d04-4574-94a0-1a86dc5a2a52) 붙여서 파일 이름 생성하기
			//중복된 사진이 덮여쓰기 되어 업로드 되지 않게 됨
			UUID uuid = UUID.randomUUID();
			log.info("uuid : " + uuid);
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
//			File saveFile = new File(uploadFolder, uploadFileName);
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				multipartFile.transferTo(saveFile);	//transferTo()를 쓸 때는 파일 객체를 만들어야 함
				
				aFileDTO.setUuid(uuid.toString());
				aFileDTO.setUploadPath(uploadFolderPath);
				
				//이미지 파일 여부 확인
				//이미지 파일인 경우에 파일명 맨 앞에 s_가 붙게 됨(예 : s_5c323153-d207-4d0c-aab7-4c8630ed025d_coffee.jpg)
				//가로, 세로 사이즈가 100으로 만들어짐
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 250, 250);
				thumbnail.close();
				//list에 AttachFileDTO 추가
				list.add(aFileDTO);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}//END for
		return new ResponseEntity<>(list, HttpStatus.OK);
		
	}
	
	
		
	//현재 시점의 연\\월\\일 폴더 경로 문자열 생성 및 반환
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	
	//섬네일 이미지 전송
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("fileName : " + fileName);
		File file = new File("C:\\upload\\", fileName);
		log.info("file : " + file);
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
	
	
	//클라이언트가 보낸 파일 이름과 타입이 서버로 잘 넘어오는지 확인
	//서버에서 클라이언트가 보내온 값 콘솔에 찍어보기
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName){
		log.info("deleteFile Name : " + fileName);
		
		File file;
		try {
			file = new File("C:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
			//파일 타입이 이미지일 때 섬네일과 원본 파일 모두 삭제
			String largeFileName = file.getAbsolutePath().replace("s_", "");	//원래 파일명으로 만들기
			log.info("largeFileName : " + largeFileName);
			file = new File(largeFileName);
			file.delete();
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
