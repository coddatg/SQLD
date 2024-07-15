SELECT getdate(),
       getdate()+1.0,
       getdate()+1.0/24,
       getdate()+1.0/24/60;

SELECT YEAR(getdate());

SELECT MONTH(getdate());

SELECT DAY(getdate());


SELECT '2006-04-25T15:50:59.997' AS UnconvertedText,
    CAST('2006-04-25T15:50:59.997' AS DATETIME) AS UsingCast,
    CONVERT(DATETIME, '2006-04-25T15:50:59.997', 127) AS UsingConvertFrom_ISO8601;
    
   
 select cast(20 AS varchar(10)),
 		convert(varchar(10),20),
 		CAST(cast('2006-04-25 15:50:59.997' as datetime) AS CHAR),
 		CONVERT(CHAR, '2006-04-25 15:50:59.997', 120)

/* 
 * 변환형 함수
 */

-- CAST ( expression AS data_type [ ( length ) ] )
-- CONVERT ( data_type [ ( length ) ] , expression [ , style ] )

SELECT
	CAST(20 AS VARCHAR(10)), -- 숫자 -> 문자
    CONVERT(VARCHAR(10), 20),
    CAST('20' AS INT), -- 문자 -> 숫자
    CONVERT(INT, '20.99'),
    CAST('20.99' AS FLOAT),
	CONVERT(DATETIME, '2006-04-25T15:50:59.997'), -- 문자 -> 날짜
	CAST('2006-04-25T15:50:59.997' AS DATETIME),
	CONVERT(CHAR, getdate(), 120), -- 날짜 -> 문자
	CAST(getdate() AS CHAR)


