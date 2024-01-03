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