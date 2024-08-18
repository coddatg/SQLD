

-- p.46 25번 문제
WITH Ad AS (
    SELECT 1 AS ad_id, 'Spring Sale' AS ad_name FROM dual UNION ALL
    SELECT 2, 'Summer Festival' FROM dual UNION ALL
    SELECT 3, 'Winter Clearance' FROM dual UNION ALL
    SELECT 4, 'Autumn Special' FROM dual
), Media AS (
    SELECT 1 AS media_id, 'Facebook' AS media_name FROM dual UNION ALL
    SELECT 2, 'Google' FROM dual UNION ALL
    SELECT 3, 'Instagram' FROM dual UNION ALL
    SELECT 4, 'Twitter' FROM dual
),AdPost AS (
    SELECT 1 AS post_id, 1 AS ad_id, 1 AS media_id, 
        '2024-07-01' AS start_date, '2024-07-15' AS end_date
    FROM dual UNION ALL
    SELECT 2, 2, 2, '2024-08-01', '2024-08-31' FROM dual UNION ALL
    SELECT 3, 3, 3, '2024-12-01', '2024-12-31' FROM dual UNION ALL
    SELECT 4, 1, 2, '2024-07-16', '2024-07-31' FROM dual UNION ALL
    SELECT 5, 4, 1, '2024-09-01', '2024-09-15' FROM dual UNION ALL 
    SELECT 6, 2, 3, '2024-10-01', '2024-10-31' FROM dual UNION ALL
    SELECT 7, 3, 2, '2024-11-01', '2024-11-15' FROM dual UNION ALL
    SELECT 8, 4, 4, '2024-07-10', '2024-07-20' FROM dual
), D AS (
    -- 정답은 2번
	SELECT media_id, min(start_date) AS start_date
	FROM adpost
	GROUP BY media_id
)
-- 광고매체ID 별 최초로 게시한 광고명과 광고시작일자
SELECT C.media_name, B.ad_name, A.start_date
FROM adpost A, ad B, media C, D
WHERE A.start_date = D.start_date AND A.media_id = D.media_id 
AND A.ad_id=B.ad_id
AND A.media_id=C.media_id
ORDER BY media_name, start_date
/*
-- 연관 서브쿼리를 이용한 쿼리
SELECT C.media_name, B.ad_name, A.start_date
FROM adpost A, ad B, media C
WHERE A.start_date = (SELECT min(D.start_date) AS start_date
	FROM   adpost D
	WHERE  D.media_id=C.media_id
	GROUP BY D.media_id) 
AND A.ad_id=B.ad_id
AND A.media_id=C.media_id
ORDER BY media_name, start_date
*/

/*
-- 1번 보기
SELECT D.media_id, min(D.start_date) AS start_date
FROM   adpost D
WHERE  D.media_id=C.media_id
GROUP BY D.media_id

-- 2번 보기
SELECT media_id, min(start_date) AS start_date
FROM adpost
GROUP BY media_id

-- 3번 보기
SELECT min(media_id) AS media_id, min(start_date) AS start_date
FROM adpost
GROUP BY ad_id

-- 4번 보기
SELECT min(media_id) AS media_id, min(start_date) AS start_date
FROM adpost
*/


-- p.83 70번 문제

WITH Members AS (
    SELECT 1 AS MemberID, 'Alice' AS MemberName FROM DUAL UNION ALL
    SELECT 2, 'Bob' FROM DUAL UNION ALL
    SELECT 3, 'Charlie' FROM DUAL
),
Terms AS (
    SELECT 1 AS TermsCode, 'Privacy Policy' AS TermsName FROM DUAL UNION ALL
    SELECT 2, 'Terms of Service' FROM DUAL UNION ALL
    SELECT 3, 'Cookie Policy' FROM DUAL
),
Consent AS (
    SELECT 1 AS MemberID, 1 AS TermsCode, 'Y' AS ConsentStatus, TO_DATE('2024-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS') AS ConsentDateTime FROM DUAL UNION ALL
    SELECT 1, 2, 'N', TO_DATE('2024-01-01 10:05:00', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL UNION ALL
    SELECT 2, 1, 'Y', TO_DATE('2024-02-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL UNION ALL
    SELECT 2, 3, 'Y', TO_DATE('2024-02-01 11:05:00', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL UNION ALL
    SELECT 3, 2, 'N', TO_DATE('2024-03-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL UNION ALL
    SELECT 3, 3, 'Y', TO_DATE('2024-03-01 12:05:00', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
)
SELECT A.MemberID, A.MemberName
FROM Members A, Consent B
WHERE A.MemberID=b.MemberID
GROUP BY A.MemberID, A.MemberName
HAVING COUNT(CASE WHEN b.ConsentStatus='N' 
 		THEN 0 ELSE NULL END) >= 1
ORDER BY A.MemberID

-- 보기 1
SELECT A.MemberID, A.MemberName
FROM Members A
WHERE EXISTS 
(SELECT 1 FROM Consent B 
WHERE A.MemberID=B.MemberID 
AND B.ConsentStatus='N')
ORDER BY A.MemberID

-- 보기 2
SELECT MemberID, MemberName
FROM Members
WHERE MemberID IN 
(SELECT MemberID 
FROM Consent
WHERE ConsentStatus='N')
ORDER BY MemberID

-- 보기 3
SELECT A.MemberID, A.MemberName
FROM Members A
WHERE 0 < (SELECT count(*) FROM Consent B 
WHERE B.ConsentStatus='N')
ORDER BY A.MemberID

-- 보기 4
SELECT A.MemberID, A.MemberName
FROM Members A, Consent B
WHERE A.MemberID=B.MemberID AND B.ConsentStatus='N'
GROUP BY A.MemberID, A.MemberName
ORDER BY A.MemberID

-- p.84 71번 문제
SELECT A.회원ID, A.회원명, A.이메일
FROM   회원 A
------------ ㄱ
WHERE  EXISTS (SELECT 'X'
               FROM   이벤트 B, 메일발송 C
               WHERE  B.시작일자 >= '2014.10.01'
               AND    B.이벤트ID=C.이벤트ID
------------ ㄴ
               AND    A.회원ID=C.회원ID
------------ ㄷ
               HAVING COUNT(*) < (SELECT COUNT(*)
                                  FROM   이벤트
                                  WHERE  시작일자 >= '2014.10.01'));


-- p.86 74번 문제
-- 평가대상상품에 대한 품질평가항목별 최종 평가결과를 출력하는 SQL로 가장 적절한 것

-- 1번 보기
SELECT B.상품ID, B.상품명, C.평가항목ID, C.평가항목명, 
    A.평가회차, A.평가등급, A.평가일자
FROM 평가결과 A, 평가대상상품 B, 품질평가항목 C,
    (SELECT MAX(평가회차) AS 평가회차 FROM 평가결과) D
WHERE A.상품ID=B.상품ID
AND   A.평가항목ID=C.평가항목ID
AND   A.평가회차=D.평가회차

SELECT B.상품ID, B.상품명, C.평가항목ID, C.평가항목명, 
    A.평가회차, A.평가등급, A.평가일자
FROM 평가결과 A, 평가대상상품 B, 품질평가항목 C,
    (SELECT 상품ID, 평가항목ID, MAX(평가회차) AS 평가회차 
     FROM 평가결과
     GROUP BY 상품ID, 평가항목ID) D
WHERE A.상품ID=B.상품ID
AND   A.평가항목ID=C.평가항목ID
AND   A.평가회차=D.평가회차
AND   A.상품ID=D.상품ID
AND   B.평가항목ID=D.평가항목ID

-- 2번 보기
SELECT B.상품ID, B.상품명, C.평가항목ID, C.평가항목명, 
    A.평가회차, A.평가등급, A.평가일자
FROM 평가결과 A, 평가대상상품 B, 품질평가항목 C
WHERE A.상품ID=B.상품ID
AND   A.평가항목ID=C.평가항목ID
AND   A.평가회차=(SELECT MAX(X.평가회차)
                FROM 평가결과 X
                WHERE X.상품ID=B.상품ID
                AND   X.평가항목ID=C.평가항목ID)

-- 3번 보기
SELECT B.상품ID, B.상품명, C.평가항목ID, C.평가항목명, 
    MAX(A.평가회차) AS 평가회차, MAX(A.평가등급) AS 평가등급, MAX(A.평가일자) AS 평가일자
FROM 평가결과 A, 평가대상상품 B, 품질평가항목 C
WHERE A.상품ID=B.상품ID
AND   A.평가항목ID=C.평가항목ID
GROUP BY B.상품ID, B.상품명, C.평가항목ID, C.평가항목명

-- 4번 보기
SELECT B.상품ID, B.상품명, C.평가항목ID, C.평가항목명, 
    A.평가회차, A.평가등급, A.평가일자
FROM (SELECT 상품ID, 평가항목ID, 
             MAX(평가회차) AS 평가회차, 
             MAX(평가등급) AS 평가등급,
             MAX(평가일자) AS 평가일자
      FROM 평가결과
      GROUP BY 상품ID, 평가항목ID) A, 평가대상상품 B, 품질평가항목 C
WHERE A.상품ID=B.상품ID
AND   A.평가항목ID=C.평가항목ID
AND   A.평가회차=D.평가회차

-- 노랭이 76번 문제풀이
WITH TBL AS (
    SELECT 'A' AS C1, 100 AS C2 FROM DUAL UNION ALL
    SELECT 'B', 200 FROM DUAL UNION ALL
    SELECT 'B', 100 FROM DUAL UNION ALL
    SELECT 'B', NULL FROM DUAL UNION ALL
    SELECT NULL, 200 FROM DUAL
) V_TBL AS (
    SELECT * FROM TBL
    WHERE C1='B' OR C1 IS NULL
)
SELECT SUM(C2) C2
FROM V_TBL
WHERE C2 >= 200 AND C1 = 'B'