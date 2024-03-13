/*
    <TRIGGER> Ʈ����
    ���� Ʈ���ŷ� ������ ���̺� DML��(INSERT, UPDATE, DELETE) � ����
    ��������� �߻��� ���
    "�ڵ�����" �Ź� ������ ������ ������ �� �� �ִ� ��ü
    
    EX) 
    ȸ�� Ż��� ������ ȸ�����̺� �����͸� DELTE�� �� 
    ��ٷ� Ż��� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ��ų��
    
    �Ű� Ƚ���� �������� �Ѿ����� ȸ���� ������Ʈ ó�� �ϰ��� �Ҷ�
    
    ����� ���� �����Ͱ� ��ϵ� ������ �ش� ��ǰ�� ���� �������� 
    �Ź� ��������� �Ҷ�..
    
    * Ʈ���� ����
    SQL�� ����ñ⿡ ���� �з�
    > BEFORE TRIGGER : ���� ������ ���̺� DML(INSERT, UPDATE, DELETE)��
                    �߻��Ǳ� ���� Ʈ���� ���� ����
    
    > AFTER TRIGGER : ���� ������ ���̺� DML�� �߻��� �� Ʈ���� ����
    
    
    * SQL���� ������ �޴� �� �࿡ ���� �з�
    > STATEMENT TRIGGER(����Ʈ����) : DML�� �߻��� SQL���� �� �� ���� Ʈ���Ÿ� ����
    > ROW TRIGGER(�� Ʈ����) : �ش� SQL���� ������ ������ �Ź� Ʈ���� ����
        :OLD - BEFORE UPDATE, BEFORE DELETE���� ���
        :NEW - AFTER INSERT, AFTER UPDATE���� ���
    
    
    * Ʈ���� ��������
    [ǥ����]
    CREATE OR REPLACE TRIGGER Ʈ���Ÿ�
    BEFORE|AFTER INSERT|DELETE|UPDATE ON ���̺��
    [FOR EACH ROW] <- ��Ʈ���� ���鶧 ����(������ ����Ʈ����)
    BEGIN
        ���೻��(�� ������ �̺�Ʈ �߻��� �ڵ����� ������ ����)
    END;
    /
 
*/


-- EMPLOYEE ���̺� ���ο� ���� �߰��� ������ �ڵ����� �޼����� ������ִ� Ʈ���� �����ϱ�
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�.');
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES (905, 'ȫ�浿', '990101-1234567', 'J1', 'S1');

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES (906, '�谩��', '880101-1234567', 'J2', 'S3');

SELECT * FROM EMPLOYEE;

-----------------------------------------------------------------

-- ��ǰ ����� ���� ����
-- <�ʿ��� ���̺� �� ������ ����

-- 1. ��ǰ�� ���� �����͸� ������ ���̺� ����(TB_PRODUCT)
CREATE TABLE TB_PRODUCT (
    PCODE NUMBER PRIMARY KEY,   -- �ڵ�
    PNAME VARCHAR2(30) NOT NULL,    -- ��ǰ��
    BRAND VARCHAR2(30) NOT NULL,    -- �귣���
    PRICE NUMBER,           -- ����
    STOCK NUMBER DEFAULT 0  -- ���
    );


-- ��ǰ��ȣ�� ������
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5;


-- ���õ����� �߰�
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL, '������Z�ø�5', '�Ｚ', 1350000, DEFAULT);
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL, '������11', '�Ｚ', 1000000, 10);
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL, '������14', '����', 1500000, 20);

COMMIT;


-- 2. ��ǰ ����� �� �̷� ���̺� ����(TB_PRO_DETAIL)
-- � ��ǰ�� � ��¥�� ��� �԰� �Ǵ� ��� �Ǿ����� �����͸� ���

CREATE TABLE TB_PRO_DETAIL (
    DCODE NUMBER PRIMARY KEY,   -- �̷¹�ȣ
    PCODE NUMBER REFERENCES TB_PRODUCT, -- ��ǰ��ȣ
    PDATE DATE NOT NULL,    -- ��ǰ�������
    AMOUNT NUMBER NOT NULL,  -- ����� ����
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�','���')) -- ����(�԰�,���)
    );

-- ������ ������ ����
CREATE SEQUENCE SEQ_DCODE;

-- 200�� ��ǰ�� ���� ��¥�� 10�� �԰�
INSERT INTO TB_PRO_DETAIL
VALUES (SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '�԰�');

-- �԰��� Ȯ��
SELECT * FROM TB_PRO_DETAIL; -- �԰��� �����
SELECT * FROM TB_PRODUCT;   -- �԰��� ����ȵ�

-- 200�� ��ǰ�� ������ 10�� ������Ű��
UPDATE TB_PRODUCT 
    SET STOCK = STOCK +10
    WHERE PCODE = 200;

SELECT * FROM TB_PRODUCT;  -- �԰��� �����Ŵ


-- TB_PRO_DETAIL ���̺� ��ǰ�� INSERT �Ǹ� 
-- TB_PRODUCT ���̺� �Ź� �ڵ����� �������� UPDATE�ǰԲ� Ʈ���� �����ϱ�

/*
    - ��ǰ�� �԰�� ��� -> �԰�� ��ǰ�� ã�Ƽ� ������ ������Ű��(UPDATE)    
    - ��ǰ�� ���� ��� -> ���� ��ǰ�� ã�Ƽ� ������ ���ҽ�Ű��(UPDATE)
*/

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRO_DETAIL
FOR EACH ROW 
BEGIN
    -- ��ǰ�� �԰�Ǿ����� ���Ǿ����� Ȯ���ϱ�
    IF (:NEW.STATUS = '�԰�' )
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

-- 200�� ��ǰ�� ���� ��¥�� 10�� �԰�
INSERT INTO TB_PRO_DETAIL
VALUES (SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '�԰�');

SELECT * FROM TB_PRODUCT;
-- �԰�� �ڵ����� ��� ������ ����ȴ�.


/*
    * Ʈ���� ����
    1. ������ �߰�, ����, ������ �ڵ����� �����͸� �����������ν� ���Ἲ ����
    2. DB ������ �ڵ�ȭ
    
    * Ʈ���� ����
    1. ����� �߰�, ����, ������ ROW�� ����, �߰�, ������ �Բ� ����ǹǷ�
        ���ɻ� ���� ���ϴ�.
    2. ������ ���鿡�� ��������� �Ұ����ϴ�.
    3. Ʈ���Ÿ� �����ϰ� �Ǵ� ��� �������� ���ϴ� ��Ȳ�� �߻��� �� �ְ� ó���ϱ� �����.
*/















