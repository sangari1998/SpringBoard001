
$(document).ready(function(){
	$.ajax({
	    url: '/api/list', // 요청을 보낼 URL
	    type: 'GET', // HTTP 요청 메서드 (GET, POST 등)
	    dataType: 'json', // 응답 데이터 타입 (json, xml, html 등)
	    success: function(posts) { // 성공적으로 요청이 완료된 경우 실행될 콜백 함수
	        $.each(posts, function(index, post) {
	            var row = '<tr>' +
	                '<td width="100">' + post.post_id + '</td>' +
	                '<td width="300" class="title_col"><a href="">' + post.title + '</a></td>' +
	                '<td width="150">' + post.username + '</td>' +
	                '<td width="150">' + formatDate(post.created_at) + '</td>' +
	                '<td width="100">' + post.readcount + '</td>' +
	                '<td width="100">' + post.likes + '</td>' +
	                '</tr>';
	            $('#postTable tbody').append(row);
	            console.log(posts)
	        });
	    },
	    error: function(xhr, status, error) { // 요청 실패 시 실행될 콜백 함수
	        console.error('Error:', error); // 에러 로그 출력
	    }
	});
    
		
});

    // 날짜 형식을 변환하는 함수
    function formatDate(dateString) {
        var date = new Date(dateString);
        var currentDate = new Date();
        var formattedDate = '';
        if (date.toDateString() === currentDate.toDateString()) {
            formattedDate = date.toLocaleTimeString();
        } else {
            formattedDate = date.toLocaleDateString();
        }
        return formattedDate;
    }
    

	
	