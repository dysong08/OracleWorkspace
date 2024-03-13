/*
    <JOIN>
    
    �� �� �̻��� ���̺��� �����͸� ���� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    => SELECT ���� �̿�
    ��ȸ����� �ϳ��� �����(RESULT SET)�� ����
    
    JOIN�� �ؾ� �ϴ� ����?
    ������ �����ͺ��̽������� �ּ����� �����ͷ� ������ ���̺� �����͸� �����ϰ� ����
    ��������� ������̺�, ���������� �������̺�, ..��� => �ߺ��� �ּ�ȭ �ϱ� ����
    => �� JOIN ������ �̿��ؼ� ������ ���̺��� "����"�� �ξ ���� ��ȸ�ؾ���
    => ���̺� ���� "�����"�� �ش�Ǵ� Į���� ��Ī���Ѽ� ��ȸ�ؾ���
    
    ������ ���� : JOIN�� ũ�� "ORACLE ���� ����"�� "ANSI(�̱� ���� ǥ�� ��ȸ)����"���� ����
    
    ����� �з� : 
            ORACLE ���� ����         |       ANSI ����
================================================================================
            �����(EQUAL JOIN)     |      ��������(INNER JOIN) => JOIN USING/ON
================================================================================
            ��������                 |      �ܺ�����(OUTER JOIN) => JOIN USING
            (LEFT OUTER JOIN)       |      ���� �ܺ�����(LEFT OUTER JOIN) 
            {RIGHT OUTER JOIN)      |      ������ �ܺ�����{RIGHT OUTER JOIN)
                  x                 |      ��ü �ܺ�����(FULL OUTER JOIN)
================================================================================
            ī�׽þ� ��               |     ��������
================================================================================
                            ��ü����(SELF JOIN)
                            ������(NON EQUAL JOIN)
                            ��������(���̺� 3�� �̻� ����)
*/


-- JOIN�� ������� �ʴ� ��
-- ��ü ������� ���, �����, �μ��ڵ�, �μ������ �˾Ƴ����� �Ѵٸ�?
    
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;
    
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
    
    
-- JOIN�� ���ؼ� ������� �ش�Ǵ� Į���鸸 ��Ī��Ű�� ��ġ �ϳ��� �����ó�� ��ȸ ����

/*
    1. �����(EQUAL JOIN) / ��������(INNER JOIN)
    �����Ű���� �ϴ� Į���� ���� "��ġ�ϴ� ��鸸" JOIN�Ǽ� ��ȸ
    (��ġ���� �ʴ� ������ ������� ����)
    => ����񱳿����ڸ� �����Ѵ�
    
    [ǥ����]
    �����(����Ŭ ����)
    SELECT ��ȸ�ϰ��� �ϴ� Į����� ����
    FROM �����ϰ��� �ϴ� ���̺��� ����
    WHERE ������ Į���� ���� ������ ����
    
    ��������(ANSI����) : ON ����
    SELECT ��ȸ�ϰ��� �ϴ� Į����� ����
    FROM �������� ���� ���̺�� 1�� ����
    JOIN ������ ���̺�� 1�� ���� ON (������ Į���� ���� ������ ����)
    
    ��������(ANSI����) : USING ���� => (������ Į������ ������ ��쿡�� ���)
    SELECT ��ȸ�� Į����� ����
    FROM �������� ���� ���̺�� 1�� ����
    JOIN ������ ���̺�� 1���� ���� USING (������ Į���� 1���� ����)
*/
    
    
-- ����Ŭ ���� ����
-- FROM ���� ��ȸ�� ���̺���� ','�� ���� 
-- WHERE ���� ������� ���� ������ ����

-- ��ü ����� ���, �����, �μ��ڵ�, �μ���
SELECT 
    EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;  -- ����� ����
-- ��ġ���� �ʴ� ������ ��ȸ���� ����(NULL, D3, D4, D7)
--> �ΰ� �̻��� ���̺��� ������ �� ��ġ�ϴ� ���� ���� ���� ������� ���ܵ� ��

    
-- ��ü ������� ���, �����, �����ڵ�, ���޸�
-- ������ �� Į������ ������ ��� 
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE;
-- � ���̺��� Į������ �ݵ�� ����ؾ� �Ѵ�.
    
    
-- ���1) ���̺���� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
    
-- ���2) ���̺� ��Ī�� �ٿ��� ����ϴ� ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;


-- ANSI ����
-- FROM���� ���� ���̺��� "�ϳ���"��� �� ��
-- �� �ڿ� JOIN������ ���� ��ȸ�ϰ��� �ϴ� ���̺� ���, ���� ��ĥ��ų Į���� ���� ���ǵ� ���� ���
-- USING����/ ON����

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
/*INNER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);  -- ������ ON������ ����(Į������ �������� ����)
-- DEPT_CODE�� NULL�� ������� ��ȸ���� ����
-- INNER ���������� 


-- ������ �� Į������ ������ ���
-- ON������ USING���� ��� ��� ������

-- 1) ON���� : Į������ �ָŸ�ȣ�ϴٶ�� ������ �߻��� �� �ֱ� ������ �ݤ���� ���̺�� OR ��Ī�� ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);


-- 2) USING���� : Į������ ������ ��쿡�� ��� ����
--              ������ Į���� �ϳ��� ���ָ� �˾Ƽ� ��Ī������
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME 
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);


-- 3) NATURAL JOIN : ������� ��� �� �ϳ�
-- ������ Ÿ�԰� �̸��� ���� Į���� ���� �������� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME 
FROM EMPLOYEE
NATURAL JOIN JOB;
-- �� ���̺��� ��ġ�ϴ� Į���� �����ϰ� ���ϳ� ������ �� �ش� Į���� ������������ ����
-- �ǹ����� �� ������� ����...


-- ���ν� �߰����� ���ǵ� ���� �����ϴ�
-- ������ �븮�� ������� ������ ��ȸ(���, �����, ����, ���޸�)

-- ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME 
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE 
    AND JOB_NAME = '�븮';


-- ANSI ����
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME 
FROM EMPLOYEE E
JOIN JOB J ON (E.JOIN_CODE = J.JOB_CODE)
WHERE JOB_NAME = '�븮';



------------ �ǽ����� ------------
-- 1. �μ��� '�λ������'�� ������� ���, �����, ���ʽ��� ��ȸ
-- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
    AND DEPT_TITLE = '�λ������';

-- ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE = '�λ������';


--2. �μ��� '�ѹ���'�� �ƴ� ������� ���, �����, �޿�, �Ի��� ��ȸ
-- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
    AND DEPT_TITLE <> '�ѹ���';

-- ANSI ����
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE ^= '�ѹ���';


-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
-- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
    AND BONUS IS NOT NULL;

-- ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. �Ʒ��� �� ���̺��� �����ؼ� �μ��ڵ�, �μ���, �����ڵ�, ������(LOCAL_NAME) ��ȸ
-- ����Ŭ ���뱸��
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;

SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;
    
-- ANSI ����
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);


----------------------------------------------------------------------------

-- DEPT_CODE�� NULL�� ������� INNER JOIN���� ��ȸ���� ����
-- �� �μ������� ���� ���� ������� ��ȸ���� ����

/*
    2. �������� / �ܺ����� (OUTER JOIN)
    ���̺��� JOIN�� "��ġ���� �ʴ� ��"�� ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT Ȥ�� RIGHT�� �����ؾ� �� 
    => LEFT�� ������ ������ �Ǵ� ���̺�, RIGHT�� �������� ������ �Ǵ� ���̺�
    
    ��ġ�ϴ� ��� ������ �Ǵ� ���̺� �������� ��ġ���� ���� �൵ ���Խ��Ѽ� ��ȸ
    
*/

-- ��ü ������� �����, �޿�, �μ��� ��ȸ
-- 1) LEFT OUTER JOIN : �� ���̺� �� ���� ����� ���̺��� �������� JOIN
-- ��, ���� �Ǿ��� ���� ���� ����� ���̺��� �����ʹ� ������ ��ȸ�ǰ� �Ѵ�.
-- (��ġ�ϴ� ���� ������ ��ȸ ����)

-- ANSI ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE 
LEFT /*OUTER*/ JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
-- ���� �������� ���� ���̺��� Į������ �ƴ� �ݴ� ���̺��� Į���� (+)�� �ٿ��ش�.


-- 2) RIGHT OUTER JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
-- ��, ���� �Ǿ��� ���� ������ ����� ���̺��� �����ʹ� ������ ��ȸ�ǰ� �Ѵ�.
-- (��ġ�ϴ� ���� ������ ��ȸ ����)

-- ANSI ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE 
RIGHT /*OUTER*/ JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;


-- 3) FULL OUTER JOIN : �� ���̺��� ���� ��� ���� ��ȸ
-- ��ġ�ϴ� ��� + LEFT JOIN ���� ���Ӱ� �߰��� ��� + RIGHT JOIN ���� ���Ӱ� �߰��� ���

-- ANSI ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE 
FULL /*OUTER*/ JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ����Ŭ ���� ���� => ���Ұ�!!!
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);


----------------------------------------------------------------------------

/*
    3. ī�׽þȰ� / ��������
    
    ��� ���̺��� �� ����� ���� ���ε� �����Ͱ� ��ȸ��(������)
    �� ���̺��� ����� ��� ������ ����� ���� ���
    
    => ���� N��, M���� ���� ���� ���̺���� ī�׽þ� ���� �����  N*M��
    => ��� ����� ���� �� ������ ��ȸ
    => ����� �����͸� ����� ������ �ִ�.
*/

-- �����, �μ���
-- ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT;

-- ANSI ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;
-- ī�׽þ� ���� ��� WHERE���� ����ϴ� ���� ������ �߸��Ǿ��ų� �ƿ� ���� ��� �߻�


----------------------------------------------------------------------------

/*
    4. �� ����(NON_EQUAL JOIN)
    '='�� ������� �ʴ� ���ι� => �ٸ� �񱳿����ڸ� ����Ͽ� ����
    (>, <, BETWEEN A AND B...) 
    => ������ Į�� ������ ��ġ�ϴ� ��찡 �ƴ϶� "����"�� ���ԵǴ� ��� ��Ī�ؼ� ��ȸ
*/

-- �����, �޿�
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT * FROM SAL_GRADE;


-- �����, �޿�, �޿����(SAL_LEVEL)
-- ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, EMPLOYEE.SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
--WHERE EMPLOYEE.SAL_LEVEL = SAL_GRADE.SAL_LEVEL;
--WHERE SALARY >= NIN.SAL AND SALARY <= MAX.SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI ����
SELECT EMP_NAME, SALARY, SAL_GRADE.SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);


----------------------------------------------------------------------------

/*
    5. ��ü���� (SELF JOIN)
    
    ���� ���̺��� �����ϴ� ���
    ��, �ڱ��ڽ��� ���̺�� �ٽ� ������ �ΰڴ�.
    => ��ü���ν� �ݵ�� ���̺� ��Ī�� �ο��ؾ� �Ѵ�.
    (������(��-��-��-ī�װ�) ������ ���� ���ȴ�!)
*/

-- ����� ���, �����, ����� ���, ����� ��ȸ
-- ����Ŭ ���� ����
SELECT E.EMP_ID, E.EMP_NAME, M.EMP_ID, M.EMP_NAME
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);

-- ANSI ����
SELECT E.EMP_ID, E.EMP_NAME, M.EMP_ID, M.EMP_NAME
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID(+)); 


----------------------------------------------------------------------------

/*
    <���� ����>
    3�� �̻��� ���̺��� �����ؼ� ��ȸ => ���� ������ �߿��ϴ�
*/

-- ���, �����, �μ���, ���޸�
-- ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE E.DEPT_CODE = DEPT_ID(+)
    AND E.JOB_CODE = J.JOB_CODE;
    

-- ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E 
LEFT JOIN DEPARTMENT ON E.DEPT_CODE = DEPT_ID
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;







