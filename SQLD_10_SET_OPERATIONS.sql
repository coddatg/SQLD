--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/FGmid
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------



-- 봄 학기와 가을 학기 모두 수강 신청한 학생
SELECT student_id
FROM enrollment
WHERE semester = TO_DATE('2024-03-01', 'YYYY-MM-DD')
INTERSECT
SELECT student_id
FROM enrollment
WHERE semester = TO_DATE('2024-09-01', 'YYYY-MM-DD');

-- 봄 학기 또는 가을 학기 수강 신청한 학생
SELECT student_id
FROM enrollment
WHERE semester = TO_DATE('2024-03-01', 'YYYY-MM-DD')
UNION
SELECT student_id
FROM enrollment
WHERE semester = TO_DATE('2024-09-01', 'YYYY-MM-DD');

-- 봄 학기 또는 가을 학기 수강 신청한 학생(중복 포함)
SELECT student_id
FROM enrollment
WHERE semester = TO_DATE('2024-03-01', 'YYYY-MM-DD')
UNION ALL
SELECT student_id
FROM enrollment
WHERE semester = TO_DATE('2024-09-01', 'YYYY-MM-DD');

-- 봄 학기에 수강 신청했지만 가을 학기에 수강 신청하지 않은 학생
SELECT student_id
FROM enrollment
WHERE semester = TO_DATE('2024-03-01', 'YYYY-MM-DD')
MINUS
SELECT student_id
FROM enrollment
WHERE semester = TO_DATE('2024-09-01', 'YYYY-MM-DD');

--------------------------------------------------------

-- 칼럼 수가 동일하고, 데이터 타입도 동일해야 한다.
SELECT student_id, semester
FROM enrollment
WHERE semester = TO_DATE('2024-03-01', 'YYYY-MM-DD')
UNION
SELECT student_id
FROM enrollment
WHERE semester = TO_DATE('2024-09-01', 'YYYY-MM-DD');
ORDER BY 1

SELECT student_id, semester
FROM enrollment
WHERE semester = TO_DATE('2024-03-01', 'YYYY-MM-DD')
UNION
SELECT semester, student_id
FROM enrollment
WHERE semester = TO_DATE('2024-09-01', 'YYYY-MM-DD');
ORDER BY 1

-- ORDER BY는 가장 아래쪽에 하나만 쓸 수 있다.
SELECT student_id, semester
FROM enrollment
WHERE semester = TO_DATE('2024-03-01', 'YYYY-MM-DD')
-- ORDER BY 1
UNION ALL
SELECT semester, student_id
FROM enrollment
WHERE semester = TO_DATE('2024-09-01', 'YYYY-MM-DD');
-- ORDER BY 1
UNION
SELECT semester, student_id
FROM enrollment
WHERE semester = TO_DATE('2024-09-01', 'YYYY-MM-DD');
ORDER BY 1

------------------------------------------------------
-- 한국데이터산업진흥원 SQL 자격검정 실전문제 55번
-- 같은 결과 쿼리 찾기

-- 2024 봄학기에 등록된 수업
CREATE VIEW v_intersect AS
SELECT course_id
FROM course
INTERSECT
SELECT course_id
FROM enrollment
WHERE semester=TO_DATE('2024-03-01', 'YYYY-MM-DD');

SELECT b.course_id, b.title
FROM  v_intersect a, course b
WHERE a.course_id=b.course_id

---------------------------------------------------------
-- EXISTS와 IN 이용

SELECT a.course_id, a.title
FROM course a
WHERE EXISTS (SELECT 1
			  FROM v_intersect x
		      WHERE a.course_id = x.course_id)
	 
SELECT course_id, title
FROM course
WHERE course_id IN (SELECT * FROM v_intersect);

---------------------------------------------------------
-- 집합의 특수성과 부정 연산 이용

CREATE VIEW v_minus AS
SELECT course_id
FROM course
MINUS
SELECT course_id
FROM enrollment
WHERE semester = TO_DATE('2024-03-01', 'YYYY-MM-DD');

SELECT a.course_id, a.title
FROM course a
WHERE NOT EXISTS (SELECT 1
				  FROM v_minus x
				  WHERE a.course_id = x.course_id)
		
SELECT course_id, title
FROM course
WHERE course_id NOT IN (SELECT * FROM v_minus);

DROP VIEW v_intersect;
DROP VIEW v_minus;

----------------------------------------------------------
-- JOIN 이용

SELECT DISTINCT
	b.course_id, a.title
FROM course a
INNER JOIN enrollment b
ON a.course_id = b.course_id
	AND b.semester=TO_DATE('2024-03-01', 'YYYY-MM-DD');

SELECT DISTINCT
	b.course_id, a.title
FROM course a
LEFT JOIN enrollment b
ON a.course_id = b.course_id
	AND b.semester=TO_DATE('2024-03-01', 'YYYY-MM-DD')
WHERE b.course_id IS NOT NULL;