-- foreign key
drop table if exists parent1;
create table parent1(
	id bigint primary key,
	p1 varchar(10),
    p2 varchar(20)
);

drop table if exists child1;
create table child1(
	id bigint primary key,
    c1 varchar(10),
    c2 varchar(20),
    p_id bigint, -- 참조할 컬럼
    -- 외래키 지정(p_id 컬럼을 parent1 테이블의 id 컬럼을 참조하도록 함)
    constraint fk_child1 foreign key(p_id) references parent1(id)
);

insert into parent1(id, p1, p2) values(1, 'aa', 'aa');
insert into parent1(id, p1, p2) values(2, 'bb', 'bb');
insert into parent1(id, p1, p2) values(3, 'cc', 'cc');
insert into parent1(id, p1, p2) values(4, 'cc', 'cc');
select * from parent1;

insert into child1(id, c1, c2, p_id) values(1, 'aaa', 'aaa', 1); -- O
-- 부모 id 컬럼에 없는 값을 p_id에 저장
insert into child1(id, c1, c2, p_id) values(2, 'bbb', 'bbb', 2); -- O
insert into child1(id, c1, c2, p_id) values(3, 'ccc', 'ccc', 3); -- O


-- 부모테이블의 데이터 삭제
-- id=2인 데이터 한 줄을 삭제
-- 자식테이블에 id = 2인 데이터를 참조하는 부분이 있기 때문에 삭제 불가
delete from parent1 where id = 2;
-- 자식테이블에 id = 4인 데이터를 참조하는 부분이 없기 때문에 삭제 가능
delete from parent1 where id = 4;
-- 자식테이블의 부모 id = 2를 참조하는 데이터 삭제
delete from child1 where id = 2;
-- 부모객체가 없어진 자식객체를 오펀(고아) 객체라 표현

drop table if exists parent2;
create table parent2(
	id bigint primary key,
	p1 varchar(10),
    p2 varchar(20)
);

drop table if exists child2;
create table child2(
	id bigint primary key,
    c1 varchar(10),
    c2 varchar(20),
    p_id bigint, -- 참조할 컬럼
    -- 외래키 지정(p_id 컬럼을 parent1 테이블의 id 컬럼을 참조하도록 함)
    -- 부모데이터 삭제 시 자식 데이터도 같이 삭제
    constraint fk_child2 foreign key(p_id) references parent2(id) on delete cascade
);

insert into parent2(id, p1, p2) values(1,'aa', 'aa');
insert into parent2(id, p1, p2) values(2,'bb', 'bb');
insert into parent2(id, p1, p2) values(3,'cc', 'cc');
insert into parent2(id, p1, p2) values(4,'dd', 'dd');
select * from parent2;

insert into child2(id, c1, c2, p_id) values(1, 'aaa', 'aaa', 1);
insert into child2(id, c1, c2, p_id) values(2, 'bbb', 'bbb', 2);
insert into child2(id, c1, c2, p_id) values(3, 'ccc', 'ccc', 3);
insert into child2(id, c1, c2, p_id) values(4, 'ddd', 'ddd', 5);
select * from child2;

delete from parent2 where id = 3;

drop table if exists parent3;
create table parent3(
	id bigint primary key,
	p1 varchar(10),
    p2 varchar(20)
);

drop table if exists child3;
create table child3(
	id bigint primary key,
    c1 varchar(10),
    c2 varchar(20),
    p_id bigint, -- 참조할 컬럼
    -- 외래키 지정(p_id 컬럼을 parent1 테이블의 id 컬럼을 참조하도록 함)
    -- 부모데이터 삭제 시 자식테이터의 참조하는 컬럼은 null로 세팅
    constraint fk_child3 foreign key(p_id) references parent3(id) on delete set null
);

insert into parent3(id, p1, p2) values(1,'aa', 'aa');
insert into parent3(id, p1, p2) values(2,'bb', 'bb');
insert into parent3(id, p1, p2) values(3,'cc', 'cc');
insert into parent3(id, p1, p2) values(4,'dd', 'dd');
select * from parent3;
delete from parent3 where id = 1;

insert into child3(id, c1, c2, p_id) values(1, 'aaa', 'aaa', 1);
insert into child3(id, c1, c2, p_id) values(2, 'bbb', 'bbb', 2);
insert into child3(id, c1, c2, p_id) values(3, 'ccc', 'ccc', 3);
insert into child3(id, c1, c2, p_id) values(4, 'ddd', 'ddd', 5);
select * from child3;

-- 수정쿼리
update child3 set c1 = '수정내용' where id = 2;
-- 여러 개를 수정할 경우 and가 아닌 , 사용
update child3 set c1 = '수정내용', c2 = 'ㅎㅎㅎ' where id = 3;

-- 연습 문제
-- book table
drop table if exists book;
create table book(
	id bigint auto_increment,
    b_bookname varchar(20),
    b_publisher varchar(20),
    b_price int,
    constraint pk_book primary key(id)
);

insert into book(b_bookname, b_publisher, b_price) values('축구 역사', '좋은출판사', 7000);
insert into book(b_bookname, b_publisher, b_price) values('축구 리포트', '나푸출판사', 13000);
insert into book(b_bookname, b_publisher, b_price) values('축구를 알려주마', '대한출판사', 22000);
insert into book(b_bookname, b_publisher, b_price) values('배구의 바이블', '대한출판사', 35000);
insert into book(b_bookname, b_publisher, b_price) values('피겨 교과서', '좋은출판사', 8000);
insert into book(b_bookname, b_publisher, b_price) values('피칭의 단계별기술', '좋은출판사', 6000);
insert into book(b_bookname, b_publisher, b_price) values('야구의 추억 이야기', '나이스미디어', 20000);
insert into book(b_bookname, b_publisher, b_price) values('야구 읽어주는 남자', '나이스미디어', 13000);
insert into book(b_bookname, b_publisher, b_price) values('올림픽스토리', '이야기당', 7500);
insert into book(b_bookname, b_publisher, b_price) values('olympic history', 'strawberry', 13000);
select * from book;

-- customer table
drop table if exists customer;
create table customer(
	id bigint auto_increment,
    c_name varchar(20),
    c_address varchar(20),
    c_phone varchar(15),
    constraint pk_customer primary key(id)
);
insert into customer(c_name, c_address, c_phone) values('손흥민', '영국 런던', '000-5000-0001');
insert into customer(c_name, c_address, c_phone) values('김연아', '대한민국 서울', '000-6000-0001');
insert into customer(c_name, c_address, c_phone) values('김연경', '대한민국 서울', '000-7000-0001');
insert into customer(c_name, c_address, c_phone) values('류현진', '캐나다 토론토', '000-7000-0001');
insert into customer(c_name, c_address, c_phone) values('이강인', '프랑스 파리', '000-8000-0001');
select * from customer;

-- orders table
drop table if exists orders;
create table orders(
	id bigint auto_increment,
    customer_id bigint,
    book_id bigint,
    o_saleprice int,
    o_orderdate date,
    constraint pk_orders primary key(id),
    constraint fk_orders_c foreign key(customer_id) references customer(id),
	constraint fk_orders_b foreign key(book_id) references book(id)
);
insert into orders(customer_id, book_id, o_saleprice, o_orderdate) values(1, 1, 6000, str_to_date('2023-07-01','%Y-%m-%d'));
insert into orders(customer_id, book_id, o_saleprice, o_orderdate) values(1, 3, 21000, str_to_date('2023-07-03','%Y-%m-%d'));
insert into orders(customer_id, book_id, o_saleprice, o_orderdate) values(2, 5, 8000, str_to_date('2023-07-03','%Y-%m-%d'));
insert into orders(customer_id, book_id, o_saleprice, o_orderdate) values(3, 6, 6000, str_to_date('2023-07-04','%Y-%m-%d'));
insert into orders(customer_id, book_id, o_saleprice, o_orderdate) values(4, 7, 20000, str_to_date('2023-07-05','%Y-%m-%d'));
insert into orders(customer_id, book_id, o_saleprice, o_orderdate) values(1, 2, 12000, str_to_date('2023-07-07','%Y-%m-%d'));
insert into orders(customer_id, book_id, o_saleprice, o_orderdate) values(4, 8, 13000, str_to_date('2023-07-07','%Y-%m-%d'));
insert into orders(customer_id, book_id, o_saleprice, o_orderdate) values(3, 10, 12000, str_to_date('2023-07-08','%Y-%m-%d'));
insert into orders(customer_id, book_id, o_saleprice, o_orderdate) values(2, 10, 7000, str_to_date('2023-07-09','%Y-%m-%d'));
insert into orders(customer_id, book_id, o_saleprice, o_orderdate) values(3, 8, 13000, str_to_date('2023-07-10','%Y-%m-%d'));
select * from orders;

-- 조회 연습
-- 1. 모든 도서의 가격과 도서명 조회
select b_price, b_bookname from book;
-- 2. 모든 출판사 이름 조회 
select b_publisher from book;
-- 2.1 중복값을 제외한 출판사 이름 조회
select distinct b_publisher from book;
-- 3. BOOK테이블의 모든 내용 조회 
select * from book;
-- 4. 20000원 미만의 도서만 조회 
select * from book where b_price < 20000;
-- 5. 10000원 이상 20000원 이하인 도서만 조회
select * from book where b_price <= 20000 and b_price >= 10000;
select * from book where b_price between 10000 and 20000; -- (between/and = 이상 이하의 개념이라 초과 미만일 땐 참고)
-- 6. 출판사가 좋은출판사 또는 대한출판사인 도서 조회 
select * from book where b_publisher = '좋은출판사' or b_publisher = '대한출판사';
select * from book where b_publisher in('좋은출판사', '대한출판사');
-- 7. 도서명에 축구가 포함된 모든 도서를 조회
select * from book where b_bookname like '%축구%';
-- 8. 도서명의 두번째 글자가 구인 도서 조회
select * from book where b_bookname like '_구%';
-- 9. 축구 관련 도서 중 가격이 20000원 이상인 도서 조회
select * from book where b_bookname like '%축구%' and b_price > 20000;
-- 10. 책 이름순으로 전체 도서 조회
select * from book order by b_bookname asc;
select * from book order by b_bookname desc;
-- 11. 도서를 가격이 낮은 것 부터 조회하고 같은 가격일 경우 도서명을 가나다 순으로 조회
select * from book order by b_price asc, b_bookname asc;