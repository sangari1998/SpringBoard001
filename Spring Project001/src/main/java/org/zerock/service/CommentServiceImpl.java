package org.zerock.service;

import java.util.List;import javax.xml.stream.events.Comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.CommentVO;
import org.zerock.mapper.CommentMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class CommentServiceImpl implements CommentService {
	@Setter(onMethod_ = {@Autowired})
	private CommentMapper mapper;
	
	// 커멘트 가져오기
	@Override
	public List<CommentVO> select(Long post_id){
		return mapper.select(post_id);
	}
	// 커멘트 추가
	@Override
	public boolean insert(CommentVO vo) {
		System.out.println("커멘트 추가 시도");
		return mapper.insert(vo);
		
	}
	// 커멘트 삭제
	@Override
	public boolean delete(Long comment_id,Long user_id) {
		return mapper.delete(comment_id,user_id);
	}
}
