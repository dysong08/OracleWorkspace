/*
    * TCL (TRANSACTION CONTROL LANGUAGE)
    트랜잭션을 제어하는 언어
    
    * 트랜잭선(TRANSACTION)
    - DB의 논리적 작업 단위
    - 데이터의 변경사항(DML에 의한)들을 하나의 트랜잭션으로 묶어서 처리
        => COMMIT(확정)하기 전까지의 변경사항들을 하나의 트랜잭션으로 모아둔다.
        
    - 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE
    
    * 트랜잭션의 종류
    - COMMIT : 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하겠다는 것을 의미
    - ROLLBACK : 변경사항들을 실제 DB에 반영하지 않겠다는 것을 의미
                트랜잭션에 담겨있는 변경사항도 다 삭제한 후 마지막 COMMIT시점으로 돌아간다
                
    - SAVEPOINT 포인트명; : 현재 시점으로 임시저장점을 정의해 두는 것.
    - ROLLBACK TO 포인트명; : 전체 변경사항들을 삭제하는 것이 아니라 
                            해당 포인트 지점까지의 트랜잭션만 롤백함
*/


SELECT * FROM EMP_01;   -- 25행

DELETE FROM EMP_01 WHERE EMP_ID = 901;
DELETE FROM EMP_01 WHERE EMP_ID = 900;


ROLLBACK; -- 다시 25행


-- 사번이 200번인 사원 삭제
DELETE FROM EMP_01 WHERE EMP_ID = 200;

-- 사번 800번, 이름 홍길동, 부서 총무부 생성하기
INSERT INTO EMP_01
VALUES (800, '홍길동', '총무부');

COMMIT;

SELECT * FROM EMP_01; 
ROLLBACK;
-- COMMIT을 하면 ROLLBACK 안됨!!!!!!!

----------------------------------------------------------------

--EMP_01테이블에서 사번이 214, 216, 217인 사원들 삭제하기
DELETE EMP_01
WHERE EMP_ID IN (214,216,217);

SELECT * FROM EMP_01; 


-- 3개의 행이 삭제된 시점에 SAVEPOINT 지정하기
SAVEPOINT SP1; --임시저장


-- EMP_01 테이블에 사번 801번 이름 김말똥 인사부 사원을 추가
INSERT INTO EMP_01
VALUES (801, '김말똥','인사부');  -- 23행

DELETE FROM EMP_01
WHERE EMP_ID = 218;     -- 22행

SELECT * FROM EMP_01; 

ROLLBACK SP1;   -- SP1 이후의 트랜잭션만 취소됨. 25행

COMMIT;



-- 사번이 900, 901번인 사원들 삭제
DELETE FROM EMP_01
WHERE EMP_ID IN (900,901);


-- 테이블 생성(DDL)
CREATE TABLE TEST(
    TID NUMBER
    );

SELECT * FROM EMP_01; -- 21행

ROLLBACK;   -- 롤백안됨! 21행

/*
    주의사항 )
    DDL구문 (CREATE, ALTER, DROP)을 실행하는 순간
    기존에 트랜잭션에 있던 모든 변경사항은 무조건 실제 DB에 반영시킨 후 DDL에 수행됨
    즉, DDL 수행 전 변경사항이 있다면 정확히 픽스(COMMIT, ROLLBACK)을 하고 DDL을 실행해야 한다.
    
*/
-- ** COMMIT을 해야 다른 계정에서 조회가 가능하다! **






