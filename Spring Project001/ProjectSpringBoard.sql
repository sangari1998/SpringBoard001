--User Table (사용자 테이블)
--
--user_id: 사용자의 고유 식별자 (기본키)
--username: 사용자 이름
--password: 사용자 비밀번호
--email: 사용자 이메일
--기타 사용자 관련 정보(성, 이름, 가입 날짜 등)
--Board Table (게시판 테이블)
--
--post_id: 게시글의 고유 식별자 (기본키)
--user_id: 게시글을 작성한 사용자의 ID (외래키)
--title: 게시글 제목
--content: 게시글 내용
--created_at: 게시글 작성 시간
--updated_at: 게시글 수정 시간
--Comment Table (댓글 테이블)
--
--comment_id: 댓글의 고유 식별자 (기본키)
--post_id: 댓글이 달린 게시글의 ID (외래키)
--user_id: 댓글을 작성한 사용자의 ID (외래키)
--content: 댓글 내용
--created_at: 댓글 작성 시간
--updated_at: 댓글 수정 시간

-- 유저 SQL문 
-- 유저 테이블 create
CREATE TABLE Users (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(50) NOT NULL unique,
    password VARCHAR2(50) NOT NULL,
    email VARCHAR2(100),
    created_at DATE DEFAULT SYSDATE
);

--유저 시퀀스
CREATE SEQUENCE users_seq START WITH 1 INCREMENT BY 1;
--삭제
drop SEQUENCE users_seq;
drop table users;

-- INSERT
INSERT INTO Users (user_id, username, password, email, created_at)
VALUES (users_seq.NEXTVAL, 'joo888880', '111111', 'joo888889@naver.com', SYSDATE);


-- UPDATE
UPDATE Users
SET username = 'new_username', email = 'new_email@example.com'
WHERE user_id = 1;

UPDATE Users
SET password = 'new_username', email = 'new_email@example.com'
WHERE user_id = 1;

-- DELETE
DELETE FROM Users
WHERE user_id = 1;

-- SELECT
select * from users;

SELECT user_id FROM Users WHERE username = 'zig2';

commit;

-- 게시글 SQL문
-- 게시글 테이블 create
CREATE TABLE Posts (
    post_id NUMBER PRIMARY KEY,
    user_id NUMBER,
    username VARCHAR2(30),
    title VARCHAR2(100) NOT NULL,
    content VARCHAR2(4000) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE,
    readcount NUMBER DEFAULT 0,
    likes NUMBER DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE SET NULL,
    FOREIGN KEY (username) REFERENCES USERS(username) ON DELETE SET NULL
);

select * from posts;
-- 게시글 시퀀스
CREATE SEQUENCE posts_seq START WITH 1 INCREMENT BY 1;
drop SEQUENCE posts_seq;
-- 테이블 삭제
drop table Posts;

commit;
-- INSERT
insert into posts(post_id,user_id,username,title,content,created_at,updated_at,readcount,likes)
values (posts_seq.nextval,1,'joo888880','홍길동 제목','홍길동내용',sysdate,null,0,0);

insert into posts(post_id,user_id,title,content,created_at,updated_at,readcount,likes)
values (#{post_id},#{user_id},#{username},#{title},#{content},#{sysdate},null,0,0);



-- UPDATE
UPDATE Posts
SET title = 'Updated title', content = 'Updated content', updated_at = SYSDATE
WHERE post_id = 1;

-- DELETE
DELETE FROM Posts
WHERE post_id = 3;

--SELECT 
SELECT * from posts;
select * from posts where title like '%김%';
--게시글 10개 보기 
SELECT * FROM (
    SELECT p.post_id, p.user_id, p.title, p.content, p.created_at, p.updated_at, p.readcount, p.likes ,u.username,
           ROW_NUMBER() OVER (ORDER BY p.post_id DESC) AS Rnum
    FROM Posts p
    JOIN Users u ON p.user_id = u.user_id
) WHERE Rnum BETWEEN 1 AND 10;


--검색글 10개 가져오기
SELECT *
FROM (
    SELECT p.post_id, p.user_id, p.title, p.content, p.created_at, p.updated_at, p.readcount, p.likes, u.username,
           ROW_NUMBER() OVER (ORDER BY p.post_id DESC) AS Rnum
    FROM Posts p
    JOIN Users u ON p.user_id = u.user_id
    WHERE 1 = 1
        AND (
            (:searchType = 'all' AND (p.title LIKE '%' || :searchValue || '%' OR u.username LIKE '%' || :searchValue || '%'))
            OR (:searchType = 'title' AND p.title LIKE '%' || :searchValue || '%')
            OR (:searchType = 'author' AND u.username LIKE '%' || :searchValue || '%')
        )
)
WHERE Rnum BETWEEN 1 AND 10;


-- 추천수 증가
UPDATE Posts
SET likes = likes + 1
WHERE post_id = 41;

-- 추천수 조회
select likes from posts where post_id=41;

--검색
SELECT
    p.post_id,
    p.user_id,
    p.title,
    p.content,
    p.created_at,
    p.updated_at,
    p.readcount,
    p.likes,
    u.username
FROM
    posts p
    JOIN users u ON p.user_id = u.user_id
WHERE
    p.title LIKE '%' || 'asd' || '%'
    OR p.content LIKE '%' || 'Content' || '%';


-- 댓글 SQL문
-- 댓글 테이블 create
CREATE TABLE Comments (
    comment_id NUMBER PRIMARY KEY,
    post_id NUMBER,
    user_id NUMBER,
    username VARCHAR2(50),
    content VARCHAR2(4000) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    --댓글 같은 경우는 글이 지워질 때 댓글도 같이 지워지도록 ON DELETE CASCADE 설정
    CONSTRAINT fk_comments_post_id FOREIGN KEY (post_id)
        REFERENCES Posts(post_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_comments_user_id FOREIGN KEY (user_id)
        REFERENCES Users(user_id)
        ON DELETE SET NULL,
    CONSTRAINT fk_comments_username FOREIGN KEY (username)
        REFERENCES Users(username)
        ON DELETE SET NULL
);

-- 댓글 시퀀스
CREATE SEQUENCE comments_seq START WITH 1 INCREMENT BY 1;
drop sequence comments_seq;
-- 테이블 삭제
drop table comments;

-- INSERT
INSERT INTO Comments (comment_id, post_id, user_id,username, content, created_at)
VALUES (comments_seq.NEXTVAL, 1, '1','joo888889', 'Content of the comment', SYSDATE);
select * from comments;
-- UPDATE
UPDATE Comments
SET content = 'Updated content of the comment'
WHERE comment_id = 1;
delete from users where user_id = 5;

select * from users;
-- DELETE
DELETE FROM Comments
WHERE comment_id = 1;

-- SELECT
SELECT * FROM USERS;
select * from comments;
SELECT * FROM POSTS;
DELETE FROM POSTS WHERE POST_ID = 22;

-- 특정게시물의 댓글 조회
SELECT c.comment_id, c.post_id, c.user_id, c.content, c.created_at,
       u.username
FROM Comments c
JOIN Users u ON c.user_id = u.user_id
WHERE c.post_id = 41
ORDER BY c.created_at ASC;

--제약사항보기
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'POSTS';

select * from comments;
select * from users;
select * from posts;
delete from users where user_id = 1;


commit;
