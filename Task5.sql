CREATE DATABASE SmartBusiness2

CREATE TABLE Product
(
	ProdID INT UNIQUE NOT NULL,
	Name   CHAR(50),
	Price  FLOAT
)

CREATE TABLE Sales
(
	Date   DATETIME,
	ProdID INT,
	Sum    FLOAT
)


SELECT P.Name, SUM(S.Sum) as Sum
FROM Sales AS S
left join Product as P on P.ProdID=S.ProdID
WHERE (S.ProdID=((SELECT P.ProdId 
	FROM Product AS P
	WHERE P.Price=(SELECT MAX(P.Price) FROM Product AS P)))) AND (S.Date<='2021-06-30 23:59:59.999') AND (S.Date >= '2021-06-01 00:00:00.000')
GROUP BY P.Name

	