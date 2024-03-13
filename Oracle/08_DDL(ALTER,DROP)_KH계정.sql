/*
    * DDL(DATA DEFINITION LANGUAGE)
    
    ��ü���� ���Ӱ� ����(CREATE)�ϰ� ����, �����ϴ� ����
    
    
    1. ALTER
    ��ü ������ �����ϴ� ����
    
    [ǥ����]
    ALTER TABLE ���̺�� �����ҳ���;
    
    - �����ҳ���
    1) Į���߰� / ���� / ����
    2) �������� �߰� / ���� => ������ �Ұ�
    3) ���̺�� / Į���� / �������Ǹ� ����
    
*/

-- 1) Į���߰� / ���� / ����
-- 1_1) Į���߰�(ADD) : ADD �߰���Į���� �ڷ��� [DEFAULT �⺻��]

SELECT * FROM DEPT_COPY;

-- CNAME Į�� �߰�
ALTER TABLE DEPT_COPY
ADD CNAME VARCHAR2(20);
-- ���ο� Į���� ��������� NULL������ ä����
ROLLBACK;

-- LNAME Į�� �߰� DEFAULT ����
ALTER TABLE DEPT_COPY
ADD LNAME VARCHAR2(20)
DEFAULT '�ѱ�';
-- ���ο� Į���� ��������� NULL�� �ƴ� DEFAULT������ ä����



-- 1_2) Į�� ����(MODIFY)
--      Į���� �ڷ��� ���� : MODIFY ������ Į���� �ٲٰ����ϴ� �ڷ���
--      DEFAULT�� ���� : MODIFY ������ Į���� �ٲٰ����ϴ� �⺻��

-- DEPT_COPY ���̺��� DEPT_IDĮ���� �ڷ����� CHAR(3)���� �����ϱ�
ALTER TABLE DEPT_COPY 
MODIFY DEPT_ID CHAR(3);

ALTER TABLE DEPT_COPY 
MODIFY DEPT_ID CHAR(2);
-- �����ϰ��� �ϴ� Į���� �̹� ����ִ� ������ �� ���� ũ��� ������ �Ұ��ϴ�

SELECT LENGTHB(DEPT_ID) FROM DEPT_COPY;
-- DEPT_COPY���̺��� DEPT_IDĮ���� ����Ʈ�� 


ALTER TABLE DEPT_COPY 
MODIFY DEPT_ID NUMBER;
-- �����ϰ��� �ϴ� Į���� �̹� ����ִ� ������ ������ �ٸ� Ÿ������ ���� �Ұ��ϴ�

--***
-- >> ����-> ����X / ���� ����ִٸ� ���ڿ� ������ ���X / ������Ȯ��(O)
--***


-- �ѹ��� �������� Į�� �����ϱ�
-- DEPT_TITLE Į���� ������Ÿ���� VARCHAR2(40) ����
-- LOCATION_ID Į���� ������Ÿ���� VARCHAR2(2)��
-- LNAME�� �⺻���� �̱����� �ٲٱ�
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '�̱�';

SELECT * FROM DEPT_COPY;


-- 1_3) Į�� ����(DROP COLUMN) : DROP COLUMN �����ϰ��� �ϴ� Į����
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;


-- DEPT_COPY2�κ��� DEPT_IDĮ�� �����ϱ�
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

SELECT * FROM DEPT_COPY2;
ROLLBACK;
-- DDL ������ ROLLBACK���� ������ �Ұ����ϴ�!!


-- ��� Į�� �����ϱ�
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
-- ���̺� �ּ� �Ѱ��� Į���� �����ؾ� �ϱ� ������ ������ Į���� �����Ұ���!!

SELECT * FROM DEPT_COPY2;



/*
    2_1) �������� �߰�
    - ��������(PRIMARY KEY, FOREGIN KEY, UNIQUE, CHECK)
    ADD [CONSTRAINT �������Ǹ�] ��������(Į����) [REFERENCES ���������̺��(������Į����)]
    
    NOTNULL �������� -> MODIFY Į���� NOT NULL;
    ���������� �̸��� �ο��ϰ��� �Ѵٸ� CONSTRAINT �������Ǹ��� �߰�
*/

-- DEPT_COPY���̺�κ��� 
-- DEPT_ID���� PRIMARY KEY
-- DEPT_TITLE���� UNIQUE
-- LNAME ����  NOT NULL �������� �ο�

ALTER TABLE DEPT_COPY
--ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID);
--ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE);
MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;
-- �ѹ��� ������ ������ �ȵǸ� ���پ� �����ϱ�..


/*
    2_2) �������� ����
    PRIMARY KEY, FOREGIN KEY, UNIQUE, CHECK
    DROP CONSTAINT �������Ǹ�;
    
    NOT NULL : MODIFY Į���� NULL;
*/

-- DEPT_COPY���̺�κ��� DCOPY_PK �������� �����ϱ�
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;  --????????????????

-- DCOPY_UQ, DCOPY_NN �������ǻ����ϱ�
--ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_UQ;
ALTER TABLE DEPT_COPY MODIFY LNAME NULL;



-- 3) Į���� / �������Ǹ� / ���̺�� ����(RENAME)

-- 3_1) Į���� ���� : RENAME COLUMN ����Į����  TO �ٲ�Į����;

-- DEPT_COPY���̺��� DEPT_TITLEĮ���� DEPT_NAME���� �ٲٱ�
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
SELECT * FROM DEPT_COPY;


-- 3_2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
-- DEPARTMENT�� SYS_C007016�� DCOPY_NN;
ALTER TABLE DEPARTMENT RENAME CONSTRAINT SYS_C007016 TO DCOPY_NN;



-- 3_3) ���̺�� ���� : RENAME [�������̺��] TO �ٲ����̺��
-- DEPT_COPY���̺���� DEPT_TEST�� �����ϱ�
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

SELECT * FROM DEPT_COPY;
SELECT * FROM DEPT_TEST;




/*
    2. DROP
    
    [ǥ����]
    DROP TABLE ���̺��;
*/

-- EMP_NEW ���̺� �����ϱ�
DROP TABLE EMP_NEW;

-- �ܷ�Ű ������ �Ǿ������� ������ ������ �ɸ�!!

-- �׽�Ʈȯ�� ����
-- DEPT_TEST���̺��� DEPT_IDĮ���� PRIMARY KEY �������� �߰��ϱ�
ALTER TABLE DEPT_TEST ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID);

-- EMPLOYEE_COPY3�� DEPT_CODEĮ���� �ܷ�Ű �߰�, �θ����̺��� DEPT_TEST
ALTER TABLE EMPLOYEE_COPY3
ADD CONSTRAINT ECOPY_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_TEST;

-- �θ����̺� �����ϱ�
DROP TABLE DEPT_TEST;


-- ��򰡿��� �����ǰ� �ִ� �θ����̺���� �������� �ʴ´�.
-- ���� �θ����̺��� �����ϰ� �ʹٸ�?

-- ��� 1) �����ϰ� �ִ� �ڽ����̺��� ���� ���� �� �θ����̺� �����ϱ�
DROP TABLE �ڽ����̺�;
DROP TABLE �θ����̺�;
-- �����ϰ� �ִ� �ڽ����̺��� �����Ǿ����Ƿ� �θ����̺� ���� ����


-- ��� 2) �θ����̺� �����ϵ� �¹��� �ִ� �ܷ�Ű �������ǵ� �Բ� �����ϱ�
-- DROP TABLE �θ����̺�� CASCADE CONSTRAINT;
DROP TABLE DEPT_TEST CASCADE CONSTRAINT;


























