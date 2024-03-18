package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.PostVO;

public interface PostMapper {

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
	// 조회수 증가
	public void readcount(Long post_id);
	// 게시자 아이디 탐색
	public Long getId(Long post_id);
	
	// 페이징
	public List<PostVO> getPage(Criteria cri);
	// 전체 데이터 개수 처리
	public int getPageCount(Criteria cri);
}
