
INSERT INTO student (student_id, email, name, department_id)
	VALUES (14, 'ddatg@ddatg.ac.kr', 'ddatg', 1);

INSERT INTO student 
	VALUES (14, 'ddatg@ddatg.ac.kr', 'ddatg', 1);

-- 에러! column 이름 목록으로 넣지 않으면 입력 순대로 모든 값을 다 넣어야 함
INSERT INTO student 
	VALUES (14, 'ddatg@ddatg.ac.kr', 'ddatg');

-- 에러! column 이름 목록으로 넣지 않으면 입력 순서를 컬럼 순서에 맞춰야 함
INSERT INTO student 
	VALUES (14, 'ddatg@ddatg.ac.kr', 1, 'ddatg');

INSERT INTO student (student_id, email, name)
	VALUES (14, 'ddatg@ddatg.ac.kr', 'ddatg');

-- 에러! NOT NULL CONSTRAINT가 있는 컬럼은 값을 입력해줘야 함
INSERT INTO student (student_id, email, department_id)
	VALUES (14, 'ddatg@ddatg.ac.kr', 1);

DELETE FROM student
WHERE student_id=14;

/*
 * UPDATE table_name
 * 	SET column_name1=update_value1
 * 	[, column_name2=update_value2, ...]
 * WHERE condition
 */

SELECT * FROM stadium s;

UPDATE stadium
	SET tel='000-0000';

ROLLBACK;

UPDATE stadium
	SET tel='000-0000'
WHERE tel IS NULL;

ROLLBACK;

-- 경기장 전화번호와 홈팀 전화번호가 일치하지 않는 경우

SELECT a.stadium_id, a.stadium_name, a.ddd, a.tel, b.ddd, b.tel
FROM stadium a
JOIN team b
ON b.team_id=a.hometeam_id
WHERE a.ddd!=b.ddd OR a.tel!=b.tel
ORDER BY 1;

-- 경기장	  
UPDATE stadium a
	SET a.DDD = (SELECT x.DDD FROM team x WHERE x.team_id=a.hometeam_id),
		a.tel = (SELECT x.tel FROM team x WHERE x.team_id=a.hometeam_id);
	
UPDATE stadium a
	SET (a.DDD, a.tel) = (SELECT x.DDD, x.tel
						  FROM team x
						  WHERE x.team_id=a.hometeam_id)
WHERE stadium_id='A02' OR stadium_id='A05'

-----------------------------------------------------------
-- merge

-- Target 테이블 생성
CREATE TABLE target_tbl (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    quantity NUMBER
);

-- Source 테이블 생성
CREATE TABLE source_tbl (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    quantity NUMBER
);

-- target_tbl 데이터 삽입
INSERT INTO target_tbl (id, name, quantity) VALUES (1, 'Item A', 10);
INSERT INTO target_tbl (id, name, quantity) VALUES (2, 'Item B', 20);
INSERT INTO target_tbl (id, name, quantity) VALUES (3, 'Item C', 30);

-- source_tbl 데이터 삽입
INSERT INTO source_tbl (id, name, quantity) VALUES (2, 'Item B', 25);
INSERT INTO source_tbl (id, name, quantity) VALUES (3, 'Item C', 35);
INSERT INTO source_tbl (id, name, quantity) VALUES (4, 'Item D', 40);

MERGE INTO target_tbl t
USING source_tbl s
ON (t.id = s.id)
WHEN MATCHED THEN
    UPDATE SET t.quantity = s.quantity
--		WHERE t.quantity > 20
--	DELETE
--		WHERE t.id=3
WHEN NOT MATCHED THEN
    INSERT (id, name, quantity) VALUES (s.id, s.name, s.quantity);
--		WHERE t.quantity > 50;

SELECT * FROM target_tbl;
   
DROP TABLE target_tbl PURGE;
DROP TABLE source_tbl PURGE;

-- Product 테이블 생성
CREATE TABLE Product (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(50),
    price NUMBER
);

-- Updates 테이블 생성
CREATE TABLE Updates (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(50),
    price NUMBER
);

-- Products 테이블에 데이터 삽입
INSERT INTO Product (product_id, product_name, price) VALUES (1, 'Product X', 100);
INSERT INTO Product (product_id, product_name, price) VALUES (2, 'Product Y', 200);
INSERT INTO Product (product_id, product_name, price) VALUES (3, 'Product Z', 300);

-- Updates 테이블에 데이터 삽입
INSERT INTO Updates (product_id, product_name, price) VALUES (2, 'Product Y', 250);
INSERT INTO Updates (product_id, product_name, price) VALUES (4, 'Product W', 400);

MERGE INTO product p
USING updates u
ON (p.product_id=u.product_id)
WHEN MATCHED THEN
	UPDATE SET p.price=u.price
WHEN NOT MATCHED THEN
	INSERT (product_id, product_name, price) VALUES (u.product_id, u.product_name, u.price)
SELECT * FROM product;
	
DROP TABLE Product PURGE;
DROP TABLE Updates PURGE;
