package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.CommentVO;

public interface CommentMapper {
	
	// 해당 글에 있는 코멘트 조회
	public List<CommentVO> select(Long post_id);
	// 해당 글에 코멘트 추가
	public boolean insert(CommentVO vo);
	// 해당 글에 있는 코멘트 삭제
	public boolean delete(@Param("comment_id") Long comment_id,@Param("user_id") Long user_id);
	
}
