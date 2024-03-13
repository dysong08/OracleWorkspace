/*
    * DDL(DATA DEFINITION LANGUAGE)
    
    객체들을 새롭게 생성(CREATE)하고 수정, 삭제하는 구문
    
    
    1. ALTER
    객체 구조를 수정하는 구문
    
    [표현법]
    ALTER TABLE 테이블명 수정할내용;
    
    - 수정할내용
    1) 칼럼추가 / 수정 / 삭제
    2) 제약조건 추가 / 삭제 => 수정은 불가
    3) 테이블명 / 칼럼명 / 제약조건명 수정
    
*/

-- 1) 칼럼추가 / 수정 / 삭제
-- 1_1) 칼럼추가(ADD) : ADD 추가할칼럼명 자료형 [DEFAULT 기본값]

SELECT * FROM DEPT_COPY;

-- CNAME 칼럼 추가
ALTER TABLE DEPT_COPY
ADD CNAME VARCHAR2(20);
-- 새로운 칼럼이 만들어지고 NULL값으로 채워짐
ROLLBACK;

-- LNAME 칼럼 추가 DEFAULT 지정
ALTER TABLE DEPT_COPY
ADD LNAME VARCHAR2(20)
DEFAULT '한국';
-- 새로운 칼럼이 만들어지고 NULL이 아닌 DEFAULT값으로 채워짐



-- 1_2) 칼럼 수정(MODIFY)
--      칼럼의 자료형 수정 : MODIFY 수정할 칼럼명 바꾸고자하는 자료형
--      DEFAULT값 수정 : MODIFY 수정할 칼럼명 바꾸고자하는 기본값

-- DEPT_COPY 테이블의 DEPT_ID칼럼의 자료형을 CHAR(3)으로 변경하기
ALTER TABLE DEPT_COPY 
MODIFY DEPT_ID CHAR(3);

ALTER TABLE DEPT_COPY 
MODIFY DEPT_ID CHAR(2);
-- 변경하고자 하는 칼럼이 이미 담겨있는 값보다 더 작은 크기로 변경은 불가하다

SELECT LENGTHB(DEPT_ID) FROM DEPT_COPY;
-- DEPT_COPY테이블의 DEPT_ID칼럼의 바이트값 


ALTER TABLE DEPT_COPY 
MODIFY DEPT_ID NUMBER;
-- 변경하고자 하는 칼럼에 이미 담겨있는 값보다 완전히 다른 타입으로 변경 불가하다

--***
-- >> 문자-> 숫자X / 값이 담겨있다면 문자열 사이즈 축소X / 사이즈확대(O)
--***


-- 한번에 여러개의 칼럼 변경하기
-- DEPT_TITLE 칼럼의 데이터타입을 VARCHAR2(40) 으로
-- LOCATION_ID 칼럼의 데이터타입을 VARCHAR2(2)로
-- LNAME의 기본값을 미국으로 바꾸기
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '미국';

SELECT * FROM DEPT_COPY;


-- 1_3) 칼럼 삭제(DROP COLUMN) : DROP COLUMN 삭제하고자 하는 칼럼명
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;


-- DEPT_COPY2로부터 DEPT_ID칼럼 삭제하기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

SELECT * FROM DEPT_COPY2;
ROLLBACK;
-- DDL 구문은 ROLLBACK으로 복구가 불가능하다!!


-- 모든 칼럼 삭제하기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
-- 테이블에 최소 한개의 칼럼은 존재해야 하기 때문에 마지막 칼럼은 삭제불가능!!

SELECT * FROM DEPT_COPY2;



/*
    2_1) 제약조건 추가
    - 제약조건(PRIMARY KEY, FOREGIN KEY, UNIQUE, CHECK)
    ADD [CONSTRAINT 제약조건명] 제약조건(칼럼명) [REFERENCES 참조할테이블명(참조할칼럼명)]
    
    NOTNULL 제약조건 -> MODIFY 칼럼명 NOT NULL;
    제약조건의 이름을 부여하고자 한다면 CONSTRAINT 제약조건명을 추가
*/

-- DEPT_COPY테이블로부터 
-- DEPT_ID에는 PRIMARY KEY
-- DEPT_TITLE에는 UNIQUE
-- LNAME 에는  NOT NULL 제약조건 부여

ALTER TABLE DEPT_COPY
--ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID);
--ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE);
MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;
-- 한번에 여러개 실행이 안되면 한줄씩 실행하기..


/*
    2_2) 제약조건 삭제
    PRIMARY KEY, FOREGIN KEY, UNIQUE, CHECK
    DROP CONSTAINT 제약조건명;
    
    NOT NULL : MODIFY 칼럼명 NULL;
*/

-- DEPT_COPY테이블로부터 DCOPY_PK 제약조건 삭제하기
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;  --????????????????

-- DCOPY_UQ, DCOPY_NN 제약조건삭제하기
--ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_UQ;
ALTER TABLE DEPT_COPY MODIFY LNAME NULL;



-- 3) 칼럼명 / 제약조건명 / 테이블명 변경(RENAME)

-- 3_1) 칼럼명 변경 : RENAME COLUMN 기존칼럼명  TO 바꿀칼럼명;

-- DEPT_COPY테이블에서 DEPT_TITLE칼럼을 DEPT_NAME으로 바꾸기
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
SELECT * FROM DEPT_COPY;


-- 3_2) 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
-- DEPARTMENT의 SYS_C007016을 DCOPY_NN;
ALTER TABLE DEPARTMENT RENAME CONSTRAINT SYS_C007016 TO DCOPY_NN;



-- 3_3) 테이블명 변경 : RENAME [기존테이블명] TO 바꿀테이블명
-- DEPT_COPY테이블명을 DEPT_TEST로 변경하기
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

SELECT * FROM DEPT_COPY;
SELECT * FROM DEPT_TEST;




/*
    2. DROP
    
    [표현법]
    DROP TABLE 테이블명;
*/

-- EMP_NEW 테이블 삭제하기
DROP TABLE EMP_NEW;

-- 외래키 설정이 되어있으면 삭제에 제한이 걸림!!

-- 테스트환경 구성
-- DEPT_TEST테이블의 DEPT_ID칼럼에 PRIMARY KEY 제약조건 추가하기
ALTER TABLE DEPT_TEST ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID);

-- EMPLOYEE_COPY3에 DEPT_CODE칼럼에 외래키 추가, 부모테이블은 DEPT_TEST
ALTER TABLE EMPLOYEE_COPY3
ADD CONSTRAINT ECOPY_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_TEST;

-- 부모테이블 삭제하기
DROP TABLE DEPT_TEST;


-- 어딘가에서 참조되고 있는 부모테이블들은 삭제되지 않는다.
-- 만약 부모테이블을 삭제하고 싶다면?

-- 방법 1) 참조하고 있는 자식테이블을 먼저 삭제 후 부모테이블 삭제하기
DROP TABLE 자식테이블;
DROP TABLE 부모테이블;
-- 참조하고 있던 자식테이블이 삭제되었으므로 부모테이블 삭제 가능


-- 방법 2) 부모테이블만 삭제하되 맞물려 있는 외래키 제약조건도 함께 삭제하기
-- DROP TABLE 부모테이블명 CASCADE CONSTRAINT;
DROP TABLE DEPT_TEST CASCADE CONSTRAINT;


























