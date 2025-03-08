CREATE TABLE customer_details(ID int,
Year_Birth int,
Education varchar(30),
Marital_Status	varchar(30),
Income int,
Kidhome int,
Teenhome int,
Dt_Customer date,
Recency int,
MntWines int,
MntFruits int,
MntMeatProducts	int,
MntFishProducts int,
MntSweetProducts int,
MntGoldProds int,
NumDealsPurchases int,
NumWebPurchases int,
NumCatalogPurchases	int,
NumStorePurchases int,
NumWebVisitsMonth int,	
AcceptedCmp3 int,
AcceptedCmp4 int,
AcceptedCmp5 int,
AcceptedCmp1 int,
AcceptedCmp2 int,
Complain int,	
Z_CostContact int,
Z_Revenue int,
Response int
)

Select * from customer_details
WHERE 
ID IS NULL OR
Year_Birth IS NULL OR
Education IS NULL OR
Marital_Status	IS NULL OR
Income IS NULL OR
Kidhome IS NULL OR
Teenhome IS NULL OR
Dt_Customer IS NULL OR
Recency IS NULL OR
MntWines IS NULL OR
MntFruits IS NULL OR
MntMeatProducts	IS NULL OR
MntFishProducts IS NULL OR
MntSweetProducts IS NULL OR
MntGoldProds IS NULL OR
NumDealsPurchases IS NULL OR
NumWebPurchases IS NULL OR
NumCatalogPurchases IS NULL OR
NumStorePurchases IS NULL OR
NumWebVisitsMonth IS NULL OR	
AcceptedCmp3 IS NULL OR
AcceptedCmp4 IS NULL OR
AcceptedCmp5 IS NULL OR
AcceptedCmp1 IS NULL OR
AcceptedCmp2 IS NULL OR
Complain IS NULL OR	
Z_CostContact IS NULL OR
Z_Revenue IS NULL OR
Response IS NULL 

-- CUSTOMER DEMOGRAPHICS
-- WHAT IS THE AVERAGE AGE OF CUSTOMERS IN THE DATSET??
--QUERY
SELECT AVG(EXTRACT (YEAR FROM NOW () - year_birth * INTERVAL '1 YEAR' )) FROM customer_details


-- HOW MANY CUSTOMERS FALL INTO EACH EDUCATION LEVEL CATEGORY??
--QUERY
SELECT COUNT (*) AS total_count, education
FROM customer_details
WHERE education IS NOT NULL
GROUP BY education 
ORDER BY total_count DESC

--what is distribution of marital status among the customers??
-- Query
SELECT marital_status,COUNT(*) AS count_of_marital_status 
FROM customer_details
WHERE marital_status IS NOT NULL
GROUP BY marital_status
ORDER BY 2 DESC

-- WHAT IS THE AVERGAE HOUSEHOLD INCOME OF THE CUSTOMERS???
-- QUERY
SELECT AVG(income) as average_income_of_customers
FROM customer_details
WHERE income IS NOT NULL

-- HOW MANY CUSTOMERS HAVE CHILDREN AND TEENAGERS IN THEIR HOUSEHOLDS??
--QUERY
SELECT  count(*) as count, kidhome,teenhome 
FROM customer_details
WHERE kidhome IS NOT NULL AND teenhome IS NOT NULL
GROUP BY kidhome,teenhome 
ORDER BY 1 DESC 

-- WHAT IS THE AVERAGE NUMBER OF DAYS SINCE LAST PURCHASE ??
-- QUERY 
SELECT CAST(AVG(recency) AS numeric(15,2))as AVERAGE_NUMBER_OF_DAYS_SINCE_LAST_PURCHASE
FROM customer_details

-- HOW MUCH ON AVERAGE DO CUSTOMERS SPEND ON EACH PRODUCT CATEGORY??
--QUERY 
    SELECT
        AVG(mntwines) AS avg_mntwines,
        AVG(mntfruits) AS avg_mntfruits,
        AVG(mntmeatproducts) AS avg_mntmeatproducts,
        AVG(mntfishproducts) AS avg_mntfishproducts,
        AVG(mntsweetproducts) AS avg_mntsweetproducts,
        AVG(mntgoldprods) AS avg_mntgoldproducts
    FROM customer_details

-- HOW MUCH ON AVERAGE DO CUSTOMERS SPEND ON EACH PRODUCT CATEGORY??
--QUERY 

SELECT 'avg_mntwines' AS labels, AVG(mntwines) AS average FROM customer_details
UNION ALL
SELECT 'avg_mntfruits' AS labels, AVG(mntfruits) AS average FROM customer_details
UNION ALL
SELECT 'avg_mntmeatproducts' AS labels, AVG(mntmeatproducts) AS average FROM customer_details
UNION ALL
SELECT 'avg_mntfishproducts' AS labels, AVG(mntfishproducts) AS average FROM customer_details
UNION ALL
SELECT 'avg_mntsweetproducts' AS labels, AVG(mntsweetproducts) AS average FROM customer_details
UNION ALL
SELECT 'avg_mntgoldprods' AS labels, AVG(mntgoldprods) AS average FROM customer_details;


-- HOW MANY CUSTOMERS ACCEPTED THE EACH CAMPAIGN OFFER???
-- QUERY
SELECT 'sum_of_acceptedcmp1' AS different_campaigns, SUM(acceptedcmp1) AS total FROM customer_details
UNION ALL 
SELECT 'sum_of_acceptedcmp2' AS different_campaigns, SUM(acceptedcmp2) AS total FROM customer_details
UNION ALL
SELECT 'sum_of_acceptedcmp3' AS different_campaigns, SUM(acceptedcmp3) AS total FROM customer_details
UNION ALL
SELECT 'sum_of_acceptedcmp4' AS different_campaigns, SUM(acceptedcmp4) AS total FROM customer_details
UNION ALL
SELECT 'sum_of_acceptedcmp5' AS different_campaigns, SUM(acceptedcmp5) AS total FROM customer_details

-- What is the overall response rate for the last campaign??
-- Query
SELECT COUNT(*) AS total, SUM(response) AS responses,((SUM(response)*100.0)/COUNT(*)) AS response_rate
FROM customer_details

--  HOW MANY PURCHASES ARE MADE THROUGH WEBSITE,CATALOG AND IN-STORE??
--QUERY
SELECT SUM(numwebpurchases) AS total_purchases,SUM(numcatalogpurchases) AS total_catalog_purchases,SUM(numstorepurchases) AS total_store_purchases
FROM customer_details

--  HOW MANY PURCHASES ARE MADE THROUGH WEBSITE,CATALOG AND IN-STORE??
--QUERY

SELECT 'websitepurchases_sum' as categories, SUM(numwebpurchases) AS TOTAL FROM customer_details
UNION ALL 
SELECT 'catalogpurchases_sum' as categories, SUM(numcatalogpurchases) AS TOTAL FROM customer_details
UNION ALL 
SELECT 'storepurchases_sum' as categories, SUM(numstorepurchases) AS TOTAL FROM customer_details
ORDER BY 2 DESC


-- WHAT IS THE AVERAGE NUMBER OF WEB VISITS PER MONTH??
-- QUERY
SELECT CAST(AVG(numwebvisitsmonth)AS numeric(10,2)) as Average_webvisits
FROM customer_details
WHERE numwebvisitsmonth IS NOT NULL

-- HOW MANY CUSTOMERS HAVE COMPLAINED IN THE LAST TWO YEARS ???
-- QUERY

SELECT COUNT(*),EXTRACT (YEAR FROM dt_customer) AS year_
FROM customer_details
WHERE complain = 1
GROUP BY EXTRACT (YEAR FROM dt_customer)
ORDER BY 1 DESC

-- WHAT IS THE OVERALL ENGAGEMENT RATE AMONG CUSTOMERS ??
--QUERY
SELECT 
SUM(acceptedcmp1)+SUM(acceptedcmp2)+SUM(acceptedcmp3)+SUM(acceptedcmp4)+SUM(acceptedcmp5)+SUM(response) AS OVERALL_ENGAGEMENT, COUNT(*)*6 AS total,
(SUM(acceptedcmp1)+SUM(acceptedcmp2)+SUM(acceptedcmp3)+SUM(acceptedcmp4)+SUM(acceptedcmp5)+SUM(response))*100.0/(COUNT(*)*6)  AS OVERALL_ENGAGEMENT_rate 
FROM customer_details

--WHAT IS THE AVERAGE NUMBER OF DEALS AND PURCHASES MADE BY CUSTOMERS??

SELECT AVG(numdealspurchases+numwebpurchases+numcatalogpurchases+numstorepurchases) AS avg_purchases
FROM customer_details


--WHICH CAMPAIGN HAS THE HIGHEST ACCEPTANCE RATE??
-- QUERY

SELECT
campaign,
sum(response) as Accepted,
count(*) AS Total
From (
	SELECT 'campaign1' as campaign, response from customer_details where acceptedcmp1=1
	UNION ALL 
	SELECT 'campaign2' as campaign, response from customer_details where acceptedcmp2= 1
	UNION ALL
	SELECT 'campaign3' as campaign, response from customer_details where acceptedcmp3=1
	UNION ALL
	SELECT 'campaign4' as campaign, response from customer_details where acceptedcmp4=1
	UNION ALL
	SELECT 'campaign5' as campaign, response from customer_details where acceptedcmp5=1
	UNION ALL
	SELECT 'lastcategory' as campaign, response from customer_details where response=1
)AS campaignData
GROUP BY campaign 
order by 3 desc

-- WHAT IS THE CORRELATION BETWEEN THE NUMBER OF WEBVISITS AND WEBPURCHASES??
--QUERY

SELECT CORR(numwebpurchases,numwebvisitsmonth)
FROM customer_details

-- what is the overall distribution of spending across all product categories??
-- QUERY 
SELECT 'mntwines_total' AS product_categories, SUM(mntwines) AS total FROM customer_details
UNION ALL
SELECT 'mntfruits_total' AS product_categories, SUM(mntfruits) AS total FROM customer_details
UNION ALL
SELECT 'mntmeatproducts_total' AS product_categories, SUM(mntmeatproducts) AS total FROM customer_details
UNION ALL
SELECT 'mntfishproducts_total' AS product_categories, SUM(mntfishproducts) AS total FROM customer_details
UNION ALL
SELECT 'mntsweetproducts_total' AS product_categories, SUM(mntsweetproducts) AS total FROM customer_details
UNION ALL
SELECT 'mntgoldproducts_total' AS product_categories, SUM(mntgoldprods) AS total FROM customer_details

WHERE mntwines IS NOT NULL AND mntfruits IS NOT NULL AND mntmeatproducts IS NOT NULL AND mntfishproducts IS NOT NULL AND mntsweetproducts  IS NOT NULL AND  mntgoldprods IS NOT NULL
ORDER BY 2 DESC