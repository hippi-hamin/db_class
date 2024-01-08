drop table if exists member_table;
create table member_table(
	id 				bigint auto_increment primary key,
    member_email 	varchar(30) not null unique,
    member_name 	varchar(20) not null,
    member_password varchar(20) not null
);

drop table if exists category_table;
create table category_table(
	id 				bigint auto_increment primary key,
    category_name	varchar(20) not null unique
);

drop table if exists board_table;
create table board_table(
	id 					bigint auto_increment primary key,
	board_title			varchar(50) not null,
    board_writer		varchar(30) not null,
    board_contents		varchar(500),
    board_hits			int default 0,
    board_created_at	datetime default now(),
    board_updated_at	datetime on update now(),
    board_file_attached	int default 0, -- 파일 첨부 여부(없으면 0, 있으면 1)
    member_id 			bigint,
    category_id			bigint,
    constraint fk_board foreign key(member_id) references member_table(id) on delete cascade,
    constraint fk_board_category foreign key(category_id) 
						references category_table(id) on delete set null
);

drop table if exists board_file_table;
create table board_file_table(
	id 					bigint auto_increment primary key,
	orginal_file_name	varchar(100), -- 사용자가 업로드한 파일의 이름
    stored_file_name	varchar(100), -- 관리용 파일 이름(파일이름 생성 로직은 backend에서)
    -- 증명사진.jpg  91845798217498237-증명사진.jpg
    board_id			bigint,
    constraint fk_board_file foreign key(board_id) references board_table(id) on delete cascade
);

drop table if exists comment_table;
create table comment_table(
	id 					bigint auto_increment primary key,
    comment_writer		varchar(30) not null,
    comment_contents	varchar(200) not null,
    comment_created_at  datetime default now(),
    board_id			bigint,
    member_id			bigint,
    constraint fk_comment_board foreign key(board_id) references board_table(id) on delete cascade,
    constraint fk_comment_member foreign key(member_id) references member_table(id) on delete cascade
);

drop table if exists good_table;
create table good_table(
	id 					bigint auto_increment primary key,
	comment_id			bigint,
    member_id			bigint,
    constraint fk_good_comment foreign key(comment_id) references comment_table(id) on delete cascade,
    constraint fk_good_member foreign key(member_id) references member_table(id) on delete cascade
);

-- 회원 기능
-- 1. 회원가입(임의의 회원3명 가입)
insert into member_table(member_email, member_name, member_password)
	values('aaa@member.com', 'aaa', '1234');
insert into member_table(member_email, member_name, member_password)
	values('bbb@member.com', 'ccc', '1111');    
insert into member_table(member_email, member_name, member_password)
	values('ccc@member.com', 'ccc', '1234');
-- 2. 이메일 중복체크 
select member_email from member_table where member_email='ddd@member.com';
-- 3. 로그인
select * from member_table where member_email='aaa@member.com' and member_password='1234';
-- 4. 전체 회원 목록 조회 
select * from member_table;
-- 5. 특정 회원만 조회 
select * from member_table where member_email='aaa@member.com';
select * from member_table where id=1;
-- 6. 내정보 수정하기(6.1, 6.2에 해당하는 쿼리문작성)
-- 6.1 회원정보 수정화면 요청(회원정보 수정 페이지를 보여준다고 가정했을 때 필요한 쿼리) 
select * from member_table where id=1;
-- 6.2 회원정보 수정 처리(비밀번호를 변경한다는 상황)
update member_table set member_password='0000' where id=1;
-- 7. 회원 삭제 또는 탈퇴 
delete from member_table where id=3;

-- 게시글 카테고리 
-- 게시판 카테고리는 자유게시판, 공지사항, 가입인사 세가지가 있음.
-- 카테고리 세가지 미리 저장
insert into category_table(category_name) values('자유게시판');
insert into category_table(category_name) values('공지사항');
insert into category_table(category_name) values('가입인사');
select * from category_table order by id asc;
desc category_table;

-- 게시판 기능 
-- 1. 게시글 작성(파일첨부 x) 3개 이상 
-- 1번 회원이 자유게시판 글 2개, 공지사항 글 1개 작성 
insert into board_table(board_title, board_writer, board_contents, member_id, category_id)
	values('안녕하세요', 'aaa@member.com', '오늘은 월요일이라 힘이나네요', 1, 1);
insert into board_table(board_title, board_writer, board_contents, member_id, category_id)
	values('눈이 왔어요', 'aaa@member.com', '빙판길 조심', 1, 1);    
insert into board_table(board_title, board_writer, board_contents, member_id, category_id)
	values('전체공지입니다.', 'aaa@member.com', '공지입니다.', 1, 2);
-- 2번 회원이 자유게시판 글 3개 작성
insert into board_table(board_title, board_writer, board_contents, member_id, category_id)
	values('오늘점심은', 'bbb@member.com', '서브웨이', 2, 1);
insert into board_table(board_title, board_writer, board_contents, member_id, category_id)
	values('자바 재밌다', 'bbb@member.com', '진짜요', 2, 1);    
insert into board_table(board_title, board_writer, board_contents, member_id, category_id)
	values('디비 재밌다', 'bbb@member.com', '??', 2, 1);
-- 3번 회원이 가입인사 글 1개 작성 
insert into board_table(board_title, board_writer, board_contents, member_id, category_id)
	values('오늘 가입했습니다', 'ccc@member.com', '반갑습니다', 3, 3);
-- 1.1. 게시글 작성(파일첨부 o)
-- 2번 회원이 파일있는 자유게시판 글 2개 작성
delete from board_table where id=11;
insert into board_table(board_title, board_writer, board_contents, board_file_attached, member_id, category_id)
	values('설산 풍경 감상하세요', 'bbb@member.com', '멋져요', 1, 2, 1);
-- 첨부된 파일정보를 board_file_table에 저장 
-- 사용자가 첨부한 파일 이름: 한라산.jpg
insert into board_file_table(original_file_name, stored_file_name, board_id)
	values('한라산.jpg', '2234989874898_한라산.jpg', 12); -- 여기서 12는 게시글의 번호(id)
insert into board_table(board_title, board_writer, board_contents, board_file_attached, member_id, category_id)
	values('오늘 다녀온 맛집', 'bbb@member.com', '겁나 맛있어요', 1, 2, 1);    
insert into board_file_table(original_file_name, stored_file_name, board_id)
	values('음식.jpg', '2234989873242_음식.jpg', 13);    
-- 2. 게시글 목록 조회 
-- 2.1 전체글 목록 조회
select * from board_table;
select id, board_title, board_writer, board_hits, board_created_at from board_table;
-- 2.2 자유게시판 목록 조회 
select * from board_table where category_id=1;
-- 2.3 공지사항 목록 조회 
select * from board_table where category_id=2;
-- 2.4 목록 조회시 카테고리 이름도 함께 나오게 조회(join)
select * from board_table b, category_table c where b.category_id=c.id;
-- 3. 2번 게시글 조회 (조회수 처리 필요함)
update board_table set board_hits=board_hits+1 where id=2;
select * from board_table where id=2;
-- 3.1. 파일 첨부된 게시글 조회 (게시글 내용과 파일을 함께)
update board_table set board_hits=board_hits+1 where id=12;
-- 게시글 내용만 가져옴
select * from board_table where id=12;
-- 해당 게시글에 첨부된 파일 정보 가져옴 
select * from board_file_table where board_id=12;
-- join 
select * from board_table b, board_file_table bf where b.id=bf.board_id and b.id=12;
-- 4. 1번 회원이 자유게시판에 첫번째로 작성한 게시글의 제목, 내용 수정
select * from board_table where id=1;
update board_table set board_title='안녕하십니까_수정', board_contents='월요일 사라져라' where id=1;
-- 5. 2번 회원이 자유게시판에 첫번째로 작성한 게시글 삭제 
delete from board_table where id=5;
-- 7. 페이징 처리(한 페이지당 글 3개씩)
-- 7.1. 첫번째 페이지
-- 7.2. 두번째 페이지
-- 7.3. 세번째 페이지 
-- 8. 검색(글제목 기준)
-- 8.1 검색결과를 오래된 순으로 조회 
-- 8.2 검색결과를 조회수 내림차순으로 조회 
-- 8.3 검색결과 페이징 처리 