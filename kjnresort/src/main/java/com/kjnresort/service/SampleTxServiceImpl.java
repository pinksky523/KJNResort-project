package com.kjnresort.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kjnresort.mapper.Sample1Mapper;
import com.kjnresort.mapper.Sample2Mapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class SampleTxServiceImpl implements SampleTxService {
	private Sample1Mapper mapper1;
	private Sample2Mapper mapper2;
	
	@Transactional
	@Override
	public void addData(String value) {
		log.info("mapper1---------------------");
		mapper1.insertCol1(value);
		
		log.info("mapper2---------------------");
		mapper2.insertCol2(value);
		
		log.info("end-------------------------");
	}

}













