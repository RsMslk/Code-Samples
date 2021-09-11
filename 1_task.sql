/*Задача 1. Напишите запрос, который выведет пилотов, которые в качестве второго пилота в
августе этого года ездили в аэропорт Шереметьево. */
SELECT NAME 
	FROM PILOTS INNER JOIN FLIGHT ON (PILOTS.pilot_id = FLIGHT.second_pilot_id)
	where  
		FLIGHT.destination = 'SVO'
		AND flight_dt BETWEEN '2021-08-01' AND '2021-08-31'
	GROUP BY NAME;