package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.PostVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PostServiceTest {
	@Setter(onMethod_ = @Autowired)
	private PostService service;
	
	@Test
	public void test() {
		log.info(service);
		assertNotNull(service);
	}
	@Test
	public void selectAll() {
		service.selectAll().forEach(vo -> log.info(vo));
	}
	@Test
	public void select() {
		log.info(service.select(22L));
	}
	@Test
	public void insert() {
		PostVO vo = new PostVO();
		vo.setUser_id(1L);
		vo.setTitle("테스트제목");
		vo.setContent("테스트 내용");
		service.insert(vo);
		log.info(vo);
	}
	@Test
	public void update() {
		PostVO vo = new PostVO();
		vo.setTitle("바뀐 제목");
		vo.setContent("바뀐 내용");
		vo.setPost_id(22L);
		service.update(vo);
		log.info("바뀐 게시물 : "+vo);
	}
	@Test
	public void delete() {
		service.delete(7L);
		log.info("삭제완료");
	}
	@Test
	public void selectSearch() {
		service.selectSearch("테스트").forEach(vo -> log.info(vo));
	}
	@Test
	public void selectId() {
		log.info(service.getId(1L));
	}
}
