package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.UserVO;
import org.zerock.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class UserServiceImpl implements UserService{
	
	@Setter(onMethod_ = {@Autowired})
	private UserMapper mapper;
	
	@Override
	// 회원가입
	public boolean register(UserVO vo) {
		log.info("register => "+vo);
		return mapper.register(vo) == true;
	}
	@Override
	public List<UserVO> selectAll(){
		log.info("====================전체목록==================");
		return mapper.selectAll();
	}
	@Override
	public UserVO loginUser(String username,String password) {
		return mapper.loginUser(username, password);
	}
}
