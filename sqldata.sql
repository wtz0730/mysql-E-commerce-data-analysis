use ship;

-- 检查空值
SELECT COUNT(*) AS user_id_null FROM user_behavior WHERE user_id IS NULL;
SELECT COUNT(*) AS item_id_null FROM user_behavior WHERE item_id IS NULL;
SELECT COUNT(*) AS category_id_null FROM user_behavior WHERE category_id IS NULL;
SELECT COUNT(*) AS behavior_type_null FROM user_behavior WHERE behavior_type IS NULL;
SELECT COUNT(*) AS ts_null FROM user_behavior WHERE timestamps IS NULL;

-- 检查重复值
select user_id,item_id,timestamps from user_behavior
group by user_id,item_id,timestamps having count(*)>1;

-- 去重
alter table user_behavior add id int first;
select * from user_behavior limit 5;
alter table user_behavior modify id int primary key auto_increment;

SET SQL_SAFE_UPDATES = 0;
DELETE user_behavior
FROM user_behavior
INNER JOIN (
    SELECT user_id,item_id,timestamps, MIN(id) AS min_id
    FROM user_behavior
    GROUP BY user_id,item_id,timestamps
    HAVING COUNT(*) > 1
) t2
ON  user_behavior.user_id = t2.user_id
AND user_behavior.item_id = t2.item_id
AND user_behavior.timestamps = t2.timestamps
WHERE user_behavior.id > t2.min_id;

SET SQL_SAFE_UPDATES = 1;

-- 新增日期：date time hour
-- 更改buffer值
show VARIABLES like '%_buffer%';
set GLOBAL innodb_buffer_pool_size=10700000000;
-- datetime
alter table user_behavior add datetimes TIMESTAMP(0);
SET SQL_SAFE_UPDATES = 0;
update user_behavior set datetimes=FROM_UNIXTIME(timestamps);
select * from user_behavior limit 5;
-- date
alter table user_behavior add dates char(10);
alter table user_behavior add dates char(8);
alter table user_behavior add dates char(2);
update user_behavior set dates=substring(datetimes,1,10);
update user_behavior set dates=substring(datetimes,12,8);
update user_behavior set dates=substring(datetimes,12,2);
select * from user_behavior limit 5;
SET SQL_SAFE_UPDATES = 1; 

-- 去异常
SET SQL_SAFE_UPDATES = 0;
select max(datetimes),min(datetimes) from user_behavior;
delete from user_behavior
where datetimes < '2017-11-25 00:00:00' or datetimes >'2017-12-03 23:59:59';
SET SQL_SAFE_UPDATES = 1;

desc user_behavior;
select * from user_behavior limit 5;
select count(1) from user_behavior;


