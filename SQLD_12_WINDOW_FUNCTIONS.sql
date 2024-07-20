--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------


/*
 * 윈도우 함수 개요
 *
 * 윈도우 함수는 OVER 절을 필수로 포함
 * OVER 절 SYNTAX
 * [ PARTITION BY partition_expr[, ...] ]
 * [ ORDER BY expr [ { ASC| DESC } ] [, ...] ]
 * [ window_frame_clause ]
 * 
 * <집계 함수>
 * 열들을 그대로 두고 하는 GROUP BY, 근데 이제 WINDOW를 곁들인..
 * SUM, MAX, MIN, AVG, COUNT
 * SQL Server는 집계 함수 내에서 ORDER BY 구문 지원 안함
 * 
 * <순위 관련 함수> 
 * RANK, DENSE_RANK, ROW_NUMBER
 * 
 * <비율 관련 함수>
 * CUME_DIST, PERCENT_RANK, NTILE, RATIO_TO_REPORT
 * RATIO_TO_REPORT는 Oracle만
 *
 */


-- 집계 함수에서 사용한 함수들을 윈도우 함수에서도 사용할 수 있다. OVER 절이 포함된 것이 다르다.
-- 집계 함수와는 다르게 출력 행 수를 변경하지 않고 모든 행에 집계 값을 출력한다.

SELECT SUM(sal)
FROM emp;

SELECT ename, job, sal, 
	SUM(sal) OVER () AS sal_sum
FROM emp;

-- PARTITION BY는 GROUP BY 처럼 소그룹을 나눠 집계할 수 있게 해준다.
-- WINDOW 함수 집계 결과는 분할(PARTITION)을 넘어 올 수 없다.
-- 행 수가 변경되는 GROUP BY 집계 한 것과는 다르게 각각의 행마다 집계값을 표시한다.

SELECT job, sum(sal)
FROM emp
GROUP BY job
ORDER BY 1;

SELECT ename, job, sal,
	SUM(sal) OVER (PARTITION BY job) AS sal_sum
FROM emp;

----------------------------------------------------------------------------

/* 
 * window_frame_clause:
 * 
 * ROW 절을 이용하면 열 단위로 윈도우 크기를 설정할 수 있다.
 * RANGE는 논리적 값에 의한 범위를 나타낸다.
 * 
 * {ROWS|RANGE} { frame_start | frame_between }
 * 
 * frame_start:
 * 	  { UNBOUNDED PRECEDING | numeric_expr PREDING | [CURRENT ROW] }
 * 
 * frame_between:
 * 	  {
 * 	    BETWEEN UNBOUNDED PRECEDNG AND frame_end_a
 *      | BETWEEN numeric_expr PRECEDING AND frame_end_a
 *      | BETWEEN CURRENT ROW AND frame_end_b
 *      | BETWEEN numeric_expr FOLLOWING AND frame_end_c
 *    }
 *  
 * 	frame_end_a:
 * 	  { numeric_expr PRECEDING | CURRENT ROW | numeric_expr FOLLOWING | UNBOUNDED FOLLOWING }
 * 
 * 	frame_end_b:
 * 	  { CURRENT ROW | numeric_expr FOLLOWING | UNBOUNDED FOLLOWING }
 *  
 * 	frame_end_c:
 * 	  { numeric_expr FOLLOWING | UNBOUNDED FOLLOWING }
 */


-- 윈도우를 설정하려면 먼저 ORDER BY로 순서를 정해야 한다.

-- ROWS frame_start
-- ROWS만 있는 절은 BETWEEN 절의 AND CURRENT ROW가 생략된 것과 같다.
SELECT ename, sal,
	SUM(sal) OVER (ORDER BY sal) AS "similar to col1", -- 동일 순서 자료 처리에서 차이가 있다.
	SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) AS col1,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "=col1",
	SUM(sal) OVER (ORDER BY sal ROWS 1 PRECEDING) AS col2,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS "=col2",
	SUM(sal) OVER (ORDER BY sal ROWS CURRENT ROW) AS col3,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN CURRENT ROW AND CURRENT ROW) AS "=col3"
FROM emp;

----------------------------------------------------------------------------

-- ROWS frame_between
-- ROWS BETWEEN UNBOUNDED PRECEDING AND { numeric_expr PRECEDING | CURRENT ROW | numeric_expr FOLLOWING | UNBOUNDED FOLLOWING }

SELECT ename, sal,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS col1,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS col2,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING) AS col3,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS col4, -- 윈도우 설정 안했을 때 디폴트
	SUM(sal) OVER () AS "=col4" -- 윈도우 설정 안했을 때 디폴트
FROM emp;

----------------------------------------------------------------------------

-- ROWS BETWEEN numeric_expr PRECEDING AND { numeric_expr PRECEDING | CURRENT ROW | numeric_expr FOLLOWING | UNBOUNDED FOLLOWING }

SELECT ename, sal,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS col1,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS col2,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING) AS col3,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING) AS col4
FROM emp;

----------------------------------------------------------------------------

--ROWS BETWEEN CURRENT ROW AND { CURRENT ROW | numeric_expr FOLLOWING | UNBOUNDED FOLLOWING }

SELECT ename, sal,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN CURRENT ROW AND CURRENT ROW) AS col1,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS col2,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS col3
FROM emp;

----------------------------------------------------------------------------

--ROWS BETWEEN numeric_expr FOLLOWING AND { numeric_expr FOLLOWING | UNBOUNDED FOLLOWING }

SELECT ename, sal,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING) AS col1,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING) AS col2
FROM emp;

----------------------------------------------------------------------------

-- 논리적 범위를 설정하는 range
SELECT ename, sal,
	count(*) OVER (ORDER BY sal RANGE BETWEEN 200 PRECEDING AND 200 FOLLOWING) AS sim_cnt
FROM emp;

----------------------------------------------------------------------------

-- partition by와 함께 사용
SELECT ename, job, sal,
	SUM(sal) OVER (
		PARTITION BY job ORDER BY sal 
		ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sal_sum
FROM emp
ORDER BY 2, 3;

----------------------------------------------------------------------------

--- group by와 함께 사용
SELECT job, round(avg(sal), 2) avg_sal,
	count(*) OVER (
		ORDER BY avg(sal) 
		RANGE BETWEEN 300 PRECEDING AND 300 FOLLOWING) AS rng
FROM emp
GROUP BY job
ORDER BY 2

----------------------------------------------------------------------------

/*
 * 집계 함수
 */

SELECT ename, job, sal,
	SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sum,
	round(AVG(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),2) AS avg,
	MIN(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS min,
	MAX(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max,
	COUNT(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt
FROM emp
ORDER BY sal;

SELECT ename, job, sal,
	SUM(sal) OVER () AS sum,
	round(AVG(sal) OVER (),2) AS avg,
	MIN(sal) OVER () AS min,
	MAX(sal) OVER () AS max,
	COUNT(sal) OVER () AS cnt
FROM emp
ORDER BY sal;

SELECT ename, job, sal,
	SUM(sal) OVER (PARTITION BY job) AS sum,
	round(AVG(sal) OVER (PARTITION BY job),2) AS avg,
	MIN(sal) OVER (PARTITION BY job) AS min,
	MAX(sal) OVER (PARTITION BY job) AS max,
	COUNT(sal) OVER (PARTITION BY job) AS cnt
FROM emp;

----------------------------------------------------------------------------

/*
 * 순위 함수
 * RANK       동순위 허용, 동순위 후 간격 있음
 * DENSE_RANK 동순위 허용, 동순위 후 간격 없음
 * ROW_NUMBER 동순위 없음, 동순위 시 무작위로 번호 배정
 */

SELECT ename, sal,
	RANK() OVER (ORDER BY sal DESC) AS rk,
	DENSE_RANK() OVER (ORDER BY sal DESC) AS drk,
	ROW_NUMBER() OVER (ORDER BY sal DESC) AS rn
FROM emp;

SELECT job, ename, sal,
	RANK() OVER (PARTITION BY job ORDER BY sal DESC) AS rk,
	DENSE_RANK() OVER (PARTITION BY job ORDER BY sal DESC) AS drk,
	ROW_NUMBER() OVER (PARTITION BY job ORDER BY sal DESC) AS rn
FROM emp;
----------------------------------------------------------------------------


/*
 * FIRST_VALUE, LAST_VALUE
 * LAST_VALUE는 SQL Server 지원 안함
 */ 

/*
 * LEAD(column_expr, offset, default) OVER (...)
 * LAG(column_expr, offset, default) OVER (...)
 */

WITH Sales AS (
    SELECT 1 AS sale_id, DATE '2023-01-01' AS sale_date, 101 AS employee_id, 500 AS amount FROM dual UNION ALL
    SELECT 2 AS sale_id, DATE '2023-01-02' AS sale_date, 102 AS employee_id, 700 AS amount FROM dual UNION ALL
    SELECT 3 AS sale_id, DATE '2023-01-03' AS sale_date, 101 AS employee_id, 300 AS amount FROM dual UNION ALL
    SELECT 4 AS sale_id, DATE '2023-01-04' AS sale_date, 103 AS employee_id, 900 AS amount FROM dual UNION ALL
    SELECT 5 AS sale_id, DATE '2023-01-05' AS sale_date, 101 AS employee_id, 400 AS amount FROM dual UNION ALL
    SELECT 6 AS sale_id, DATE '2023-01-06' AS sale_date, 104 AS employee_id, 600 AS amount FROM dual UNION ALL
    SELECT 7 AS sale_id, DATE '2023-01-07' AS sale_date, 105 AS employee_id, 800 AS amount FROM dual UNION ALL
    SELECT 8 AS sale_id, DATE '2023-01-08' AS sale_date, 101 AS employee_id, 350 AS amount FROM dual UNION ALL
    SELECT 9 AS sale_id, DATE '2023-01-09' AS sale_date, 102 AS employee_id, 450 AS amount FROM dual UNION ALL
    SELECT 10 AS sale_id, DATE '2023-01-10' AS sale_date, 103 AS employee_id, 750 AS amount FROM dual UNION ALL
    SELECT 11 AS sale_id, DATE '2023-01-11' AS sale_date, 101 AS employee_id, 250 AS amount FROM dual UNION ALL
    SELECT 12 AS sale_id, DATE '2023-01-12' AS sale_date, 104 AS employee_id, 650 AS amount FROM dual UNION ALL
    SELECT 13 AS sale_id, DATE '2023-01-13' AS sale_date, 105 AS employee_id, 850 AS amount FROM dual UNION ALL
    SELECT 14 AS sale_id, DATE '2023-01-14' AS sale_date, 101 AS employee_id, 450 AS amount FROM dual UNION ALL
    SELECT 15 AS sale_id, DATE '2023-01-15' AS sale_date, 102 AS employee_id, 550 AS amount FROM dual UNION ALL
    SELECT 16 AS sale_id, DATE '2023-01-16' AS sale_date, 103 AS employee_id, 950 AS amount FROM dual UNION ALL
    SELECT 17 AS sale_id, DATE '2023-01-17' AS sale_date, 104 AS employee_id, 700 AS amount FROM dual UNION ALL
    SELECT 18 AS sale_id, DATE '2023-01-18' AS sale_date, 105 AS employee_id, 900 AS amount FROM dual UNION ALL
    SELECT 19 AS sale_id, DATE '2023-01-19' AS sale_date, 101 AS employee_id, 500 AS amount FROM dual UNION ALL
    SELECT 20 AS sale_id, DATE '2023-01-20' AS sale_date, 102 AS employee_id, 600 AS amount FROM dual
)
SELECT sale_id, to_char(sale_date, 'YYYY-MM-DD') AS sale_date, employee_id, amount,
	lag(amount, 1) OVER (PARTITION BY employee_id ORDER BY sale_date) AS prev_sale,
	lead(amount, 1, NULL) OVER (PARTITION BY employee_id ORDER BY sale_date) AS next_sale,
	first_value(amount) OVER (PARTITION BY employee_id ORDER BY sale_date) AS first_sale_amount,
	last_value(amount) OVER (PARTITION BY employee_id ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_sale_amount
FROM sales;
----------------------------------------------------------------------------

/*
 * ratio_to_report
 * 비율을 구해주는 함수
 */

SELECT deptno, ename, sal,
	round(sal/sum(sal) over(), 2) AS calculated_rr,
	round(ratio_to_report(sal) OVER(), 2) AS sal_rr
FROM emp;

----------------------------------------------------------------------------
/*
 * NP-현재열보다 같거나 앞선 열 숫자
 * NR-열 숫자
 * RK-RANK 
 * 
 * cume_dist: NP/NR
 * percent_rank: (RK-1)/(NR-1)
 */

WITH T AS (
	SELECT
		empno,
		count(*) OVER (PARTITION BY deptno ORDER BY sal) AS NP,
		count(*) OVER (PARTITION BY deptno) AS NR,
		rank() OVER (PARTITION BY deptno ORDER BY sal) AS RK
	FROM emp
)
SELECT e.deptno, e.ename, e.sal,
	T.NP, T.NR, T.RK,
	T.NP/T.NR,
	cume_dist() OVER (PARTITION BY deptno ORDER BY sal) AS cd,
	(T.RK-1)/(T.NR-1),
	percent_rank() OVER (PARTITION BY deptno ORDER BY sal) AS pr
FROM emp e, T
WHERE e.empno=T.empno

----------------------------------------------------------------------------
-- NTILE
SELECT deptno, ename, sal,
	ntile(1) OVER (ORDER BY sal) AS nt1,
	ntile(2) OVER (ORDER BY sal) AS nt2,
	ntile(3) OVER (ORDER BY sal) AS nt3,
	ntile(4) OVER (ORDER BY sal) AS nt4,
	ntile(5) OVER (ORDER BY sal) AS nt5
FROM emp;