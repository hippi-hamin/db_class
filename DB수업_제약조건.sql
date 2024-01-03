-- 제약조건
-- id, member_email, member_password 컬럼이 있는 테이블
drop table if exists member2; -- mysql에선 if exist를 같이 써줌으로써 에러를 줄일 수 있음
create table member1 (
	id bigint,
    member_email varchar(20),
    member_password varchar(20)
);
insert into member1(id, member_email, member_password) values(1, 'aa@aa.com', '1234');
-- 모든 컬럼에 값을 다 넣을 때는 컬럼이름 생략 가능
insert into member1 values(2, 'bb@bb,com', '1234');
-- 특정 컬럼만 값을 넣을 때
insert into member1 values(3, 'ccOcc.com'); -- 전체 컬럼의 값을 다 넣어줄 때 컬럼이름 생략 가능
insert into member1(id, member_email) values (3, 'cc@cc.com'); -- 특정 컬럼의 값을 넣어 줄 떄 값이 없는 컬럼은 null로 표기.
select * from member1;
insert into member1 values(4, 'dd@dd.com', null);

drop table if exists member2;
create table member2 (
	id bigint not null,
    member_email varchar(20),
    member_password varchar(20)
);
insert into member2(id, member_email, member_password) values(1, 'aa@aa.com', '1234');
-- id를 제외하고 나머지 값만 입력
insert into member2(member_email, member_password) values('bb@bb.com', '1234');
insert into member2(id, member_email, member_password) values(null, 'bb@bb.com', '1234');
insert into member2(id, member_email, member_password) values(4, null, '1234');

drop table if exists member3;
create table member3 (
	id bigint not null unique,
    member_email varchar(20) not null,
    member_password varchar(20) not null,
    created_at datetime
);

insert into member3(id, member_email, member_password) values(1, 'aa@aa.com', '1234');
insert into member3(id, member_email, member_password) values(2, 'bb@bb.com', '1234');
insert into member3(id, member_email, member_password) values(2, 'bb@bb.com', null);

--
drop table if exists member4;
create table member4 (
	id bigint not null unique,
    member_email varchar(20) not null unique,
    member_password varchar(20) not null,
    created_at datetime
);
insert into member4(id, member_email, member_password, created_at)
	values(1, 'aa@aa.com', '1234', now());

-- default 시간 자동 저장
drop table if exists member5;    
create table member5 (
	id bigint not null unique,
    member_email varchar(20) not null unique,
    member_password varchar(20) not null,
    created_at datetime default now()
);
 -- default 로 지정한 컬럼은 따로 값을 주지 않아도 값이 default로 지정한 값으로 저장됨
select * from member5;
insert into member5(id, member_email, member_password, created_at)
	values(1, 'aa@aa.com', '1234', now());
-- default로 지정한 컬럼은 따로 값을 주지 않아도 값이 default로 지정한 값으로 저장됨.
insert into member5(id, member_email, member_password)
		values(2, 'bb@bb.com', '1234');
        
-- primary key
drop table if exists member6;
create table member6 (
	id bigint primary key,
    member_email varchar(20) not null unique,
    member_password varchar(20) not null,
    created_at datetime default now()
);
select * from member6;
insert into member6(id, member_email, member_password) values(1, 'aa@aa.com', '1234');
insert into member6(id, member_email, member_password) values(2, 'bb@bb.com', '1234');

drop table if exists member7;
create table member7 (
	id bigint,
    member_email varchar(20) not null unique,
    member_password varchar(20) not null,
    created_at datetime default now(),
    constraint pk_member7 primary key(id)
);

-- 자동 번호 적용하기 (auto_increment는 pk 컬럼에만 지정 가능)
drop table if exists member8;
create table member8 (
	id bigint auto_increment,
    member_email varchar(20) not null unique,
    member_password varchar(20) not null,
    created_at datetime default now(),
    -- id2 bigint auto_increment, -- 일반 컬럼에는 지정 불가
    constraint pk_member8 primary key(id)
);
select * from member8;
-- auto_increment를 지정하면 값을 따로 주지 않아도 됨
insert into member8(member_email, member_password) values('aa@aa.com', '1234');
insert into member8(member_email, member_password) values('bb@bb.com', '1234');