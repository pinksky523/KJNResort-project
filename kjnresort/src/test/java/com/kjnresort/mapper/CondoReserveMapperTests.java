package com.kjnresort.mapper;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kjnresort.domain.CondoReserveVO;

import org.springframework.beans.factory.annotation.Autowired;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
						"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class CondoReserveMapperTests {
	
	@Setter(onMethod_=@Autowired)
	private CondoReserveMapper mapper;
	//@Setter(onMethod_=@Autowired)
	//private CondoMapper priceMapper;
	
	
	@Test
	public void adasd() {
		Calendar checkIn=Calendar.getInstance();
		checkIn.set(2020, 0,13, 0, 0, 0);
		Calendar checkOut=Calendar.getInstance();
		checkOut.set(2020, 0,14, 0, 0, 0);
		int count=-1;
		String roomType="N";
		int roomNo=0;
		int reserveRoomNo=0;
		if(roomType.equals("P")) {
			roomNo=100;
		}else if(roomType.equals("D")){
			roomNo=200;
		}else if(roomType.equals("N")) {
			roomNo=300;
		}else{
			roomNo=400;
		}
		
		for(int i=1;i<10;i++) {
			count=mapper.getOverlapDateCount(roomType, roomNo+i, checkIn.getTime(), checkOut.getTime());
			if(count==0) {
				reserveRoomNo=roomNo+i;
				break;
			}
		}
		
		log.info(reserveRoomNo);
	
	}
	
	
	//@Test
	public void reserveTEST() {
		Calendar checkIn=Calendar.getInstance();
		checkIn.set(2020, 0, 6, 0, 0, 0);
		Calendar checkOut=Calendar.getInstance();
		checkOut.set(2020, 0, 8, 0, 0, 0);
		List<String> availableRoomType=new ArrayList<String>();
		
		String[] roomTypeArr= {"P","D","N","R"};
		String type;
		int size=-1;
		int roomNo=0;
		for(int i=0;i<4;i++) {
			type=roomTypeArr[i];
			roomNo=(i+1)*100;
			for(int j=1;j<10;j++) {
				size=mapper.getOverlapDateCount(type, roomNo+j, checkIn.getTime(), checkOut.getTime());
				if(size==0) {
					availableRoomType.add(type);
					break;
				}
			}
		}
		
		log.info("====================");
		log.info(availableRoomType);
		
		
	}
	
	@Test
	public void SGSEFE() {
		Calendar checkIn=Calendar.getInstance();
		checkIn.set(2020, 0, 6, 0, 0, 0);
		Calendar checkOut=Calendar.getInstance();
		checkOut.set(2020, 0, 8, 0, 0, 0);
		List<String> nonAvailableRoomType=new ArrayList<String>();
		List<String> availableRoomType=new ArrayList<String>();
		Map<String,Integer> roomType=new HashMap<String,Integer>();
		roomType.put("P",1);
		roomType.put("D",1);
		roomType.put("N",1);
		roomType.put("R",1);
		//nonAvailableRoomType=mapper.getNonAvailableRoomType(checkIn.getTime(), checkOut.getTime());
		
		for(String type:roomType.keySet()) {
			for (String nonType : nonAvailableRoomType) {
				if(type.equals(nonType)&&mapper.getMaxRoomNoByRoomType(nonType)%100==9){
					roomType.replace(type, 0);
				}
			} 
		}//end map foreach
		
		for(Map.Entry<String,Integer> entry:roomType.entrySet()) {
			if(entry.getValue()==1) {
				availableRoomType.add(entry.getKey());
			}
		}//end map foreach
		
		
		log.info(availableRoomType);
	}
	
	//@Test
	public void testreserve() {
		int checkInRe=-1;
		int checkOutRe=-1;
		int lastRoomNo=-1;
		int reserveSizeByRoomType=-1;
		List<String> availableRoomType=new ArrayList<String>();
		
		Calendar checkIn=Calendar.getInstance();
		checkIn.set(2020, 0, 6, 0, 0, 0);
		Calendar checkOut=Calendar.getInstance();
		checkOut.set(2020, 0, 8, 0, 0, 0);
		
		reserveSizeByRoomType=mapper.getReserveSizeByRoomType("P");
		if(reserveSizeByRoomType==0) { //예약이 하나도 없을 때 바로가능
			availableRoomType.add("P"); //바로 가능
		}else {//예약이 하나 이상
			//checkInRe=mapper.confirmCheckInByRoomType(checkIn.getTime(),"P");
			lastRoomNo=mapper.getMaxRoomNoByRoomType("P");
			if(checkInRe==0) {//re가 0이여야 가능 1이상 불가능
			//	checkOutRe=mapper.confirmCheckOutByRoomType(checkOut.getTime(),"P");
				
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
		
		reserveSizeByRoomType=mapper.getReserveSizeByRoomType("D");
		if(reserveSizeByRoomType==0) { //예약이 하나도 없을 때 바로가능
			availableRoomType.add("D"); //바로 가능
		}else {//예약이 하나 이상
			//checkInRe=mapper.confirmCheckInByRoomType(checkIn.getTime(),"D");
			if(checkInRe==0) {//re가 0이여야 가능 1이상 불가능
			//	checkOutRe=mapper.confirmCheckOutByRoomType(checkOut.getTime(),"D");
				lastRoomNo=mapper.getMaxRoomNoByRoomType("D");
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
		
		reserveSizeByRoomType=mapper.getReserveSizeByRoomType("N");
		if(reserveSizeByRoomType==0) { //예약이 하나도 없을 때 바로가능
			availableRoomType.add("N"); //바로 가능
		}else {//예약이 하나 이상
			//checkInRe=mapper.confirmCheckInByRoomType( checkIn.getTime(),"N");
			if(checkInRe==0) {//re가 0이여야 가능 1이상 불가능
			//	checkOutRe=mapper.confirmCheckOutByRoomType(checkOut.getTime(),"N");
				lastRoomNo=mapper.getMaxRoomNoByRoomType("N");
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
		
		reserveSizeByRoomType=mapper.getReserveSizeByRoomType("R");
		if(reserveSizeByRoomType==0) { //예약이 하나도 없을 때 바로가능
			availableRoomType.add("R"); //바로 가능
		}else {//예약이 하나 이상
			//checkInRe=mapper.confirmCheckInByRoomType(checkIn.getTime(),"R");
			if(checkInRe==0) {//re가 0이여야 가능 1이상 불가능
			//	checkOutRe=mapper.confirmCheckOutByRoomType(checkOut.getTime(),"R");
				lastRoomNo=mapper.getMaxRoomNoByRoomType("N");
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
		
	}//END METHOD
	
	
	
	//@Test
	public void timetest() {
	
		Calendar in=Calendar.getInstance();
		in.set(2020,0,1,23,11,0);
		mapper.insertdate(in.getTime());
		log.info(mapper.get());
	}
	
	
//	//@Test
//	public void getReserveList() {//�������� �����ͼ� ���డ���� �� ���� ����غ���
//		//String[] roomType= {"P","D","N","R"};
//		long preCheckIn,preCheckOut,postCheckIn,postCheckOut;
//		Calendar checkInCalendar=Calendar.getInstance();
//		checkInCalendar.set(2020,0,1);
//		Calendar checkOutCalendar=Calendar.getInstance();
//		checkInCalendar.set(2020,0,3);
//		long inputCheckIn=checkInCalendar.getTimeInMillis();
//		long inputCheckOut=checkOutCalendar.getTimeInMillis();
//		List<String> roomAvailable=new ArrayList<String>();
//		List<CondoReserveVO> condoReserveList=new ArrayList<CondoReserveVO>();
//		int reRoomNum=0;
//		boolean re=false;
//		
//		condoReserveList=mapper.getReserveView();
//		
//		List<CondoReserveVO> roomPList=new ArrayList<CondoReserveVO>();
//		List<CondoReserveVO> roomDList=new ArrayList<CondoReserveVO>();
//		List<CondoReserveVO> roomNList=new ArrayList<CondoReserveVO>();
//		List<CondoReserveVO> roomRList=new ArrayList<CondoReserveVO>();
//		
//		for (CondoReserveVO vo : condoReserveList) {
//			if(vo.getRoomType().equals("P")) {
//				roomPList.add(vo);
//			}
//			else if(vo.getRoomType().equals("D")) {
//				roomDList.add(vo);
//			}
//			else if(vo.getRoomType().equals("N")) {
//				roomNList.add(vo);
//			}
//			else if(vo.getRoomType().equals("R")) {
//				roomRList.add(vo);
//			}
//		}
//		
//		log.info("roomPList.size():"+roomPList.size());
//		log.info("roomDList.size():"+roomDList.size());
//		log.info("roomNList.size():"+roomNList.size());
//		log.info("roomRList.size():"+roomRList.size());
//		
//		//=============================================================
//		
//		if(roomPList.size()==0) {//������ ���� ��
//			roomAvailable.add("P");
//			
//		}
//		else if(roomPList.size()==1) { //������ �ϳ� ���� ��
//			preCheckIn=roomPList.get(0).getCheckIn().getTime();
//			preCheckOut=roomPList.get(0).getCheckOut().getTime();
//			
//			if(inputCheckOut<=preCheckIn||preCheckOut<=inputCheckIn) {//���డ��!
//				roomAvailable.add("P");
//			}
//		}
//		else {//������ �ΰ� �̻� �� ��
//			
//			
//			for(int i=0;i<roomPList.size()-1;i++) {
//				//���� �� ���Ҵµ� ��ѹ��� 109�� ��¥ ���°Ű� 
//				//108�̸� true�� 109�� ������Ǵϱ�.
//				//preCheckIn=roomPList.get(i).getCheckIn().getTime();
//				preCheckOut=roomPList.get(i).getCheckOut().getTime();
//				
//			    postCheckIn=roomPList.get(i+1).getCheckIn().getTime();
//				//postCheckOut=roomPList.get(i+1).getCheckOut().getTime();
//			    reRoomPNum=roomPList.get(i).getRoomNo();
//			    
//				if(preCheckOut<=inputCheckIn&&inputCheckOut<=postCheckIn) {
//			//		reP=true;
//					break;
//				}
//				
//			}
//			
//			//if(reP==true) {
//				roomAvailable.add("P");
//			//}else if(reP==false&&reRoomPNum<109){
//				roomAvailable.add("P");
//			}
//		}
//		
//		//===========================
//		if(roomDList.size()==0)
//			roomAvailable.add("D");
//		else if(roomPList.size()==1) { //������ �ϳ� ���� ��
//			preCheckIn=roomPList.get(0).getCheckIn().getTime();
//			preCheckOut=roomPList.get(0).getCheckOut().getTime();
//			
//			if(inputCheckOut<=preCheckIn||preCheckOut<=inputCheckIn) {//���డ��!
//				roomAvailable.add("P");
//			}
//		}
//	
//	}
	
	
	//@Test
	public void inputReserve() {
		CondoReserveVO vo=new CondoReserveVO();
		
		
		Calendar checkIn=Calendar.getInstance();
		Calendar checkOut=Calendar.getInstance();
		checkIn.set(20,0,15);
		checkOut.set(20,0,16);
		
		//��� �������� Date�� ����ȯ ������ϹǷ�
		Date cIn=new Date(checkIn.getTimeInMillis());
		Date cOut=new Date(checkOut.getTimeInMillis());
		vo.setCheckIn(cIn);
		vo.setCheckOut(cOut);
		
		
	
		
		//������ �� ���
		long re=checkOut.getTimeInMillis()-checkIn.getTimeInMillis();
		int nights=(int) (re/(24 * 60 * 60 * 1000));
		vo.setNights(nights);
		
		vo.setId("user00");
		//vo.setPrice(priceMapper.getPriceByRoomType("P")*nights);
		vo.setReserveDate(new Date());
		vo.setReview(0);
		vo.setRoomNo(101);
		vo.setRoomType("P");
		vo.setStatus(0);
		mapper.insert(vo);
	}
	
	//@Test
	public void testDate() {
		Calendar a=Calendar.getInstance();
		a.set(2050,0,1);
		Calendar b=Calendar.getInstance();
		b.set(2050,0,3);
		long re=b.getTimeInMillis()-a.getTimeInMillis();
		log.info(re/(24 * 60 * 60 * 1000));
		//Date now=new Date(a.getTimeInMillis());
		//mapper.insertdate(now);
	}
	
	//@Test
	public void breakTest() {
		for(int i=0;i<3;i++) {
			for(int j=0;j<3;j++) {
				if(i==1&&j==1) {
					log.info("j:"+j);
					break;} //���� �ȿ� �ִ� ��ø���� ��������
			}
			log.info("i:"+i);
		}
	}
	
	
	
}
