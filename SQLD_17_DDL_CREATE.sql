--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/FGmid
-- Email          : coddat.g@gmail.com
-- Last Updated   : 2024-06-28
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

DROP TABLE enrollment purge;
DROP TABLE student purge;
DROP TABLE course purge;
DROP TABLE Department purge;


/*
 * < 테이블 생성 규칙 >
 * 
 * 테이블명은 객체 의미하는 적절한 이름 사용, 가급적 단수형 권고
 * 다른 테이블명과 중복되지 않아야
 * 한 테이블 내 칼럼명 중복 지정할 수 없음
 * 
 * 칼럼은 괄호'( )' 안에 콤마로 구분해 정의
 * 칼럼명은 데이터베이스 내에서 일관성 있게 사용
 * 데이터 유형 반드시 지정해야
 * 
 * 테이블명, 칼럼명 패턴
 *   반드시 문자로 시작 
 * 	 벤더별로 길이 한계
 *   사전 정의된 예약어는 사용 불가
 *   A-Z, a-z, 0-9, _, $, # 문자만 허용
 * 
 * 생성문은 항상 ;로 끝남
 * 
 */

CREATE TABLE Department (
    department_id NUMBER NOT NULL,
    department_name VARCHAR2(100) NOT NULL,
    CONSTRAINT department_pk PRIMARY KEY (department_id)
);

CREATE TABLE Student (
    student_id NUMBER(3) CONSTRAINT student_not_null NOT NULL,
    email varchar(50) UNIQUE NOT NULL,
    name VARCHAR2(50) NULL,
    department_id NUMBER(3) DEFAULT 0,
    CONSTRAINT student_pk PRIMARY KEY (student_id),
    CONSTRAINT department_key FOREIGN KEY (department_id) REFERENCES Department(department_id)
);
-- ALTER TABLE Student ADD CONSTRAINT student_pk PRIMARY KEY (student_id);
-- ALTER TABLE Students ADD CONSTRAINT department_key FOREIGN KEY (department_id) REFERENCES Department(department_id);

CREATE TABLE Course (
    course_id NUMBER(3) NOT NULL,
    course_name VARCHAR2(100) NOT NULL,
    department_id NUMBER(3),
    CONSTRAINT course_pk PRIMARY KEY (course_id),
    CONSTRAINT department_fk FOREIGN KEY (department_id) REFERENCES Department(department_id)
    	ON DELETE CASCADE
);

CREATE TABLE Enrollment (
    student_id NUMBER NOT NULL,
    course_id NUMBER NOT NULL,
    semester DATE NOT NULL,
    grade NUMBER(4, 2) CHECK (grade>=50.00),
    -- CHECK (grade BETWEEN 50.00 and 100.00),
    CONSTRAINT enrollment_key PRIMARY KEY (student_id, course_id, semester),
    CONSTRAINT student_fk FOREIGN KEY (student_id) REFERENCES Student(student_id)
    	ON DELETE CASCADE,
    CONSTRAINT course_fk FOREIGN KEY (course_id) REFERENCES Course(course_id)
    	ON DELETE CASCADE
);

INSERT INTO Department (department_id, department_name) VALUES (1, 'Computer Science');
INSERT INTO Department (department_id, department_name) VALUES (2, 'Mathematics');
INSERT INTO Department (department_id, department_name) VALUES (3, 'Physics');
INSERT INTO Department (department_id, department_name) VALUES (4, 'Chemistry');
INSERT INTO Department (department_id, department_name) VALUES (5, 'Biology');

INSERT INTO Student (student_id, name, email, department_id) VALUES (1, 'John Doe', 'john@ddatg.ac.kr', 1);
INSERT INTO Student (student_id, name, email, department_id) VALUES (2, 'Jane Smith', 'jane@ddatg.ac.kr', 2);
INSERT INTO Student (student_id, name, email, department_id) VALUES (3, 'Emily Davis', 'emily@ddatg.ac.kr', 3);
INSERT INTO Student (student_id, name, email, department_id) VALUES (4, 'Michael Brown', 'michael@ddatg.ac.kr', 4);
INSERT INTO Student (student_id, name, email, department_id) VALUES (5, 'Sarah Connor', 'sarah@ddatg.ac.kr', 5);
INSERT INTO Student (student_id, name, email, department_id) VALUES (6, 'Kyle Reese', 'kyle@ddatg.ac.kr', 1);
INSERT INTO Student (student_id, name, email, department_id) VALUES (7, 'T-800', 'T800@ddatg.ac.kr', 2);
INSERT INTO Student (student_id, name, email, department_id) VALUES (8, 'Ellen Ripley', 'ellen@ddatg.ac.kr', 3);
INSERT INTO Student (student_id, name, email, department_id) VALUES (9, 'Alice Johnson', 'alice@ddatg.ac.kr', 4);
INSERT INTO Student (student_id, name, email, department_id) VALUES (10, 'Bob Williams', 'bob@ddatg.ac.kr', 5);
INSERT INTO Student (student_id, name, email, department_id) VALUES (11, 'Charlie Miller', 'charlie@ddatg.ac.kr', 1);
INSERT INTO Student (student_id, name, email, department_id) VALUES (12, 'Diana Wilson', 'diana@ddatg.ac.kr', 2);
INSERT INTO Student (student_id, name, email, department_id) VALUES (13, 'Ethan Harris', 'ethan@ddatg.ac.kr', 3);


INSERT INTO Course (course_id, course_name, department_id) VALUES (101, 'Introduction to Computer Science', 1);
INSERT INTO Course (course_id, course_name, department_id) VALUES (102, 'Calculus I', 2);
INSERT INTO Course (course_id, course_name, department_id) VALUES (103, 'Physics I', 3);
INSERT INTO Course (course_id, course_name, department_id) VALUES (104, 'Organic Chemistry', 4);
INSERT INTO Course (course_id, course_name, department_id) VALUES (105, 'Biology I', 5);
INSERT INTO Course (course_id, course_name, department_id) VALUES (106, 'Algorithms', 1);
INSERT INTO Course (course_id, course_name, department_id) VALUES (107, 'Linear Algebra', 2);
INSERT INTO Course (course_id, course_name, department_id) VALUES (108, 'Quantum Physics', 3);
INSERT INTO Course (course_id, course_name, department_id) VALUES (109, 'Biochemistry', 4);
INSERT INTO Course (course_id, course_name, department_id) VALUES (110, 'Genetics', 5);
INSERT INTO Course (course_id, course_name, department_id) VALUES (111, 'Discrete Mathematics', 1);
INSERT INTO Course (course_id, course_name, department_id) VALUES (112, 'Statistics', 2);
INSERT INTO Course (course_id, course_name, department_id) VALUES (113, 'Thermodynamics', 3);



INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (1, 101, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 88.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (1, 102, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 85.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (2, 103, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 78.50);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (2, 104, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 82.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (3, 105, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 90.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (3, 106, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 88.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (4, 107, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 75.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (4, 101, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 85.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (5, 102, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 90.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (5, 103, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 92.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (6, 104, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 80.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (6, 105, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 87.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (7, 106, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 85.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (7, 107, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 83.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (8, 101, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 88.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (8, 102, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 86.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (3, 101, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 89.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (3, 105, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 92.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (4, 109, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 85.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (4, 110, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 90.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (5, 111, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 88.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (5, 112, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 87.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (9, 113, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 90.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (9, 101, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 91.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (10, 105, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 86.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (10, 109, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 88.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (11, 110, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 89.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (11, 111, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 90.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (12, 112, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 91.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (12, 113, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 92.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (13, 101, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 93.00);
INSERT INTO Enrollment (student_id, course_id, semester, grade) VALUES (13, 105, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 94.00);