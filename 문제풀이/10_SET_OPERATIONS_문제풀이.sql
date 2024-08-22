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
 * 55번 문제 예시 테이블
 */

 WITH 서비스 AS (
    SELECT 1 AS 서비스ID, '온라인 쇼핑' AS 서비스명, 'http://shop.example.com' AS 서비스URL FROM dual UNION ALL
    SELECT 2, '비디오 스트리밍', 'http://video.example.com' FROM dual UNION ALL
    SELECT 3, '뉴스 웹사이트', 'http://news.example.com' FROM dual UNION ALL
    SELECT 4, '클라우드 스토리지', 'http://cloud.example.com' FROM dual UNION ALL
    SELECT 5, '온라인 교육', 'http://edu.example.com' FROM dual
), 회원 AS (
    SELECT 101 AS 회원ID, '김철수' AS 회원명 FROM dual UNION ALL
    SELECT 102, '이영희' FROM dual UNION ALL
    SELECT 103, '박지민' FROM dual UNION ALL
    SELECT 105, '정하늘' FROM dual
), 서비스이용 AS (
    SELECT 1 AS 서비스ID, 101 AS 회원ID, TO_DATE('2024-08-21 10:00:00', 'YYYY-MM-DD HH24:MI:SS') AS 이용일시 FROM dual UNION ALL
    SELECT 1, 102, TO_DATE('2024-08-21 11:00:00', 'YYYY-MM-DD HH24:MI:SS') FROM dual UNION ALL
    SELECT 2, 101, TO_DATE('2024-08-22 14:30:00', 'YYYY-MM-DD HH24:MI:SS') FROM dual UNION ALL
    SELECT 2, 103, TO_DATE('2024-08-22 15:45:00', 'YYYY-MM-DD HH24:MI:SS') FROM dual UNION ALL
    SELECT 3, 102, TO_DATE('2024-08-23 09:00:00', 'YYYY-MM-DD HH24:MI:SS') FROM dual UNION ALL
    SELECT 3, 103, TO_DATE('2024-08-23 10:30:00', 'YYYY-MM-DD HH24:MI:SS') FROM dual
)

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

