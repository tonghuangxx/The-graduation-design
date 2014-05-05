--id:主键    admin_code:管理员帐号   password:密码    name:姓名  
--telephone:电话   email:邮件  enrolldate:创建日期
CREATE TABLE DLTS_ADMIN_INFO(
	ID NUMBER(11) CONSTRAINT DLTS_ADMIN_INFO_ID_PK PRIMARY KEY,
	ADMIN_CODE VARCHAR2(30) UNIQUE　NOT NULL,	
	PASSWORD VARCHAR2(30) NOT NULL,
	NAME VARCHAR2(30) NOT NULL,
	TELEPHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	ENROLLDATE DATE NOT NULL
);
--创建用户表的主键序号
create sequence dlts_admin_info_id;
insert into dlts_admin_info values(dlts_admin_info_id.nextval,'dlts','dlts','cwb','13688997766',
		'shiyl@sin.com',to_date('2013-05-22','yyyy-mm-dd'));
insert into dlts_admin_info values(dlts_admin_info_id.nextval,'admin','111111','lily','13688997766','shiyl@sin.com'
   ,to_date('2013-05-22','yyyy-mm-dd'));
insert into dlts_admin_info values(dlts_admin_info_id.nextval,'tom123','1234','tom','13688997766','shiyl@sin.com'
   ,to_date('2013-05-22','yyyy-mm-dd'));
   insert into dlts_admin_info values(dlts_admin_info_id.nextval,'lbwn','1234','lb','13688997766','shiyl@sin.com'
   ,to_date('2013-05-22','yyyy-mm-dd'));

--角色表
CREATE TABLE DLTS_ROLE(
	id number(11) primary key,
	role_name varchar(30) not null
);
--创建角色表的主键序号
CREATE SEQUENCE dlts_role_id;

insert into dlts_role values(dlts_role_id.nextval,'超级管理');
insert into dlts_role values(dlts_role_id.nextval,'角色管理');
insert into dlts_role values(dlts_role_id.nextval,'资费管理');
insert into dlts_role values(dlts_role_id.nextval,'帐务管理');
insert into dlts_role values(dlts_role_id.nextval,'业务管理');
insert into dlts_role values(dlts_role_id.nextval,'账单管理');
insert into dlts_role values(dlts_role_id.nextval,'报表管理');
insert into dlts_role values(dlts_role_id.nextval,'管理员管理');
--用户角色关系表
CREATE TABLE dlts_user_role(
  id number(11) PRIMARY KEY,
  usid number(11),
  rid number(11),
  CONSTRAINT dlts_user_role_usid_fk FOREIGN KEY(usid) REFERENCES dlts_admin_info(id),
  CONSTRAINT dlts_user_role_tid_fk FOREIGN KEY(rid) REFERENCES dlts_role(id)
  );
 --创建用户角色关系表的主键序号
create sequence dlts_user_role_id;

--给一号管理员添加数据
insert into dlts_user_role values(dlts_user_role_id.nextval,1,1);
insert into dlts_user_role values(dlts_user_role_id.nextval,1,2);
insert into dlts_user_role values(dlts_user_role_id.nextval,1,3);
insert into dlts_user_role values(dlts_user_role_id.nextval,1,4);
insert into dlts_user_role values(dlts_user_role_id.nextval,1,5);
insert into dlts_user_role values(dlts_user_role_id.nextval,1,6);
insert into dlts_user_role values(dlts_user_role_id.nextval,1,7);
insert into dlts_user_role values(dlts_user_role_id.nextval,1,8);
--给二号管理员添加数据
insert into dlts_user_role values(dlts_user_role_id.nextval,2,8);
--给三号管理员添加数据
insert into dlts_user_role values(dlts_user_role_id.nextval,3,8);
--给四号管理员添加数据
insert into dlts_user_role values(dlts_user_role_id.nextval,4,8);


--模块表
CREATE TABLE dlts_module(
	id number(11) primary key,
	module_name varchar(20) not null
);
create sequence dlts_module_id;
insert into dlts_module values(dlts_module_id.nextval,'角色');
insert into dlts_module values(dlts_module_id.nextval,'资费');
insert into dlts_module values(dlts_module_id.nextval,'帐务');
insert into dlts_module values(dlts_module_id.nextval,'业务');
insert into dlts_module values(dlts_module_id.nextval,'账单');
insert into dlts_module values(dlts_module_id.nextval,'报表');
insert into dlts_module values(dlts_module_id.nextval,'管理');

--访问控制表
create table dlts_acl(
		id number(10) PRIMARY KEY,
   rid number(10),
   mid number(10),
   c  number(2) not null,
   r number(2) not null,
   u number(2) not null,
   d number(2) not null,
   CONSTRAINT dlts_acl_rid_fk FOREIGN KEY(rid) REFERENCES dlts_role(id),
   CONSTRAINT dlts_acl_mid_fk FOREIGN KEY(mid) REFERENCES dlts_module(id)
);
create sequence dlts_acl_id;
--角色管理对模块的权限
----------------------------------------------------c-r-u-d
insert into dlts_acl values(dlts_acl_id.nextval,2,1,1,1,1,1);
insert into dlts_acl values(dlts_acl_id.nextval,2,2,0,1,0,0);
insert into dlts_acl values(dlts_acl_id.nextval,2,3,0,1,0,0);
insert into dlts_acl values(dlts_acl_id.nextval,2,4,0,1,0,0);
insert into dlts_acl values(dlts_acl_id.nextval,2,5,0,1,0,0);
insert into dlts_acl values(dlts_acl_id.nextval,2,6,0,1,0,0);
insert into dlts_acl values(dlts_acl_id.nextval,2,7,0,1,0,0);
--超级管理员对模块的权限
insert into dlts_acl values(dlts_acl_id.nextval,1,1,1,1,1,1);
insert into dlts_acl values(dlts_acl_id.nextval,1,2,1,1,1,1);
insert into dlts_acl values(dlts_acl_id.nextval,1,3,1,1,1,1);
insert into dlts_acl values(dlts_acl_id.nextval,1,4,1,1,1,1);
insert into dlts_acl values(dlts_acl_id.nextval,1,5,1,1,1,1);
insert into dlts_acl values(dlts_acl_id.nextval,1,6,1,1,1,1);
insert into dlts_acl values(dlts_acl_id.nextval,1,7,1,1,1,1);
--管理员管理对模块的权限
insert into dlts_acl values(dlts_acl_id.nextval,8,1,0,1,0,0);
insert into dlts_acl values(dlts_acl_id.nextval,8,2,0,1,0,0);
insert into dlts_acl values(dlts_acl_id.nextval,8,3,0,1,0,0);
insert into dlts_acl values(dlts_acl_id.nextval,8,4,0,1,0,0);
insert into dlts_acl values(dlts_acl_id.nextval,8,5,0,1,0,0);
insert into dlts_acl values(dlts_acl_id.nextval,8,6,0,1,0,0);
insert into dlts_acl values(dlts_acl_id.nextval,8,7,0,1,0,0);

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


