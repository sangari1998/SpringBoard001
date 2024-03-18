package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.UserVO;


public interface UserMapper {
	// 회원가입
	public boolean register(UserVO vo);
	// 회원조회
	public List<UserVO> selectAll();
	// 로그인 처리
	public UserVO loginUser(@Param("username") String username,@Param("password") String password);
}
