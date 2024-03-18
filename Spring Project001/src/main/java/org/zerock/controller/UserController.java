package org.zerock.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.UserVO;
import org.zerock.service.UserService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class UserController {
	@Setter(onMethod_ = {@Autowired})
	private UserService userservice;
	
	// 로그인창 들어가기
	@GetMapping("/login")
	public String login() {
		return "/user/login";
	}
	
	// 로그인 시도
	@PostMapping("/login")
	public String loginCtrl(HttpSession session
			,@RequestParam("username") String username
			,@RequestParam("password") String password
			,RedirectAttributes rttr
			,Model model) {
		UserVO user = userservice.loginUser(username, password);
		if(user == null) { // 로그인 실패시
			rttr.addFlashAttribute("modalTitle","로그인 실패");
			rttr.addFlashAttribute("modalMessage","아이디 또는 비밀번호가 일치하지 않습니다.");
			rttr.addFlashAttribute("getModal",true);
			System.out.println("로그인 실패");
			return "redirect:/user/login";
		}// 로그인 성공시
		session.setAttribute("username", user.getUsername());
		session.setAttribute("user_id", user.getUser_id());
		System.out.println("로그인 성공");
		return "redirect:/post/list";
	}
	// 로그아웃
	@GetMapping("/logout")
	public String logoutCtrl(HttpSession session) {
		session.setMaxInactiveInterval(0);
		session.invalidate();
		System.out.println("세션 끊기");
		return "redirect:/post/list";
	}
	// 회원가입창 들어가기
	@GetMapping("/register")
	public String register() {
		return "/user/register";
	}
	// 회원가입 시도
	@PostMapping("/register")
	public String registerCtrl(
			@RequestParam("username") String username,
			@RequestParam("password") String password,
			@RequestParam("email") String email,
			RedirectAttributes rttr) {
		UserVO user = new UserVO();
		user.setUsername(username);
		user.setPassword(password);
		user.setEmail(email);
		try { // 성공시
			userservice.register(user);
			rttr.addFlashAttribute("getModal",true);
			rttr.addFlashAttribute("modalTitle","회원가입 성공!!");
			rttr.addFlashAttribute("modalMessage","로그인 해주세요.");
			return "redirect:/user/login";			
		} catch (Exception e) { // 실패시
			rttr.addFlashAttribute("registerfalse",true);
			return "redirect:/user/register";
		}
	}
}
