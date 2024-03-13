/*
    <�Լ� Function>
    �ڹ��� �޼��� ���� ����
    �Ű������� ���޵� ������ �о ����� ����� ��ȯ -> ȣ���ؼ� �� ��
    
    -������ �Լ� : n���� ���� �о n���� ����� ����(�� �ึ�� �Լ��� �����ϰ� ����� ��ȯ)
    - �׷� �Լ� : n���� ���� �о �׷��� ������ŭ ����� ����(*�ϳ��� �׷캰�� �Լ� ������ ��ȯ)
    
    ������ �Լ��� �׷��Լ��� �԰� ����� �� ����. : ������� ������ �ٸ��� ������
*/


--------------------- <������ �Լ�> ----------------------
/*
    <���ڿ��� ���õ� �Լ�>
    LENGTH / LENGTHB
    
    - LENGTH(���ڿ�) : �ش� ���޵� ���ڿ��� ���� �� ��ȯ
    - LENGTHB(���ڿ�) : ���޵� ���ڿ��� ����Ʈ �� ��ȯ
    
    ��� ���� ���ڷ� ��ȯ -> NUMBER
    ���ڿ� : ���ڿ� ������ ���ͷ��̳� ���ڿ��� ����� Į���� ����
*/

SELECT LENGTH('����Ŭ!'), LENGTHB('����Ŭ!')
FROM DUAL;
-- �������̺� : ��������̳� ���� Į���� ���� �׽�Ʈ Ȥ�� ����ϱ� ���� �뵵�� ����ϴ� ���̺�


/*
    <INSTR>
    - INSTR(���ڿ�, Ư������, ã�� ��ġ�� ���۰�, ����) : ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ
                ã�� ��ġ�� ���۰�, ������ ���� ����
            ã�� ��ġ�� ���۰� : (1 / -1)
              1 : �տ��� ���� ã�ڴ�(�⺻��)
             -1 : �ڿ������� ã�ڴ�.
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;    -- �Ű����� ������ �⺻��
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- (==) �Ű����� 1�� �⺻��
-- 3 : �տ������� ù��°�� ��ġ�ϴ� B�� ��ġ�� AA"B"AACAABBAA

SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
-- 10 : �ڿ������� ù��°�� ��ġ�ϴ� B�� ���� �տ������� ���� ��ȯ AABAACAAB"B"AA

SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;
-- 9 :  B�� �ڿ������� �ι�°�� ��ġ�ϴ� ���� �տ������� ���� ��ȯ AABAACAA"B"BAA
 
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; 
-- 9 : B�� �տ��� �ι�°�� ��ġ�ϴ� ���� ��ȯ AABAACAA"B"BAA

SELECT INSTR('AABAACAABBAA', 'B', -1, 0) FROM DUAL;
-- ������ ��� ������ ���ý� ���� �߻���. 1���� �����ϱ� ������ 0���� ����.

-- �ε���ó�� ������ ��ġ�� ã�� ���� ������
-- �ڹ�ó�� 0���� ���� ���� �ƴ϶� 1���� �����Ѵ�.


-- EMPLOYEE ���̺��� �̸��Ͽ��� @�� ��ġ�� ã�ƺ���
SELECT INSTR(EMAIL, '@' ) AS "@�� ��ġ" 
FROM EMPLOYEE;


------------------------------------------------------
/*
    <SUBSTR>
    ���ڿ��κ��� Ư�� ���ڿ��� �����ϴ� �Լ�
    - SUBSTR(���ڿ�, ó����ġ, ������ ���ڰ���)
    
    ������� CHARACTER Ÿ������ ��ȯ(���ڿ�)
    ������ ���� ������ ��������(������ ���ڿ� ������ ����)
    ó�� ��ġ�� ������ ���� ���� : �ڿ��� ���� N��° ��ġ�������� ���ڸ� �����Ѵٴ� ��
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7 ) FROM DUAL;
-- SHOWME"THEMONEY" // 7��°���� ���

SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
-- SHOW"ME"THEMONEY // 5������ 2��

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6 ) FROM DUAL;
-- "SHOWME"THEMONEY // 1������ 6��

SELECT SUBSTR('SHOWMETHEMONEY', -8, 3 ) FROM DUAL;
-- SHOWME"THE"MONEY // 8������ �������� 3��


-- �ֹε�Ϲ�ȣ���� ���� �κ��� �����ؼ� ����/���ڸ� üũ
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1 ) AS ����
FROM EMPLOYEE;

-- �� ����� �̸��Ͽ��� ID�κи� �����ؼ� ��ȸ(����̸�, �̸���, �����ID)
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1 ) AS ID
FROM EMPLOYEE;

-- EMPLOYEE ���� ���� ����鸸 ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1 ) IN ('1', '3');  -- (==) IN(1, 3) -> �ڵ�����ȯ
-- �ֹι�ȣ 8��° 1���� '1' �Ǵ� '3'�� �ǹ�


/*
    LPAD / RPAD
    - LPAD/RPAD(���ڿ�, ���������� ��ȯ�� ������ ����. �����̰��� �ϴ� ����)
    : ������ ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� 
      ���� N���̸�ŭ�� ���ڿ��� ��ȯ
      
      ������� CHARACTER Ÿ������ ��ȯ
      �����̰��� �ϴ� ���ڴ� ��������(�⺻�� ' ')
*/

SELECT LPAD(EMAIL, 16), EMAIL
FROM EMPLOYEE;
-- �����̰��� �ϴ� ���� ������ ' '�⺻���� �������� �� �� ����

SELECT RPAD(EMAIL, 20, '#'), EMAIL
FROM EMPLOYEE;

-- �ֹε�Ϲ�ȣ ��ȸ : 621205-1234567 => 621205-1******
--9�������� ��� *�� ����.. 
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8)
FROM EMPLOYEE;


SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*' ) AS �ֹι�ȣ
FROM EMPLOYEE;

/*
    LTRIM/RTRIM(���ڿ�, ���Ž�Ű���� �ϴ� ����)
    : ���ڿ��� ���� �Ǵ� �����ʿ��� ���Ž�Ű���� �ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ

*/

SELECT LTRIM('    K     H    ') FROM DUAL;  
-- �⺻������ ������ ����' '�� �������ش�

SELECT RTRIM('    K     H    ') FROM DUAL;  
-- �⺻������ �������� ����' '�� �������ش�

SELECT LTRIM('123123KH123', '123') FROM DUAL;
-- 123123"KH123" // �Ǿ��� 123123�� ����

SELECT RTRIM('000012300456000', '0') FROM DUAL;
-- "000012300456"000  // �ǳ��� 0�� ����

SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
-- ACABACC"KH"  // ���� �������� ���� ���ڸ� ������ ������ ��������
-- ���Ž�Ű���� �ϴ� ���ڿ��� ������ �����ϴ� ���� �ƴ϶�
-- ���� �ϳ��ϳ��� �� �����ϸ� �������ִ� ����


/*
    - TRIM(BOTH/LEADING/TRAILING '�����ϰ��� �ϴ� ����' FORM '���ڿ�')
    : ���ڿ��� ����/����/���ʿ� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ��� ��ȯ
    
    ������� CHARACTER Ÿ������ ��ȯ
    BOTH/LEADING/TRAILING : ��������, ������ �⺻�� BOTH
*/

SELECT TRIM('           K    H       ') FROM DUAL;
-- "K    H"  ���� ���� ����

SELECT TRIM('Z' FROM 'ZZZZKZZHZZ') FROM DUAL;
-- ZZZZ"KZZH"ZZ     

--SELECT TRIM('ZZZZKZZHZZ', 'Z') FROM DUAL;
-- �����߻� / �Ű����� ���ù���� �ùٸ��� �ʴ�

SELECT TRIM(BOTH 'Z' FROM 'ZZZZKZZHZZ') FROM DUAL;
-- ZZZZ"KZZH"ZZ  // BOTH �� �⺻��(��, ��)

SELECT TRIM(LEADING 'Z' FROM 'ZZZZKZZHZZ') FROM DUAL;
-- ZZZZ"KZZHZZ"  // ���ʸ� ���ŵ�

SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKZZHZZ') FROM DUAL;
-- "ZZZZKZZH"ZZ  // ���ʸ� ���ŵ�


/*
    LOWER/UPPER/INITCAP
    - LOWER(���ڿ�) : ���ڿ��� ���� �ҹ��ڷ� ����
    
    - UPPER(���ڿ�) : ���ڿ��� ���� �빮�ڷ� ����
    
    - INITCAP(���ڿ�) : ���ڿ��� ���� �� �ܾ��� �ձ��ڸ� �빮�ڷ� ����
*/

SELECT LOWER('Welcome to D class'), UPPER('Welcome to D class'), INITCAP('Welcome to D class')
FROM DUAL;


/*
    CONCAT 
    
    - CONCAT(���ڿ�1, ���ڿ�2) : ���޵� ���ڿ� �ΰ��� �ϳ��� ���ڿ��� ���ļ� ��ȯ
*/

SELECT CONCAT('������', '�󸶹ٻ��')
FROM DUAL;

SELECT '������' || '�󸶹�' || 1234
FROM DUAL;

SELECT CONCAT('������', 123, 'ABC')
FROM DUAL;
-- �Ű������� ���� �ΰ��� ���ڿ��� �����ϴ�


/*
    REPLACE
    
    - REPLACE(���ڿ�, ã������, �ٲܹ���) : ���ڿ��κ��� ã�����ڸ� ã�Ƽ� �ٲܹ��ڷ� �ٲ� ���ڿ��� ��ȯ
*/

SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��')
FROM DUAL;

-- �� ����� �̸��� �ּҸ� kh.or.kr���� iei.or.kr�� ����� ���ڿ� ����ϱ�
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'iei.or.kr')
FROM EMPLOYEE;



----------------------------------------------------------
/*
    <���ڿ� ���õ� �Լ�>
    
    ABS
    - ABS(���밪�� ���� ����) : ���밪�� �����ִ� �Լ� (ABSOLUTE)
    
    ������� NUMBER ���·� ��ȯ
*/

SELECT ABS(-10)
FROM DUAL;

SELECT ABS(-10.9)
FROM DUAL;


/*
    MOD
    - MOD(����, ������) : �� ���� ���� ���������� ��ȯ
*/

SELECT MOD(10, 3)
FROM DUAL;

SELECT MOD(-10, 3)
FROM DUAL;

SELECT MOD(10.9, 3)
FROM DUAL;



/*
    ROUND
    - ROUNG(�ݿø��ϰ����ϴ¼�, �ݿø���ġ) : �ݿø�ó�����ִ� �Լ�
    
    �ݿø���ġ : �Ҽ��� �������� �Ʒ� N��° ������ �ݿø��Ѵ�.(������ �⺻���� 0)
*/

SELECT ROUND(123.456) 
FROM DUAL;  -- 123

SELECT ROUND(123.456, 1) 
FROM DUAL;  -- 123.5

SELECT ROUND(123.456, 2) 
FROM DUAL;  -- 123.46


/*
    CEIL
    - CEIL(�ø�ó���� ����) : �Ҽ��� �Ʒ��� ���� �ø�ó�����ִ� �Լ�
*/

SELECT CEIL(123.456) 
FROM DUAL;  -- 124


/*
    FLOOR
    - FLOOR(����ó���ϰ����ϴ¼���) : �Ҽ��� �Ʒ��� ���� ������ ����ó�����ִ� �Լ�
*/

SELECT FLOOR(123.999) 
FROM DUAL;  -- 123

-- �� �������� �ٹ��ϼ� ���ϱ�(���ó�¥-����� = �Ҽ���)

SELECT EMP_NAME, SYSDATE-HIRE_DATE, FLOOR(SYSDATE-HIRE_DATE) || '��' AS �ٹ��ϼ�
FROM EMPLOYEE;


/*
    TRUNC
    - TRUNC(����ó���Ҽ���, ��ġ) : ��ġ ������ ������ ����ó�� �Լ�
*/

SELECT TRUNC(123.786) FROM DUAL;    -- ��ġ�� ������ �⺻���� 0
SELECT TRUNC(123.786, 1) FROM DUAL;  -- 123.7
SELECT TRUNC(123.786, 2) FROM DUAL;  -- 123.78
SELECT TRUNC(123.786, -1) FROM DUAL; -- 120
SELECT TRUNC(123.786, -2) FROM DUAL; -- 100


-----------------------------------------------------------------
/*
    <��¥ ���� �Լ�>
    DateŸ�� : �⵵, ��, ��, ��, ��, �ʸ� �� ������ �ڷ���
*/

SELECT SYSDATE FROM DUAL;

-- 1. MONTHS_BETWEEN(DATE1, DATE2) : �� ��¥������ ������ ��ȯ(������� NUMBER)
--      DATE2�� �� �̷��� ��� ������ ����.

-- �� ������ �ٹ��ϼ�, �ٹ������� ��ȸ
SELECT EMP_NAME, 
        FLOOR(SYSDATE-HIRE_DATE) || '��' �ٹ��ϼ�
FROM EMPLOYEE;

SELECT EMP_NAME, 
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE )) || '����' �ٹ�������
FROM EMPLOYEE;

SELECT EMP_NAME, 
        FLOOR(SYSDATE-HIRE_DATE) || '��' �ٹ��ϼ�,
        FLOOR(ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE ))) || '����' �ٹ�������
FROM EMPLOYEE;



-- 2. 
-- ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ �������� ���� ��¥�� ��ȯ(������� DATEŸ��)
-- ���ó�¥���� 5���� ���� ��ȸ
SELECT ADD_MONTHS(SYSDATE, 5)
FROM DUAL;

-- ��ü ������� 1�� �ټ���(==�Ի��� ���� 1�ֳ�)
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 12)
FROM EMPLOYEE;


-- 3. NEXT_DAY(DATE, ����(����/����)) : ��¥���� ���� ����� ������ ã�� �� ��¥�� ��ȯ(������� DATE)
-- 1:�Ͽ���, 2:������, 3:ȭ���� ... 7:�����
SELECT NEXT_DAY(SYSDATE, 1)
FROM DUAL;

SELECT NEXT_DAY(SYSDATE, '��')
FROM DUAL;

SELECT NEXT_DAY(SYSDATE, 'SATURDAY')
FROM DUAL;
-- ���� ��ǻ�� ���þ� KOREAN�̱� ������ ����� �߰��� ���� �߻���

-- ���� ���� ���
-- DDL(������ ���� ���) : CREATE, ALTER, DROP
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;



-- 5. 
/*
    EXTRACT : �⵵ �Ǵ� �� �Ǵ� �� ������ �����ؼ� NUMBER�ڷ������� ��ȯ
    
    - EXTRACT(YEAR FROM ��¥) : Ư�� ��¥�κ��� �⵵�� ����
    - EXTRACT(MONTH FROM ��¥) : Ư�� ��¥�κ��� ���� ����
    - EXTRACT(DAY FROM ��¥) : Ư�� ��¥�κ��� �ϸ� ����
*/

SELECT EXTRACT(YEAR FROM SYSDATE),
       EXTRACT(MONTH FROM SYSDATE),
       EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

------------- ���ڿ�, ����, ��¥�� ���õ� �Լ���... �� ---------------------------

/*
    <����ȯ �Լ�>
    NUMBER/DATE => CHARACTER
    
    - TO_CHAR(NUMBER/DATE, ����)
    : ������ �Ǵ� ��¥�� �����͸� ������ Ÿ������ ���˿� ���� ��ȯ�ؼ� ��ȯ
*/

-- ���ڸ� ���ڿ���
SELECT TO_CHAR(1234)
FROM DUAL;  -- 1234 -> '1234'

SELECT TO_CHAR(1234,'00000000')
FROM DUAL;  -- 1234 -> '00001234' ��ĭ�� �ִٸ� 0���� ä��

SELECT TO_CHAR(1234, '99999')
FROM DUAL;  -- 1234 -> ' 1234' ��ĭ�� ' '�� ä��

SELECT TO_CHAR(1234, 'L00000')
FROM DUAL;  -- 1234 -> '��01234' L:LOCAL => ���� ������ ������ ȭ����� ǥ��

SELECT TO_CHAR(1234, 'L99,000')
FROM DUAL;  -- 1234 -> '��1,234'

-- �޿������� 3�ڸ����� ','�� ��� Ȯ���ϱ�
SELECT EMP_NAME, TO_CHAR(SALARY, '999,999,999') AS �޿�
FROM EMPLOYEE;   -- '  8,000,000'


-- ��¥�� ���ڿ���
SELECT SYSDATE
FROM DUAL;

SELECT TO_CHAR(SYSDATE)
FROM DUAL;

-- 2023-11-24
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;

SELECT EXTRACT(YEAR FROM SYSDATE) || '-' || EXTRACT(MONTH FROM SYSDATE) "YYYY-MM"
FROM DUAL;

-- �� �� �� : ����(AM)/����(PM)
-- EX) ���� 00:00:00
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY')
FROM DUAL;  -- 11�� ��, 2023 : MON�� ��'��' ����, DY�� ������ �˷��ֵ� �������� �˷����� ����

SELECT TO_CHAR(SYSDATE, 'DAY')
FROM DUAL; 


-- �⵵�ν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL; 
-- YY�� RR�� ������
-- R : ROUND�� ����
-- YY : �⵵�� �� ���ڸ��� ������ 20�� ����
-- RR : 50�� �������� ������ 20, ũ�� 19 -> 89 : 1989


-- ���ν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL; 
-- RM : �θ����ڷ� ��ȯ



-- �Ϸν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'D'),
       TO_CHAR(SYSDATE, 'DD'),
       TO_CHAR(SYSDATE, 'DDD')
FROM DUAL; 
-- D : ������ �������� �Ͽ��Ϻ��� ������ ��ĥ°���� �˷��ִ� ����
--        ��:1, ��:2, ȭ:3 ...
-- DD : 1�� �������� 1�Ϻ��� ��ĥ°���� �˷��ִ� ����
-- DDD : 1�� �������� 1�� 1�Ϻ��� ��ĥ°���� �˷��ִ� ����


-- ���Ϸν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'DY'),
       TO_CHAR(SYSDATE, 'DAY')
FROM DUAL; 

-- 2023�� 11�� 24�� (��) �������� �����Ű��
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" (DY) ')
FROM DUAL; 


-- �����, �Ի���(���� ������ ����)
-- 2010�� ���Ŀ� �Ի��� ����鸸 ���ϱ�
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" (DY) ')
FROM EMPLOYEE
--WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2010;
WHERE HIRE_DATE >= '10/01/01';  -- �ڵ�����ȯ


/*
    NUMBER/CHARCATER => DATE
    - TO_DATE(NUMBER/CHARACTER, ����) : ����/������ �����͸� ��¥������ ��ȯ
    (������� DATEŸ��)
*/

SELECT TO_DATE(20231124)
FROM DUAL;  -- �⺻���� YY/MM/DD�� ��ȯ

SELECT TO_DATE('20231124')
FROM DUAL;  

-- 20000101�� NUMBER������ DATE�ڷ������� ��ȯ�ϰ��� �Ѵٸ�?
SELECT TO_DATE(000101)    -- 000101 => 101 : NUMBER�ڷ������� ���� 0���� �����ϸ� ���δ� �����ȴ�.
FROM DUAL;  -- 101�̶� DATE�� �ƴ϶� �����߻�

SELECT TO_DATE('000101')    -- 000101 => 00/01/01 : 0���ν����ϴ� �⵵�� �ݵ�� ''���ڿ��� �ٷ�� ��
FROM DUAL; 

SELECT TO_DATE(20000101)    -- 00/01/01
FROM DUAL; 

SELECT TO_DATE('20100101', 'YYYYMMDD')   
FROM DUAL; 

SELECT TO_DATE('231124 183000', 'YYMMDD HH24MISS')   
FROM DUAL; 

SELECT TO_DATE('140630', 'YYMMDD')   
FROM DUAL; 

SELECT TO_DATE('980630', 'YYMMDD')   
FROM DUAL;  -- 2098�⵵
-- TO_DATE() �� �̿��ؼ� DATE�������� ��ȯ��
-- ���ڸ� �⵵�� ���� YY������ �����ų ��� ������ ���ڸ��� 20�⵵�� �߰��ȴ�

SELECT TO_DATE('140630', 'RRMMDD')   
FROM DUAL; 

SELECT TO_DATE('980630', 'RRMMDD')   
FROM DUAL;  -- 1998�⵵

-- ���ڸ� �⵵�� ���� RR������ �����ų ��� 
-- 50�̻��̸� ����(19)
-- 50�̸��̸� ���缼��(20)�� �߰���



/*
    CHARACTER => NUMBER
    - TO_NUMBER(CHARACTER, ����) : ���ڿ� �����͸� ���ڷ� ��ȯ
*/
SELECT '123'+'456'  
FROM DUAL;  -- 579 : �ڵ�����ȯ ���� ������� ����

SELECT '10,000,000'+'550,000'
FROM DUAL;  -- ��������. ����(,)�� ���ԵǾ� �ֱ� ������ �ڵ�����ȯ�� �ȵ�

SELECT TO_NUMBER('10,000,000', '99,999,999')+TO_NUMBER('550,000', '999,999')
FROM DUAL; -- 10550000

SELECT TO_NUMBER('0123')
FROM DUAL;



-- ���ڿ�, ����, ��¥ ����ȯ �Լ���(TO_CHAR, TO_NUMBER, TO_DATE)
----------------------------------------------------------------------

/*
    <NULL ó�� �Լ�>
    - NVL(Į����, �ش�Į������ NULL�� ��� ��ȯ�� ��ȯ��)
    - �ش� Į������ ������ ���(NULL�� �ƴ� ���) ������ Į������ ��ȯ
    - �ش� Į������ �������� ���� ���(NULL�� ���) ���� ������ Ư������ ��ȯ
*/

-- �����, ���ʽ�, ���ʽ��� ���� ��� 0���� ���
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- ���ʽ��� ���Ե� ����
SELECT EMP_NAME, (SALARY + SALARY*BONUS)*12 AS "���ʽ����� ����"
FROM EMPLOYEE;

SELECT EMP_NAME, (SALARY + (SALARY* NVL(BONUS, 0)))*12 AS "���ʽ����� ����"
FROM EMPLOYEE;


-- NVL2(Į����, �����1, �����2)
-- Į������ NULL�� ��� : �����2 ��ȯ
-- Į������ NULL�� �ƴ� ��� : ����� 1 ��ȯ

-- ����� �߿� ���ʽ��� �ִ� ����� "���ʽ��� ����" , ���� ����� "���ʽ��� ����" ��ȯ
SELECT EMP_NAME, BONUS, NVL2(BONUS, '���ʽ� ����', '���ʽ� ����') AS ���ʽ�����
FROM EMPLOYEE;


-- NULLIF(�񱳴��1, �񱳴��2) : �����
-- �� ���� ������ ��� : NULL ��ȯ
-- �� ���� �ٸ� ��� : �񱳴��1����ȯ
SELECT NULLIF(123,123)
FROM DUAL;

SELECT NULLIF(123,456)
FROM DUAL;



-- �����Լ� : DECODE -> SWITCH��
-- �����Լ� ģ�� : CASE WHEN THEN ���� -> IF��

/*
    <�����Լ�>
    
    - DECODE(�񱳴��, ���ǰ�1, �����1, ���ǰ�2, �����2, ���ǰ�3, �����3, ...,���ǰ�N, �����N, �����)
    �ڹ��� SWITCH���� ������
    �񱳴�󿡴� Į��, �������, �Լ��� �� �� �ִ�.
*/

-- ���, �����, �ֹι�ȣ, �ֹε�Ϲ�ȣ�κ��� ������ �����ؼ� 1�̸� ����, 2�� ����
SELECT EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '����', 2, '����', '����' )
FROM EMPLOYEE;

-- �������� �޿��� �λ���Ѽ� ��ȸ
-- �����ڵ尡 'J7'�� ����� �޿��� 10%�λ�
-- �����ڵ尡 'J6'�� ����� �޿��� 15%�λ�
-- �����ڵ尡 'J5'�� ����� �޿��� 20%�λ�
-- �� �� �����ڵ��� ����� �޿��� 5%�λ�
-- �����, �����ڵ�, ������ �޿�, ������ �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY, 
       DECODE(JOB_CODE, 'J7', SALARY*1.1, 'J6', SALARY*1.15, 'J5', SALARY*1.2, SALARY*1.05) AS"���� �� �޿�"
FROM EMPLOYEE;


/*
    CASE WHEN THEN ����
    -DECODE �����Լ��� ���Ѵٸ� DECODE�� �ش� ���ǰ˻�� ����񱳸��� ����
    CASE WHEN THEN ������ ��� Ư�� ������ �� ������� ���� ����
    
    [ǥ����]
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         WHEN ���ǽ�N THEN �����N
         ELSE �����
    END
    
    - �ڹ��� if~else if���� ������
*/

-- ���, �����, �ֹι�ȣ, �����ڸ����� ���� ����, ���� ����
SELECT EMP_ID, EMP_NAME, EMP_NO, CASE WHEN SUBSTR(EMP_NO, 8, 1) IN(1,3) THEN '����'
        ELSE '����'
        END ����
FROM EMPLOYEE;


SELECT EMP_NAME, JOB_CODE, SALARY, 
       CASE WHEN JOB_CODE = 'J7' THEN (SALARY*1.1) 
            WHEN JOB_CODE = 'J6' THEN (SALARY*1.15)
            WHEN JOB_CODE = 'J5' THEN (SALARY*1.2)
       ELSE (SALARY*1.05)
       END �λ��ı޿�
FROM EMPLOYEE;

-- �����, �޿�, �޿����(SAL_LEVELĮ�� ���X)
-- SALARY���� 500���� �ʰ��� ��� '���'
--            500���� ���� 350���� �ʰ��� ��� '�߱�'
--            350���� ������ ��� '�ʱ�'
--            �޿����
-- CASE WHEN THEN �������� �ۼ��غ���

SELECT EMP_NAME, SALARY, 
      CASE WHEN SALARY > '5000000' THEN '���'
           WHEN SALARY > '3500000' THEN '�߱�'
           ELSE '�ʱ�'
      END �޿����
FROM EMPLOYEE;




----------------- <�׷� �Լ�> -----------------
-- �׷��Լ� : �����͵��� ��(SUM), ���(AVG), ...
-- N���� ���� �о �׷캰�� ����� ��ȯ(�ϳ��� �׷캰�� �Լ� ���� �� ��� ��ȯ)

-- 1. SUM(����Ÿ��Į��) : Į�������� �� �հ踦 ��ȯ���ִ� �Լ�
-- ��ü ������� �� �޿� �հ�
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- �μ��ڵ尡 D5�� ������� �� �޿� �հ�
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- ���� ������� �� �޿� �հ�
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;


-- 2. AVG(����Ÿ��Į��) : �ش� Į�������� ����� ���ؼ� ��ȯ
-- ������� �޿� ���
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;


-- 3. MIN(ANYŸ�� Į��) : �ش� Į������ �߿��� ���� ���� ���� ��ȯ
-- ��ü ����� �� �����޿�, ���� �����̸�, �������� �̸��ϰ�, ���� ���ſ� �Ի��� ��¥
SELECT MIN(SALARY), SALARY
FROM EMPLOYEE;
-- ��ȯ����� �ϴ� ������� ������ �ٸ��� ������ �����߻���

SELECT MIN(SALARY), MIN(EMP_NAME), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;


-- 4. MAX(ANYŸ�� Į��) : �ش� Į������ �߿��� ���� ū ���� ��ȯ

SELECT MAX(SALARY), MAX(EMP_NAME), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;


-- 5. COUNT(*/Į����/DISTINCT Į����) : ��ȸ�� ���� ������ ���� ��ȯ
--      COUNT(*) : ��ȸ ����� �ش��ϴ� ��� ���� ������ �� ���� ��ȯ(�⺻��)
--      COUNT(Į����) : ������ Į������ "NULL"�� �ƴ� �͸� ���� ������ ��ȯ
--      COUNT(DISTINCT Į����) : ������ Į������ �ߺ����� ���� ��� �ϳ��θ� ������ ���� ��ȯ, NULL�� ����X

-- ��ü�����
SELECT COUNT(*)
FROM EMPLOYEE;

-- ���� �����
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

-- �μ���ġ�� �Ϸ�� ����� ��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

SELECT COUNT(DEPT_CODE) -- ���� ������(==)
FROM EMPLOYEE;      -- NULL�� �ƴ� �͸� COUNT��

-- �μ���ġ�� �Ϸ�� ���� ��� ��
SELECT COUNT(DEPT_CODE) 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

-- ���� ������� ���� �μ��� ����
SELECT COUNT(DISTINCT DEPT_CODE) 
FROM EMPLOYEE;  -- NULL�� ���� �ߺ����� 1���� COUNT��.

-- ���� ����� ��
SELECT COUNT( DECODE(SUBSTR(EMP_NO, 8, 1), 2, 1, NULL ) )
FROM EMPLOYEE;
-- �Ű������� NULL���� �� ��� ������ COUNT���� �ʴ´�



-------------------- �ǽ����� ---------------------
-- EMPLOYEE ���̺��� ������, �μ��ڵ�, �������, ���� ��ȸ
-- ��, ��������� �ֹι�ȣ���� �����ؼ� 00�� 00�� 00�Ϸ� ��µǰ� �ϸ�
-- ���̴� �ֹι�ȣ���� �����Ͽ� ��¥ �����ͷ� ��ȯ�� ���� ����Ͻÿ�

-- ������� ���� 1)
SELECT EMP_NAME, DEPT_CODE, EMP_NO, 
        SUBSTR(EMP_NO, 1, 2) || '��' || SUBSTR(EMP_NO, 3, 2) || '��' || SUBSTR(EMP_NO, 5, 2) || '��'  �������
FROM EMPLOYEE;

-- ������� ���� 2)
SELECT EMP_NAME, DEPT_CODE, EMP_NO, 
        TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 6), 'YYMMDD'), 'YY"��" MM"��" DD"��"')
FROM EMPLOYEE;

-- ���̸� �����Ͽ� ��¥ �����ͷ� ��ȯ
SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RRRR')) ����
FROM EMPLOYEE;


-- �ΰ��� ��ġ��
SELECT EMP_NAME, DEPT_CODE, EMP_NO, 
        TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 6), 'YYMMDD'), 'YY"��" MM"��" DD"��"') �������,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RRRR')) ����
FROM EMPLOYEE;





