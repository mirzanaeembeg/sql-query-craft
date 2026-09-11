
-- *** The Lost Letter ***

-- Find the address id for the sender's address
SELECT id FROM addresses
WHERE address = "900 Somerville Avenue";

-- -- Find the address id for the recipient's address.
-- --But it was more sorrowful for me that in the problem description the street address spelling is "2 Finnegan Street" and in the DB it is "2 Finnigan Street"
-- -- I debug it by the following hardcode query
SELECT * FROM packages WHERE from_address_id IN (SELECT id FROM addresses WHERE address = "900 Somerville Avenue");
SELECT * FROM scans WHERE package_id = 384; SELECT * FROM scans WHERE package_id = 384 AND address_id = 854;
SELECT address FROM addresses WHERE ID = 854;

SELECT id FROM addresses
WHERE address = "2 Finnigan Street";

--Find the packages using both address IDs
SELECT id, contents FROM packages
WHERE from_address_id = (SELECT id FROM addresses
                            WHERE address = "900 Somerville Avenue")
AND
to_address_id = (SELECT id FROM addresses
                    WHERE address = "2 Finnigan Street");

--Find the most recent Drop scan for this package
SELECT address_id, action, timestamp FROM scans
WHERE package_id = (
    SELECT id FROM packages
    WHERE from_address_id = (SELECT id FROM addresses
                                WHERE address = "900 Somerville Avenue")
    AND
    to_address_id = (SELECT id FROM addresses
                        WHERE address = "2 Finnigan Street")
)
AND action = 'Drop'
ORDER BY timestamp DESC
LIMIT 1;

--Final query for finding the address details (address and type)
SELECT address, type FROM addresses
WHERE id = (
    SELECT address_id FROM scans
    WHERE package_id = (
                        SELECT id FROM packages
                        WHERE from_address_id = (SELECT id FROM addresses
                                                WHERE address = "900 Somerville Avenue")
                        AND
                        to_address_id = (SELECT id FROM addresses
                                        WHERE address = "2 Finnigan Street")
                        )
    AND action = 'Drop'
    ORDER BY timestamp DESC
    LIMIT 1
);


-- *** The Devious Delivery ***
Quack to bath times means there is somthing like duck and no from address means from_address_id is NULL
Find the suspicious package with no sender address and quack to bath time
SELECT id, contents FROM packages
WHERE from_address_id IS NULL;

-- Find the most recent Drop scan for this package
SELECT address_id FROM scans
WHERE package_id = (SELECT id FROM packages
                    WHERE from_address_id IS NULL)
AND action = 'Drop'
ORDER BY timestamp DESC
LIMIT 1;

-- Find the address details and contents
SELECT p.contents, a.type FROM packages p
JOIN scans s ON s.package_id = p.id
JOIN addresses a ON a.id = s.address_id
WHERE p.from_address_id IS NULL
AND s.action = 'Drop'
ORDER BY s.timestamp DESC
LIMIT 1;

-- *** The Forgotten Gift ***

-- Find the contents of the gift
SELECT id, contents FROM packages
WHERE from_address_id = (SELECT id FROM addresses
                         WHERE address = '109 Tileston Street')
AND to_address_id = (SELECT id FROM addresses
                     WHERE address = '728 Maple Place')
;

-- Final query to find out the Who has the Forgotten Gift
SELECT d.name, p.contents
FROM packages p
JOIN scans s ON s.package_id = p.id
JOIN drivers d ON d.id = s.driver_id
WHERE p.from_address_id = (
    SELECT id FROM addresses
    WHERE address = '109 Tileston Street'
)
AND p.to_address_id = (
    SELECT id FROM addresses
    WHERE address = '728 Maple Place'
)
ORDER BY s.timestamp DESC
LIMIT 1;
