package org.zerock.service;

import java.util.List;

import org.zerock.domain.PostVO;

public interface PostService {
	
	// 전체 게시글 조회
	public List<PostVO> selectAll();
	// 게시글 한개 조회
	public PostVO select(Long post_id);
	// 게시글 작성
	public void insert(PostVO vo);
	// 게시글 수정
	public boolean update(PostVO vo);
	// 게시글 삭제
	public boolean delete(Long post_id);
	// 검색으로 특정 게시글 조회
	public List<PostVO> selectSearch(String str);
	// 게시글로 유저id조회
	public Long getId(Long post_id);

}
