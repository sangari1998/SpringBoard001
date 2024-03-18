package org.zerock.service;

import java.util.List;

import org.zerock.domain.UserVO;

public interface UserService {
	// 회원가입
	public boolean register(UserVO vo);
	// 회원조회
	public List<UserVO> selectAll();
	// 로그인처리
	public UserVO loginUser(String username,String password);
}
