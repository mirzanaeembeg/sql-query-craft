CREATE TABLE IF NOT EXISTS "meteorites_temp" (
    "name" TEXT,
    "id" INTEGER,
    "nametype" TEXT,
    "class" TEXT,
    "mass" TEXT,
    "discovery" TEXT,
    "year" TEXT,
    "lat" TEXT,
    "long" TEXT
);


-- 1
UPDATE "meteorites_temp"
SET "mass" = NULL
WHERE "mass" = '';

UPDATE "meteorites_temp"
SET "year" = NULL
WHERE "year" = '';

UPDATE "meteorites_temp"
SET "lat" = NULL
WHERE "lat" = '';

UPDATE "meteorites_temp"
SET "long" = NULL
WHERE "long" = '';

-- 2
DELETE FROM "meteorites_temp"
WHERE "nametype" = 'Relict';

-- 3
UPDATE "meteorites_temp"
SET "mass" = ROUND("mass", 2);

UPDATE "meteorites_temp"
SET "lat" = ROUND("lat", 2);

UPDATE "meteorites_temp"
SET "long" = ROUND("long", 2);

-- 4
CREATE TABLE "meteorites" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "mass" NUMERIC,
    "discovery" TEXT NOT NULL CHECK("discovery" IN ('Fell', 'Found')),
    "year" INTEGER,
    "lat" NUMERIC,
    "long" NUMERIC
);

-- 5
INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long"
FROM "meteorites_temp"
ORDER BY "year" ASC, "name" ASC;

-- 6
DROP TABLE "meteorites_temp";
