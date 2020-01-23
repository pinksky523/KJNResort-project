package com.kjnresort.service;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;


import com.kjnresort.domain.CondoReserveVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.mapper.CondoReserveMapper;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class CondoReserveServiceImpl implements CondoReserveService {
	CondoReserveMapper condoReservemapper;
	

	@Override
	public List<String> getAvailableRoomType(Calendar checkIn, Calendar checkOut) {
		log.info("getAvailableRoomType Service Impl 진입");
		List<String> availableRoomType=new ArrayList<String>();
		//List<String> a=new ArrayList<String>();
		//a.add("D");
		//a.add("R");
		String[] roomTypeArr= {"P","D","N","R"};
		String type;
		int count=-1;
		int roomNo=0;
		for(int i=0;i<4;i++) {
			type=roomTypeArr[i];
			roomNo=(i+1)*100;
			for(int j=1;j<10;j++) {
				count=condoReservemapper.getOverlapDateCount(type, roomNo+j, checkIn.getTime(), checkOut.getTime());
				if(count==0) {
					availableRoomType.add(type);
					break;
				}
			}
		}
		return availableRoomType;
	}

	
	@Override
	public List<CondoReserveVO> getListWithPaging(Criteria cri) {
		// TODO Auto-generated method stub
		return null;
	}



	@Override
	public List<CondoReserveVO> getListWithId(Criteria cri, String id) {
		// TODO Auto-generated method stub
		return null;
	}



	@Override
	public int register(CondoReserveVO reserve) {
		log.info("register reserve in serviceImpl.....");
		
		int count=-1;
		int roomNo=-1;
		int reserveRoomNo=-1;
		if(reserve.getRoomType().equals("P")) {
			roomNo=100;
		}else if(reserve.getRoomType().equals("D")){
			roomNo=200;
		}else if(reserve.getRoomType().equals("N")) {
			roomNo=300;
		}else{
			roomNo=400;
		}
		
		for(int i=1;i<10;i++) {
			count=condoReservemapper.getOverlapDateCount(reserve.getRoomType(), roomNo+i,reserve.getCheckIn(),reserve.getCheckOut());
			if(count==0) {
				reserveRoomNo=roomNo+i;
				break;
			}
		}
		reserve.setRoomNo(reserveRoomNo);
		return condoReservemapper.insert(reserve);
		
	}



	@Override
	public boolean modify(CondoReserveVO reserve) {
		return condoReservemapper.update(reserve)==1;
	
	}



	@Override
	public CondoReserveVO get(Long reserveNo) {
		return condoReservemapper.read(reserveNo);
		
	}



	@Override
	public int getTotalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return 0;
	}



	@Override
	public int getTotalCountWithId(Criteria cri, String id) {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public long getMaxReserveNo() {
		return condoReservemapper.getMaxReserveNo();
	}



	
	
}
