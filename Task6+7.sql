CREATE DATABASE SmartBusiness3

CREATE TABLE Product
(
	ProdID INT UNIQUE NOT NULL,
	Cost   FLOAT,
	Name   CHAR(50)
)


CREATE TABLE PlanSales
(
	ProdId INT,
	PlanSum FLOAT,
	Year INT,
	Month INT
)

CREATE TABLE ActualSales
(
	ProdId INT,
	Sum FLOAT,
	Year INT,
	Month INT
)

SELECT  DISTINCT TAB.Year, TAB.Month, P.Name ,COALESCE(A.Sum,0) AS ActualSum,COALESCE(PS.PlanSum,0) AS PlanSum, (COALESCE(PS.PlanSum,0)-COALESCE(A.Sum,0)) AS Deviation
FROM	(SELECT PS.ProdId,PS.Year, PS.Month, PS.PlanSum
		 FROM PlanSales AS PS
		 JOIN ActualSales AS A ON A.ProdId=PS.ProdId
		 WHERE  (PS.Month!=A.Month) AND (PS.Year != A.Year)
		 UNION
		 SELECT A.ProdId,A.Year, A.Month, A.Sum
		 FROM ActualSales as A) AS TAB
JOIN	 Product AS P ON P.ProdID=TAB.ProdId
LEFT JOIN	 PlanSales AS PS ON (PS.Month=TAB.Month) AND (PS.Year=TAB.Year) AND (PS.ProdId=TAB.ProdId)
LEFT JOIN     ActualSales AS A ON (A.Month=TAB.Month) AND (A.Year=TAB.Year)  AND (A.ProdId=TAB.ProdId)