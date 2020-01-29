package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.ApplianceVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.RecruitVO;

public interface ApplianceMapper {	
	public int getTotalCount(Criteria cri);
	public List<ApplianceVO> getListWithPaging(Criteria cri);		// 게시글 목록(관리자)
	public List<ApplianceVO> getList(String id);					// 게시글 목록(사용자)
	
	public ApplianceVO read(Long applianceNo);						// 게시글 조회(관리자)
	public void insert(ApplianceVO appliance);						// 게시글 등록(사용자)
	public void save(ApplianceVO appliance);						// 게시글 임시저장(사용자)
	public int update(ApplianceVO appliance);						// 임시저장한 지원서를 임시저장(사용자)
	public int updateInsert(ApplianceVO appliance);					// 임시저장한 지원서를 제출(사용자)
	public MemberVO memberRead(MemberVO member);					// 회원 정보
	public RecruitVO recruitRead(RecruitVO recruit);				// 지원서 정보
	public ApplianceVO applianceRead(ApplianceVO appliance);		// 지원 내역 정보
	
}






