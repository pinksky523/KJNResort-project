package com.kjnresort.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class QnaPageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private QnaCriteria qnaCri;

	public QnaPageDTO(QnaCriteria qnaCri, int total) {
		this.qnaCri = qnaCri;
		this.total = total;

		//�� ������ ��� - �� ȭ�鿡 ������ ��ȣ 10���� ����Ѵٰ� ����
		endPage = (int)(Math.ceil(qnaCri.getPageNum() / 10.0)) * 10;
		
		startPage = this.endPage - 9;	//���� ������ ���
		
		//���� �� ������ ���
		int realEnd = (int)(Math.ceil( (total * 1.0) / qnaCri.getAmount()));
		
		if(realEnd <= endPage) {	//�� �������� ���� ���������� ū ���
			endPage = realEnd;
		}
		
		prev = startPage > 1;		//���� ������ ����
		next = endPage < realEnd;	//���� ������ ����
	}
}















