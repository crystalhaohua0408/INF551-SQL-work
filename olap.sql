drop table if exists Sells;
drop table if exists Purchase;

drop table if exists Beers;
create table Beers(name varchar(100), manf varchar(100), primary key(name, manf));

insert into Beers values('Bud', 'Anheuser-Busch');
insert into Beers values('Bud Lite', 'Anheuser-Busch');
insert into Beers values('Michelob', 'Anheuser-Busch');
insert into Beers values('Summerbrew', 'Pete''s');

drop table if exists Bars;
create table Bars(name varchar(100) primary key, addr varchar(100));

insert into Bars values('Joe''s bar', 'Maple St.');
insert into Bars values('Bob''s bar', 'Maple St.');
insert into Bars values('Mary''s bar', 'Sunny Dr.');


drop table if exists Drinkers;
create table Drinkers(name varchar(100) primary key, addr varchar(100),
	phone varchar(20));

insert into Drinkers values('Steve', 'Vermont St.', '213-555-1234');
insert into Drinkers values('Bill', 'Jefferson St.', '213-555-0101');
insert into Drinkers values('Jennifer', 'Maple St.', '626-552-1234');

drop table if exists Sells;
create table Sells(bar varchar(100), 
	beer varchar(100), 
	price int, 
	primary key(bar, beer),
	foreign key (bar) references Bars(name),
	foreign key (beer) references Beers(name));

insert into Sells values('Joe''s bar', 'Bud', 3);
insert into Sells values('Joe''s bar', 'Bud Lite', 3);
insert into Sells values('Joe''s bar', 'Summerbrew', 4);
insert into Sells values('Joe''s bar', 'Michelob', 3);
insert into Sells values('Bob''s bar', 'Bud', 3);
insert into Sells values('Bob''s bar', 'Summerbrew', 3);
insert into Sells values('Mary''s bar', 'Bud', null);
insert into Sells values('Mary''s bar', 'Bud Lite', 3);


drop table if exists Purchase;
create table Purchase(bar varchar(100),
	beer varchar(100),
	drinker varchar(100),
	ptime datetime, -- purchase time
	quantity int, -- how beers purchased, note unit price in Sells table
	primary key(bar, beer, drinker, ptime),
	foreign key (bar) references Bars(name),
	foreign key (beer) references Beers(name),
	foreign key (drinker) references Drinkers(name));

insert into Purchase 
	values('Joe''s bar', 'Bud', 'Steve', '2015-10-5 9:50:09', 2);
insert into Purchase 
	values('Joe''s bar', 'Bud', 'Steve', '2015-10-15 9:50:09', 2);
insert into Purchase 
	values('Joe''s bar', 'Bud', 'Bill', '2015-10-4 10:24:48', 3);
insert into Purchase 
	values('Joe''s bar', 'Bud', 'Jennifer', '2015-10-8 12:45:46', 5);
insert into Purchase 
	values('Joe''s bar', 'Bud Lite', 'Steve', '2015-10-8 9:50:09', 3);
insert into Purchase 
	values('Joe''s bar', 'Bud Lite', 'Bill', '2015-10-8 10:24:48', 1);
insert into Purchase 
	values('Joe''s bar', 'Michelob', 'Jennifer', '2015-10-9 12:45:46', 2);
insert into Purchase 
	values('Joe''s bar', 'Summerbrew', 'Jennifer', '2015-10-20 12:45:46', 2);
insert into Purchase 
	values('Bob''s bar', 'Summerbrew', 'Steve', '2015-10-2 23:45:52', 2);
insert into Purchase 
	values('Bob''s bar', 'Bud', 'Steve', '2015-10-8 15:21:23', 3);

insert into Purchase 
	values('Mary''s bar', 'Bud', 'Jennifer', '2015-10-2 23:31:47', 3);
insert into Purchase 
	values('Mary''s bar', 'Bud Lite', 'Jennifer', '2015-10-12 21:31:47', 2);

insert into Purchase 
	values('Joe''s bar', 'Bud', 'Steve', '2015-9-6 12:50:09', 1);
insert into Purchase 
	values('Joe''s bar', 'Bud Lite', 'Steve', '2015-9-15 16:38:21', 1);
insert into Purchase 
	values('Bob''s bar', 'Summerbrew', 'Steve', '2015-9-2 23:45:52', 1);
insert into Purchase 
	values('Bob''s bar', 'Bud', 'Steve', '2015-9-8 15:21:23', 1);
insert into Purchase 
	values('Mary''s bar', 'Bud', 'Jennifer', '2015-9-2 23:31:47', 1);
insert into Purchase 
	values('Mary''s bar', 'Michelob', 'Jennifer', '2015-9-12 21:31:47', 2);
