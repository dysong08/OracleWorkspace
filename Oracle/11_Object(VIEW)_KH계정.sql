/*
    * Object
    DB�� �̷�� ������ ��������
    
    * Object
    - TABLE, USER, VIEW, SEQUENCE, INDEX, PACKAGE, TRIGGER, FUNCTION, PROCEDURE..
    
    <VIEW ��>
    SELECT���� ������ ������(RESULTSET)�� ������ �� �� �ִ� ��ü
    (���� ���� SELECT���� VIEW�� �����صθ� �Ź� �� SELECT���� �ٽ� ����� �ʿ䰡 ����)
    => ��ȸ�� ���� �ӽ����̺� ���� �����̸� ���� �����Ͱ� ����ִ� ���� �ƴϴ�.
    => ��ȸ�� ���� ������������ �����ϸ� VIEWȣ��� ���������� �����Ų��.
*/


-- �ǽ����� --
-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������, ���޸� ��ȸ�Ͻÿ�.

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N USING (NATIONAL_CODE)
JOIN JOB J USING(JOB_CODE)
WHERE N.NATIONAL_NAME = '�ѱ�';



/*
    1. VIEW �������
    
    [ǥ����]
    CREATE VIEW ���
    AS ��������;
    
    
    CREATE [OR REPLACE] VIEW ���
    AS ��������;
    => �� ������ ������ �ߺ��� �̸��� �䰡 ���ٸ� ���Ӱ� �䰡 �����ǰ�
                      �ߺ��� �̸��� �䰡 �ִٸ� �ش� �̸��� �並 �����Ѵ�.
*/


CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
    JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
    JOIN NATIONAL N USING (NATIONAL_CODE)
    JOIN JOB J USING(JOB_CODE);
-- ���� KH������ ����� ���� ��� �����߻���..........
-- ������ �������� GRANT CREATE VIEW TO KH; �� ���Ѻο� ����� �Ѵ�.


-- ���Ӱ��� �ý��۰������� ����
GRANT CREATE VIEW TO KH;
-- ���� �ο� �� KH�������� ����


SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�'; 
-- VW_EMPLOYEE �信 ���� ���������� �ζ������·� ������ �־� ȣ����.



-- '���þ�'�� �ٹ��ϴ� ������� ���, �̸�, ���޸�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, BONUS
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�'; 
-- �信 �������� �ʴ� Į���� �����ϸ� ���� �߻��Ѵ� (�信 ���ʽ� Į���� ����)


-- ��� ������ �������̺� => ������ �����͸� �����ϰ� ���� ����.
-- Ȯ�ι��

SELECT * FROM USER_VIEWS;
-- ��� �ܼ��� �������� TEXT ���·� ������ �ϴ� ��ü


/*
    * �� Į���� ��Ī �ο��ϱ�
    �������� SELECT���� �Լ�ȣ���, �������� ���� ����� ��� �ݵ�� ��Ī�� ����.
*/

-- ����� ���, �̸�, ���޸�, ����, �ٹ������ ��ȸ�� ���ִ� SELECT���� �����
-- �̸� VIEW�� �����Ͻÿ�.

CREATE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
         DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') "����",
         EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "�ٹ����"
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
         
SELECT * FROM VW_EMP_JOB;


-- �ٸ� ������� ��Ī �ο��ϱ�(��, ��� Į���� ���� ��Ī�� ���)
CREATE OR REPLACE VIEW VW_EMP_JOB(���, �����, ���޸�, ����, �ٹ����)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
         DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') ,
         EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
         
SELECT * FROM VW_EMP_JOB;

SELECT ���, ����� 
FROM VW_EMP_JOB
WHERE ���� = '��';


DROP VIEW VW_EMP_JOB;

-------------------------------------------------------------------------

-- INSERT, UPDATE, DELETE
/*
    * ������ �並 �̿��ؼ� DML(INSERT, UPDATE, DELETE) ��� ����
    
    ���ǻ��� : �並 ���ؼ� �����ϰ� �ȴٸ� ���� �����Ͱ� ��� �ִ�
            ���̺� ��������� ����ȴ�.
*/

CREATE VIEW VW_JOB
AS SELECT * FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- VW_JOB�� INSERT
INSERT INTO VW_JOB
VALUES ('J8','����');
-- JOB ���̺��� �߰��� �Ǿ���.


-- VW_JOB�� UPDATE, JOB_CODE�� J8�� ������ '�˹�'�� �����ϱ�
UPDATE VW_JOB
    SET JOB_NAME ='�˹�'
WHERE JOB_CODE = 'J8';

SELECT * FROM VW_JOB;
SELECT * FROM JOB;


-- VW_JOB�� DELETE, JOB_CODE�� J8�� ������ �����ϱ�
DELETE VW_JOB
WHERE JOB_CODE = 'J8';

SELECT * FROM VW_JOB;
SELECT * FROM JOB;



/*
    VIEW�� Ȱ���ؼ� DML�� ������ ���
        : ���������� �̿��ؼ� ������ ���̺��� �״�� ������ ��쿡�� ����
        
    * ������ �並 ������ DML�� �Ұ����� ��찡 �ξ� �� ����
        => �߰����� ó���� �� �� ��� �Ұ���
        
        1) �信 ���ǵǾ� ���� ���� Į���� �����ϴ� ���
        2) �信 ���ǵǾ� ���� ���� Į�� �߿� ���̽����̺�� NOT NULL ���������� ������ ���
        3) �������� �Ǵ� �Լ��� ���� ���ǵǾ� �ִ� ���
        4) �׷��Լ��� GROUP BY���� ���Ե� ���
        5) DISTINCT ������ ���Ե� ���
        6) JOIN�� �̿��� ���
*/

-- 1) �信 ���ǵǾ� ���� ���� Į���� �����ϴ� ���
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB;

INSERT INTO VW_JOB(JOB_CODE, JOB_NAME)
VALUES ('J8','����');
-- �������� �ʴ� Į���� INSERT �ȵ�

UPDATE VW_JOB
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';
-- �������� �ʴ� Į���� UPDATE �ȵ�

DELETE FROM VW_JOB
WHERE JOB_CODE = 'J7'; 
-- �������� �ʴ� Į���� DELETE �ȵ�



-- 2) �信 ���ǵǾ� ���� ���� Į�� �߿� NOT NULL ���������� ������ ���
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

INSERT INTO VW_JOB
VALUES ('����');
-- cannot insert NULL into ("KH"."JOB"."JOB_CODE")
-- JOB���̺��� NOT NULL �������ǿ� ����� (JOB_CODE�� NULL���� �������� ��)


-- 3) �������� �Ǵ� �Լ��� ���� ���ǵǾ� �ִ� ���
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 "����" 
FROM EMPLOYEE; 

INSERT INTO VW_EMP_SAL
VALUES (400, 'ȫ�浿', 3000000, 36000000);
-- virtual column not allowed here
-- ����Į���� ������� �ʴ´� (���� Į���� ���̽����̺� ���� Į����)


-- 4) �׷��Լ��� GROUP BY���� ���Ե� ���
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) "�հ�"
    FROM EMPLOYEE
    GROUP BY DEPT_CODE; 

SELECT * FROM VW_GROUPDEPT;

INSERT INTO VW_GROUPDEPT
VALUES ('D3', 8000000);
-- �հ� Į���� ����Į���̴�. (���̽����̺� ���� Į��)


-- 5) DISTINCT ������ ���Ե� ��� DML�Ұ� 
--(//����)



-- 6) JOIN�� �̿��� ���
CREATE OR REPLACE VIEW VW_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
   
   
-- ����� �����ؼ� �̸� �����ϱ� 
UPDATE VW_JOINEMP
SET EMP_NAME = '������'
WHERE EMP_ID = '200';

SELECT * FROM VW_JOINEMP;
--���氡��


-- ����� �����ؼ� �μ��̸� �����ϱ�
UPDATE VW_JOINEMP
SET DEPT_TITLE = 'ȸ���'
WHERE EMP_ID = '200';

SELECT * FROM VW_JOINEMP;
-- ���� �ٸ� ���̺� �ִ� Į�� ���� �����߻�
-- JOIN�� DEPARTMENT ���̺��� DML �ȵ�!



-------------------------------------------------------------------

-- VIEW�� ��밡���� �ɼǵ�

-- 1. OR REPLACE
CREATE OR REPLACE VIEW V_EMP_SALARY
AS SELECT * FROM EMPLOYEE;

-- 2. FORCE/NOFORCE �ɼ� : ���� ���̺��� ������ VIEW�� ������ ������ �� �ְ� ���ִ� �ɼ�(�⺻�� NOFORCE)
--CREATE OR REPLACE FORCE/NOFORCE 
CREATE FORCE VIEW V_FORCETEST
AS SELECT A,B,C FROM NOTHING;
-- VIEW ���� ����

SELECT * FROM V_FORCETEST;
-- VIEW ������ ���������� ���� ���̺��� ���� ������ ���� ����
-- ���� ���� NOTHING ���̺� �������ָ� ��...

CREATE TABLE NOTHING(
    A NUMBER,
    B NUMBER,
    B NUMBER
    );



-- 3. WITH CHECK OPTION
--  ���������� SELECT���� WHERE������ ����� Į���� �������� ���ϰ� ���� �ɼ�
CREATE OR REPLACE VIEW V_CHECKOPTION
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5' WITH CHECK OPTION;

SELECT * FROM V_CHECKOPTION; --6��

UPDATE V_CHECKOPTION
SET DEPT_CODE = 'D6'
WHERE EMP_ID = '215';

SELECT * FROM V_CHECKOPTION;
-- view WITH CHECK OPTION where-clause violation �����߻�


UPDATE V_CHECKOPTION
SET SALARY = '5000000'
WHERE EMP_ID = '215';

SELECT * FROM V_CHECKOPTION;
-- WHERE���� �����ϴ� Į���� �ƴϱ� ������ �����߻�XX
-- DEPT_CODE Į������ WITH CHECK OPTION �� �ɷ�����.

ROLLBACK;



-- 4. WITH READ ONLY
-- VIEW ��ü�� ���� ���ϰ� �����ϴ� �ɼ�
CREATE OR REPLACE VIEW V_READ
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5' WITH READ ONLY;

SELECT * FROM V_READ;

UPDATE V_READ
SET SALARY = '10000000';
-- read-only view���� DML�� �� �� ����.



DROP USER WORKBOOK CASCADE;

CREATE USER WORKBOOK IDENTIFIED BY WORKBOOK;

GRANT CONNECT, RESOURCE TO WORKBOOK;



