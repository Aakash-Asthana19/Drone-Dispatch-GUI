-- CS4400: Introduction to Database Systems (Spring 2024)
-- Phase III: Stored Procedures & Views [v1] Wednesday, March 27, 2024 @ 5:20pm EST


-- Team 33
-- Rudra Amin (ramin45)
-- Aakash Asthana (aasthana34)
-- Fevin Felix (ffelix6)
-- Harsh Munagekar (hmunagekar3)
-- Steve George (sgeorge78)

-- Directions:
-- Please follow all instructions for Phase III as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from an SQL Dump file.
-- This file must run without error for credit.

/* This is a standard preamble for most of our scripts.  The intent is to establish
a consistent environment for the database behavior. */
set global transaction isolation level serializable;
set global SQL_MODE = 'ANSI,TRADITIONAL';
set names utf8mb4;
set SQL_SAFE_UPDATES = 0;

set @thisDatabase = 'drone_dispatch';
drop database if exists drone_dispatch;
create database if not exists drone_dispatch;
use drone_dispatch;

-- -----------------------------------------------
-- table structures
-- -----------------------------------------------

create table users (
uname varchar(40) not null,
first_name varchar(100) not null,
last_name varchar(100) not null,
address varchar(500) not null,
birthdate date default null,
primary key (uname)
) engine = innodb;

create table customers (
uname varchar(40) not null,
rating integer not null,
credit integer not null,
primary key (uname)
) engine = innodb;

create table employees (
uname varchar(40) not null,
taxID varchar(40) not null,
service integer not null,
salary integer not null,
primary key (uname),
unique key (taxID)
) engine = innodb;

create table drone_pilots (
uname varchar(40) not null,
licenseID varchar(40) not null,
experience integer not null,
primary key (uname),
unique key (licenseID)
) engine = innodb;

create table store_workers (
uname varchar(40) not null,
primary key (uname)
) engine = innodb;

create table products (
barcode varchar(40) not null,
pname varchar(100) not null,
weight integer not null,
primary key (barcode)
) engine = innodb;

create table orders (
orderID varchar(40) not null,
sold_on date not null,
purchased_by varchar(40) not null,
carrier_store varchar(40) not null,
carrier_tag integer not null,
primary key (orderID)
) engine = innodb;

create table stores (
storeID varchar(40) not null,
sname varchar(100) not null,
revenue integer not null,
manager varchar(40) not null,
primary key (storeID)
) engine = innodb;

create table drones (
storeID varchar(40) not null,
droneTag integer not null,
capacity integer not null,
remaining_trips integer not null,
pilot varchar(40) not null,
primary key (storeID, droneTag)
) engine = innodb;

create table order_lines (
orderID varchar(40) not null,
barcode varchar(40) not null,
price integer not null,
quantity integer not null,
primary key (orderID, barcode)
) engine = innodb;

create table employed_workers (
storeID varchar(40) not null,
uname varchar(40) not null,
primary key (storeID, uname)
) engine = innodb;

-- -----------------------------------------------
-- referential structures
-- -----------------------------------------------

alter table customers add constraint fk1 foreign key (uname) references users (uname)
	on update cascade on delete cascade;
alter table employees add constraint fk2 foreign key (uname) references users (uname)
	on update cascade on delete cascade;
alter table drone_pilots add constraint fk3 foreign key (uname) references employees (uname)
	on update cascade on delete cascade;
alter table store_workers add constraint fk4 foreign key (uname) references employees (uname)
	on update cascade on delete cascade;
alter table orders add constraint fk8 foreign key (purchased_by) references customers (uname)
	on update cascade on delete cascade;
alter table orders add constraint fk9 foreign key (carrier_store, carrier_tag) references drones (storeID, droneTag)
	on update cascade on delete cascade;
alter table stores add constraint fk11 foreign key (manager) references store_workers (uname)
	on update cascade on delete cascade;
alter table drones add constraint fk5 foreign key (storeID) references stores (storeID)
	on update cascade on delete cascade;
alter table drones add constraint fk10 foreign key (pilot) references drone_pilots (uname)
	on update cascade on delete cascade;
alter table order_lines add constraint fk6 foreign key (orderID) references orders (orderID)
	on update cascade on delete cascade;
alter table order_lines add constraint fk7 foreign key (barcode) references products (barcode)
	on update cascade on delete cascade;
alter table employed_workers add constraint fk12 foreign key (storeID) references stores (storeID)
	on update cascade on delete cascade;
alter table employed_workers add constraint fk13 foreign key (uname) references store_workers (uname)
	on update cascade on delete cascade;

-- -----------------------------------------------
-- table data
-- -----------------------------------------------

insert into users values
('jstone5', 'Jared', 'Stone', '101 Five Finger Way', '1961-01-06'),
('sprince6', 'Sarah', 'Prince', '22 Peachtree Street', '1968-06-15'),
('awilson5', 'Aaron', 'Wilson', '220 Peachtree Street', '1963-11-11'),
('lrodriguez5', 'Lina', 'Rodriguez', '360 Corkscrew Circle', '1975-04-02'),
('tmccall5', 'Trey', 'McCall', '360 Corkscrew Circle', '1973-03-19'),
('eross10', 'Erica', 'Ross', '22 Peachtree Street', '1975-04-02'),
('hstark16', 'Harmon', 'Stark', '53 Tanker Top Lane', '1971-10-27'),
('echarles19', 'Ella', 'Charles', '22 Peachtree Street', '1974-05-06'),
('csoares8', 'Claire', 'Soares', '706 Living Stone Way', '1965-09-03'),
('agarcia7', 'Alejandro', 'Garcia', '710 Living Water Drive', '1966-10-29'),
('bsummers4', 'Brie', 'Summers', '5105 Dragon Star Circle', '1976-02-09'),
('cjordan5', 'Clark', 'Jordan', '77 Infinite Stars Road', '1966-06-05'),
('fprefontaine6', 'Ford', 'Prefontaine', '10 Hitch Hikers Lane', '1961-01-28');

insert into customers values
('jstone5', 4, 40),
('sprince6', 5, 30),
('awilson5', 2, 100),
('lrodriguez5', 4, 60),
('bsummers4', 3, 110),
('cjordan5', 3, 50);

insert into employees values
('awilson5', '111-11-1111', 9, 46000),
('lrodriguez5', '222-22-2222', 20, 58000),
('tmccall5', '333-33-3333', 29, 33000),
('eross10', '444-44-4444', 10, 61000),
('hstark16', '555-55-5555', 20, 59000),
('echarles19', '777-77-7777', 3, 27000),
('csoares8', '888-88-8888', 26, 57000),
('agarcia7', '999-99-9999', 24, 41000),
('bsummers4', '000-00-0000', 17, 35000),
('fprefontaine6', '121-21-2121', 5, 20000);

insert into store_workers values
('eross10'),
('hstark16'),
('echarles19');

insert into stores values
('pub', 'Publix', 200, 'hstark16'),
('krg', 'Kroger', 300, 'echarles19');

insert into employed_workers values
('pub', 'eross10'),
('pub', 'hstark16'),
('krg', 'eross10'),
('krg', 'echarles19');

insert into drone_pilots values
('awilson5', '314159', 41),
('lrodriguez5', '287182', 67),
('tmccall5', '181633', 10),
('agarcia7', '610623', 38),
('bsummers4', '411911', 35),
('fprefontaine6', '657483', 2);

insert into drones values
('pub', 1, 10, 3, 'awilson5'),
('pub', 2, 20, 2, 'lrodriguez5'),
('krg', 1, 15, 4, 'tmccall5'),
('pub', 9, 45, 1, 'fprefontaine6');

insert into products values
('pr_3C6A9R', 'pot roast', 6),
('ss_2D4E6L', 'shrimp salad', 3),
('hs_5E7L23M', 'hoagie sandwich', 3),
('clc_4T9U25X', 'chocolate lava cake', 5),
('ap_9T25E36L', 'antipasto platter', 4);

insert into orders values
('pub_303', '2024-05-23', 'sprince6', 'pub', 1),
('pub_305', '2024-05-22', 'sprince6', 'pub', 2),
('krg_217', '2024-05-23', 'jstone5', 'krg', 1),
('pub_306', '2024-05-22', 'awilson5', 'pub', 2);

insert into order_lines values
('pub_303', 'pr_3C6A9R', 20, 1),
('pub_303', 'ap_9T25E36L', 4, 1),
('pub_305', 'clc_4T9U25X', 3, 2),
('pub_306', 'hs_5E7L23M', 3, 2),
('pub_306', 'ap_9T25E36L', 10, 1),
('krg_217', 'pr_3C6A9R', 15, 2);

-- -----------------------------------------------
-- stored procedures and views
-- -----------------------------------------------

-- add customer
delimiter // 
create procedure add_customer
	(in ip_uname varchar(40), in ip_first_name varchar(100),
	in ip_last_name varchar(100), in ip_address varchar(500),
    in ip_birthdate date, in ip_rating integer, in ip_credit integer)
sp_main: begin
	IF (ip_uname is NULL or ip_first_name is NULL or ip_last_name is NULL or ip_address is NULL or ip_birthdate is NULL or ip_rating IS NULL or ip_credit is NULL) then 
		leave sp_main;
	END IF;
	IF (select count(*) from customers where uname like ip_uname) = 0 THEN
		INSERT into users values
        (ip_uname, ip_first_name, ip_last_name, ip_address, ip_birthdate);
		INSERT into customers values
        (ip_uname, ip_rating, ip_credit);
	END IF;
end //
delimiter ;

DELIMITER //
CREATE PROCEDURE add_drone_pilot
    (IN ip_uname VARCHAR(40), IN ip_first_name VARCHAR(100),
    IN ip_last_name VARCHAR(100), IN ip_address VARCHAR(500),
    IN ip_birthdate DATE, IN ip_taxID VARCHAR(40), IN ip_service INTEGER, 
    IN ip_salary INTEGER, IN ip_licenseID VARCHAR(40),
    IN ip_experience INTEGER)
sp_main: BEGIN
    DECLARE unameExists INT;
    DECLARE taxIDExists INT;
    DECLARE licenseIDExists INT;

    SELECT COUNT(*) INTO unameExists FROM users WHERE uname = ip_uname;
    SELECT COUNT(*) INTO taxIDExists FROM employees WHERE taxID = ip_taxID;
    SELECT COUNT(*) INTO licenseIDExists FROM drone_pilots WHERE licenseID = ip_licenseID;

    IF unameExists > 0 OR taxIDExists > 0 OR licenseIDExists > 0 THEN
        SELECT 'Duplicate username, tax ID, or license ID exists.' AS message;
    ELSE
        INSERT INTO users VALUES (ip_uname, ip_first_name, ip_last_name, ip_address, ip_birthdate);
        INSERT INTO employees VALUES (ip_uname, ip_taxID, ip_service, ip_salary);
        INSERT INTO drone_pilots VALUES (ip_uname, ip_licenseID, ip_experience);
        IF ROW_COUNT() > 0 THEN
            SELECT 'Pilot added successfully.' AS message;
        ELSE
            SELECT 'Failed to add pilot.' AS message;
        END IF;
    END IF;
END //
DELIMITER ;


-- add product
delimiter // 
create procedure add_product
	(in ip_barcode varchar(40), in ip_pname varchar(100),
    in ip_weight integer)
sp_main: begin
	-- place your solution here
	IF ip_barcode is NULL or ip_pname is NULL or ip_weight is NULL then
		leave sp_main;
	END IF;
    IF ip_barcode NOT IN (select barcode from products) THEN
		INSERT into products values 
        (ip_barcode, ip_pname, ip_weight);
	END IF;
end //
delimiter ;

-- add drone
delimiter // 
create procedure add_drone
	(in ip_storeID varchar(40), in ip_droneTag integer,
    in ip_capacity integer, in ip_remaining_trips integer,
    in ip_pilot varchar(40))
sp_main: begin
    declare store_exists int;
    declare pilot_assigned int;
    
	IF (ip_storeID is NULL or ip_droneTag is NULL or ip_capacity is NULL or ip_remaining_trips is NULL or ip_pilot is NULL) then 
		leave sp_main;
	END IF;
    
    select count(*) into store_exists from stores where storeID = ip_storeID;
    select count(*) into pilot_assigned from drones where pilot = ip_pilot;
    
    if store_exists = 1 and pilot_assigned = 0 then
        if ((select count(*) from drones where storeID = ip_storeID and droneTag = ip_droneTag) = 0) then
            insert into drones values (ip_storeID, ip_droneTag, ip_capacity, ip_remaining_trips, ip_pilot);
        end if;
    end if;
end //
delimiter ;


-- increase customer credits
delimiter // 
create procedure increase_customer_credits
	(in ip_uname varchar(40), in ip_money integer)
sp_main: begin
	-- place your solution here
    if (ip_uname is NULL or ip_money is NULL or ip_money < 0) then 
		leave sp_main;
	end if;
	update customers 
    set credit = credit + ip_money 
    where uname like ip_uname;
end //
delimiter ;

-- swap drone control
DELIMITER //
CREATE PROCEDURE swap_drone_control
    (IN ip_incoming_pilot VARCHAR(40), IN ip_outgoing_pilot VARCHAR(40))
BEGIN
    DECLARE validIncoming INT;
    DECLARE incomingNoDrone INT;
    DECLARE outgoingHasDrone INT;

    IF ip_incoming_pilot IS NULL OR ip_outgoing_pilot IS NULL THEN 
        LEAVE sp_main;
    END IF;

    -- Check if the incoming pilot is valid
    SELECT COUNT(*) INTO validIncoming FROM drone_pilots WHERE uname = ip_incoming_pilot;
    
    -- Check if the incoming pilot is not currently controlling a drone
    SELECT COUNT(*) INTO incomingNoDrone FROM drones WHERE pilot = ip_incoming_pilot;

    -- Check if the outgoing pilot is currently controlling a drone
    SELECT COUNT(*) INTO outgoingHasDrone FROM drones WHERE pilot = ip_outgoing_pilot;
    
    -- Perform the swap if all conditions are met
    IF validIncoming > 0 AND incomingNoDrone = 0 AND outgoingHasDrone > 0 THEN
        UPDATE drones SET pilot = ip_incoming_pilot WHERE pilot = ip_outgoing_pilot;
    END IF;
END //
DELIMITER ;

-- repair and refuel a drone
delimiter // 
create procedure repair_refuel_drone
	(in ip_drone_store varchar(40), in ip_drone_tag integer,
    in ip_refueled_trips integer)
sp_main: begin
	-- place your solution here
    if (ip_drone_store is NULL or ip_drone_tag is NULL or ip_refueled_trips is NULL or ip_refueled_trips < 0) then
		SELECT 'Invalid Input' AS status;
		leave sp_main;
	end if;
	-- Update the remaining_trips for the specified drone
	update drones
	set remaining_trips = remaining_trips + ip_refueled_trips
	where storeID = ip_drone_store and droneTag = ip_drone_tag;
    
    IF ROW_COUNT() = 0 THEN
        SELECT 'No Drone Updated' AS status;  -- No drone was found with the given identifiers
    ELSE
        SELECT 'Drone Updated Successfully' AS status;  -- Drone was successfully updated
    END IF;
end //
delimiter ;

-- begin order
delimiter // 
create procedure begin_order
	(in ip_orderID varchar(40), in ip_sold_on date,
    in ip_purchased_by varchar(40), in ip_carrier_store varchar(40),
    in ip_carrier_tag integer, in ip_barcode varchar(40),
    in ip_price integer, in ip_quantity integer)
sp_main: begin
	-- place your solution here
--     This procedure is used to initiate an order for groceries with one line product – including price and quantity – if
-- (and only if) the following conditions are met:
-- • The customer, order ID, drone, and product barcode are all valid.
-- • The price is non-negative, and the quantity is positive.
-- • The customer has enough credits to purchase the initial products being ordered.
-- • The drone has enough lifting capacity to carry the initial products.

	declare customer_count int;
    declare order_count int;
    declare drone_count int;
    declare product_count int;
	select count(*) into customer_count from customers where uname = ip_purchased_by;
	select count(*) into order_count from orders where orderID = ip_orderID;
    select count(*) into drone_count from drones where storeID = ip_carrier_store and droneTag = ip_carrier_tag;
    select count(*) into product_count from products where barcode = ip_barcode;
    
    IF ip_orderID is NULL or ip_sold_on is NULL or ip_purchased_by is NULL or ip_carrier_store is NULL or ip_carrier_tag is NULL or ip_barcode is NULL or ip_price is NULL or ip_quantity is NULL
		then leave sp_main;
	END IF;
    
    
	if (product_count = 1 and 
		drone_count = 1 and 
        order_count = 0 and 
        customer_count = 1 and 
        (select total_weight_allowed - current_weight from drone_traffic_control where drone_serves_store = ip_carrier_store and drone_tag = ip_carrier_tag) - ((select weight from products where barcode = ip_barcode) * ip_quantity) >= 0 and 
        ip_price >= 0 and 
        ip_quantity > 0 and 
        (select current_credit - credit_already_allocated from customer_credit_check where customer_name = ip_purchased_by) - (ip_quantity * ip_price) >= 0) then
        
		insert into orders values(ip_orderID, ip_sold_on, ip_purchased_by, ip_carrier_store, ip_carrier_tag);
		insert into order_lines values(ip_orderID, ip_barcode, ip_price, ip_quantity);
    end if;
end //
delimiter ;


drop procedure if exists add_order_line;
-- add order line
delimiter // 
create procedure add_order_line
    (in ip_orderID varchar(40), in ip_barcode varchar(40),
    in ip_price integer, in ip_quantity integer)
sp_main: begin
    -- place your solution here
    declare username varchar(40);
    declare customerCredit integer;
    declare productWeight integer;
    declare totalPrice integer default 0;
    declare droneCapacity integer;
    declare store varchar(40);
    declare totalWeight integer default 0;
    
    if ip_orderID is null or ip_barcode is null or ip_price is null or ip_quantity is null then
		leave sp_main;
	end if;

    select purchased_by into username from orders where orderID = ip_orderID limit 1;
    if username is null then
        leave sp_main;
    end if;

    if not exists (select barcode from products where barcode = ip_barcode) then
        leave sp_main;
    end if;

    if exists (select barcode from order_lines where order_lines.orderID = ip_orderID and barcode = ip_barcode) then
        leave sp_main;
    end if;

    if ip_price < 0 or ip_quantity <= 0 then
        leave sp_main;
    end if;

    set totalPrice = ip_price * ip_quantity;
    select credit into customerCredit from customers where uname like username limit 1;
	set totalPrice = totalPrice + (select sum(ol.price * ol.quantity) from order_lines as ol where ol.orderID = ip_orderID);
    if customerCredit < totalPrice then
        leave sp_main;
    end if;

    select weight into productWeight from products where barcode = ip_barcode limit 1;
    select carrier_store into store from orders where orderID = ip_orderID limit 1;
    select d.capacity into droneCapacity from drones as d, orders as o
    where ip_orderID = o.orderID and d.droneTag = o.carrier_tag and d.storeID = o.carrier_store;

	set totalWeight = (productWeight * ip_quantity);
	set totalWeight = totalWeight + (select sum(p.weight * ol.quantity) from products as p, order_lines as ol
		where ol.orderID = ip_orderID and ol.barcode = p.barcode);
        
    if droneCapacity < totalWeight then
        leave sp_main;
    end if;
    

    insert into order_lines (orderID, barcode, price, quantity) values (ip_orderID, ip_barcode, ip_price, ip_quantity);
end //
delimiter ;


delimiter //
create procedure deliver_order
    (in ip_orderID varchar(40))
sp_main: begin
    declare total_cost int;
    declare custrate int;
    
    -- Check if the input orderID is valid
    if ip_orderID is null or ip_orderID = '' or (select count(*) from orders where orders.orderID = ip_orderID) = 0 or (select remaining_trips from drones join orders on drones.storeID = orders.carrier_store and drones.droneTag = orders.carrier_tag where orders.orderID = ip_orderID) <= 0 then
        leave sp_main;
    end if;
    
	select cost into total_cost from orders_in_progress where orderID = ip_orderID;
    
    update customers join orders on uname = purchased_by set credit = credit - total_cost where orderID = ip_orderID;
    update stores join orders on storeID = carrier_store set revenue = revenue + total_cost where orderID = ip_orderID;
    update drones join orders on droneTag = carrier_tag and storeID = carrier_store set remaining_trips = remaining_trips - 1 where orderID = ip_orderID;
    update drone_pilots join drones on uname = pilot join orders on (storeID = carrier_store and droneTag = carrier_tag) set experience = experience + 1 where orderID = ip_orderID;
    
    select rating into custrate from customers join orders on uname = purchased_by where orderID = ip_orderID;
    
    if (total_cost > 25 and custrate < 5) then
		update customers join orders on uname = purchased_by set rating = rating + 1 where orderID = ip_orderID;
    end if;
    
    delete from order_lines where orderID = ip_orderID;
    delete from orders where orderID = ip_orderID;
    
end //

delimiter ;

drop procedure if exists cancel_order; 
delimiter //
create procedure cancel_order
    (in ip_orderID varchar(40))
sp_main: begin
    -- place your solution here
    declare username varchar(40);
    declare currentRating integer;

    select purchased_by into username from orders where orderid = ip_orderid limit 1;
    if ip_orderID is NULL or username is null then 
        leave sp_main;
    end if;
    select rating into currentRating from customers where uname = username;
    if currentRating > 1 then
        update customers set rating = rating - 1 where uname = username;
    end if;

    delete from order_lines where orderid = ip_orderid;
    delete from orders where orderid = ip_orderid;
end //
delimiter ;

-- display persons distribution across roles
create or replace view role_distribution (category, total) as
-- replace this select query with your solution
select 'users' as category, count(*) as total from users union
select 'customers' as category, count(*) as total from customers union
select 'employees' as category, count(*) as total from employees union
select 'customer_employer_overlap' as category, count(*) as total from customers natural join employees union
select 'drone_pilots' as category, count(*) as total from drone_pilots union
select 'store_workers' as category, count(*) as total from store_workers union
select 'other_employee_roles' as category, (select count(*) from employees) - (select count(*) from drone_pilots) - (select count(*) from store_workers);

-- display customer status and current credit and spending activity
create or replace view customer_credit_check (customer_name, rating, current_credit,
	credit_already_allocated) as
-- replace this select query with your solution
select c.uname as customer_name, 
       c.rating as rating, 
       c.credit as current_credit, 
       ifnull(sum(ol.price * ol.quantity), 0) as credit_already_allocated
from customers as c
left join orders o on c.uname = o.purchased_by
left join order_lines ol on o.orderID = ol.orderID
group by c.uname;

-- display drone status and current activity
create or replace view drone_traffic_control (drone_serves_store, drone_tag, pilot,
	total_weight_allowed, current_weight, deliveries_allowed, deliveries_in_progress) as
-- replace this select query with your solution
select storeID, droneTag, pilot, capacity, COALESCE((
        select COALESCE(currentDroneWeight, 0) from (
            select carrier_store, carrier_tag, sum(orderWeight) as currentDroneWeight 
            from (
                select orderID, sum(lineWeight) as orderWeight 
                from (
                    select orderID, products.barcode, quantity * weight as lineWeight 
                    from order_lines 
                    join products on order_lines.barcode = products.barcode
                ) as s 
                group by orderID
            ) as weights 
            join orders on weights.orderID = orders.orderID 
            group by carrier_store, carrier_tag
        ) as capweights 
        where storeID = carrier_store and droneTag = carrier_tag
    ), 0) as current_weight, remaining_trips, (select count(*) from orders where (drones.storeID = orders.carrier_store and drones.droneTag = orders.carrier_tag)) as deliveries_in_progress from drones;

-- display product status and current activity including most popular products
create or replace view most_popular_products (barcode, product_name, weight, lowest_price,
	highest_price, lowest_quantity, highest_quantity, total_quantity) as
-- replace this select query with your solution
select p.barcode, p.pname, p.weight, min(o.price), max(o.price), IFNULL(min(o.quantity), 0), IFNULL(max(o.quantity), 0), IFNULL(sum(o.quantity), 0) 
from products as p left join order_lines as o
on p.barcode = o.barcode
group by p.barcode;

-- display drone pilot status and current activity including experience
#This view displays the status for all pilots including the pilot’s current and pending flight experience.
create or replace view drone_pilot_roster (pilot, licenseID, drone_serves_store,
	drone_tag, successful_deliveries, pending_deliveries) as
-- replace this select query with your solution
with table_x as
(select pilot as duname, count(*) as remaining_trips_cal from orders join drones on drones.storeID = orders.carrier_store and drones.droneTag = orders.carrier_tag group by pilot)
#table_x is the few drone pilots w/ pending orders

select drone_pilots.uname, drone_pilots.licenseID, drones.storeID, drones.droneTag, drone_pilots.experience, IFNULL(table_x.remaining_trips_cal, 0)
from drone_pilots left join drones on drones.pilot = drone_pilots.uname left join table_x on drone_pilots.uname=table_x.duname;

-- display store revenue and activity
create or replace view store_sales_overview (store_id, sname, manager, revenue,
	incoming_revenue, incoming_orders) as
-- replace this select query with your solution
select storeID, sname, manager, revenue, coalesce(sum(price * quantity), 0), coalesce(count(distinct o.orderID), 0)
from stores s left join orders o on carrier_store = storeID left join order_lines ol on o.orderID = ol.orderID group by storeID, sname, manager;



create or replace view orders_in_progress (orderID, cost, num_products, payload,
    contents) as
-- replace this select query with your solution
select 
    o.orderid,
    sum(ol.price * ol.quantity) as cost,
    count(ol.barcode) as num_products,
    sum(p.weight * ol.quantity) as payload,
    group_concat(p.pname separator ', ') as contents
from orders o
join order_lines ol on o.orderid = ol.orderid
join products p on ol.barcode = p.barcode
group by o.orderid;

-- remove customer
delimiter // 
create procedure remove_customer
	(in ip_uname varchar(40))
sp_main: begin
	IF ip_uname is NULL or ip_uname NOT IN (select uname from customers) THEN
		LEAVE sp_main;
	END IF;
	IF ip_uname NOT IN (select uname from customers) THEN
		LEAVE sp_main;
	END IF;
	IF ip_uname NOT IN (select purchased_by from orders) THEN
		DELETE from customers where uname = ip_uname;
        IF ip_uname NOT IN (select uname from employees) THEN
			DELETE from users where uname = ip_uname;
		END IF;
	END IF;
end //
delimiter ;

-- remove drone pilot
delimiter // 
create procedure remove_drone_pilot
	(in ip_uname varchar(40))
sp_main: begin
	-- place your solution here
    #This procedure is used to remove a pilot from the system if (and only if) the following conditions are met:
	#• The pilot is not controlling a drone.
	#• Note: Only the drone pilot should be removed from the system – if the drone pilot is also a customer,
	#then the customer should remain in the system.
    declare pilotControlling int;
    declare pilotInCustomer int;
    
	select count(*) into pilotControlling from drones where ip_uname like drones.pilot; #if 0, not controlling a drone
	select count(*) into pilotInCustomer from customers where ip_uname like customers.uname; #if greater than 0, drone pilot also a customer
    
    #if drone pilot is in customer, do not remove it from users
    if (pilotInCustomer > 0) then
		delete from employees where employees.uname like ip_uname;
		delete from drone_pilots where drone_pilots.uname like ip_uname;
    ELSEIF (pilotControlling=0) then
		delete from users where users.uname like ip_uname;
		delete from employees where employees.uname like ip_uname;
		delete from drone_pilots where drone_pilots.uname like ip_uname;
    END IF;
    
end //
delimiter ;

-- remove product
delimiter //
create procedure remove_product
	(in ip_barcode varchar(40))
sp_main: begin
	-- place your solution here
    declare used_in_pending int;
    select count(*) into used_in_pending from order_lines where ip_barcode = barcode;
    
    if (used_in_pending = 0) then 
		delete from products where barcode = ip_barcode;
    end if;
end //
delimiter ;

-- remove drone
delimiter // 
create procedure remove_drone
	(in ip_storeID varchar(40), in ip_droneTag integer)
sp_main: begin
	-- place your solution here
    declare is_carrying_pending int;
    
    select count(*) into is_carrying_pending from orders where (ip_storeId = carrier_store and ip_droneTag = carrier_tag);
    
    if (is_carrying_pending = 0) then
		delete from drones where (storeID = ip_storeId and droneTag = ip_droneTag);
        if row_count() = 0 then
			select 0 as status;
		else select 1 as status;
        end if;
	else
		select 2 as status;
	end if;
end //
delimiter ;