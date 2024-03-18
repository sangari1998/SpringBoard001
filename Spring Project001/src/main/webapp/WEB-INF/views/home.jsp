<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/BoardList.js"></script>

<html>
<head>
<script>
$.ajax({
    url: '/api/list', // 요청을 보낼 URL
    type: 'GET', // HTTP 요청 메서드 (GET, POST 등)
    dataType: 'json', // 응답 데이터 타입 (json, xml, html 등)
    success: function(data) { // 성공적으로 요청이 완료된 경우 실행될 콜백 함수
        location.href=('./post/BoardList.jsp')
    },
    error: function(xhr, status, error) { // 요청 실패 시 실행될 콜백 함수
        console.error('Error:', error); // 에러 로그 출력
    }
});
</script>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
