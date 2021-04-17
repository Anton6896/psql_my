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

insert into delivery
values (1, 1, 320),
       (1, 2, 200),
       (2, 4, 100),
       (2, 3, 250);



-- Question and answers ===================================

select p_name, p_color, p_unit_price, s_name
from delivery,
     product,
     supplier
where delivery.p_id = product.p_id and supplier.s_id=delivery.s_id;

