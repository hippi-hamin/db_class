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
