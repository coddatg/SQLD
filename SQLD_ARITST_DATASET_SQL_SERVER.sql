--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/sV6wK
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------

DROP TABLE artist;

CREATE TABLE artist (
	artist_id int NOT NULL,
	name varchar(10) NOT NULL,
	group_name varchar(10),
	height float,
    foot_size float,
	birth_year int,
	CONSTRAINT ARTIST_PK PRIMARY KEY (artist_id)
);

INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (1, '카리나', 'aespa', 168, 230, 2000);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (2, '윈터', 'aespa', 163, 225,2001);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (3, '지젤', 'aespa', 163.5, NULL, 2000);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (4, '닝닝', 'aespa', 161, NULL, 2002);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (5, '안유진', 'IVE', 173, 250, 2003);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (6, '가을', 'IVE', 164, 225, 2002);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (7, '레이', 'IVE', 170, NULL, 2004);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (8, '장원영', 'IVE', 173, 245, 2004);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (9, '리즈', 'IVE', 171, NULL, 2004);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (10, '이서', 'IVE', 165, 245, 2007);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (11, '민지', 'NewJeans', 169, 245, 2004);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (12, '하니', 'NewJeans', 161.7, 240, 2004);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (13, '다니엘', 'NewJeans', 165, NULL, 2005);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (14, '해린', 'NewJeans', 164.5, 245, 2006);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (15, '혜인', 'NewJeans', 170, NULL, 2008);
INSERT INTO artist (artist_id, name, group_name, height, foot_size, birth_year) VALUES (16, '아이유', NULL, 162.3, 225, 1993);