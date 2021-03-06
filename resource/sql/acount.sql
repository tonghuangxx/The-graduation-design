--recommender_id:推荐人id   login_name:登录名       	login_passwd：登录密码  status：状态
--create_date:创建时间    pause_date:终止时间    close_date:关闭时间   real_name:真实姓名
--idcard_no：身份证号    birthday:生日   gender：性别   occupation:职业   telephone:电话
--email:邮箱     mailaddress：通讯地址   zipcode：邮编     qq：qq号     last_login_time:上次登录时间
--last_login_ip：上次登录的ip
 
CREATE TABLE DLTS_ACCOUNT(
 ID			NUMBER(9) CONSTRAINT DLTS_ACCOUNT_ID_PK PRIMARY KEY,
 RECOMMENDER_ID	NUMBER(9) CONSTRAINT DLTS_ACCOUNT_RECOMMENDER_ID_FK
			REFERENCES DLTS_ACCOUNT(ID),
 LOGIN_NAME		VARCHAR2(30)  NOT NULL
			CONSTRAINT DLTS_ACCOUNT_LOGIN_NAME_UK UNIQUE,
 LOGIN_PASSWD		VARCHAR2(30) NOT NULL,
 STATUS			CHAR(1)	CONSTRAINT DLTS_ACCOUNT_STATUS_CK
 				CHECK (STATUS IN (0,1,2)),
 CREATE_DATE		DATE	 DEFAULT SYSDATE,
 PAUSE_DATE		DATE,
 CLOSE_DATE		DATE,
 REAL_NAME		VARCHAR2(20)	NOT NULL,
 IDCARD_NO		CHAR(18)		NOT NULL
			CONSTRAINT DLTS_ACCOUNT_INCARD_NO UNIQUE,
 BIRTHDATE		DATE,
 GENDER	             		CHAR(1) CONSTRAINT DLTS_ACCOUNT_GENDER_CK
				CHECK (GENDER IN (0,1)),
 OCCUPATION		VARCHAR2(50),
 TELEPHONE		VARCHAR2(15) NOT NULL,
 EMAIL			VARCHAR2(50),
 MAILADDRESS		VARCHAR2(50),
 ZIPCODE		CHAR(6),
 QQ			VARCHAR2(15),
 LAST_LOGIN_TIME	  	DATE,
 LAST_LOGIN_IP		VARCHAR2(15)
);
--创建帐务表的序号
create sequence dlts_account_id;

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
     REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(dlts_account_id.nextval,NULL,'taiji001','256528',1,'2008 03 15','zhangsanfeng','19430225','410381194302256528',13669351234);

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(dlts_account_id.nextval,NULL,'xl18z60','190613',1,'2009 01 10','guojing','19690319','330682196903190613',13338924567);

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(dlts_account_id.nextval,2,'dgbf70','270429',1,'2009 03 01','huangrong','19710827','330902197108270429',13637811357);

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(dlts_account_id.nextval,1,'mjjzh64','041115',1,'2010 03 12','zhangwuji','19890604','610121198906041115',13572952468);

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(dlts_account_id.nextval,3,'jmdxj00','010322',1,'2011 01 01','guofurong','199601010322','350581200201010322',18617832562);

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(dlts_account_id.nextval,3,'ljxj90','310346',1,'2012 02 01','luwushuang','19930731','320211199307310346',13186454984);

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(dlts_account_id.nextval,NULL,'kxhxd20','012115',1,'2012 02 20','weixiaobao','20001001','321022200010012115',13953410078);





--UNIX服务器信息表
CREATE TABLE DLTS_HOST
(ID 		NUMBER(15) CONSTRAINT DLTS_HOST_ID_PK PRIMARY KEY,
HOST_IP VARCHAR2(15),
NAME 		VARCHAR2(20), 
LOCATION	VARCHAR2(30)
);

CREATE SEQUENCE DLTS_HOST_ID;
INSERT INTO HOST VALUES (dlts_host_id.nextval,'192.168.0.26','sunv210','beijing');
INSERT INTO HOST VALUES(dlts_host_id.nextval,'192.168.0.20','sun-server','beijing');
INSERT INTO HOST VALUES (dlts_host_id.nextval,'192.168.0.23','sun280','beijing');
INSERT INTO HOST VALUES (dlts_host_id.nextval,'192.168.0.200','ultra10','beijing');

--业务信息表
CREATE TABLE DLTS_SERVICE(
 ID		NUMBER(10) CONSTRAINT DLTS_SERVICE_ID_PK PRIMARY KEY,
 ACCOUNT_ID	NUMBER(9) CONSTRAINT DLTS_SERVICE_DLTS_ACCOUNT_ID_FK
		REFERENCES ACCOUNT(ID) NOT NULL,
 UNIX_HOST	VARCHAR2(15) CONSTRAINT DLTS_SERVICE_UNIX_HOST_FK
		REFERENCES HOST(ID) NOT NULL ,
 OS_USERNAME	VARCHAR2(8)	NOT NULL,
 CONSTRAINT DLTS_SERVICE_UNIXHOST_OSUSERNAME_UK 
 	UNIQUE(UNIX_HOST,OS_USERNAME),
 LOGIN_PASSWD	VARCHAR2(8) NOT NULL,
 STATUS 		CHAR(1) 	CONSTRAINT DLTS_SERVICE_STATUS_CK
			CHECK ( STATUS IN (0,1,2) ),	
 CREATE_DATE	DATE	DEFAULT SYSDATE,
 PAUSE_DATE	DATE,
 CLOSE_DATE	DATE,
 COST_ID		NUMBER(4) CONSTRAINT DLTS_SERVICE_COST_ID_FK
			REFERENCES COST(ID) NOT NULL
);

INSERT INTO SERVICE VALUES (2001,1010,'192.168.0.26','guojing','guo1234',0,'2009 03 10 10:00:00',null,null,1);

INSERT INTO SERVICE VALUES (2002,1011,'192.168.0.26','huangr','huang234',0,'2009 03 01 15:30:05',null,null,1);

INSERT INTO SERVICE VALUES (2003,1011,'192.168.0.20','huangr','huang234',0,'2009 03 01 15:30:10',null,null,3);

INSERT INTO SERVICE VALUES (2004,1011,'192.168.0.23','huangr','huang234',0,'2009 03 01 15:30:15',null,null,6);

INSERT INTO SERVICE VALUES (2005,1019,'192.168.0.26','luwsh','luwu2345',0,'2012 02 10 23 :50:55',null,null,4);

INSERT INTO SERVICE VALUES (2006,1019,'192.168.0.20','luwsh','luwu2345',0,'2012 02 10 00 :00:00',null,null,5);

INSERT INTO SERVICE VALUES (2007,1020,'192.168.0.20','weixb','wei12345',0,'2012 02 10 11:05:20',null,null,6);

INSERT INTO SERVICE VALUES (2008,1010,'192.168.0.20','guojing','guo09876',0,'2012 02 11 12:05:21',null,null,6);

--业务详单表
CREATE TABLE SERVICE_DETAIL
(ID 		NUMBER(11) CONSTRAINT SERVICE_DTAIL_ID_PK PRIMARY KEY,
 SERVICE_ID 	NUMBER(10) CONSTRAINT SERVICE_DETAIL_SERVICE_ID
                                        		REFERENCES SERVICE(ID) NOT NULL,
 CLIENT_HOST 	VARCHAR2(15),
 OS_USERNAME 	VARCHAR2(8),
 PID 		NUMBER(11),
 LOGIN_TIME 	DATE,
 LOGOUT_TIME 	DATE,
 DURATION 	NUMBER(20,9),
 COST		NUMBER(20,6));

ALTER SESSION SET NLS_DATE_FORMAT  = 'yyyy mm dd hh24:mi:ss'
INSERT INTO SERVICE_DETAIL(ID,SERVICE_ID,CLIENT_HOST,OS_USERNAME,LOGOUT_TIME,DURATION) VALUES
(1,2001,'192.168.172.4','guojing','2013 06 11 08:30:00',3610);
INSERT INTO SERVICE_DETAIL(ID,SERVICE_ID,CLIENT_HOST,OS_USERNAME,LOGOUT_TIME,DURATION) VALUES
(2,2001,'192.168.172.4','guojing','2013 06 13 20:30:00',10800);
INSERT INTO SERVICE_DETAIL(ID,SERVICE_ID,CLIENT_HOST,OS_USERNAME,LOGOUT_TIME,DURATION) VALUES
(3,2001,'192.168.172.4','guojing','2013 06 14 20:30:00',10800);
INSERT INTO SERVICE_DETAIL(ID,SERVICE_ID,CLIENT_HOST,OS_USERNAME,LOGOUT_TIME,DURATION) VALUES
(4,2001,'192.168.172.4','guojing','2013 06 15 19:30:00',32400);
INSERT INTO SERVICE_DETAIL(ID,SERVICE_ID,CLIENT_HOST,OS_USERNAME,LOGOUT_TIME,DURATION) VALUES
(5,2001,'192.168.172.4','guojing','2013 06 18 19:30:00',36000);
INSERT INTO SERVICE_DETAIL(ID,SERVICE_ID,CLIENT_HOST,OS_USERNAME,LOGOUT_TIME,DURATION) VALUES
(6,2001,'192.168.172.4','guojing','2013 06 20 21:30:00',36000);
COMMIT;

--业务资费更新备份表
CREATE TABLE SERVICE_UPDATE_BAK(
 ID		NUMBER(10) PRIMARY KEY,
 SERVICE_ID	NUMBER(9) NOT NULL,
 COST_ID		NUMBER(4)  NOT NULL
);

--时长信息表
CREATE TABLE MONTH_DURATION
(SERVICE_ID 		NUMBER(10),
 MONTH_ID 		CHAR(6),
 CONSTRAINT MONTH_DURATION_PK PRIMARY KEY(SERVICE_ID,MONTH_ID),
 SERVICE_DETAIL_ID            NUMBER(11),
 SOFAR_DURATION	NUMBER(11)
);

--用临时表技术生成账单编号表，用于保存BILL_ID(账单ID)，ACCOUNT_ID（帐务ID），BILL_MONTH（账单月）
CREATE GLOBAL TEMPORARY TABLE BILL_CODE
(BILL_ID  		NUMBER(11),
 ACCOUNT_ID 	NUMBER(9),
 BILL_MONTH 	CHAR(6)
) On COMMIT PRESERVE ROWS;
 
--账单信息表
DROP TABLE BILL CASCADE CONSTRAINTS PURGE;
CREATE TABLE BILL
(ID 		NUMBER(11) CONSTRAINT BILL_ID_PK PRIMARY KEY,
 ACCOUNT_ID 	NUMBER(9) CONSTRAINT BILL_ACCOUNT_ID
                                           REFERENCES ACCOUNT(ID) NOT NULL,
 BILL_MONTH 	CHAR(6),
 COST 		NUMBER(13,2),
 PAYMENT_MODE 	CHAR(1) CONSTRAINT BILL_PAYMENT_CODE_CK
			CHECK (PAYMENT_MODE IN (0,1,2,3)),
 PAY_STATE	CHAR(10) DEFAULT 0 CONSTRAINT BILL_PAY_STATE_CK
		CHECK (PAY_STATE IN (0,1)) 
);

--账单条目表
DROP TABLE BILL_ITEM CASCADE CONSTRAINTS PURGE;
CREATE TABLE BILL_ITEM
(ITEM_ID		NUMBER(11) CONSTRAINT BILL_ITEM_ID_PK  PRIMARY KEY,
 BILL_ID 		NUMBER(11) CONSTRAINT BILL_ITME_BILL_ID
			REFERENCES BILL(ID) NOT NULL,
 SERVICE_ID 	NUMBER(10) NOT NULL,
 COST 		NUMBER(13,2));

