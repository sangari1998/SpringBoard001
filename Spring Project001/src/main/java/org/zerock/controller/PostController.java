package org.zerock.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.CommentVO;
import org.zerock.domain.PostVO;
import org.zerock.service.CommentService;
import org.zerock.service.PostService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@Log4j
@RequestMapping("/post/*")
@AllArgsConstructor
public class PostController {
	@Setter(onMethod_ = {@Autowired})
	private PostService postservice;
	@Setter(onMethod_ = {@Autowired})
	private CommentService commentservice;
	
	// 초기 게시판 화면
	@GetMapping("/list")
	public String getList(Model model) {
		model.addAttribute("posts", postservice.selectAll());
		return "post/BoardList";
	}
	// 글 자세히 보기
	@GetMapping("/Detail")
	public String getListOne(Long post_id,Model model) {
		model.addAttribute("post",postservice.select(post_id));
		model.addAttribute("comments",commentservice.select(post_id));
		return "post/Detail";
	}
	// 코멘트 추가
	@PostMapping("/Detail")
	public String addComment(HttpSession session,
			RedirectAttributes rttr,
			@RequestParam("content") String content,
			@RequestParam("post_id") Long post_id) {
		String username = (String)session.getAttribute("username");
		if(username == null) {
			rttr.addAttribute("getModal",true);
			rttr.addAttribute("modalTitle","로그인 시간 만료");
			rttr.addAttribute("modalMessage","다시 로그인 해주세요");
			return "redriect:/post/Detail?post_id"+post_id;
		}
		Long user_id = (Long)session.getAttribute("user_id");
		CommentVO comment = new CommentVO();
		comment.setPost_id(post_id);
		comment.setUser_id(user_id);
		comment.setUsername(username);
		comment.setContent(content);
		if(commentservice.insert(comment)) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		return "redirect:/post/Detail?post_id="+post_id;
	}
	
	
	// 글쓰기
	@GetMapping("/write")
	public String write(
			Model model,
			HttpSession session,
			RedirectAttributes rttr,
			@RequestParam(value="writeMode",defaultValue = "false" ) boolean writeMode) {
		if(session.getAttribute("username") == null) {
			rttr.addFlashAttribute("getModal",true);
			rttr.addFlashAttribute("modalTitle","로그인한 유저만 작성이 가능합니다.");
			rttr.addFlashAttribute("modalMessage","로그인 시도 부탁드립니다.");
			return "redirect:/post/list";
		}else {
			model.addAttribute("writeMode", true);
			return "post/Detail";			
		}

	}
	// 글 등록
	@PostMapping("/write")
	public String write(
			HttpSession session,
			RedirectAttributes rttr,
			@RequestParam("title") String title,
			@RequestParam("content") String content) {
		if(session.getAttribute("username") == null) {
			rttr.addFlashAttribute("getModal",true);
			rttr.addFlashAttribute("modalTitle","로그인이 만료되었습니다.");
			rttr.addFlashAttribute("modalMessage","다시 로그인 부탁드립니다.");
			return "redirect:/post/list";
		}else {
			PostVO vo = new PostVO();
			vo.setUser_id((Long)session.getAttribute("user_id"));
			vo.setUsername((String)session.getAttribute("username"));
			vo.setTitle(title);
			vo.setContent(content);
			try {
				postservice.insert(vo);
				rttr.addFlashAttribute("getModal",true);
				rttr.addFlashAttribute("modalMessage","게시글이 등록되었습니다");
				return "redirect:/post/list"; 
			} catch (Exception e) {
				rttr.addFlashAttribute("getModal",true);
				rttr.addFlashAttribute("modalTtitle","게시글 등록 실패!!");
				rttr.addFlashAttribute("modalMessage","이상 오류 발생");
				return "redirect:/post/list";
			}
		}
	}
	
	// 편집모드
	@GetMapping("/detail")
	public String update(
			HttpSession session,
			RedirectAttributes rttr,
			Model model,
			@RequestParam("post_id") Long post_id,
			@RequestParam("editMode") boolean editMode) {
		if(session.getAttribute("username") == null) { 
			// 비회원이 편집 시도시
			rttr.addFlashAttribute("getModal",true);
			rttr.addFlashAttribute("modalTitle","편집 제한");
			rttr.addFlashAttribute("modalMessage","비회원은 편집 불가능합니다.");
			System.out.println("비회원처리");
			return "redirect:/post/Detail?post_id="+post_id;
		}else {
			// 다른 회원이 편집 시도시
			Long user_id = (Long)session.getAttribute("user_id");
			Long user_id2 =postservice.getId(post_id);
			if(!user_id.equals(user_id2)) {
				rttr.addFlashAttribute("getModal",true);
				rttr.addFlashAttribute("modalTitle","편집 제한");
				rttr.addFlashAttribute("modalMessage","글 작성자만 편집이 가능합니다.");
				return "redirect:/post/Detail?post_id="+post_id;
			}else {
				model.addAttribute("editMode",true);
				return "/post/Detail";				
			}
	
		}	
	}
	//수정
	@PostMapping("/update")
	public String update(
			HttpSession session,
			RedirectAttributes rttr,
			@RequestParam("post_id") Long post_id,
			@RequestParam("title") String title,
			@RequestParam("content") String content
			) {
		if(session.getAttribute("username") == null) { // 세션이 만료되었을때
			rttr.addFlashAttribute("getModal",true);
			rttr.addFlashAttribute("modalTitle","로그인이 만료되었습니다.");
			rttr.addFlashAttribute("modalMessage","다시 로그인 부탁드립니다.");
			return "redirect:/post/list";
		}
		PostVO vo = new PostVO();
		vo.setTitle(title);
		System.out.println(title+"제목");
		vo.setContent(content);
		System.out.println(content+"내용");
		vo.setPost_id(post_id);
		System.out.println(post_id+"글번호");
		if(postservice.update(vo)) {
			rttr.addFlashAttribute("getModal",true);
			rttr.addFlashAttribute("modalTitle","글 수정 완료");
			rttr.addFlashAttribute("modalMessage","글 수정 완료");
			return "redirect:/post/list";
		}else {
			rttr.addFlashAttribute("getModal",true);
			rttr.addFlashAttribute("modalTitle","글 수정 실패");
			rttr.addFlashAttribute("modalMessage","오류 발생");
			return "redirect:/post/list";
		}
		
	}
	// 삭제
	@GetMapping("/delete")
	public String delete(
			HttpSession session,
			RedirectAttributes rttr,
			@RequestParam("post_id") Long post_id) {
		if(session.getAttribute("username") == null) { 
			// 비회원이 삭제 시도시
			rttr.addFlashAttribute("getModal",true);
			rttr.addFlashAttribute("modalTitle","삭제 제한");
			rttr.addFlashAttribute("modalMessage","비회원은 삭제 불가능합니다.");
			return "redirect:/post/Detail?post_id="+post_id;
		}else {
			// 다른 회원이 삭제 시도시
			Long user_id = (Long)session.getAttribute("user_id");
			Long user_id2 =postservice.getId(post_id);
			if(!user_id.equals(user_id2)) {
				rttr.addFlashAttribute("getModal",true);
				rttr.addFlashAttribute("modalTitle","삭제 제한");
				rttr.addFlashAttribute("modalMessage","글 작성자만 삭제가 가능합니다.");
				return "redirect:/post/Detail?post_id="+post_id;
			}else { // 본인이 삭제 시도시
				postservice.delete(post_id);
				rttr.addFlashAttribute("getModal",true);
				rttr.addFlashAttribute("modalTitle","삭제 성공!!");				
				return "redirect:/post/list";				
			}
		}
		
	}
	@GetMapping("Detail/Comment/delete")
	public String CommentDelete(
			HttpSession session,
			RedirectAttributes rttr,
			@RequestParam("comment_id") Long comment_id,
			@RequestParam("post_id") Long post_id) {
		Long user_id = (Long)session.getAttribute("user_id");
		System.out.println("여긴 이동함");
		System.out.println(comment_id+"코멘트 아이디");
		if(user_id == null) {
			rttr.addFlashAttribute("getModal",true);
			rttr.addFlashAttribute("modalTitle","삭제 불가능");
			rttr.addFlashAttribute("modalMessage", "코멘트 작성자만 삭제가능합니다.");
			return "redirect:/post/Detail?post_id="+post_id;
		}
		System.out.println("로그인 인정됨");
		if(commentservice.delete(comment_id, user_id)) {
			rttr.addFlashAttribute("getModal", true);
			rttr.addFlashAttribute("modalTitle", "삭제완료");
			return "redirect:/post/Detail?post_id="+post_id;
		}else {
			rttr.addFlashAttribute("getModal", true);
			rttr.addFlashAttribute("ModalTitle", "삭제실패");
			rttr.addFlashAttribute("modalTitle", "코멘트 작성자만 삭제 가능합니다.");
			return "redirect:/post/Detail?post_id="+post_id;
		}
		
		
	}
	
	
	
}
