package org.zerock.service;

import java.util.List;

import org.zerock.domain.CommentVO;

public interface CommentService {
	// 코멘트 조회
	public List<CommentVO> select(Long post_id);
	// 코멘트 추가
	public boolean insert(CommentVO vo);
	// 코멘트 삭제
	public boolean delete(Long comment_id,Long user_id);
}
