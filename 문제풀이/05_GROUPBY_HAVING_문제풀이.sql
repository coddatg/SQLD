--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------


-- p.35 9번 문제

WITH TAB_A AS (
	SELECT 30 col1, NULL col2, 20 col3 FROM dual UNION ALL
	SELECT NULL, 50, 10 FROM dual UNION ALL
	SELECT 0, 10, NULL col3 FROM dual
)
SELECT sum(col2) + sum(col3) FROM tab_a WHERE col1 IS NULL;
-- SELECT * FROM tab_a;
-- SELECT sum(col2) + sum(col3) FROM tab_a;
-- SELECT sum(col2) + sum(col3) FROM tab_a WHERE col1 > 0;
-- SELECT sum(col2) + sum(col3) FROM tab_a WHERE col1 IS NOT NULL;
-- SELECT sum(col2) + sum(col3) FROM tab_a WHERE col1 IS NULL;

-- p.48 27번 문제
WITH TABLE_A AS (
	SELECT 1 AS tabkey, NULL AS cola, '가' AS colb, NULL AS colc FROM dual UNION ALL
	SELECT 2, 1, '가', 5 FROM dual UNION ALL
	SELECT 3, NULL, '나', 2 FROM dual UNION ALL
	SELECT 4, 3, '나', 0 FROM dual UNION ALL
	SELECT 5, NULL, NULL, 3 FROM dual UNION ALL
	SELECT 6, 5, '다', 0 FROM dual UNION ALL
	SELECT 7, NULL, '다', NULL FROM dual
)
SELECT cola+colc FROM table_a;

SELECT colb
	, max(cola) AS cola1
	, min(cola) AS cola2
	, sum(cola+colc) AS sumac
FROM table_a
GROUP BY colb;

-- SELECT * FROM TABLE_A;

-- p.63 50번 문제
WITH tab1 AS (
	SELECT 10 AS col1, 20 AS col2, NULL AS col3 FROM dual UNION ALL
	SELECT 15, NULL, NULL FROM dual UNION ALL
	SELECT 50, 70, 20 FROM dual
)
SELECT sum(col2) + sum(col3) FROM tab1;

-- SELECT sum(col2) FROM tab1;
-- SELECT sum(col1+col2+col3) FROM tab1;
-- SELECT sum(col2+col3) FROM tab1;
-- SELECT sum(col2) + sum(col3) FROM tab1;





