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
		
		@Override
		public CondoVO get(String roomType) {
			return mapper.get(roomType);
		}

		@Override
		public int modify(CondoVO cmvo) {
			// TODO Auto-generated method stub
			return 0;
		}

		@Override
		public List<Integer> getPriceList() {
			// TODO Auto-generated method stub
			return null;
		}
		
		
}
