--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

-- p.37 12번 문제
SELECT
	LOWER('SQL Expert'),
	UPPER('SQL Expert'),
	ASCII('A'),
	LTRIM('xxYYZZxYZxx', 'x')
FROM dual

-- p.45 24번 문제
SELECT
	ROUND(4.875, 2),
	LENGTH('KOREAN'),
--  DATE_FORMAT('2022-11-02', '%Y-%m-%d'), MYSQL 함수
	TO_DATE('2022-11-02', 'YYYY-MM-DD'),
	SUBSTR('Gangneung Wonju', 8, 4)
FROM dual


-- p.39 15번 문제
WITH TAB1 AS(
	SELECT 'A'||CHR(10)||'A' AS C1 FROM dual UNION ALL
	SELECT 'B'||CHR(10)||'B'||CHR(10)||'B' FROM dual
)
SELECT sum(CC)
FROM (
	SELECT length(c1),
		LENGTH(REPLACE(c1, chr(10))),
		(length(c1) - LENGTH(REPLACE(c1, chr(10))) + 1) CC 
	FROM tab1
)

-- p.40 16번 문제
SELECT TO_CHAR(
	TO_DATE('2023.01.10 10', 'YYYY.MM.DD HH24') + 1/24/(60/10), 
	'YYYY.MM.DD HH24.MI.SS')
FROM dual;

-- p.50 30번 문제
SELECT TO_CHAR(
	TO_DATE('2019.02.25', 'YYYY.MM.DD') + 1/12/(60/30), 
	'YYYY.MM.DD HH24.MI.SS')
FROM dual;

-- p.38 13번 문제
WITH SVC_JOIN AS (
	SELECT 'CUST0001' AS CUST_ID, 'SVC0001' AS SVC_ID,
		'20141201' AS JOIN_YMD, '00' AS JOIN_HH,
		TO_DATE('2015-01-11', 'YYYY-MM-DD') AS SVC_START_DATE,
		TO_DATE('2015-01-30', 'YYYY-MM-DD') AS SVC_END_DATE 
	FROM dual UNION ALL
	SELECT 'CUST0002', 'SVC0002', '20141201', '00', 
		TO_DATE('2014-12-31', 'YYYY-MM-DD'), TO_DATE('2015-01-02', 'YYYY-MM-DD')
	FROM dual UNION ALL
	SELECT 'CUST0003', 'SVC0003', '20141201', '00', 
		TO_DATE('2014-12-10', 'YYYY-MM-DD'), TO_DATE('2015-01-31', 'YYYY-MM-DD')
	FROM dual 
)
SELECT svc_id, count(*) AS cnt
FROM svc_join
WHERE TO_DATE('201501','YYYYMM') = SVC_END_DATE
	AND join_ymd||join_HH = '2014120100'
GROUP BY svc_id

/*
SELECT svc_id, count(*) AS cnt
FROM svc_join
WHERE svc_end_date >= TO_DATE('20150101000000', 'YYYYMMDDHH24MISS')
	AND svc_end_date <= TO_DATE('20150131235959', 'YYYYMMDDHH24MISS')
	AND concat(join_ymd, join_hh) = '2014120100'
GROUP BY svc_id

SELECT svc_id, count(*) AS cnt
FROM svc_join
WHERE svc_end_date >= TO_DATE('20150101', 'YYYYMMDD')
	AND svc_end_date < TO_DATE('20150201', 'YYYYMMDD')
	AND (join_ymd, join_hh) IN (('20141201', '00'))
GROUP BY svc_id

SELECT svc_id, count(*) AS cnt
FROM svc_join
WHERE '201501' = TO_CHAR(svc_end_date, 'YYYYMM')
	AND join_ymd = '20141201'
	AND join_HH = '00'
GROUP BY svc_id

SELECT svc_id, count(*) AS cnt
FROM svc_join
WHERE TO_DATE('201501','YYYYMM') = SVC_END_DATE
	AND join_ymd||join_HH = '2014120100'
GROUP BY svc_id

WITH temp AS (
	SELECT TO_DATE('20150111', 'YYYYMMDD') c1 FROM dual UNION ALL 
	SELECT TO_DATE('20150121', 'YYYYMMDD') FROM dual UNION ALL 
	SELECT TO_DATE('20150101', 'YYYYMMDD') FROM dual
)
*/


-- p.40 17번 문제
SELECT loc,
	CASE WHEN loc = 'NEW YORK' THEN 'EAST' ELSE 'ETC' END AS AREA1,
	CASE loc WHEN 'NEW YORK' THEN 'EAST' ELSE 'ETC' END AS AREA2,
	DECODE(loc, 'NEW YORK', 'EAST', 'ETC') AS AREA3
FROM dept


-- p.41 18번 문제
SELECT team_id,
	isnull(sum(CASE WHEN POSITION='FW' THEN 1 END), 0),
	sum(CASE POSITION WHEN 'FW' THEN 1 END),
	sum(CASE POSITION WHEN 'FW' THEN 1 ELSE 1 END)
FROM player
GROUP BY team_id;


-- p.42 20번 문제

SELECT ename, empno, mgr
	, (mgr, 7698) AS NM
FROM emp
-- WHERE	mgr=7698
	
	
-- p.50 31번 문제
	
SELECT coalesce(NULL, 'A') FROM dual;
SELECT nullif('A', 'A') FROM dual;
SELECT nvl('A', NULL) FROM dual;
SELECT nvl(NULL, 0) + 10 FROM dual;