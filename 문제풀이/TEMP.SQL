
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