/*
    * DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    
    ����Ŭ���� �����ϴ� ��ü��
    ������ �����(CREATE), ������ �����ϰ�(ALTER), ���� ��ü�� ����(DROP)�ϴ� ��ɹ�
    ��, ���� ��ü�� �����ϴ� ���� DB�����ڳ� �����ڰ� �ַ� �����  
*/

/*
    <CREATE TABLE>
    ���̺� : ��(ROW), ��(COLUMN)�� �����Ǵ� ���� �⺻���� DB��ü ������ �ϳ�
    ��� �����ʹ� ���̺��� ���ؼ� �����(�����͸� �����ϰ��� �Ѵٸ� ���̺� �����ؾ� ��)
    
    [ǥ����]
    CREATE TABLE ���̺��(
    Į���� �ڷ���,
    Į���� �ڷ���,
    Į���� �ڷ���,
    ...
    )
    
    <�ڷ���>
    - ����(CHAR(ũ��)/VARCHAR2(ũ��)) : ũ��� BYTE
                                    (����,����,Ư�� 1BYTE, �ѱ� 3BYTE)
        - CHAR(����Ʈ��) : �ִ� 2000BYTE���� ��������
                        ��������
                        �ַ� ���� ���� ���ڼ��� ������ �ִ� ��� ����Ѵ�
                        EX)���� : ��/��, M/F, �ֹε�Ϲ�ȣ ��..
        - VARCHAR2(����Ʈ��) : �ִ� 4000BYTE���� ��������
                            ��������
                            VAR�� '����', 2�� 2�踦 �ǹ�
                            �ַ� ���� ���� ���ڼ��� �������� ���� ��� ���
                            EX)�̸�, ���̵�, ��й�ȣ ...
        - VARCHAR2(CHAR) : ���ڴ����� ũ�� ������ ����
    
    - ����(NUMBER) : ����/�Ǽ� ������� NUMBER
    - ��¥(DATE) : ����Ͻú��� �������� �ð� ����
    - LOB 
            CLOB : �������� ����(�ִ� 4GB)
            BLOB : BINARY DATA
         
*/

-- ȸ������ �����͸� ��� ���� MEMBER���̺� ����
-- ���̵�, ��й�ȣ, �̸�, �������
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_BDATE DATE
);

-- TABLE Ȯ�ι��1
SELECT * FROM MEMBER;

-- TABLE Ȯ�ι��2
-- ������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�

SELECT * 
FROM USER_TABLES;
-- -> ���� DDL����� ������ ������ �ִ� ���̺���� �������� ������ Ȯ���� �� �ִ�
-- �ý��� ���̺�


-- Į���� Ȯ�ι�
SELECT * 
FROM USER_TAB_COLUMNS;
-- Į�������� Ȯ���� �� �ִ� �ý��� ���̺�



/*
    Į���� �ּ� �ޱ�
    
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';

*/

COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.MEMBER_BDATE IS '�������';



-- INSERT(DML��)
-- ������ �߰��ÿ��� �������� �߰�, �߰��� ���� ���

-- INSERT INTO ���̺�� VALUES(ù��° Į���ǰ�, �ι�° Į���ǰ�,...)

INSERT INTO MEMBER VALUES('user01', 'pass01', 'ȫ�浿', '1980/05/10');
INSERT INTO MEMBER VALUES('user02', 'pass02', '�谩��', '1999/05/10');
INSERT INTO MEMBER VALUES('user03', 'pass03', '�ڸ���', SYSDATE);


INSERT INTO MEMBER VALUES(NULL, NULL, NULL, SYSDATE);
-- ���̵�, ���, �̸��� NULL���� �����ص� �Ǵ°�? ���� �ƴ�

INSERT INTO MEMBER VALUES('user03', 'pass03', '�ڸ���', SYSDATE);
-- �ߺ��� ���̵� �����ص� �Ǵ°�? ���� �ƴ�

-- ���� NULL�����̳� �ߺ��� ���̵��� ��ȿ�� �����Ͱ� �ƴ�
-- ��ȿ�� �����Ͱ��� �����ϱ� ���ؼ��� "��������"�� �ɾ�� �Ѵ�.
-- ������ ���Ἲ ������ �����ϴ�

SELECT * FROM MEMBER;


/*
    <���� ���� CONSTRAINTS>
    - Ư�� Į���� ���� ���ϴ� �����Ͱ��� �����ϱ� ���ؼ� �� Į������ �����Ѵ�
    
    - ���� ������ �ο��� Į���� ���� �����Ϳ� ������ �ִ��� ������ �ڵ����� �˻��� ����
    
    - ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
    - Į���� ���������� �ο��ϴ� ��� : Į��������� / ���̺������
    
    1. NOT NULL ��������
        �ش� Į���� �ݵ�� ���� �����ؾ߸� �� ��� ���
        => NULL���� ���� ���ͼ��� �ȵǴ� Į���� �ο��ϴ� ��������
            ����/������ NULL���� ������� �ʵ��� �����ϴ� ��������
            
        ������ : Į������������θ� ���� ����
        
*/

-- NOT NULL ���������� �߰��� ���̺� �����
-- Į������������� �ο� : Į���� �ڷ��� �������� 
--              => ���������� �ο��ϰ��� �ϴ� Į�� �ٷεڿ� ���


CREATE TABLE MEMBER_NOTNULL(
    MEMBER_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    );

INSERT INTO MEMBER_NOTNULL VALUES (1, 'user01', 'pass01','ȫ�浿', '��', '010-4121-3393', 'rudals@naver.com');

INSERT INTO MEMBER_NOTNULL VALUES (2, NULL,NULL,NULL,NULL,NULL,NULL);
-- �����߻�. NOT NULL �������ǿ� ����Ǿ� �����߻�

INSERT INTO MEMBER_NOTNULL VALUES (2, 'user02','pass02','�谩��',NULL,NULL,NULL);
-- NOTNULL ���� �ƴϴ��� 

SELECT * FROM MEMBER_NOTNULL;


/*
    2. UNIQUE ��������
        Į���� �ߺ����� �����ϴ� ��������(�ݵ�� ������ ���� 
        ����/������ ������ �ش� Į���� �߿� �ߺ����� ���� ���
        �߰�/������ ���� �ʰ� ����
        
        Į���������/���̺������ �Ѵ� ������
*/


CREATE TABLE MEMBER_UNIQUE(
    MEMBER_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE(MEMBER_ID)   -- <- ���̺������ : 
    --                  ���Į���� �� ����ϰ� �������� ���������� �ο��ϴ� ���
    );


INSERT INTO MEMBER_UNIQUE VALUES (1, 'user01','pass01','ȫ�浿','��','010-1111-1111', null);
-- ���������� �ο��Ҷ� ���� �������Ǹ��� ���������� ������ �ý��ۿ��� �˾Ƽ�
-- �ߺ����� �ʴ� ������ �������Ǹ��� �ο��Ѵ�. ex) SYS_C007073

/*
    * �������� �ο��� �������Ǹ� �����ϴ� ǥ����
    
    -> Į���������
    Į���� �ڷ��� [CONSTRAINT �������Ǹ�] ��������
    
    -> ���̺������
    [CONSTRAINT �������Ǹ�] ��������(Į����)
*/


CREATE TABLE MEMBER_UNIQUE_NN(
    MEMBER_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL ,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    CONSTRAINT MEM_ID_UQ UNIQUE(MEMBER_ID)   
    -- CONSTRAINT ���̺��_�������Ǹ�_Į���� ���� �ַ� ���(��� ���̺� ��ġ�� �ȵ�)                
    );


INSERT INTO MEMBER_UNIQUE_NN VALUES (1, 'user01','pass01','ȫ�浿','��','010-1111-1111', null);
INSERT INTO MEMBER_UNIQUE_NN VALUES (1, 'user01','pass01','ȫ�浿','��','010-1111-1111', null);
-- �������Ǹ��� ������ �Ŀ��� � Į���� � ������ ���������� �����ߴ���
-- �Ѵ��� �ľ��� �� �ִ�.


/*
    3. CHECK ��������
    Į���� ��ϵ� �� �ִ� ���� ���� ������ ���� ���� ����
    EX) ���� Į���� �� �Ǵ� ��, M Ȥ�� F, Y Ȥ�� N���� ���� �߰��ϰ� ���� �� ���
    
    [ǥ����]
    CHECK (���ǽ�)
*/

CREATE TABLE MEMBER_CHECK (
    MEMBER_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE(MEMBER_ID)   
    );


INSERT INTO MEMBER_CHECK VALUES (1, 'user01','pass01','ȫ�浿','��','010-1111-1111', null);
INSERT INTO MEMBER_CHECK VALUES (2, 'user02','pass02','ȫ�浿','��','010-1111-1111', null);

INSERT INTO MEMBER_CHECK VALUES (2, 'user02','pass02','ȫ�浿','��','010-1111-1111', null);
INSERT INTO MEMBER_CHECK VALUES (3, 'user03','pass03','ȫ�浿',NULL,'010-1111-1111', null);
-- CHECK ������������ NULL���� INSERT �����Ѱ�? ������
-- �߰������� NULL���� �������� �ϰ� �ʹٸ� NOT NULL �������ǵ� ���� �ɾ��ָ� ��

/*
    * DEFAULT ����
    Ư�� Į���� ���� ���� ���� �⺻�� ���� ����(���������� �ƴ�)
    
    EX)ȸ�������� Į���� ȸ�������� ���Ե� ������ �ð��� ����ϰ� �ʹ�. 
    -> DEFUALT�� SYSDATE�� �־��ָ� ��
*/

DROP TABLE MEMBER_CHECK;

CREATE TABLE MEMBER_CHECK (
    MEMBER_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE,
    UNIQUE(MEMBER_ID)   
    -- 
    );


INSERT INTO MEMBER_CHECK VALUES (1, 'user03','pass03','ȫ�浿','��','010-1111-1111', null, SYSDATE);

INSERT INTO MEMBER_CHECK VALUES (1, 'user02','pass02','ȫ�浿','��','010-1111-1111', null, DEFAULT);

SELECT * FROM MEMBER_CHECK;



/*
    INSERT INTO ���̺��(Į����� ����)
    VALUES(������ �°� ���� ����)
*/

INSERT INTO MEMBER_CHECK (MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GENDER)
VALUES(5, 'user55', 'pass', '�浿', '��');
-- ���� �߰��ϰ��� �������� Į������ �⺻������ NULL�� ����
-- ���� DEFAULT�ɼ��� �ο��Ǿ� �ִٸ� NULL���� �ƴ� DEFAULT���� ����

INSERT INTO MEMBER_CHECK (MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GENDER, MEMBER_DATE)
VALUES(6, 'user56', 'pass', '�浿', '��', NULL);
-- ��, NULL���� ����ϸ� NULL���� ����.

SELECT * FROM MEMBER_CHECK;



/*
    4. PRIMARY KEY(�⺻Ű) ��������
        ���̺��� �� ����� ������ �����ϰ� �ĺ��� �� �ִ� Į���� �ο��ϴ� ��������
        => �� ����� ������ �� �ִ� �ĺ����� ����
        EX) ���, �μ����̵�, �����ڵ�, ȸ����ȣ, �й� ��...
        => �ĺ����� ���� : �ߺ�X ���� ������ �ȵ�(NOT NULL + UNIQUE)
        
        �� ���̺�� �� ���� �⺻Ű�� ���� ����
*/


CREATE TABLE MEMBER_PRIMARYKEY1 (
    MEMBER_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE
    );


INSERT INTO MEMBER_PRIMARYKEY1 (MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GENDER)
VALUES(NULL, 'user2', 'pass', '�浿', '��');
-- �⺻Ű Į������ �ߺ���, NULL���� �ο��� �� ����. �׻� ������ ���� ������


CREATE TABLE MEMBER_PRIMARYKEY2 (
    MEMBER_NO NUMBER ,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEM_PK2 PRIMARY KEY(MEMBER_NO)   -- ���̺������
    );


CREATE TABLE MEMBER_PRIMARYKEY3 (
    MEMBER_ID VARCHAR2(20) ,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEM_PK3 PRIMARY KEY(MEMBER_ID, MEMBER_NAME)   -- ���̺������
    );
-- ���̺�� 1���� PRIMARY KEY�� ����� �� �ִ�.
-- �� ���� Į���� �⺻Ű�� ����ϰ� ���� ��� 
-- �� Į���� ��� �ѹ��� PRIMARY KEY�� ���� �����ϴ�.


INSERT INTO MEMBER_PRIMARYKEY3 (MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GENDER)
VALUES('user1', 'pass', '�浿', '��');

INSERT INTO MEMBER_PRIMARYKEY3 (MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GENDER)
VALUES('user1', 'pass', '�浿2', '��');

INSERT INTO MEMBER_PRIMARYKEY3 (MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GENDER)
VALUES('user1', 'pass', '�浿2', '��');
SELECT * FROM MEMBER_PRIMARYKEY3;
-- PRIMARY KEY�� �ο��� MEMBER_ID, MEMBER_NAME �� �� �����ϸ� �����߻�
-- �ϳ��� �ٸ� ��� ���� ������

-- -> ����Ű�� ��� �� Į���� ���� ������ �ߺ��Ǿ�� �������ǿ� ����ȴ�
-- ����Ű�� ��� �� Į���� ���� NULL�̴��� �������ǿ� ����ȴ�.



/*
    5. FOREIGN KEY(�ܷ�Ű)
        �ش� Į���� �ٸ� ���̺� �����ϴ� ���� ���;� �ϴ� Į���� �ο��ϴ� ��������
        => "�ٸ� ���̺��� �����Ѵ�"��� ǥ��
        ��, ������ �ٸ� ���̺��� �����ϰ� �ִ� ���� ���� �� �ִ�.
        EX) KH��������
            EMPLOYEE���̺� DEPT_CODE �� ��� DEPRARTMENT���̺��� DEPT_ID��
            �̹� �� �ִ� ���鸸 ����ϰ� �־���.
        => FORDIGN KEY ������������ ���̺��� ������� ����
        �ٸ� ���̺�� ���踦 ������ �� �ִ�.
        
        [ǥ����]
        -> Į��������� �������� ������
        Į���� �ڷ��� [CONSTRAINT �������Ǹ�] REFERENCES �������̺��[(������ Į����)]   
        
        -> ���̺������ 
        [CONSTRAINT �������Ǹ�] FOREIGN KEY(Į����) REFERENCES �������̺��[(������ Į����)] 
        
        => ���� ������ Ű���� : [CONSTRAINT �������Ǹ�], [(������ Į����)]
        => ������ Į���� ������ ������ ���̺��� PRIMARY KEY�� �ش��ϴ� Į���� ������ Į������ �����ȴ�.
        
        ������ Į���� Ÿ�԰� �ܷ�Ű�� ������ Į���� Ÿ��(�ڷ���)�� ��ġ�ؾ� �Ѵ�.
*/


-- �θ����̺�(�������̺�) �����
-- ȸ����޿� ���� �����͸� �����ϴ� ���̺�(����ڵ�, ��޸�)

CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY, --����ڵ� ���ڿ�('G1','G2','G3',..) �⺻Ű
    GRADE_NAME VARCHAR2(20) NOT NULL --��޸� ���ڿ� �Ϲ�ȸ��, ���ȸ��, ���̾�ȸ��..
    );

SELECT * FROM MEM_GRADE;

-- �ڽ����̺� �����
CREATE TABLE MEM (
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE, -- Į��������� �ܷ�Ű ����
    GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE 
    -- CONSTRAINT �������Ǹ� FREIGN KEY(GRADE_ID) REFERENCES MEM_GREADE(GRADE_CODE)
    -- ���̺������
    );

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (1, 'user1', 'pass01', '���', 'G1');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (2, 'user2', 'pass02', '�̼���', 'G2');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (3, 'user3', 'pass03', '�谩��', 'G3');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (4, 'user4', 'pass04', '����', 'G4');
-- G4 ����� MEM_GRADE ���̺� �������� �ʴ� �������̱� ������ �߰��� �� ����.

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (4, 'user4', 'pass04', '����', NULL);
-- �ܷ�Ű �������ǿ��� NULL���� �� �� �ִ�.

SELECT * FROM MEM;

SELECT MEMBER_NAME, GRADE_NAME
FROM MEM
JOIN MEM_GRADE ON GRADE_ID = GRADE_CODE;



-- MEM_GRADE���� ���ʿ��� �����Ͱ� �־ �����Ͱ��� �����ϰ��� �ϴ� ���
-- MEM_GRADE���̺�κ��� GRADE_CODE�� 'G1'�� �����͸� �����Ϸ��� �Ѵ�.

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
-- �ڽ� ���̺� �߿� GRAED_IDĮ������ G1���� �̹� �����ؼ� ����ϰ� �ֱ� ������
-- ������ �� ����.

-- ���� �ܷ�Ű �������� �ο��� ����ó���� ���� �ɼ��� ���� �ο����� ����
-- �⺻������ �������� �ɼ��� �ɷ��ִ�.

DROP TABLE MEM;

/*
    * �ڽ� ���̺� ������ �ο�(�ܷ�Ű ���������� �ο�������)
     �θ����̺�(�������̺�)�� �����Ͱ� �����Ǿ��� �� 
     �ڽ����̺��� ��� ó�������� �ɼ����� ���ص� �� �ִ�.
     
     * FOREIGN KEY �����ɼ�
     - ON DELETE RESTRICTED : ���� ���� => �⺻�ɼ�
     - ON DELETE SET NULL : �θ����͸� ������ �� �ش� �����͸� ����ϴ� 
                            �ڽĵ����͸� NULL�� �����ϰڴ�.
    - ON DELETE CASCADE : �θ����͸� ������ �� �ش� �����͸� ����ϴ�
                            �ڽĵ����͸� �Բ� �����ϰڴ�.
*/


CREATE TABLE MEM (
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE ON DELETE SET NULL, -- Į��������� �ܷ�Ű ����
    GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE 
    -- CONSTRAINT �������Ǹ� FREIGN KEY(GRADE_ID) REFERENCES MEM_GREADE(GRADE_CODE)
    -- ���̺������
    );

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (1, 'user1', 'pass01', '���', 'G1');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (2, 'user2', 'pass02', '�̼���', 'G2');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (3, 'user3', 'pass03', '�谩��', 'G3');

SELECT * FROM MEM;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
-- 'G1'�� �����ϰ� �ִ� Į������ NULL�� �ٲ��.



DROP TABLE MEM;

CREATE TABLE MEM (
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL ,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE ON DELETE CASCADE, -- Į��������� �ܷ�Ű ����
    GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEMBER_DATE DATE DEFAULT SYSDATE 
    -- CONSTRAINT �������Ǹ� FREIGN KEY(GRADE_ID) REFERENCES MEM_GREADE(GRADE_CODE)
    -- ���̺������
    );

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (1, 'user1', 'pass01', '���', 'G1');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (2, 'user2', 'pass02', '�̼���', 'G2');

INSERT INTO MEM(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, GRADE_ID)
VALUES (3, 'user3', 'pass03', '�谩��', 'G3');

SELECT * FROM MEM;


DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G3';


/*
    �ܷ�Ű ���������� ������ ������ ������
    ��, �� Į���� ������ �ǹ��� �����Ͱ� ��� �־�� ��
    (�ڷ����� ���� ��䰪�� ������ �ǹ̵� ����ؾ� ��)
*/

--------------------------------------------------------------------
/*
    ------------- ���⼭���� ������ KH�������� --------------------
    
    * SUBQUERY�� Ȱ���� ���̺� ����(���̺� ����)
    
    [ǥ����]
    CREATE TABLE ���̺�� 
    AS ��������;
*/

-- EMPLOYEE ���̺��� ������ ���ο� ���̺� �����ϱ�(EMPLOYEE_COPY)
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;
-- Į��, ��ȸ����� �����͵鸸 ����� �����
-- �������� �� NOT NULL �������� �����

-- PRIMARY KEY, �ڸ�Ʈ ���� ���簡 �ȵ�
-- ���������� ���� ���̺��� ������ ��� ���������� ��� NOT NULL�� �����

SELECT * FROM EMPLOYEE_COPY;


-- EMPLOYEE�� �ִ� �÷��� ������ �����ϰ� ������
CREATE TABLE EMPLOYEE_COPY2
AS SELECT * FROM EMPLOYEE
--WHERE EMP_ID IS NULL; (==)
WHERE 1 = 0;

SELECT * FROM EMPLOYEE_COPY2;



-- ��ü ����� �� �޿��� 300���� �̻��� ������� ���, �̸�, �μ��ڵ�, �޿� ����
-- Į���� �Բ� ����
-- ������ ���̺�� : EMPLOYEE_COPY3
CREATE TABLE EMPLOYEE_COPY3
AS 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT * FROM EMPLOYEE_COPY3;


-- ��ü ����� ���, �����, �޿�, ���� ��ȸ�� ����� ������ ���̺� ����
-- ������ ���̺�� : EMPLOYEE_COPY4
CREATE TABLE EMPLOYEE_COPY4
AS 
SELECT EMP_NO, EMP_NAME, SALARY, SALARY*12 "����"
FROM EMPLOYEE;

-- ���������� SELECT �������, �Լ����� ����� ��� �ݵ�� ��Ī�� �ο��ؾ� �Ѵ�.
SELECT * FROM EMPLOYEE_COPY4;






