/*
    * DML (DATA MANIPULATION LANGUAGE)
    ������ ���� ���
    
    ���̺� ���ο� �����͸� ����(INSERT)�ϰų�
    ������ �����͸� ����(UPDATE)�ϰų�
    ����(DELETE)�ϴ� ������
*/

/*
    1. INSERT : ���̺� ���ο� "��"�� �߰��ϴ� ����
    
    [ǥ����]
    
    * INSERT INTO �迭
    1) INSERT INTO ���̺�� VALUES(��1,��2,��3,..)
    => �ش� ���̺� "���" Į���� ���� �߰��ϰ��� �ϴ� ���� 
    ���� ���� �����ؼ� "�� ��"�� INSERT�ϰ��� �� �� ���� ǥ����
    ���ǻ��� : Į���� ����, �ڷ���, ������ ���缭 VALUES��ȣ �ȿ� �����ؾ� ��
*/

-- EMPLOYEE ���̺� ������� �߰�
INSERT INTO EMPLOYEE
VALUES (900, '�谩��', '991008-1234567','ALS@iei.or.kr', '01012345678', 
        'D1', 'J7', 'S6', 1900000, 0.2, 200, SYSDATE, null, DEFAULT);
        
SELECT * FROM EMPLOYEE;


/*
    2) INSERT INTO ���̺��(Į����1, Į����2, Į����3)
    VALUES (��1,��2,��3);
    
    => �ش� ���̺� "Ư��" Į���� �����ؼ� �� Į���� �߰��� ���� �����ϰ��� �Ҷ� ���
    
    - ���� ������ �����Ͱ� �߰��Ǳ� ������ ������ �ȵ� Į����
        �⺻������ NULL���� ����
    - ��, DEFAULT ������ �ִ� ��� "�⺻��"�� ����
    
    - NOT NULL ���������� �ɷ��ִ� Į���� �ݵ�� �����ؼ� ���� ���� �����ؾ� ��
    (��, DEFAULT �ɼ��� �߰��� ���� ��������)
*/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES (901, '�ڸ���', '990202-1234567', 'J6', 'S5');


/*
    3) INSERT INTO ���̺�� (��������);
    => VALUES()�� ���� ���� �����ϴ°� �ƴ϶� 
      ���������� ��ȸ�� ������� ��°�� INSERT�ϴ� ����
      (���� ���� �� ���� INSERT�� �� �ִ�.)
*/

-- �� ���̺� �߰�
CREATE TABLE EMP_01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DETE_TITLE VARCHAR2(20)
    );
    
-- ��ü ������� ���, �̸�, �μ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- �� �������� ����� INSERT
INSERT INTO EMP_01(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
);

SELECT * FROM EMP_01;


/*
    * INSERT ALL �迭
    �� �� �̻��� ���̺� ���� INSERT�� �� ���
    ���� : �׶� ���Ǵ� ���������� �����ؾ� �Ѵ�.
    
    1) INSERT ALL
    INTO ���̺��1 VALUES(Į����,Į����,..)
    INTO ���̺��2 VALUES(Į����,Į����,..)
    ��������;
*/

-- ù��° ���̺� : �޿��� 300���� �̻��� ������� ���, �����, ���޸��� ������ ���̺�
CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    JOB_NAME VARCHAR2(20)
    );

-- �ι�° ���̺� : �޿��� 300���� �̻��� ������� ���, �����, �μ����� ������ ���̺�
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
    );


SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY >= 3000000;


INSERT ALL
INTO EMP_JOB VALUES (EMP_ID, EMP_NAME, JOB_NAME) -- 8��
INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_TITLE) -- 8��
    SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE SALARY >= 3000000;



/*
    2) INSERT ALL
    WHEN ����1 THEN
        INTO ���̺��1 VALUES(Į����,Į����,..)
    WHEN ����2 THEN
        INTO ���̺��2 VALUES(Į����,Į����,..)
    ��������;
    
    - ���ǿ� �´� ���鸸 �߰��ϰڴ�.
*/

-- ������ ����ؼ� �� ���̺� �� �߰�(INSERT)
-- ���ο� �׽�Ʈ�� ���̺� ����
-- 2010�⵵ �������� ������ �Ի��� ������� ���, �����, �Ի���, �޿�

CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

-- 2010�⵵ �������� ���Ŀ� �Ի��� ������� ���, �����, �Ի���, �޿�
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;


INSERT ALL
WHEN HIRE_DATE < '2010/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2010/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT * FROM EMPLOYEE;


----------------------------------------------------

/*
    2. UPDATE
    ���̺� ��ϵ� ������ �����͸� �����ϴ� ����
    
    [ǥ����]
    UPDATE ���̺��
    SET Į���� = �ٲܰ�,
        Į���� = �ٲܰ�,
        Į���� = �ٲܰ�,  -- �������� Į������ ���ÿ� ���氡��
        ...              -- �̶� �ٲ�Į���� , �� �����ؾ� ��
    WHERE ����;   -- WHERE���� ���� ����. ������ ���̺��� ��� ���� �����Ͱ� ����ȴ�.
*/

-- ���纻 ���̺��� ���� �� �۾�
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

-- DEPT_COPY���̺��� D9�μ��� �μ����� ������ȹ������ ����
UPDATE DEPT_COPY
    SET DEPT_TITLE = '������ȹ��';
-- ������ �߰����� �ʴ� ��� ��� ���� ���� ������ȹ������ ������
SELECT * FROM DEPT_COPY;

ROLLBACK; -- ������׿� ���� �ǵ����� ��ɾ�

UPDATE DEPT_COPY
    SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';
-- WHERE���� ���ǿ� ���� 1��~N���� ���� ����� �� �ִ�.

SELECT * FROM DEPT_COPY;


-- ���纻 ���̺�
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE;

SELECT * FROM EMP_SALARY;


-- ��ü ����� �޿��� 20%, ���ʽ��� 10% �λ�
UPDATE EMP_SALARY
    SET SALARY = SALARY*1.2,
        BONUS = NVL(BONUS,0) + 0.1;
SELECT * FROM EMP_SALARY; 



/*
    * UPDATE�ÿ� �������� ���
    ���������� ������ ��������� ������ �ִ� ���� �����ϰڴ�
    
    - CREATE �ÿ� �������� : ���������� ������ ����� ���̺� ���鶧 �ְڴ�.
    - INSERT �ÿ� �������� : ���������� ������ ����� �ش� ���̺� �����ϰڴ�.
    
    [ǥ����]
    UPDATE ���̺��
    SET Į���� = (��������)
    WHERE ����;

*/

-- EMP_SALARY ���̺� �ڸ��� ����� �μ��ڵ带 ������ ����� �μ��ڵ�� �����ϱ�
-- 1)
SELECT * FROM EMP_SALARY;

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';

-- 2) �ڸ��� �μ��ڵ带 D9�� �����ϱ�
UPDATE EMP_SALARY
SET DEPT_CODE = (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '������')
WHERE EMP_NAME = '�ڸ���';


-- ���� ����� �޿��� ���ʽ��� ����� ����� �޿��� ���ʽ������� �����Ͻÿ�
-- ������ ���߿� ���������� ����� ��
UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                        FROM EMP_SALARY
                        WHERE EMP_NAME = '�����' )
WHERE EMP_NAME = '����';

SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME IN ('�����','����');

-- ���ǻ��� : UPDATE�Ҷ��� ������ ���� ���� �������ǿ� ����Ǹ� �ȵ�

UPDATE EMPLOYEE
    SET EMP_ID = 200
WHERE EMP_NAME = '������'; 
-- PRIMARY KEY �������� ����


COMMIT; -- ��� ��������� Ȯ���ϴ� ��ɾ�


-----------------------------------------------------------------


/*
    4. DELETE 
    ���̺� ��ϵ� �����͸� "��"������ �����ϴ� ����
    
    [ǥ����]
    DELETE FROM ���̺��
    WHERE ����; -- WHERE�� ��������. ������ ������� ������
*/

-- EMPLOYEE ���̺��� ��� �� ����
DELETE FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;
-- 0�� �� ��ȸ
-- �����ʹ� ������ Į����ü�� ��������

ROLLBACK;


-- EMPLOYEE ���̺��� �谩��, �ڸ��� ����� ���� �����ϱ�
DELETE FROM EMPLOYEE
WHERE EMP_ID IN (900,901);

SELECT * FROM EMPLOYEE; 
COMMIT; 


/*
    * TRUNCATE : ���̺��� ��ü ���� ��� ������ �� ����ϴ� ����(����)
                DELETE������ ����ӵ��� ����
                ��, ������ ���� ���� �Ұ�
                ROLLBACK �Ұ�
                
    [ǥ����]
    TRUNCATE TABLE ���̺��;
*/

SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY;

TRUNCATE TABLE EMP_SALARY;
ROLLBACK;











