package com.kjnresort.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kjnresort.domain.CondoVO;
import com.kjnresort.mapper.CondoMapper;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
@AllArgsConstructor
public class CondoSerivceImpl implements CondoService {
		CondoMapper mapper;
		public int modify(CondoVO cmvo) {
			return 0;
		}
		public List<Integer> getPriceList(){
			return null;
		}
}
