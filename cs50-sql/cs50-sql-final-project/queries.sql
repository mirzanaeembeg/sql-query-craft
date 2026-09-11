-- Add a patient
INSERT INTO "patients" ("first_name", "last_name", "email", "date_of_birth")
VALUES ('Amina', 'Rahman', 'amina.rahman@hotmail.com', '1998-04-12');

-- Add the hospital before affiliating a doctor with it
INSERT INTO "hospitals" ("name", "address")
VALUES ('Green Life Hospital', 'Dhaka, Bangladesh');

-- Add a doctor affiliated with a hospital
INSERT INTO "doctors" ("hospital_id", "first_name", "last_name", "specialty", "email", "chamber_address", "chamber_hours")
VALUES (1, 'Farhan', 'Islam', 'Cardiology', 'dr.farhan@hotmail.com', 'Room 204, Green Life Hospital, Dhaka', 'Sat-Thu 5pm-8pm');

-- Add a pharmaceutical company
INSERT INTO "pharma_companies" ("name", "address")
VALUES ('Square Pharmaceuticals', 'Gazipur, Bangladesh');

-- Add a medicine made by a pharmaceutical company
INSERT INTO "medicines" ("pharma_company_id", "name", "description")
VALUES (1, 'Napa Extra', 'Paracetamol 500mg + Caffeine 65mg');

-- Have a patient follow a doctor
INSERT INTO "follows" ("follower_type", "follower_id", "followee_type", "followee_id")
VALUES ('patient', 1, 'doctor', 1);

-- Have a doctor follow a research center
INSERT INTO "follows" ("follower_type", "follower_id", "followee_type", "followee_id")
VALUES ('doctor', 1, 'research_center', 1);

-- Have a pharmaceutical company follow a doctor
INSERT INTO "follows" ("follower_type", "follower_id", "followee_type", "followee_id")
VALUES ('pharma_company', 1, 'doctor', 1);

-- Find the doctors followed by a patient
SELECT "doctors".*
FROM "doctors"
JOIN "follows" ON "follows"."followee_id" = "doctors"."id"
WHERE "follows"."followee_type" = 'doctor'
AND "follows"."follower_type" = 'patient'
AND "follows"."follower_id" = 1;

-- Find the patients following a doctor
SELECT "patients".*
FROM "patients"
JOIN "follows" ON "follows"."follower_id" = "patients"."id"
WHERE "follows"."follower_type" = 'patient'
AND "follows"."followee_type" = 'doctor'
AND "follows"."followee_id" = 1;

-- A patient sends a question to a doctor
INSERT INTO "messages" ("patient_id", "doctor_id", "sender", "content")
VALUES (1, 1, 'patient', 'I have had chest tightness for two days, should I be worried?');

-- The doctor replies
INSERT INTO "messages" ("patient_id", "doctor_id", "sender", "parent_message_id", "content")
VALUES (1, 1, 'doctor', 1, 'Please visit my chamber today so I can examine you in person.');

-- Show a patient's conversation with a doctor, oldest messages first
SELECT *
FROM "messages"
WHERE "patient_id" = 1
AND "doctor_id" = 1
ORDER BY "sent_at" ASC;

-- Publish a tip for patients
INSERT INTO "posts" ("doctor_id", "title", "content")
VALUES (1, 'Managing Blood Pressure', 'Reduce salt intake and monitor your blood pressure twice a day.');

-- Show a doctor's posts, newest first
SELECT *
FROM "posts"
WHERE "doctor_id" = 1
ORDER BY "posted_at" DESC;

-- Write a prescription linked to the consultation message
INSERT INTO "prescriptions" ("doctor_id", "patient_id", "message_id")
VALUES (1, 1, 2);

-- Add a medicine to the prescription
INSERT INTO "prescription_items" ("prescription_id", "medicine_id", "dosage", "quantity")
VALUES (1, 1, '1 tablet twice daily after meals', 10);

-- Show a patient's prescriptions and medicines
SELECT "prescriptions"."id", "prescriptions"."issued_at", "medicines"."name", "prescription_items"."dosage", "prescription_items"."quantity"
FROM "prescriptions"
JOIN "prescription_items" ON "prescription_items"."prescription_id" = "prescriptions"."id"
JOIN "medicines" ON "medicines"."id" = "prescription_items"."medicine_id"
WHERE "prescriptions"."patient_id" = 1;

-- Give a doctor free medicine samples
INSERT INTO "medicine_samples" ("pharma_company_id", "doctor_id", "medicine_id", "quantity")
VALUES (1, 1, 1, 20);

-- Show the samples given out by a pharmaceutical company
SELECT "doctors"."first_name", "doctors"."last_name", "medicines"."name", "medicine_samples"."quantity", "medicine_samples"."provided_at"
FROM "medicine_samples"
JOIN "doctors" ON "doctors"."id" = "medicine_samples"."doctor_id"
JOIN "medicines" ON "medicines"."id" = "medicine_samples"."medicine_id"
WHERE "medicine_samples"."pharma_company_id" = 1;

-- Add a pharmacy
INSERT INTO "pharmacies" ("name", "address")
VALUES ('Lazz Pharma', 'Dhanmondi, Dhaka');

-- Record a bulk medicine shipment to a pharmacy
INSERT INTO "pharmacy_supplies" ("pharma_company_id", "pharmacy_id", "medicine_id", "quantity")
VALUES (1, 1, 1, 500);

-- Show the medicines supplied to a pharmacy
SELECT "medicines"."name", SUM("pharmacy_supplies"."quantity") AS "total_supplied"
FROM "pharmacy_supplies"
JOIN "medicines" ON "medicines"."id" = "pharmacy_supplies"."medicine_id"
WHERE "pharmacy_supplies"."pharmacy_id" = 1
GROUP BY "medicines"."name";

-- Record a patient's medicine collection
INSERT INTO "medicine_collections" ("prescription_item_id", "pharmacy_id")
VALUES (1, 1);

-- Show the medicines collected by a patient and their pharmacies
SELECT "medicines"."name", "pharmacies"."name" AS "pharmacy_name", "medicine_collections"."collected_at"
FROM "medicine_collections"
JOIN "prescription_items" ON "prescription_items"."id" = "medicine_collections"."prescription_item_id"
JOIN "medicines" ON "medicines"."id" = "prescription_items"."medicine_id"
JOIN "prescriptions" ON "prescriptions"."id" = "prescription_items"."prescription_id"
JOIN "pharmacies" ON "pharmacies"."id" = "medicine_collections"."pharmacy_id"
WHERE "prescriptions"."patient_id" = 1;

-- Find cardiologists affiliated with a hospital
SELECT "first_name", "last_name", "chamber_address", "chamber_hours"
FROM "doctors"
WHERE "specialty" = 'Cardiology'
AND "hospital_id" = 1;

-- Change a patient's email address
UPDATE "patients"
SET "email" = 'amina.rahman@outlook.com'
WHERE "id" = 1;

-- Update a doctor's specialty and hours
UPDATE "doctors"
SET "specialty" = 'Internal Medicine',
    "chamber_hours" = 'Sat-Thu 4pm-7pm'
WHERE "id" = 1;

-- Correct a message
UPDATE "messages"
SET "content" = 'I have had chest tightness for three days, should I be worried?'
WHERE "id" = 1
AND "patient_id" = 1
AND "doctor_id" = 1;

-- Edit a doctor's post
UPDATE "posts"
SET "title" = 'Managing Blood Pressure Safely',
    "content" = 'Reduce salt intake and monitor your blood pressure twice a day.'
WHERE "id" = 1
AND "doctor_id" = 1;

-- Update the quantity in a pharmacy shipment
UPDATE "pharmacy_supplies"
SET "quantity" = 750
WHERE "id" = 1
AND "pharmacy_id" = 1
AND "medicine_id" = 1;

-- Unfollow a doctor
DELETE FROM "follows"
WHERE "follower_type" = 'patient'
AND "follower_id" = 1
AND "followee_type" = 'doctor'
AND "followee_id" = 1;

-- Remove a medicine collection record
DELETE FROM "medicine_collections"
WHERE "id" = 1;

-- Delete a prescription's medicine items before deleting the prescription
DELETE FROM "prescription_items"
WHERE "prescription_id" = 1;

DELETE FROM "prescriptions"
WHERE "id" = 1
AND "patient_id" = 1
AND "doctor_id" = 1;

-- Delete a doctor's post
DELETE FROM "posts"
WHERE "id" = 1
AND "doctor_id" = 1;
