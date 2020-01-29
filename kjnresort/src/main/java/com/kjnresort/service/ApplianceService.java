package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.ApplianceVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.RecruitVO;

public interface ApplianceService {
	public int getTotalCount(Criteria cri);							// 페이징
	public List<ApplianceVO> getList(Criteria cri);					// 게시글 목록(관리자)
	public List<ApplianceVO> getList(String id);					// 게시글 목록(사용자)
	
	public ApplianceVO get(Long applianceNo);						// 지원서 조회
	public void register(ApplianceVO appliance);					// 지원서 제출
	public void save(ApplianceVO appliance);						// 지원서 임시저장
	public boolean modify(ApplianceVO appliance);					// 임시저장한 지원서를 임시저장
	public boolean modifyRegister(ApplianceVO appliance);			// 임시저장한 지원서를 제출
	public MemberVO memberGet(MemberVO member);						// 회원 정보
	public RecruitVO recruitGet(RecruitVO recruit);					// 지원서 정보
	public ApplianceVO applianceGet(ApplianceVO appliance);			// 지원 내역 정보

}
