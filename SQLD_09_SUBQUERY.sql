--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/FGmid
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

/*
 * WHERE, HAVING 등 조건절에 사용하는 서브쿼리
 * 단일컬럼 - 단일행 서브쿼리, 다중행 서브쿼리
 * 다중컬럼 - 다중컬럼 서브쿼리
 * 
 * ORDER BY 사용할 수 없음
 */


-- 단일행 서브쿼리(Single Row Subquery)
-- 한 행에 정확히 하나의 열을 반환하는 서브쿼리

SELECT ename, job, sal 
FROM emp
WHERE sal <= (SELECT avg(sal) FROM emp)
ORDER BY 3 DESC;


-- 다중행 서브쿼리(Multi Row Subquery)
-- 실행 결과가 여러 건인 서브쿼리
-- 반드시 다중 행 비교 연산자인 IN, ALL, ANY=SOME, EXISTS 와 함께 사용해야 한다.

-- 팀에 CLERK가 있는 모든 부서의 사원 정보
SELECT ename, job, deptno
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE job='CLERK')

SELECT deptno FROM emp WHERE job='CLERK'


-- ALL과 ANY 사용 예시
SELECT ename, job, sal
FROM emp
WHERE sal > ALL (SELECT sal FROM emp WHERE job='SALESMAN')
ORDER BY 3 DESC;

SELECT ename, job, sal
FROM emp
WHERE sal > (SELECT max(sal) FROM emp WHERE job='SALESMAN')
ORDER BY 3 DESC;

SELECT ename, job, sal
FROM emp
WHERE sal > ANY (SELECT sal FROM emp WHERE job='SALESMAN')
ORDER BY 3 DESC;

SELECT ename, job, sal
FROM emp
WHERE sal > (SELECT min(sal) FROM emp WHERE job='SALESMAN')
ORDER BY 3 DESC;



-- 다중 컬럼 서브쿼리(Multi Column Subquery)
-- 실행 결과가 2개 이상 컬럼을 갖고 있는 서브쿼리

-- 소속 부서별 가장 급여가 적은 직원 정보
SELECT *
FROM emp
WHERE (deptno, sal) IN (SELECT deptno, min(sal) 
						FROM emp 
						GROUP BY deptno)

-- 1개 행만 갖는 경우
-- 존스씨와 부서와 직책이 같은 직원 정보
SELECT *
FROM emp
WHERE (deptno, job) = (SELECT deptno, job 
					   FROM emp 
					   WHERE ename='JONES')

					   
					   
-- 스칼라 서브쿼리(Scalar Subquery)
-- 행마다 정확히 하나의 행을  서브쿼리
-- column_expr 사용하는 대부분 위치에 사용 가능

SELECT ename, job, sal,
	(SELECT round(avg(sal),2) FROM emp) AS avg_sal
FROM emp
ORDER BY sal DESC;

-- 각 직원의 소속 부서 평균 연봉 정보를 함께 출력
SELECT a.ename, a.sal,
	(SELECT round(avg(x.sal), 2)
	 FROM emp x
	 WHERE x.deptno = a.deptno) AS davg_sal
FROM emp a;


-- 연관(Correlated) 서브쿼리.
-- 서브쿼리가 메인 쿼리의 컬럼을 갖고 있는 형태

-- 연관 서브쿼리, 단일행 서브쿼리
-- 서브 쿼리 종류가 정확히 구분되는 것은 아니다.
SELECT a.player_name, a.height
FROM player a
WHERE a.height > (SELECT round(avg(x.height),2)
	 			  FROM player x
	 			  WHERE x.team_id = a.team_id);

	 			 
-- EXISTS 문은 보통 연관 서브쿼리와 함께 쓰인다
-- 하나라도 데이터가 있으면 TRUE를 반환하고 종료
-- 어떤 값을 반환하든 상관 없기 때문에 책에서는 보통 1을 반환하고 있다.
	 			 	 			 
SELECT a.stadium_id, a.stadium_name
FROM stadium a
WHERE EXISTS (SELECT 1
			  FROM schedule x
			  WHERE x.stadium_id = a.stadium_id AND
				x.sche_date BETWEEN '20120501' AND '20120530');	

			
-- 인라인 뷰, ORDER BY 사용 가능

 SELECT b.dname, a.ename
 FROM (
 	SELECT deptno, ename
 	FROM emp
 	WHERE job='SALESMAN') a, dept b
 WHERE a.deptno=b.deptno

WITH T AS (
	SELECT deptno, ename
 	FROM emp
 	WHERE job='SALESMAN'
)
 SELECT b.dname, T.ename
 FROM T, dept b
 WHERE T.deptno=b.deptno
			
/* 
 * 뷰 장점
 * 
 * 독립성 - 테이블 구조가 변경돼도 뷰를 사용하는 응용 프로그램은 변경할 필요 없음
 * 편리성 - 복잡한 질의를 단순하게 작성할 수 있다. 재사용성도 높아짐.
 * 보안성 - 생년월일 처럼 숨겨야 하는 개인정보가 있으면 뷰를 생성할 때 해당 칼럼만 빼고 생성
 * 
 */
 
 -- 생성
CREATE VIEW v_emp_dept AS
SELECT a.ename, a.job, b.dname, b.loc
FROM emp a, dept b
WHERE a.deptno = b.deptno

SELECT * FROM v_emp_dept;

-- 삭제
DROP VIEW v_emp_dept;
