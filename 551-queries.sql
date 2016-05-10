SELECT name
FROM Beers
WHERE manf = 'Anheuser-Busch';

SELECT *
FROM Beers
WHERE manf = 'Anheuser-Busch';

SELECT name AS beer, manf
FROM Beers
WHERE manf = 'Anheuser-Busch';

SELECT bar, beer,
	price * 120 AS priceInYen
FROM Sells;

SELECT drinker, 'likes Bud' AS whoLikesBud
FROM Likes
WHERE beer = 'Bud';

SELECT drinker, concat('likes ', beer) as whoLikesWhat
FROM Likes;

SELECT price
FROM Sells
WHERE bar = 'Joe''s Bar' AND
		beer = 'Bud';

SELECT name
FROM Drinkers
WHERE phone LIKE '%555-____';

SELECT bar
FROM Sells
WHERE price < 2.00 OR price >= 2.00;

select count(*)
from Sells;

select count(price)
from Sells;

SELECT bar
FROM Sells
WHERE price < 2.00 OR price >= 2.00 OR price is null;

-- multi-relation queries

SELECT beer
FROM Likes, Frequents
WHERE bar = 'Joe''s Bar' AND
		Frequents.drinker = Likes.drinker;

-- tuple variable
-- find all pairs of beers made by same manf.

SELECT b1.name, b2.name
FROM Beers b1, Beers b2
WHERE b1.manf = b2.manf AND
		b1.name < b2.name;

-- subqueries

-- bars that sell summerbrew at same price as bud solde at joe

-- without subquery
select S.bar
from sells S, sells S1
where S.beer = 'Summerbrew' and 
	S.price = S1.price and
	S1.bar = 'Joe''s bar' and
	S1.beer = 'Bud';

-- with subquery
select bar
from sells S
where beer = 'Summerbrew' and 
	price = 
		(select price 
		 from sells
		 where bar = 'Joe''s bar' and
			beer = 'Bud');

-- find name and manf of beers that Bill likes

-- without subquery
select name, manf
from beers, likes
where beers.name = likes.beer and likes.drinker = 'Bill';

-- with subquery
select name, manf
from beers
where name in (select beer from likes where drinker = 'Bill');

-- exists

-- find unique beer by its manufacturer

select name
from beers b1
where not exists(select name from beers b2 where
	b2.name != b1.name and b2.manf = b1.manf);


-- find beers sold at the highest price

select beer
from sells
where price >= all (select price from sells where price is not null);

-- set 

-- find drinker and beer s.t.
-- drinker likes the beer
-- and drinker frequents at least one bar that sells the beer

(select drinker, beer
from likes)
union
(select drinker, beer
from frequents, sells
where frequents.bar = sells.bar);

-- no intersect in mysql
-- alternative

-- use join
select distinct likes.drinker, likes.beer
from likes, frequents, sells
where likes.drinker = frequents.drinker
	and likes.beer = sells.beer 
	and frequents.bar = sells.bar;

-- or 
select drinker, beer
from likes
where  exists(
	select * 
	from frequents, sells
	where likes.drinker = frequents.drinker
	and likes.beer = sells.beer 
	and frequents.bar = sells.bar);

-- find drinker, beer s.t.
-- drinker likes the bear but does not go to any bar that sells the beer

-- no difference/except in mysql
(select drinker, beer
from likes)
except
-- these are pairs where drinker does go to bar that sells the beer
(select drinker, beer
from frequents, sells
where frequents.bar = sells.bar);

select drinker, beer
from likes
where not exists(
	select * 
	from frequents, sells
	where likes.drinker = frequents.drinker
	and likes.beer = sells.beer 
	and frequents.bar = sells.bar);

-- or use not in
select drinker, beer
from likes
where (drinker, beer) not in (
	select frequents.drinker, sells.beer
	from frequents, sells
	where likes.drinker = frequents.drinker
	and likes.beer = sells.beer 
	and frequents.bar = sells.bar);


-- or use left outer join

select distinct likes.drinker, likes.beer
from likes left outer join 
	(select distinct frequents.drinker, sells.beer 
		from frequents, sells
		where frequents.bar = sells.bar) as t
 on likes.drinker = t.drinker
	and likes.beer = t.beer
where t.drinker is null and t.beer is null;

-- check all results of left outer join
select *
from likes left outer join 
	(select distinct frequents.drinker, sells.beer 
		from frequents, sells
		where frequents.bar = sells.bar) as t
 on likes.drinker = t.drinker
	and likes.beer = t.beer;

-- note that this does not work
-- it will return drinker and beer as long as 
-- there is another drinker in frequents
select distinct likes.drinker, likes.beer
from likes, frequents, sells
where (likes.drinker != frequents.drinker
	or likes.beer != sells.beer)
	and frequents.bar = sells.bar; 


-- aggregation

SELECT beer, AVG(price)
FROM Sells
GROUP BY beer;

-- find avg price of beer either served by at least 3 bars or
-- manf by Pete's
SELECT beer, AVG(price)
FROM Sells
GROUP BY beer
HAVING COUNT(bar) >= 3 OR
	beer IN (SELECT name
			   FROM Beers
			   WHERE manf = 'Pete''s');


