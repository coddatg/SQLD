--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------



SELECT
	lower('SQL Expert'),
	upper('SQL Expert'),
	ascii('A'),
	chr(65),
	concat('SQL', ' Expert'), -- 2개까지만
	length('SQL Expert')
FROM dual;


SELECT
	ltrim('xxxYYYZZxYZ', 'x'),
	ltrim('xxxYYYZZxYZ', 'xY'),
	ltrim('xxxYYYZZxYZ', 'xYZ'),
	ltrim('   xxxx'),
	rtrim('xxxYYYZZxYZ', 'ZY'),
	rtrim('xxxx    '),
	trim('  xxxx    '),
	trim('x' FROM 'xxxxYYYzzYZxxxx'),
	trim(BOTH 'x' FROM 'xxxxYYYzzYZxxxx'),
	trim(LEADING 'x' FROM 'xxxxYYYzzYZxxxx'),
	trim(TRAILING 'x' FROM 'xxxxYYYzzYZxxxx')
FROM dual;
 	