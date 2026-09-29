-- 1first query
SELECT   c.FirstName,
         c.LastName,
         c.City,
         c.Company,
         c.CustomerId
FROM     Customer AS c
WHERE    Company IS NOT NULL
--WHERE  c.City in ('London' , 'Paris' , 'Berlin')
--where c.LastName like 'S%'
ORDER BY c.LastName DESC;

-- 2 overall count
SELECT count(*)
FROM   Customer;

-- 3group by query
SELECT   TOP 3 c.Country,
               count(*) AS NumberofCustomers
FROM     Customer AS C
WHERE    c.Company IS NULL
GROUP BY c.Country
ORDER BY NumberofCustomers DESC;

-- 4 INVOICES TABLE  
SELECT   i.InvoiceId,
         i.InvoiceDate,
         i.CustomerId,
         i.Total
FROM     Invoice AS I
ORDER BY i.CustomerId ASC;

-- 5 GROUP BY EACH CUSTOEMR IN INVOICES TABLE  , descending order 
SELECT   i.CustomerId,
         sum(i.Total) AS Total_Invoice
FROM     Invoice AS I
GROUP BY i.CustomerId
ORDER BY Total_Invoice DESC;

-- 6 get names of the customer from customer table  
SELECT i.CustomerId,
       -- sum(i.Total) as Total_Invoice,
       c.FirstName
FROM   Invoice AS I
       INNER JOIN
       Customer AS c
       ON I.CustomerId = c.CustomerId;

--GROUP BY i.CustomerId
--order by Total_Invoice desc;
-- 7 using concat function 
SELECT c.CustomerId,
       c.FirstName,
       c.LastName,
       --c.FirstName+' '+c.LastName as customername,
       concat(c.FirstName, ' ', c.LastName) AS CustomerName,
       c.City
FROM   Customer AS c;

-- 8 to join customer , invoice tables 
SELECT   i.CustomerId,
         c.FirstName,
         c.LastName,
         SUM(i.Total) AS InvoiceTotal,
         count(*) AS NoofInvoices
FROM     Invoice AS i
         INNER JOIN
         Customer AS C
         ON i.CustomerId = c.CustomerId
GROUP BY i.CustomerId, c.FirstName, c.lastname
ORDER BY i.CustomerId;

-- 9 Creating a sub query 
SELECT *
FROM   (SELECT   i.CustomerId,
                 SUM(i.Total) AS InvoiceTotal,
                 COUNT(*) AS NumberOfInvoices
        FROM     Invoice AS i
        GROUP BY i.CustomerId) AS IBC;

--10.  joining customer table , subquery
SELECT ibc.CustomerId,
       c.FirstName,
       concat(c.FirstName, ' ', c.LastName) AS CustomerName,
       ibc.InvoiceTotal,
       ibc.NumberOfInvoices
FROM   (SELECT   i.CustomerId,
                 SUM(i.Total) AS InvoiceTotal,
                 COUNT(*) AS NumberOfInvoices
        FROM     Invoice AS i
        GROUP BY i.CustomerId) AS IBC
       INNER JOIN
       Customer AS c
       ON ibc.CustomerId = c.CustomerId;

--11 customer ,employee table join 
SELECT e.EmployeeId,
       c.SupportRepId,
       e.FirstName,
       e.LastName
FROM   Employee AS e
       INNER JOIN
       Customer AS c
       ON e.EmployeeId = c.SupportRepId;

-- 12 joining customer, employee, and invoice tables
SELECT i.InvoiceId,
       i.InvoiceDate,
       i.Total,
       c.CustomerId,
       CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
       e.EmployeeId,
       CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName
FROM   Invoice AS i
       INNER JOIN
       Customer AS c
       ON i.CustomerId = c.CustomerId
       INNER JOIN
       Employee AS e
       ON c.SupportRepId = e.EmployeeId;

SELECT ibc.CustomerId,
       CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
       CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
       ibc.InvoiceTotal,
       ibc.NumberOfInvoices
FROM   (SELECT   i.CustomerId,
                 SUM(i.Total) AS InvoiceTotal,
                 COUNT(*) AS NumberOfInvoices
        FROM     Invoice AS i
        GROUP BY i.CustomerId) AS ibc
       INNER JOIN
       Customer AS c
       ON ibc.CustomerId = c.CustomerId
       INNER JOIN
       Employee AS e
       ON c.SupportRepId = e.EmployeeId;