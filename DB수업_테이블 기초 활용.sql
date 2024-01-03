-- 테이블 활용 기초
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