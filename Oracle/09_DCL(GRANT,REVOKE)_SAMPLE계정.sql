-- 3_1. CREATE TABLE ���� �ο��ޱ� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
    );    
-- ������� ���� : SAMPLE ������ ���̺� ���� ������ �ο����� �ʾƼ� �����߻���


-- 3_2) CREATE TABLE ���� �ο����� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
    );  
    
-- SAMPLE ������ TABLESPACE�� ���� �Ҵ���� �ʾƼ� ���� �߻�


-- TABLESPACE �Ҵ� ���� ��..
CREATE TABLE TEST(
    TEST_ID NUMBER
    ); -- ���̺� �����Ϸ�
    
INSERT INTO TEST VALUES(1);
-- ���̺� ���� ������ �ο������� ���� ������ �����ϰ� �ִ� ���̺�� ����(DML)�� ��������



-- 4. �� ������ 
-- ���Ѻο� �ޱ� ��
CREATE VIEW V_TEST
AS SELECT * FROM TEST;


-- ���Ѻο� ���� ��
CREATE VIEW V_TEST
AS SELECT * FROM TEST;



-- 5. SAMPLE�������� KH������ ���̺� �����ؼ� ��ȸ�غ���
SELECT *
FROM KH.DEPARTMENT; --��ȸ������ ���� �ʾ����Ƿ� ���ٺҰ�, �����߻���

SELECT *
FROM KH.EMPLOYEE;   --��ȸ������ �޾����Ƿ� ��ȸ������



-- 6. SAMPLE �������� KH������ ���̺� �����ؼ� �� �����ϱ�
--          KH�� DEPARTMENT���̺� ȸ��� �μ� �߰�
INSERT INTO KH.DEPARTMENT VALUES('D0', 'ȸ���', 'L2');
-- ���ѹ��� �ʾ����Ƿ� �����߻���


--------------------------------------------------------------------



-- 7. ���̺�����ϱ�
CREATE TABLE TEST2 (
    NUM NUMBER
    );
-- ���̺� �������� ȸ���� ���� ���� ����� �����߻�










