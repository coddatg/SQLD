
/*
 * p.71 58 번
 */
WITH 직원 AS (
      SELECT 'A001' 사원번호, '홍길동' 이름, 'GEN' 부서코드, '2019-01-01' 입사일, 1200000 급여 FROM DUAL UNION ALL
      SELECT 'A002', '일지매', 'MKT', '2019-01-12', 1840000 FROM DUAL UNION ALL
      SELECT 'A003', '심청', 'MKT', '2019-01-12', 2340000 FROM DUAL UNION ALL
      SELECT 'A004', '고길동', 'HRD', '2018-09-05', 3500000 FROM DUAL UNION ALL
      SELECT 'A005', '이국', 'ACC', '2011-07-07', 2300000 FROM DUAL UNION ALL
      SELECT 'A006', '동치성', 'STG', '2004-12-14', 3560000 FROM DUAL UNION ALL
      SELECT 'A007', '손오공', 'MKT', '2015-11-10', 4500000 FROM DUAL UNION ALL
      SELECT 'A008', '사오정', 'HRD', '2018-07-18', 3200000 FROM DUAL UNION ALL
      SELECT 'A009', '저팔계', 'SYS', '2011-03-03', 2180000 FROM DUAL UNION ALL
      SELECT 'A009', '장길산', 'SYS', '2019-01-23', 1780000 FROM DUAL
)
SELECT * FROM 직원 WHERE 부서코드 IN ('MKT', 'HRD') ORDER BY 3;

-- 1번
SELECT A.부서코드, A.사원번호, A.급여,
	ROUND(ratio_to_report(급여) OVER (PARTITION BY 부서코드), 2) 급여비중
FROM (SELECT 사원번호, 이름, 부서코드, 급여, 
			sum(급여) OVER (PARTITION BY 부서코드) AS 부서급여합
	  FROM 직원
	  WHERE 부서코드 IN ('MKT', 'HRD')) A
ORDER BY A.부서코드, A.급여 DESC, A.사원번호;
-- 2번
SELECT A.부서코드, A.사원번호, A.급여,
	ROUND(급여/부서급여합, 2) 급여비중
FROM (SELECT 사원번호, 이름, 부서코드, 급여, 
			sum(급여) OVER (PARTITION BY 부서코드) AS 부서급여합
	  FROM 직원
	  WHERE 부서코드 IN ('MKT', 'HRD')) A
ORDER BY A.부서코드, A.급여 DESC, A.사원번호
-- 3번
SELECT A.부서코드, A.사원번호, A.급여,
	ROUND(급여/부서급여합, 2) 급여비중
FROM 직원 A, 
	(SELECT 부서코드, sum(급여) AS 부서급여합
	  FROM 직원
	  WHERE 부서코드 IN ('MKT', 'HRD')
	  GROUP BY 부서코드) B
WHERE A.부서코드=B.부서코드
AND A.부서코드 IN ('MKT', 'HRD')
ORDER BY A.부서코드, A.급여 DESC, A.사원번호
-- 4번
SELECT A.부서코드, A.사원번호, A.급여,
	ROUND(급여/부서급여합, 2) 급여비중
FROM (SELECT 사원번호, 이름, 부서코드, 급여, 
			sum(급여) OVER (PARTITION BY 부서코드 ORDER BY 사원번호) AS 부서급여합
	  FROM 직원
	  WHERE 부서코드 IN ('MKT', 'HRD')) A
ORDER BY A.부서코드, A.급여 DESC, A.사원번호


/*
 * p.89 77번
 */
WITH 사원 AS (
	SELECT '001' AS 사원ID, 100 AS 부서ID, 2500 AS 연봉 FROM dual UNION ALL
	SELECT '002', 100, 3000 FROM dual UNION ALL
	SELECT '003', 200, 4500 FROM dual UNION ALL
	SELECT '004', 200, 3000 FROM dual UNION ALL
	SELECT '005', 200, 2500 FROM dual UNION ALL
	SELECT '006', 300, 4500 FROM dual UNION ALL
	SELECT '007', 300, 3000 FROM dual
)
-- SELECT * FROM 사원;
SELECT 사원ID, COL2, COL3
FROM (SELECT 사원ID, 
			ROW_NUMBER() OVER (PARTITION BY 부서ID ORDER BY 연봉 DESC) AS COL1,
			SUM(연봉) OVER (PARTITION BY 부서ID ORDER BY 사원ID
						   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS COL2,
			MAX(연봉) OVER (ORDER BY 연봉 DESC ROWS CURRENT ROW) AS COL3
	  FROM 사원)
WHERE COL1=2
ORDER BY 1;


/*
 * p.96 85번
 */
SELECT 고객번호, 고객명, 매출액,
      RANK() OVER(ORDER BY 매출액 DESC) AS 순위
FROM (
      SELECT A.고객번호,
             MAX(A.고객명) AS 고객명,
             SUM(B.매출액) AS 매출액,
             FROM 고객 A INNER JOIN 월별매출 B
             ON (A.고객번호=B.고객번호)
             GROUP BY A.고객번호
      )
ORDER BY 순위;

/*
 * p.98 86번
 */
SELECT JOB, ENAME, SAL, COMM,
	DENSE_RANK() OVER (ORDER BY NVL(SAL, 0) + NVL(COMM, 0) DESC) RANK
FROM EMP;


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

/*
 * p.100 88번
 */
SELECT 상품분류코드, 
        AVG(상품가격) AS 상품가격,
        COUNT(*) OVER (ORDER BY AVG(상품가격)
                      RANGE BETWEEN 10000 PRECEDING 
                      AND 10000 FOLLOWING) AS 유사개수
FROM 상품
GROUP BY 상품분류코드

/*
 * p.101 89번
 */
WITH 사원 AS (
	SELECT '001' AS 사원ID, 100 AS 부서ID, '홍길동' AS 사원명, 2500 AS 연봉 FROM dual UNION ALL
	SELECT '002', 100, '강감찬', 3000 FROM dual UNION ALL
	SELECT '003', 200, '김유신', 4500 FROM dual UNION ALL
	SELECT '004', 200, '김선달', 3000 FROM dual UNION ALL
	SELECT '005', 200, '유학생', 2500 FROM dual UNION ALL
	SELECT '006', 300, '변사또', 4500 FROM dual UNION ALL
	SELECT '007', 300, '박문수', 3000 FROM dual
)
-- SELECT * FROM 사원;
SELECT Y.사원ID, Y.부서ID, Y.사원명, Y.연봉
FROM (SELECT 사원ID, MAX(연봉) OVER (PARTITION BY 부서ID) AS 최고연봉
	  FROM 사원) X, 사원 Y
WHERE X.사원ID = Y.사원ID
AND   X.최고연봉 = Y.연봉;


/*
 * p.102 90번
 */
SELECT EMPNO, HIREDATE, SAL, 
	  LAG(SAL) OVER (ORDER BY HIREDATE) AS SAL2
FROM EMP 
WHERE JOB='SALESMAN';


/*
 * p.108 98 번
 */
SELECT COL1, COL2,
      ______ () OVER (ORDER BY COL2) COL3
FROM TBL;