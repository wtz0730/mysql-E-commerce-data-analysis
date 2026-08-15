select * from user_behavior where dates is null;
delete from user_behavior where dates is null;

select user_id,dates from temp_behavior group by user_id,dates;
-- 自关联
select * from (select user_id,dates from temp_behavior group by user_id,dates) a,(select user_id,dates from temp_behavior group by user_id,dates) b where a.user_id=b.user_id;

-- 筛选条件
select * from (select user_id,dates from temp_behavior group by user_id,dates) a,(select user_id,dates from temp_behavior group by user_id,dates) b where a.user_id<b.user_id;

-- 留存数
select a.dates,count(if(datediff(b.dates,a.dates)=1,b.user_id,null)) retention_1 from (select user_id,dates from temp_behavior group by user_id,dates) a,(select user_id,dates from user_behavior group by user_id,dates) b where a.user_id<=b.user_id group by a.dates;

select * from retention_rate;

-- 跳失率
-- 跳失用户 -- 88
select count(*)
from
(select user_id from user_behavior
group by user_id
having count(behavior_type)=1
) a;

select sum(pv) from pv_uv_puv; -- 89660670
