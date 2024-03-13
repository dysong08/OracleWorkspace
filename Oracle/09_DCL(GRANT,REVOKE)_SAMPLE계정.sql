-- 3_1. CREATE TABLE 권한 부여받기 전
CREATE TABLE TEST(
    TEST_ID NUMBER
    );    
-- 불충분한 권한 : SAMPLE 계정에 테이블 생성 권한을 부여하지 않아서 에러발생함


-- 3_2) CREATE TABLE 권한 부여받은 후
CREATE TABLE TEST(
    TEST_ID NUMBER
    );  
    
-- SAMPLE 계정에 TABLESPACE가 아직 할당되지 않아서 오류 발생


-- TABLESPACE 할당 받은 후..
CREATE TABLE TEST(
    TEST_ID NUMBER
    ); -- 테이블 생성완료
    
INSERT INTO TEST VALUES(1);
-- 테이블 생성 권한을 부여받으면 현재 계정이 소유하고 있는 테이블들 조작(DML)이 가능해짐



-- 4. 뷰 만들어보기 
-- 권한부여 받기 전
CREATE VIEW V_TEST
AS SELECT * FROM TEST;


-- 권한부여 받은 후
CREATE VIEW V_TEST
AS SELECT * FROM TEST;



-- 5. SAMPLE계정에서 KH계정의 테이블에 접근해서 조회해보기
SELECT *
FROM KH.DEPARTMENT; --조회권한을 받지 않았으므로 접근불가, 에러발생함

SELECT *
FROM KH.EMPLOYEE;   --조회권한을 받았으므로 조회가능함



-- 6. SAMPLE 계정에서 KH계정의 테이블에 접근해서 행 삽입하기
--          KH의 DEPARTMENT테이블에 회계부 부서 추가
INSERT INTO KH.DEPARTMENT VALUES('D0', '회계부', 'L2');
-- 권한받지 않았으므로 에러발생함


--------------------------------------------------------------------



-- 7. 테이블생성하기
CREATE TABLE TEST2 (
    NUM NUMBER
    );
-- 테이블 생성권한 회수로 인한 권한 불충분 에러발생










