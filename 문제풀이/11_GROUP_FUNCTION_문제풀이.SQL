
-- p.66 52번 문제

-- 1번 보기
SELECT col1, sum(col2)
GROUP BY col1
UNION ALL
SELECT NULL, sum(col2)
-- 2번 보기
GROUP BY GROUPING SETS(COL1)
-- 3번 보기
GROUP BY ROLLUP(COL1)
GROUP BY GROUPING SETS(COL1, ())
-- 4번 보기
GROUP BY CUBE(COL1)
GROUP BY GROUPING SETS(COL1, ())


-- p.70 57번 문제

-- 1번 보기
GROUPING SETS(grade, (job, grade))
-- 2번 보기
ROLLUP(grade, job)
GROUPING SETS((grade, job), (grade), ())
-- 3번 보기
grade, ROLLUP(job)
GROUPING SETS( (grade, job), (grade) )
-- 4번 보기
grade, CUBE(job)
GROUPING SETS((grade, job), (grade))

-- p.90 79번 문제
SELECT 
    CASE GROUPING(B.지역명) WHEN 1 THEN '지역전체'
        ELSE B.지역명 END AS 지역명,
    CASE TO_CHAR(A.이용일시, 'YYYY.MM') WHEN 1 THEN '월별합계'
        ELSE TO_CHAR(A.이용일시, 'YYYY.MM') END AS 이용월
    SUM(이용량) AS 이용량
FROM 이용내역 A INNER JOIN 지역 B
ON A.지역ID=B.지역ID
GROUP BY ROLLUP(B.지역명, TO_CHAR(A.이용일시, 'YYYY.MM'))

-- p.93 80번 문제
-- 1번 보기
ROLLUP(DNAME, JOB)
GROUPING SETS((DNAME, JOB), (DNAME), ())
-- 2번 보기
CUBE(DNAME, JOB)
GROUPING SETS((DNAME, JOB), (DNAME), (JOB), ())
-- 3번 보기
GROUPING SETS((DNAME, JOB), DNAME)
-- 4번 보기
DNAME, ROLLUP(JOB)
GROUPING SETS((DNAME, JOB), (DNAME))


-- p.93 81번 문제
-- 1번 보기
GROUP BY CUBE((A.설비ID), (B.에너지코드), (A.설비ID, B.에너지코드))
-- 2번 보기
GROUP BY CUBE (A.설비ID, B.에너지코드)
-- 3번 보기
GROUP BY GROUPING SETS ((A.설비ID), (A.설비ID, B.에너지코드))
-- 4번 보기
GROUP BY GROUPING SETS ((A.설비ID), (B.에너지코드), 
                        (A.설비ID, B.에너지코드))


-- p.94 82번 문제
-- 1번 보기
ROLLUP(JOB, DEPTNO)
GROUPING SETS ( (JOB, DEPTNO), JOB, () )
-- 2번 보기
ROLLUP((JOB, DEPTNO))
ROLLUP(A)
GROUPING SETS((JOB, DEPTNO), ())
-- 3번 보기
ROLLUP((JOB), (DEPTNO))
GROUPING SETS ( (JOB, DEPTNO), JOB, () )
-- 4번 보기
JOB, ROLLUP(DEPTNO)
GROUPING SETS ( (JOB, DEPTNO), (JOB) )



-- p.95 83번 문제
GROUP BY GROUPING SETS((상품ID, 월))
GROUP BY 상품ID, 월
-- 1번 보기
GROUP BY GROUPING SETS(상품ID, 월)
GROUP BY 상품ID
GROUP BY 월
-- 2번 보기
-- 3번 보기
GROUP BY GROUPING SETS(상품ID, 월, ())
-- 4번 보기
GROUP BY GROUPING SETS((상품ID, 월), (월))


-- p.105 95번 문제
GROUP BY CUBE(X.keyb, Y.col1)

-- 1번 보기
GROUP BY ROLLUP(X.keyb, Y.col1)
-- 2번 보기
GROUP BY GROUPING SETS((X.keyb, Y.col1), X.keyb, Y.col1, ())
-- 3번 보기
GROUP BY GROUPING SETS (X.keyb, Y.col1)
-- 4번 보기
GROUP BY GROUPING SETS((X.keyb, Y.col1), X.keyb, Y.col1)














