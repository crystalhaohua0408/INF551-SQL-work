drop table if exists sales;
create table sales(bar varchar(100) , 
	beer varchar(100) ,
	drinker varchar(100) , 
	ptime datetime, -- purchase time
	quantity int
    );
insert into sales select * from Purchase;
alter table sales add column amount int;
alter table sales add foreign key(bar) references Bars(name);
alter table sales add foreign key(beer)references Beers(name);
alter table sales add foreign key(drinker) references Drinkers(name);


SET SQL_SAFE_UPDATES = 0;
update sales,Sells set amount = Sells.price * quantity
where sales.bar = Sells.bar and sales.beer = Sells.beer;
delete from sales where amount is null;

select month(ptime) , sum(amount) from sales
group by month(ptime)
order by sum(amount) desc;

select bar,sum(amount) from sales
where month(ptime)=9
group by bar;

select bar,sum(amount) from sales
where month(ptime)=10
group by bar;

select bar, month(ptime),sum(amount) from sales
group by bar,month(ptime)
order by sum(ptime) desc;

select beer ,sum(amount) from sales
group by beer
order by sum(amount) desc;

select bar from sales
where beer = (select beer from sales group by beer order by sum(amount) desc limit 1)
group by bar
order by sum(amount) desc;

select bar ,sum(amount) from sales
group by bar
order by sum(amount) desc;

select addr from Bars
where (select bar from sales group by bar order by sum(amount) desc limit 1) = name;

drop view if exists bar_mon_view;
create view bar_mon_view as
select bar,  extract(month from ptime) mon, sum(amount) amt
from sales
group by bar, mon;

select mon,sum(amt) from bar_mon_view
group by mon
order by sum(amt) desc;

select sum(amt) from bar_mon_view
where mon=10
group by mon;







