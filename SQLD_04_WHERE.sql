--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

/*
 * WHERE 절
 * 원하는 열들을 검색, 필터링해서 출력
 */

-- 비교 연산자
-- 다른 자료형을 bool(TRUE/FALSE) 로 변환
-- 예, 아니오로 대답하세요.
-- =, >, >=, <, <=
-- !=, <>, ^=

SELECT * FROM emp;

-- 부서번호가 20인 직원 정보
SELECT empno, ename, deptno, sal
FROM emp
WHERE deptno=20;

-- 부서번호가 20인 직원 정보
SELECT empno, ename, deptno, sal
FROM emp
WHERE deptno^=20;

-- 부서번호가 20인 직원 정보
SELECT empno, ename, deptno, sal
FROM emp
WHERE deptno=30;

-- 논리 연산자
-- AND, OR bool 결합
-- NOT bool 반전

-- 부서번호가 20이거나 30인 직원 정보
SELECT empno, ename, deptno, sal
FROM emp
WHERE deptno=20 OR deptno=30;

-- 부서번호가 20이거나 30이면서
-- sal이 1100 이상인 직원 정보
SELECT empno, ename, deptno, sal
FROM emp
WHERE deptno=20 OR 
	deptno=30 AND sal>=1100;


-- 연산자 우선순위에 주의
-- 1. () 
-- 2. 비교연산자 SQL 연산자
-- 3. NOT 
-- 4. AND 
-- 5. OR

SELECT empno, ename, deptno, sal
FROM emp
WHERE (deptno=20 OR deptno=30) AND sal>=1100;


-- 부서번호가 20이거나 30이면서
-- sal이 1100 이상이고 2500이하인 직원 정보
SELECT empno, ename, deptno, sal
FROM emp
WHERE (deptno=20 OR deptno=30) 
	AND (sal>=1100 AND sal<=2500);


/*
 * SQL 연산자
 * IN, BETWEEN, LIKE, IS NULL
 */

-- IN, BETWEEN 자주 쓰는 비교 연산자와 논리 연산자 묶음


-- x [NOT] IN 연산자: 리스트에 있는 값 중 어느 하나라도 일치. EQUI OR 조건을 묶는다.
SELECT empno, ename, deptno, sal
FROM emp
WHERE deptno IN (20, 30) -- (deptno=20 OR deptno=30) 
	AND (sal>=1100 AND sal<=2500);

SELECT empno, ename, deptno, sal
FROM emp
WHERE deptno NOT IN (20, 30) -- NOT (deptno=20 OR deptno=30) 
	AND (sal>=1100 AND sal<=2500);

-- x [NOT] BETWEEN a AND B 연산자: 범위 조건
SELECT empno, ename, deptno, sal
FROM emp
WHERE deptno IN (20, 30) 
	AND sal BETWEEN 1100 AND 2500 -- (sal>=1100 AND sal<=2500);

SELECT empno, ename, deptno, sal
FROM emp
WHERE deptno IN (20, 30) 
	AND sal NOT BETWEEN 1100 AND 2500 -- NOT (sal>=1100 AND sal<=2500);


-- LIKE 연산자: 문자열 비교
-- %는 길이 상관 없이 어떤 문자든 매칭
-- _는 1개 문자와 매칭. 자리수 표현

-- A로 시작하는 직원 정보
SELECT empno, ename
FROM emp
WHERE ename LIKE 'A%';

-- J로 시작하고 ES로 끝나는 직원 정보
SELECT empno, ename
FROM emp
WHERE ename LIKE 'J%ES';

-- 이름이 4글자인 직원 정보
SELECT empno, ename
FROM emp
WHERE ename LIKE '____';

-- 이름이 4글자고 D로 끝나는 직원 정보
SELECT empno, ename
FROM emp
WHERE ename LIKE '___D';


/*
 * WHERE 절에서의 NULL 처리
 */

-- null 과 비교연산
-- =, >, <=, <, <=
-- !=, <>, != 
-- 모두 FALSE
SELECT *
FROM emp
WHERE 
	comm=NULL
	OR comm>NULL 
	OR comm>=NULL
	OR comm<NULL
	OR comm<=NULL
	OR comm!=NULL
	OR NULL=NULL
	OR NULL!=NULL;

SELECT *
FROM emp
WHERE
	sal BETWEEN 800 AND NULL
	OR sal BETWEEN NULL AND 3000
	OR NULL IN (1, 2, 3, NULL)
	OR NULL NOT IN (1, 2, 3, NULL)
	OR NULL LIKE 'NULL'
	OR NULL LIKE NULL;

-- 비교할 수 없다. 오류 발생.
SELECT *
FROM emp
WHERE 1=1 AND NULL;

-- IS 연산자
SELECT empno, ename, comm
FROM emp
WHERE comm IS NULL;

SELECT empno, ename, comm
FROM emp
WHERE comm IS NOT NULL;