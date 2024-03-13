/*
    <SUBQUERY ��������>
    �ϳ��� �ֵ� SQL�ȿ� ���Ե� �� �ϳ��� SELECT��
    
    ���� SQL���� ���ؼ� ���� ������ �ϴ� SELECT��
    => �ַ� ���������� ���� ���δ�.
*/

-- ���� �������� ����1
-- ���ö ����� ���� �μ��� �����
-- 1) ���ö ����� �μ��ڵ带 ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

-- 2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- �� �δܰ� ��ġ��
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 
    (SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '���ö');
-- FROM -> WHERE -> 


-- ���� �������� ����2
-- ��ü����� ��� �޿����� �� ���� �޿��� �ް� �ִ� ������� ���, �̸�, �����ڵ� ��ȸ
-- 1) ��ü ����� ��ձ޿� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 2) �޿��� 3047000�� �̻��� ����� ��ȸ
SELECT EMP_NO, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3047000;

-- �� �δܰ� ��ġ��
SELECT EMP_NO, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);


/*
    �������� ����
    ���������� ������ ������� ���� ��̳Ŀ� ���� �з���
    
    - ������ (���Ͽ�) �������� : ���������� ������ ������� ������ 1���� ��(��ĭ�� Į������ ���ö�)
    - ������ (���Ͽ�) �������� : ������� ���� ���϶�
    - (������) ���߿� �������� : ���������� ������ ������� ���� ���϶�
    - ������ ���߿� ��������  : ���������� ������ ������� ������ �������϶�
    
    => ���������� ������ ����� ���� ��̳Ŀ� ���� ��밡���� �����ڰ� �޶���
*/

-----------------------------------------------------------------

/*
    1. ������ ���Ͽ� ��������(SINGLE ROW SUBQUERY)
    ���������� ��ȸ ������� ������ 1���� ��
    
    ��밡�� ������ => =, != , <=, >=, ...
*/

-- �� ������ ��� �޿����� �� ���� �޴� ������� �����, �����ڵ�, �޿���ȸ
-- 1) �� ������ ��� �޿� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 2) �޿��� ���(3047000��)���� ���� �޴� ����� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < 3047000;
              
-- �� �δܰ� ��ġ��
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);


-- ���� �޿��� �޴� ����� ���, �����, �����ڵ�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);


-- ���ö������� �޿��� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');

-- ���ö������� �޿��� �� ���� �޴� ����� ���, �̸�, �μ���, �޿� ��ȸ
--(��������+����)
-- ����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+)
AND SALARY > (SELECT SALARY FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
                
-- ANSI����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID(+))
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
                

-- �μ��� �޿� ���� ���� ū �μ� �ϳ����� ��ȸ. �μ��ڵ�, �μ���, �޿��� ��
-- (��������, GROUP BY, JOIN)

-- 1) �� �μ��� �޿� �� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
                
-- 2) �� �޿��� ���� ū �μ� ��ȸ            
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;               
                
-- 3) �� �δܰ� ��ġ��
SELECT DEPT_CODE, DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_CODE, DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE );             
                
 -----------------------------------------------------------------
 
 /*
    2. ������ ��������(MULTI ROW SBUQUERY)
    
    ���������� ��ȸ ������� ���� ���� ���
    
    - IN (10,2030) �������� : �������� ����� �߿��� �ϳ��� ��ġ�ϴ� ���� �ִٸ�
    - > OR < ANY(10,20,30) : �������� ����� �߿��� "�ϳ���" ũ�ų� ���� ���
    - > OR < ALL (10,20,30) : �������� ������� "���" ������ ũ�ų� ���� ���
 */
 
 -- �� �μ��� �ְ� �޿��� �޴� ����� �̸�, �����ڵ�, �޿� ��ȸ
 --1) �� �μ��� �ְ� �޿� ��ȸ(������, ���Ͽ�)
 SELECT MAX(SALARY)
 FROM EMPLOYEE
 GROUP BY DEPT_CODE;
 
 -- 2) �� �޿��� �޴� ����� ��ȸ
 SELECT EMP_NAME, JOB_CODE, SALARY
 FROM EMPLOYEE
 WHERE SALARY IN (2890000,3660000,8000000,3760000,3900000,2490000,2550000);

 -- 3) �� ������ ��ġ��
 SELECT EMP_NAME, JOB_CODE, SALARY
 FROM EMPLOYEE
 WHERE SALARY IN ( SELECT MAX(SALARY)
                    FROM EMPLOYEE
                    GROUP BY DEPT_CODE);
 
 
 -- ������ �Ǵ� ����� ����� ���� �μ��� ����� ��ȸ(�����, �μ��ڵ�, �޿�)
 SELECT DEPT_CODE
 FROM EMPLOYEE
 WHERE EMP_NAME IN ('������', '�����');
 
 SELECT EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE IN ( SELECT DEPT_CODE
                      FROM EMPLOYEE
                      WHERE EMP_NAME IN ('������', '�����'));
 
 
 -- �븮 �����ӿ��� �ұ��ϰ� ���� ������ �޿����� ���� �޴� ����� ��ȸ
 --(���, �̸�, ���޸�, �޿�) / ��� < �븮 < ���� < ���� < ����
 
 -- 1) ���� ���޵��� �޿� ��ȸ
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'; -- 2200000,2500000,3760000
 
 -- 2) �� �޿���ϵ麸�� �ϳ��� ���� �޿��� �޴� ������ ��ȸ
SELECT EMP_NO, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮' AND SALARY >= ANY(SELECT SALARY
                                    FROM EMPLOYEE
                                    JOIN JOB USING(JOB_CODE)
                                    WHERE JOB_NAME = '����');
 
-- ���� �����ӿ��� ��� ���������� �޿����� �� ���� �޴� ���� ��ȸ
--(���, �̸�, ���޸�, �޿�)

-- 1) 
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����' 
AND SALARY > ALL(SELECT SALARY
                 FROM EMPLOYEE
                JOIN JOB USING(JOB_CODE)
                WHERE JOB_NAME = '����');

-----------------------------------------------------------------
    
/*
    3. (������) ���߿� ��������
    �������� ��ȸ ����� ���� ���������� ������ Į���� �������� ���
*/       
           
-- ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش�Ǵ� ����� ��ȸ
-- (�����, �μ��ڵ�, �����ڵ�, �����)

-- 1) ������ ����� �μ��ڵ�, �����ڵ� ��ȸ
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';

-- 2) �μ��ڵ尡 D5�̸鼭 J5������ ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND JOB_CODE ='J5';

-- 3) �� �� �������� �ϳ��� ��ġ��
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '������')
AND JOB_CODE = (SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '������');
-- ���߿� �������� (���� ���� ������ ���缭 Į������ ����)
-- WHERE(�񱳴��Į��1, �񱳴��Į��2) = (���Ұ�1, ���Ұ�2 => �������� �������� �����ؾ� ��)


SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
--WHERE (DEPT_CODE, JOB_CODE) = ('D5', 'J5'); -- ���ͷ��� ���úҰ���

WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '������');


-- �ڳ��� ����� ���� �����ڵ�, ���� �������� ���� ����� ��ȸ
--(���, �̸�, �����ڵ�, ������)
-- ������ ���߿� �������� �̿��Ͽ� �ۼ�
SELECT JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '�ڳ���';

SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '�ڳ���');

-----------------------------------------------------------------

/*
    4. ������ ���߿� ��������
    �������� ��ȸ ����� ���� �� ���� Į���� ���
*/

-- �� ���޺� �ּұ޿��� �޴� ����� ��ȸ(���, �̸�, �����ڵ�, �޿�)
-- 1) �� ���޺� �ּұ޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2) �� ��ϵ� �� ��ġ�ϴ� ��� ��ȸ
-- 2-1) ���� ���� (OR)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE = 'J2' AND SALARY = '3700000')
    OR (JOB_CODE = 'J2' AND SALARY = '1380000')
;
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                        FROM EMPLOYEE
                        GROUP BY JOB_CODE);



-- �� �μ��� �ְ� �޿��� �޴� ����� ��ȸ(���,�̸�, �μ��ڵ�,�޿�)
-- �μ��� ���� ��� �μ����� �������� ��ȸ

-- 1) �μ��� �ְ� �޿� ��ȸ
SELECT NVL(DEPT_CODE, '����'), MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE, '����'), SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE,'����'), SALARY) IN (SELECT NVL(DEPT_CODE, '����'), MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE)
ORDER BY 1;


SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE)
ORDER BY 1;

-----------------------------------------------------------------

/*
    5. �ζ��� ��(INLINE VIEW)
    FROM ���� ���������� �����ϴ� ��
    
    ���������� ������ ����� ���̺� ����ؼ� �����
*/

-- ���ʽ� ���� ������ 3000���� �̻��� ������� ���, �̸�, ���ʽ����Կ���, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 "���ʽ� ���� ����", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + SALARY*NVL(BONUS,0))*12 >= 30000000;

-- �ζ��� �並 ����Ͽ� ����� ��󳻱�
SELECT EMP_NAME
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 "���ʽ� ���� ����", DEPT_CODE)
FROM EMPLOYEE
WHERE (SALARY + SALARY*NVL(BONUS,0))*12 >= 30000000;

-- EX)
SELECT EMP_ID
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 "���ʽ� ���� ����", DEPT_CODE
        FROM EMPLOYEE
        WHERE (SALARY + SALARY*NVL(BONUS,0))*12 >= 30000000);

SELECT EMP_ID
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 "���ʽ� ���� ����", DEPT_CODE
        FROM EMPLOYEE
        WHERE (SALARY + SALARY*NVL(BONUS,0))*12 >= 30000000)
WHERE DEPT_CODE IS NULL;

-- ������� : FROM -> SUBQURTY FROM -> 



-- �ζ��� �並 �ַ� ����ϴ� ��
-- TOP-N�м� : DB�� �ִ� �ڷ��� �ֻ��� N���� �ڷḦ ���� ���� ����ϴ� ���

-- �� ������ �޿��� ���� ���� ���� 5��(����, �����, �޿�)
-- * ROWNUM : ��ȸ�� ������� 1���� ������ �ο����ִ� Į��(����Ŭ���� �������ִ� Į��)
SELECT E.*, ROWNUM FROM EMPLOYEE E;

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
-- ���ļ����� �̻���

-- �ذ� : ORDER BY�� ������ ���̺��� ������ ROWNUM�� �ο��ϱ�
SELECT  ROWNUM, EMP_NAME, SALARY
FROM (  SELECT * 
        FROM EMPLOYEE 
        ORDER BY SALARY DESC  )
WHERE ROWNUM <= 5;



-- �� �μ��� ��� �޿��� ���� �μ��� �μ��ڵ� 3��, ��� �޿� ��ȸ
-- 1) �� �μ��� ��� �޿�
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 2 DESC;

-- 2) �����ο�, ���� 3���� �߸���
SELECT ROWNUM "����", S.* /*DEPT_CODE, ROUND(AVG(SALARY))*/
FROM ( SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS "��ձ޿�"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY 2 DESC ) S --��Ī���̱�
WHERE ROWNUM <= 3;

-- ROWNUM�� �̿��ؼ� ������ �ű� �� �ִ�.
-- �ٸ�, ������ ���� ���� ���¿����� ������ �Űܵ� �ǹ̰� �����Ƿ�
-- �� ���� �� ���� �ű�⸦ �ؾ� �Ѵ�.
-- ��, �ζ��κ�� ���� ORDER BY�� �ϰ� ������������ ������ �Űܾ� ��


-----------------------------------------------------------------

/*
    6. WINDOW FUNCTION(���� �ű�� �Լ�)
    -> SELECT�������� ��� ����
    
    RANK() OVER(���ı���)
    DENSE_RANK() OVER(���ı���)
    
    - RANK() OVER(���ı���) : ���� 1���� 3���̸� �� ���������� 4��
    - DENSE_RANK() OVER(���ı���) : ���� 1���� 3���̸� �� ���������� 2��
    
    ���ı��� : ORDER BY��(���ı��� Į���̸�, ��������/��������)
*/

-- ������� �޿��� ���� ������� �Űܼ� �����, �޿�, ���� ��ȸ 
-- RANK() OVER
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;


-- DENSE_RANK() OVER
SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;


-- �ζ��κ�� 5�������� ��ȸ�ϱ�
SELECT E.*
FROM (SELECT EMP_NAME, SALARY, 
        DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
        FROM EMPLOYEE) E
WHERE "����" <= 5;







