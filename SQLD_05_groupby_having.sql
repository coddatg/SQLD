--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/FGmid
-- Email          : coddat.g@gmail.com
-- Last Updated   : 2024-06-28
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

/*
 * GROUP BY, HAVING 절
 * 
 * 집계함수
 * GROUP BY 절
 * HAVING 절
 */

/*
 * 출제 포인트
 *
 * 1.집계 함수의 NULL 처리, 공집합 처리
 * 2.주의 사항
 * 3.HAVING 절 GROUP BY 없이 사용
 * 4.HAVING과 WHERE의 차이
 */

/*
 * 집계함수와 GROUP BY 절
 * MIN, MAX, SUM, AVG, COUNT
 */

SELECT * FROM artist;

SELECT count(*),
	sum(height),
	avg(height),
	max(height),
	min(height)
FROM artist;

-- 함수 내부에 DISTINCT 사용할 수 있음
SELECT DISTINCT group_name FROM artist;

SELECT count(*),
	count(group_name),
	count(DISTINCT group_name)
FROM artist;

-- NULL 처리. 공집합일 때
SELECT count(*)
FROM artist
WHERE foot_size IS NOT NULL;

SELECT count(*) AS 전체행수, 
	   count(foot_size) AS NULL제외행수
FROM artist;

-- NULL만 있을 때
SELECT foot_size
FROM artist
WHERE foot_size IS NULL;

SELECT count(*) AS 전체행수,
	   count(foot_size) AS NULL제외행수,
	   sum(foot_size),
	   avg(foot_size),
	   max(foot_size),
	   min(foot_size)
FROM artist
WHERE foot_size IS NULL;

-- 공집합일 때
SELECT * FROM artist WHERE 1=2;

SELECT count(*),
	count(height),
	sum(height),
	avg(height),
	max(height),
	min(height)
FROM artist
WHERE 1=2;

-- GROUP BY에 지정된 칼럼의 같은 이름끼리 그룹화
SELECT group_name,
	count(*),
	round(avg(height),2),
	max(height),
	min(height),
	sum(height)
FROM artist
GROUP BY group_name;

-- GROUP BY에 1개 이상 칼럼 지정할 수 있다.
SELECT group_name, birth_year,
	count(*),
	round(avg(height),2),
	max(height),
	min(height),
	sum(height)
FROM artist
GROUP BY group_name, birth_year;

-- GROUP BY에 지정된 칼럼들의 공통 조합을 공유하는 행들을 그룹화
-- 중복된 것들을 제거하고 유일한 조합만을 남기게 된다. DISTINCT 한 것과 같은 효과
SELECT group_name, birth_year
FROM artist
GROUP BY group_name, birth_year;

SELECT DISTINCT
	group_name, birth_year
FROM artist;

-- 그룹화하지도 집계하지도 않은 컬럼은 조회할 수 없음
SELECT name,
	group_name AS 그룹,
	avg(foot_size)
FROM artist
GROUP BY group_name;

SELECT 
	group_name AS 그룹,
	avg(foot_size)
FROM artist
GROUP BY group_name
ORDER BY name; -- ORDER BY에는 SELECT에서 조회 할 수 있는 컬럼만 올 수 있음

-- GROUP BY에는 ALIAS 사용할 수 없음
SELECT 
	group_name AS 그룹,
	avg(foot_size)
FROM artist
GROUP BY 그룹;


/*
 * HAVING 절
 *
 * GROUP BY 되거나 집계된 데이터 필터링
 */

SELECT group_name,
	round(avg(height),2),
	max(height),
	min(height),
	avg(foot_size)
FROM artist
GROUP BY group_name
HAVING avg(foot_size)> 240;

-- SELECT에 선택하지 않아도 필터링 할 수 있음
SELECT group_name,
	round(avg(height),2),
	max(height),
	min(height)
FROM artist
GROUP BY group_name
HAVING avg(foot_size)> 240;

-- GROUP BY와의 순서는 바꿀수도 있음
-- 보통은 GROUP BY 뒤에 사용
SELECT group_name,
	round(avg(height),2),
	max(height),
	min(height)
FROM artist
HAVING avg(foot_size)> 240
GROUP BY group_name;

-- HAVING은 GROUP BY 없이 단독으로도 사용 가능
SELECT max(height),
	min(height)
FROM artist
HAVING count(*)>0;

SELECT
	round(avg(height),2),
	max(height),
	min(height)
FROM artist
HAVING avg(foot_size) > 0;

-- 아래 둘은 같은 결과를 출력
SELECT group_name,
	round(avg(height),2),
	max(height),
	min(height)
FROM artist
HAVING group_name IN ('aespa', 'IVE')
GROUP BY group_name;

-- WHERE 절이 GROUP BY 전에 실행된다는 차이
SELECT group_name,
	round(avg(height),2),
	max(height),
	min(height)
FROM artist
WHERE group_name IN ('aespa', 'IVE')
GROUP BY group_name;

-- 필터링 구문이긴 하지만 GROUP BY나 집계하지 않았기 때문에 HAVING을 사용 할 수 없다.
SELECT group_name, height
FROM artist
HAVING group_name IN ('aespa', 'IVE');

-- WHERE 절은 group by, 집계 이전에 실행되기 때문에 집계함수를 사용할 수 없다.
SELECT group_name, height
FROM artist
GROUP BY group_name
WHERE avg(height) > 165;

/*
 * 집계함수와 산술연산자의 NULL 처리 연습 쿼리 추가
 */

-- test 데이터세트 생성
CREATE TABLE temp (
	col1 number,
	col2 number,
	col3 number
);

INSERT INTO temp (col1, col2, col3) VALUES (10, NULL, 30);
INSERT INTO temp (col1, col2, col3) VALUES (NULL, 40, 10);
INSERT INTO temp (col1, col2, col3) VALUES (0, 30, NULL);

-- 집계함수 NULL 빼고 집계
-- NULL과 산술연산자(+,-,*,/) 연산 결과는 NULL

SELECT * FROM temp;
SELECT sum(col2), sum(col3), sum(col2)+sum(col3) FROM temp;
/*
col1	col2	col3
----	----	----
10		NULL	30
NULL	40		10
0		30		NULL

---------------------
sum(col2) 40+30 -> 70
sum(col3) 30+10 -> 40
sum(col2)+sum(col3) 70+40 -> 110
*/

SELECT * FROM temp WHERE col1>0;
SELECT sum(col2), sum(col3), sum(col2)+sum(col3) FROM temp WHERE col1>0;
/*
col1	col2	col3
----	----	----
10		NULL	30

----------------------
sum(col2) -> NULL
sum(col3) -> 30
sum(col2)+sum(col3) NULL+30 -> NULL
*/

SELECT * FROM temp WHERE col1 IS NOT NULL;
SELECT sum(col2), sum(col3), sum(col2)+sum(col3) FROM temp WHERE col1 IS NOT NULL;
/*
col1	col2	col3
----	----	----
10		NULL	30
0		30		NULL

----------------------
sum(col2) -> 30
sum(col3) -> 30
sum(col2)+sum(col3) 30+30 -> 60
*/

SELECT * FROM temp WHERE col1 IS NULL;
SELECT sum(col2), sum(col3), sum(col2)+sum(col3) FROM temp WHERE col1 IS NULL;
/*
col1	col2	col3
----	----	----
NULL	40		10

----------------------
sum(col2) -> 40
sum(col3) -> 10
sum(col2)+sum(col3) 40+10 -> 50
*/

-- 테스트 데이터세트 삭제
DROP TABLE temp;

-- 인라인 뷰로 테스트 데이터세트 T 생성
WITH T AS (
	SELECT NULL col1, 'A' col2, null col3 FROM dual UNION ALL
	SELECT 1, 'A', 10 FROM dual UNION ALL
	SELECT NULL, 'B', 9 FROM dual UNION ALL
	SELECT 2, 'B', 8 FROM dual UNION ALL
	SELECT NULL, 'C', 7 FROM dual UNION ALL
	SELECT 3, 'C', 6 FROM dual UNION ALL
	SELECT NULL, 'D', 5 FROM dual UNION ALL
	SELECT 4, 'D', 4 FROM dual UNION ALL
	SELECT NULL, NULL, 3 FROM dual UNION ALL
	SELECT 5, NULL, 2 FROM dual
)
SELECT col2,
	max(col1),
	min(col1),
	sum(col1+col3)
FROM T
GROUP BY col2;