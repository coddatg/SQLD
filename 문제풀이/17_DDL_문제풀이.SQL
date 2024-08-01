
-- p.118 107번 문제
CREATE TABLE 학생 (
    학번 char(8) PRIMARY KEY,
    장학금 INTEGER
)

(가) SELECT COUNT(*) FROM 학생;
(나) SELECT COUNT(학번) FROM 학생;


-- p.119 109번 문제
CREATE TABLE SALESREP  (
    SalesRepNo int NOT NULL,
    RepName char(35) NOT NULL,
    HireDate date NOT NULL,

    CONSTRAINT SalesRepPK PRIMARY KEY (SalesRepNo),
    CONSTRAINT SalesRepAK1 UNIQUE (RepName)
)


-- p.124 118번 문제
-- Department did '1'인 행 삭제 할 때 Empoyee did가 '1'인 행을 같이 삭제하도록 하는 방법 
Employee(eid, ename, did)
Department(did, dname, budget)