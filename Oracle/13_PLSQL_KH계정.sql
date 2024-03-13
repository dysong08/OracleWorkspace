/*
    <PL/SQL>
    PROCEDURE LANGUAGE EXTENSTION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ��ִ� ������ ���
    SQL���� ������ ������ ����, ����ó��, �ݺ�ó��, ����ó�� ���� �����Ͽ�
    SQL�� ������ ����. 
    �� ���� �ټ��� SQL���� ���� �� �� �ִ�.
    
    
    * <PL/SQL>
    - [����� (DECLARE SECTION)] : DECLARE�� ����, ������ ����� ���� �� �ʱ�ȭ�Ѵ�
    - ����� (EXECUTABLE SECTION) : BEGIN���� ����, SQL�� �Ǵ� ��� ���� ������ ����ϴ� �κ�
    - [����ó���� (EXCEPTION SECTION)] :
        EXCEPTION���� ����, ���ܹ߻��� �ذ��ϱ� ���� ������ �̸� ����ص� �� �ִ� �κ�
    
*/

-- * ���� �ƿ�ǲ �ɼ��� ON(�ܼ�â�� ������ ������ִ� �ɼ�)
SET SERVEROUTPUT ON;

BEGIN 
    DBMS_OUTPUT.PUT_LINE('HELLO_ORACLE');
END;
/

/*
    1. DECLARE �����
    ���� �� ��� �����ϴ� ����
    �Ϲ�Ÿ�Ժ���, ���۷�������, ROWŸ�Ժ���
    
    1_1) �Ϲ�Ÿ�� ���� ���� �� �ʱ�ȭ
    [ǥ����] ������ [CONSTANT] �ڷ��� [:= ��];
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    EID := &��ȣ;
    ENAME := '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
-- �� '/' �� �־�� ��� ����� ���ֵǾ� ���� PL�� ������ �����ϴ�.



-- 1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ
-- (� ���̺��� � Į���� ������Ÿ���� �����ؼ� �� Ÿ������ ����)
-- ������ ���̺��.Į����%TYPE;

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    EID := '300';
    ENAME := 'ȫ�浿';
    SAL := 3000000;
    
    -- ����� 200���� ����� ���, �����, ������ ���� EID, ENAME, SAL ������ �����ϱ�
    SELECT
        EMP_ID, EMP_NAME, SALARY
        INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/




/*
    ���۷��� Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE�� �����ϰ�
    ���� �ڷ��� EMPLOYEE(EMP_ID, EMP_NAME, JOB_CODE, SALARY)
    DEPARTMENT(DEPT_TITLE)���� �����ϵ��� ����
    
    ����ڰ� �Է��� ����� ����� ���, �����, �����ڵ�, �޿�, �μ��� ��ȸ �� ����ϱ�
*/

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
        INTO EID, ENAME, JCODE, SAL, DTITLE
        FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID = &���;

    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE : ' || DTITLE);
    
END;
/

SELECT * FROM EMPLOYEE;



-- 1_3) ROWŸ�� ���� Ÿ��
--      ���̺��� �� �࿡ ���� "���" Į������ �Ѳ����� ���� �� �ִ� ����
--      ������ ���̺��%ROWTYPE;

DECLARE 
    E EMPLOYEE%ROWTYPE;

BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME );
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY );
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || E.BONUS );
END;
/


-------------------------------------------------------------

-- 2. BEGIN �����
-- <���ǹ�>

-- 1) IF���ǽ� THEN ���೻��
-- ����� �Է¹��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ���(%)�� ����Ͻÿ�
-- ��, ���ʽ��� ���� �ʴ� ����� '���ʽ��� ���� �ʴ� ����Դϴ�' �� ���

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
        INTO EID, ENAME, SAL, BONUS
        FROM EMPLOYEE
        WHERE EMP_ID = &���;

    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SAL);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� �ʴ� ����Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || BONUS);
    -- IF���� �ش�Ǿ ELSE���� ��� �Ѵ� ��µȴ�!
    
END;
/


-- 2) IF ���ǽ� THEN ���೻�� ELSE ���೻�� 

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
        INTO EID, ENAME, SAL, BONUS
        FROM EMPLOYEE
        WHERE EMP_ID = &���;

    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SAL);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� �ʴ� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || BONUS);
    END IF;   
END;
/



--------------------------- �ǽ����� --------------------------------------

DECLARE 
    -- ���۷���Ÿ�Ժ��� (EID, ENAME, DTITLE, NCODE)
    -- ������ Į��(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    -- �Ϲ�Ÿ�Ժ��� ������ TEAM VARCHAR2(10)
    TEAM VARCHAR2(10);

BEGIN
    -- ����ڰ� �Է��� ����� ����� ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ ��
    -- �� ������ ����
    -- ��ȸ�� �ڵ��� NCODE�� ���� KO�� ��� TEAM������ '�ѱ���' ����
    -- �ƴҰ�� TEAM�� '�ؿ���' ����
    
    -- ���, �̸�, �μ�, �Ҽ��� ����Ͻÿ�

    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
        INTO EID, ENAME, DTITLE, NCODE
        FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
        LEFT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
        WHERE EMP_ID = &���;
        
            
        IF NCODE = 'KO'
            THEN TEAM := '�ѱ���';
        ELSE 
            TEAM := '�ؿ���';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
        DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
        DBMS_OUTPUT.PUT_LINE('�μ� : ' || DTITLE);
        DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
END;
/
----------------------------------------------------------

-- 3) IF ���ǽ�1 THEN ���೻�� ELSIF ���ǽ�2 THEN ���೻�� [ELSE ���೻��] END IF;

-- �޿��� 500���� �̻��̸� ���
-- 300���� �̻��̸� �߱�
-- �׿� �ʱ�
-- ��¹� : �ش� ����� ����� XX�Դϴ�.

DECLARE 
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT SALARY
    INTO SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    IF SAL >= 5000000 THEN GRADE := '���';
    ELSIF SAL >= 3000000 THEN GRADE := '�߱�';
    ELSE GRADE := '�ʱ�';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('�ش� ����� �޿������ ' || GRADE || '�Դϴ�.');   
END;
/



-- 4) CASE �񱳴���� WHEN ����񱳰�1 THEN �����1 WHEN �񱳰�2 THEN �����2 ELSE ����� END;

DECLARE 
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30);
     
BEGIN
    SELECT * 
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DNAME := CASE EMP.DEPT_CODE
            WHEN 'D1' THEN '�λ���'
            WHEN 'D2' THEN 'ȸ����'
            WHEN 'D3' THEN '������'
            WHEN 'D4' THEN '����������'
            WHEN 'D9' THEN '�ѹ���'
            ELSE '�ؿܿ�����'
            END;
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '�� ' || DNAME || '�Դϴ�');
END;
/



/*
    1) BASIC LOOP��
    [ǥ����]
    LOOP
        �ݺ������� ������ ����;
        
        * �ݺ����� �������� �� �ִ� ���� �ʿ�
    END LOOP;
    
    
    * �ݺ����� �������� �� �ִ� ���� 2����
    1) IF ���ǽ� THEN EXIT; ENDIF;
    2) EXIT WHEN ���ǽ�;
*/


-- 1~5���� ���������� 1�� �����ϴ� ���� ����ϱ�

DECLARE 
    I NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I+1;
        
       -- IF I = 6 THEN EXIT; END IF; (==)
       EXIT WHEN I = 6;
    END LOOP;
END;
/



/*
    2) FOR LOOP��
    FOR ���� IN [REVERSE] �ʱⰪ.. ������
    LOOP
        �ݺ������� ������ ����;
    END LOOP;
*/

BEGIN 
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/


---------------------------------------
DROP TABLE TEST;

CREATE TABLE TEST (
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

CREATE SEQUENCE SEQ_TNO;

BEGIN 
    FOR I IN 1..5000
    LOOP
        INSERT INTO TEST VALUES (SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
    COMMIT;
    
END;
/

SELECT COUNT(*) FROM TEST;



-- 3) WHILE LOOP��
/*
    WHILE �ݺ����� ����� ����
    LOOP
        �ݺ������� �����ų ����
    END LOOP;
*/

DECLARE 
    I NUMBER := 1;
BEGIN 
    WHILE I < 6
    LOOP
        DBMS_OUTPUT.PUT_LINE (i);
        I := I+1;
    END LOOP;   
END;
/




-- ������ ¦���� ����Ͻÿ�
-- 2 X 1 = 2
-- 2 X 2 = 4 
-- 2��, 4��, 6��, 8�� ���

-- 2_1) FOR LOOP�� Ȱ��
BEGIN 
    FOR DAN IN 2..9     
    LOOP  
        IF MOD(DAN,2) = 0  
            THEN
                FOR SU IN 1..9
                LOOP 
        
                DBMS_OUTPUT.PUT_LINE(DAN || 'X' || SU || '=' || DAN*SU );
                END LOOP;
                DBMS_OUTPUT.PUT_LINE('==================' );
        END IF;
    END LOOP;
END;
/


-- 2_2) WHILE LOOP�� Ȱ��
DECLARE 
    DAN NUMBER;
    SU NUMBER;
BEGIN 
    DAN := 2;
    WHILE DAN <= 9
    LOOP
        SU := 1;       
        IF MOD(DAN,2) = 0
            THEN 
                WHILE SU <= 9
                LOOP
                    DBMS_OUTPUT.PUT_LINE(DAN || 'X' || SU || '=' || DAN*SU );
                    SU := SU+1;
                END LOOP;
                DBMS_OUTPUT.PUT_LINE('==================' );
        END IF;
        DAN := DAN+1;
    END LOOP;   
END;
/


------------------------------------------------------------------

-- 4) ����ó����

/*
    ����(EXCEPTION) : ������ �߻��ϴ� ����
    
    [ǥ����]
    EXCEPTION
        WHEN ���ܸ�1 THEN ����ó������1;
        WHEN ���ܸ�2 THEN ����ó������2;
        ..
        WHEN OTHERS THEN ����ó������N;    
    
    
    * �ý��� ����(����Ŭ���� �̸� �����ص� ����)
    - NO_DATA_FOUND : SELECT�� ����� �� �൵ ���� ���
    - TOO_MANY_ROW  : SELECT�� ����� ���� ���� ���
    - ZERO_DIVIDE : 0���� ������
    ...
*/


-- ����ڰ� �Է��� ���� ������ ������ ����� ���
-- 0�� �Է����� ����� ����ó��
DECLARE 
    RESULT NUMBER;
BEGIN
    RESULT := 10 / &����;
    DBMS_OUTPUT.PUT_LINE('��� : ' || RESULT);
EXCEPTION
    WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������� 0���� ���� �� �����ϴ�.');
END;
/


-- UNIQUE�������� ����� ����ó��
BEGIN 
    UPDATE EMPLOYEE
    SET EMP_ID = &���
    WHERE EMP_NAME = '���ö';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/


DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = &������;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID || ',' || '�̸� : ' || ENAME);
EXCEPTION 
    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ʹ� ���� ���� ��ȸ�Ǿ����ϴ�.');
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('��ȸ�� �����Ͱ� �����ϴ�.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��߽��ϴ�.');
END;
/










