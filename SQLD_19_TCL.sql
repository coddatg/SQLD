
-- SAVEPOINT, ROLLBACK, COMMIT
-- 트랜잭션: 데이터베이스의 논리적 연산 단위
-- TRANSACTION의 대상은  DML(INSERT, UPDATE, DELETE)

CREATE TABLE t (
  id int,
  col1 varchar2(1),
  col2 int
);

INSERT INTO t values(1, 'A', 2);
INSERT INTO t values(2, 'A', 2);
INSERT INTO t values(3, 'B', 3);
INSERT INTO t values(4, 'B', 3);
INSERT INTO t values(5, 'C', 3);
COMMIT;

savepoint sp1;
delete from t where id=2;
savepoint sp2;
delete from t where col1='A';
delete from t where col2=3;
rollback to sp2;
-- rollback;
commit;
select * from t;

---------------------------------------------------

CREATE TABLE t (id int, val int);

INSERT INTO t values(1, 100);
INSERT INTO t values(2, 200);
commit;

savepoint sp1;
update t set val=200 where id=1;
savepoint sp2;
update t set val=300 where id=1;
rollback to sp2;
commit;

select * from t;


---------------------------------------------------
-- DDL, DCL은 AUTO COMMIT 된다.

CREATE TABLE t1 (id int,val int);

INSERT INTO t1 values(1, 100);
INSERT INTO t1 values(2, 200);
commit;

update t1 set val=200 where id=1;
create table t2 (id int, var int);
-- drop table t2;
rollback; -- CREATE, DROP, ALTER 명령어 이후 AUTO COMMIT 된다.

select * from t1;

---------------------------------------------------
-- SAVEPOINT

CREATE TABLE t (id int, val int);

INSERT INTO t values(1, 100);
INSERT INTO t values(2, 200);
commit;

savepoint sp1;
insert into t values(3, 300);
savepoint sp2;
insert into t values(4, 400);
savepoint sp3;
insert into t values(5, 500);
savepoint sp4;
insert into t values(6, 600);
rollback to sp4;
rollback to sp3;
rollback to sp2;
/*
 * rollback to sp1;
 * rollback to sp2; -- 오류 발생
 */
commit;

select * from t;


---------------------------------------------------
-- 중간에 commit한 경우
CREATE TABLE t (id int, val int);

INSERT INTO t values(1, 100);
INSERT INTO t values(2, 200);
commit;

savepoint sp1;
insert into t values(3, 300);
savepoint sp2;
insert into t values(4, 400);
commit;
insert into t values(5, 500);
savepoint sp3;
insert into t values(6, 600);
rollback to sp2;
commit;

select * from t;


