drop user test;
drop login tester;
create login tester with password = 'pass';
create user test for login tester with default_schema = [dbo];
use Home_management;
--exec sp_grantdbaccess 'test';

--SELECT CURRENT_USER

execute as user = 'test';
select * from apartment;
select * from humans;
select descript from services;
update humans set l_name = 'Wexler' where f_name = 'Alex';
revert;
print '_______________next row____________________';

begin tran 
grant select, insert, update on apartment to test with grant option;
execute as user = 'test';
select * from apartment;
update apartment set street = 'Pervomayskaya' where building_no = 31;
insert into apartment(street, building_no) values ('Lenina', 21);
select * from humans;
select f_name from humans;
update humans set owner_flag = 1 where perm_res_flag = 0;
insert into humans(f_name, l_name, owner_flag) values('Vasily', 'Pupkin', 1);
revert;
rollback;
print'__________________next row__________________';

select * from humans
use Home_management;



grant select(f_name, l_name, owner_flag), update(owner_flag) on humans to test;
execute as user = 'test';
select  * from categories;
select * from humans;
select f_name, l_name, owner_flag from humans;
update humans set owner_flag = 1 where f_name = 'Alex';
revert;
print'__________________next row__________________';

grant select on tariffes to test;
execute as user = 'test';
select * from tariffes;
select * from apt_tariff;
select serv_id from tariffes;
update tariffes set price = price + 14;
revert;

print'__________________next row__________________';

select * from view1;
begin tran
create role db_change_view;
grant update(street) on view1 to db_change_view;
execute sp_addrolemember db_change_view, test;
select * from view1;
update view1 set street = 'Pushkinskaya' where debt > 100;
revert;
print '___________________new row_____________________'
rollback;

drop role db_change_view
