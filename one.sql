-- table creation ==============================================
create table supplier
(
    s_id   serial primary key,
    s_name varchar(30),
    s_city varchar(30)
);

create table product
(
    p_id         serial primary key,
    p_name       varchar(30) not null,
    p_color      varchar(30),
    p_unit_price decimal
);

create table delivery
(
    -- assumings that supplier can deliver product only once
    s_id       serial,
    p_id       serial,
    d_quantity decimal,
    foreign key (s_id) references supplier (s_id),
    foreign key (p_id) references product (p_id),
    primary key (s_id, p_id)
);

SELECT *
FROM information_schema.tables
WHERE table_schema = 'public';

-- populate data ==============================================
insert into supplier (s_name, s_city)
VALUES ('Yossi Kohen', 'HA'),
       ('maya Levi', 'BS'),
       ('Aharon Biton', 'TA'),
       ('Batiay Katz', 'AD');


insert into product (p_name, p_color, p_unit_price)
VALUES ('chair', 'black', 12.50),
       ('table', 'wood', 30.20),
       ('lamp', 'white', 13.50),
       ('notebook', 'red', 40),
       ('shoes', 'red', 40.10);

insert into delivery (s_id, p_id, d_quantity)
values (1, 1, 320),
       (1, 2, 200),
       (2, 4, 100),
       (2, 3, 250);


-- Question and answers ===================================

select p_name, p_color, p_unit_price, s_name
from delivery,
     product,
     supplier
where delivery.p_id = product.p_id
  and supplier.s_id = delivery.s_id;


-- sum of red items
select *
from product;
select count(*) as items_amount
from product
where p_color = 'red';

-- must have privileges
ALTER DATABASE mmn11 SET datestyle TO 'ISO, DMY';
select current_date;

-- find all supplier name and quantity , that provide product 'notebook'
select supplier.s_name, d_quantity
from supplier,
     delivery,
     product
where product.p_name = 'notebook'
  and product.p_id = delivery.p_id
  and delivery.s_id = supplier.s_id;


-- find for all suppliers what is the tot price for the delivery for all his goods
select product.p_id, (product.p_unit_price * delivery.d_quantity) as tot_price, s_id as suplier_id
from delivery,
     product
where delivery.p_id = product.p_id;

select *, (d_quantity * product.p_unit_price) as tot_price
from delivery
         natural join product;

-- how many supplier earns for all his deliveries
select sum((d_quantity * product.p_unit_price)) as tot_sum, s_id
from delivery
         natural join product
group by s_id;

-- look for the delivery that tot price is > 1000
-- order of supplier id and price of delivery in descending order
select *
from product p,
     delivery d
where p.p_id = d.p_id
  and (d_quantity * p.p_unit_price) > 1000
order by d.s_id, (d_quantity * p.p_unit_price) desc;

-- get all product that have at least 5 chars at name
select *
from product
where product.p_name like '_____%';
select *
from product;

-- get name that not bigger than 4
select *
from product
where not (p_name like '_____%');


-- find all products that have 2 or more colors
select distinct p2.p_name
from product p1,
     product p2
where p1.p_id <> p2.p_id
  and p1.p_name = p2.p_name
  and p1.p_color <> p2.p_color;