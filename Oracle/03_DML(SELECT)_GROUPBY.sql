/*
    <GROUP BY 절>
    
    그룹을 묶어줄 기준을 제시할 수 있는 구문 => 그룹함수와 같이 쓰임
    제시된 기준별로 그룹을 묶어줄 수 있다.
    여러 개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용함
    
    [표현법]
    GROUP BY 묶어줄 기준이될 칼럼
*/

-- 각 부서별로 총 급여의 합계
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE;
-- 반환해줄 갯수가 서로 다르기 때문에 에러발생함

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 'D1'부서의 총 급여의 합계
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- 각 부서별 사원 수 합계
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 총 급여합을 부서별 오름차순으로 정렬해서 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

-- 실행순서
-- FROM -> GROUP BY -> SELECT -> ORDER BY 

-- 각 부서별의 총 급여합 오름차순 정렬
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 2 DESC;


-- 각 직급별로 직급코드, 총 급여의 합, 사원수, 보너스를 받는 사원수, 평균급여, 최고급여, 최소급여
SELECT JOB_CODE, SUM(SALARY), COUNT(*), COUNT(BONUS), MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 각 부서별 부서코드, 사원수, 보너스를 받는 사원수, 사수가 있는 사원수, 평균 급여
SELECT DEPT_CODE, COUNT(*), COUNT(BONUS), COUNT(MANAGER_ID), ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 성별별 사원수
-- 성별 : SUBSTR(EMP_NO, 8, 1)
SELECT COUNT(*), SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- 성별 기준으로 평균 급여
SELECT ROUND(AVG(SALARY)) || '원' 평균급여,
       CASE SUBSTR(EMP_NO, 8, 1) WHEN '1' THEN '남자'
       ELSE '여자' END 성별
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
 
-- 각 부서별로 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000
GROUP BY DEPT_CODE;
-- 실행순서 : FROM -> WHERE 순이기 때문에 GROUP화 되기 전이라 에러발생함

/*
    <HAVING 절>
    
    그룹에 대한 조건을 제시하고자 할 때 사용되는 구문
    (주로 그룹함수를 가지고 조건 제시) => 항상 GROUP BY절과 사용된다.
*/

-- 각 부서별 평균급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;
-- 실행순서 : FROM -> HAVING -> WHERE


-- 각 직급별 총 급여합이 1000만원 이상인 직급 코드, 급여 합을 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- 각 부서별 보너스를 받는 사원이 없는 부서만 조회
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;



/*
    <ROLLUP>과 <CUBE>
    - 그룹별 산출결과 값의 "집계"를 계산하는 함수
    
    -ROLLUP(그룹 기준에 해당하는 칼럼명/함수식, 그룹 기준에 해당하는 칼럼명/함수식)
            : 인자로 전달받은 그룹중 가장 먼저 지정한 그룹을 기준으로 추가 집계 결과를 반환해줌
            
    -CUBE(그룹 기준에 해당하는 칼럼명/함수식, 그룹 기준에 해당하는 칼럼명/함수식)
            : 인자로 전달받은 그룹들로 가능한 모든 조합별 집계를 반환해줌
*/

-- 부서별 직급별 급여 합계
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;
-- JOB_CODE를 제외한 DEPT_CODE에 대한 추가집계 결과만 반환

-- 모든 조합별 통계를 구함
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

-------------------------------------------------------------

/*
    <SELECT 문 구조 및 실행순서>
    
    5. SELECT : 조회하고자 하는 칼럼명들 / * / 리터럴 / 산술연산식 / 함수식 
    1. FROM : 조회하고자 하는 테이블명 / DUAL(가상테이블)
    2. WHERE : 조건식(그룹함수는 사용불가)
    3. GROUP BY : 그룹 기준에 해당하는 칼럼명 / 함수식
    4. HAVING : 그룹함수식에 대한 조건식
    6. ORDER BY : 정렬하고자 하는 칼럼명 / 순번 / 별칭 [ASC/EDSC] [NULLS FIRST/LAST]
*/

-------------------------------------------------------------

/*
    <집합연산자 SET OPERATOR>
    
    여러 개의 쿼리문을 하나의 쿼리문으로 만드는 연산자
    
    - UNION(합집합) : 두 쿼리문을 수행한 결과값(RESULTSET)을 더한 후 중복되는 부분은 한 번 빼서 중복을 제거한 것
    - UNION ALL : 두 쿼리문을 수행한 결과값을 더한 후 중복되는 값은 제거하지 않은 것
    - INTERSECT(교집합) : 두 쿼리문을 수행한 결과값의 중복된 값만 남긴 것
    - MINUS(차집합) : 선행 쿼리문의 결과값에서 후행 쿼리문의 결과값을 뺀 나머지 부분
    
    ** 주의할 점 : 두 쿼리문을 실행한 결과를 합쳐서 한개의 RESULTSET으로 보여줘야 하기 때문에
            두 쿼리문을 수행한 SELECT 절 부분은 동일해야 한다.
            => 조회할 칼럼이 동일해야 한다.
*/

-- 1. UNION(합집합) : 두 쿼리문을 수행한 결과값(RESULTSET)을 더한 후 중복을 제거
-- 부서코드가 D5이거나 또는 급여가 300만원 초과인 사원들 조회(사번, 사원명, 부서코드, 급여)

-- UNION 미사용 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';  -- 6명(박나라~대북혼)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;   -- 8명(선동일~전지연)


-- UNION 사용 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'  -- 6명(박나라~대북혼)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;   -- 8명(선동일~전지연)
-- 대북혼, 심봉선은 부서가 D5이면서 300만원 초과이기 때문에 중복값은 제거됨 ->12명


-- 직급코드가 J6이거나 부서코드가 D1인 사원들만 조회(사번, 사원명, 부서코드, 직급코드)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' 
UNION /*ALL*/
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';
--UNION ALL : 여러개의 쿼리결과를 더해서 중복값 포함 출력된다.


-- 3. INTERSECT : 교집합, 여러 쿼리 결과의 중복된 결과만을 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' 
INTERSECT 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';


-- 4. MINUS : 차집합, 선행 쿼리결과에서 후행 쿼리결과를 뺀 나머지를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' 
MINUS 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';
