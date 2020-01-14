package com.kjnresort.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.kjnresort.domain.EventAttachVO;
import com.kjnresort.domain.ReviewAttachVO;
import com.kjnresort.mapper.EventAttachMapper;
import com.kjnresort.mapper.ReviewAttachMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
@AllArgsConstructor
public class FileCheckTask {

	@Setter(onMethod_ = @Autowired)
	private ReviewAttachMapper attachMapperR;
	
	@Setter(onMethod_ = @Autowired)
	private EventAttachMapper attachMapperE;
	
	private String getFolderYesterDay() {		// 어제 날짜 폴더의 문자열 반환
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
	@Scheduled(cron = "0 0 13 * * *")
	public void checkFiles() throws Exception{
		log.warn("File Check Task run .....");
		log.warn(new Date());
		
		// 1) 데이터베이스에서 어제 사용된 파일 목록 받아오기
		List<ReviewAttachVO> fileListR = attachMapperR.getOldFiles();
		List<EventAttachVO> fileListE = attachMapperE.getOldFiles();
		
		// 2) 해당 폴더의 파일 목록에서 데이터베이스에 없는 파일 찾아내기
		// tbl_attach 테이블의 데이터를 목록으로 반환
		List<Path> fileListPathsR = fileListR.stream()
							      .map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
								  .collect(Collectors.toList());
		List<Path> fileListPathsE = fileListE.stream()
			      .map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
				  .collect(Collectors.toList());
		
		log.warn("==============================");
		
		fileListPathsR.forEach(p -> log.warn(p));
		fileListPathsE.forEach(p -> log.warn(p));
		
		// 어제 날짜 폴더 가져오기
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		
		// 3) 데이터베이스에 없는 파일들 삭제하기
		// 목록에 없는 삭제 대상 파일들을 배열에 저장
		File[] removeFilesR = targetDir.listFiles(file -> fileListPathsR.contains(file.toPath()) == false);
		File[] removeFilesE = targetDir.listFiles(file -> fileListPathsE.contains(file.toPath()) == false);
		
		log.warn("------------------------------");
		for (File file : removeFilesR) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
		for (File file : removeFilesE) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}
}
