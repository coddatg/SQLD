
-- p.73 60번 문제
WITH TAB1 AS (
    SELECT 1 as C1, NULL AS C2, 'A' AS C3 FROM dual UNION ALL
    SELECT 2, 1, 'B' FROM dual UNION ALL
    SELECT 3, 1, 'C' FROM dual UNION ALL
    SELECT 4, 2, 'D' FROM dual
)
SELECT C3
FROM TAB1
START WITH C2 IS NULL
CONNECT BY PRIOR C1=C2
ORDER SIBLINGS BY C3 DESC;

-- p.74 62번 문제
WITH 사원 AS (
    SELECT '001' AS 사원번호, '홍길동' AS 사원명,
        TO_DATE('2012-01-01', 'YYYY-MM-DD') AS 입사일자,
        NULL AS 매니저사원번호
    FROM DUAL UNION ALL
    SELECT '002', '강감찬', TO_DATE('2012-01-01', 'YYYY-MM-DD'), 001 FROM dual UNION ALL
    SELECT '003', '이순신', TO_DATE('2013-01-01', 'YYYY-MM-DD'), 001 FROM dual UNION ALL
    SELECT '004', '이민정', TO_DATE('2013-01-01', 'YYYY-MM-DD'), 001 FROM dual UNION ALL
    SELECT '005', '이병헌', TO_DATE('2013-01-01', 'YYYY-MM-DD'), NULL FROM dual UNION ALL
    SELECT '006', '안성기', TO_DATE('2014-01-01', 'YYYY-MM-DD'), 005 FROM dual UNION ALL
    SELECT '007', '이수근', TO_DATE('2014-01-01', 'YYYY-MM-DD'), 005 FROM dual UNION ALL
    SELECT '008', '김병만', TO_DATE('2014-01-01', 'YYYY-MM-DD'), 005 FROM dual
)
SELECT 사원번호, 사원명, 입사일자, 매니저사원번호
FROM 사원
START WITH 매니저사원번호 IS NULL
CONNECT BY PRIOR 사원번호=매니저사원번호
AND 입사일자 BETWEEN '2013-01-01' AND '2013-12-31'
ORDER SIBLINGS BY 사원번호;


-- p.75 64번 문제
WITH 부서 AS (
    SELECT 100 부서코드, '아시아지부' 부서명, NULL 상위부서코드 FROM dual UNION ALL
    SELECT 110, '한국지사', 100 FROM dual UNION ALL
    SELECT 111, '서울지점', 110 FROM dual UNION ALL
    SELECT 112, '부산지점', 110 FROM dual UNION ALL
    SELECT 120, '일본지사', 100 FROM dual UNION ALL
    SELECT 121, '도쿄지점', 120 FROM dual UNION ALL
    SELECT 122, '오사카지점', 120 FROM dual UNION ALL
    SELECT 130, '중국지사', 100 FROM dual UNION ALL
    SELECT 131, '베이징지점', 130 FROM dual UNION ALL
    SELECT 132, '상하이지점', 130 FROM dual UNION ALL
    SELECT 200, '남유럽지부', NULL FROM dual UNION ALL
    SELECT 210, '스페인지사', 200 FROM dual UNION ALL
    SELECT 211, '마드리드지점', 210 FROM dual UNION ALL
    SELECT 212, '그라나다지점', 210 FROM dual UNION ALL
    SELECT 220, '포르투갈지사', 200 FROM dual UNION ALL
    SELECT 221, '리스본지점', 220 FROM dual UNION ALL
    SELECT 222, '포르투지점', 220 FROM dual
)
-- 1번 보기
SELECT 부서코드, 부서명, 상위부서코드, LEVEL
FROM 부서
START WITH 부서코드=120
CONNECT BY PRIOR 부서코드=상위부서코드
UNION
SELECT 부서코드, 부서명, 상위부서코드, LEVEL
FROM 부서
START WITH 부서코드=120
CONNECT BY 부서코드=PRIOR 상위부서코드
ORDER BY 부서코드

-- 2번 보기
SELECT 부서코드, 부서명, 상위부서코드, LEVEL
FROM 부서
START WITH 부서코드=100
CONNECT BY PRIOR 상위부서코드=부서코드

-- 3번 보기
SELECT 부서코드, 부서명, 상위부서코드, LEVEL
FROM 부서
START WITH 부서코드=121
CONNECT BY PRIOR 상위부서코드=부서코드

-- 4번 보기
SELECT 부서코드, 부서명, 상위부서코드, LEVEL
FROM 부서
START WITH 부서코드=(SELECT 부서코드
FROM 부서
WHERE 상위부서코드 IS NULL
START WITH 부서코드=120
CONNECT BY PRIOR 상위부서코드=부서코드
)
CONNECT BY 상위부서코드=PRIOR 부서코드


