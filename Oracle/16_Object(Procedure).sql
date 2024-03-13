/*
    <PROCEDURE> ���ν���
    PL/SQL���� �����ؼ� �̿��ϴ� ��ü
    �ʿ��� ������ ���� �ۼ��� PL/SQL���� ���ϰ� ȣ�� �����ϴ�
    
    * ���ν��� �������
    [ǥ����]
    CREATE [OR REPLACE] PROCEDURE ���ν�����1[(�Ű�����)]
    IS
    BEGIN
        ����κ�
    END;
    
    
    * ���ν��� ������
    EXEC ���ν�����;
*/

-- EMPLOYEE���̺� ����
CREATE TABLE PRO_TEST
AS SELECT * FROM EMPLOYEE;

CREATE PROCEDURE DEL_DATA
IS
--�������� ����
BEGIN
    DELETE FROM PRO_TEST;
    COMMIT;
END;
/

SELECT * FROM PRO_TEST;


-- ������ ���ν��� ����
EXEC DEL_DATA;
SELECT * FROM PRO_TEST;



-- ���ν����� �Ű����� �߰��ϱ�
-- IN : ���ν����� ����� �ʿ��� ���� "�Է¹޴�" ����(�ڹ��� �Ű������� �����ϰ� ����)
-- OUT : ���ν����� ȣ���� ������ ���� "�ǵ����ִ�" ����(�����)

CREATE OR REPLACE PROCEDURE PRO_SELECT_EMP(
    V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
    V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SALARY OUT EMPLOYEE.SALARY%TYPE,
    V_BONUS OUT EMPLOYEE.BONUS%TYPE
    )
IS
BEGIN
    SELECT EMP_NAME, SALARY, BONUS
    INTO V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/


-- �Ű����� �߰��� ���ν��� �����ϱ�
-- ���� �� ������� ������ ���� ����

VAR EMP_NAME VARCHAR2(20);
VAR SALARY NUMBER;
VAR BONUS NUMBER;

EXEC PRO_SELECT_EMP(200, :EMP_NAME, :SALARY, :BONUS);

PRINT EMP_NAME;
PRINT SALARY;
PRINT BONUS;


/*
    * ���ν��� ����
    1. ó���ӵ��� ������.
    2. �뷮 �ڷ�ó���� ������.
    EX) DB���� ��뷮�� �����͸� SELECT������ �޾ƿ� �� �ڹٿ��� ó���ϴ� ��� VS
        DB���� ��뷮�� �����͸� SELECT�� �� �ڹٷ� �ѱ��� �ʰ� ���� DB���� ó���ϴ� ���
    DB���� ó���ϴ� ���� ������ ����(�����͸� �ѱ涧���� ��Ʈ��ũ ��� �߻�)
    
    
    * ���ν��� ����
    1. DB�ڿ��� ���� ����ϱ� ������ DB�� ���ϸ� �ְԵȴ�.
    2. ������ ���鿡�� �ڹټҽ��ڵ�, ����Ŭ �ڵ带 ���ÿ� ��������ϱ� ��ƴ�.
    
    
    ����)
    �� ���� ó���Ǵ� �����ͷ��� ���� ������ �䱸�ϴ� ó���� DB�󿡼� ó���ϴ� ���� ����
    �ҽ����� ���鿡���� �ڹٷθ� �����ϴ� ���� ����.
*/


-----------------------------------------------------------------------

/*
    <FUNCTION>
    ���ν����� ���������� ���ο� PL/SQL�� �ۼ��� �� �ְ�
    �������� ��ȯ ���� �� ����.
    
    
    * FUNCTION �������
    [ǥ����]
    CREATE FUNCTION ��Ǹ� [(�Ű�����)]
    RETUEN �ڷ���
    IS
    BEGIN
        ����κ�
    END;    

*/

CREATE FUNCTION MYFUNC(V_STR VARCHAR2)
RETURN VARCHAR2
IS
    RESULT VARCHAR2(1000);
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_STR);
    RESULT := V_STR || '!!!!!';
    
    RETURN RESULT;
END;
/

SELECT MYFUNC('�浿') FROM DUAL;



-- ����� ����� ���޹޾Ƽ� ������ ����ؼ� ��ȯ���ִ� �Լ� �����,.
CREATE OR REPLACE FUNCTION CALC_SALARY(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS
    E EMPLOYEE%ROWTYPE;
    RESULT NUMBER;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    RESULT := (E.SALARY + (E.SALARY* NVL(E.BONUS,0))) *12 ;
    RETURN RESULT;
END;
/

SELECT EMP_ID, CALC_SALARY(EMP_ID)
FROM EMPLOYEE;








