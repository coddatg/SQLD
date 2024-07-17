--------------------------------------------------------------------------------------
-- Writer         : 땃지
-- Course URL     : https://inf.run/FGmid
-- Email          : coddat.g@gmail.com
-- Copyright      : Copyright 2024. by 땃지. All Rights Reserved.
-- Notice         : 이 쿼리 스크립트를 가공, 인용하실 때는 출처를 명확히 밝혀주시기 바랍니다.
--------------------------------------------------------------------------------------


/*
 * 정규표현식(정규식, regex) 특정 패턴과 일치하는 문자열을 찾거나 조작하기 위해 사용하는 문자열 검색 패턴
 * 이메일 주소 형식 검증, 전화번호 형식 검사, HTML 태그 제거 등의 작업 
 * 
 * POSIX 연산자
 */

/* 
 * 특별한 의미를 갖는 메타 문자 . | \ ^ $ * + ? {} [] ()
 * . \n를 제외한 모든 문자와 일치
 * | or
 * \ 다음 메타 문자를 일반 문자로 취급
 */


SELECT regexp_substr('aab', 'a.b') AS c1,
	   regexp_substr('abb', 'a.b') AS c2,
	   regexp_substr('acb', 'a.b') AS c3,
	   regexp_substr('adc', 'a.b') AS c4,
	   regexp_substr('a'||CHR(13)||'b', 'a.b') AS c5,
FROM dual;


SELECT regexp_substr('a', 'a|b') AS c1, -- a OR b
	   regexp_substr('b', 'a|b') AS c2, 
	   regexp_substr('c', 'a|b') AS c3, 
	   regexp_substr('ab', 'ab|cd') AS c4, -- ab OR cd
	   regexp_substr('cd', 'ab|cd') AS c5,
	   regexp_substr('bc', 'ab|cd') AS c6,
	   regexp_substr('aa', 'a|aa') AS c7, -- a OR aa, a가 먼저 일치하며 a 반환
	   regexp_substr('aa', 'aa|a') AS c8 -- aa가 먼저 일치하며 aa 반환
FROM dual;

SELECT regexp_substr('a|b', 'a|b') AS c1,
	   regexp_substr('a|b', 'a\|b') AS c2
FROM dual;


SELECT regexp_substr('dadadadddat|g', 'ddat.g') AS C1,
	   regexp_substr('dadadadddat|g', 'dd|at') AS C2,
	   regexp_substr('dadadadddat|g', 'ddat\|g') AS C3
FROM dual;

/*
 * ^ carrot 문자열의 시작
 * $ dollar 문자열의 끝
 */

/*
SELECT 'ab' || chr(10) || 'cd' FROM dual;

SELECT regexp_substr('ab' || chr(10) || 'cd', '^.', 1, 1) AS C1,
	   regexp_substr('ab' || chr(10) || 'cd', '^.', 1, 2) AS C2,
	   regexp_substr('ab' || chr(10) || 'cd', '.$', 1, 1) AS C3,
	   regexp_substr('ab' || chr(10) || 'cd', '.$', 1, 2) AS C4
FROM dual;
*/

SELECT regexp_substr('dadadadddat|g', '^ddat.g') AS C1,
	   regexp_substr('dadadadddat|g', 'ddat.g$') AS C2
FROM dual;

/*
 * ?     0회 또는 1회 일치
 * *     0회 또는 그 이상의 횟수로 일치
 * +     1회 또는 그 이상의 횟수로 일치
 * {m}   m회 일치
 * {m,}  최소 m회 일치
 * {,m}  최대 m회 일치
 * {m,n} 최소 m회, 최대 n회 일치 
 */


SELECT regexp_substr('ac'  , 'ab?c') AS c1,
	   regexp_substr('abc' , 'ab?c') AS c2,
	   regexp_substr('abbc', 'ab?c') AS c3,
	   regexp_substr('ac'  , 'ab*c') AS c4,
	   regexp_substr('abc' , 'ab*c') AS c5,
	   regexp_substr('abbc', 'ab*c') AS c6,
	   regexp_substr('ac'  , 'ab+c') AS c7,
	   regexp_substr('abc' , 'ab+c') AS c8,
	   regexp_substr('abbc', 'ab+c') AS c9
FROM dual;


SELECT regexp_substr('ab'   , 'a{2}') AS c1,
       regexp_substr('aab'  , 'a{2}') AS c2,
       regexp_substr('aab'  , 'a{3,}') AS c3,
       regexp_substr('aaab' , 'a{3,}') AS c4,
       regexp_substr('aaab' , 'a{4,5}') AS c5,
       regexp_substr('aaaab', 'a{4,5}') AS c6
FROM dual;


SELECT regexp_substr('dadadadddat|g', 'd?at.g') AS C1,
	   regexp_substr('dadadadddat|g', 'd*at.g') AS C2,
	   regexp_substr('dadadadddat|g', 'd+at.g') AS C3,
	   regexp_substr('dadadadddat|g', 'd{2}at.g') AS C4,
	   regexp_substr('dadadadddat|g', 'd{2,}at.g') AS C5,
	   regexp_substr('dadadadddat|g', 'd{,4}at.g') AS C6,
	   regexp_substr('dadadadddat|g', 'd{2,5}at.g') AS C7
FROM dual;

	   
/*
 * (expr)  괄호 안의 표현식을 하나의 단위로 취급
 */

SELECT regexp_substr('ababc', '(ab)+c') AS c1,
	   regexp_substr('ababc', 'ab+c') AS c2,
	   regexp_substr('abd'  , 'a(b|c)d') AS c3,
	   regexp_substr('abd'  , 'ab|cd') AS c4
FROM dual;

SELECT regexp_substr('abaBdadadaddat|g', '(da)+') AS c1,
	   regexp_substr('abaBdadadaddat|g', 'da+') AS c2,
	   regexp_substr('abaBdadadaddat|g', '(d|a)+t') AS c3,
	   regexp_substr('abaBdadadaddat|g', 'da+t') AS c2
FROM dual;

/*
 * \n  n번째 서브 표현식과 일치, n은 1과 9사이 정수
 */

SELECT regexp_substr('abxab' , '(ab|cd)x\1') AS c1,
	   regexp_substr('cdxcd' , '(ab|cd)x\1') AS c2,
	   regexp_substr('abxef' , '(ab|cd)x\1') AS c3,
	   regexp_substr('ababab', '(.*)\1+') AS c4,
	   regexp_substr('ababcd', '(.*)\1+') AS c5,
	   regexp_substr('abcabc', '(.*)\1+') AS c6,
	   regexp_substr('abcabd', '(.*)\1+') AS c7
FROM dual;


/*
 * [] 문자 클래스
 * [abc]는 a|b|c 와 동일한 표현
 * 내부에서 - ^ 라는 메타 문자를 이용
 *
 * - 를 이용해 범위를 표현할 수 있음 [a-c] 위와 동일한 표현
 * ^ 를 이용해 부정을 표현할 수 있음 [^a-c] a,b,c를 제외한 나머지 문자

 *  \t tab
 *	\n 개행
 *  \r 캐리지 리턴
 *  \f 폼피드
 *  \v 수직탭
 */


SELECT regexp_substr('ac', '[ab]c') AS C1,
	   regexp_substr('bc', '[ab]c') AS C2,
	   regexp_substr('cc', '[ab]c') AS C3,
	   regexp_substr('ac', '[^ab]c') AS C4,
	   regexp_substr('bc', '[^ab]c') AS C5,
	   regexp_substr('cc', '[^ab]c') AS C6
FROM dual;

SELECT regexp_substr('abcABXYZ123@# !', '[A-Z]+') AS C1,
	   regexp_substr('abcABXYZ123@# !', '[a-z]+') AS C2,
	   regexp_substr('abcABXYZ123@# !', '[A-Za-z]+') AS C3,
	   regexp_substr('abcABXYZ123@# !', '[0-9]+') AS C4,
	   regexp_substr('abcABXYZ123@# !', '[0-9a-fA-F]+') AS C5,
	   regexp_substr('abcABXYZ123@# !', '[^0-9]+') AS C6,
	   regexp_substr('abcABXYZ123@# !', '[0-9A-Za-z]+') AS C7,
	   regexp_substr('abcABXYZ123@# !', '[ \t\n\r\f\v]+') AS C8,
	   regexp_substr('abcABXYZ123@# !', '[^ \t\n\r\f\v]+') AS C9
FROM dual;


/*
 * 문자열 클래스
 * 문자를 대괄호로 묶은 표현식
 
 */

SELECT regexp_substr('abcABXYZ123@# !', '[[:upper:]]+') AS c1,
	   regexp_substr('abcABXYZ123@# !', '[[:lower:]]+') AS c2,
	   regexp_substr('abcABXYZ123@# !', '[[:alpha:]]+') AS c3,
	   regexp_substr('abcABXYZ123@# !', '[[:digit:]]+') AS c4,
	   regexp_substr('abcABXYZ123@# !', '[[:xdigit:]]+') AS c5,
	   regexp_substr('abcABXYZ123@# !', '[[:alnum:]]+') AS c6,
	   regexp_substr('abcABXYZ123@# !', '[[:punct:]]+') AS c7,
	   regexp_substr('abcABXYZ123@# !', '[[:blank:]]+') AS c8,
	   regexp_substr('abcABXYZ123@# !', '[[:space:]]+') AS c9,
	   regexp_substr('abcABXYZ123@# !', '[[:cntrl:]]+') AS c10,
	   regexp_substr('abcABXYZ123@# !', '[[:graph:]]+') AS c11,
	   regexp_substr('abcABXYZ123@# !', '[[:print:]]+') AS c12
FROM dual;

SELECT regexp_substr('abcABXYZ123@# !', '[[:upper:]]+') AS c1,
	   regexp_substr('abcABXYZ123@# !', '[A-Z]+') AS c1_2,
	   regexp_substr('abcABXYZ123@# !', '[[:lower:]]+') AS c2,
	   regexp_substr('abcABXYZ123@# !', '[a-z]+') AS c2_2,
	   regexp_substr('abcABXYZ123@# !', '[[:alpha:]]+') AS c3,
	   regexp_substr('abcABXYZ123@# !', '[A-Za-z]+') AS c3_2,
	   regexp_substr('abcABXYZ123@# !', '[[:digit:]]+') AS c4,
	   regexp_substr('abcABXYZ123@# !', '[0-9]+') AS c4_1,
	   regexp_substr('abcABXYZ123@# !', '[[:xdigit:]]+') AS c5,
	   regexp_substr('abcABXYZ123@# !', '[0-9A-Fa-f]+') AS c5_2,
	   regexp_substr('abcABXYZ123@# !', '[[:alnum:]]+') AS c6,
	   regexp_substr('abcABXYZ123@# !', '[0-9a-zA-Z]+') AS c6_2,
	   regexp_substr('abcABXYZ123@# !', '[[:word:]]+') AS C7,
	   regexp_substr('abcABXYZ123@# !', '[0-9a-zA-Z ]+') AS C7_1,
	   regexp_substr('abcABXYZ123@# !', '[[:blank:]]+') AS c8,
	   regexp_substr('abcABXYZ123@# !', '[ \t]+') AS c8_2,
	   regexp_substr('abcABXYZ123@# !', '[[:space:]]+') AS c9,
	   regexp_substr('abcABXYZ123@# !', '[ \t\n\r\f\v]+') AS c9_2,
	   regexp_substr('abcABXYZ123@# !', '[[:punct:]]+') AS c10,
	   regexp_substr('abcABXYZ123@# !', '[[:cntrl:]]+') AS c11,
	   regexp_substr('abcABXYZ123@# !', '[[:graph:]]+') AS c12,
	   regexp_substr('abcABXYZ123@# !', '[[:print:]]+') AS c13
FROM dual;

SELECT regexp_substr(chr(9)||chr(10)||chr(11)||chr(12), '[[:blank:]]+') AS c1,
	   regexp_substr(chr(9)||chr(10)||chr(11)||chr(12), '[[:space:]]+') AS c2,
	   regexp_substr(chr(9)||chr(10)||chr(11)||chr(12), '[[:cntrl:]]+') AS c3
FROM DUAL;

/*
 * PERL 정규 표현식
 */

/*
 * 문자 클래스
 * POSIX 문자 클래스와 유사하게 동작
 */


SELECT regexp_substr('abcABXYZ123@# !', '\d+') AS C1, -- [[:digit:]] [0-9]
	   regexp_substr('abcABXYZ123@# !', '\D+') AS C2, -- [^[:digit:]] [^0-9]
	   regexp_substr('abcABXYZ123@# !', '\w+') AS C3, -- [[:alnum:]_] [0-9a-zA-Z_]
	   regexp_substr('abcABXYZ123@# !', '\W+') AS C4, -- [^[:alnum:]_] [^0-9a-zA-Z_] 
	   regexp_substr('abcABXYZ123@# !', '\s+') AS C5, -- [[:space:]] [ \t\n\r\f\v] 
	   regexp_substr('abcABXYZ123@# !', '\S+') AS C6  -- [^[:space:]] [^ \t\n\r\f\v] 
FROM dual;

SELECT regexp_substr('abcABXYZ123@# !', '[[:digit:]]+') AS C1,
	   regexp_substr('abcABXYZ123@# !', '[^[:digit:]]+') AS C2,
	   regexp_substr('abcABXYZ123@# !', '[[:alnum:]_]+') AS C3,
	   regexp_substr('abcABXYZ123@# !', '[^[:alnum:]_]+') AS C4,
	   regexp_substr('abcABXYZ123@# !', '[[:space:]]+') AS C5,
	   regexp_substr('abcABXYZ123@# !', '[^[:space:]]+') AS C6
FROM dual;

SELECT regexp_substr('abcABXYZ123@# !', '[0-9]+') AS C1,
	   regexp_substr('abcABXYZ123@# !', '[^0-9]+') AS C2,
	   regexp_substr('abcABXYZ123@# !', '[0-9a-zA-Z_]+') AS C3,
	   regexp_substr('abcABXYZ123@# !', '[^0-9a-zA-Z_]+') AS C4,
	   regexp_substr('abcABXYZ123@# !', '[ \t\n\r\f\v]+') AS C5,
	   regexp_substr('abcABXYZ123@# !', '[^ \t\n\r\f\v]+') AS C6
FROM dual;

SELECT regexp_substr('(650) 555-0100', '^\(\d{3}\) \d{3}-\d{4}$') AS C1,
	   regexp_substr('650-555-0100', '^\d{3}-\d{3}-\d{4}$') AS C2,
	   regexp_substr('to: dattg', '\w+\W\s\w+') AS C3,
	   regexp_substr('to dattg', '\w+\W\s\w+') AS C4,
	   regexp_substr('to: dattg', '\w+\W+\w+') AS C5,
	   regexp_substr('to dattg', '\w+\W+\w+') AS C6,
	   regexp_substr('dattg@company.co.kr', '\w+@\w+(\.\w+)+') AS C7,
	   regexp_substr('dattg@company', '\w+@\w+(\.\w+)+') AS C8,
	   regexp_substr('coddat.g@gmail.com', '\w+@\w+(\.\w+)+') AS C9,
	   regexp_substr('coddat.g@gmail.com', '^(\w|[.-])+@\w+(\.\w+)+$') AS C10,
	   regexp_substr('coddat.g@gmail.com', '^[0-9a-zA-Z_.-]+@\w+(\.\w+)+$') AS C11
FROM dual;

