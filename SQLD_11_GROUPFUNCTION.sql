--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/FGmid
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

/*
 * 그룹 함수
 * 
 * 선수 지식: GROUP BY
 */

SELECT a, b, c, d, num
FROM sales;

SELECT a, b, sum(num)
FROM sales
GROUP BY GROUPING SETS (a, b)
ORDER BY 1, 2;

SELECT a, b, c, sum(num)
FROM sales
GROUP BY GROUPING SETS (a, b, c)
ORDER BY 1, 2, 3;

-- grouping sets -> group by와 union으로 바꿀 수 있다.
SELECT a, NULL, sum(num)
FROM sales
GROUP BY a
UNION ALL
SELECT NULL, b, sum(num)
FROM sales
GROUP BY b

SELECT a, NULL, sum(num)
FROM sales
GROUP BY a
UNION ALL
SELECT NULL, b, sum(num)
FROM sales
GROUP BY b;

-- group by a
-- union all
-- group by b

SELECT a, NULL, NULL, sum(num)
FROM sales
GROUP BY a
UNION ALL
SELECT NULL, b, NULL, sum(num)
FROM sales
GROUP BY b
UNION ALL
SELECT NULL, NULL, c, sum(num)
FROM sales
GROUP BY c

-- group by a
-- union all
-- group by b
-- union all
-- group by c

SELECT a, NULL ,NULL, sum(num)
FROM sales
GROUP BY a
UNION ALL
SELECT NULL, b, NULL, sum(num)
FROM sales
GROUP BY b
UNION ALL
SELECT NULL, NULL, c, sum(num)
FROM sales
GROUP BY c


-- 묶음 표현
SELECT a, b, c, sum(num)
FROM sales
GROUP BY GROUPING SETS ((a, b), c)
ORDER BY 1, 2, 3;

-- group by a, b
-- union all
-- group by c

SELECT a, b, NULL, sum(num)
FROM sales
GROUP BY a, b
UNION ALL
SELECT NULL, NULL, c, sum(num)
FROM sales
GROUP BY c

---------------------------------------------
-- rollup
SELECT a, b, sum(num)
FROM sales
GROUP BY rollup(a, b)
-- ORDER BY 1, 2;

SELECT a, b, sum(num)
FROM sales
GROUP BY a, b
UNION ALL
SELECT a, NULL, sum(num)
FROM sales
GROUP BY a
UNION ALL
SELECT NULL, NULL, sum(num)
FROM sales;

SELECT a, b, sum(num)
FROM sales
GROUP BY GROUPING SETS ((a, b), a, ());


---------------------------------------------
-- cube
SELECT a, b, sum(num)
FROM sales
GROUP BY cube(a, b)
ORDER BY 1, 2;

SELECT a, b, sum(num)
FROM sales
GROUP BY a, b
UNION ALL
SELECT a, NULL, sum(num)
FROM sales
GROUP BY a
UNION ALL
SELECT NULL, b, sum(num)
FROM sales
GROUP BY b
UNION ALL
SELECT NULL, NULL, sum(num)
FROM sales
ORDER BY 1, 2;

SELECT a, b, sum(num)
FROM sales
GROUP BY GROUPING sets((a, b), a, b, ())
ORDER BY 1, 2;

-----------------------------------------------
-- 다양한 변형들
SELECT a, b, c, d, sum(num)
FROM sales
GROUP BY GROUPING SETS (a, ROLLUP(b, c), d)
ORDER BY 1, 2, 3, 4;

SELECT a, b, c, d, sum(num)
FROM sales
GROUP BY GROUPING SETS (a, (b, c), b, (), d)
ORDER BY 1, 2, 3, 4;

--
SELECT a, b, c, d, sum(num)
FROM sales
GROUP BY GROUPING SETS (a, CUBE(b, c), d)
ORDER BY 1, 2, 3, 4;

SELECT a, b, c, d, sum(num)
FROM sales
GROUP BY GROUPING SETS (a, (b, c), b, c, (), d)
ORDER BY 1, 2, 3, 4;

--
SELECT a, b, c, d, sum(num)
FROM sales
GROUP BY GROUPING SETS (a, CUBE(b), c, d)
ORDER BY 1, 2, 3, 4;

SELECT a, b, c, d, sum(num)
FROM sales
GROUP BY GROUPING SETS (a, b, (), c, d)
ORDER BY 1, 2, 3, 4;

--
SELECT a, b, c, d, sum(num)
FROM sales
GROUP BY GROUPING SETS (a, rollup(b, c, d))
ORDER BY 1, 2, 3, 4;

SELECT a, b, c, d, sum(num)
FROM sales
GROUP BY GROUPING SETS (a, (b, c, d), (b, c), b, ())
ORDER BY 1, 2, 3, 4;

--
SELECT a, b, c, d, sum(num)
FROM sales
GROUP BY a, b, rollup(c, d)
ORDER BY 1,

SELECT 
	a, GROUPING(a) grp_a, CASE GROUPING(a) WHEN 1 THEN 'all a' ELSE a END AS grp_a,
	b, GROUPING(b) grp_b, CASE GROUPING(b) WHEN 1 THEN 'all b' ELSE b END AS grp_b,
	c, GROUPING(c) grp_c, CASE GROUPING(c) WHEN 1 THEN 'all c' ELSE c END AS grp_c,
	d, GROUPING(d) grp_d, CASE GROUPING(d) WHEN 1 THEN 'all d' ELSE d END AS grp_d,
	sum(num)
FROM sales
GROUP BY rollup(a, b, c, d);


SELECT 
	CASE GROUPING(a) WHEN 1 THEN 'all a' ELSE a END AS grp_a,
	CASE GROUPING(b) WHEN 1 THEN 'all b' ELSE b END AS grp_b,
	CASE GROUPING(c) WHEN 1 THEN 'all c' ELSE c END AS grp_c,
	CASE GROUPING(d) WHEN 1 THEN 'all d' ELSE d END AS grp_d,
	sum(num)
FROM sales
GROUP BY rollup(a, b, c, d);


SELECT 
	CASE GROUPING(a) WHEN 1 THEN 'all a' ELSE a END AS grp_a,
	CASE GROUPING(b) WHEN 1 THEN 'all b' ELSE b END AS grp_b,
	sum(num)
FROM sales
GROUP BY rollup(a, b)
ORDER BY 1, 2;
