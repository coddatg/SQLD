--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

-- * 애스터리스크(*) 사용하기
-- *는 모든 열 선택하는 키워드
SELECT * FROM emp;

-- 조회하려는 컬럼을 콤마(,)로 구분해 나열
SELECT empno, ename, job, deptno
FROM emp;

-- ALL, DISTINCT 옵션
-- ALL은 생략 가능한 키워드 아래 두 쿼리 같은 결과 출력
-- 같은 표현
SELECT ALL
	empno, ename, job, deptno
FROM emp;

SELECT DISTINCT
	deptno
FROM emp;

-- DISTINCT는 나열한 모든 컬럼에 적용
-- 컬럼 값들의 유일한 조합을 출력한다.
SELECT DISTINCT
	deptno, job
FROM emp
ORDER BY 1, 2;

-- ALIAS 부여하기
-- AS 키워드로 컬럼에 별명 부여
SELECT 
    empno AS 사원번호,
	ename AS 이름,
	deptno AS 부서번호,
	job AS 업무
FROM emp;

-- AS 생략 가능
SELECT 
    empno 사원번호,
	ename 이름,
	deptno 부서번호,
	job 업무
FROM emp;

-- 오라클의 ALIAS와 칼럼명은 영문자로 시작하며 영문자, _, 숫자, $, #만 허용되며 대소문자를 구분하지 않음 
-- e.g.> foo1, Bar123, F1200, foo_bar -> FOO1, BAR123, F1200, FOO_BAR로 출력
-- 허용되지 않은 컬럼 이름을 사용하거나 대소문자를 구분하고 싶으면 " "를 이용  e.g.> "123 foo", "123", "Foo", "baR"
-- SQL Server는 "", '', [] 이용 e.g.>"123 foo", '123', [Foo], [baR]
SELECT 
	empno  AS 사원 번호, -- 오류 발생
	ename  AS 123이름,  -- 오류 발생
	deptno AS 부서-번호, -- 오류 발생
	job    AS Job      -- 대소문자 반영 안됨
FROM emp;

SELECT 
	empno  AS "사원 번호",
	ename  AS "123이름",
	deptno AS "부서-번호", 
	job    AS "Job"         
FROM emp;


/*
 * 산술 연산자
 */
-- 산술 연산자, 수학의 사칙연산
-- NUMBER와 DATE에 적용 가능
-- 연산자 우선순위
-- 1. ()
-- 2. *, /
-- 3. +, -


SELECT sal,
	   sal*0.3,
	   100+300, -- 모든 행에 같은 값
	   sal-deptno
FROM emp;

-- NULL과의 산술 연산은 항상 NULL을 반환
SELECT sal+comm,
	   sal+NULL,
	   sal-NULL,
	   sal*NULL,
	   sal/NULL
FROM emp;

/* 
 * 합성 연산자
 * 오라클 ||, SQL Server +
 */
-- KING의 직책은 PRESIDENT이며 연봉은 5000이다.

SELECT ename || '의 직책은 ' || job || '이며 연봉은 ' || sal ||'이다.'
FROM emp;

-- SQL Server
-- SELECT ename + '의 직책은 ' + job + '이며 연봉은 ' + sal +'이다.'
-- FROM emp;

-- CONCAT 2개 문자열 합성
SELECT CONCAT('연봉', sal)
	-- CONCAT('연봉', ' ', sal) -- 오류. Oracle CONCA은 인자 2개만 받음 
FROM emp;




