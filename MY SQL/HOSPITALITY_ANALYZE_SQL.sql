create database Hospitality_Analytics; 
show tables;
select * from dim_date;
select * from dim_hotels;
select * from dim_rooms;
select * from fact_aggrecated_booking;
select * from fact_booking;

select distinct city from dim_hotels;

select count(*) as total_hotels
from dim_hotels;

# TOTAL REVENUE
select concat(ROUND(sum(revenue_realized)/1000000)," M")as Total_Revenue
from fact_booking;

#TOTAL BOOKINGS
select count(booking_id) as Total_Booking
from fact_booking;

# TOTAL CAPACITY
select sum(capacity)  as Total_Capacity
from fact_aggrecated_booking;

# AVG RATING
select	avg(ratings_given) as Avg_rating
from fact_booking;

# BOOKING ANALYZE QUERIES
select count(*) as total_booking
from fact_booking;

select * from fact_booking
limit 10;

# SUCCESFUL BOOKINGS
select count(*) as succesful_booking
from fact_booking
where trim(booking_status) = 'Checked Out';

# CANCELLED BOOKINGS
select count(*) as cancelled_booking
from fact_booking
where trim(booking_status) = 'Cancelled';

# NO_SHOW_BOOKING
select count(*) as no_show_booking
from fact_booking 
where trim(booking_status) = 'no show';

# ADR (AVRAGE DAILY RATE)
select 
concat(" $ ", round(sum(revenue_realized) / count(booking_id)/10))as ADR
from fact_booking
where trim(booking_status) = "Checked Out";

# OCCUPANCY_RATE
select sum(successful_bookings) / sum(capacity) * 100 as occupancy_rate
from fact_aggrecated_booking
group by property_id; 

select 
concat(round(sum(successful_bookings) * 100.0 /  sum(capacity),2),"%") as occupancy_rate
from fact_aggrecated_booking;


# REVENUE BY HOTESL
select h.property_name,
concat(sum(round(revenue_generated) / 1000000), "M") as Total_revenue
from fact_booking f
join dim_hotels h 
on f.property_id = h.property_id
group by property_name;

# REVENUE BY CITY
select
 h.city,
concat(sum(round(revenue_generated) / 1000000), "M") as Total_Revenue
from fact_booking f
join dim_hotels h
on f.property_id = h.property_id
group by city;

# ROOM CLASS WISE REVENUE
select 
r.room_class,
concat(sum(round(revenue_realized) / 1000000), "M") as Revenue
from fact_booking f
join dim_rooms r 
on f.room_category = r.room_id
group by room_class
order by revenue desc;

# TOP 5 HOTELS BOOKING
select h.property_name,
count(booking_id) as Total_Bookings
from fact_booking f
join dim_hotels h  
on f.property_id = h.property_id
group by property_name
order by Total_Bookings desc;

# MONTHLY REVENUE
select 
d.mmm_yy,
concat(round(sum(f.revenue_generated)/1000000),"m") as Revenue
from fact_booking f 
join dim_date d 
on f.check_in_date = d.date
group by d.mmm_yy
order by Revenue desc;

# BOOKING STATUS DISTRIBUTION
select booking_status,
count(*) as Total
from fact_booking
group by booking_status;

# BOOKING BY PLATFROM
select booking_platform,
concat(round(sum(revenue_generated)/1000000),"M")
as Revenue
from fact_booking 
group by booking_platform
order by Revenue desc;

# REVPAR REVENUE PER AVAILABLE ROOMS
select 
concat("$",(round(sum(revenue_generated) / sum(capacity),2))) as REVPAR
from fact_booking f 
join fact_aggrecated_booking a 
on f.property_id = a.property_id;

# MONTHLY BOOKING TREND
select d.mmm_yy,
count(booking_id) as Bookings
from fact_booking f
join dim_date d
on f.check_in_date = d.date
group by d.mmm_yy
order by Bookings desc;

# WEEKEND VS WEEKDAYS
select d.day_type,
concat(round(sum(revenue_realized)/1000000),"M") as Revenue
from fact_booking f
join dim_date d
on f.check_in_date = d.date
group by d.day_type
order by Revenue;






