/*
    * TCL (TRANSACTION CONTROL LANGUAGE)
    Ʈ������� �����ϴ� ���
    
    * Ʈ���輱(TRANSACTION)
    - DB�� ���� �۾� ����
    - �������� �������(DML�� ����)���� �ϳ��� Ʈ��������� ��� ó��
        => COMMIT(Ȯ��)�ϱ� �������� ������׵��� �ϳ��� Ʈ��������� ��Ƶд�.
        
    - Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE
    
    * Ʈ������� ����
    - COMMIT : �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ��ϰڴٴ� ���� �ǹ�
    - ROLLBACK : ������׵��� ���� DB�� �ݿ����� �ʰڴٴ� ���� �ǹ�
                Ʈ����ǿ� ����ִ� ������׵� �� ������ �� ������ COMMIT�������� ���ư���
                
    - SAVEPOINT ����Ʈ��; : ���� �������� �ӽ��������� ������ �δ� ��.
    - ROLLBACK TO ����Ʈ��; : ��ü ������׵��� �����ϴ� ���� �ƴ϶� 
                            �ش� ����Ʈ ���������� Ʈ����Ǹ� �ѹ���
*/


SELECT * FROM EMP_01;   -- 25��

DELETE FROM EMP_01 WHERE EMP_ID = 901;
DELETE FROM EMP_01 WHERE EMP_ID = 900;


ROLLBACK; -- �ٽ� 25��


-- ����� 200���� ��� ����
DELETE FROM EMP_01 WHERE EMP_ID = 200;

-- ��� 800��, �̸� ȫ�浿, �μ� �ѹ��� �����ϱ�
INSERT INTO EMP_01
VALUES (800, 'ȫ�浿', '�ѹ���');

COMMIT;

SELECT * FROM EMP_01; 
ROLLBACK;
-- COMMIT�� �ϸ� ROLLBACK �ȵ�!!!!!!!

----------------------------------------------------------------

--EMP_01���̺��� ����� 214, 216, 217�� ����� �����ϱ�
DELETE EMP_01
WHERE EMP_ID IN (214,216,217);

SELECT * FROM EMP_01; 


-- 3���� ���� ������ ������ SAVEPOINT �����ϱ�
SAVEPOINT SP1; --�ӽ�����


-- EMP_01 ���̺� ��� 801�� �̸� �踻�� �λ�� ����� �߰�
INSERT INTO EMP_01
VALUES (801, '�踻��','�λ��');  -- 23��

DELETE FROM EMP_01
WHERE EMP_ID = 218;     -- 22��

SELECT * FROM EMP_01; 

ROLLBACK SP1;   -- SP1 ������ Ʈ����Ǹ� ��ҵ�. 25��

COMMIT;



-- ����� 900, 901���� ����� ����
DELETE FROM EMP_01
WHERE EMP_ID IN (900,901);


-- ���̺� ����(DDL)
CREATE TABLE TEST(
    TID NUMBER
    );

SELECT * FROM EMP_01; -- 21��

ROLLBACK;   -- �ѹ�ȵ�! 21��

/*
    ���ǻ��� )
    DDL���� (CREATE, ALTER, DROP)�� �����ϴ� ����
    ������ Ʈ����ǿ� �ִ� ��� ��������� ������ ���� DB�� �ݿ���Ų �� DDL�� �����
    ��, DDL ���� �� ��������� �ִٸ� ��Ȯ�� �Ƚ�(COMMIT, ROLLBACK)�� �ϰ� DDL�� �����ؾ� �Ѵ�.
    
*/
-- ** COMMIT�� �ؾ� �ٸ� �������� ��ȸ�� �����ϴ�! **






