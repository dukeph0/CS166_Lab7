-- Write the following SQL queries in queries.sql both with and without indexes.


--Count how many parts in NYC have more than 70 parts on hand
SELECT COUNT(PN.part_number)
FROM part_nyc PN
WHERE PN.on_hand > 70; --without index

SELECT PN.part_number, COUNT(*)
FROM part_nyc PN
WHERE PN.on_hand > 70
GROUP BY PN.part_number; --with index

--Count how many total parts on hand, in both NYC AND SFO, are Red
SELECT COUNT(PN.on_hand) AS pn_hand 
FROM part_nyc PN
WHERE PN.color = 'Red';
SELECT COUNT(PS.on_hand) AS ps_hand
FROM part_sfo PS
WHERE PS.color = 'Red';
SELECT (pn_hand + ps_hand); --without index

SELECT COUNT(*) AS pn_hand2
FROM part_nyc
WHERE color = 'Red';
SELECT COUNT(*) AS ps_hand2
FROM part_sfo
WHERE color = 'Red';
SELECT (pn_hand2 + ps_hand2); --with index

--List all the suppliers that have more total on_hand parts in NYC than they do in SFO.
SELECT S.supplier_name 
FROM supplier S, part_nyc PN, part_sfo PS
WHERE COUNT(PN.on_hand) > COUNT(PS.on_hand); --without index

SELECT S.supplier_name
FROM supplier S, part_nyc PN, part_sfo PS
WHERE COUNT(PN.*) > COUNT(PS.*); --with index

--List all the suppliers that supply parts in NYC that aren't supplied by anyone in SFO.
SELECT S.supplier_name
FROM supplier S, part_nyc PN, part_sfo PS
WHERE PN.part_number NOT PS.part_number --without index

SELECT S.supplier_name
FROM supplier S, part_nyc PN, part_sfo PS
WHERE PN.* NOT PS.*; --with index

--Update all of the NYC on_hand values to on_hand - 10.
UPDATE part_nyc
SET on_hand = (on_hand - 10); --without index

UPDATE *
SET on_hand = (on_hand - 10)
FROM part_nyc PN
WHERE on_hand = PN.on_hand; --with index

--Delete all parts from NYC which have less than 30 parts on_hand.
DELETE PN.part_number 
FROM part_nyc PN 
WHERE COUNT(PN.on_hand) < 30; --without index

DELETE PN.part_number 
FROM part_nyc PN
WHERE COUNT(PN.*) < 30; --with index
