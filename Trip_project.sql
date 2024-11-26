use Akhilesh
select * from question
insert into question values('2022-03-04 08:00','A1',1,'10:30','LOGIN')
insert into question values('2022-03-04 08:40','A2',1,'10:30','LOGIN')
insert into question values('2022-03-04 09:10','A3',1,'10:30','LOGIN')
insert into question values('2022-03-04 10:00','A4',1,'10:30','LOGIN')
insert into question values('2022-03-05 19:00','A4',2,'18:50','LOGOUT')
insert into question values('2022-03-05 19:10','B1',2,'18:50','LOGOUT')
)


#1.Monthly Number of trips, one trip is defined by a unique trip ID


Select convert(varchar(7),Employee_Pick_up_Time,126) as Month_Year, count(distinct Trip_id) as Number_of_Trips from question
group by convert(varchar(7),Employee_Pick_up_Time,126)

#2.First Pickup and Last Pickup time for a trip 


select trip_id , convert(varchar(16),min(Employee_Pick_up_Time),120),convert(varchar(16),max(Employee_Pick_up_Time),120) from question
group by trip_id 

#4.Unique employees traveling in Night hours vs Day Hours (Night Hours = before 10 AM or after 6 pm, Day Hours is everything other than night hours.)

select Month_year,count(Day_travel_employee) Employees_in_day_hours, count(Night_travel_employee) Employees_in_Night_hours
from 
(select convert(varchar(7),Employee_Pick_up_Time,126) as Month_Year,
case 
when Trip_Direction='login' and convert(varchar(8),Employee_Pick_up_Time,108)<'10:00:00'and shift_time>'10:00:00' then 'Travelled in Both hours' 
when trip_direction='logout' and '18:00:00' between convert(varchar(7),Employee_Pick_up_Time,108) and shift_time  then 'Travelled in Both hours' end as Both_travel_employees,
case
when trip_direction='login'and convert(varchar(8),Employee_Pick_up_Time,108)='10:00:00' and shift_time<'18:00:00' then 'Travelled in Day hours' end as Day_travel_employee,
case 
when trip_direction='logout' and '18:00:00' not between convert(varchar(8),Employee_Pick_up_Time,108) and shift_time  then 'Travelled in night hours' end as Night_travel_employee from question) tt
group by Month_year


#5.No. of TOTAL DAY hours travelled and TOTAL Night hours travelled


select Month_Year, cast(round(sum(((isnull(Night_hour1,0)+isnull(Night_Hour2,0))/60.0)),0) as int) as Total_Night_hour_travelled ,cast(sum((isnull(Day_hour1,0)/60.0)) as int) as Total_Day_hour_travelled
from (select convert(varchar(7),Employee_Pick_up_Time,126) as Month_Year,  
case when datepart( hour,Employee_Pick_up_Time) <= 10  then datediff(minute,convert(varchar,Employee_Pick_up_Time, 108),'10:00:00') end Night_hour1,
case when datepart( hour,Employee_Pick_up_Time) <= 10 then abs(datediff(minute,'10:30:00','10:00:00')) end Day_hour1, 
case when datepart( hour,Employee_Pick_up_Time) >= 18 then abs(dATEdiff(minute,convert(varchar,Employee_Pick_up_Time,108),'18:50:00')) end Night_Hour2
from question ) ttt
  group by month_year



