select categroy_id
,count(if(behavior_type='pv',behavior_type,null)) '品类浏览量'
from temp_behavior
group by category
order by 2 desc 
limit 10;

select item_id
,count(if(behavior_type='pv',behavior_type,null)) '商品浏览量'
from temp_behavior
group by item_id
order by 2 desc 
limit 10;

select category_id,item_id,品类商品浏览量 from
(
select category_id,item_id
,count(if(behavior_type='pv',behavior_type,null)) '品类商品浏览量'
,rank()over(partition by category_id order by '品类商品浏览量' desc) r
from temp_behavior
group by category_id,item_id
order by 3 desc 
) a
where a.r = 1
order by a.品类商品浏览量 desc
limit 10;

create table popula_categories(
category_id int,
pv int);
create table popula_items(
item_id int,
pv int);
create table popula_cateitems(
category_id int,
pv int);

insert into popular_categories
select categroy_id
,count(if(behavior_type='pv',behavior_type,null)) '品类浏览量'
from user_behavior
group by category_id
order by 2 desc 
limit 10;

insert into popular_items
select item_id
,count(if(behavior_type='pv',behavior_type,null)) '商品浏览量'
from user_behavior
group by item_id
order by 2 desc 
limit 10;

insert into popular_cateitems
select category_id,item_id,品类商品浏览量 from
(
select category_id,item_id
,count(if(behavior_type='pv',behavior_type,null)) '品类商品浏览量'
,rank()over(partition by category_id order by '品类商品浏览量' desc) r
from user_behavior
group by category_id,item_id
order by 3 desc 
) a
where r = 1
order by a.品类商品浏览量 desc
limit 10;

create table popula_categories(
category_id int,
pv int);
create table popula_items(
item_id int,
pv int);
create table popula_cateitems(
category_id int,
pv int);

select * from popular_items,popular_categories