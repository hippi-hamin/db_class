use db_dbclass;

create table table1(
	col1 int,
    col2 varchar(5)
);
-- 테이블 조회 (모든컬럼 = * )
select * from table1;

-- 테이블에 데이터 저장
insert into table1(col1, col2) values(1, '안녕');
insert into table1(col1, col2) values(2, '화요일');

-- 정의한 컬럼에 맞지 않는 데이터가 들어오면 에러 ▼ / col1은 int로 지정해 놓았는데 문자가 들어가니 에러.
insert into table1(col1, col2) values('aa', '화요일');
-- 정의한 컬럼에 맞지 않는 데이터가 들어와 에러 / col2의 size는 5라고 지정해놨는데 '회요일입니다' 와 abcde. 은 6글자여서 size가 맞지 않음.
-- 항상 문자는 '   ' 세미클론안에 있는 모든 문자들이 size로 체크됨.
insert into table1(col1, col2) values(4, '화요일입니다.');
insert into table1(col1, col2) values(5, 'abcde.');

/*
 관리번호(id) bigint , 
 학번(studentNumber), 
 이름(studentName), 
 전화번호(studentMobile), 
 학과(studentMajor) 정보를 저장하는 student_table 생성 
*/

-- 테이블 생성 과정
create table student_table(
	id bigint,
    studentNumber varchar(8),
    studentName varchar(20),
    studentMobile varchar(20),
    studentMajor varchar(20)
);
-- 테이블 삭제 과정
drop table student_table;

-- 테이블에 정보 넣는 과정
insert into student_table(id, studentNumber, studentName, studentMobile, studentMajor)
	values(1, '20241111', '학생1', '010-1111-1111', '컴퓨터공학');

-- 테이블 보는 과정
select * from student_table;

drop table dept;
create table dept (
    deptno int,
    dname varchar(14),
    loc varchar(13)
);
drop table emp;
create table emp (
    empno int,
    ename varchar(10),
    job varchar(9),
    mgr int,
    hiredate date,
    sal int,
    comm int,
    deptno int
);
drop table bonus;
create table bonus (
    ename varchar(10),
    job varchar(9),
    sal int,
    comm int
);

drop table salgrade;
create table salgrade (
    grade int,
    losal int,
    hisal int
);
    
insert into dept values	(10,'ACCOUNTING','NEW YORK');
insert into dept values (20,'RESEARCH','DALLAS');
insert into dept values (30,'SALES','CHICAGO');
insert into dept values	(40,'OPERATIONS','BOSTON');    

insert into emp values (7369,'SMITH','CLERK',7902, str_to_date('17-12-1980','%d-%m-%Y'),800,NULL,20);
insert into emp values (7499,'ALLEN','SALESMAN',7698,str_to_date('20-2-1981','%d-%m-%Y'),1600,300,30);
insert into emp values (7521,'WARD','SALESMAN',7698,str_to_date('22-2-1981','%d-%m-%Y'),1250,500,30);
insert into emp values (7566,'JONES','MANAGER',7839,str_to_date('2-4-1981','%d-%m-%Y'),2975,NULL,20);
insert into emp values (7654,'MARTIN','SALESMAN',7698,str_to_date('28-9-1981','%d-%m-%Y'),1250,1400,30);
insert into emp values (7698,'BLAKE','MANAGER',7839,str_to_date('1-5-1981','%d-%m-%Y'),2850,NULL,30);
insert into emp values (7782,'CLARK','MANAGER',7839,str_to_date('9-6-1981','%d-%m-%Y'),2450,NULL,10);
insert into emp values (7788,'SCOTT','ANALYST',7566,str_to_date('13-7-87','%d-%m-%Y'),3000,NULL,20);
insert into emp values (7839,'KING','PRESIDENT',NULL,str_to_date('17-11-1981','%d-%m-%Y'),5000,NULL,10);
insert into emp values (7844,'TURNER','SALESMAN',7698,str_to_date('8-9-1981','%d-%m-%Y'),1500,0,30);
insert into emp values (7876,'ADAMS','CLERK',7788,str_to_date('13-7-87','%d-%m-%Y'),1100,NULL,20);
insert into emp values (7900,'JAMES','CLERK',7698,str_to_date('3-12-1981','%d-%m-%Y'),950,NULL,30);
insert into emp values (7902,'FORD','ANALYST',7566,str_to_date('3-12-1981','%d-%m-%Y'),3000,NULL,20);
insert into emp values (7934,'MILLER','CLERK',7782,str_to_date('23-1-1982','%d-%m-%Y'),1300,NULL,10);
		 
insert into salgrade values (1,700,1200);
insert into salgrade values (2,1201,1400);
insert into salgrade values (3,1401,2000);
insert into salgrade values (4,2001,3000);
insert into salgrade values (5,3001,9999);

select * from emp; 
select * from bonus; -- 조회결과 없음
select * from salgrade;
select * from dept;

-- emp 테이블 전체 컬럼 조회
select * from emp;
-- emp 테이블의 empno, ename 컬럼만 조회
select empno, ename from emp;
-- select SMITH from emp; -- X
-- emp 테이블의 job 컬럼만 조회
select job from emp;
-- 중복값은 한 번만 조회
select distinct job from emp;
-- 사원 이름 조회(asc = 오름차순)
select * from emp order by ename asc;
-- 사원 이름 조회(desc = 내림차순)
select * from emp order by ename desc;
-- 급여(sal) 기준 오름차순 정렬
select * from emp order by sal asc;
-- 급여(sal) 기준 내림차순 정렬
select * from emp order by sal desc;
-- 입사일(hiredate) 기준 오름차순 정렬
select * from emp order by hiredate asc;
-- 입사일(hiredate) 기준 내림차순 정렬
select * from emp order by hiredate desc;
-- 정렬 기준이 두가지라면 콤마(,)로 구분
-- 입사일 기준 내림차순 정렬하고 입사일이 같다면 이름 기준 오름차순 정렬
select * from emp order by hiredate desc, ename asc;

-- 조건 : 특정 데이터를 기준으로 조회하고자 할 때
-- where
-- 직급(job)이 salesman인 사원 조회
select * from emp where job = 'salesman'; -- 대소문자 안가림
-- 직급(job)이 manager인 사원 조회
select * from emp where job = 'manager'; -- 대소문자 안가림
-- 부서번호(deptno)이 10인 사원 조회
select * from emp where deptno = 10; -- 대소문자 안가림
-- 이름(ename)이 james인 사원 조회
select * from emp where ename = 'james'; -- 대소문자 안가림
-- 사번(empno)이 7654인 사원 조회
select * from emp where empno = 7654; -- 대소문자 안가림

-- 조건이 2가지 이상
-- 직급이 manager 이고 부서번호가 20인 사원
select * from emp where job = 'manager' and deptno = 20;
-- 직급이 salesman 이거나 clerk인 사원
select * from emp where job = 'salesman' or job = 'clerk';
-- 급여(sal)가 3000 이하인 사원
select * from emp where sal <= 3000;
-- 급여가 1000 이상 3000 이하인 사원
select * from emp where sal between 1000 and 3000;
-- 급여가 3000 이하인 사원
select * from emp where sal <= 3000;
-- 급여가 3000 이하인 사원 조회 결과를 sal 기준으로 오름차순 정렬
select * from emp where sal <= 3000 order by sal asc;
-- 직급이 salesman이 아닌 사원
select * from emp where job != 'saleseman';
select * from emp where not job = 'salesman';
-- 입사일자 (hiredate)가 81년 4월 1일 이후인 사원
select * from emp where hiredate > '1981-04-01';
select * from emp where hiredate > '1981-04-01'order by hiredate asc;
-- str_to_date() : 문자를 날짜형으로 변환하는 함수
select * from emp where hiredate > str_to_date('1981-04-01', '%Y-%m-%d');

-- like 연산자 (%는 like 연산자에서만 사용 가능)
select * from emp where ename like 'm%'; -- 이름이 m으로 시작하는 사원 
select * from emp where ename like '%m'; -- 이름이 m으로 끝나는 사원
select * from emp where ename like '%m%'; -- 이름에 m이 포함되어 있는 사원 (추후에 검색 기능에서 사용 가능)
select * from emp where ename like '_m%'; -- 언더바 = 글자수, 이름 두번째 자리에 m이 있는 사원
select * from emp where ename like '__m%'; -- 이름 세번째 자리에 m이 있는 사원
-- 김씨성의 이름이 3글자인 사원
select * from emp where ename like '김__';
-- 이씨성의 이름이 2글자인 사원
select * from emp where ename like '이_';
-- 이름이 3글자인 사원 중에서 이름 중간에 '가'가 있는 사원
select * from emp where ename like '_가_';
select * from emp where ename like '_날씨_';

-- 함수
-- sum(), avg(), max(), min(), count()
-- 급여 총합
select sum(sal) from emp;
select sum(sal) as '급여총합' from emp;
-- salesman 급여 총합
select sum(sal) from emp where job = 'salesman';
select sum(sal) from emp where job = 'manager';
-- 평균 급여 조회
select avg(sal) from emp;
-- 평균값을 소수 둘째자리 까지만 조회하려면
-- round() 함수
-- dual : 문장을 완성하기 위한 가상의 테이블
select round(12.3456, 2) from dual;
select round(12.3456, 1) from dual;
select round(12.3456, -1) from dual;
select sysdate() from dual;

select round(avg(sal),2) from emp;

-- 가장 많은 급여
select max(sal) from emp;
-- 가장 적은 급여
select min(sal) from emp;
-- 전체 사원 수
select count(*) from emp;
-- 부서번호가 20인 사원 수
select count(*) from emp where deptno = 20;

-- 그룹화(grouping, 특정 컬럼을 기준으로 동일한 데이터끼리 묶는 것)
-- 그룹화한 결과를 조회할 때는 그룹화한 컬럼으로 조회만 가능
-- job을 기준으로 그룹화
-- 그룹화하지 않은 컬럼은 조회 불가능

select * from emp group by job;
select sal, count(*) from emp group by sal;
-- 직급별 평균급여
select job, avg(sal) from emp group by job;
-- 직급이 clerk인 사원들의 평균급여
select job, avg(sal) from emp where job = 'clerk';
-- 부서(deptno)별 평균급여
select deptno, avg(sal) from emp group by deptno;
-- 직급별 사원수
select job, count(*) from emp group by job;
-- 직급별, 평균급여, 사원수
select job, avg(sal), count(*) from emp group by job;
-- 위의 결과에서 직급기준 오름차순 정렬
select job, avg(sal), count(*) from emp group by job order by job;
-- 위의 결과에서 평균 급여 소수 첫째자리까지 
select job, round(avg(sal), 1), count(*) from emp group by job order by job;
-- 위의 결과에서 job은 '직급' 급여 평균값은 '평균급여', 사원수는 '사원수'로 표현하여 조회
select job as '직급', round(avg(sal), 1) as '평균급여', count(*) as '사원수'
	from emp group by job order by job;
    
-- 두 개 이상 컬럼 그룹화
-- deptno를 기준으로 그룹화하고 그 결과 내에서 job 기준으로 그룹화
select deptno, job from emp group by deptno, job;
select deptno, job, count(*) from emp group by deptno, job;
select deptno, job, count(*), avg(sal) from emp group by deptno, job;

-- 그룹화한 결과에 조건을 적용
-- having (그룹화 하기 전은 where)
-- 위의 결과에서 평균 급여가 2000 이상인 결과만 조회
select deptno, job, count(*), avg(sal)
	from emp
		group by deptno, job
			having avg(sal) >= 2000 
				order by avg(sal) asc;

-- 급여가 3000 이하인 사원만 가지고 부서별, 직급별 그룹화를 하고 평균급여가 2000 이상인 결과 조회
select deptno, job, count(*), avg(sal)
	from emp
		where sal <= 3000 -- 그룹화 하기 전 where 조건문으로 한 번 걸러주기.
			group by deptno, job
				having avg(sal) >= 2000 
					order by avg(sal) asc;

-- date 타입을 문자로 표현 : date_format()
select date_format(hiredate, '%Y') from emp;
/*	
	연습문제
	1. 부서별 평균급여, 최고급여, 최저급여, 사원수 조회(평균급여는 소수점 둘째자리에서 반올림)
    2. 직급별 사원수 조회(단 3명 이상인 결과만 출력)
    3. 연도별 입사한 사원수 조회(조회결과 : 연도(yyyy), 사원수)
    3.1. 위의 결과에서 각 연도별로 부서별 입사한 사원수 조회(조회결과 : 연도(yyyy), 부서번호, 사원수)
*/
select deptno as '부서번호' , round(avg(sal), 1) as '평균급여', max(sal) as '최고급여', min(sal)'최저급여', count(*)'사원수'
	from emp 
		group by deptno;
select job as '직급', count(empno) as '사원수'
	from emp 
		group by job
			having count(empno) >= 3;
select date_format(hiredate, '%Y') as '입사년도', count(empno) as '사원수'
	from emp
		group by date_format(hiredate, '%Y');
select date_format(hiredate, '%Y') as '입사년도', deptno as '부서번호', count(empno) as '사원수'
	from emp
		group by date_format(hiredate, '%Y'), deptno
			order by date_format(hiredate, '%Y');
            
-- 조인(join)
-- 두 개 이상의 테이블을 하나의 테이블처럼 사용할 때
select * from emp; -- 적절한 방법은 아님
select * from dept;
select * from emp, dept;
-- 내부조인(inner join)
-- 조인하려는 두 테이블에 공통 컬럼이 존재해야 함.
select * from emp, dept where emp.deptno = dept.deptno;
-- 테이블 이름을 줄여서 사용
select * from emp e, dept d where e.deptno = d.deptno;
-- deptno 컬럼은 두 테이블에 모두 있기 때문에 ambiguous 에러
select empno, ename, job, deptno, dname, loc from emp e, dept d where e.deptno = d.deptno;
select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc 
	from emp e, dept d where e.deptno = d.deptno;
-- emp 테이블 전체 조회
select e.* from emp e, dept d where e.deptno = d.deptno;
-- emp, dept를 조인하여 empno, ename, deptno, dname, loc 조회
-- (단, 급여가 2500 이상인 사원만 조회하고, 조회결과는 사원이름 기준으로 오름차순 정렬)
select e.empno, e.ename, d.deptno, d.dname, d.loc
	from emp e, dept d
		where e.deptno = d.deptno and e.sal >= 2500
			order by e.ename asc;
            
-- 서브쿼리(sub query)
-- 하나의 쿼리문 안에서 다른 쿼리문을 수행하는 것
-- 최저 급여를 받는 사원의 이름
select * from emp;
-- 1. 최저급여가 얼마인지? => 800
select min(sal) from emp;
-- 2. 800 급여를 받는 사원의 이름 => smith
select ename from emp where sal = 800;
-- 위의 두 문장을 서브쿼리로
select ename from emp where sal = (select min(sal) from emp);
-- 최고 급여를 받는 사원의 정보 조회
select ename from emp where sal = (select max(sal) from emp);
-- allen 보다 높은 급여를 받는 사원 조회
select * from emp where sal > (select sal from emp where ename = 'allen');
-- 연습문제
-- 1. clark 보다 늦게 입사한 사원 조회 
-- clark 입사일자
-- select hiredate from emp where ename = 'clark'; => '1981-06-09'
-- select * from emp where hiredate > '1981-06-09'; => martin,scott,king,turner,adams,james,ford,miller 의 정보
select * from emp 
	where hiredate > (select hiredate from emp where ename = 'clark') 
		order by hiredate asc;
-- 2. 부서번호가 20인 사원 중에서 전체 사원 평균 급여보다 높은 급여를 받는 사원 조회
-- select avg(sal) from emp; => 2073
-- select * from emp where sal > 2073; => jones,blake,clark,scott,king,ford 의 정보
-- select * from emp where sal > 2073 and deptno = 20; => jones, scott, ford 의 정보
select * from emp 
	where deptno = 20 
		and sal > (select avg(sal) from emp);
-- 3. 2번 조회 결과에서 부서이름, 부서위치도 함께 조회
select e.*, d.dname, d.loc
	from emp e, dept d 
		where e. deptno = d.deptno 
			and e.deptno = 20 
				and sal > (select avg(sal) from emp);
-- 4. martin과 같은 부서 사원 중에서 전체 사원 평균 급여보다 높은 급여를 받는 사원 조회
-- select deptno from emp where ename = 'martin'; => 30
-- select * from emp where sal > (select avg(sal) from emp) and deptno = 30; => black 의 정보
select * from emp 
	where deptno = (select deptno from emp where ename = 'martin') 
		and sal > (select avg(sal) from emp);

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
    
create table member5 (
	id bigint not null unique,
    member_email varchar(20) not null unique,
    member_password varchar(20) not null,
    created_at datetime default now()
);
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