



SELECT
	to_number('11'),
	to_char(19),
	to_char(SYSDATE, 'YYYY/MM/DD'),
	to_char(SYSDATE, 'YYYY, MON, DAY'),
	to_date('2024.06.11', 'YYYY.MM.DD')
FROM dual;
 	