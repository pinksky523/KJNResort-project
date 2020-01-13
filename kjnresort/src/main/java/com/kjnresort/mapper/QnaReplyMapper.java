package com.kjnresort.mapper;

import com.kjnresort.domain.QnaReplyVO;

public interface QnaReplyMapper {
	public boolean delete(Long qrNo);
	public void insert(QnaReplyVO qrVO);
	public String read(long qNo);
}
