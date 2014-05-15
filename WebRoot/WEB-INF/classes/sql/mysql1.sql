create database biyesheji default character set utf8;
use biyesheji;

--id:主键    admin_code:管理员帐号   password:密码    name:姓名  
--telephone:电话   email:邮件  enrolldate:创建日期         
--创建用户表
CREATE TABLE DLTS_ADMIN_INFO(
	ID varchar(32),
	ADMIN_CODE VARCHAR(30) NOT NULL unique,	
	PASSWORD VARCHAR(32) NOT NULL,
	NAME VARCHAR(30) NOT NULL,
	TELEPHONE VARCHAR(30),
	EMAIL VARCHAR(50),
	ENROLLDATE DATETIME NOT NULL,
	CONSTRAINT DLTS_ADMIN_INFO_ID_PK PRIMARY KEY(id)
)engine=innodb;
alter table DLTS_ADMIN_INFO modify column ENROLLDATE DATETIME;
update dlts_admin_info set enrolldate='2014-01-01' where id ='402881e645db3cc40145db3fd5e60000';
select * from dlts_admin_info;

insert into dlts_admin_info values(1,'dlts','F60598D5B3B5012DA811610A7D8CC0C1','cwb','13688997766',
		'shiyl@sin.com','2013-05-22');
insert into dlts_admin_info values(2,'admin','111111','lily','13688997766','shiyl@sin.com'
   ,'2013-05-22 12:12:12');
insert into dlts_admin_info values(3,'tom123','1234','tom','13688997766','shiyl@sin.com'
   ,'2014-02-22');
insert into dlts_admin_info values(4,'lbwn','1234','lb','13688997766','shiyl@sin.com'
   ,'2013-05-22');
   insert into dlts_admin_info values('543da','lbwn123','1234','lb','13688997766','shiyl@sin.com'
   ,'2013-05-22');
   
   
--角色表
CREATE TABLE DLTS_ROLE(
	id varchar(32),
	role_name varchar(30) not null,
	constraint dlts_role_id_pk primary key(id)
)engine=innodb;


insert into dlts_role values(1,'超级管理');
insert into dlts_role values(2,'角色管理');
insert into dlts_role values(3,'资费管理');
insert into dlts_role values(4,'帐务管理');
insert into dlts_role values(5,'业务管理');
insert into dlts_role values(6,'账单管理');
insert into dlts_role values(7,'报表管理');
insert into dlts_role values(8,'管理员管理');

--用户角色关系表
CREATE TABLE dlts_user_role(
  id varchar(32),
  usid varchar(32),
  rid varchar(32),
  constraint dlts_user_role_id_pk primary key(id),
  CONSTRAINT dlts_user_role_usid_fk FOREIGN KEY(usid) REFERENCES dlts_admin_info(id) on delete set null,
  CONSTRAINT dlts_user_role_tid_fk FOREIGN KEY(rid) REFERENCES dlts_role(id) on delete set null
 )engine=innodb;

alter table dlts_user_role drop  foreign key dlts_user_role_usid_fk;
alter table dlts_user_role drop  foreign key dlts_user_role_tid_fk;
alter table dlts_user_role add constraint dlts_user_role_usid_fk foreign key(usid) references dlts_admin_info(id) on delete set null;
alter table dlts_user_role add constraint dlts_user_role_tid_fk foreign key(rid) references dlts_role(id) on delete set null;
select ar.id,ar.usid,ar.rid,ai.id,ai.admin_code,ai.password,ai.name,ai.telephone,ai.email,ai.enrolldate,r.id,r.role_name from dlts_admin_info ai left outer join dlts_user_role ar on ar.usid=ai.id left outer join dlts_role r on ar.rid=r.id order by ai.enrolldate desc;

--给一号管理员添加数据
insert into dlts_user_role values(1,1,1);
insert into dlts_user_role values(2,1,2);
insert into dlts_user_role values(3,1,3);
insert into dlts_user_role values(4,1,4);
insert into dlts_user_role values(5,1,5);
insert into dlts_user_role values(6,1,6);
insert into dlts_user_role values(7,1,7);
insert into dlts_user_role values(8,1,8);
--给二号管理员添加数据
insert into dlts_user_role values(9,2,8);
--给三号管理员添加数据
insert into dlts_user_role values(10,3,8);
--给四号管理员添加数据
insert into dlts_user_role values(11,4,8);


--模块表
CREATE TABLE dlts_module(
	id varchar(32),
	module_name varchar(20) not null,
	constraint dlts_module_id_pk primary key(id)
)engine=innodb;

insert into dlts_module values(1,'角色');
insert into dlts_module values(2,'资费');
insert into dlts_module values(3,'帐务');
insert into dlts_module values(4,'业务');
insert into dlts_module values(5,'账单');
insert into dlts_module values(6,'报表');
insert into dlts_module values(7,'管理');

##功能表
create table dlts_function(
	id varchar(32),
	code varchar(255),
	name varchar(255),
	action varchar(1000),
	parentId varchar(32),
	constraint dlts_function_id_pk primary key(id)
)engine=innodb;

##角色功能表
create table dlts_role_function(
	id varchar(32),
	roleId varchar(32),
	functionId varchar(32),
	constraint dlts_role_function_id_pk primary key(id),
	constraint dlts_role_function_roleId_fk foreign key(roleId) references dlts_role(id) on delete set null,
	constraint dlts_role_function_functionId_fk foreign key(functionId) references dlts_function(id) on delete set null
)engine=innodb;

alter table dlts_user_role drop  foreign key dlts_role_function_roleId_fk;
alter table dlts_user_role drop  foreign key dlts_role_function_functionId_fk;
alter table dlts_user_role add constraint dlts_user_role_usid_fk foreign key(usid) references dlts_admin_info(id) on delete set null;
alter table dlts_user_role add constraint dlts_user_role_tid_fk foreign key(rid) references dlts_role(id) on delete set null;

select count(*) from DLTS_ADMIN_INFO ai left outer join dlts_user_role ar on ar.usid=ai.id left outer join dlts_role r on ar.rid=r.id;


select * from dlts_acl;
select * from dlts_admin_info; 
select * from dlts_role;
select * from dlts_user_role where usid=3; 
select * from dlts_module;
select * from dlts_acl where mid=1;
select * from (select rownum rn,id,admin_code,password,
name,telephone,email,enrolldate from dlts_admin_info 
					 where rownum<=4)  where rn>=3;
					 
select * from dlts_module m join dlts_role r on m.id=r.id join dlts_admin_info a  where m.id=1; 			

alter system set processes=1000 scope=spfile;
commit;
select count(*) from v$process;
select value from v$parameter where name='processes';


--资费表   
--id:资费id  name：资费名称   base_duration:包在线时长  base_cost:月固定费用  unit_cost:单位费用
--status:0：开通  1：暂停  2:表示删除  descr：资费信息说明  creatime:创建时间  startime：启用时间 
--cost_type 1表示包月,2表示套餐,3表示计时
CREATE TABLE DLTS_COST(
    ID varchar(32),
    NAME VARCHAR(50) NOT NULL,
    BASE_DURATION int,
    BASE_COST float(7,2),
    UNIT_COST float(7,4),
    STATUS CHAR(1),
    DESCR VARCHAR(100),
    CREATIME DATETIME,
    STARTIME DATETIME,
    COST_TYPE CHAR(1),
    CONSTRAINT DLTS_COST_ID_PK PRIMARY KEY(id)
 )engine=innodb;
INSERT INTO dlts_cost VALUES (1,'5.9元套餐',20,5.9,0.4,0,'5.9元20小时/月,超出部分0.4元/时',now(),now(),'2');
INSERT INTO dlts_cost VALUES (2,'6.9元套餐',40,6.9,0.3,0,'6.9元40小时/月,超出部分0.3元/时',now(),now(),'2');
INSERT INTO dlts_cost VALUES (3,'8.5元套餐',100,8.5,0.2,0,'8.5元100小时/月,超出部分0.2元/时',now(),now(),'2');
INSERT INTO dlts_cost VALUES (4,'10.5元套餐',200,10.5,0.1,0,'10.5元200小时/月,超出部分0.1元/时',now(),now(),'3');
INSERT INTO dlts_cost VALUES (5,'计时收费',0,0,0.5,0,'0.5元/时,不使用不收费',now(),now(),'1');
INSERT INTO dlts_cost VALUES (6,'包月',0,20,0,0,'每月20元,不限制使用时间',now(),now(),'1');
INSERT INTO dlts_cost VALUES (7,'包年',0,20,0,1,'每月20元,不限制使用时间',now(),now(),'1');
=========================================================




--recommender_id:推荐人id   login_name:登录名       	login_passwd：登录密码  status：状态
--create_date:创建时间    pause_date:终止时间    close_date:关闭时间   real_name:真实姓名
--idcard_no：身份证号    birthday:生日   gender：性别   occupation:职业   telephone:电话
--email:邮箱     mailaddress：通讯地址   zipcode：邮编     qq：qq号     last_login_time:上次登录时间
--last_login_ip：上次登录的ip
 
CREATE TABLE DLTS_ACCOUNT(
 ID			int(11) CONSTRAINT DLTS_ACCOUNT_ID_PK PRIMARY KEY auto_increment,
 RECOMMENDER_ID	int(11) CONSTRAINT DLTS_ACCOUNT_RECOMMENDER_ID_FK
			REFERENCES DLTS_ACCOUNT(ID),
 LOGIN_NAME		VARCHAR2(30)  NOT NULL
			CONSTRAINT DLTS_ACCOUNT_LOGIN_NAME_UK UNIQUE,
 LOGIN_PASSWD		VARCHAR2(30) NOT NULL,
 STATUS			CHAR(1)	CONSTRAINT DLTS_ACCOUNT_STATUS_CK
 				CHECK (STATUS IN (0,1,2)),
 CREATE_DATE	timestamp 	 DEFAULT current_timestamp,
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

