CREATE DATABASE SmartBusiness
CREATE TABLE CustTable
(
	AccountNum INT UNIQUE NOT NULL,
	Name CHAR(50),
)

CREATE TABLE CustTrans
(
	CustAccount INT,
	TransDate DateTime,
	Amount INT
)


/*1*/
SELECT C.AccountNum, C.Name, CT.Amount
FROM CustTable as C
LEFT JOIN CustTrans as CT ON CT.CustAccount=C.AccountNum*/


/*2*/
SELECT AccountNum
FROM CustTable as C
left join	(SELECT CT.CustAccount, COUNT( DISTINCT CT.TransDate) as C
	FROM CustTrans  as CT
	WHERE (CT.TransDate <= '2021-01-31 23:59:59.999') AND (CT.TransDate >= '2021-01-01 00:00:00.000')
	GROUP BY CT.CustAccount) AS DOP ON DOP.CustAccount=C.AccountNum
WHERE DOP.C IS NULL


/*3*/
SELECT DOP.CustAccount
FROM  (SELECT CT.CustAccount,SUM(Amount) AS S
	FROM CustTrans  as CT
	WHERE (CT.TransDate <= '2021-01-31 23:59:59.999') AND (CT.TransDate >= '2021-01-01 00:00:00.000') /*указанный период*/
	GROUP BY CT.CustAccount) AS DOP
WHERE DOP.S IN (SELECT MAX(S) FROM (SELECT CT.CustAccount,SUM(Amount) AS S
	FROM CustTrans  as CT
	WHERE (CT.TransDate <= '2021-01-31 23:59:59.999') AND (CT.TransDate >= '2021-01-01 00:00:00.000') /*указанный период*/
	GROUP BY CT.CustAccount) AS DOP)



