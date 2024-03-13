/*
    * DCL (DATA CONTROL LANGUAGE)
    데이터 제어 언어
    
    계정에게 시스템권한 또는 객체접근권한을 
    부여(GRANT)하거나 회수(REVOKE)하는 언어
    
    * 권한부여(GRANT)
        -시스템권한 : 특정 DB에 접근하는 권한
                    객체들을 생성할 수 있는 권한
        -객체접근권한 : 특정 객체들에 접근해서 조작할 수 있는 권한
        
    * 시스템권한
    
    
    [표현법]
    GRANT 권한1, 권한2,  ... TO 계정명;
    
    - 시스템 권한의 종류
    CREATE SESSION : 계정에 접속할 수 있는 권한
    CREATE TABLE   : 테이블을 생성할 수 있는 권한
    CREATE VIEW    : 뷰를 생성할 수 있는 권한
    

*/

-- 1. SAMPLE 계정 생성하기
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;


-- 2. SAMPLE 계정에 접속하기 위한 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO SAMPLE;


-- 3_1. SAMPLE 계정에 테이블을 생성할 수 있는 CREATE TABLE권한 부여
GRANT CREATE TABLE TO SAMPLE;


-- 3_2. SAMPLE 계정에 테이블 스페이스를 할당해주기( SAMPLE 계정변경)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
--QUOTA : 몫 나누어주다, 할당하다


-- 4. SAMPLE 계정에 뷰를 생성할 수 있는 CREATE VIEW 권한 부여
GRANT CREATE VIEW TO SAMPLE;


-----------------------------------------------------------

/*
    - 객체 권한
    특정 객체들을 조작할 수 있는 권한
    조작 : SELECT, INSERT, UPDATE, DELETE
    
    [표현법]
    GRANT 권한종류 ON 특정객체 TO 계정명;
    
        권한종류         |       특정객체
    -----------------------------------------
        SELECT          |   TABLE, VIEW, SEQUENCE
        INSERT          |   TABLE, VIEW
        UPDATE          |   TABLE, VIEW
        DELETE          |   TABLE, VIEW
*/

-- 5. SAMPLE 계정에 KH.EMPLOYEE테이블을 조회할 수 있는 권한 부여학
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;


-- 6. SAMPLE 계정에 KH.DEPARTMENT 테이블에 행을 삽입할 수 있는 권한 부여하기
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;




--------------------------------------------------------------------

-- GRANT CONNECT, RESOURCE TO 계정명;
/*
    <롤 ROLE>
    특정 권한들을 하나의 집합으로 모아놓은 것
    
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, SELECT, INSERT, ...
            (특정 객체들을 생성 및 조작할 수 있는 권한)(일반 개발자용 권한)
    CONNECT : CREATE SESSION(DB에 접속할 수 있는 권한)
*/
--------------------------------------------------------------------
/*
    권한 회수(REVOKE)
    권한을 회수할 때 사용하는 명령어
    
    [표현법]
    REVOKE 권한1, 권한2, .. FROM 계정명;
*/

-- 7. SAMPLE 계정에서 테이블을 생성할 수 없도록 권한 회수하기
REVOKE CREATE TABLE FROM SAMPLE;





