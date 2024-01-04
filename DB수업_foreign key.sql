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