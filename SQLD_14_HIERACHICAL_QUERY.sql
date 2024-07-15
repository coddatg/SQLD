--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/FGmid
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------


/*
 * 셀프 조인
 */

-- 관리자가 JONES인 직원

SELECT a.empno, a.ename,
	b.empno, b.ename, b.mgr
FROM emp a, emp b, emp c
WHERE a.ename='JONES'
	AND b.mgr = a.empno

SELECT a.empno, a.ename,
	b.empno, b.ename, b.mgr,
	c.empno, c.ename, c.mgr
FROM emp a, emp b, emp c
WHERE a.ename='JONES'
	AND b.mgr = a.empno
	AND c.mgr = b.empno

/*
 * 계층형 질의
 */

-- JONES에서 시작 
SELECT empno, ename, mgr
	FROM emp
START WITH ename='JONES'
CONNECT BY PRIOR empno=mgr
ORDER SIBLINGS BY ename ASC;

-- mgr이 NULL인 경우, 루트 노드에서 시작
SELECT empno, ename, mgr
	FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno=mgr
ORDER SIBLINGS BY ename ASC;

-- 제공되는 슈도코드, 연산자, 함수
SELECT empno, ename, mgr,
	LEVEL,
	CONNECT_BY_ISLEAF,
	CONNECT_BY_ROOT ename AS "root",
	SYS_CONNECT_BY_PATH(ename, '/') AS "path"
	FROM emp
START WITH ename='JONES'
CONNECT BY PRIOR empno=mgr;

-- level을 이용한 계층 표현
SELECT empno, ename, mgr,
	   LEVEL,
	   lpad(' ', (LEVEL-1)*2)||ename AS level_empno,
	   sys_connect_by_path(ename, '/') AS PATH
	FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno=mgr
ORDER SIBLINGS BY ename ASC;

-- CONNECT BY에 추가 조건을 기술할 수 있으며 시작 노드를 제외한 나머지 노드에 적용됨
SELECT empno, ename, mgr, hiredate
	FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno=mgr
	AND hiredate BETWEEN '1981-01-01' AND '1981-06-30'
ORDER SIBLINGS BY ename ASC;

--- recursive cte를 이용한 방법

WITH anchor(n) AS (
	SELECT 1 AS n FROM dual
	UNION ALL
	SELECT n + 1 AS n FROM anchor WHERE n < 3
)
SELECT * FROM anchor;


WITH emp_anchor(empno, ename, mgr, lv) AS (
	SELECT empno, ename, mgr, 1 AS lv
	FROM emp
	WHERE mgr IS NULL
	UNION ALL
	SELECT b.empno, b.ename, b.mgr, a.lv+1 AS lv
	FROM emp_anchor a JOIN emp b
	ON a.empno=b.mgr
)
SELECT * FROM emp_anchor;

-- 순서까지
WITH emp_anchor(empno, ename, mgr, lv, sort) AS (
	SELECT empno, ename, mgr, 1 AS lv,
		to_char(row_number() OVER (ORDER BY ename)) AS sort
	FROM emp
	WHERE mgr IS NULL
	UNION ALL
	SELECT b.empno, b.ename, b.mgr, a.lv+1 AS lv,
		a.sort||to_char(row_number() over(ORDER BY b.ename)) AS sort
	FROM emp_anchor a JOIN emp b
	ON a.empno=b.mgr
)
SELECT empno, ename, mgr, lv FROM emp_anchor
ORDER BY sort;




WITH t AS (
	SELECT 001 deptno, '대표이사' dname, NULL higher FROM dual UNION ALL
	SELECT 100, '경영지원부', 001 FROM dual UNION ALL
	SELECT 101, '회계팀' dname, 100 FROM dual UNION ALL
	SELECT 101, '인사팀' dname, 100 FROM dual UNION ALL
	SELECT 101, '재무팀' dname, 100 FROM dual UNION ALL
	SELECT 200, '영업본부' dname, 001 FROM dual UNION ALL
	SELECT 201, '국내영업팀' dname, 200 FROM dual UNION ALL
	SELECT 202, '해외영업팀' dname, 200 FROM dual UNION ALL
	SELECT 203, '고객관리팀' dname, 200 FROM dual UNION ALL
	SELECT 300, '개발본부' dname, NULL FROM dual UNION ALL
	SELECT 301, '프론트엔드팀' dname, 300 FROM dual UNION ALL
	SELECT 302, '백엔드팀' dname, 300 FROM dual
)
SELECT deptno, dname, higher
	FROM t
START WITH deptno=100
CONNECT BY deptno = PRIOR higher
UNION
SELECT deptno, dname, higher
	FROM t
START WITH deptno=100
CONNECT BY PRIOR deptno=higher

