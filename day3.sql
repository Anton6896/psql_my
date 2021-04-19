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
    -- (many to many)
    title varchar(40),
    date  date,
    time  time,
    primary key (title, date, time),
    foreign key (title) references festival (title)
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

-- population  ====================================================================
insert into events (title, date, time)
VALUES ('testEvent', '1/18/1999', '04:05');
insert into agent (aname, address)
VALUES ('name', 'address');


copy agent from '/tmp/pgcsv/MOCK_DATA.csv' with (format csv);
-- ant1 have no permissions on Fedora (i cant populate this now)


-- questions ================================================================

-- find title from LAST festival that was at 2019
select title
from festival
where date_part('year', start_date) = 2019
   or date_part('year', end_date) = 2019
    and end_date >= all -- look for the last one that was at 2019
        (
            -- return all festival dates from 2029 (or mentioned 2019 )
            select end_date
            from festival
            where date_part('year', start_date) = 2019
               or date_part('year', end_date) = 2019
        );

-- find festival with one event only
select *
from festival f
         join events e on f.title = e.title
where not exists
    (
    -- same festival but different date or time
        select title
        from events
        where title = f.title
            and date <> e.date
           or time <> e.time
    );

-- look for the number of events for ech festival
select title, count(*) total_events
from events
group by title;