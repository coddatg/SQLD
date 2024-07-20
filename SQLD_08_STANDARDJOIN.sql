--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------


/*
 * Equi INNER JOINS
 * 
 * FROM tableA a [INNER] JOIN tableB b 
 * 	ON a.column_name=b.column_name [AND a.column_name=b.column_name]
 * 
 * FROM tableA a [INNER] JOIN tableB b USING (column_name1[, column_name2])
 * 
 * FROM tableA a NATURAL JOIN tableB b
 */

SELECT empno, a.ename, b.dname
FROM emp a, dept b
WHERE a.deptno=b.deptno;

-- 표준 구문
SELECT empno, a.ename, b.dname
FROM emp a
INNER JOIN dept b -- INNER 생략 가능
ON a.deptno=b.deptno;

-- USING
SELECT empno, a.ename, b.dname
FROM emp a
INNER JOIN dept b -- INNER 생략 가능
USING (deptno);

SELECT empno, a.ename, b.dname
FROM emp a
NATURAL JOIN dept b;


/*
 * Non EQUI JOIN
 * =가 아닌 다른 (Between, >, >=, <, <= 등) 연산자 사용해 JOIN
 */

WITH salgrade AS (
	SELECT 1 grade, 700 losal, 1200 hisal FROM dual
	UNION ALL
	SELECT 2 grade, 1201 losal, 1400 hisal FROM dual
	UNION ALL
	SELECT 3 grade, 1401 losal, 2000 hisal FROM dual
	UNION ALL
	SELECT 4 grade, 2001 losal, 3000 hisal FROM dual
	UNION ALL
	SELECT 5 grade, 3001 losal, 9999 hisal FROM dual
)
--SELECT * FROM salgrade;
SELECT e.ename, e.job, e.sal, s.losal, s.hisal, s.grade
FROM emp e, salgrade s
WHERE e.sal between s.losal AND s.hisal
ORDER BY e.ename, s.grade;

WITH salgrade AS (
	SELECT 1 grade, 700 losal, 1200 hisal FROM dual
	UNION ALL
	SELECT 2 grade, 1201 losal, 1400 hisal FROM dual
	UNION ALL
	SELECT 3 grade, 1401 losal, 2000 hisal FROM dual
	UNION ALL
	SELECT 4 grade, 2001 losal, 3000 hisal FROM dual
	UNION ALL
	SELECT 5 grade, 3001 losal, 9999 hisal FROM dual
)
--SELECT * FROM salgrade;
SELECT e.ename, e.job, e.sal, s.losal, s.hisal, s.grade
FROM emp e
JOIN salgrade s
ON e.sal between s.losal AND s.hisal
ORDER BY e.ename, s.grade;

/*
 * 3개 이상 테이블 조인
 */

SELECT a.player_name,
	b.region_name,
	b.team_name,
	c.stadium_name
FROM player a, team b, stadium c
WHERE b.team_id=a.team_id
	AND c.stadium_id=c.stadium_id;

SELECT a.player_name,
	b.region_name,
	b.team_name,
	c.stadium_name
FROM player a
JOIN team b ON b.team_id=a.team_id
JOIN stadium c ON c.stadium_id=c.stadium_id;

/*
 * OUTER JOINS
 * 
 * 왼 쪽 테이블(FROM) 기준으로 조인
 * FROM tableA LEFT [OUTER] JOIN tableB 
 * 
 * 오른 쪽 테이블(JOIN) 기준으로 조인
 * FROM tableA LEFT [OUTER] JOIN tableB 
 * 
 * 양 쪽 테이블 기준으로 조인
 * FROM tableA FULL [OUTER] JOIN tableB
 */

SELECT a.stadium_name, a.stadium_id, b.stadium_id, b.team_name
FROM stadium a, team b
WHERE b.stadium_id(+)=a.stadium_id;

SELECT a.stadium_name, a.stadium_id, b.stadium_id, b.team_name
FROM stadium a
LEFT OUTER JOIN team b
ON b.stadium_id=a.stadium_id;

SELECT a.stadium_name, a.stadium_id, b.stadium_id, b.team_name
FROM team b
RIGHT OUTER JOIN stadium a
ON b.stadium_id=a.stadium_id;


-- full outer join
CREATE VIEW v_employee AS (
SELECT 1 AS emp_id, 'Alice' AS name, 100 AS salary FROM dual UNION ALL
SELECT 2 AS emp_id, 'Bob' AS name, 200 AS salary FROM dual UNION ALL
SELECT 3 AS emp_id, 'Charlie' AS name, 300 AS salary FROM dual);

CREATE VIEW v_project AS (
SELECT 1 AS proj_id, 'Project A' AS proj_name, 1 AS emp_id FROM dual UNION ALL
SELECT 2 AS proj_id, 'Project B' AS proj_name, 2 AS emp_id FROM dual UNION ALL
SELECT 3 AS proj_id, 'Project C' AS proj_name, 4 AS emp_id FROM dual);

SELECT e.emp_id,
    e.name AS employee_name,
    e.salary,
    p.proj_id,
    p.proj_name
FROM v_employee e
FULL OUTER JOIN v_project p
ON e.emp_id = p.emp_id
ORDER BY e.emp_id, p.proj_id;

SELECT emp_id,
    e.name AS employee_name,
    e.salary,
    p.proj_id,
    p.proj_name
FROM v_employee e
FULL OUTER JOIN v_project p
USING (emp_id)
ORDER BY emp_id, p.proj_id;

-- full outer join과 실행 결과가 같은 쿼리들
SELECT e.emp_id,
    e.name AS employee_name,
    e.salary,
    p.proj_id,
    p.proj_name
FROM v_employee e
LEFT JOIN v_project p
ON e.emp_id = p.emp_id
UNION
SELECT e.emp_id,
    e.name AS employee_name,
    e.salary,
    p.proj_id,
    p.proj_name
FROM v_employee e
RIGHT JOIN v_project p
ON e.emp_id = p.emp_id

SELECT e.emp_id,
    e.name AS employee_name,
    e.salary,
    NULL AS proj_id,
    NULL AS proj_name
FROM v_employee e
WHERE NOT EXISTS (SELECT 1 FROM v_project p WHERE e.emp_id=p.emp_id)
UNION ALL
SELECT e.emp_id,
    e.name AS employee_name,
    e.salary,
    p.proj_id,
    p.proj_name
FROM v_employee e
JOIN v_project p
ON e.emp_id = p.emp_id
UNION ALL
SELECT NULL,
	NULL,
	NULL,
    p.proj_id,
    p.proj_name
FROM v_project p
WHERE NOT EXISTS (SELECT 1 FROM v_employee e WHERE e.emp_id=p.emp_id)
ORDER BY 1;


DROP VIEW v_employee;
DROP VIEW v_project;

/*
 * CROSS JOIN
 */

SELECT a.empno, a.ename, b.dname
FROM emp a, dept b;

SELECT a.empno, a.ename, b.dname
FROM emp a
CROSS JOIN dept b;

SELECT a.empno, a.ename, b.dname
FROM emp a, dept b, emp c;

SELECT a.empno, a.ename, b.dname
FROM emp a
CROSS JOIN dept b
CROSS JOIN emp c;
