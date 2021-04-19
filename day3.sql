-- musician tables

SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog'
  AND schemaname != 'information_schema';


create table agent
(
    aname   varchar(30) primary key,
    address varchar(100)
);

create table musician
-- all musicians must have an agent
(
    mid        serial primary key,
    mname      varchar(30),
    aname      varchar(30),
    percentage decimal,
    foreign key (aname) references agent (aname)
);

create table instrumentalist
(
    instrument varchar(30),
    mid        serial,
    foreign key (mid) references musician (mid),
    primary key (mid, instrument)
);

create table singer
(
    mid    serial primary key,
    gender varchar(10),
    foreign key (mid) references musician (mid)
);

create table festival
(
    title      varchar(40) primary key,
    place      varchar(40),
    start_date date,
    end_date   date
);

create table events
(
    title varchar(40) primary key,
    date  date,
    time  time
);

create table booked
(
    mid    serial,
    title  varchar(40),
    date   date,
    time   time,
    salary decimal,
    primary key (mid, title, date, time),
    foreign key (mid) references musician (mid)

);

-- population
insert into events (title, date, time) VALUES ('testEvent', '1/18/1999', '04:05');
insert into agent (aname, address) VALUES ('name', 'address');


copy agent from '/tmp/pgcsv/MOCK_DATA.csv' with (format csv); -- ant1 have no permissions Fedora





-- questions

-- find title from last festival that ws at 2019




