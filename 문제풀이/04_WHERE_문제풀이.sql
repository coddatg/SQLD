--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

-- p.34 8번 문제
SELECT deptno, round(avg(sal),2)
FROM emp
HAVING avg(sal) >= 1800
GROUP BY deptno;

-- p.36 10번 문제
SELECT * FROM emp WHERE comm IS NOT NULL;
SELECT * FROM emp WHERE comm <> NULL;
SELECT * FROM emp WHERE comm != NULL;
SELECT * FROM emp WHERE comm NOT NULL;

-- p.43 22번 문제
SELECT ename
FROM emp
WHERE ename 
	LIKE '%L___'
--	LIKE '_L%__'
--	LIKE '_L_%_'
--	LIKE '_L__%'

-- p.52 36번 문제
WITH emp_tbl AS (
 	SELECT 1000 AS empno, 'SMITH' AS ename FROM dual UNION ALL
	SELECT 1050, 'ALLEN' FROM dual UNION ALL
	SELECT 1100, 'SCOTT' FROM dual
), rule_tbl AS (
	SELECT 1 AS rule_no, 'S%' AS rule FROM dual UNION ALL
	SELECT 2, '%T%' FROM dual
)
SELECT count(*) CNT
FROM emp_tbl A, rule_tbl B
WHERE A.ename LIKE B.rule;
















