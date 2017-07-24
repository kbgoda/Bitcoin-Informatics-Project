-- Makes sure the table is created and the data is inputted in the table. Otherwise rollback to previous state.
START TRANSACTION;

DROP TABLE IF EXISTS cryptocurrency CASCADE;

CREATE TABLE cryptocurrency (
	date DATE,
	ltcbtc NUMERIC,
	open NUMERIC(10),
	high NUMERIC(10),
	low NUMERIC(10),
	close_p NUMERIC(10),
	vol_btc NUMERIC(10),
	vol_aud NUMERIC(10),
	weighted_price NUMERIC(10),
	PRIMARY KEY(DATE)
);

-- Formats date so it can be inputted in the SQL Db
SET datestyle TO DMY;

-- Modify the file location if you wish to test it.
COPY cryptocurrency(date, ltcbtc, open, high, low, close_p, vol_btc, vol_aud, weighted_price)
FROM '/Users/kbgoda/Desktop/Y1S1/INFO1903/Assignments/Project Stage 2/SQL/mergeLBAUD.csv'
WITH CSV HEADER DELIMITER AS ',';

CREATE INDEX ON cryptocurrency(vol_btc);

COMMIT;
