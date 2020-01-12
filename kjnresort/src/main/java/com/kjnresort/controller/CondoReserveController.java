package com.kjnresort.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kjnresort.domain.Criteria;


@RequestMapping("/condoReserve")
public class CondoReserveController {
 
	//�ܵ�������
	@GetMapping("/list")
	public void reserveList(Model model,Criteria cri) {
		
	}
	
	//�ܵ��������ȸ
	@GetMapping("/get")
	public void reserveGet(long rno,Model model,Criteria cri) {
		
	}
	
	//�ܵ������̿�Ȯ��
	@PostMapping("/confirm")
	public void reserveConfirm(long rno,Model model,Criteria cri) {
		
	}
	
	//�ܵ��������
	@PostMapping("/cancel")
	public void reserveCancel(long rno,Model model,Criteria cri) {
		
	}
	
	//�ܵ������ϱ�
	@PostMapping("/add")
	public void addReserve() { //�Ű������� ���� vo,dao�� �߰����ֱ�
		
	}
	
}
