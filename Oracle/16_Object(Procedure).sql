/*
    <PROCEDURE> 프로시져
    PL/SQL문을 저장해서 이용하는 객체
    필요할 때마다 내가 작성한 PL/SQL문을 편하게 호출 가능하다
    
    * 프로시져 생성방법
    [표현식]
    CREATE [OR REPLACE] PROCEDURE 프로시저명1[(매개변수)]
    IS
    BEGIN
        실행부분
    END;
    
    
    * 프로시져 실행방법
    EXEC 프로시져명;
*/

-- EMPLOYEE테이블 복사
CREATE TABLE PRO_TEST
AS SELECT * FROM EMPLOYEE;

CREATE PROCEDURE DEL_DATA
IS
--지역변수 선언
BEGIN
    DELETE FROM PRO_TEST;
    COMMIT;
END;
/

SELECT * FROM PRO_TEST;


-- 생성된 프로시져 실행
EXEC DEL_DATA;
SELECT * FROM PRO_TEST;



-- 프로시져에 매개변수 추가하기
-- IN : 프로시져를 실행시 필요한 값을 "입력받는" 변수(자바의 매개변수와 동일하게 사용됨)
-- OUT : 프로시져를 호출한 곳으로 값을 "되돌려주는" 변수(결과값)

CREATE OR REPLACE PROCEDURE PRO_SELECT_EMP(
    V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
    V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SALARY OUT EMPLOYEE.SALARY%TYPE,
    V_BONUS OUT EMPLOYEE.BONUS%TYPE
    )
IS
BEGIN
    SELECT EMP_NAME, SALARY, BONUS
    INTO V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/


-- 매개변수 추가한 프로시져 실행하기
-- 실행 후 결과값을 저장할 변수 선언

VAR EMP_NAME VARCHAR2(20);
VAR SALARY NUMBER;
VAR BONUS NUMBER;

EXEC PRO_SELECT_EMP(200, :EMP_NAME, :SALARY, :BONUS);

PRINT EMP_NAME;
PRINT SALARY;
PRINT BONUS;


/*
    * 프로시져 장점
    1. 처리속도가 빠르다.
    2. 대량 자료처리시 유리함.
    EX) DB에서 대용량의 데이터를 SELECT문으로 받아온 후 자바에서 처리하는 경우 VS
        DB에서 대용량의 데이터를 SELECT한 후 자바로 넘기지 않고 직접 DB에서 처리하는 경우
    DB에서 처리하는 것이 성능이 좋음(데이터를 넘길때마다 네트워크 비용 발생)
    
    
    * 프로시져 단점
    1. DB자원을 직접 사용하기 때문에 DB에 부하를 주게된다.
    2. 관리적 측면에서 자바소스코드, 오라클 코드를 동시에 형상관리하기 어렵다.
    
    
    정리)
    한 번에 처리되는 데이터량이 많고 성능을 요구하는 처리는 DB상에서 처리하는 것이 낫고
    소스관리 측면에서는 자바로만 관리하는 것이 좋다.
*/


-----------------------------------------------------------------------

/*
    <FUNCTION>
    프로시져와 마찬가지로 내부에 PL/SQL를 작성할 수 있고
    실행결과를 반환 받을 수 있음.
    
    
    * FUNCTION 생성방법
    [표현식]
    CREATE FUNCTION 펑션명 [(매개변수)]
    RETUEN 자료형
    IS
    BEGIN
        실행부분
    END;    

*/

CREATE FUNCTION MYFUNC(V_STR VARCHAR2)
RETURN VARCHAR2
IS
    RESULT VARCHAR2(1000);
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_STR);
    RESULT := V_STR || '!!!!!';
    
    RETURN RESULT;
END;
/

SELECT MYFUNC('길동') FROM DUAL;



-- 사원의 사번을 전달받아서 연봉을 계산해서 반환해주는 함수 만들기,.
CREATE OR REPLACE FUNCTION CALC_SALARY(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS
    E EMPLOYEE%ROWTYPE;
    RESULT NUMBER;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    RESULT := (E.SALARY + (E.SALARY* NVL(E.BONUS,0))) *12 ;
    RETURN RESULT;
END;
/

SELECT EMP_ID, CALC_SALARY(EMP_ID)
FROM EMPLOYEE;








