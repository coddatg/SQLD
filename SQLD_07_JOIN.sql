--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/FGmid
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

/*
 * JOIN
 * 
 * 테이블 여러개 조인해도 2개씩 조인
 * JOIN A, B, C, D -> JOIN(JOIN(JOIN(A, B), C), D)
 */

/*
 * EQUI JOIN
 * 테이블 간의 칼럼 값들이 정확히 일치 할 때 사용
 *
 * 일반적으로는 PK, FK를 이용
 * 논리적 관계만으로도 가능
 * JOIN 대상 테이블 N개라면 EQUI JOIN은 조인 조건 N-1개 필요
 */

SELECT * FROM emp;
SELECT * FROM dept;

-- 테이블 이름을 컬럼 명 앞에 '.'로 구분해서 사용한다. 
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno=dept.deptno;

-- 테이블명 사용은 양 쪽 테이블의 컬럼명이 겹치지 않는 경우는 필수가 아니다. 
SELECT empno, emp.ename, dept.dname
FROM emp, deptno
WHERE emp.deptno=dept.deptno;

-- Alias 활용, 쿼리 복잡도 줄일 수 있다.
-- FROM 절에서는 AS를 사용할 수 없다.
SELECT empno, a.ename, b.dname
FROM emp a, dept b
WHERE a.deptno=b.deptno;

-- Alias를 붙인 경우 기존 테이블 명은 사용할 수 없다.
-- 아래 쿼리는 오류 발생
SELECT emp.empno, emp.ename, b.dname
FROM emp a, dept b
WHERE emp.deptno=b.deptno;

-- 조건 추가해서 쿼리 할 수 있다.
SELECT a.empno, emp.ename, b.dname
FROM emp a, dept b
WHERE b.dname='SALES' AND a.deptno=b.deptno;

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
-- WHERE e.sal between s.losal AND s.hisal
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

/*
 * OUTER JOIN
 * 한 쪽 테이블 기준으로 조인
 * 기준 테이블을 불러오고, 다른쪽 테이블을 추가 한다.
 */

SELECT a.stadium_name, a.stadium_id, b.stadium_id, b.team_name
FROM stadium a, team b
WHERE b.stadium_id(+)=a.stadium_id;

SELECT a.stadium_name, a.stadium_id, b.stadium_id, b.team_name
FROM stadium a, team b
WHERE a.stadium_id=b.stadium_id(+);

SELECT a.ename, b.dname
FROM emp a, dept b
WHERE b.deptno=a.deptno(+);

-- OUTER 조인 다른 쿼리로 작성해보기

SELECT a.stadium_name, a.stadium_id, b.stadium_id, b.team_name
FROM stadium a, team b
WHERE b.stadium_id=a.stadium_id
UNION ALL
SELECT stadium_name, stadium_id, NULL, NULL
FROM stadium
WHERE stadium_id NOT IN (SELECT stadium_id FROM team);

SELECT a.stadium_name, a.stadium_id, b.stadium_id, b.team_name
FROM stadium a, team b
WHERE b.stadium_id=a.stadium_id
UNION ALL
SELECT a.stadium_name, a.stadium_id, NULL, NULL
FROM stadium a
WHERE NOT EXISTS (SELECT 1 FROM team b WHERE a.stadium_id=b.stadium_id);