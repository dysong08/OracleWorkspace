-- �����ּ�
/*�������ּ�*/
/*
DML : ������ ����, SELECT(DQL), INSERT, UPDATE, DELETE
DDL : ������ ����, CREATE, ALTER, DROP
TCL : Ʈ����� ����, COMMIT,ROLLBACK
DCL : ���Ѻο�, GRANT, REVOKE

<SELECT>
�����͸� ��ȸ�ϰų� �˻��� �� ����ϴ� ��ɾ�
- RESULT SET : SELECT ������ ���� ��ȸ�� �������� ������� �ǹ�(��ȸ�� ����� ����)
*/

-- EMPLOYEE���̺��� "��ü"������� ���, �̸�, �޿� Į���� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE; --����� CTRL+ENTER

select emp_id, emp_name, salary
from employee;
-- ��ɾ�, Ű����, Į����� ��ҹ��� ���� ����
-- �ҹ��ڷ� �ۼ��ص� ����. ��, �빮�ڷ� ���°� ����.

-- EMPLOYEE ���̺��� ��ü ������� "���" Į���� ��ȸ�ϴ� ���
-- SELECT EMP_ID, EMP_NAME, EMP_NO, .... -- <- �̷��� ����
SELECT * 
FROM EMPLOYEE; 

-- EMPLOYEE���̺��� ��ü ������� �̸�, �̸���, �޴�����ȣ ��ȸ
SELECT EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE;


----------- �ǽ����� -----------
-- 1. JOB���̺��� ��� Į����ȸ
SELECT *
FROM JOB;

-- 2. JOM���̺��� ���޸� Į���� ��ȸ
SELECT JOB_NAME
FROM JOB;

-- 3. DEPARTMENT���̺��� ��� Į�� ��ȸ
SELECT *
FROM DEPARTMENT;

-- 4. EMPLOYEE���̺��� ������, �̸���, ��ȭ��ȣ, �Ի��� Į���� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 5. EMPLOYEE���̺��� �Ի���, ������, �޿� Į���� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE; 

----------------------------------------------
/*
    <Į������ ���� �������>
    ��ȸ�ϰ��� �ϴ� Į������ �����ϴ� SELECT ���� ��������� ����Ͽ� ����� ��ȸ�� �� �ִ�.
*/

-- EMPLOYEE ���̺�κ��� ������, ����, ����(����*12) 
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE ���̺�κ��� ������, ����, ���ʽ�, ���ʽ��� ���Ե� ����(����*12 +(���ʽ�*����)*12)
-- �������������� NULL���� ������ ��� ������� �׻� NULL�� ���´�.
SELECT EMP_NAME, SALARY, BONUS, ( (SALARY + BONUS * SALARY) * 12)
FROM EMPLOYEE;

-- EMPLOYEE ���̺�κ��� ������, �Ի���, �ٹ��ϼ�(���ó�¥-�Ի���) ��ȸ
-- DATE�ڷ��� - DATE�ڷ���
-- ���ó�¥ SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;
-- ������� �������� ���� : DATE Ÿ�� �ȿ� ���Ե� ��, ��, �ʿ� ���� ������� �����ϱ� ����
-- ������� '��'���� ���


----------------------------------------------

/* 
    <Į���� ��Ī �ο��ϱ�>
    [ǥ����] 
    Į���� AS ��Ī, Į���� AS "��Ī", Į���� ��Ī, Į���� "��Ī"
    
    AS�� ���̵� �Ⱥ��̵� ���� ��Ī�� Ư�����ڳ� ���Ⱑ ���Ե� ��� �ݵ�� ""�� ��� ǥ���ؾ� ��.
*/

-- EMPLOYEE ���̺�κ��� ������, ����, ����(����*12) 
SELECT EMP_NAME, SALARY, SALARY*12 "����(���ʽ� ������)"
FROM EMPLOYEE;

-- EMPLOYEE ���̺�κ��� ������, ����, ���ʽ�, ���ʽ��� ���Ե� ����(����*12 +(���ʽ�*����)*12)
-- �������������� NULL���� ������ ��� ������� �׻� NULL�� ���´�.
SELECT EMP_NAME, SALARY, BONUS, ( (SALARY + BONUS * SALARY) * 12) AS "���ʽ� ���Ե� ����"
FROM EMPLOYEE;

-- EMPLOYEE ���̺�κ��� ������, �Ի���, �ٹ��ϼ�(���ó�¥-�Ի���) ��ȸ
-- DATE�ڷ��� - DATE�ڷ���
-- ���ó�¥ SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE 
FROM EMPLOYEE;
-- ������� �������� ���� : DATE Ÿ�� �ȿ� ���Ե� ��, ��, �ʿ� ���� ������� �����ϱ� ����
-- ������� '��'���� ���

/*
    <���ͷ�>
    ���Ƿ� ������ ���ڿ�('')�� SELECT ���� ����ϸ�
    ���� �� ���̺� �����ϴ� ������ó�� ��ȸ�� �����ϴ�.
*/

-- EMPLOYEE ���̺�κ��� ���, �����, �޿�, �޿�����(��) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' AS �޿�����
FROM EMPLOYEE;


/*
    <DISTINCT>
    ��ȸ�ϰ��� �ϴ� Į���� �ߺ��� ���� �� �ѹ��� ��ȸ�ϰ��� �� �� ���
    
    [ǥ����] 
    SELECT DISTINCT �ߺ����� �ִ� Į����
    (��, SELECT ���� DISTINCT ������ �Ѱ��� �����ϴ�)
*/
SELECT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �μ��ڵ�鸸 ��ȸ
SELECT DISTINCT DEPT_CODE --, DISTINCT JOB_CODE    <- DISTINCT�� �� ������ �ι� ��� �Ұ��ϴ�
FROM EMPLOYEE;

SELECT DISTINCT JOB_CODE    -- <- ���� �ϳ��� ��ȸ�ؾ� �Ѵ�.
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE, JOB_CODE -- -> DEPT_CODE, JOB_CODE �ΰ��� ��� �����ؾ� �ߺ��̶�� ������
FROM EMPLOYEE;


--------------------------------------------------------------
/*
    <WHERE ��>
    ��ȸ�ϰ��� �ϴ� ���̺� Ư�� ������ �����ؼ�
    �� ���ǿ� �����ϴ� �����͵鸸 ��ȸ�ϰ��� �� �� ����ϴ� ����
    
    [ǥ����]
    SELECT ��ȸ�ϰ��� �ϴ� Į����, ...    => Į���鸸 �̾Ƴ��ڴ�. 
    FROM ���̺��
    WHERE ���ǽ�;  => ���ǿ� �ش��ϴ� ����� �̾Ƴ��ڴ�.
    
    - ���ǽĿ� ��� ������ �����ڵ�
    >, <, >=, <=
    = (��ġ�ϴ°�?  -> �ڹٿ����� == )
    !=, ^=, <> (��ġ���� �ʴ°�?)
*/

-- EMPLOYEE ���̺�κ��� �޿��� 400���� �̻��� ����鸸 ��ȸ(���Į��)
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE ���̺�κ��� �μ��ڵ尡 D9�� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE ���̺�κ��� �μ��ڵ尡 D9�� �ƴ� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';


-------------- �ǽ����� ------------
-- 1. EMPLOYEE ���̺��� �޿��� 300���� �̻��� ������� �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE ���̺��� �����ڵ尡 J2�� ������� �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

-- 3. EMPLOYEE ���̺��� ���� �������� ������� ���, �̸�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- 4. EMPLOYEE ���̺��� ����(���ʽ�������)�� 5000���� �̻��� ������� �̸�, �޿�, ����, �Ի����� ��ȸ
SELECT EMP_NAME, SALARY, SALARY*12 AS "����(���ʽ�������)", HIRE_DATE 
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
--WHERE ���� >= 50000000;  <- �����߻�. SELECT������ �ο��� ��Ī�� WHERE������ ����� �� ����
-- (��������� �Ұ�����)

-------------------------------------------------------------
/*
    <��������>
    ���� ���� ������ ���� �� ���
    AND(�ڹ� : &&), OR(�ڹ� : ||)
    AND : ~ �̸鼭, �׸���
    OR  : ~ �̰ų�, �Ǵ�
*/

-- EMPLOYEE ���̺��� �μ��ڵ尡 D9�̸鼭 �޿��� 500���� �̻��� ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;


-- �μ��ڵ尡 D6�̰ų� �޿��� 300���� �̻��� ������� �μ��ڵ�, �޿� ��ȸ
SELECT DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- �޿��� 350���� �̻��̰� 600���� ������ ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-------------------------------------------------------------

/*
    <BETWEEN AND>
    �� �̻� �� ������ ������ ���� ������ ������ �� ���
    
    [ǥ����]
    �񱳴��Į���� BETWEEN ���Ѱ� AND ���Ѱ�
*/

-- �޿��� 350���� �̻��̰� 600���� ������ ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- �޿��� 350���� �̸��̰� 600���� �ʰ��� ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
--WHERE NOT SALARY  BETWEEN 3500000 AND 6000000; (==)
-- Oracle�� NOT == Java�� ������������(!)


-- ** BETWEEN AND �����ڴ� DATE ���İ��� �������� ��� ����
-- �Ի����� '90/01/01' ~ '03/01/01'�� ������� ��� Į�� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';
WHERE HIRE_DATE NOT BETWEEN '90/01/01' AND '03/01/01';

------------------------------------------------------------

/*
    <LIKE 'Ư������'>
    ���ϰ��� �ϴ� Į������ ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    [ǥ����]
    �񱳴��Į���� LIKE 'Ư������'
    
    - �ɼ� : Ư������ �κп� ���ϵ�ī���� '%', '_'�� ������ ������ �� ����
    
    '&' : 0���� �̻�
            �񱳴��Į�� LIKE '����%' => Į���� �߿� '����'�� �����ϴ� ���� ��ȸ
            �񱳴��Į�� LIKE '%����' => Į���� �߿� '����'�� ������ ���� ��ȸ
            �񱳴�� Į�� LIKE '%����%' -> Į���� �߿� '����'�� ���ԵǴ� ���� ��ȸ
    '_' : 1����
            �񱳴�� Į�� LIKE '_����' => Į���� �߿� '����'�տ� ������ 1���ڰ� �����ϴ� ��� ��ȸ
            �񱳴�� Į�� LIKE '__����' => Į���� �߿� '����'�տ� ������ 2���ڰ� �����ϴ� ��� ��ȸ        
*/


-- ���� ������ ������� �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- �̸� �߿� '��'�� ���Ե� ������� �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- �̸� ��� ���ڰ� '��'�� ������� ��� Į�� ��ȸ(���ڴ� ���ٰ� ����)
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';


-- ESCAPE ����
-- EMPLOYEE ���̺��� �̸����� _���� ���ڰ� 3������ ����� ��ȸ
-- jun_jy@kh.or.kr
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMAIL LIKE '___#_%' ESCAPE '#'; 
WHERE EMAIL LIKE '____!_%' ESCAPE '!';


-------- �ǽ����� --------
--1. �̸��� '��'���� ������ ������� �̸�, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. ��ȭ��ȣ ó�� 3���ڰ� 010�� �ƴ� ������� �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. DEPARTMENT ���̺��� �ؿܿ����� ���õ� �μ����� ��� Į�� ��ȸ
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '%�ؿܿ���%';

----------------------------------------------------------

/*
    <IS NULL>
    �ش� ���� NULL���� �����ش�
    
    [ǥ����]
    Į�� IS NULL : Į������ NULL���� Ȯ��
    Į�� IS NOT NULL : Į������ NULL�� �ƴ��� Ȯ��
*/

-- ���ʽ��� ���� �ʴ� ������� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- ����� ����, �μ���ġ�� ���� ���� ���� ������� ��� Į�� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- �μ���ġ�� ���� �ʾ����� ���ʽ��� �޴� ����� ��� Į�� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

----------------------------------------------------------

/*
    <IN>
    �񱳴�� Į������ ���� ������ ��ϵ� �߿� ��ġ�ϴ� ���� �ִ��� �Ǵ�
    
    [ǥ����]
    �񱳴��Į�� IN (��1, ��2, ��3, ...)
*/

-- �μ��ڵ尡 D6�̰ų� D8�̰ų� D5�� ������� ��� Į�� ��ȸ
SELECT *
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5'; �Ʒ��� ���� ���ϼ� �ִ�.
 WHERE DEPT_CODE IN ('D6', 'D8', 'D5');
 
 --------------------------------------------------------------
 
 /*
    <���� ������ ||>
    ���� Į�������� ��ġ �ϳ��� Į���� �� ó�� ��������ִ� ������
    Į���� ���ͷ��� ������ ���� �ִ�.
    
 */
 
-- SELECT EMP_ID, EMP_NAME, SALARY
 SELECT EMP_ID || EMP_NAME || SALARY AS "����"
 FROM EMPLOYEE;

-- XX�� XXX�� ������ XXXX�� �Դϴ�. AS �޿�����
SELECT EMP_ID || '�� ' || EMP_NAME || '�� ������ ' || SALARY || '�� �Դϴ�.' AS "�޿�����" 
FROM EMPLOYEE;


--------------------------------------------------------------
/*
    <������ �켱����>
    0. ()
    1. ���������
    2. ���Ῥ����
    3. �񱳿�����
    4. IS NULL, LIKE, IN
    5. BETWEEN AND
    6. NOT
    7. AND
    8. OR
*/
--------------------------------------------------------------
/*
    <ORDER BY ��>
    SELECT�� ���� �������� �����ϴ� ���� �Ӹ� �ƴ϶� ���� �������� ����Ǵ� ����
    ���� ��ȸ�� ������鿡 ���ؼ� "����"������ �����ִ� ����
    
    [ǥ����]
    SELECT ��ȸ��Į��1, 2, 3...
    FROM ��ȸ�� ���̺��
    WHERE ���ǽ�
    ORDER BY [���ı������� ������� �ϴ� Į����/��Ī/Į������] [ASC/DESC] [NULLS FIRST/NULLS LAST]
    
    �������� / ��������
    - ASC : ��������(������ �⺻��)
    - DESC : ��������
    
    �����ϰ��� �ϴ� Į������ NULL�� ���� ���
    - NULLS FIRST : �ش� NULL������ ������ ��ġ(�������� ������ ��� �⺻��)
    - NULLS LAST  : �ش� NULL������ �ڷ� ��ġ(�������� ������ ��� �⺻��)
*/

-- ������ ���� �������� �������� ����
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- ������ ���� �������� �������� ����
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY /*ASC*/;  -- �⺻���� ���������̱� ������ ASC ��������.

-- ���ʽ� ���� ����
SELECT *
FROM EMPLOYEE
-- ORDER BY BONUS;     -- NULLS LAST �⺻��
-- ORDER BY BONUS ASC NULLS FIRST;
-- ORDER BY BONUS DESC;    -- NULLS FIRST �⺻��
-- ORDER BY BONUS DESC NULLS LAST;
ORDER BY BONUS DESC NULLS LAST, SALARY ASC;     -- ���ʽ��� ������ ��� �޿����� ��������
--> ù��°�� ������ ���ı����� Į������ ��ġ�� ��� �ι�° ���ı����� ������ �ٽ� ����

-- �������� �������� ����
SELECT EMP_NAME, SALARY, SALARY*12 
FROM EMPLOYEE
-- ORDER BY SALARY*12;     -- �������� ��������
 -- ORDER BY 3;     -- Į�� ����
-- ORDER BY ����;    -- ��Ī ��� ����
-- ORDER BY �� ���� �Ӹ� �ƴ϶� ���ڿ�, ��¥�� ���� ����



------------------------------------
