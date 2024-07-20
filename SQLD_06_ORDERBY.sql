--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

/*
 * ORDER BY 절
 * 
 * 결과를 정렬해서 출력
 * 
 * ORDER BY expression
 * 	[{ ASC | DESC }]
 * 	[{ NULLS FIRST | NULLS LAST }] 
 * 	[,...]
 */

/*
 * 출제 포인트
 * 
 * 1. 같은 결과 출력하는 표현식
 * 2. 잘못된 표현식
 * 3. NULL 정렬 순서 및 NULL 처리
 */

-- ASC 오름차순 정렬. 기본값 생략 가능
SELECT name,
	group_name,
	height,
	foot_size
FROM artist
ORDER BY height;

SELECT name,
	group_name,
	height,
	foot_size
FROM artist
ORDER BY height ASC;

-- DESC 내림 차순 정렬. 생략 할 수 없음
SELECT name,
	group_name,
	height,
	foot_size
FROM artist
ORDER BY height DESC;

-- 여러개 컬럼으로 정렬 할 수 있음
SELECT name,
	group_name,
	height,
	foot_size
FROM artist
ORDER BY group_name, height DESC;

-- { DESC | ASC } 옵션은 각각에 적용
SELECT name,
	group_name,
	height,
	foot_size
FROM artist
ORDER BY group_name DESC, height DESC;

-- 표현식에 올 수 있는 것
-- 컬럼 이름, ALIAS, 출력되는 컬럼 번호, 기타 표현식

SELECT name,
	group_name AS 그룹이름,
	height AS 키,
	foot_size
FROM artist
ORDER BY 2 DESC, 키 DESC;

SELECT name,
	group_name AS 그룹이름,
	height AS 키,
	foot_size
FROM artist
ORDER BY LOWER(group_name), height;

-- 같은 결과 출력하는 표현식
-- 컬럼 이름, ALIAS, 컬럼 번호 등 다양한 표현식을 사용할 수 있고
-- ASC가 생략 가능하다는 사실을 이용한 다양한 표현
SELECT name,
	group_name AS 그룹이름,
	height AS 키,
	foot_size
FROM artist
ORDER BY group_name DESC, height, name;
-- ORDER BY group_name DESC, 3, name;
-- ORDER BY 그룹이름 DESC, birth_year ASC, 1;

-- 사용 주의 사항, 잘못된 표현식 쓰기
-- ORDER BY의 실행 순서는 SELECT 다음이기 때문에 SELECT에 출력 가능한 표현식만 정렬 기준으로 넣을 수 있다.
SELECT group_name,
	avg(height)
FROM artist
GROUP BY group_name
ORDER BY name DESC;

SELECT name,
	group_name,
	birth_year
FROM artist
ORDER BY avg(height)

SELECT group_name,
	avg(height)
FROM artist
GROUP BY group_name
ORDER BY avg(height) DESC

-- NULL 정렬 순서 및 NULL처리
-- Oracle NULL 가장 큰 값으로 처리, SQL Server는 가장 작은 값으로 처리
SELECT name,
	group_name,
	foot_size
FROM artist
ORDER BY foot_size ASC;

-- { NULLS FIRST | NULLS LAST } 옵션으로 NULL 출력 순서 제어 가능(Oracle Only)
SELECT name,
	group_name,
	foot_size
FROM artist
ORDER BY foot_size DESC NULLS LAST;