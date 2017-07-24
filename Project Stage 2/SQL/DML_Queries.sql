-- Analysis on BTCAUD, and LTCBTC
-- Some of these queries are the same as the Unix based ones. 
-- However this is done in order to analysis how efficient the tools are compared to each other.
-- There are other queries which are exclusively done in SQL

-- Checks whether the data is outputted properly
SELECT * 
FROM cryptocurrency
LIMIT 4;

-- Columns are date, ltcbtc, open, high, low, close_p, vol_btc, vol_aud, weighted_price in this table

-- Get the values and the dates of the opening price of BTC in the month of April in 2015.
SELECT date AS Date, open AS Opening_BTCAUD_Price
FROM cryptocurrency 
WHERE date BETWEEN '2014-04-01' AND '2014-04-30';

-- Count the total values in the weighted_price column where it is not null
-- I do not need to add a where clause as PSQL automatically removes the null values in the weighted_price column
SELECT COUNT(weighted_price)
FROM cryptocurrency;

-- Get the dates and LTCBTC values of the top ten highest LTCBTC values
SELECT date, ltcbtc 
FROM cryptocurrency 
ORDER BY ltcbtc DESC 
LIMIT 10;

-- Average the open, high, low, close_p values together and find how many are greater than the avg weighted price
SELECT round(avg(open), 0) AS open, round(avg(high), 0) AS high, round(avg(low), 0) AS low, round(avg(close_p), 0) AS close_p
FROM cryptocurrency
WHERE open > (SELECT avg(weighted_price) FROM cryptocurrency) AND
	  high > (SELECT avg(weighted_price) FROM cryptocurrency) AND
	   low > (SELECT avg(weighted_price) FROM cryptocurrency) AND
   close_p > (SELECT avg(weighted_price) FROM cryptocurrency);

-- Count the total volume of BTC where the closing price was $350
SELECT '$' || (SUM(vol_aud)) AS Total_AUD_Volume
FROM cryptocurrency 
WHERE close_p = 350;

-- Find the average price of LTCBTC 
SELECT trunc(avg(LTCBTC), 4) AS avg_ltcbtc_price
FROM cryptocurrency;

-- Find the value of LTCBTC, weighted BTC price and the date where the high value of BTCAUD was $300 using a subquery
-- Sort the results in ascending LTCBTC values
SELECT date, weighted_price, ltcbtc 
FROM cryptocurrency 
WHERE high = (SELECT high WHERE high = 300) 
ORDER BY ltcbtc ASC;


