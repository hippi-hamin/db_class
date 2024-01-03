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
            