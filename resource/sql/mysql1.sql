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

insert into dlts_admin_info values('e18464c163904680bb124da8ed47704f','dlts','F60598D5B3B5012DA811610A7D8CC0C1','cwb','18766922216','979447668@sin.com','2013-05-22');
   
--角色表
CREATE TABLE DLTS_ROLE(
	id varchar(32),
	role_name varchar(30) not null,
	constraint dlts_role_id_pk primary key(id)
)engine=innodb;

insert into dlts_role values('79b1cfc5195e4990b60b92e8595d838c','超级管理');
insert into dlts_role values('17289f0071a94926b8029f5cdb148a7c','角色管理');
insert into dlts_role values('d341c8e8a16a4a1ab31ede808b9b0911','资费管理');
insert into dlts_role values('4d097cfdf86240e9939ecd5d2214f982','帐务管理');
insert into dlts_role values('f745f07725d640bb89c1704449377141','业务管理');
insert into dlts_role values('67c733b569bb45a79f0f5982c57a3f7a','账单管理');
insert into dlts_role values('476a4edd35734eb385832ffe844b0afc','报表管理');
insert into dlts_role values('9f73030dfd1944a0becde731b70facc1','管理员管理');

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
insert into dlts_user_role values('e18464c163904680bb124da8ed47704f','e18464c163904680bb124da8ed47704f','79b1cfc5195e4990b60b92e8595d838c');
insert into dlts_user_role values('fcb688b6510a41559dea2110c4435bb4','e18464c163904680bb124da8ed47704f','17289f0071a94926b8029f5cdb148a7c');
insert into dlts_user_role values('d9aa3905fa934ac59b82d8a3f6065f11','e18464c163904680bb124da8ed47704f','d341c8e8a16a4a1ab31ede808b9b0911');
insert into dlts_user_role values('d0d4b5262b57450fad2cdc542666570e','e18464c163904680bb124da8ed47704f','f745f07725d640bb89c1704449377141');
insert into dlts_user_role values('127c577efab441c2ac41f8c5dcf1aab8','e18464c163904680bb124da8ed47704f','67c733b569bb45a79f0f5982c57a3f7a');
insert into dlts_user_role values('f18b505bd224482dbcb729acbc6fc927','e18464c163904680bb124da8ed47704f','476a4edd35734eb385832ffe844b0afc');
insert into dlts_user_role values('51216abc5a6f4615b2fa3b061a9d2613','e18464c163904680bb124da8ed47704f','9f73030dfd1944a0becde731b70facc1');
insert into dlts_user_role values('2e395434afa74ee1abc79b0c3c1c295f','e18464c163904680bb124da8ed47704f','4d097cfdf86240e9939ecd5d2214f982');

##功能表
create table dlts_function(
	id varchar(32),
	code varchar(255),
	name varchar(255),
	action varchar(1000),
	parentId varchar(32),
	moduleId varchar(32),
	constraint dlts_function_id_pk primary key(id)
)engine=innodb;

insert into dlts_function values('6cc0cdac947f42669d5508cbc438a20f',null,'角色操作',null,'0','979c435a126043c5af2c8a0967121e1d');
insert into dlts_function values('cedd55caf0054872803b4b9443d43a9c',null,'资费操作',null,'0','8a413d26ca4345d68137a944a47f0766');
insert into dlts_function values('3d1d0341892941d7b7a6770d20f07d2a',null,'管理员操作',null,'0','ccf01cb3d8fc441b81b4e6a8417f7233');
insert into dlts_function values('fdd4c28eaff04a049c471c8ca5f53f2a',null,'修改信息',null,'0','d5d659c7bc124bcc81ef431cb99dbc43');
insert into dlts_function values('bd5e15e0fa8e473b86da255b9a22f266',null,'修改密码',null,'0','6c7b939b422a43298a55feb1b26a3190');
insert into dlts_function values('6e6307cdd9414e4fb27009c1d489d64c',null,'帐务操作',null,'0','67b5548595bb4cb797fa634a28ac3580');
insert into dlts_function values('a1970ae90d414a9d824e98fab27b32c1',null,'业务操作',null,'0','c89f98f64dc84efa82af44797fde4571');
insert into dlts_function values('e42797cda42e44e59ca1be435597ecdc',null,'账单操作',null,'0','10b336ca80ce47259f33ce04e83cff73');
##还未插入
insert into dlts_function values('14b800c2cce445009b93e3b0752a6c49',null,'报表操作',null,'0','');














##角色功能表
create table dlts_role_function(
	id varchar(32),
	roleId varchar(32),
	functionId varchar(32),
	constraint dlts_role_function_id_pk primary key(id),
	constraint dlts_role_function_roleId_fk foreign key(roleId) references dlts_role(id) on delete set null,
	constraint dlts_role_function_functionId_fk foreign key(functionId) references dlts_function(id) on delete set null
)engine=innodb;
##超级管理员对应的function
insert into dlts_role_function values('b55943627ef5478c8f3173358a903049','79b1cfc5195e4990b60b92e8595d838c','6cc0cdac947f42669d5508cbc438a20f');
insert into dlts_role_function values('6ddfe1be0d364377ba302654d0ae0acc','79b1cfc5195e4990b60b92e8595d838c','cedd55caf0054872803b4b9443d43a9c');
insert into dlts_role_function values('0470674205ae4326b8c028f2a3c25a23','79b1cfc5195e4990b60b92e8595d838c','3d1d0341892941d7b7a6770d20f07d2a');
insert into dlts_role_function values('60e5cb0471c444ad86ace74799a336a0','79b1cfc5195e4990b60b92e8595d838c','fdd4c28eaff04a049c471c8ca5f53f2a');
insert into dlts_role_function values('f84adc3c802b4e3f976f0cbc5fc5ed98','79b1cfc5195e4990b60b92e8595d838c','bd5e15e0fa8e473b86da255b9a22f266');
##管理员对应的function
insert into dlts_role_function values('5e58de405f3a48c7afb459c954aa7cb3','9f73030dfd1944a0becde731b70facc1','3d1d0341892941d7b7a6770d20f07d2a');
insert into dlts_role_function values('a3020ef885f04ea296950d0e8119279d','9f73030dfd1944a0becde731b70facc1','fdd4c28eaff04a049c471c8ca5f53f2a');
insert into dlts_role_function values('05e3afd56746416a89a796c1d7205c0d','9f73030dfd1944a0becde731b70facc1','bd5e15e0fa8e473b86da255b9a22f266');

--模块表
CREATE TABLE dlts_module(
	id varchar(32),
	module_name varchar(20) not null,
	menucode varchar(100),
	url varchar(500),
	parentid varchar(32),
	displayno int,
	deleted int,
	constraint dlts_module_id_pk primary key(id)
)engine=innodb;

insert into dlts_module values('979c435a126043c5af2c8a0967121e1d','角色管理','role_off','/role/listData','0',1,0);
insert into dlts_module values('ccf01cb3d8fc441b81b4e6a8417f7233','管理员','admin_off','/user/listData','0',2,0);
insert into dlts_module values('8a413d26ca4345d68137a944a47f0766','资费','fee_off','/fee/listData','0',3,0);
insert into dlts_module values('67b5548595bb4cb797fa634a28ac3580','帐务','account_off','/account/listData','0',4,0);
insert into dlts_module values('c89f98f64dc84efa82af44797fde4571','业务','service_off','/service/listData','0',5,0);
insert into dlts_module values('10b336ca80ce47259f33ce04e83cff73','账单','bill_off','/bill/listData','0',6,0);
insert into dlts_module values('c2112f8554a84d309eadd17aad493cc4','报表');
insert into dlts_module values('d5d659c7bc124bcc81ef431cb99dbc43','个人信息','information_off','/user/updateInfo','0',8,0);
insert into dlts_module values('6c7b939b422a43298a55feb1b26a3190','修改密码','password_off','/user/updatePwd','0',9,0);




alter table dlts_user_role drop  foreign key dlts_role_function_roleId_fk;
alter table dlts_user_role drop  foreign key dlts_role_function_functionId_fk;
alter table dlts_user_role add constraint dlts_user_role_usid_fk foreign key(usid) references dlts_admin_info(id) on delete set null;
alter table dlts_user_role add constraint dlts_user_role_tid_fk foreign key(rid) references dlts_role(id) on delete set null;

select count(*) from DLTS_ADMIN_INFO ai left outer join dlts_user_role ar on ar.usid=ai.id left outer join dlts_role r on ar.rid=r.id;




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
INSERT INTO dlts_cost VALUES ('1','5.9元套餐',20,5.9,0.4,0,'5.9元20小时/月,超出部分0.4元/时',now(),now(),'2');
INSERT INTO dlts_cost VALUES ('2','6.9元套餐',40,6.9,0.3,0,'6.9元40小时/月,超出部分0.3元/时',now(),now(),'2');
INSERT INTO dlts_cost VALUES ('3','8.5元套餐',100,8.5,0.2,0,'8.5元100小时/月,超出部分0.2元/时',now(),now(),'2');
INSERT INTO dlts_cost VALUES ('4','10.5元套餐',200,10.5,0.1,0,'10.5元200小时/月,超出部分0.1元/时',now(),now(),'2');
INSERT INTO dlts_cost VALUES ('5','计时收费',0,0,0.5,0,'0.5元/时,不使用不收费',now(),now(),'3');
INSERT INTO dlts_cost VALUES ('6','包月',0,20,0,0,'每月20元,不限制使用时间',now(),now(),'1');
INSERT INTO dlts_cost VALUES ('7','包年',0,20,0,1,'每月20元,不限制使用时间',now(),now(),'1');




--recommender_id:推荐人id   login_name:登录名       	login_passwd：登录密码  status：状态
--create_date:创建时间    pause_date:终止时间    close_date:关闭时间   real_name:真实姓名
--idcard_no：身份证号    birthday:生日   gender：性别   occupation:职业   telephone:电话
--email:邮箱     mailaddress：通讯地址   zipcode：邮编     qq：qq号     last_login_time:上次登录时间
--last_login_ip：上次登录的ip
 
CREATE TABLE DLTS_ACCOUNT(
 	ID	varchar(32),
 	RECOMMENDER_ID	VARCHAR(32),
 	LOGIN_NAME	VARCHAR(100) NOT NULL UNIQUE,
 	LOGIN_PASSWD VARCHAR(32) NOT NULL,
	STATUS	CHAR(1),
 	CREATE_DATE	timestamp DEFAULT current_timestamp,
 	PAUSE_DATE	DATETIME,
 	CLOSE_DATE	DATETIME,
 	REAL_NAME	VARCHAR(100) NOT NULL,
 	IDCARD_NO CHAR(18) NOT NULL UNIQUE,
 	BIRTHDATE	DATETIME,
 	GENDER	   CHAR(1),
 	OCCUPATION	VARCHAR(50),
 	TELEPHONE	VARCHAR(15) NOT NULL,
 	EMAIL		VARCHAR(50),
 	MAILADDRESS	VARCHAR(50),
 	ZIPCODE		CHAR(6),
 	QQ			VARCHAR(15),
 	LAST_LOGIN_TIME	DATETIME,
 	LAST_LOGIN_IP	VARCHAR(15),
 	CONSTRAINT DLTS_ACCOUNT_ID_PK PRIMARY KEY(ID),
 	CONSTRAINT DLTS_ACCOUNT_RECOMMENDER_ID_FK FOREIGN KEY(RECOMMENDER_ID) REFERENCES DLTS_ACCOUNT(ID) ON DELETE SET NULL
)engine=innodb;


INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,
     REAL_NAME,BIRTHDATE,IDCARD_NO,GENDER,TELEPHONE,ZIPCODE)
VALUES('1',NULL,'admin1','F60598D5B3B5012DA811610A7D8CC0C1',1,'zhangsanfeng','19430225','410381194302256528','1',13669351234,'10000');

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,
REAL_NAME,BIRTHDATE,IDCARD_NO,GENDER,TELEPHONE,ZIPCODE)
VALUES('2',NULL,'admin2','F60598D5B3B5012DA811610A7D8CC0C1',1,'guojing','19690319','330682196903190613','1',13338924567,'10000');

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,
REAL_NAME,BIRTHDATE,IDCARD_NO,GENDER,TELEPHONE,ZIPCODE)
VALUES('3','2','admin3','F60598D5B3B5012DA811610A7D8CC0C1',1,'huangrong','19710827','330902197108270429','0',13637811357,'10000');

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,
REAL_NAME,BIRTHDATE,IDCARD_NO,GENDER,TELEPHONE,ZIPCODE)
VALUES('4','1','admin4','F60598D5B3B5012DA811610A7D8CC0C1',1,'zhangwuji','19890604','610121198906041115','1',13572952468,'10000');

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,
REAL_NAME,BIRTHDATE,IDCARD_NO,GENDER,TELEPHONE,ZIPCODE)
VALUES('5','3','admin5','F60598D5B3B5012DA811610A7D8CC0C1',1,'guofurong','20020101','350581200201010322','0',18617832562,'10000');

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,
REAL_NAME,BIRTHDATE,IDCARD_NO,GENDER,TELEPHONE,ZIPCODE)
VALUES('6','3','admin6','F60598D5B3B5012DA811610A7D8CC0C1',1,'luwushuang','19930731','320211199307310346','0',13186454984,'10000');

INSERT INTO DLTS_ACCOUNT(ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,
REAL_NAME,BIRTHDATE,IDCARD_NO,GENDER,TELEPHONE,ZIPCODE)
VALUES('7',NULL,'admin7','F60598D5B3B5012DA811610A7D8CC0C1',1,'weixiaobao','20001001','321022200010012115','1',13953410078,'10000');


=========================================================


--UNIX服务器信息表
CREATE TABLE DLTS_HOST(
	ID 		VARCHAR(32),
	HOST_IP VARCHAR(64),
	NAME 	VARCHAR(100), 
	LOCATION	VARCHAR(100),
 	CONSTRAINT DLTS_HOST_ID_PK PRIMARY KEY(ID)
)engine=innodb;

INSERT INTO DLTS_HOST VALUES ('1','127.0.0.1','administrator','zibo');

--业务信息表
CREATE TABLE DLTS_SERVICE(
	ID VARCHAR(32),
 	ACCOUNT_ID	VARCHAR(32) NOT NULL,
 	UNIX_HOST	VARCHAR(32) NOT NULL ,
 	OS_USERNAME	VARCHAR(50)	NOT NULL,
 	LOGIN_PASSWD VARCHAR(32) NOT NULL,
 	STATUS CHAR(1),	
 	CREATE_DATE	timestamp DEFAULT current_timestamp,
 	PAUSE_DATE	DATETIME,
 	CLOSE_DATE	DATETIME,
 	COST_ID VARCHAR(32) NOT NULL,
    CONSTRAINT DLTS_SERVICE_ID_PK PRIMARY KEY(ID),
    CONSTRAINT DLTS_SERVICE_DLTS_ACCOUNT_ID_FK FOREIGN KEY(ACCOUNT_ID) REFERENCES DLTS_ACCOUNT(ID) ,
    CONSTRAINT DLTS_SERVICE_UNIX_HOST_FK FOREIGN KEY(UNIX_HOST) REFERENCES DLTS_HOST(ID) ,
    CONSTRAINT DLTS_SERVICE_UNIXHOST_OSUSERNAME_UK UNIQUE(UNIX_HOST,OS_USERNAME),
    CONSTRAINT DLTS_SERVICE_COST_ID_FK FOREIGN KEY(COST_ID) REFERENCES  DLTS_COST(ID) 
)engine=innodb;


INSERT INTO DLTS_SERVICE(id,account_id,unix_host,os_username,login_passwd,status,cost_id) VALUES ('1','1','1','guojing','F60598D5B3B5012DA811610A7D8CC0C1',0,'1');

INSERT INTO DLTS_SERVICE(id,account_id,unix_host,os_username,login_passwd,status,cost_id) VALUES ('2','1','1','huangr','F60598D5B3B5012DA811610A7D8CC0C1',0,'1');

INSERT INTO DLTS_SERVICE(id,account_id,unix_host,os_username,login_passwd,status,cost_id) VALUES ('3','1','1','zhangwuji','F60598D5B3B5012DA811610A7D8CC0C1',0,'2');

INSERT INTO DLTS_SERVICE(id,account_id,unix_host,os_username,login_passwd,status,cost_id) VALUES ('4','2','1','zhangsanfeng','F60598D5B3B5012DA811610A7D8CC0C1',0,'2');

--业务资费更新备份表
CREATE TABLE DLTS_SERVICE_UPDATE_BAK(
 ID		VARCHAR(32) PRIMARY KEY,
 SERVICE_ID	VARCHAR(32) NOT NULL,
 COST_ID VARCHAR(32)  NOT NULL,
 CONSTRAINT DLTS_SERVICE_UPDATE_BAK_SERVICE_ID_FK FOREIGN KEY(SERVICE_ID) REFERENCES DLTS_SERVICE(ID),
 CONSTRAINT DLTS_SERVICE_UPDATE_BAK_COST_ID_FK FOREIGN KEY(COST_ID) REFERENCES DLTS_COST(ID) 
)engine=innodb;

select * from DLTS_SERVICE_UPDATE_BAK;


--时长信息表
CREATE TABLE DLTS_MONTH_DURATION
(SERVICE_ID varchar(32),
 MONTH_ID 	DATE,
 SERVICE_DETAIL_ID VARCHAR(32),
 SOFAR_DURATION	int,
 CONSTRAINT DLTS_MONTH_DURATION_PK PRIMARY KEY(SERVICE_ID,MONTH_ID),
 CONSTRAINT DLTS_MONTH_DURATION_SERVICE_ID_FK FOREIGN KEY(SERVICE_ID) REFERENCES DLTS_SERVICE(ID)
)engine=innodb;


 
--账单信息表
DROP TABLE BILL CASCADE CONSTRAINTS PURGE;
CREATE TABLE DLTS_BILL(
	ID VARCHAR(32) ,
    ACCOUNT_ID 	VARCHAR(32),
    BILL_MONTH 	DATE,
    COST FLOAT(13,2),
    PAYMENT_MODE CHAR(1),
    PAY_STATE	CHAR(1) DEFAULT 0, 
    CONSTRAINT DLTS_BILL_ID_PK  PRIMARY KEY(id),
	CONSTRAINT DLTS_BILL_ACCOUNT_ID FOREIGN KEY(ACCOUNT_ID) REFERENCES DLTS_ACCOUNT(ID) ON DELETE SET NULL
)ENGINE=INNODB;



--账单条目表
DROP TABLE BILL_ITEM CASCADE CONSTRAINTS PURGE;
CREATE TABLE DLTS_BILL_ITEM(
	ID		varchar(32),
 	BILL_ID varchar(32),
 	SERVICE_ID 	VARCHAR(32),
 	COST 		FLOAT(13,2),
 	CONSTRAINT DLTS_BILL_ITEM_ID_PK  PRIMARY KEY(ID),
 	CONSTRAINT DLTS_BILL_ITEM_SERVICE_ID_FK FOREIGN KEY(SERVICE_ID) REFERENCES DLTS_SERVICE(ID) ON DELETE SET NULL
 )ENGINE=INNODB;
 
 --用临时表技术生成账单编号表，用于保存BILL_ID(账单ID)，ACCOUNT_ID（帐务ID），BILL_MONTH（账单月）
CREATE GLOBAL TEMPORARY TABLE DLTS_BILL_CODE
(BILL_ID  		varchar(32),
 ACCOUNT_ID 	varchar(32),
 BILL_MONTH 	DATE
) On COMMIT PRESERVE ROWS;
 
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



select this_.id as id2_0_, this_.base_cost as base2_2_0_, this_.base_duration as base3_2_0_, this_.cost_type as cost4_2_0_, this_.creatime as creatime2_0_, this_.descr as descr2_0_, this_.name as name2_0_, this_.startime as startime2_0_, this_.status as status2_0_, this_.unit_cost as unit10_2_0_ from DLTS_COST this_ order by this_.base_cost asc, this_.creatime desc limit 3;

##开启event_scheduler
SET GLOBAL event_scheduler = 1;

CREATE EVENT e_dlts_cost_update_status ON SCHEDULE EVERY 1 HOUR  DO update biyesheji.dlts_cost set STATUS='0';
show events;
drop event e_every_1_month;
CREATE EVENT e_dlts_service_update_cost_id ON SCHEDULE EVERY 1 MINUTE  DO update biyesheji.dlts_service set cost_id='1' where id='40288a7d463d9f0f01463dd3151d0010';
CREATE EVENT e_dlts_service_update_cost_id ON SCHEDULE AT TIMESTAMP '2014-05-29 14:22:00'  DO update biyesheji.dlts_service as s join biyesheji.DLTS_SERVICE_UPDATE_BAK as b set s.cost_id=b.cost_id where s.id=b.service_id;

CREATE  EVENT e_every_1_month  ON SCHEDULE EVERY 1 MONTH STARTS DATE_ADD(DATE_ADD(DATE_SUB(CURDATE(),INTERVAL DAY(CURDATE())-1 DAY), INTERVAL 0 MONTH),INTERVAL 0 HOUR)  DO update biyesheji.dlts_service as s join biyesheji.DLTS_SERVICE_UPDATE_BAK as b set s.cost_id=b.cost_id where s.id=b.service_id;
CREATE EVENT e_dlt_bill_insert ON SCHEDULE AT TIMESTAMP '2014-05-29 14:22:00'  DO insert into  biyesheji.dlts_bill values( replace(uuid(),'-',''),) ;