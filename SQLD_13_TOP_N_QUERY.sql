--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/FGmid
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------


/*
 * TOP N 쿼리
 * 
 * 오라클 
 *
 * 슈도컬럼 ROWNUM 
 * OFFSET offset { ROW | ROWS }
 * FETCH { FIRST | NEXT } [ { rowcount | percent PERCENT } ] { ROW | ROWS } { ONLY | WITH TIES }
 * 
 */

SELECT ename, sal
FROM emp
WHERE rownum < 3
ORDER BY sal DESC; -- 추출 후 반영

SELECT ename, sal
FROM (
	SELECT ename, sal
	FROM emp 
	ORDER BY sal DESC
)
WHERE rownum < 3;

SELECT ename, sal
FROM emp
ORDER BY sal DESC
FETCH FIRST 2 ROWS WITH TIES;

SELECT ename, sal
FROM emp
ORDER BY sal DESC
OFFSET 5 ROWS FETCH FIRST 2 ROWS ONLY;

/* 
 * SQL Server 
 */

SELECT TOP(2) 
	   ename, sal
FROM EMP
ORDER BY sal DESC;
/*
KING 5000.00
SCOTT 3000.00
*/

SELECT TOP(2) WITH TIES
	   ename, sal
FROM EMP
ORDER BY sal DESC;
/*
KING 5000.0
FORD 3000.0
SCOTT 3000.0
*/