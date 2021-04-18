select *
from supplier;
select *
from delivery;
select *
from product;

-- what amount of products deliver supplier 1
select count(*) as sp1qty
from delivery
where s_id = 1;

-- what amount of different products was delivered
select count(distinct p_id) as dif_products
from delivery;



-- inner queries ===========================================================


-- get the max amount of deliver for supplier
select d1.s_id, d1.d_quantity as max_q -- select data from the line that 'where' is return
from delivery d1
-- magic word 'all' -> will go thru the all data and compare
-- 'where' will go line by line
where d1.d_quantity >= all -- d_quantity > {....} ? x : y
      (
          select d2.d_quantity -- return {100, 23, 415, etc.}
          from delivery d2
          where d1.s_id = d2.s_id
      )
order by d1.s_id;


select s_id, max(d_quantity) as maxq
from delivery
group by s_id
order by s_id;

-- get supplier id that deliver green product at range 50 - 100
select s_id
from delivery
where d_quantity between 50 and 100
  and p_id in
      (
          select p_id
          from product
          where p_color = 'green'
      );