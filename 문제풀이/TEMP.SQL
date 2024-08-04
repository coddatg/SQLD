
-- p.129 126번 문제

-- 1번
UPDATE 부서 A 
SET 담당자=(
    SELECT C.부서코드
    FROM (SELECT 부서코드, MAX(변경일자) AS 변경일자
          FROM 부서임시
          GROUP BY 부서코드) B, 부서임시 C
          WHERE B.부서코드=C.부서코드
          AND B.변경일자=C.변경일자
          AND A.부서코드=C.부서코드)

-- 2번
UPDATE 부서 A 
SET 담당자=(
    SELECT C.부서코드
    FROM (SELECT 부서코드, MAX(변경일자) AS 변경일자
          FROM 부서임시
          GROUP BY 부서코드) B, 부서임시 C
          WHERE B.부서코드=C.부서코드
          AND B.변경일자=C.변경일자
          AND A.부서코드=C.부서코드)
WHERE EXISTS (SELECT 1 FROM 부서 X WHERE A.부서코드=X.부서코드)

-- 3번
UPDATE 부서 A 
SET 담당자=(
    SELECT B.담당자
    FROM   부서임시 B
   	WHERE  B.부서코드=A.부서코드
   	AND    B.변경일자=(
   		   SELECT MAX(C.변경일자)
           FROM 부서임시 C
           WHERE C.부서코드=B.부서코드))
WHERE 부서코드 IN (SELECT 부서코드 FROM 부서임시);

-- 4번
UPDATE 부서 A 
SET 담당자=(
    SELECT B.담당자
    FROM 부서임시 B
    WHERE A.부서코드=B.부서코드
    AND B.변경일자='2015.01.25')