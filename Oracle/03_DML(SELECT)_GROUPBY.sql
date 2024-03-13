/*
    <GROUP BY ��>
    
    �׷��� ������ ������ ������ �� �ִ� ���� => �׷��Լ��� ���� ����
    ���õ� ���غ��� �׷��� ������ �� �ִ�.
    ���� ���� ������ �ϳ��� �׷����� ��� ó���� �������� �����
    
    [ǥ����]
    GROUP BY ������ �����̵� Į��
*/

-- �� �μ����� �� �޿��� �հ�
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE;
-- ��ȯ���� ������ ���� �ٸ��� ������ �����߻���

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 'D1'�μ��� �� �޿��� �հ�
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- �� �μ��� ��� �� �հ�
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� �� �޿����� �μ��� ������������ �����ؼ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

-- �������
-- FROM -> GROUP BY -> SELECT -> ORDER BY 

-- �� �μ����� �� �޿��� �������� ����
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 2 DESC;


-- �� ���޺��� �����ڵ�, �� �޿��� ��, �����, ���ʽ��� �޴� �����, ��ձ޿�, �ְ�޿�, �ּұ޿�
SELECT JOB_CODE, SUM(SALARY), COUNT(*), COUNT(BONUS), MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- �� �μ��� �μ��ڵ�, �����, ���ʽ��� �޴� �����, ����� �ִ� �����, ��� �޿�
SELECT DEPT_CODE, COUNT(*), COUNT(BONUS), COUNT(MANAGER_ID), ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ������ �����
-- ���� : SUBSTR(EMP_NO, 8, 1)
SELECT COUNT(*), SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- ���� �������� ��� �޿�
SELECT ROUND(AVG(SALARY)) || '��' ��ձ޿�,
       CASE SUBSTR(EMP_NO, 8, 1) WHEN '1' THEN '����'
       ELSE '����' END ����
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
 
-- �� �μ����� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000
GROUP BY DEPT_CODE;
-- ������� : FROM -> WHERE ���̱� ������ GROUPȭ �Ǳ� ���̶� �����߻���

/*
    <HAVING ��>
    
    �׷쿡 ���� ������ �����ϰ��� �� �� ���Ǵ� ����
    (�ַ� �׷��Լ��� ������ ���� ����) => �׻� GROUP BY���� ���ȴ�.
*/

-- �� �μ��� ��ձ޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;
-- ������� : FROM -> HAVING -> WHERE


-- �� ���޺� �� �޿����� 1000���� �̻��� ���� �ڵ�, �޿� ���� ��ȸ
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- �� �μ��� ���ʽ��� �޴� ����� ���� �μ��� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;



/*
    <ROLLUP>�� <CUBE>
    - �׷캰 ������ ���� "����"�� ����ϴ� �Լ�
    
    -ROLLUP(�׷� ���ؿ� �ش��ϴ� Į����/�Լ���, �׷� ���ؿ� �ش��ϴ� Į����/�Լ���)
            : ���ڷ� ���޹��� �׷��� ���� ���� ������ �׷��� �������� �߰� ���� ����� ��ȯ����
            
    -CUBE(�׷� ���ؿ� �ش��ϴ� Į����/�Լ���, �׷� ���ؿ� �ش��ϴ� Į����/�Լ���)
            : ���ڷ� ���޹��� �׷��� ������ ��� ���պ� ���踦 ��ȯ����
*/

-- �μ��� ���޺� �޿� �հ�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;
-- JOB_CODE�� ������ DEPT_CODE�� ���� �߰����� ����� ��ȯ

-- ��� ���պ� ��踦 ����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

-------------------------------------------------------------

/*
    <SELECT �� ���� �� �������>
    
    5. SELECT : ��ȸ�ϰ��� �ϴ� Į����� / * / ���ͷ� / �������� / �Լ��� 
    1. FROM : ��ȸ�ϰ��� �ϴ� ���̺�� / DUAL(�������̺�)
    2. WHERE : ���ǽ�(�׷��Լ��� ���Ұ�)
    3. GROUP BY : �׷� ���ؿ� �ش��ϴ� Į���� / �Լ���
    4. HAVING : �׷��Լ��Ŀ� ���� ���ǽ�
    6. ORDER BY : �����ϰ��� �ϴ� Į���� / ���� / ��Ī [ASC/EDSC] [NULLS FIRST/LAST]
*/

-------------------------------------------------------------

/*
    <���տ����� SET OPERATOR>
    
    ���� ���� �������� �ϳ��� ���������� ����� ������
    
    - UNION(������) : �� �������� ������ �����(RESULTSET)�� ���� �� �ߺ��Ǵ� �κ��� �� �� ���� �ߺ��� ������ ��
    - UNION ALL : �� �������� ������ ������� ���� �� �ߺ��Ǵ� ���� �������� ���� ��
    - INTERSECT(������) : �� �������� ������ ������� �ߺ��� ���� ���� ��
    - MINUS(������) : ���� �������� ��������� ���� �������� ������� �� ������ �κ�
    
    ** ������ �� : �� �������� ������ ����� ���ļ� �Ѱ��� RESULTSET���� ������� �ϱ� ������
            �� �������� ������ SELECT �� �κ��� �����ؾ� �Ѵ�.
            => ��ȸ�� Į���� �����ؾ� �Ѵ�.
*/

-- 1. UNION(������) : �� �������� ������ �����(RESULTSET)�� ���� �� �ߺ��� ����
-- �μ��ڵ尡 D5�̰ų� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ(���, �����, �μ��ڵ�, �޿�)

-- UNION �̻�� 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';  -- 6��(�ڳ���~���ȥ)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;   -- 8��(������~������)


-- UNION ��� 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'  -- 6��(�ڳ���~���ȥ)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;   -- 8��(������~������)
-- ���ȥ, �ɺ����� �μ��� D5�̸鼭 300���� �ʰ��̱� ������ �ߺ����� ���ŵ� ->12��


-- �����ڵ尡 J6�̰ų� �μ��ڵ尡 D1�� ����鸸 ��ȸ(���, �����, �μ��ڵ�, �����ڵ�)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' 
UNION /*ALL*/
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';
--UNION ALL : �������� ��������� ���ؼ� �ߺ��� ���� ��µȴ�.


-- 3. INTERSECT : ������, ���� ���� ����� �ߺ��� ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' 
INTERSECT 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';


-- 4. MINUS : ������, ���� ����������� ���� ��������� �� �������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' 
MINUS 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';
