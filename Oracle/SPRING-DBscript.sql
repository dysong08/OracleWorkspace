DROP TABLE REPLY;
DROP TABLE BOARD;
DROP TABLE MEMBER;
DROP TABLE BOARD_TYPE;
DROP TABLE BOARD_IMG;
DROP TABLE CHAT_MESSAGE;
DROP TABLE CHAT_ROOM;
DROP TABLE CHAT_ROOM_JOIN;
DROP SEQUENCE SEQ_UNO;
DROP SEQUENCE SEQ_BNO;
DROP SEQUENCE SEQ_RNO;
--------------------------------------------------
------------------  MEMBER 愿??젴 -------------------
--------------------------------------------------
CREATE TABLE MEMBER (
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(30) NOT NULL UNIQUE,
  USER_PWD VARCHAR2(100) NOT NULL,
  USER_NAME VARCHAR2(15) NOT NULL,
  EMAIL VARCHAR2(100),
  BIRTHDAY VARCHAR2(6),
  GENDER VARCHAR2(1) CHECK (GENDER IN('M', 'F')),
  PHONE VARCHAR2(13),
  ADDRESS VARCHAR2(100),
  ENROLL_DATE DATE DEFAULT SYSDATE,
  MODIFY_DATE DATE DEFAULT SYSDATE,
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N'))
);
CREATE SEQUENCE SEQ_UNO NOCACHE;
INSERT INTO MEMBER
VALUES (SEQ_UNO.NEXTVAL, 'admin', '1234', '관리자', 'admin@kh.or.kr', '800918', 'F', '010-1111-2222', '경기도', SYSDATE, SYSDATE, DEFAULT);
----------------------------------------------------
-------------------- BOARD 愿??젴  --------------------
----------------------------------------------------
CREATE TABLE BOARD(
  BOARD_NO NUMBER PRIMARY KEY,
  BOARD_TITLE VARCHAR2(100) NOT NULL,
  BOARD_CONTENT VARCHAR2(4000) NOT NULL,
  BOARD_WRITER NUMBER,
  COUNT NUMBER DEFAULT 0,
  CREATE_DATE DATE DEFAULT SYSDATE,
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')),
  ORIGIN_NAME VARCHAR2(200),
  CHANGE_NAME VARCHAR2(200),
  BOARD_CD VARCHAR2(2),
  FOREIGN KEY (BOARD_WRITER) REFERENCES MEMBER
);
CREATE SEQUENCE SEQ_BNO NOCACHE;
----------------------------------------------------
-------------------- REPLY 愿??젴 ---------------------	
----------------------------------------------------
CREATE TABLE REPLY(
  REPLY_NO NUMBER PRIMARY KEY,
  REPLY_CONTENT VARCHAR2(400),
  REF_BNO NUMBER,
  REPLY_WRITER NUMBER,
  CREATE_DATE DATE DEFAULT SYSDATE,
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),
  FOREIGN KEY (REF_BNO) REFERENCES BOARD,
  FOREIGN KEY (REPLY_WRITER) REFERENCES MEMBER
);
CREATE SEQUENCE SEQ_RNO NOCACHE;
CREATE TABLE BOARD_TYPE
(BOARD_CD CHAR(2) PRIMARY KEY,
 BOARD_NAME VARCHAR2(20) NOT NULL);
INSERT INTO BOARD_TYPE VALUES('C','일반게시판');
INSERT INTO BOARD_TYPE VALUES('T','사진게시판');
CREATE TABLE BOARD_IMG(
    BOARD_IMG_NO NUMBER PRIMARY KEY,
    ORIGIN_NAME VARCHAR2(200),
    CHANGE_NAME VARCHAR2(200),
    REF_BNO VARCHAR2(200),
    IMG_LEVEL NUMBER(1)
);
CREATE TABLE CHAT_MESSAGE(
CM_NO NUMBER PRIMARY KEY,
MESSAGE VARCHAR2(4000),
CREATE_DATE DATE,
CHAT_ROOM_NO NUMBER,
USER_NO NUMBER
);
CREATE TABLE CHAT_ROOM(
    CHAT_ROOM_NO NUMBER PRIMARY KEY,
    TITLE VARCHAR2(400),
    STATUS VARCHAR2(1) DEFAULT 'Y',
    USER_NO NUMBER
);
CREATE TABLE CHAT_ROOM_JOIN(
    USER_NO NUMBER,
    CHAT_ROOM_NO NUMBER
);
COMMIT;



INSERT INTO BOARD
VALUES
(SEQ_BNO.NEXTVAL,
'게시글제목2',
'게시글내용2',
8,
0,
SYSDATE,
DEFAULT,
NULL,
NULL,
'C');

COMMIT;

		SELECT B.*,  M.USER_NAME
		  FROM BOARD B
		  JOIN MEMBER M ON M.USER_NO = B.BOARD_WRITER
		 WHERE B.STATUS = 'Y';
         
         
CREATE SEQUENCE SEQ_INO;
COMMIT;

INSERT INTO REPLY
VALUES(SEQ_RNO.NEXTVAL, '잘봤어요', 24, 5, DEFAULT, DEFAULT);

INSERT INTO REPLY
VALUES(SEQ_RNO.NEXTVAL, '굿', 24, 8, DEFAULT, DEFAULT);

INSERT INTO REPLY
VALUES(SEQ_RNO.NEXTVAL, '좋아요', 24, 5, DEFAULT, DEFAULT);
COMMIT;


CREATE SEQUENCE SEQ_CM_NO;
delete from CHAT_ROOM_JOIN;
CREATE TABLE CHAT_ROOM_JOIN;
ALTER TABLE CHAT_ROOM_JOIN ADD PRIMARY KEY(USER_NO, CHAT_ROOM_NO);


create table menu (
    id number,
    restaurant varchar2(512) not null,
    name varchar2(256) not null,
    price number,
    type varchar2(10) not null, --  한식 kr, 중식 ch, 일식 jp
    taste varchar2(10) not null, -- 순한맛 mild, 매운맛 hot
    constraint pk_menu primary key(id),
    constraint uq_menu unique (restaurant, name, taste) -- 두리순대국 순대국 mild, 두리순대국 순대국 hot
);
create sequence seq_menu_id;
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'두리순대국','순대국',7000,'kr','mild');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'두리순대국','순대국',7000,'kr','hot');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'장터','뚝배기 김치찌게',7000,'kr','hot');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'만리향','간짜장',5000,'ch','mild');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'만리향','짬뽕',6000,'ch','hot');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'짬뽕지존','짬뽕',9000,'ch','mild');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'김남완초밥집','완초밥',13000,'jp','mild');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'김남완초밥집','런치초밥',10000,'jp','mild');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'김남완초밥집','참치도로초밥',33000,'jp','mild');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'진가와','자루소면',8000,'jp','mild');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'진가와','자루소바',9000,'jp','mild');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'백운봉','막국수',9000,'kr','hot');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'대우부대찌게','부대지게',10000,'kr','hot');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'봉된장','열무비빔밥+우렁된장',7000,'kr','hot');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'대우부대찌게','부대찌게',10000,'kr','hot');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'산들애','딸기',500,'kr','hot');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'대우부대찌게','청국장',13000,'kr','mild');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'스타동','사케동',8400,'jp','mild');
insert into spring.menu (id,restaurant,name,price,type,taste) values (seq_menu_id.nextval,'진씨화로','돌솥비빔밥',7000,'kr','mild');
commit;

select   *
from   menu;
