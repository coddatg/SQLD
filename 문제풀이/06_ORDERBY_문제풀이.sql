--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

-- p.43 21번 문제

SELECT dname, loc, deptno
FROM dept
ORDER BY dname, loc, 3 DESC

SELECT dname, loc area, deptno
FROM dept
ORDER BY dname, area, deptno DESC

SELECT dname, loc area, deptno
FROM dept
ORDER BY 1, area, 3 DESC

SELECT dname dept, loc area, deptno
FROM dept
ORDER BY dept DESC, loc, 3 DESC


-- p.49 28번 문제풀이

WITH tbl AS (
	SELECT 100 AS id FROM dual UNION ALL
	SELECT 100 FROM dual UNION ALL
	SELECT 200 FROM dual UNION ALL
	SELECT 200 FROM dual UNION ALL
	SELECT 200 FROM dual UNION ALL
	SELECT 999 FROM dual UNION ALL
	SELECT 999 FROM dual
)
SELECT id
FROM tbl
GROUP BY id
HAVING count(*)=2
ORDER BY (CASE WHEN id=999 THEN 0 ELSE id end)












