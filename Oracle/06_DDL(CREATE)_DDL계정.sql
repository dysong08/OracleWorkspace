/*
    * DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    
    오라클에서 제공하는 객체를
    새로이 만들고(CREATE), 구조를 변경하고(ALTER), 구조 자체를 삭제(DROP)하는 명령문
    즉, 구조 자체를 정의하는 언어로 DB관리자나 설계자가 주로 사용함  
*/

/*
    <CREATE TABLE>
    테이블 : 행(ROW), 열(COLUMN)로 구성되는 가장 기본적은 DB객체 종류중 하나
    모든 데이터는 테이블을 통해서 저장됨(데이터를 조작하고자 한다면 테이블 생성해야 함)
    
    [표현법]
    CREATE TABLE 테이블명(
    칼럼명 자료형,
    칼럼명 자료형,
    칼럼명 자료형,
    ...
    )
    
    <자료형>
    - 문자(CHAR(크기)/VARCHAR2(크기)) : 크기는 BYTE
                                    (숫자,영문,특문 1BYTE, 한글 3BYTE)
        - CHAR(바이트수) : 최대 2000BYTE까지 지정가능
                        고정길이
                        주로 들어올 값의 글자수가 정해져 있는 경우 사용한다
                        EX)성별 : 남/여, M/F, 주민등록번호 등..
        - VARCHAR2(바이트수) : 최대 4000BYTE까지 지정가능
                            가변길이
                            VAR는 '가변', 2는 2배를 의미
                            주로 들어올 값의 글자수가 정해지지 않은 경우 사용
                            EX)이름, 아이디, 비밀번호 ...
        - VARCHAR2(CHAR) : 글자단위로 크기 지정이 가능
    
    - 숫자(NUMBER) : 정수/실수 상관없이 NUMBER
    - 날짜(DATE) : 년월일시분초 형식으로 시간 지정
    - LOB 
            CLOB : 가변길이 문자(최대 4GB)
            BLOB : BINARY DATA
         
*/

-- 회원들의 데이터를 담기 위핸 MEMBER테이블 생성
-- 아이디, 비밀번호, 이름, 생년월일
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_BDATE DATE
);

-- TABLE 확인방법1
SELECT * FROM MEMBER;

-- TABLE 확인방법2
-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블

SELECT * 
FROM USER_TABLES;
-- -> 현재 DDL사용자 계정이 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는
-- 시스템 테이블


-- 칼럼들 확인법
SELECT * 
FROM USER_TAB_COLUMNS;
-- 칼럼정보를 확인할 수 있는 시스템 테이블



/*
    칼럼에 주석 달기
    
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';

*/

COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.MEMBER_BDATE IS '생년월일';



-- INSERT(DML문)
-- 데이터 추가시에는 한행으로 추가, 추가할 값을 기술

-- INSERT INTO 테이블명 VALUES(첫번째 칼럼의값, 두번째 칼럼의값,...)

INSERT INTO MEMBER VALUES('user01', 'pass01', '홍길동', '1980/05/10');
INSERT INTO MEMBER VALUES('user02', 'pass02', '김갑생', '1999/05/10');
INSERT INTO MEMBER VALUES('user03', 'pass03', '박말똥', SYSDATE);


INSERT INTO MEMBER VALUES(NULL, NULL, NULL, SYSDATE);
-- 아이디, 비번, 이름에 NULL값이 존재해도 되는가? 절대 아님

INSERT INTO MEMBER VALUES('user03', 'pass03', '박말똥', SYSDATE);
-- 중복된 아이디가 존재해도 되는가? 절대 아님

-- 위의 NULL값들이나 중복된 아이디값은 유효한 데이터가 아님
-- 유효한 데이터값을 유지하기 위해서는 "제약조건"을 걸어야 한다.
-- 데이터 무결성 보장이 가능하다

SELECT * FROM MEMBER;


/*
    <제약 조건 CONSTRAINTS>
    - 특정 칼럼에 내가 원하는 데이터값만 유지하기 위해서 각 칼럼마다 설정한다
    
    - 제약 조건이 부여된 칼럼에 들어올 데이터에 문제가 있는지 없는지 자동으로 검사할 목적
    
    - 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
    - 칼럼에 제약조건을 부여하는 방식 : 칼럼레벨방식 / 테이블레벨방식
    
    1. NOT NULL 제약조건
        해당 칼럼에 반드시 값이 존재해야만 할 경우 사용
        => NULL값이 절대 들어와서는 안되는 칼럼에 부여하는 제약조건
            삽입/수정시 NULL값을 허용하지 않도록 제한하는 제약조건
            
        주의점 : 칼럼레벨방식으로만 설정 가능
        
*/

-- NOT NULL 제약조건이 추가된 테이블 만들기
-- 칼럼레벨방식으로 부여 : 칼럼명 자료형 제약조건 
--              => 제약조건을 부여하고자 하는 칼럼 바로뒤에 기술


CREATE TABLE MEMBER_NOTNULL(
    MEMBER_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    );

INSERT INTO MEMBER_NOTNULL VALUES (1, 'user01', 'pass01','홍길동', '남', '010-4121-3393', 'rudals@naver.com');

INSERT INTO MEMBER_NOTNULL VALUES (2, NULL,NULL,NULL,NULL,NULL,NULL);
-- 에러발생. NOT NULL 제약조건에 위배되어 오류발생

INSERT INTO MEMBER_NOTNULL VALUES (2, 'user02','pass02','김갑생',NULL,NULL,NULL);
-- NOTNULL 값이 아니더라도 

SELECT * FROM MEMBER_NOTNULL;


/*
    2. UNIQUE 제약조건
        칼럼에 중복값을 제한하는 제약조건(반드시 고유한 값만 
        삽입/수정시 기존에 해당 칼럼값 중에 중복값이 있을 경우
        추가/수정이 되지 않게 제약
        
        칼럼레벨방식/테이블레벨방식 둘다 가능함
*/


CREATE TABLE MEMBER_UNIQUE(
    MEMBER_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE(MEMBER_ID)   -- <- 테이블레벨방식 : 
    --                  모든칼럼을 다 기술하고 마지막에 제약조건을 부여하는 방식
    );


INSERT INTO MEMBER_UNIQUE VALUES (1, 'user01','pass01','홍길동','남','010-1111-1111', null);
-- 제약조건을 부여할때 직접 제약조건명을 지정해주지 않으면 시스템에서 알아서
-- 중복되지 않는 임의의 제약조건명을 부여한다. ex) SYS_C007073

/*
    * 제약조건 부여시 제약조건명도 지정하는 표현법
    
    -> 칼럼레벨방식
    칼럼명 자료형 [CONSTRAINT 제약조건명] 제약조건
    
    -> 테이블레벨방식
    [CONSTRAINT 제약조건명] 제약조건(칼럼명)
*/


CREATE TABLE MEMBER_UNIQUE_NN(
    MEMBER_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL ,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    CONSTRAINT MEM_ID_UQ UNIQUE(MEMBER_ID)   
    -- CONSTRAINT 테이블명_제약조건명_칼럼명 으로 주로 사용(모든 테이블간 겹치면 안됨)                
    );


INSERT INTO MEMBER_UNIQUE_NN VALUES (1, 'user01','pass01','홍길동','남','010-1111-1111', null);
INSERT INTO MEMBER_UNIQUE_NN VALUES (1, 'user01','pass01','홍길동','남','010-1111-1111', null);
-- 제약조건명을 지정한 후에는 어떤 칼럼에 어떤 종류의 제약조건을 위배했는지
-- 한눈에 파악할 수 있다.


/*
    3. CHECK 제약조건
    칼럼에 기록될 수 있는 값에 대한 조건을 직접 설정 가능
    EX) 성별 칼럼에 남 또는 여, M 혹은 F, Y 혹은 N등의 값만 추가하고 싶을 때 사용
    
    [표현법]
    CHECK (조건식)
*/

CREATE TABLE MEMBER_CHECK (
    MEMBER_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE(MEMBER_ID)   
    );


INSERT INTO MEMBER_CHECK VALUES (1, 'user01','pass01','홍길동','남','010-1111-1111', null);
INSERT INTO MEMBER_CHECK VALUES (2, 'user02','pass02','홍길동','님','010-1111-1111', null);

INSERT INTO MEMBER_CHECK VALUES (2, 'user02','pass02','홍길동','여','010-1111-1111', null);
INSERT INTO MEMBER_CHECK VALUES (3, 'user03','pass03','홍길동',NULL,'010-1111-1111', null);
-- CHECK 제약조건으로 NULL값도 INSERT 가능한가? 가능함
-- 추가적으로 NULL값을 못들어오게 하고 싶다면 NOT NULL 제약조건도 같이 걸어주면 됨

/*
    * DEFAULT 설정
    특정 칼럼에 들어올 값에 대한 기본값 설정 가능(제약조건은 아님)
    
    EX)회원가입일 칼럼에 회원정보가 삽입된 순간의 시간을 기록하고 싶다. 
    -> DEFUALT로 SYSDATE를 넣어주면 됨
*/

DROP TABLE MEMBER_CHECK;

CREATE TABLE MEMBER_CHECK (
    MEMBER_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE,
    UNIQUE(MEMBER_ID)   
    -- 
    );


INSERT INTO MEMBER_CHECK VALUES (1, 'user03','pass03','홍길동','남','010-1111-1111', null, SYSDATE);

INSERT INTO MEMBER_CHECK VALUES (1, 'user02','pass02','홍길동','남','010-1111-1111', null, DEFAULT);

SELECT * FROM MEMBER_CHECK;



/*
    INSERT INTO 테이블명(칼럼명들 나열)
    VALUES(순서에 맞게 값을 나열)
*/

INSERT INTO MEMBER_CHECK (MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GENDER)
VALUES(5, 'user55', 'pass', '길동', '남');
-- 값을 추가하고자 지정안한 칼럼에는 기본값으로 NULL이 들어간다
-- 만약 DEFAULT옵션이 부여되어 있다면 NULL값이 아닌 DEFAULT값이 들어간다

INSERT INTO MEMBER_CHECK (MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GENDER, MEMBER_DATE)
VALUES(6, 'user56', 'pass', '길동', '남', NULL);
-- 단, NULL값을 명시하면 NULL값이 들어간다.

SELECT * FROM MEMBER_CHECK;



/*
    4. PRIMARY KEY(기본키) 제약조건
        테이블에서 각 행들의 정보를 유일하게 식별할 수 있는 칼럼에 부여하는 제약조건
        => 각 행들을 구분할 수 있는 식별자의 역할
        EX) 사번, 부서아이디, 직급코드, 회원번호, 학번 등...
        => 식별자의 조건 : 중복X 값이 없으면 안됨(NOT NULL + UNIQUE)
        
        한 테이블당 한 개의 기본키만 지정 가능
*/


CREATE TABLE MEMBER_PRIMARYKEY1 (
    MEMBER_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE
    );


INSERT INTO MEMBER_PRIMARYKEY1 (MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GENDER)
VALUES(NULL, 'user2', 'pass', '길동', '남');
-- 기본키 칼럼에는 중복값, NULL값을 부여할 수 없다. 항상 고유한 값이 들어가야함


CREATE TABLE MEMBER_PRIMARYKEY2 (
    MEMBER_NO NUMBER ,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEM_PK2 PRIMARY KEY(MEMBER_NO)   -- 테이블레벨방식
    );


CREATE TABLE MEMBER_PRIMARYKEY3 (
    MEMBER_ID VARCHAR2(20) ,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEM_PK3 PRIMARY KEY(MEMBER_ID, MEMBER_NAME)   -- 테이블레벨방식
    );
-- 테이블당 1개의 PRIMARY KEY만 사용할 수 있다.
-- 두 개의 칼럼을 기본키로 사용하고 싶은 경우 
-- 두 칼럼을 묶어서 한번에 PRIMARY KEY로 설정 가능하다.


INSERT INTO MEMBER_PRIMARYKEY3 (MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GENDER)
VALUES('user1', 'pass', '길동', '남');

INSERT INTO MEMBER_PRIMARYKEY3 (MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GENDER)
VALUES('user1', 'pass', '길동2', '남');

INSERT INTO MEMBER_PRIMARYKEY3 (MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GENDER)
VALUES('user1', 'pass', '길동2', '남');
SELECT * FROM MEMBER_PRIMARYKEY3;
-- PRIMARY KEY를 부여한 MEMBER_ID, MEMBER_NAME 둘 다 동일하면 에러발생
-- 하나만 다를 경우 생성 가능함

-- -> 복합키일 경우 두 칼럼의 값이 완전히 중복되어야 제약조건에 위배된다
-- 복합키일 경우 한 칼럼의 값이 NULL이더라도 제약조건에 위배된다.



/*
    5. FOREIGN KEY(외래키)
        해당 칼럼에 다른 테이블에 존재하는 값만 들어와야 하는 칼럼에 부여하는 제약조건
        => "다른 테이블을 참조한다"라고 표현
        즉, 참조된 다른 테이블이 제공하고 있는 값만 들어올 수 있다.
        EX) KH계정에서
            EMPLOYEE테이블에 DEPT_CODE 의 경우 DEPRARTMENT테이블의 DEPT_ID에
            이미 들어가 있는 값들만 사용하고 있었다.
        => FORDIGN KEY 제약조건으로 테이블간의 연결고리를 만들어서
        다른 테이블과 관계를 형성할 수 있다.
        
        [표현법]
        -> 칼럼레벨방식 제약조건 설정시
        칼럼명 자료형 [CONSTRAINT 제약조건명] REFERENCES 참조테이블명[(참조할 칼럼명)]   
        
        -> 테이블레벨방식 
        [CONSTRAINT 제약조건명] FOREIGN KEY(칼럼명) REFERENCES 참조테이블명[(참조할 칼럼명)] 
        
        => 생략 가능한 키워드 : [CONSTRAINT 제약조건명], [(참조할 칼럼명)]
        => 참조할 칼럼명 생략시 참조할 테이블의 PRIMARY KEY에 해당하는 칼럼이 참조할 칼럼으로 설정된다.
        
        참조할 칼럼명 타입과 외래키로 지정할 칼럼의 타입(자료형)이 일치해야 한다.
*/


-- 부모테이블(참조테이블) 만들기
-- 회원등급에 대한 데이터를 보관하는 테이블(등급코드, 등급명)

CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY, --등급코드 문자열('G1','G2','G3',..) 기본키
    GRADE_NAME VARCHAR2(20) NOT NULL --등급명 문자열 일반회원, 우수회원, 다이아회원..
    );

SELECT * FROM MEM_GRADE;

-- 자식테이블 만들기
CREATE TABLE MEM (
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE, -- 칼럼레벨방식 외래키 지정
    GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE 
    -- CONSTRAINT 제약조건명 FREIGN KEY(GRADE_ID) REFERENCES MEM_GREADE(GRADE_CODE)
    -- 테이블레벨방식
    );

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (1, 'user1', 'pass01', '경민', 'G1');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (2, 'user2', 'pass02', '이순신', 'G2');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (3, 'user3', 'pass03', '김갑생', 'G3');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (4, 'user4', 'pass04', '김삼순', 'G4');
-- G4 등급은 MEM_GRADE 테이블에 존재하지 않는 데이터이기 때문에 추가할 수 없다.

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (4, 'user4', 'pass04', '김삼순', NULL);
-- 외래키 제약조건에는 NULL값도 들어갈 수 있다.

SELECT * FROM MEM;

SELECT MEMBER_NAME, GRADE_NAME
FROM MEM
JOIN MEM_GRADE ON GRADE_ID = GRADE_CODE;



-- MEM_GRADE에서 불필요한 데이터가 있어서 데이터값을 삭제하고자 하는 경우
-- MEM_GRADE테이블로부터 GRADE_CODE가 'G1'인 데이터를 삭제하려고 한다.

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
-- 자식 테이블 중에 GRAED_ID칼럼에서 G1값을 이미 참조해서 사용하고 있기 때문에
-- 삭제할 수 없다.

-- 현재 외래키 제약조건 부여시 삭제처리에 대한 옵션을 따로 부여하지 않음
-- 기본적으로 삭제제한 옵션이 걸려있다.

DROP TABLE MEM;

/*
    * 자식 테이블 생성시 부여(외래키 제약조건을 부여했을때)
     부모테이블(참조테이블)의 데이터가 삭제되었을 때 
     자식테이블에는 어떻게 처리할지를 옵션으로 정해둘 수 있다.
     
     * FOREIGN KEY 삭제옵션
     - ON DELETE RESTRICTED : 삭제 제한 => 기본옵션
     - ON DELETE SET NULL : 부모데이터를 삭제할 때 해당 데이터를 사용하는 
                            자식데이터를 NULL로 변경하겠다.
    - ON DELETE CASCADE : 부모데이터를 삭제할 때 해당 데이터를 사용하는
                            자식데이터를 함께 삭제하겠다.
*/


CREATE TABLE MEM (
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE ON DELETE SET NULL, -- 칼럼레벨방식 외래키 지정
    GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE 
    -- CONSTRAINT 제약조건명 FREIGN KEY(GRADE_ID) REFERENCES MEM_GREADE(GRADE_CODE)
    -- 테이블레벨방식
    );

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (1, 'user1', 'pass01', '경민', 'G1');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (2, 'user2', 'pass02', '이순신', 'G2');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (3, 'user3', 'pass03', '김갑생', 'G3');

SELECT * FROM MEM;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
-- 'G1'을 참조하고 있는 칼럼값이 NULL로 바뀐다.



DROP TABLE MEM;

CREATE TABLE MEM (
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE ON DELETE CASCADE, -- 칼럼레벨방식 외래키 지정
    GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE 
    -- CONSTRAINT 제약조건명 FREIGN KEY(GRADE_ID) REFERENCES MEM_GREADE(GRADE_CODE)
    -- 테이블레벨방식
    );

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (1, 'user1', 'pass01', '경민', 'G1');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (2, 'user2', 'pass02', '이순신', 'G2');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (3, 'user3', 'pass03', '김갑생', 'G3');

SELECT * FROM MEM;


DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G3';


/*
    외래키 제약조건이 없더라도 조인이 가능함
    단, 두 칼럼에 동일한 의미의 데이터가 담겨 있어야 함
    (자료형이 같고 담긴값의 종류나 의미도 비슷해야 함)
*/

--------------------------------------------------------------------
/*
    ------------- 여기서부터 실행은 KH계정에서 --------------------
    
    * SUBQUERY를 활용한 테이블 생성(테이블 복사)
    
    [표현법]
    CREATE TABLE 테이블명 
    AS 서브쿼리;
*/

-- EMPLOYEE 테이블을 복제한 새로운 테이블 생성하기(EMPLOYEE_COPY)
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;
-- 칼럼, 조회결과인 데이터들만 제대로 복사됨
-- 제약조건 중 NOT NULL 제약조건 복사됨

-- PRIMARY KEY, 코멘트 등은 복사가 안됨
-- 서브쿼리를 통해 테이블을 생성할 경우 제약조건의 경우 NOT NULL만 복사됨

SELECT * FROM EMPLOYEE_COPY;


-- EMPLOYEE에 있는 컬럼의 구조만 복사하고 싶을때
CREATE TABLE EMPLOYEE_COPY2
AS SELECT * FROM EMPLOYEE
--WHERE EMP_ID IS NULL; (==)
WHERE 1 = 0;

SELECT * FROM EMPLOYEE_COPY2;



-- 전체 사원들 중 급여가 300만원 이상인 사원들의 사번, 이름, 부서코드, 급여 복제
-- 칼럼도 함께 복제
-- 복제할 테이블명 : EMPLOYEE_COPY3
CREATE TABLE EMPLOYEE_COPY3
AS 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT * FROM EMPLOYEE_COPY3;


-- 전체 사원의 사번, 사원명, 급여, 연봉 조회한 결과를 복제한 테이블 생성
-- 복제할 테이블명 : EMPLOYEE_COPY4
CREATE TABLE EMPLOYEE_COPY4
AS 
SELECT EMP_NO, EMP_NAME, SALARY, SALARY*12 "연봉"
FROM EMPLOYEE;

-- 서브쿼리의 SELECT 산술연산, 함수식이 기술된 경우 반드시 별칭을 부여해야 한다.
SELECT * FROM EMPLOYEE_COPY4;






