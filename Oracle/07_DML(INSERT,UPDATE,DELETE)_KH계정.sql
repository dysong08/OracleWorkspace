/*
    * DML (DATA MANIPULATION LANGUAGE)
    데이터 조작 언어
    
    테이블에 새로운 데이터를 삽입(INSERT)하거나
    기존의 데이터를 수정(UPDATE)하거나
    삭제(DELETE)하는 구문들
*/

/*
    1. INSERT : 테이블에 새로운 "행"을 추가하는 구문
    
    [표현법]
    
    * INSERT INTO 계열
    1) INSERT INTO 테이블명 VALUES(값1,값2,값3,..)
    => 해당 테이블에 "모든" 칼럼에 대해 추가하고자 하는 값을 
    내가 직접 제시해서 "한 행"을 INSERT하고자 할 때 쓰는 표현법
    주의사항 : 칼럼의 순서, 자료형, 갯수를 맞춰서 VALUES괄호 안에 나열해야 함
*/

-- EMPLOYEE 테이블에 사원정보 추가
INSERT INTO EMPLOYEE
VALUES (900, '김갑생', '991008-1234567','ALS@iei.or.kr', '01012345678', 
        'D1', 'J7', 'S6', 1900000, 0.2, 200, SYSDATE, null, DEFAULT);
        
SELECT * FROM EMPLOYEE;


/*
    2) INSERT INTO 테이블명(칼럼명1, 칼럼명2, 칼럼명3)
    VALUES (값1,값2,값3);
    
    => 해당 테이블에 "특정" 칼럼만 선택해서 그 칼럼에 추가할 값만 제시하고자 할때 사용
    
    - 한행 단위로 데이터가 추가되기 때문에 선택이 안된 칼럼은
        기본적으로 NULL값이 들어간다
    - 단, DEFAULT 설정이 있는 경우 "기본값"이 들어간다
    
    - NOT NULL 제약조건이 걸려있는 칼럼은 반드시 선택해서 직접 값을 제시해야 함
    (단, DEFAULT 옵션이 추가된 경우는 생략가능)
*/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES (901, '박말똥', '990202-1234567', 'J6', 'S5');


/*
    3) INSERT INTO 테이블명 (서브쿼리);
    => VALUES()로 값을 직접 기입하는게 아니라 
      서브쿼리로 조회한 결과값을 통째로 INSERT하는 구문
      (여러 행을 한 번에 INSERT할 수 있다.)
*/

-- 새 테이블 추가
CREATE TABLE EMP_01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DETE_TITLE VARCHAR2(20)
    );
    
-- 전체 사원들의 사번, 이름, 부서명을 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 위 서브쿼리 결과를 INSERT
INSERT INTO EMP_01(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
);

SELECT * FROM EMP_01;


/*
    * INSERT ALL 계열
    두 개 이상의 테이블에 각각 INSERT할 때 사용
    조건 : 그때 사용되는 서브쿼리가 동일해야 한다.
    
    1) INSERT ALL
    INTO 테이블명1 VALUES(칼럼명,칼럼명,..)
    INTO 테이블명2 VALUES(칼럼명,칼럼명,..)
    서브쿼리;
*/

-- 첫번째 테이블 : 급여가 300만원 이상인 사원들의 사번, 사원명, 직급명을 보관할 테이블
CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    JOB_NAME VARCHAR2(20)
    );

-- 두번째 테이블 : 급여가 300만원 이상인 사원들의 사번, 사원명, 부서명을 보관할 테이블
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
    );


SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY >= 3000000;


INSERT ALL
INTO EMP_JOB VALUES (EMP_ID, EMP_NAME, JOB_NAME) -- 8행
INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_TITLE) -- 8행
    SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE SALARY >= 3000000;



/*
    2) INSERT ALL
    WHEN 조건1 THEN
        INTO 테이블명1 VALUES(칼럼명,칼럼명,..)
    WHEN 조건2 THEN
        INTO 테이블명2 VALUES(칼럼명,칼럼명,..)
    서브쿼리;
    
    - 조건에 맞는 값들만 추가하겠다.
*/

-- 조건을 사용해서 각 테이블에 값 추가(INSERT)
-- 새로운 테스트용 테이블 생성
-- 2010년도 기준으로 이전에 입사한 사원들의 사번, 사원명, 입사일, 급여

CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

-- 2010년도 기준으로 이후에 입사한 사원들의 사번, 사원명, 입사일, 급여
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;


INSERT ALL
WHEN HIRE_DATE < '2010/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2010/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT * FROM EMPLOYEE;


----------------------------------------------------

/*
    2. UPDATE
    테이블에 기록된 기존의 데이터를 수정하는 구문
    
    [표현법]
    UPDATE 테이블명
    SET 칼럼명 = 바꿀값,
        칼럼명 = 바꿀값,
        칼럼명 = 바꿀값,  -- 여러개의 칼럼값을 동시에 변경가능
        ...              -- 이때 바꿀칼럼을 , 로 나열해야 함
    WHERE 조건;   -- WHERE절은 생략 가능. 생략시 테이블의 모든 행의 데이터가 변경된다.
*/

-- 복사본 테이블을 만든 후 작업
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

-- DEPT_COPY테이블에서 D9부서의 부서명을 전략기획팀으로 수정
UPDATE DEPT_COPY
    SET DEPT_TITLE = '전략기획팀';
-- 조건을 추가하지 않는 경우 모든 행의 값이 전략기획팀으로 수정됨
SELECT * FROM DEPT_COPY;

ROLLBACK; -- 변경사항에 대해 되돌리는 명령어

UPDATE DEPT_COPY
    SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';
-- WHERE절의 조건에 따라 1개~N개의 행이 변경될 수 있다.

SELECT * FROM DEPT_COPY;


-- 복사본 테이블
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE;

SELECT * FROM EMP_SALARY;


-- 전체 사원의 급여를 20%, 보너스를 10% 인상
UPDATE EMP_SALARY
    SET SALARY = SALARY*1.2,
        BONUS = NVL(BONUS,0) + 0.1;
SELECT * FROM EMP_SALARY; 



/*
    * UPDATE시에 서브쿼리 사용
    서브쿼리를 수행한 결과값으로 기존에 있던 값을 변경하겠다
    
    - CREATE 시에 서브쿼리 : 서브쿼리를 수행한 결과를 테이블 만들때 넣겠다.
    - INSERT 시에 서브쿼리 : 서브쿼리를 수행한 결과를 해당 테이블에 삽입하겠다.
    
    [표현법]
    UPDATE 테이블명
    SET 칼럼명 = (서브쿼리)
    WHERE 조건;

*/

-- EMP_SALARY 테이블에 박말똥 사원의 부서코드를 선동일 사원의 부서코드로 변경하기
-- 1)
SELECT * FROM EMP_SALARY;

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '선동일';

-- 2) 박말똥 부서코드를 D9로 변경하기
UPDATE EMP_SALARY
SET DEPT_CODE = (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '선동일')
WHERE EMP_NAME = '박말똥';


-- 방명수 사원의 급여와 보너스를 유재식 사원의 급여와 보너스값으로 변경하시오
-- 단일행 다중열 서브쿼리를 사용할 것
UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                        FROM EMP_SALARY
                        WHERE EMP_NAME = '유재식' )
WHERE EMP_NAME = '방명수';

SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME IN ('유재식','방명수');

-- 주의사항 : UPDATE할때도 변경할 값에 대해 제약조건에 위배되면 안됨

UPDATE EMPLOYEE
    SET EMP_ID = 200
WHERE EMP_NAME = '송종기'; 
-- PRIMARY KEY 제약조건 위배


COMMIT; -- 모든 변경사항을 확정하는 명령어


-----------------------------------------------------------------


/*
    4. DELETE 
    테이블에 기록된 데이터를 "행"단위로 삭제하는 구문
    
    [표현법]
    DELETE FROM 테이블명
    WHERE 조건; -- WHERE절 생략가능. 생략시 모든행이 삭제됨
*/

-- EMPLOYEE 테이블의 모든 행 삭제
DELETE FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;
-- 0개 행 조회
-- 데이터는 없지만 칼럼자체는 남아있음

ROLLBACK;


-- EMPLOYEE 테이블의 김갑생, 박말똥 사원의 정보 삭제하기
DELETE FROM EMPLOYEE
WHERE EMP_ID IN (900,901);

SELECT * FROM EMPLOYEE; 
COMMIT; 


/*
    * TRUNCATE : 테이블의 전체 행을 모두 삭제할 때 사용하는 구문(절삭)
                DELETE문보다 수행속도가 빠름
                단, 별도의 조건 제시 불가
                ROLLBACK 불가
                
    [표현법]
    TRUNCATE TABLE 테이블명;
*/

SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY;

TRUNCATE TABLE EMP_SALARY;
ROLLBACK;











