/*
    <JOIN>
    
    두 개 이상의 테이블에서 데이터를 같이 조회하고자 할 때 사용되는 구문
    => SELECT 문을 이용
    조회결과는 하나의 결과물(RESULT SET)로 나옴
    
    JOIN을 해야 하는 이유?
    관계형 데이터베이스에서는 최소한의 데이터로 각각의 테이블에 데이터를 보관하고 있음
    사원정보는 사원테이블, 직급정보는 직급테이블, ..등등 => 중복을 최소화 하기 위해
    => 즉 JOIN 구문을 이용해서 여러개 테이블간의 "관계"를 맺어서 같이 조회해야함
    => 테이블 간의 "연결고리"에 해당되는 칼럼을 매칭시켜서 조회해야함
    
    문법상 종류 : JOIN은 크게 "ORACLE 전용 구문"과 "ANSI(미국 국립 표준 협회)구문"으로 나뉨
    
    개념상 분류 : 
            ORACLE 전용 구문         |       ANSI 구문
================================================================================
            등가조인(EQUAL JOIN)     |      내부조인(INNER JOIN) => JOIN USING/ON
================================================================================
            포괄조인                 |      외부조인(OUTER JOIN) => JOIN USING
            (LEFT OUTER JOIN)       |      왼쪽 외부조인(LEFT OUTER JOIN) 
            {RIGHT OUTER JOIN)      |      오른쪽 외부조인{RIGHT OUTER JOIN)
                  x                 |      전체 외부조인(FULL OUTER JOIN)
================================================================================
            카테시안 곱               |     교차조인
================================================================================
                            자체조인(SELF JOIN)
                            비등가조인(NON EQUAL JOIN)
                            다중조인(테이블 3개 이상 조인)
*/


-- JOIN을 사용하지 않는 예
-- 전체 사원들의 사번, 사원명, 부서코드, 부서명까지 알아내고자 한다면?
    
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;
    
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
    
    
-- JOIN을 통해서 연결고리에 해당되는 칼럼들만 매칭시키면 마치 하나의 결과물처럼 조회 가능

/*
    1. 등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
    연결시키고자 하는 칼럼의 값이 "일치하는 행들만" JOIN되서 조회
    (일치하지 않는 값들은 결과에서 제외)
    => 동등비교연산자를 제시한다
    
    [표현법]
    등가조인(오라클 구문)
    SELECT 조회하고자 하는 칼럼명들 나열
    FROM 조인하고자 하는 테이블명들 나열
    WHERE 연결할 칼럼에 대한 조건을 제시
    
    내부조인(ANSI구문) : ON 구문
    SELECT 조회하고자 하는 칼럼명들 나열
    FROM 기준으로 삼을 테이블명 1개 제시
    JOIN 조인할 테이블명 1개 제시 ON (연결할 칼럼에 대한 조건을 제시)
    
    내부조인(ANSI구문) : USING 구문 => (연결할 칼럼명이 동일한 경우에만 사용)
    SELECT 조회할 칼럼명들 나열
    FROM 기준으로 삼을 테이블명 1개 제시
    JOIN 조인할 테이블명 1개만 제시 USING (연결할 칼럼명 1개만 제시)
*/
    
    
-- 오라클 전용 구문
-- FROM 절에 조회할 테이블들을 ','로 나열 
-- WHERE 절에 연결고리에 대한 조건을 제시

-- 전체 사원의 사번, 사원명, 부서코드, 부서명
SELECT 
    EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;  -- 연결고리 제시
-- 일치하지 않는 값들은 조회되지 않음(NULL, D3, D4, D7)
--> 두개 이상의 테이블을 조인할 때 일치하는 값이 없는 행이 결과에서 제외된 것

    
-- 전체 사원들의 사번, 사원명, 직급코드, 직급명
-- 연결할 두 칼럼명이 동일한 경우 
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE;
-- 어떤 테이블의 칼럼인지 반드시 기술해야 한다.
    
    
-- 방법1) 테이블명을 이용하는 방법
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
    
-- 방법2) 테이블에 별칭을 붙여서 사용하는 방법
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;


-- ANSI 구문
-- FROM절에 기준 테이블을 "하나만"기술 한 뒤
-- 그 뒤에 JOIN절에서 같이 조회하고자 하는 테이블 기술, 또한 매칠시킬 칼럼에 대한 조건도 같이 기술
-- USING구문/ ON구문

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
/*INNER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);  -- 무조건 ON구문만 가능(칼럼명이 동일하지 않음)
-- DEPT_CODE가 NULL인 사원들은 조회되지 않음
-- INNER 생략가능함 


-- 연결할 두 칼럼명이 동일한 경우
-- ON구문과 USING구문 모두 사용 가능함

-- 1) ON구문 : 칼럼명이 애매모호하다라는 에러가 발생할 수 있기 때문에 반ㄱ드시 테이블명 OR 별칭을 기술
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);


-- 2) USING구문 : 칼럼명이 동일한 경우에만 사용 가능
--              동일한 칼럼명 하나만 써주면 알아서 매칭시켜줌
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME 
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);


-- 3) NATURAL JOIN : 등가조인의 방법 중 하나
-- 동일한 타입과 이름을 가진 칼럼을 조인 조건으로 이용하는 방법
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME 
FROM EMPLOYEE
NATURAL JOIN JOB;
-- 두 테이블간의 일치하는 칼럼이 유일하게 딱하나 존재할 때 해당 칼럼을 조인조건으로 세움
-- 실무에서 잘 사용하지 않음...


-- 조인시 추가적인 조건도 제시 가능하다
-- 직급이 대리인 사원들의 정보를 조회(사번, 사원명, 월급, 직급명)

-- 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME 
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE 
    AND JOB_NAME = '대리';


-- ANSI 구문
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME 
FROM EMPLOYEE E
JOIN JOB J ON (E.JOIN_CODE = J.JOB_CODE)
WHERE JOB_NAME = '대리';



------------ 실습문제 ------------
-- 1. 부서가 '인사관리부'인 사원들의 사번, 사원명, 보너스를 조회
-- 오라클 전용구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
    AND DEPT_TITLE = '인사관리부';

-- ANSI 구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';


--2. 부서가 '총무부'가 아닌 사원들의 사번, 사원명, 급여, 입사일 조회
-- 오라클 전용구문
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
    AND DEPT_TITLE <> '총무부';

-- ANSI 구문
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE ^= '총무부';


-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
-- 오라클 전용구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
    AND BONUS IS NOT NULL;

-- ANSI 구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. 아래의 두 테이블을 참고해서 부서코드, 부서명, 지역코드, 지역명(LOCAL_NAME) 조회
-- 오라클 전용구문
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;

SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;
    
-- ANSI 구문
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);


----------------------------------------------------------------------------

-- DEPT_CODE가 NULL인 사원들은 INNER JOIN으로 조회되지 않음
-- 즉 부서배정이 되지 않은 사원들은 조회되지 않음

/*
    2. 포괄조인 / 외부조인 (OUTER JOIN)
    테이블간의 JOIN시 "일치하지 않는 행"도 포함시켜서 조회 가능
    단, 반드시 LEFT 혹은 RIGHT를 지정해야 함 
    => LEFT시 왼쪽이 기준이 되는 테이블, RIGHT시 오른쪽이 기준이 되는 테이블
    
    일치하는 행과 기준이 되는 테이블 기준으로 일치하지 않은 행도 포함시켜서 조회
    
*/

-- 전체 사원들의 사원명, 급여, 부서명 조회
-- 1) LEFT OUTER JOIN : 두 테이블 중 왼편에 기술된 테이블을 기준으로 JOIN
-- 즉, 뭐가 되었든 간에 왼편에 기술된 테이블의 데이터는 무조건 조회되게 한다.
-- (일치하는 것이 없더라도 조회 가능)

-- ANSI 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE 
LEFT /*OUTER*/ JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 오라클 전용 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
-- 내가 기준으로 삼을 테이블의 칼럼명이 아닌 반대 테이블의 칼럼명에 (+)를 붙여준다.


-- 2) RIGHT OUTER JOIN : 두 테이블 중 오른편에 기술된 테이블을 기준으로 JOIN
-- 즉, 뭐가 되었든 간에 오른편에 기술된 테이블의 데이터는 무조건 조회되게 한다.
-- (일치하는 것이 없더라도 조회 가능)

-- ANSI 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE 
RIGHT /*OUTER*/ JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 오라클 전용 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;


-- 3) FULL OUTER JOIN : 두 테이블이 가진 모든 행을 조회
-- 일치하는 행들 + LEFT JOIN 기준 새롭게 추가된 행들 + RIGHT JOIN 기준 새롭게 추가된 행들

-- ANSI 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE 
FULL /*OUTER*/ JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 오라클 전용 구문 => 사용불가!!!
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);


----------------------------------------------------------------------------

/*
    3. 카테시안곱 / 교차조인
    
    모든 테이블의 각 행들이 서로 맵핑된 데이터가 조회됨(곱집합)
    두 테이블의 행들이 모두 곱해진 행들의 조합 출력
    
    => 각각 N개, M개의 행을 가진 테이블들의 카테시안 곱의 결과는  N*M행
    => 모든 경우의 수를 다 따져서 조회
    => 방대한 데이터를 출력할 위험이 있다.
*/

-- 사원명, 부서명
-- 오라클 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT;

-- ANSI 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;
-- 카테시안 곱의 경우 WHERE절에 기술하는 조인 조건이 잘못되었거나 아예 없을 경우 발생


----------------------------------------------------------------------------

/*
    4. 비등가 조인(NON_EQUAL JOIN)
    '='를 사용하지 않는 조인문 => 다른 비교연산자를 사용하여 조인
    (>, <, BETWEEN A AND B...) 
    => 지정한 칼럼 값들이 일치하는 경우가 아니라 "범위"에 포함되는 경우 매칭해서 조회
*/

-- 사원명, 급여
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT * FROM SAL_GRADE;


-- 사원명, 급여, 급여등급(SAL_LEVEL)
-- 오라클 전용 구문
SELECT EMP_NAME, SALARY, EMPLOYEE.SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
--WHERE EMPLOYEE.SAL_LEVEL = SAL_GRADE.SAL_LEVEL;
--WHERE SALARY >= NIN.SAL AND SALARY <= MAX.SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI 구문
SELECT EMP_NAME, SALARY, SAL_GRADE.SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);


----------------------------------------------------------------------------

/*
    5. 자체조인 (SELF JOIN)
    
    같은 테이블끼리 조인하는 경우
    즉, 자기자신의 테이블과 다시 조인을 맺겠다.
    => 자체조인시 반드시 테이블에 별칭을 부여해야 한다.
    (계층형(대-중-소-카테고리) 구조시 자주 사용된다!)
*/

-- 사원의 사번, 사원명, 사수의 사번, 사수명 조회
-- 오라클 전용 구문
SELECT E.EMP_ID, E.EMP_NAME, M.EMP_ID, M.EMP_NAME
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);

-- ANSI 구문
SELECT E.EMP_ID, E.EMP_NAME, M.EMP_ID, M.EMP_NAME
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID(+)); 


----------------------------------------------------------------------------

/*
    <다중 조인>
    3개 이상의 테이블을 조인해서 조회 => 조인 순서가 중요하다
*/

-- 사번, 사원명, 부서명, 직급명
-- 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE E.DEPT_CODE = DEPT_ID(+)
    AND E.JOB_CODE = J.JOB_CODE;
    

-- ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E 
LEFT JOIN DEPARTMENT ON E.DEPT_CODE = DEPT_ID
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;







