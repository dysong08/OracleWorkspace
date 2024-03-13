/*
    <SUBQUERY 서브쿼리>
    하나의 주된 SQL안에 포함된 또 하나의 SELECT문
    
    메인 SQL문을 위해서 보조 역할을 하는 SELECT문
    => 주로 조건절에서 많이 쓰인다.
*/

-- 간단 서브퀘리 예시1
-- 노옹철 사원과 같은 부서인 사원들
-- 1) 노옹철 사원의 부서코드를 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 2) 부서코드가 D9인 사원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 위 두단계 합치기
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 
    (SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '노옹철');
-- FROM -> WHERE -> 


-- 간단 서브퀘리 예시2
-- 전체사원의 평균 급여보다 더 많은 급여를 받고 있는 사원들의 사번, 이름, 직급코드 조회
-- 1) 전체 사원의 평균급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 2) 급여가 3047000원 이상인 사원들 조회
SELECT EMP_NO, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3047000;

-- 위 두단계 합치기
SELECT EMP_NO, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);


/*
    서브쿼리 구분
    서브쿼리를 수행한 결과값이 몇행 몇열이냐에 따라 분류됨
    
    - 단일행 (단일열) 서브쿼리 : 서브쿼리를 수행한 결과값이 오로지 1개일 때(한칸의 칼럼값을 나올때)
    - 다중행 (단일열) 서브쿼리 : 결과값이 여러 행일때
    - (단일행) 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 열일때
    - 다중행 다중열 서브쿼리  : 서브쿼리를 수행한 결과값이 여러행 여러열일때
    
    => 서브쿼리를 수행한 결과가 몇행 몇열이냐에 따라 사용가능한 연산자가 달라짐
*/

-----------------------------------------------------------------

/*
    1. 단일행 단일열 서브쿼리(SINGLE ROW SUBQUERY)
    서브쿼리의 조회 결과값이 오로지 1개일 때
    
    사용가능 연산자 => =, != , <=, >=, ...
*/

-- 전 직원의 평균 급여보다 더 적게 받는 사원들의 사원명, 직급코드, 급여조회
-- 1) 전 직원의 평균 급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 2) 급여가 평균(3047000원)보다 적게 받는 사원들 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < 3047000;
              
-- 위 두단계 합치기
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);


-- 최저 급여를 받는 사원의 사번, 사원명, 직급코드, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);


-- 노옹철사원보다 급여를 더 많이 받는 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');

-- 노옹철사원보다 급여를 더 많이 받는 사원의 사번, 이름, 부서명, 급여 조회
--(서브쿼리+조인)
-- 오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+)
AND SALARY > (SELECT SALARY FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');
                
-- ANSI구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID(+))
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');
                

-- 부서별 급여 합이 가장 큰 부서 하나만을 조회. 부서코드, 부서명, 급여의 합
-- (서브쿼리, GROUP BY, JOIN)

-- 1) 각 부서별 급여 합 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
                
-- 2) 총 급여가 가장 큰 부서 조회            
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;               
                
-- 3) 위 두단계 합치기
SELECT DEPT_CODE, DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_CODE, DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE );             
                
 -----------------------------------------------------------------
 
 /*
    2. 다중행 서브쿼리(MULTI ROW SBUQUERY)
    
    서브쿼리의 조회 결과값이 여러 행일 경우
    
    - IN (10,2030) 서브쿼리 : 여러개의 결과값 중에서 하나라도 일치하는 것이 있다면
    - > OR < ANY(10,20,30) : 여러개의 결과값 중에서 "하나라도" 크거나 작을 경우
    - > OR < ALL (10,20,30) : 여러개의 결과값의 "모든" 값보다 크거나 작을 경우
 */
 
 -- 각 부서별 최고 급여를 받는 사원의 이름, 직급코드, 급여 조회
 --1) 각 부서별 최고 급여 조회(다중행, 단일열)
 SELECT MAX(SALARY)
 FROM EMPLOYEE
 GROUP BY DEPT_CODE;
 
 -- 2) 위 급여를 받는 사원들 조회
 SELECT EMP_NAME, JOB_CODE, SALARY
 FROM EMPLOYEE
 WHERE SALARY IN (2890000,3660000,8000000,3760000,3900000,2490000,2550000);

 -- 3) 두 쿼리문 합치기
 SELECT EMP_NAME, JOB_CODE, SALARY
 FROM EMPLOYEE
 WHERE SALARY IN ( SELECT MAX(SALARY)
                    FROM EMPLOYEE
                    GROUP BY DEPT_CODE);
 
 
 -- 선동일 또는 유재식 사원과 같은 부서인 사원들 조회(사원명, 부서코드, 급여)
 SELECT DEPT_CODE
 FROM EMPLOYEE
 WHERE EMP_NAME IN ('선동일', '유재식');
 
 SELECT EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE IN ( SELECT DEPT_CODE
                      FROM EMPLOYEE
                      WHERE EMP_NAME IN ('선동일', '유재식'));
 
 
 -- 대리 직급임에도 불구하고 과장 직급의 급여보다 많이 받는 사원들 조회
 --(사번, 이름, 직급명, 급여) / 사원 < 대리 < 과장 < 차장 < 부장
 
 -- 1) 과장 직급들의 급여 조회
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'; -- 2200000,2500000,3760000
 
 -- 2) 위 급여목록들보다 하나라도 높은 급여를 받는 직원들 조회
SELECT EMP_NO, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리' AND SALARY >= ANY(SELECT SALARY
                                    FROM EMPLOYEE
                                    JOIN JOB USING(JOB_CODE)
                                    WHERE JOB_NAME = '과장');
 
-- 과장 직급임에도 모든 차장직급의 급여보다 더 많이 받는 직원 조회
--(사번, 이름, 직급명, 급여)

-- 1) 
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장' 
AND SALARY > ALL(SELECT SALARY
                 FROM EMPLOYEE
                JOIN JOB USING(JOB_CODE)
                WHERE JOB_NAME = '차장');

-----------------------------------------------------------------
    
/*
    3. (단일행) 다중열 서브쿼리
    서브쿼리 조회 결과가 값은 한행이지만 나열된 칼럼은 여러개인 경우
*/       
           
-- 하이유 사원과 같은 부서코드, 같은 직급코드에 해당되는 사원들 조회
-- (사원명, 부서코드, 직급코드, 고용일)

-- 1) 하이유 사원의 부서코드, 직급코드 조회
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유';

-- 2) 부서코드가 D5이면서 J5직급인 사원들 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND JOB_CODE ='J5';

-- 3) 위 두 쿼리문을 하나로 합치기
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '하이유')
AND JOB_CODE = (SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '하이유');
-- 다중열 서브쿼리 (비교할 값의 순서를 맞춰서 칼럼값을 나열)
-- WHERE(비교대상칼럼1, 비교대상칼럼2) = (비교할값1, 비교할값2 => 서브쿼리 형식으로 제시해야 함)


SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
--WHERE (DEPT_CODE, JOB_CODE) = ('D5', 'J5'); -- 리터럴값 제시불가함

WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '하이유');


-- 박나라 사원과 같은 직급코드, 같은 사수사번을 가진 사원들 조회
--(사번, 이름, 직급코드, 사수사번)
-- 단일행 다중열 서브쿼리 이용하여 작성
SELECT JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '박나라';

SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '박나라');

-----------------------------------------------------------------

/*
    4. 다중행 다중열 서브쿼리
    서브쿼리 조회 결과가 여러 행 여러 칼럼일 경우
*/

-- 각 직급별 최소급여를 받는 사원들 조회(사번, 이름, 직급코드, 급여)
-- 1) 각 직급별 최소급여 조회
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2) 위 목록들 중 일치하는 사원 조회
-- 2-1) 조건 나열 (OR)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE = 'J2' AND SALARY = '3700000')
    OR (JOB_CODE = 'J2' AND SALARY = '1380000')
;
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                        FROM EMPLOYEE
                        GROUP BY JOB_CODE);



-- 각 부서별 최고 급여를 받는 사원들 조회(사번,이름, 부서코드,급여)
-- 부서가 없을 경우 부서명은 없음으로 조회

-- 1) 부서별 최고 급여 조회
SELECT NVL(DEPT_CODE, '없음'), MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE, '없음'), SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE,'없음'), SALARY) IN (SELECT NVL(DEPT_CODE, '없음'), MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE)
ORDER BY 1;


SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE)
ORDER BY 1;

-----------------------------------------------------------------

/*
    5. 인라인 뷰(INLINE VIEW)
    FROM 절에 서브쿼리를 제시하는 것
    
    서브쿼리를 수행한 결과를 테이블 대신해서 사용함
*/

-- 보너스 포함 연봉이 3000만원 이상인 사원들의 사번, 이름, 보너스포함연봉, 부서코드 조회
SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 "보너스 포함 연봉", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + SALARY*NVL(BONUS,0))*12 >= 30000000;

-- 인라인 뷰를 사용하여 사원명만 골라내기
SELECT EMP_NAME
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 "보너스 포함 연봉", DEPT_CODE)
FROM EMPLOYEE
WHERE (SALARY + SALARY*NVL(BONUS,0))*12 >= 30000000;

-- EX)
SELECT EMP_ID
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 "보너스 포함 연봉", DEPT_CODE
        FROM EMPLOYEE
        WHERE (SALARY + SALARY*NVL(BONUS,0))*12 >= 30000000);

SELECT EMP_ID
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 "보너스 포함 연봉", DEPT_CODE
        FROM EMPLOYEE
        WHERE (SALARY + SALARY*NVL(BONUS,0))*12 >= 30000000)
WHERE DEPT_CODE IS NULL;

-- 실행순서 : FROM -> SUBQURTY FROM -> 



-- 인라인 뷰를 주로 사용하는 예
-- TOP-N분석 : DB상에 있는 자료중 최상위 N개의 자료를 보기 위해 사용하는 기능

-- 전 직원중 급여가 가장 높은 상위 5명(순위, 사원명, 급여)
-- * ROWNUM : 조회된 순서대로 1부터 순번을 부여해주는 칼럼(오라클에서 제공해주는 칼럼)
SELECT E.*, ROWNUM FROM EMPLOYEE E;

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
-- 정렬순서가 이상함

-- 해결 : ORDER BY로 정렬한 테이블을 가지고 ROWNUM을 부여하기
SELECT  ROWNUM, EMP_NAME, SALARY
FROM (  SELECT * 
        FROM EMPLOYEE 
        ORDER BY SALARY DESC  )
WHERE ROWNUM <= 5;



-- 각 부서별 평균 급여가 높은 부서의 부서코드 3개, 평균 급여 조회
-- 1) 각 부서별 평균 급여
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 2 DESC;

-- 2) 순번부여, 상위 3개만 추리기
SELECT ROWNUM "순위", S.* /*DEPT_CODE, ROUND(AVG(SALARY))*/
FROM ( SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS "평균급여"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY 2 DESC ) S --별칭붙이기
WHERE ROWNUM <= 3;

-- ROWNUM을 이용해서 순위를 매길 수 있다.
-- 다만, 정렬이 되지 않은 상태에서는 순위를 매겨도 의미가 없으므로
-- 선 정렬 후 순위 매기기를 해야 한다.
-- 즉, 인라인뷰로 먼저 ORDER BY를 하고 메인쿼리에서 순번을 매겨야 함


-----------------------------------------------------------------

/*
    6. WINDOW FUNCTION(순위 매기는 함수)
    -> SELECT절에서만 기술 가능
    
    RANK() OVER(정렬기준)
    DENSE_RANK() OVER(정렬기준)
    
    - RANK() OVER(정렬기준) : 공동 1위가 3명이면 그 다음순위는 4위
    - DENSE_RANK() OVER(정렬기준) : 공동 1위가 3명이면 그 다음순위는 2위
    
    정렬기준 : ORDER BY절(정렬기준 칼럼이름, 오름차순/내림차순)
*/

-- 사원들의 급여가 높은 순서대로 매겨서 사원명, 급여, 순위 조회 
-- RANK() OVER
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;


-- DENSE_RANK() OVER
SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;


-- 인라인뷰로 5위까지만 조회하기
SELECT E.*
FROM (SELECT EMP_NAME, SALARY, 
        DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
        FROM EMPLOYEE) E
WHERE "순위" <= 5;







