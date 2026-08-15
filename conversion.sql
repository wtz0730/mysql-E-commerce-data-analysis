-- 统计各类行为用户数
select behavior_type,count(distinct user_id) user_num from temp_behavior
group by beavior_type order by behavior_type desc;

-- 存储
create table behavior_user_num(
behavior_type varchar(5),
user_num int);

insert into behavior_user_num
select behavior_type,count(distinct user_id) user_num from user_behavior
group by beavior_type order by behavior_type desc;

select * from behavior_user_num;
-- 672404/984105

-- 统计各类行为的数量
select behavior_type,count(*) user_num from temp_behavior
group by beavior_type order by behavior_type desc;

create table behavior_num(
behavior_type varchar(5),
behavior_count_num int);

insert into behavior_num
select behavior_type,count(*) behavior_count_num from user_behavior
group by beavior_type order by behavior_type desc;

select * from behavior_num;
-- 2015807/89660670

