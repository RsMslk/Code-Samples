/*Задача 2. Выведите пилотов старше 45 лет, которые совершили больше 30 полетов на грузовых
самолетах.*/
SELECT name 
	FROM PILOTS
	WHERE PILOTS.age > 45 
		AND PILOTS.pilot_id IN 
			(SELECT pilot_id 
				FROM PILOTS INNER JOIN FLIGTS ON (FLIGHTS.first_pilot_id = PILOTS.pilot_id or FLIGHTS.second_pilot_id = PILOTS.pilot_id)
				INNER JOIN PLANES ON (PLANES.plane_id = FLIGHTS.plane_id)
				WHERE PLANES.cargo_flg = 1
				GROUP BY pilot_id
				HAVING COUNT(flight_id) > 30) 
