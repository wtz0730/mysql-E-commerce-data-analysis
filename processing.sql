-- 创建临时表
create table temp_behavior like user_behavior;

-- 截取
insert into temp_behavior
select * from user_behavior limit 100000;

select * from temp_behavior;

-- pv 
select dates,count(distinct user_id) 'pv' from temp_behavior where behavior_type='pv' group by dates;

-- 一条语句
select dates,count(*) 'pv',count(distinct user_id) 'uv',round(count(*)/count(distinct user_id),1) 'pv/uv' from temp_behavior where behavior_type='pv' group by dates;

-- 处理真实数据 
create table pv_uv_puv(dates char(10),pv int(9),uv int(9),puv decimal(10,1));
insert into pv_uv_puv
select dates,count(*) 'pv',count(distinct user_id) 'uv',round(count(*)/count(distinct user_id),1) 'pv/uv' from user_behavior where behavior_type='pv' group by dates;

select * from pv_uv_puv;
delete from pu_uv_puv where dates is null;
