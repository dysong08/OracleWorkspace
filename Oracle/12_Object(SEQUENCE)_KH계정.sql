/*
    <시퀀스 SEQUENCE>
    
    자동으로 번호를 발생시켜주는 역할을 하는 객체(자동번호 부여기)
    정수값을 자동으로 순차적으로 발생시켜준다(연속된 숫자)
    
    순차적으로 "겹치지 않는" 숫자를 채번할 때 사용
    => 사번, 회원번호, 게시글번호, 이미지번호 등등..

    [표현법]
    CREATE SEQUENCE 시퀀스명
    START WITH 시작숫자 -> 처음 발생시킬 시작값 설정(DEFALUT 1)
    INCREMENT BY 증가값 -> 증가시킬 다음값 (DEFALUT 1)
    MAXVALUE 최대값     -> 최대값 지정
    MINVALUE 최소값     -> 최소값 지정
    CYCLE/NOCYCLE      -> 값의 순한여부(최대값 까지 증가 후 초기화 여부)(DEFALUT NOCYCLE)
    CACHE 바이트크기/NOCACHE -> 캐시메모리 사용여부(CACHES_SIZE : DEALUT 20BYTE)
    
    * 캐시메모리란?
    시퀀스로부터 미리 발생될 값들을 생성해서 저장해두는 공간
    매번 호출할 때마다 새로이 번호를 생성하는 것보단
    캐시메모리 공간에 미리 생성된 값들을 가져다 쓰게 되면 훨씬 속도가 빠르다.
    단, 접속이 끊기고 나서 재접속 후에는 기존에 생성해놨던 값들은 초기화 된다.
*/

CREATE SEQUENCE SEQ_TEST;


-- 시퀀스 데이터 딕셔너리
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;


/*
    2. 시퀀스 사용 구문
    
    시퀀스명.CURRVAL : 현재 시퀀스의 값을 반환(마지막으로 성공적으로 발생된 NEXTVAL 값)
    시퀀스명.NEXTVAL : 현재 시퀀스의 값을 증가시키고 증가된 시퀀스의 값을 반환
                        => 시퀀스명.CURRVAL + INCREMENT_BY 값만큼 증가된 값
                        
    단, 시퀀스 생성 후 첫 NEXTVAL은 START WITH로 지정된 시작값으로 발생된다.
    NEXTVAL이 호출되지 않았다면 CURRVAL은 수행 불가하다.
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
-- 시퀀스가 생성되고 나서 NEXTVAL을 한번이라도 수행해야 CURRVAL을 수행 할 수 있음.
-- CURRVAL은 마지막에 성공적으로 수행된 NEXTVAL을 보여주는 임시값이기 때문.

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;

SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- LAST_NUMBER : 현재 상황에서 앞으로 NEXTVAL을 수행할 경우의 예정값

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;


/*
    3. 시퀀스 변경
    
    [표현법]
    ALTER SEQUENCE 시퀀스명
    INCREMENT BY 증가값
    MAXVALUE 최대값
    MINVALUE 최소값
    CYCLE/NOCYCLE
    CACHE 크기/NOCACHE
    
    => START WITH는 변경 불가
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;


-- 시퀀스 삭제
DROP SEQUENCE SEQ_EMPNO;
SELECT * FROM USER_SEQUENCES;


-- 사번 채번용 시퀀스 생성(시퀀스명 SEQ_EID)
CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 10
MAXVALUE 400; 

--수정할때
ALTER SEQUENCE SEQ_EID
INCREMENT BY 10
MAXVALUE 400;


-- 사원이 추가될 때 실행할 INSERT문
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES (SEQ_EID.NEXTVAL, '이말동', '990101-1234567', 'J2', 'S3');

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES (SEQ_EID.NEXTVAL, '고길동', '990101-1234567', 'J2', 'S3');

SELECT * FROM EMPLOYEE;



-- 시퀀스를 사용할 수 없는 구문

-- VIEW의 SELECT
-- DISTINCT가 포함된 SELECT
-- GROUP BY절이 있는 SELECT
-- SELECT, UPDATE, DELETE등에서의 서브쿼리내부
-- CREATE TABLE, ALTER TABLE의 DEFALUT로 사용불가






