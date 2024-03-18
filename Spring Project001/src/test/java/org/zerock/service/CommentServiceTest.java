package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.CommentVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CommentServiceTest {
	@Setter(onMethod_ = @Autowired)
	private CommentService service;
	
	// 주입 테스트
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	// 커멘트 가져오기
	public void select() {
		service.select(22L).forEach(vo -> log.info(vo));
	}
	
	// 커멘트 추가하기
	@Test
	public void insert() {
		CommentVO vo = new CommentVO();
		vo.setPost_id(22L);
		vo.setUser_id(5L);
		vo.setContent("추가한 컨텐트");
		service.insert(vo);
		log.info("추가 완료");
	}
	
	// 커멘트 삭제하기
	@Test
	public void delete() {
	
	}
}
