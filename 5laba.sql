--
--1/Год, дом, квартира, задолженность по оплате на конец года.
--
use LABA3
IF OBJECT_ID ('DEBT_TABLE ') IS NOT NULL
	drop VIEW DEBT_TABLE
GO
CREATE VIEW DEBT_TABLE ( [year],HOUSE, FLAT,all_debt) 
AS 
	SELECT cast(year(payment.[date]) as varchar(4)),
	 house.house_number, flats.flat_number,sum( payment.debt) as all_dept
	 from 
		payment inner join citizen on (citizen.citizen_id = payment.citizen_id)
		inner join residence_time on (residence_time.citizen_id = citizen.citizen_id)
		inner join flats on (flats.flat_id = residence_time.flat_id)
		inner join house on (house.house_id = flats.house_id)
		where payment.debt in (select payment.debt from payment where  Month(payment.date) = (select max ( Month(payment.date)) from payment))
		group by cast(year(payment.[date]) as varchar(4)),house.house_number, flats.flat_number
		order by cast(flat_number as int) OFFSET 0 ROWS ; --OFFSET
GO
select * from DEBT_TABLE



--ВЫВЕСТИ ВСЕХ ЖИТЕЛЕЙ ДОМА 302бис У КОТОРЫХ НЕТ ДОЛГОВ НА КОНЕЦ ГОДА И КОТОРЫЕ ЖИВУТ В ЧЕТНЫХ КВАРТИРАХ

select citizen.Name,citizen.Middle_name,citizen.Last_Name 
	from 
		citizen inner join residence_time on (citizen.citizen_id = residence_time.citizen_id) 
		inner join flats on (flats.flat_id = residence_time.flat_id)
		inner join DEBT_TABLE ON (flats.flat_number = DEBT_TABLE.FLAT)
	WHERE DEBT_TABLE.all_debt = 0
		AND CAST(flats.flat_number AS int  ) %2 =0
		AND HOUSE = '302бис'

	GROUP BY citizen.Name,citizen.Middle_name,citizen.Last_Name 


--выводим суммарный итоговый долг всех жителей первого дома у которых имя начинается на А

 SELECT SUM(ALL_DEBT) FROM DEBT_TABLE INNER JOIN flats ON DEBT_TABLE.FLAT =flats.flat_number INNER JOIN residence_time on flats.flat_id = residence_time.flat_id inner join citizen on residence_time.citizen_id = citizen.citizen_id 
	WHERE HOUSE = '1' AND SUBSTRING (citizen.Name,1,1) = 'А' and property_part!=0
	

