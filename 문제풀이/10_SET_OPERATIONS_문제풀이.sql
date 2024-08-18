/*
 * p.59 45번 문제
 */
SELECT A.ID, B.ID
FROM TBL1 A FULL OUTER JOIN TBL2 B
ON A.ID=B.ID

SELECT A.ID, B.ID
FROM TBL1 A LEFT OUTER JOIN TBL2 B
ON A.ID=B.ID
UNION
SELECT A.ID, B.ID
FROM TBL1 A RIGHT OUTER JOIN TBL2 B
ON A.ID=B.ID

SELECT A.ID, B.ID
FROM TBL1 A, TBL2 B
WHERE A.ID=B.ID
UNION ALL
SELECT A.ID, NULL
FROM TBL1 A
WHERE NOT EXISTS (SELECT 1 FROM TBL B WHERE A.ID=B.ID)
UNION ALL
SELECT NULL, B.ID
FROM TBL1 B
WHERE NOT EXISTS (SELECT 1 FROM TBL A WHERE B.ID=A.ID)

/*
 * p68 55번 문제
 */
SELECT A.서비스ID, B.서비스명, B.서비스URL
FROM (SELECT 서비스ID
      FROM 서비스
      INTERSECT
      SELECT 서비스ID
      FROM 서비스이용) A, 서비스 B
WHERE A.서비스ID=B.서비스ID;

-- 1번 보기
SELECT B.서비스ID, A.서비스명, A.서비스URL
FROM 서비스 A, 서비스이용 B
WHERE A.서비스ID=B.서비스ID;

-- 2번 보기
SELECT X.서비스ID, X.서비스명, X.서비스URL
FROM 서비스 X
WHERE NOT EXISTS (SELECT 1 
                  FROM (SELECT 서비스ID
                        FROM 서비스
                        MINUS
                        SELECT 서비스ID
                        FROM 서비스이용) Y
                  WHERE X.서비스ID=Y.서비스ID)

-- 3번 보기
SELECT B.서비스ID, A.서비스명, A.서비스URL
FROM 서비스 A LEFT OUTER JOIN 서비스이용 B
ON (A.서비스ID=B.서비스ID)
WHERE B.서비스ID IS NULL
GROUP BY B.서비스ID, A.서비스명, A.서비스URL

-- 4번 보기
SELECT A.서비스ID, A.서비스명, A.서비스URL
FROM 서비스 A
WHERE 서비스ID IN (SELECT 서비스ID
                 FROM 서비스이용
                 MINUS
                 SELECT 서비스ID
                 FROM 서비스)

SELECT A.서비스ID, A.서비스명, A.서비스URL
FROM 서비스 A
WHERE 서비스ID NOT IN (SELECT 서비스ID
                 FROM 서비스
                 MINUS
                 SELECT 서비스ID
                 FROM 서비스이용)

/*
 * p.69 56번 문제
 */
WITH TBL1 AS (
    SELECT 'AA' AS COL1, 'A1' AS COL2 FROM DUAL UNION ALL
    SELECT 'AB', 'A2' FROM DUAL
), TBL2 AS (
    SELECT 'AA' AS COL1, 'A1' AS COL2 FROM DUAL UNION ALL
    SELECT 'AB', 'A2' FROM DUAL UNION ALL
    SELECT 'AC', 'A3' FROM DUAL UNION ALL
    SELECT 'AD', 'A4' FROM DUAL
)
SELECT COL1, COL2, COUNT(*) AS CNT
FROM (SELECT COL1, COL2
      FROM TBL1
      UNION ALL
      SELECT COL1, COL2
      FROM TBL2
      UNION
      SELECT COL1, COL2
      FROM TBL1)
GROUP BY COL1, COL2;