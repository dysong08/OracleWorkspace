/*
    INDEX : 
    데이터를 빠르게 검색하기 위한 구조로 데이터의 정렬과 탐색과 같은 DBMS성능향상을 목적으로 사용


    <INDEX>
    책에서 '목차'같은 역할을 하는 DBMS객체
    
    테이블에서 데이터를 조회(SELECT)할때 인덱스가 없다면 
    테이블의 모든 데이터를 하나하나 뒤져서(FULL-SCAN) 내가 원하는 데이터를 검색한다.
    
    인덱스 설정을 해두면 테이블의 모든행을 뒤지지 않고 
    내가 원하는 조건만 빠르게 검색이 가능하다
    
    인덱스로 설정한 칼럼의 데이터들을 별도로 "오름차순으로 정렬"하여
    특정 메모리 공간에 물리적 주소값과 실제 칼럼의 값을 함께 저장시킨다.


*/

-- 현재 계정에 생성된 인덱스들
SELECT * FROM USER_INDEXES;

SELECT * FROM USER_IND_COLUMNS;

SELECT * 
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME = '송종기';


-- 일반 칼럼 인덱스 생성하기
CREATE INDEX IND_EMPLOYEE ON EMPLOYEE(EMP_NAME);

-- 인덱스 추가 후 인덱스 사용여부 확인하기 F10
SELECT * 
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME = '송종기';


-- 여러 칼람에 인덱스 부여 가능
CREATE INDEX IND_EMPLOYEE_COM ON EMPLOYEE(EMP_NAME, DEPT_CODE);

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '박나라' AND DEPT_CODE = 'D5';

/*
    인덱스의 장점
    1) WHERE절에 인덱스 칼럼을 사용시 훨씬 빠르게 연산 가능
    2) ORDER BY 연산을 사용할 필요가 없다. (이미 정렬되어 있다.)
    3) MIN, MAX값을 찾을때 연산속도가 매우 빠름(이미 정렬되어 있기 때문)
    
    인덱스의 단점
    1) 인덱스가 많을수록 저장공간이 부족해지게 되므로
        적절한 수준을 유지해야 한다
    2) INDEX를 활용한 INDEX-SCAN보다 단순한 FULL-SCAN이 더 유리할 때가 있음
        일반적으로 테이블의 전체 데이터중 10~15%의 데이터를 처리하는 경우에만 효율적이다
    3) DML에 취약하다(INSERT, UPDATE, DELETE)
        데이터가 새롭게 추가,수정,삭제되면 인덱스테이블 안에 있는 값들을 다시 정렬하고
        물리적 주소값을 수정해 줘야한다.
*/






