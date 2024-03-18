package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.PostVO;
import org.zerock.mapper.PostMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class PostServiceImpl implements PostService{
	@Setter(onMethod_ = {@Autowired})
	private PostMapper mapper;
	
	@Override
	public List<PostVO> selectAll(){
		return mapper.selectAll();
	}
	@Override
	public PostVO select(Long post_id) {
		mapper.readcount(post_id);
		return mapper.select(post_id);
	}
	@Override
	public void insert(PostVO vo) {
		mapper.insert(vo);
	}
	@Override
	public boolean update(PostVO vo) {
		return mapper.update(vo);
	}
	@Override
	public boolean delete(Long post_id) {
		return mapper.delete(post_id);
	}
	@Override
	public List<PostVO> selectSearch(String str){
		return mapper.selectSearch(str);
	}
	@Override
	public Long getId(Long post_id) {
		return mapper.getId(post_id);
	}
	
}
