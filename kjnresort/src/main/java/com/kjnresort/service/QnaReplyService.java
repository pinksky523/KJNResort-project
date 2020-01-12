package com.kjnresort.service;

import com.kjnresort.domain.QnaReplyVO;

public interface QnaReplyService {
	public void register(QnaReplyVO qrVO);
	public QnaReplyVO get(Long qno);
	public boolean remove(Long qno);
}
