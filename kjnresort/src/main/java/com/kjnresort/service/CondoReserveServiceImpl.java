package com.kjnresort.service;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

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
	public List<String> getAvailableRoomType(String roomType, Calendar checkIn, Calendar checkOut) {
		log.info("getAvailableRoomType in serviceImple....");
		int checkInRe=-1;
		int checkOutRe=-1;
		int lastRoomNo=-1;
		int reserveSizeByRoomType=-1;
		List<String> availableRoomType=new ArrayList<String>();
		
		
		/*Calendar checkIn=Calendar.getInstance();
		checkIn.set(2020, 0, 6, 0, 0, 0);
		Calendar checkOut=Calendar.getInstance();
		checkOut.set(2020, 0, 8, 0, 0, 0);
		*/
		reserveSizeByRoomType=condoReservemapper.getReserveSizeByRoomType("P");
		if(reserveSizeByRoomType==0) { //예약이 하나도 없을 때 바로가능
			availableRoomType.add("P"); //바로 가능
		}else {//예약이 하나 이상
			checkInRe=condoReservemapper.confirmCheckInByRoomType(checkIn.getTime(),"P");
			lastRoomNo=condoReservemapper.getMaxRoomNoByRoomType("P");
			if(checkInRe==0) {//re가 0이여야 가능 1이상 불가능
				checkOutRe=condoReservemapper.confirmCheckOutByRoomType(checkOut.getTime(),"P");
				
				if(checkOutRe==0) {
					availableRoomType.add("P");
				}else { //체크아웃 범위가 안맞을 때 
					if(lastRoomNo<109) {
						availableRoomType.add("P");
					}
				}
			}else {//체크인 범위가 안맞을 때 
				if(lastRoomNo<109) {
					availableRoomType.add("P");
				}
			}
		}//END P
		
		checkInRe=-1;
		checkOutRe=-1;
		lastRoomNo=-1;
		reserveSizeByRoomType=-1;
		
		reserveSizeByRoomType=condoReservemapper.getReserveSizeByRoomType("D");
		if(reserveSizeByRoomType==0) { //예약이 하나도 없을 때 바로가능
			availableRoomType.add("D"); //바로 가능
		}else {//예약이 하나 이상
			checkInRe=condoReservemapper.confirmCheckInByRoomType(checkIn.getTime(),"D");
			if(checkInRe==0) {//re가 0이여야 가능 1이상 불가능
				checkOutRe=condoReservemapper.confirmCheckOutByRoomType(checkOut.getTime(),"D");
				lastRoomNo=condoReservemapper.getMaxRoomNoByRoomType("D");
				if(checkOutRe==0) {
					availableRoomType.add("D");
				}else {
					if(lastRoomNo<209) {
						availableRoomType.add("D");
					}
				}
			}else {//체크인 범위가 안맞을 때 
				if(lastRoomNo<209) {
					availableRoomType.add("D");
				}
			}
		}//END D
		
		checkInRe=-1;
		checkOutRe=-1;
		lastRoomNo=-1;
		reserveSizeByRoomType=-1;
		
		reserveSizeByRoomType=condoReservemapper.getReserveSizeByRoomType("N");
		if(reserveSizeByRoomType==0) { //예약이 하나도 없을 때 바로가능
			availableRoomType.add("N"); //바로 가능
		}else {//예약이 하나 이상
			checkInRe=condoReservemapper.confirmCheckInByRoomType( checkIn.getTime(),"N");
			if(checkInRe==0) {//re가 0이여야 가능 1이상 불가능
				checkOutRe=condoReservemapper.confirmCheckOutByRoomType(checkOut.getTime(),"N");
				lastRoomNo=condoReservemapper.getMaxRoomNoByRoomType("N");
				if(checkOutRe==0) {
					availableRoomType.add("N");
				}else {
					if(lastRoomNo<309) {
						availableRoomType.add("N");
					}
				}
			}else {
				if(lastRoomNo<309) {
					availableRoomType.add("N");
				}
			}
		}//END N
		
		checkInRe=-1;
		checkOutRe=-1;
		lastRoomNo=-1;
		reserveSizeByRoomType=-1;
		
		reserveSizeByRoomType=condoReservemapper.getReserveSizeByRoomType("R");
		if(reserveSizeByRoomType==0) { //예약이 하나도 없을 때 바로가능
			availableRoomType.add("R"); //바로 가능
		}else {//예약이 하나 이상
			checkInRe=condoReservemapper.confirmCheckInByRoomType(checkIn.getTime(),"R");
			if(checkInRe==0) {//re가 0이여야 가능 1이상 불가능
				checkOutRe=condoReservemapper.confirmCheckOutByRoomType(checkOut.getTime(),"R");
				lastRoomNo=condoReservemapper.getMaxRoomNoByRoomType("N");
				if(checkOutRe==0) {
					availableRoomType.add("R");
				}else {
					if(lastRoomNo<109) {
						availableRoomType.add("R");
					}
				}
			}else {
				if(lastRoomNo<409) {
					availableRoomType.add("R");
				}
			}
		}//END R
		
		for (String string : availableRoomType) {
			log.warn("available RoomType:"+string);
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
	public void register(CondoReserveVO reserve) {
		log.info("register reserve in serviceImpl.....");
		condoReservemapper.insert(reserve);
		
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
	
	
}
