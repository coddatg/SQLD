--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

/*
 * PIVOT 절과 UNPIVOT
 * 피봇절은 항상 집계함수와 함께 사용
 */

SELECT job, deptno, sal
FROM emp;

SELECT job, deptno, avg(sal) 
FROM emp
GROUP BY job, deptno;

--------------------------------------------------
-- PIVOT 절 없이 CASE WHEN 절을 이용해 피봇 구현
						
SELECT job,
	avg(CASE deptno WHEN 10 THEN sal END) AS D10_SAL,
	avg(CASE deptno WHEN 20 THEN sal END) AS D20_SAL,
	avg(CASE deptno WHEN 30 THEN sal END) AS D30_SAL
FROM emp
GROUP BY job
ORDER BY 1;

-------------------------------------------------
-- deptno 행들을 열로 회전

SELECT *
FROM (SELECT job, deptno, sal FROM emp) -- 인라인 뷰
PIVOT (avg(sal) FOR deptno IN (10, 20, 30));

-- 컬럼마다 Alias도 지정할 수 있음
SELECT *
FROM (SELECT job, deptno, sal FROM emp)
PIVOT (avg(sal) FOR deptno IN (10 AS D10, 20 AS D20, 30 AS D30));

-- 3개 이상 컬럼 피봇
SELECT to_char(hiredate, 'YYYY') AS YYYY, 
	job, deptno, avg(sal)
FROM emp
GROUP BY to_char(hiredate, 'YYYY'), job, deptno

SELECT *
FROM (SELECT to_char(hiredate, 'YYYY') AS YYYY, job, deptno, sal FROM emp)
PIVOT (avg(sal) FOR deptno IN (10 AS D10, 20 AS D20, 30 AS D30));

-------------------------------------------------
-- 피봇은 FROM 절의 일부. WHERE, ORDER BY 절 등을 추가해 쿼리 할 수 있다.

-- ORDER BY 절 추가
SELECT *
FROM (SELECT to_char(hiredate, 'YYYY') AS YYYY, job, deptno, sal FROM emp)
PIVOT (avg(sal) FOR deptno IN (10 AS D10, 20 AS D20, 30 AS D30))
ORDER BY 1, 2;

-- WHERE 절 추가
SELECT *
FROM (SELECT job, deptno, sal FROM emp)
PIVOT (avg(sal) FOR deptno IN (10 AS D10, 20 AS D20, 30 AS D30))
WHERE D20 > 2500
ORDER BY 1;

SELECT job, D10
FROM (SELECT job, deptno, sal FROM emp)
PIVOT (avg(sal) FOR deptno IN (10 AS D10, 20 AS D20, 30 AS D30))
WHERE D20 > 2500
ORDER BY 1;

--------------------------------------------------------

-- 집계 함수 2개 이상 사용 가능
SELECT *
FROM (SELECT job, deptno, sal FROM emp)
PIVOT (avg(sal) AS sal, count(*) AS cnt FOR deptno IN (10, 20))

-- 피봇 컬럼 두개 이상 조합 가능
SELECT *
FROM (SELECT to_char(hiredate, 'YYYY') AS YYYY, job, deptno, sal FROM emp)
PIVOT (avg(sal) AS sal
	   FOR (deptno, job) IN ((10, 'ANALYST') AS D10A, (10, 'CLERK') AS D10C,
							  (20, 'ANALYST') AS D20A, (20, 'CLERK') AS D20C))


---------------------------------------------------
-- UNPIVOT
-- PIVOT 된 것을 원래대로 되돌림

WITH T AS (
	SELECT *
	FROM (SELECT job, deptno, sal  FROM emp)
	PIVOT (sum(sal) FOR deptno IN (10 AS D10, 20 AS D20, 30 AS D30))
) -- 피봇 테이블 생성
SELECT job, deptno, sal 
FROM T
UNPIVOT (sal FOR deptno IN (D10 AS 10, D20 AS 10, D30 AS 30));
-- PIVOT과 반대로 실행

-- NULL을 포함한 UNPIVOT
WITH T AS (
	SELECT *
	FROM (SELECT job, deptno, sal  FROM emp)
	PIVOT (sum(sal) FOR deptno IN (10 AS D10, 20 AS D20, 30 AS D30))
)
SELECT job, deptno, sal 
FROM T
UNPIVOT INCLUDE NULLS (sal FOR deptno IN (D10 AS 10, D20 AS 10, D30 AS 30));

---------------------------------------------------------
-- 2개 이상 집계 함수를 이용한 경우의 UNPIVOT
WITH T AS (
	SELECT *
	FROM (SELECT job, deptno, sal FROM emp WHERE job IN ('ANALYST', 'CLERK'))
	PIVOT (avg(sal) AS sal, count(*) AS cnt FOR deptno IN (10 AS D10, 20 AS D20))
)
SELECT *
FROM T
UNPIVOT ((sal, cnt) 
	FOR deptno IN ((D10_sal, D10_cnt) AS 10, (D20_sal, D20_cnt) AS 20));

SELECT job, deptno, avg(sal), count(*) 
FROM emp 
WHERE job IN ('ANALYST', 'CLERK') AND deptno IN (10, 20)
GROUP BY job, deptno
ORDER BY 1, 2;


