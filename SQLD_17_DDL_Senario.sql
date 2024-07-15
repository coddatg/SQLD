

SELECT * FROM student;

SELECT * from all_tab_columns where table_name='STUDENT';
SELECT * FROM user_constraints WHERE table_name='STUDENT';

/*
ON DELETE NO ACTION(default)
child 있어서 못 지운다.

ON DELETE SET NULL
parent 삭제되면 child NULL로 세팅

ON DELETE CASCADE
parent 삭제되면 child 삭제 
*/
DELETE FROM department
WHERE department_id=1;

SELECT * FROM student;
SELECT * FROM student;

SELECT * FROM enrollment
WHERE student_id=1;

SELECT * FROM student;

DELETE student
WHERE student_id=1;

/*
 * CTAS
 * 주의 사항
 * not null, check(C) 제약조건만 복제된다.
 * primary key(P), forign key(R), unique(U) 제약 조건은 복제되지 않는다.
 */
CREATE TABLE student2 AS
SELECT * FROM student;

SELECT * FROM student;

SELECT *
FROM user_constraints
WHERE table_name IN ('STUDENT','STUDENT2')
ORDER BY table_name;



/*
 * 제약 조건 추가
 * ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint(column_name)
 *
 * 제약 조건 삭제
 * ALTER TABLE table_name DROP CONSTRAINT constraint_name;
 */
ALTER TABLE student2 ADD CONSTRAINT student2_pk PRIMARY KEY(student_id);
ALTER TABLE student2 DROP CONSTRAINT student2_pk;

SELECT *
FROM user_constraints
WHERE table_name='STUDENT2';

SELECT * FROM student2;

/*
 * 컬럼 추가
 * ALTER TABLE table_name ADD (column_name1 datatype1 constraint1
 *							 [, column_name2 datatype2 constraint2, ...] )
 *
 * 컬럼 삭제
 * ALTER TABLE table_name DROP (column_name1 [, column_name2, ...]);
 */

ALTER TABLE student ADD (address varchar(100));
ALTER TABLE student ADD (address varchar(100) NOT NULL);
ALTER TABLE student ADD (address varchar(100) DEFAULT 'Korea' NOT NULL);

ALTER TABLE student DROP(address);

-- 기존 데이터 있는 경우 NOT NULL 단독 constraint 불가
ALTER TABLE student2 ADD 
	(address varchar(100) DEFAULT 'Korea' NOT NULL,
	 admission number(4));

ALTER TABLE student2 DROP(address, admission);


-- MODIFY
SELECT * from all_tab_columns where table_name='STUDENT';
ALTER TABLE student MODIFY (email varchar(100) NULL, name varchar(100) NOT NULL)

-- rename column, rename table
ALTER TABLE student RENAME COLUMN email TO email_address;
RENAME student TO stdt;
SELECT * FROM stdt;


/*
 * DROP TABLE table_name [CASCADE CONSTRAINT] [PURGE];
 * 
 * CASCADE CONSTRAINT: 제약 조건 있어도 삭제
 * PURGE: 복구 불가능하게 하는 옵션
 */

-- 제약 조건 다시 설정 한 후
DROP TABLE student; -- 삭제 안되는 것 확인

DROP TABLE student CASCADE CONSTRAINT;

SELECT * FROM user_constraints WHERE table_name='STUDENT';

-- recyclebin 조회
SELECT * FROM recyclebin;
FLASHBACK TABLE student TO BEFORE DROP;

-- dustbin 비우기
SELECT * FROM student;
DROP TABLE student CASCADE CONSTRAINT PURGE;

-- dustbin 조회
SELECT * FROM recyclebin

FLASHBACK TABLE student TO BEFORE DROP;
purge recyclebin;
 

-- truncate
-- 자동 커밋 되기 때문에 복구하기 힘들다. DROP과는 달리 휴지통에도 없다.
-- DELETE는 ROLLBACK이 가능하지만 시스템에 부하를 준다는 단점
SELECT * FROM enrollment;
TRUNCATE TABLE enrollment;

