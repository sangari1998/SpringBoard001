package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.UserVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserServiceTest {
	@Setter(onMethod_ = @Autowired)
	public UserService service;
	
	@Test
	public void test() {
		log.info(service);
		assertNotNull(service);
	}
	@Test
	public void register() {
		UserVO vo = new UserVO();
		vo.setUsername("joo753951211");
		vo.setPassword("753951");
		vo.setEmail("joo888889@naver.com");
		service.register(vo);
		log.info("회원가입 완료");
	}
	@Test
	public void selectAll(){
		service.selectAll().forEach(vo -> log.info(vo));
	}
	@Test
	public void getUser() {
		log.info(service.loginUser("joo888889", "111111"));
	}
}
