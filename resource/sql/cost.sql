--资费表   
--id:资费id  name：资费名称   base_duration:包在线时长  base_cost:月固定费用  unit_cost:单位费用
--status:0：开通  1：暂停  2:表示删除  descr：资费信息说明  creatime:创建时间  startime：启用时间 
--cost_type 1表示包月,2表示套餐,3表示计时
    CREATE TABLE DLTS_COST(
    ID number(4) CONSTRAINT DLTS_COST_ID_PK PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    BASE_DURATION number(11),
    BASE_COST number(7,2),
    UNIT_COST number(7,4),
    STATUS CHAR(1) CONSTRAINT DLTS_COST_STATUS_CK
    CHECK (STATUS IN (0,1,2)),
    DESCR VARCHAR2(100),
    CREATIME DATE DEFAULT SYSDATE ,
    STARTIME DATE,
    COST_TYPE CHAR(1),
    );
    --创建一个序列用于资费表插入时的id
CREATE SEQUENCE dlts_cost_id;
INSERT INTO dlts_cost VALUES (dlts_cost_id.nextval,'5.9元套餐',20,5.9,0.4,0,'5.9元20小时/月,超出部分0.4元/时',DEFAULT,sysdate,'2');
INSERT INTO dlts_cost VALUES (dlts_cost_id.nextval,'6.9元套餐',40,6.9,0.3,0,'6.9元40小时/月,超出部分0.3元/时',DEFAULT,sysdate,'2');
INSERT INTO dlts_cost VALUES (dlts_cost_id.nextval,'8.5元套餐',100,8.5,0.2,0,'8.5元100小时/月,超出部分0.2元/时',DEFAULT,sysdate,'2');
INSERT INTO dlts_cost VALUES (dlts_cost_id.nextval,'10.5元套餐',200,10.5,0.1,0,'10.5元200小时/月,超出部分0.1元/时',DEFAULT,sysdate,'3');
INSERT INTO dlts_cost VALUES (dlts_cost_id.nextval,'计时收费',null,null,0.5,0,'0.5元/时,不使用不收费',DEFAULT,sysdate,'1');
INSERT INTO dlts_cost VALUES (dlts_cost_id.nextval,'包月',null,20,null,0,'每月20元,不限制使用时间',DEFAULT,sysdate,'1');
   --INSERT INTO dlts_cost VALUES (7,'包年',null,20,null,1,'每月20元,不限制使用时间',DEFAULT,sysdate,'1');
select * from dlts_cost;   
update dlts_cost set status=1 where id=9;
select ID, NAME, BASE_DURATION, BASE_COST, UNIT_COST, CREATIME, 
STARTIME, STATUS, DESCR from (select rownum r, ID, NAME, BASE_DURATION, 
BASE_COST, UNIT_COST, CREATIME, STARTIME, STATUS, DESCR from DLTS_COST 
where rownum < 4) a where a.r > 1;
delete from dlts_cost where name='456';


select * from (select rownum rn,id,name,
					base_duration,base_cost,unit_cost,status,descr,creatime,startime 
					from (select id,name,
					base_duration,base_cost,unit_cost,status,descr,creatime,startime 
					from dlts_cost order by nvl(base_duration,0) desc) where rownum<=3) where rn>=1