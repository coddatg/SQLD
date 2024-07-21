--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

-- p.121 111번

WITH T1 AS (
	SELECT 1 col1, 'AAAA' col2 FROM dual UNION ALL
	SELECT 1, 'AAAA' FROM dual UNION ALL
	SELECT 1, 'AAAA' FROM dual UNION ALL
	SELECT 2, 'BBBB' FROM dual
)
SELECT count(col1), count(col2)
FROM (
	SELECT DISTINCT col1, col2 FROM T1
)