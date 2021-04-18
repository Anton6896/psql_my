select *
from supplier;
select *
from delivery;

-- what amount of products deliver supplier 1
select count(*) as sp1qty
from delivery
where s_id = 1;

-- what amount of different products was delivered
select count(distinct p_id) as dif_products
from delivery;



-- inner queries ===========================================================

-- get the max amount of deliver for supplier
select d1.s_id, d1.d_quantity as max_q
from delivery d1
-- magic word 'all'
where d1.d_quantity >= all
      (
          select d2.d_quantity
          from delivery d2
          where d1.s_id = d2.s_id
      );