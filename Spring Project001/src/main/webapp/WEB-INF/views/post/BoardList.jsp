<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>

<html>
<head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/BoardList.js"></script>

	<meta charset="UTF-8">
	<title>전체 게시판 목록</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<style>
	   table, th, td {
	        border: none !important; /* 모든 테이블 셀의 외곽선 제거 */
	    }
		td,th {
			text-align: center;

			border-bottom: 1px solid #ccc !important; 
		
		}
		#board_wrap{
			margin: 0 auto;
			max-width: 900px;
		}
		
		#board_wrap .table .top_row th {
		    color: #fff !important;
		   	background-color: #0072f9 !important;
		}
		.button {
			width: 90%;
			margin: auto 0;
			
		}
		.flex{
			display: flex;

		}
		.flex-flow-column{
			flex-flow: column wrap;
			margin: 10px;
		}

		.login_wrap{
			width: 200px;
			border: 1px solid #ccc;
			border-radius: 5px;
			margin: 5px;
			margin-left: auto; /* 왼쪽 마진을 auto로 설정하여 오른쪽으로 밀어냄 */
			margin-bottom: 40px;
		}
		h1{
			font-size: 30px;
			font-weight: 700;
			text-align: center;
			margin-top: 5vh;
		}
		.pagenav{
			display: flex;
			justify-content: center;
			margin-top: 50px;
			
		}
		.search_wrap{
			justify-content: space-between;
		}
		.title_col{
			text-align: left;

		}
		.user_name_em{
			font-size: 24px;	
			font-weight: 700;	
			text-align: center;
		}
		
		/* modal */
		.modal {
	        display: none;
	        position: fixed;
	        z-index: 1;
	        left: 0;
	        top: 0;
	        width: 100%;
	        height: 100%;
	        overflow: auto;
	        background-color: rgba(0, 0, 0, 0.4);
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
        .paginate_button {
        	width: 30px;
        	height: 30px;
        }
	</style>
	<!-- 추가적인 사용자 정의 스타일 -->
    <!-- <script src="/resources/js/jquery-1.12.4.min.js"></script>
    <script src="/resources/js/jquery-3.3.1.min.js"></script> -->
</head>
<body>

	<div id="board_wrap">
		<header>
			<h1>전체 게시판</h1>
		</header>
		
		<div class="login_wrap">
		    <c:choose>
		        <c:when test="${not empty username}">
		            <div class="flex flex-flow-column">
		                <span class="user_name_em">${username}</span>
		            </div>
		            <div class="flex flex-flow-column">
		                <button type="button" onclick="location.href='/user/logout'" class="btn btn-secondary">로그아웃</button>
		            </div>
		        </c:when>
		        <c:otherwise>
		            <div class="flex flex-flow-column">
		                <button type="button" class="btn btn-primary" onclick="location.href='/user/login'">로그인</button>
		            </div>
		            <div class="flex flex-flow-column">
		                <button type="button" onclick="location.href='/user/register'" style="text-decoration: none;" class="btn btn-secondary">회원가입</button>
		            </div>
		        </c:otherwise>
		    </c:choose>
		</div>

		<section>
			<table id="postTable" class="table table-bordered">
				<thead>
				<tr class="top_row">
					<th width="100">번호</th>
					<th width="300">제목</th>
					<th width="150">작성자</th>
					<th width="150">작성일</th>
					<th width="100">조회수</th>
					<th width="100">추천</th>
				</tr>
				</thead>
<!-- 포워딩 받은 데이터 처리 -->
		<c:forEach var="posts" items="${posts }">
				<tr>
					<td width="100">${posts.post_id }</td>
					<td width="300"><a href="/post/Detail?post_id=${posts.post_id }">${posts.title }</a></td>
					<c:choose>
						<c:when test="${not empty posts.username }">
							<td width="150">${posts.username}</td>
						</c:when>
						<c:when test="${empty posts.username }">
							<td width="150">탈퇴한 사용자</td>
						</c:when>
					</c:choose>
					<td width="150">
					<fmt:formatDate value="${posts.created_at }" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td width="100">${posts.readcount }</td>
					<td width="100">${posts.likes }</td>
				</tr>
		</c:forEach>				
			</table>
			
		<!-- 검색버튼 -->
		
		<div class="flex search_wrap">
	        <form action="/post/search" method="get" class="flex form-control-sm">
	            <select class="form-select form-select-sm w-50" aria-label="Default select example" name="searchType">
	                <option value="all">전체</option>
	                <option value="title">제목</option>
	                <option value="author">작성자</option>
	            </select>
	            <input class="form-control" value="" name="searchValue">
	            <button class="btn btn-secondary btn-sm " style="white-space:nowrap;" type="submit">검색</button>
	        </form>
	        <div class="writeBoard">
	            <button class="btn btn-secondary btn-sm" type="button" onclick="location.href='/post/write'">글쓰기</button>
	        </div>
	    </div>
	    	<nav aria-label="Page navigation" class="pagenav">
 				<div class="pull-right">
					<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							
							<li class="paginate_button previous">
								<a href="${pageMaker.startPage -1}">Previous</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage }">
<!-- 							<li class="paginate_button"> -->
							<li class='paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }'>
								<a href="/post/list?Criteria=${num }">${num }</a> 
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next">
								<a href="${pageMaker.endPage +1}">Next</a>
							</li>					
						</c:if>
					</ul>
					<!--#b. 페이징 작업 = 실제 클릭하면 동작하는 부분 처리 -->
					<form id='actionForm' action="/post/list" method="get">
						<input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum }' />
						<input type="hidden" name="amount" value='${pageMaker.cri.amount }' />
					</form>		
				</div>
				</nav>
		</section>
		
        <c:if test="${not empty getModal}">
            <!-- 모달창 추가 -->
            <div id="errorModal" class="modal">
                <div class="modal-content">
                    <h3>${modalTitle}</h3>
                    <p>${modalMessage}</p>
                    <button class="modal-button" onclick="closeModal()">확인</button>
                </div>
            </div>

            <script type="text/javascript">
                // 모달창 표시 함수
                function showModal() {
                    document.getElementById("errorModal").style.display = "block";
                }

                // 모달창 닫기 함수
                function closeModal() {
                    document.getElementById("errorModal").style.display = "none";
                }

                // 로그인 실패 시 모달창 표시
                <c:if test="${not empty modalMessage}">
                    showModal();
                </c:if>
            </script>
        </c:if>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
		var actionForm = $("#actionForm");
		$(".paginate_button a").on("click", function(e){
		    e.preventDefault();
		    var pageNum = this.getAttribute("href").match(/Criteria=(\d+)/)[1];
		    $("#actionForm input[name='pageNum']").val(pageNum);
		    $("#actionForm").submit();
		});
	})

</script>
</body>
</html>