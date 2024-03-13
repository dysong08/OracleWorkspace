/*
    * DCL (DATA CONTROL LANGUAGE)
    ������ ���� ���
    
    �������� �ý��۱��� �Ǵ� ��ü���ٱ����� 
    �ο�(GRANT)�ϰų� ȸ��(REVOKE)�ϴ� ���
    
    * ���Ѻο�(GRANT)
        -�ý��۱��� : Ư�� DB�� �����ϴ� ����
                    ��ü���� ������ �� �ִ� ����
        -��ü���ٱ��� : Ư�� ��ü�鿡 �����ؼ� ������ �� �ִ� ����
        
    * �ý��۱���
    
    
    [ǥ����]
    GRANT ����1, ����2,  ... TO ������;
    
    - �ý��� ������ ����
    CREATE SESSION : ������ ������ �� �ִ� ����
    CREATE TABLE   : ���̺��� ������ �� �ִ� ����
    CREATE VIEW    : �並 ������ �� �ִ� ����
    

*/

-- 1. SAMPLE ���� �����ϱ�
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;


-- 2. SAMPLE ������ �����ϱ� ���� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE;


-- 3_1. SAMPLE ������ ���̺��� ������ �� �ִ� CREATE TABLE���� �ο�
GRANT CREATE TABLE TO SAMPLE;


-- 3_2. SAMPLE ������ ���̺� �����̽��� �Ҵ����ֱ�( SAMPLE ��������)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
--QUOTA : �� �������ִ�, �Ҵ��ϴ�


-- 4. SAMPLE ������ �並 ������ �� �ִ� CREATE VIEW ���� �ο�
GRANT CREATE VIEW TO SAMPLE;


-----------------------------------------------------------

/*
    - ��ü ����
    Ư�� ��ü���� ������ �� �ִ� ����
    ���� : SELECT, INSERT, UPDATE, DELETE
    
    [ǥ����]
    GRANT �������� ON Ư����ü TO ������;
    
        ��������         |       Ư����ü
    -----------------------------------------
        SELECT          |   TABLE, VIEW, SEQUENCE
        INSERT          |   TABLE, VIEW
        UPDATE          |   TABLE, VIEW
        DELETE          |   TABLE, VIEW
*/

-- 5. SAMPLE ������ KH.EMPLOYEE���̺��� ��ȸ�� �� �ִ� ���� �ο���
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;


-- 6. SAMPLE ������ KH.DEPARTMENT ���̺� ���� ������ �� �ִ� ���� �ο��ϱ�
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;




--------------------------------------------------------------------

-- GRANT CONNECT, RESOURCE TO ������;
/*
    <�� ROLE>
    Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
    
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, SELECT, INSERT, ...
            (Ư�� ��ü���� ���� �� ������ �� �ִ� ����)(�Ϲ� �����ڿ� ����)
    CONNECT : CREATE SESSION(DB�� ������ �� �ִ� ����)
*/
--------------------------------------------------------------------
/*
    ���� ȸ��(REVOKE)
    ������ ȸ���� �� ����ϴ� ��ɾ�
    
    [ǥ����]
    REVOKE ����1, ����2, .. FROM ������;
*/

-- 7. SAMPLE �������� ���̺��� ������ �� ������ ���� ȸ���ϱ�
REVOKE CREATE TABLE FROM SAMPLE;





