use akhilesh
select * from Up_wheel_csv_file
where s_no = (select min(s_no) from Up_wheel_csv_file)

#1.Total copany wise vehicle

select Company_name,count(*) as Number_of_vehicle from Up_wheel_csv_file
group by Company_name
order by count(*) asc

#2 Number of vehicle in various cities

select Location, company_name,count(*) as Number_of_vehicle_in_cities from Up_wheel_csv_file
group by Location,Company_name 
order by count(*) asc

#3 Number of petol or Diesel or hybrid vehicle in cities

select Registration_status,Engine_type,count(*) as Number_of_vehicle from Up_wheel_csv_file
group by Registration_status,Engine_type
order  by count(*)

#4.Mileage wise rank

select  company_name, Mileage 
from (
select company_name, Mileage ,
rank() over(partition by company_name order by Mileage desc) as Mileage_wise_rank from Up_wheel_csv_file) one
where one.Mileage_wise_rank=1


#5 Model year wise vehicle details


select Model_year,count(*) as Number_of_vehicle from Up_wheel_csv_file
group by Model_year
order  by count(*) desc



