-- 한줄주석
/*여러줄주석*/
/*
DML : 데이터 조작, SELECT(DQL), INSERT, UPDATE, DELETE
DDL : 데이터 정의, CREATE, ALTER, DROP
TCL : 트랜잭션 제어, COMMIT,ROLLBACK
DCL : 권한부여, GRANT, REVOKE

<SELECT>
데이터를 조회하거나 검색할 때 사용하는 명령어
- RESULT SET : SELECT 구문을 통해 조회된 데이터의 결과물을 의미(조회된 행들의 집합)
*/

-- EMPLOYEE테이블의 "전체"사원들의 사번, 이름, 급여 칼럼을 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE; --실행시 CTRL+ENTER

select emp_id, emp_name, salary
from employee;
-- 명령어, 키워드, 칼럼명등 대소문자 구분 없음
-- 소문자로 작성해도 무방. 단, 대문자로 쓰는게 관례.

-- EMPLOYEE 테이블의 전체 사원들의 "모든" 칼럼을 조회하는 방법
-- SELECT EMP_ID, EMP_NAME, EMP_NO, .... -- <- 이렇게 안함
SELECT * 
FROM EMPLOYEE; 

-- EMPLOYEE테이블의 전체 사원들의 이름, 이메일, 휴대폰번호 조회
SELECT EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE;


----------- 실습문제 -----------
-- 1. JOB테이블의 모든 칼럼조회
SELECT *
FROM JOB;

-- 2. JOM테이블의 직급명 칼럼만 조회
SELECT JOB_NAME
FROM JOB;

-- 3. DEPARTMENT테이블의 모든 칼럼 조회
SELECT *
FROM DEPARTMENT;

-- 4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 입사일 칼럼만 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 5. EMPLOYEE테이블의 입사일, 직원명, 급여 칼럼만 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE; 

----------------------------------------------
/*
    <칼럼값을 통한 산술연산>
    조회하고자 하는 칼럼들을 나열하는 SELECT 절에 산술연산을 기술하여 결과를 조회할 수 있다.
*/

-- EMPLOYEE 테이블로부터 직원명, 월급, 연봉(월급*12) 
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터 직원명, 월급, 보너스, 보너스가 포함된 연봉(월급*12 +(보너스*월급)*12)
-- 산술연산과정에서 NULL값이 존재할 경우 결과값도 항상 NULL이 나온다.
SELECT EMP_NAME, SALARY, BONUS, ( (SALARY + BONUS * SALARY) * 12)
FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터 직원명, 입사일, 근무일수(오늘날짜-입사일) 조회
-- DATE자료형 - DATE자료형
-- 오늘날짜 SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;
-- 결과값이 지저분한 이유 : DATE 타입 안에 포함된 시, 분, 초에 대한 연산까지 수행하기 때문
-- 결과값은 '일'수로 출력


----------------------------------------------

/* 
    <칼럼명에 별칭 부여하기>
    [표현법] 
    칼럼명 AS 별칭, 칼럼명 AS "별칭", 칼럼명 별칭, 칼럼명 "별칭"
    
    AS를 붙이든 안붙이든 간에 별칭에 특수문자나 띄어쓰기가 포함될 경우 반드시 ""를 묶어서 표기해야 함.
*/

-- EMPLOYEE 테이블로부터 직원명, 월급, 연봉(월급*12) 
SELECT EMP_NAME, SALARY, SALARY*12 "연봉(보너스 미포함)"
FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터 직원명, 월급, 보너스, 보너스가 포함된 연봉(월급*12 +(보너스*월급)*12)
-- 산술연산과정에서 NULL값이 존재할 경우 결과값도 항상 NULL이 나온다.
SELECT EMP_NAME, SALARY, BONUS, ( (SALARY + BONUS * SALARY) * 12) AS "보너스 포함된 연봉"
FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터 직원명, 입사일, 근무일수(오늘날짜-입사일) 조회
-- DATE자료형 - DATE자료형
-- 오늘날짜 SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE 
FROM EMPLOYEE;
-- 결과값이 지저분한 이유 : DATE 타입 안에 포함된 시, 분, 초에 대한 연산까지 수행하기 때문
-- 결과값은 '일'수로 출력

/*
    <리터럴>
    임의로 지정된 문자열('')을 SELECT 절에 기술하면
    실제 그 테이블에 존재하는 데이터처럼 조회가 가능하다.
*/

-- EMPLOYEE 테이블로부터 사번, 사원명, 급여, 급여단위(원) 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS 급여단위
FROM EMPLOYEE;


/*
    <DISTINCT>
    조회하고자 하는 칼럼에 중복된 값을 딱 한번만 조회하고자 할 때 사용
    
    [표현법] 
    SELECT DISTINCT 중복값이 있는 칼럼명
    (단, SELECT 절에 DISTINCT 구문은 한개만 가능하다)
*/
SELECT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 부서코드들만 조회
SELECT DISTINCT DEPT_CODE --, DISTINCT JOB_CODE    <- DISTINCT를 한 구문에 두번 사용 불가하다
FROM EMPLOYEE;

SELECT DISTINCT JOB_CODE    -- <- 따로 하나씩 조회해야 한다.
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE, JOB_CODE -- -> DEPT_CODE, JOB_CODE 두가지 모두 동일해야 중복이라고 간주함
FROM EMPLOYEE;


--------------------------------------------------------------
/*
    <WHERE 절>
    조회하고자 하는 테이블에 특정 조건을 제시해서
    그 조건에 만족하는 데이터들만 조회하고자 할 때 기술하는 구문
    
    [표현법]
    SELECT 조회하고자 하는 칼럼명, ...    => 칼럼들만 뽑아내겠다. 
    FROM 테이블명
    WHERE 조건식;  => 조건에 해당하는 행들을 뽑아내겠다.
    
    - 조건식에 사용 가능한 연산자들
    >, <, >=, <=
    = (일치하는가?  -> 자바에서의 == )
    !=, ^=, <> (일치하지 않는가?)
*/

-- EMPLOYEE 테이블로부터 급여가 400만원 이상인 사원들만 조회(모든칼럼)
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블로부터 부서코드가 D9인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블로부터 부서코드가 D9이 아닌 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';


-------------- 실습문제 ------------
-- 1. EMPLOYEE 테이블에서 급여가 300만원 이상인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE 테이블에서 직급코드가 J2인 사원들의 이름, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

-- 3. EMPLOYEE 테이블에서 현재 재직중인 사원들의 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- 4. EMPLOYEE 테이블에서 연봉(보너스미포함)이 5000만원 이상인 사원들의 이름, 급여, 연봉, 입사일을 조회
SELECT EMP_NAME, SALARY, SALARY*12 AS "연봉(보너스미포함)", HIRE_DATE 
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
--WHERE 연봉 >= 50000000;  <- 에러발생. SELECT절에서 부여한 별칭을 WHERE절에서 사용할 수 없다
-- (실행순서상 불가능함)

-------------------------------------------------------------
/*
    <논리연산자>
    여러 개의 조건을 엮을 때 사용
    AND(자바 : &&), OR(자바 : ||)
    AND : ~ 이면서, 그리고
    OR  : ~ 이거나, 또는
*/

-- EMPLOYEE 테이블에서 부서코드가 D9이면서 급여가 500만원 이상인 사원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;


-- 부서코드가 D6이거나 급여가 300만원 이상인 사원들의 부서코드, 급여 조회
SELECT DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- 급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-------------------------------------------------------------

/*
    <BETWEEN AND>
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용
    
    [표현법]
    비교대상칼럼명 BETWEEN 하한값 AND 상한값
*/

-- 급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 급여가 350만원 미만이고 600만원 초과인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
--WHERE NOT SALARY  BETWEEN 3500000 AND 6000000; (==)
-- Oracle의 NOT == Java의 논리부정연산자(!)


-- ** BETWEEN AND 연산자는 DATE 형식간의 범위에도 사용 가능
-- 입사일이 '90/01/01' ~ '03/01/01'인 사원들의 모든 칼럼 조회
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';
WHERE HIRE_DATE NOT BETWEEN '90/01/01' AND '03/01/01';

------------------------------------------------------------

/*
    <LIKE '특정패턴'>
    비교하고자 하는 칼럼값이 내가 지정한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교대상칼럼명 LIKE '특정패턴'
    
    - 옵션 : 특정패턴 부분에 와일드카드인 '%', '_'를 가지고 제시할 수 있음
    
    '&' : 0글자 이상
            비교대상칼럼 LIKE '문자%' => 칼럼값 중에 '문자'로 시작하는 행을 조회
            비교대상칼럼 LIKE '%문자' => 칼럼값 중에 '문자'로 끝나는 행을 조회
            비교대상 칼럼 LIKE '%문자%' -> 칼럼값 중에 '문자'가 포함되는 행을 조회
    '_' : 1글자
            비교대상 칼럼 LIKE '_문자' => 칼럼값 중에 '문자'앞에 무조건 1글자가 존재하는 경우 조회
            비교대상 칼럼 LIKE '__문자' => 칼럼값 중에 '문자'앞에 무조건 2글자가 존재하는 경우 조회        
*/


-- 성이 전씨인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름 중에 '하'가 포함된 사원들의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 전화번호 4번째 자리가 9로 시작하는 사원들의 사번, 사원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- 이름 가운데 글자가 '지'인 사원들의 모든 칼럼 조회(외자는 없다고 가정)
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_지_';


-- ESCAPE 문자
-- EMPLOYEE 테이블에서 이메일이 _앞의 글자가 3글자인 사원을 조회
-- jun_jy@kh.or.kr
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMAIL LIKE '___#_%' ESCAPE '#'; 
WHERE EMAIL LIKE '____!_%' ESCAPE '!';


-------- 실습문제 --------
--1. 이름이 '연'으로 끝나는 사원들의 이름, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. 전화번호 처음 3글자가 010이 아닌 사원들의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. DEPARTMENT 테이블에서 해외영업과 관련된 부서들의 모든 칼럼 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '%해외영업%';

----------------------------------------------------------

/*
    <IS NULL>
    해당 값이 NULL인지 비교해준다
    
    [표현법]
    칼럼 IS NULL : 칼럼값이 NULL인지 확인
    칼럼 IS NOT NULL : 칼럼값이 NULL이 아닌지 확인
*/

-- 보너스를 받지 않는 사원들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- 사수가 없고, 부서배치도 아직 받지 않은 사원들의 모든 칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 부서배치는 받지 않았지만 보너스는 받는 사원의 모든 칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

----------------------------------------------------------

/*
    <IN>
    비교대상 칼럼값에 내가 제시한 목록들 중에 일치하는 값이 있는지 판단
    
    [표현법]
    비교대상칼럼 IN (값1, 값2, 값3, ...)
*/

-- 부서코드가 D6이거나 D8이거나 D5인 사원들의 모든 칼럼 조회
SELECT *
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5'; 아래와 같이 줄일수 있다.
 WHERE DEPT_CODE IN ('D6', 'D8', 'D5');
 
 --------------------------------------------------------------
 
 /*
    <연결 연산자 ||>
    여러 칼럼값들을 마치 하나의 칼럼인 것 처럼 연결시켜주는 연산자
    칼럼과 리터럴을 연결할 수도 있다.
    
 */
 
-- SELECT EMP_ID, EMP_NAME, SALARY
 SELECT EMP_ID || EMP_NAME || SALARY AS "연결"
 FROM EMPLOYEE;

-- XX번 XXX의 월급은 XXXX원 입니다. AS 급여정보
SELECT EMP_ID || '번 ' || EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' AS "급여정보" 
FROM EMPLOYEE;


--------------------------------------------------------------
/*
    <연산자 우선순위>
    0. ()
    1. 산술연산자
    2. 연결연산자
    3. 비교연산자
    4. IS NULL, LIKE, IN
    5. BETWEEN AND
    6. NOT
    7. AND
    8. OR
*/
--------------------------------------------------------------
/*
    <ORDER BY 절>
    SELECT문 가장 마지막에 기입하는 구문 뿐만 아니라 가장 마지막에 실행되는 구문
    최종 조회된 결과물들에 대해서 "정렬"기준을 세워주는 구문
    
    [표현법]
    SELECT 조회할칼럼1, 2, 3...
    FROM 조회할 테이블명
    WHERE 조건식
    ORDER BY [정렬기준으로 세우고자 하는 칼럼명/별칭/칼럼순번] [ASC/DESC] [NULLS FIRST/NULLS LAST]
    
    오름차순 / 내림차순
    - ASC : 오름차순(생략시 기본값)
    - DESC : 내림차순
    
    정렬하고자 하는 칼럼값에 NULL이 있을 경우
    - NULLS FIRST : 해당 NULL값들을 앞으로 배치(내림차순 정렬일 경우 기본값)
    - NULLS LAST  : 해당 NULL값들을 뒤로 배치(오름차순 정렬일 경우 기본값)
*/

-- 월급이 높은 사람들부터 내림차순 정렬
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- 월급이 낮은 사람들부터 오름차순 정렬
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY /*ASC*/;  -- 기본값이 오름차순이기 때문에 ASC 생략가능.

-- 보너스 기준 정렬
SELECT *
FROM EMPLOYEE
-- ORDER BY BONUS;     -- NULLS LAST 기본값
-- ORDER BY BONUS ASC NULLS FIRST;
-- ORDER BY BONUS DESC;    -- NULLS FIRST 기본값
-- ORDER BY BONUS DESC NULLS LAST;
ORDER BY BONUS DESC NULLS LAST, SALARY ASC;     -- 보너스가 동일할 경우 급여기준 내림차순
--> 첫번째로 제시한 정렬기준의 칼럼값이 일치할 경우 두번째 정렬기준을 가지고 다시 정렬

-- 연봉기준 오름차순 정렬
SELECT EMP_NAME, SALARY, SALARY*12 
FROM EMPLOYEE
-- ORDER BY SALARY*12;     -- 연봉기준 내림차순
 -- ORDER BY 3;     -- 칼럼 순번
-- ORDER BY 연봉;    -- 별칭 사용 가능
-- ORDER BY 는 숫자 뿐만 아니라 문자열, 날짜도 정렬 가능



------------------------------------
