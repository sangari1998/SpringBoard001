<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:choose>
	    <c:when test="${editMode}">
			<title>게시글 수정하기</title>
		</c:when>
		<c:when test="${writeMode}"> <!-- writeMode 분기 추가 -->
			<title>게시글 작성하기</title>
		</c:when>
		<c:otherwise>
			<title>게시글 상세보기</title>
		</c:otherwise>
</c:choose>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- CKEditor  -->
<script src="https://cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
<style>

.container {
    max-width: 960px;
    padding: 15px;
    padding-top: 50px;
}

/* 추천 버튼 애니메이션 */
.like-btn {
    width: 50px;
    transition: transform 0.2s;
}

.like-btn img {
    width: 100%;
}

.like-btn:active {
    transform: scale(1.2);
}

.post-info {
    display: flex;
    justify-content: space-between;
    border-bottom: 1px solid #ccc;
    padding-bottom: 10px;
    margin-bottom: 20px;
    border-top: rgb(46, 67, 97) solid 2px;
    background-color: rgb(241, 247, 255);
    padding: 5px;
    border-radius: 5px;
}

.star_icon {
    width: 20px;
    margin-right: 5px;
    margin-bottom: 3px;
}

.comment-icon {
    width: 24px;
    height: 24px;
    margin-right: 5px;
    margin-bottom: 2px;
}

.speech_span {
    font-weight: 700;
}

.context_container {
    min-height: 300px;
}

.button-container {
    display: flex;
    justify-content: center;
    position: relative;
    margin-top: 20px;
    top: -15px;
}

.like-btn-container {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
}

.button-group {
    position: absolute;
    right: 0;
}

.button-group .btn {
    margin-left: 5px;
}
.speeach_tap{
	margin-top: 50px;
	margin-bottom: 10px;
}
.flex_wrap_between{
	display: flex;
	justify-content: space-between;
	
}

.star_icon {
    width: 20px;
    margin-right: 5px;
}

.button_wrap {
    text-align: right;
    position: relative;
}

.button_wrap .btn {
    margin-left: 5px;
}
.user_info_wrap {
    background-color: #e8e8e8;
    border-bottom: 1px solid #ccc;
    padding: 5px;
    border-radius: 5px;
}
.user_info_wrap td{
	background-color: #e8e8e8;
	border-bottom-width: 0;
	padding: 0;
	
}
.container .table tbody tr, .container .table tbody tr td{
	border-bottom-width: 0;
}
.container .table tfoot tr, .container .table tfoot tr td{
	border-bottom-width: 0;
}
.dot_img{
	width: 14px;
	height: 14px;
}
.dropdown-menu {
    border: none;
    display: block;
    position: absolute;
    min-width: 120px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    animation: fadeIn 0.3s;
    border-radius: 0;
    padding: 5px;
    right: 0;
    bottom: 5px;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.dropdown-menu a {
    color: black;
    text-decoration: none;
}

.dropdown-menu a:hover {
    text-decoration: none;
}

.dropdown-menu .ed.icon i {
    color: black;
}

.trash_icon{
	margin-left: 1px;
	margin-right: 3px;
}
#newCommentContent {
    border: 1px solid #ccc;
    padding: 5px;
    border-radius: 5px;
}

#newCommentContent:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}
.user_own_comment, .user_own_comment td{
	background-color: #deeeff;
}
#likeCount{
	font-weight: 700;
	font-size: 18px;
	margin-right: 5px;
}
/* modal */
.modal {
       display: block;
       position: fixed;
       z-index: 1;
       left: 0;
       top: 0;
       width: 100%;
       height: 100%;
       overflow: auto;
       background-color: rgba(0, 0, 0, 0.4);
   }
#modal {
		display: none;
	}
   .modal-content {
       background-color: #fefefe;
       margin: 15% auto;
       padding: 20px;
       border: 1px solid #888;
       width: 300px;
       text-align: center;
   }

   .close {
       color: #aaa;
       float: right;
       font-size: 28px;
       font-weight: bold;
       cursor: pointer;
   }

   .close:hover,
   .close:focus {
       color: black;
       text-decoration: none;
       cursor: pointer;
   }
      .modal-button {
          background-color: #4CAF50;
          color: #fff;
          padding: 10px 20px;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-size: 16px;
          margin-top: 10px;
      }

      .modal-button:hover {
          background-color: #45a049;
      }
</style>
</head>
<body>
<div class="container">
	<c:choose>
		<c:when test="${writeMode }">
			<h2>게시글 작성하기</h2>
		</c:when>
		<c:when test="${editMode }">
			<h2>게시글 수정하기</h2>
		</c:when>
	</c:choose>
	<c:choose>
	    <c:when test="${editMode or writeMode}"> <!-- editMode와 writeMode 모두 동일한 폼을 사용 -->
	        <form id="postForm" method="post" action="/post/${editMode ? 'update' : 'write'}"> <!-- action 속성 분기 처리 -->
	            <c:if test="${editMode}">
	                <input type="hidden" name="post_id" value="${param.post_id}">
	            </c:if>
	            <div class="mb-3">
	                <input type="text" class="form-control" id="title" name="title" value="${post.title}" required>
	            </div>
	            <div class="mb-3">
	                <textarea class="form-control" id="editor" name="content" rows="10" required>${post.content}</textarea>
	            </div>
	            <script>
	                CKEDITOR.replace('editor');
	            </script>
	        </form>
	    </c:when>
	    <c:otherwise>
	        <h3>${post.title}</h3>
	        <div class="post-info">
	            <span><img src="/resources/images/star_icon.png" alt="유저_아이콘" class="star_icon"/>${post.username}</span>
	            <span><fmt:formatDate value="${post.created_at}" pattern="yyyy-MM-dd HH:mm" /></span>
	        </div>
	        <div class="context_container">
	            <p>${post.content}</p>
	        </div>
	    </c:otherwise>
	</c:choose>
    <div class="button-container">
        <c:if test="${not (editMode or writeMode)}"> <!-- 상세보기 모드에서만 좋아요 버튼 표시 -->
            <div class="like-btn-container">
                <span id="likeCount">${post.likes}</span>
                <button type="button" class="btn btn-primary like-btn">
                    <img src="/resources/images/like_button.png" alt="추천 아이콘" />
                </button>
            </div>
        </c:if>
		<div class="button-group">
			<c:if test="${not (editMode or writeMode) }"></c:if>
		    <button type="button" class="btn btn-primary btn-sm" onclick="window.location.href='/post/list'">목록</button>
		    <c:choose>
		        <c:when test="${editMode or writeMode}">
		            <button type="submit" form="postForm" class="btn btn-secondary btn-sm">${editMode ? '수정' : '등록'}</button>
		        </c:when>
				<c:otherwise>
				    <button type="button" class="btn btn-secondary btn-sm" onclick="toggleEditMode(${post.post_id})">수정</button>
				    <button type="button" class="btn btn-danger btn-sm" onclick="deletePost(${post.post_id})">삭제</button>
				</c:otherwise>
		    </c:choose>
		</div>
    </div>
    <c:if test="${not (editMode or writeMode)}"> <!-- 상세보기 모드에서만 댓글 표시 -->
               <div class="speeach_tap">
            <img src="/resources/images/speech_icon.png" alt="댓글 아이콘" class="comment-icon">
            <span class="speech_span">댓글</span>
        </div>
        <table class="table" style="width: 100%;">
            <tbody>
                <c:if test="${not empty comments}">
                    <c:forEach var="comment" items="${comments}">
                    	<tr class="user_info_wrap flex_wrap_between">
                        <%-- <tr class="user_info_wrap flex_wrap_between ${sessionScope.username eq comment.username ? 'user_own_comment' : ''}"> --%>
                            <td>
                                <div>
                                	<c:choose>
                                		<c:when test="${not empty comment.user_id }">
                                			<img src="/resources/images/star_icon.png" alt="유저_아이콘" class="star_icon"/>${comment.username}
                                		</c:when>
                                		<c:when test="${empty comment.user_id }">
                                			<img src="/resources/images/star_icon.png" alt="유저_아이콘" class="star_icon"/>탈퇴한 사용자
                                		</c:when>
                                	</c:choose>
                                </div>
                            </td>
                            <td>
                                <fmt:formatDate value="${comment.created_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="comment_content">${comment.content}</td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="button_wrap">
                                    <c:if test="${not empty username}">
	                                        <form action="/post/Detail/Comment/delete" method="get">
	                                        	<input type="hidden" name="comment_id" value="${comment.comment_id }">
	                                        	<input type="hidden" name="post_id" value="${param.post_id }">
	                                            <i class="fas fa-trash"><button class="btn btn-primary btn-sm" type="sumbit">삭제</button></i>
	                                        </form>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
            <tfoot>
                <c:if test="${not empty username}">
                <form action="/post/Detail" method="post">
                    <tr>
                        <td colspan="2">
                            <textarea name="content" id="newCommentContent" rows="3" style="width: 100%; resize: none;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: right;">
                
                        	<input type="hidden" name="post_id" value="${param.post_id }">
                            <input type="submit" class="btn btn-primary btn-sm" id="addCommentBtn" value="등록">
                        </td>

                    </tr>
                </form>
                </c:if>
                
            </tfoot>
        </table>
    </c:if>
    <!-- 수정: 모달창 코드 수정 -->
	<c:if test="${getModal }">    
    <div id="errorModal" class="modal">
        <div class="modal-content">
            <h3 id="modalTitle">${modalTitle}</h3>
            <p id="modalMessage">${modalMessage }</p>
            <button class="modal-button" onclick="closeModal(this)">확인</button>
        </div>
    </div>
    </c:if>
    <div id="modal" class="modal">
        <div class="modal-content">
            <p id="modalMessage">정말 삭제하시겠습니까?</p>
            <button class="modal-button" onclick="deleteModal()">네</button>
            <button class="modal-button" onclick="closeModal(this)">아니오</button>
        </div>
    </div>
</div>
<script>

    // 수정모드로
    function toggleEditMode(postId) {
        location.href = '/post/detail?post_id=' + postId + '&editMode=true';
    }
	function deletePost(postId) {
		location.href = '/post/delete?post_id=' + postId;
	}
    // 취소모드로
    function cancelEdit() {
        window.location.href = '/post/detail?post_id=' + postId;
    }

    // 모든 모달창 닫기 함수
	function closeModal() {
	    var modals = document.querySelectorAll('.modal'); // 모든 .modal 요소를 선택
	    modals.forEach(function(modal) {
	        modal.style.display = 'none';
	    });
	}
    window.addEventListener('pageshow', function(event) {
        if (event.persisted || (window.performance && window.performance.navigation.type == 2)) {
            closeModal();
        }
    });

</script>
</body>
</html>