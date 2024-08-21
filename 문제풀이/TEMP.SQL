
/*
 * p.99 87 번
 */

WITH 추천내역 AS (
      SELECT 'SNS' 추천경로, '나한일' 추천인, '강감찬' 피추천인, 75 추천점수 FROM DUAL UNION ALL
      SELECT 'SNS', '이순신', '강감찬', 80 FROM DUAL UNION ALL
      SELECT '이벤트응모', '홍길동', '강감찬', 88 FROM DUAL UNION ALL
      SELECT '이벤트응모', '저절로', '이순신', 78 FROM DUAL UNION ALL
      SELECT '홈페이지', '저절로', '이대로', 93 FROM DUAL UNION ALL
      SELECT '홈페이지', '홍두깨', '심청이', 98 FROM DUAL
)
SELECT 추천경로, 추천인, 피추천인, 추천점수
FROM (SELECT 추천경로, 추천인, 피추천인, 추천점수,
            ROW_NUMBER() OVER (PARTITION BY 추천경로 ORDER BY 추천점수 DESC) AS RNUM
      FROM 추천내역)
WHERE RNUM=1