<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-group input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            cursor: pointer;
        }
        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }
        
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
        <h2>회원가입</h2>
        <form method="post" action="/user/register">
            <div class="form-group">
                <label for="username">아이디:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="email">이메일:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <input type="submit" value="회원가입" />
            </div>
        </form>

            <!-- 모달창 추가 -->
		<c:if test="${not empty registerfalse }">            
            <div id="errorModal" class="modal" ><!-- style="display: block;" -->
                <div class="modal-content" ><!-- style="display: block;" -->
                
                    <h3>회원가입 실패</h3>
                    <p>중복된 아이디 입니다.</p>
                    <button class="modal-button moss" onclick="displayNone(this)">확인</button>

                </div>
		        <script>
		            function displayNone(element){
		                element.parentElement.parentElement.style.display = 'none';
		            }
		
		            window.addEventListener('pageshow', function(event) {
		                if (event.persisted || window.performance.navigation.type === 2) {
		                    // 페이지 캐시에서 로드되었을 때 모달을 숨깁니다.
		                    document.getElementById('errorModal').style.display = 'none';
		                }
		            });
		        </script>
            </div>
		</c:if>

    </div>
</body>
</html>