create database casestudy;
use casestudy;

create table station
( station_id int primary key,
station_name varchar(50),
location varchar(50));

insert into station (station_id, station_name, location) values
(1, 'Central Station', 'City Center'),
(2, 'North Station', 'North City'),
(3, 'South Station', 'South City'),
(4, 'East Station', 'East City'),
(5, 'West Station', 'West City');
select * from station;

create table Train
(Train_id int primary key,
Train_name varchar(50),
Train_type varchar(50),
Total_coaches int);

insert into Train values
(101,"Rajdhani Express","Express",22),
(102,"Mail Express", "Express", 22),
(103,"Intercity", "Passenger", 24),
(104,"Vasuki","Freight",295),
(105,"PATNA GAYA MEMU", "Passenger",20);
select * from Train;

create table passenger
(passenger_id int primary key,
first_name varchar (50),
last_name varchar (50),
age int,
gender char(1));
select * from passenger;

insert into passenger values
(111,"Sakeeb","Shaikh",21,"M"), 
(112,"Simran","varma",21,"F"),
(113,"Neha","Pawar",21,"F"),
(114,"Shubhangi","More",21,"F"),
(115,"Nishant","Nikam",21,"M");
select * from passenger;


CREATE TABLE Schedule (
    schedule_id INT PRIMARY KEY,
    train_id INT,
    station_id INT,
    arrival_time TIME,
    departure_time TIME,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    FOREIGN KEY (train_id) REFERENCES Train(train_id),
    FOREIGN KEY (station_id) REFERENCES Station(station_id)
);

INSERT INTO Schedule (schedule_id, train_id, station_id, arrival_time, departure_time, day_of_week) VALUES
(201, 101, 1, '08:00:00', '08:15:00', 'Monday'),
(202, 102, 3, '10:00:00', '10:15:00', 'Monday'),
(203, 103, 2, '09:00:00', '09:10:00', 'Sunday'),
(204, 102, 4, '11:00:00', '11:20:00', 'Tuesday'),
(205, 104, 3, '12:00:00', '12:30:00', 'Saturday'),
(206, 105, 5, '14:00:00', '14:15:00', 'Wednesday'),
(207, 104, 4, '07:00:00', '07:30:00', 'Thursday'),
(208, 103, 1, '09:00:00', '09:20:00', 'Friday');
select * from Schedule;


-- Simple Queries:

-- 1.Find all trains of type "Express":
select * from Train where Train_type="Express";

-- 2.List all passengers whose last name is "Shaikh":
select * from passenger where last_name ="Shaikh";

-- 3.Find the train with Train_id 103:
select * from Train where Train_id = 103;

-- 4. Count the number of stations 
select count(*) from station;

-- 5. List all schedules for train 101:
select * from Schedule  Train where Train_id=101;
 
-- 6. List all passengers who are female:
select * from passenger where gender ="F";

-- 7.Find the departure time of the train with schedule_id 202:
select departure_time from Schedule where Schedule_id = 202;

-- 8.List all trains with more than 20 coaches:
select * from Train where Total_coaches >20;

-- 9. List all stations located in "City Center":
select * from Station where Location= "City Center";

-- 10. rename train name vasuki to vasuki goods
UPDATE Train
SET train_name = 'Vasuki Goods'
WHERE train_name = 'Vasuki';
select * from Train;


-- complex queries:
-- 1.Find the total number of passengers:
SELECT COUNT(*) AS total_passengers FROM Passenger;

-- 2.Find the average age of passengers:
SELECT AVG(age) AS average_age FROM Passenger;

-- 3.List all schedules for trains operating on "Monday":
SELECT * FROM Schedule WHERE day_of_week = 'Monday';

-- 4.Find all trains that stop at "Central Station" (station_id 1):
SELECT * FROM Schedule WHERE station_id = 1;

-- 5. List the train names and the corresponding station names for all schedules:
SELECT T.train_name, S.station_name
FROM Schedule Sch
JOIN Train T ON Sch.train_id = T.train_id
JOIN Station S ON Sch.station_id = S.station_id;

-- 6. Count the number of schedules for each train:
SELECT train_id, COUNT(*) AS schedule_count
FROM Schedule
GROUP BY train_id;

-- 7.Find the station with the earliest arrival time for train 104:
SELECT station_id, MIN(arrival_time) AS earliest_arrival
FROM Schedule
WHERE train_id = 104
GROUP BY station_id
ORDER BY earliest_arrival
LIMIT 1;

-- 8.Find all male passengers who are older than 20 years:
SELECT * FROM Passenger
WHERE gender = 'M' AND age > 20;

-- 9.Find all trains that do not have any schedules on "Saturday":
SELECT T.train_id, T.train_name
FROM Train T
LEFT JOIN Schedule Sch ON T.train_id = Sch.train_id AND Sch.day_of_week = 'Saturday'
WHERE Sch.schedule_id IS NULL;

-- 10.Find the train(s) with the maximum number of coaches:
SELECT * FROM Train
WHERE total_coaches = (SELECT MAX(total_coaches) FROM Train);

-- 11.List all stations and the number of trains that stop at each station:
SELECT S.station_name, COUNT(Sch.train_id) AS train_count
FROM Station S
JOIN Schedule Sch ON S.station_id = Sch.station_id
GROUP BY S.station_name;

-- 12.Find the earliest departure time for each train on "Wednesday":
SELECT train_id, MIN(departure_time) AS earliest_departure
FROM Schedule
WHERE day_of_week = 'Wednesday'
GROUP BY train_id;

-- 13.List all passengers whose first name starts with 'S':
SELECT * FROM Passenger WHERE first_name like "s%";

-- 14. Find the total revenue from tickets :
SELECT SUM(Total_coaches * 100) AS total_revenue
FROM Train ;

-- 15. Find all trains that have a schedule at "West Station" (station_id 5) and operate on "Wednesday":
SELECT T.train_id, T.train_name
FROM Train T
JOIN Schedule Sch ON T.train_id = Sch.train_id
WHERE Sch.station_id = 5 AND Sch.day_of_week = 'Wednesday';

-- 16. List all trains and the number of times they appear in the schedule:
SELECT T.train_name, COUNT(Sch.schedule_id) AS schedule_count
FROM Train T
LEFT JOIN Schedule Sch ON T.train_id = Sch.train_id
GROUP BY T.train_name;

-- 17. Find the average number of coaches per train type:
SELECT train_type, AVG(total_coaches) AS avg_coaches
FROM Train
GROUP BY train_type;

-- 18.Find the most common departure time across all schedules:
SELECT departure_time, COUNT(*) AS frequency
FROM Schedule
GROUP BY departure_time
ORDER BY frequency DESC
LIMIT 1;

-- 19. Find all trains that stop at both "Central Station" (station_id 1) and "North Station" (station_id 2):
SELECT DISTINCT T.train_id, T.train_name
FROM Train T
JOIN Schedule S1 ON T.train_id = S1.train_id AND S1.station_id = 1
JOIN Schedule S2 ON T.train_id = S2.train_id AND S2.station_id = 2;

-- 20.List the full names of all passengers, sorted by last name:
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM Passenger
ORDER BY last_name;

-- 21. Find the difference in arrival and departure times for all schedules:
SELECT schedule_id, TIMEDIFF(departure_time, arrival_time) AS time_difference
FROM Schedule;

-- 22. List all trains that do not stop at "South Station" (station_id 3):
SELECT T.train_id, T.train_name
FROM Train T
WHERE T.train_id NOT IN (SELECT train_id FROM Schedule WHERE station_id = 3);

-- 23. Find the oldest passenger:
SELECT * FROM Passenger
WHERE age = (SELECT MAX(age) FROM Passenger);

-- 24. List all schedules where the arrival time is earlier than 09:00 AM:
SELECT * FROM Schedule
WHERE arrival_time < '09:00:00';

-- 25. Find all trains that are scheduled at "Central Station" (station_id 1) more than once a week:
/*SELECT train_id, COUNT(*) AS frequency
FROM Schedule
WHERE station_id = 1
GROUP BY train_id
HAVING frequency > 0;
*/
SELECT train_id, COUNT(*) AS frequency
FROM Schedule
WHERE station_id = 1
GROUP BY train_id
HAVING frequency > 0;

-- 26. List all passengers with the first name "Neha" or last name "Nikam":
SELECT * FROM Passenger
WHERE first_name = 'Neha' OR last_name = 'Nikam';

-- 27. Find the station with the maximum number of schedules:
SELECT station_id, COUNT(*) AS schedule_count
FROM Schedule
GROUP BY station_id
ORDER BY schedule_count DESC
LIMIT 1;

-- 28. Find the train(s) with the earliest and latest departure times on "Friday":
SELECT train_id, MIN(departure_time) AS earliest_departure, MAX(departure_time) AS latest_departure
FROM Schedule
WHERE day_of_week = 'Friday'
GROUP BY train_id;

-- 29. List all trains that stop at exactly 2 stations:
SELECT train_id, COUNT(*) AS station_count
FROM Schedule
GROUP BY train_id
HAVING station_count = 2;

-- 30. Find all passengers who are younger than 22 years and are male:
SELECT * FROM Passenger
WHERE age < 22 AND gender = 'M';

-- 31. List the schedule details for the train with the highest number of coaches:
SELECT S.*
FROM Schedule S
JOIN Train T ON S.train_id = T.train_id
WHERE T.total_coaches = (SELECT MAX(total_coaches) FROM Train);

-- 32. Find the total number of schedules for trains of type "Passenger":
SELECT COUNT(*)
FROM Schedule Sch
JOIN Train T ON Sch.train_id = T.train_id
WHERE T.train_type = 'Passenger';

-- 33.List all the stations where no trains stop on "Saturday":
SELECT S.station_name
FROM Station S
LEFT JOIN Schedule Sch ON S.station_id = Sch.station_id AND Sch.day_of_week = 'Saturday'
WHERE Sch.schedule_id IS NULL;

-- 34. Find the youngest female passenger:
SELECT * FROM Passenger
WHERE gender = 'F' AND age = (SELECT MIN(age) FROM Passenger WHERE gender = 'F');

-- 35. List the total number of coaches for all trains stopping at "East Station" (station_id 4):
SELECT SUM(T.total_coaches) AS total_coaches
FROM Train T
JOIN Schedule Sch ON T.train_id = Sch.train_id
WHERE Sch.station_id = 4;

-- 36. Find the maximum, minimum, and average age of passengers:
SELECT MAX(age) AS max_age, MIN(age) AS min_age, AVG(age) AS avg_age
FROM Passenger;

-- 37. List all trains that have schedules on both "Monday" and "Wednesday":
SELECT DISTINCT T.train_id, T.train_name
FROM Train T
JOIN Schedule S1 ON T.train_id = S1.train_id AND S1.day_of_week = 'Monday'
JOIN Schedule S2 ON T.train_id = S2.train_id AND S2.day_of_week = 'Wednesday';

-- 38. List the station names and the corresponding arrival times for train 101:
SELECT St.station_name, Sch.arrival_time
FROM Schedule Sch
JOIN Station St ON Sch.station_id = St.station_id
WHERE Sch.train_id = 101;

-- 39. Find all trains that depart after 10:00 AM:
SELECT T.train_name, Sch.departure_time
FROM Train T
JOIN Schedule Sch ON T.train_id = Sch.train_id
WHERE Sch.departure_time > '10:00:00';

-- 40. Find the station where the train with the most schedules stops most frequently:
SELECT station_id, COUNT(*) AS frequency
FROM Schedule
WHERE train_id = (SELECT train_id
                  FROM Schedule
                  GROUP BY train_id
                  ORDER BY COUNT(*) DESC
                  LIMIT 1)
GROUP BY station_id
ORDER BY frequency DESC
LIMIT 1;
