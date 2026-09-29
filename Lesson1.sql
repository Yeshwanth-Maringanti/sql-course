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

-- overall count
SELECT count(*)
FROM   Customer;

--group by query
SELECT   TOP 3 c.Country,
               count(*) AS NumberofCustomers
FROM     Customer AS C
WHERE    c.Company IS NULL
GROUP BY c.Country
ORDER BY NumberofCustomers DESC;

-- INVOICES TABLE  
SELECT i.InvoiceId,
       i.InvoiceDate,
       i.CustomerId,
       i.Total
FROM   Invoice AS I
order by i.CustomerId asc;

-- GROUP BY EACH CUSTOEMR IN INVOICES TABLE  , descending order 

SELECT 
       i.CustomerId,
       sum(i.Total) as Total_Invoice
FROM   Invoice AS I
GROUP BY i.CustomerId
order by Total_Invoice desc;


-- get names of the customer from customer table  


SELECT 
       i.CustomerId,
      -- sum(i.Total) as Total_Invoice,
       c.FirstName
FROM   Invoice AS I JOIN  Customer c
on I.CustomerId = c.CustomerId;
--GROUP BY i.CustomerId
--order by Total_Invoice desc;