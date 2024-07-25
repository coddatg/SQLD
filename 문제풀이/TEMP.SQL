

SELECT A.고객ID, A.고객명, SUM(B.사용량*C.단가) AS 사용금액
FROM 고객 A
INNER JOIN 시간대별사용량 B
ON A.고객ID=B.고객ID
INNER JOIN 시간대구간 C
ON A.사용시간대 >= C.시작시간대
AND A.사용시간대 <= C.종료시간대
GROUP BY A.고객ID, A.고객명
