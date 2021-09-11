/*Задача 3. Выведите ТОП 10 пилотов-капитанов (first_pilot_id), которые перевезли наибольшее число пассажиров в этом году.*/


SELECT nam from (
SELECT TOP (10) pilots.NAME as nam, sum(flights.quantity) from flights left join pilots on (flights.first_pilot_id = pilots.pilot_id) left join planes on (flight. plane_id = planes.plane_id)
where flight_dt > 600
and planes.cargo_flg = 0
group by pilots.name
order by sum(flights.quantity) desc);