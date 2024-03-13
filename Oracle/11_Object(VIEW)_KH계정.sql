/*
    * Object
    DB를 이루는 논리적인 구조물들
    
    * Object
    - TABLE, USER, VIEW, SEQUENCE, INDEX, PACKAGE, TRIGGER, FUNCTION, PROCEDURE..
    
    <VIEW 뷰>
    SELECT문을 수행한 수행결과(RESULTSET)를 저장해 둘 수 있는 객체
    (자주 쓰일 SELECT문을 VIEW에 저장해두면 매번 긴 SELECT문을 다시 기술할 필요가 없다)
    => 조회를 위한 임시테이블 같은 존재이며 실제 데이터가 담겨있는 것은 아니다.
    => 조회를 위한 서브쿼리문만 저장하며 VIEW호출시 서브쿼리를 실행시킨다.
*/


-- 실습문제 --
-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명, 직급명 조회하시오.

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N USING (NATIONAL_CODE)
JOIN JOB J USING(JOB_CODE)
WHERE N.NATIONAL_NAME = '한국';



/*
    1. VIEW 생성방법
    
    [표현법]
    CREATE VIEW 뷰명
    AS 서브쿼리;
    
    
    CREATE [OR REPLACE] VIEW 뷰명
    AS 서브쿼리;
    => 뷰 생성시 기존에 중복된 이름의 뷰가 없다면 새롭게 뷰가 생성되고
                      중복된 이름의 뷰가 있다면 해당 이름의 뷰를 변경한다.
*/


CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
    JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
    JOIN NATIONAL N USING (NATIONAL_CODE)
    JOIN JOB J USING(JOB_CODE);
-- 현재 KH계정은 뷰생성 권한 없어서 에러발생함..........
-- 관리자 계정에서 GRANT CREATE VIEW TO KH; 로 권한부여 해줘야 한다.


-- 접속계정 시스템계정으로 변경
GRANT CREATE VIEW TO KH;
-- 권한 부여 후 KH계정으로 복귀


SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '한국'; 
-- VW_EMPLOYEE 뷰에 위의 서브쿼리를 인라인형태로 가지고 있어 호출함.



-- '러시아'에 근무하는 사원들의 사번, 이름, 직급명, 보너스 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, BONUS
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '러시아'; 
-- 뷰에 존재하지 않는 칼럼을 제시하면 오류 발생한다 (뷰에 보너스 칼럼이 없음)


-- 뷰는 논리적인 가상테이블 => 실제로 데이터를 저장하고 있지 않음.
-- 확인방법

SELECT * FROM USER_VIEWS;
-- 뷰는 단순히 쿼리문을 TEXT 형태로 보관만 하는 객체


/*
    * 뷰 칼럼에 별칭 부여하기
    서브쿼리 SELECT절에 함수호출식, 산술연산식 등이 기술된 경우 반드시 별칭을 지정.
*/

-- 사원의 사번, 이름, 직급명, 성별, 근무년수를 조회할 수있는 SELECT문을 만들고
-- 이를 VIEW로 정의하시오.

CREATE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
         DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') "성별",
         EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "근무년수"
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
         
SELECT * FROM VW_EMP_JOB;


-- 다른 방법으로 별칭 부여하기(단, 모든 칼럼에 대해 별칭을 기술)
CREATE OR REPLACE VIEW VW_EMP_JOB(사번, 사원명, 직급명, 성별, 근무년수)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
         DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') ,
         EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
         
SELECT * FROM VW_EMP_JOB;

SELECT 사번, 사원명 
FROM VW_EMP_JOB
WHERE 성별 = '여';


DROP VIEW VW_EMP_JOB;

-------------------------------------------------------------------------

-- INSERT, UPDATE, DELETE
/*
    * 생성된 뷰를 이용해서 DML(INSERT, UPDATE, DELETE) 사용 가능
    
    주의사항 : 뷰를 통해서 조작하게 된다면 실제 데이터가 담겨 있던
            테이블에 변경사항이 적용된다.
*/

CREATE VIEW VW_JOB
AS SELECT * FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- VW_JOB에 INSERT
INSERT INTO VW_JOB
VALUES ('J8','인턴');
-- JOB 테이블에도 추가가 되었음.


-- VW_JOB에 UPDATE, JOB_CODE가 J8인 직급을 '알바'로 변경하기
UPDATE VW_JOB
    SET JOB_NAME ='알바'
WHERE JOB_CODE = 'J8';

SELECT * FROM VW_JOB;
SELECT * FROM JOB;


-- VW_JOB에 DELETE, JOB_CODE가 J8인 직급을 삭제하기
DELETE VW_JOB
WHERE JOB_CODE = 'J8';

SELECT * FROM VW_JOB;
SELECT * FROM JOB;



/*
    VIEW를 활용해서 DML이 가능한 경우
        : 서브쿼리를 이용해서 기존의 테이블을 그대로 복제한 경우에만 가능
        
    * 하지만 뷰를 가지고 DML이 불가능한 경우가 훨씬 더 많다
        => 추가적인 처리가 더 들어간 경우 불가능
        
        1) 뷰에 정의되어 있지 않은 칼럼을 조작하는 경우
        2) 뷰에 정의되어 있지 않은 칼럼 중에 베이스테이블상에 NOT NULL 제약조건이 지정된 경우
        3) 산술연산식 또는 함수를 통해 정의되어 있는 경우
        4) 그룹함수나 GROUP BY절이 포함된 경우
        5) DISTINCT 구문이 포함된 경우
        6) JOIN을 이용한 경우
*/

-- 1) 뷰에 정의되어 있지 않은 칼럼을 조작하는 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB;

INSERT INTO VW_JOB(JOB_CODE, JOB_NAME)
VALUES ('J8','인턴');
-- 존재하지 않는 칼럼에 INSERT 안됨

UPDATE VW_JOB
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J7';
-- 존재하지 않는 칼럼에 UPDATE 안됨

DELETE FROM VW_JOB
WHERE JOB_CODE = 'J7'; 
-- 존재하지 않는 칼럼에 DELETE 안됨



-- 2) 뷰에 정의되어 있지 않은 칼럼 중에 NOT NULL 제약조건이 지정된 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

INSERT INTO VW_JOB
VALUES ('인턴');
-- cannot insert NULL into ("KH"."JOB"."JOB_CODE")
-- JOB테이블의 NOT NULL 제약조건에 위배됨 (JOB_CODE에 NULL값을 넣으려고 함)


-- 3) 산술연산식 또는 함수를 통해 정의되어 있는 경우
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 "연봉" 
FROM EMPLOYEE; 

INSERT INTO VW_EMP_SAL
VALUES (400, '홍길동', 3000000, 36000000);
-- virtual column not allowed here
-- 가상칼럼은 허용하지 않는다 (연봉 칼럼은 베이스테이블에 없는 칼럼임)


-- 4) 그룹함수나 GROUP BY절이 포함된 경우
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) "합계"
    FROM EMPLOYEE
    GROUP BY DEPT_CODE; 

SELECT * FROM VW_GROUPDEPT;

INSERT INTO VW_GROUPDEPT
VALUES ('D3', 8000000);
-- 합계 칼럼은 가상칼럼이다. (베이스테이블에 없는 칼럼)


-- 5) DISTINCT 구문이 포함된 경우 DML불가 
--(//생략)



-- 6) JOIN을 이용한 경우
CREATE OR REPLACE VIEW VW_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
   
   
-- 사번을 제시해서 이름 변경하기 
UPDATE VW_JOINEMP
SET EMP_NAME = '서동일'
WHERE EMP_ID = '200';

SELECT * FROM VW_JOINEMP;
--변경가능


-- 사번을 제시해서 부서이름 변경하기
UPDATE VW_JOINEMP
SET DEPT_TITLE = '회계부'
WHERE EMP_ID = '200';

SELECT * FROM VW_JOINEMP;
-- 서로 다른 테이블에 있는 칼럼 사용시 에러발생
-- JOIN한 DEPARTMENT 테이블은 DML 안됨!



-------------------------------------------------------------------

-- VIEW에 사용가능한 옵션들

-- 1. OR REPLACE
CREATE OR REPLACE VIEW V_EMP_SALARY
AS SELECT * FROM EMPLOYEE;

-- 2. FORCE/NOFORCE 옵션 : 실제 테이블이 없더라도 VIEW를 강제로 생성할 수 있게 해주는 옵션(기본값 NOFORCE)
--CREATE OR REPLACE FORCE/NOFORCE 
CREATE FORCE VIEW V_FORCETEST
AS SELECT A,B,C FROM NOTHING;
-- VIEW 생성 가능

SELECT * FROM V_FORCETEST;
-- VIEW 생성은 가능하지만 실제 테이블이 없기 때문에 볼수 없음
-- 따라서 직접 NOTHING 테이블 생성해주면 됨...

CREATE TABLE NOTHING(
    A NUMBER,
    B NUMBER,
    B NUMBER
    );



-- 3. WITH CHECK OPTION
--  서브쿼리의 SELECT문의 WHERE절에서 사용한 칼럼은 수정하지 못하게 막는 옵션
CREATE OR REPLACE VIEW V_CHECKOPTION
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5' WITH CHECK OPTION;

SELECT * FROM V_CHECKOPTION; --6행

UPDATE V_CHECKOPTION
SET DEPT_CODE = 'D6'
WHERE EMP_ID = '215';

SELECT * FROM V_CHECKOPTION;
-- view WITH CHECK OPTION where-clause violation 에러발생


UPDATE V_CHECKOPTION
SET SALARY = '5000000'
WHERE EMP_ID = '215';

SELECT * FROM V_CHECKOPTION;
-- WHERE절에 존재하는 칼럼이 아니기 때문에 에러발생XX
-- DEPT_CODE 칼럼에만 WITH CHECK OPTION 이 걸려있음.

ROLLBACK;



-- 4. WITH READ ONLY
-- VIEW 자체를 수정 못하게 차단하는 옵션
CREATE OR REPLACE VIEW V_READ
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5' WITH READ ONLY;

SELECT * FROM V_READ;

UPDATE V_READ
SET SALARY = '10000000';
-- read-only view에는 DML을 할 수 없다.



DROP USER WORKBOOK CASCADE;

CREATE USER WORKBOOK IDENTIFIED BY WORKBOOK;

GRANT CONNECT, RESOURCE TO WORKBOOK;



