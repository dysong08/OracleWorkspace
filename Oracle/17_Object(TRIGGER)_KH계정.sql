/*
    <TRIGGER> 트리거
    내가 트리거로 지정한 테이블에 DML문(INSERT, UPDATE, DELETE) 등에 의해
    변경사항이 발생할 경우
    "자동으로" 매번 실행할 내용을 정의해 둘 수 있는 객체
    
    EX) 
    회원 탈퇴시 기존의 회원테이블에 데이터를 DELTE한 후 
    곧바로 탈퇴된 회원들만 따로 보관하는 테이블에 자동으로 INSERT 시킬때
    
    신고 횟수가 일정수를 넘었을때 회원을 블랙리스트 처리 하고자 할때
    
    입출고에 대한 데이터가 기록될 때마다 해당 상품에 대한 재고수량을 
    매번 수정해줘야 할때..
    
    * 트리거 종류
    SQL문 시행시기에 따른 분류
    > BEFORE TRIGGER : 내가 지정한 테이블에 DML(INSERT, UPDATE, DELETE)가
                    발생되기 전에 트리거 먼저 실행
    
    > AFTER TRIGGER : 내가 지정한 테이블에 DML가 발생된 후 트리거 실행
    
    
    * SQL문에 영향을 받는 각 행에 따른 분류
    > STATEMENT TRIGGER(문장트리거) : DML이 발생한 SQL문에 딱 한 번만 트리거를 실행
    > ROW TRIGGER(행 트리거) : 해당 SQL문을 실행할 때마다 매번 트리거 실행
        :OLD - BEFORE UPDATE, BEFORE DELETE에서 사용
        :NEW - AFTER INSERT, AFTER UPDATE에서 사용
    
    
    * 트리거 생성구문
    [표현식]
    CREATE OR REPLACE TRIGGER 트리거명
    BEFORE|AFTER INSERT|DELETE|UPDATE ON 테이블명
    [FOR EACH ROW] <- 행트리거 만들때 구문(없으면 문장트리거)
    BEGIN
        실행내용(위 지정한 이벤트 발생시 자동으로 실행할 구문)
    END;
    /
 
*/


-- EMPLOYEE 테이블에 새로운 행이 추가될 때마다 자동으로 메세지를 출력해주는 트리거 정의하기
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다.');
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES (905, '홍길동', '990101-1234567', 'J1', 'S1');

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES (906, '김갑생', '880101-1234567', 'J2', 'S3');

SELECT * FROM EMPLOYEE;

-----------------------------------------------------------------

-- 상품 입출고 관련 예시
-- <필요한 테이블 및 시퀀스 생성

-- 1. 상품에 대한 데이터를 보관할 테이블 생성(TB_PRODUCT)
CREATE TABLE TB_PRODUCT (
    PCODE NUMBER PRIMARY KEY,   -- 코드
    PNAME VARCHAR2(30) NOT NULL,    -- 상품명
    BRAND VARCHAR2(30) NOT NULL,    -- 브랜드명
    PRICE NUMBER,           -- 가격
    STOCK NUMBER DEFAULT 0  -- 재고
    );


-- 상품번호용 시퀀스
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5;


-- 샘플데이터 추가
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL, '갤럭시Z플립5', '삼성', 1350000, DEFAULT);
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL, '갤럭시11', '삼성', 1000000, 10);
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL, '아이폰14', '애플', 1500000, 20);

COMMIT;


-- 2. 상품 입출고 상세 이력 테이블 생성(TB_PRO_DETAIL)
-- 어떤 상품이 어떤 날짜에 몇개가 입고 또는 출고 되었는지 데이터를 기록

CREATE TABLE TB_PRO_DETAIL (
    DCODE NUMBER PRIMARY KEY,   -- 이력번호
    PCODE NUMBER REFERENCES TB_PRODUCT, -- 상품번호
    PDATE DATE NOT NULL,    -- 상품입출고일
    AMOUNT NUMBER NOT NULL,  -- 입출고 수량
    STATUS CHAR(6) CHECK(STATUS IN ('입고','출고')) -- 상태(입고,출고)
    );

-- 입출고용 시퀀스 생성
CREATE SEQUENCE SEQ_DCODE;

-- 200번 상품이 오늘 날짜로 10개 입고
INSERT INTO TB_PRO_DETAIL
VALUES (SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '입고');

-- 입고내용 확인
SELECT * FROM TB_PRO_DETAIL; -- 입고내용 적용됨
SELECT * FROM TB_PRODUCT;   -- 입고내용 적용안됨

-- 200번 상품의 재고수량 10개 증가시키기
UPDATE TB_PRODUCT 
    SET STOCK = STOCK +10
    WHERE PCODE = 200;

SELECT * FROM TB_PRODUCT;  -- 입고내용 적용시킴


-- TB_PRO_DETAIL 테이블에 상품이 INSERT 되면 
-- TB_PRODUCT 테이블에 매번 자동으로 재고수량이 UPDATE되게끔 트리거 정의하기

/*
    - 상품이 입고된 경우 -> 입고된 상품을 찾아서 재고수량 증가시키기(UPDATE)    
    - 상품이 출고된 경우 -> 출고된 상품을 찾아서 재고수량 감소시키기(UPDATE)
*/

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRO_DETAIL
FOR EACH ROW 
BEGIN
    -- 상품이 입고되었는지 출고되었는지 확인하기
    IF (:NEW.STATUS = '입고' )
        THEN
        UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    ELSE
        UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;    
END;
/

-- 200번 상품이 오늘 날짜로 10개 입고
INSERT INTO TB_PRO_DETAIL
VALUES (SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '입고');

SELECT * FROM TB_PRODUCT;
-- 입고시 자동으로 재고 수량이 적용된다.


/*
    * 트리거 장점
    1. 데이터 추가, 수정, 삭제시 자동으로 데이터를 관리해줌으로써 무결성 보장
    2. DB 관리의 자동화
    
    * 트리거 단점
    1. 빈번한 추가, 수정, 삭제시 ROW의 삽입, 추가, 삭제가 함께 실행되므로
        성능상 좋지 못하다.
    2. 관리적 측면에서 형상관리가 불가능하다.
    3. 트리거를 남용하게 되는 경우 예상하지 못하는 상황이 발생할 수 있고 처리하기 힘들다.
*/















