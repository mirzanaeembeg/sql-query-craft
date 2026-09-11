-- Represent hospitals
CREATE TABLE "hospitals" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "phone" TEXT,
    PRIMARY KEY("id")
);

-- Represent medical research centers
CREATE TABLE "research_centers" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent pharmaceutical companies
CREATE TABLE "pharma_companies" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent pharmacies
CREATE TABLE "pharmacies" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent doctors, optionally affiliated with a hospital
CREATE TABLE "doctors" (
    "id" INTEGER,
    "hospital_id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "specialty" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "chamber_address" TEXT,
    "chamber_hours" TEXT,
    "registered" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("hospital_id") REFERENCES "hospitals"("id")
);

-- Represent patients
CREATE TABLE "patients" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "date_of_birth" NUMERIC,
    "registered" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id")
);

-- Represent medicines, each manufactured by one pharmaceutical company
CREATE TABLE "medicines" (
    "id" INTEGER,
    "pharma_company_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    PRIMARY KEY("id"),
    FOREIGN KEY("pharma_company_id") REFERENCES "pharma_companies"("id"),
    UNIQUE("pharma_company_id", "name")
);

-- Represent "follow" connections between any two users in the network
-- (e.g. patient follows doctor, doctor follows research center,
-- pharma company follows doctor).
CREATE TABLE "follows" (
    "id" INTEGER,
    "follower_type" TEXT NOT NULL CHECK("follower_type" IN ('patient', 'doctor', 'hospital', 'pharmacy', 'pharma_company', 'research_center')),
    "follower_id" INTEGER NOT NULL,
    "followee_type" TEXT NOT NULL CHECK("followee_type" IN ('patient', 'doctor', 'hospital', 'pharmacy', 'pharma_company', 'research_center')),
    "followee_id" INTEGER NOT NULL,
    "followed_at" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    UNIQUE("follower_type", "follower_id", "followee_type", "followee_id")
);

-- Represent messages exchanged between a patient and a doctor,
-- e.g. a patient's question and the doctor's reply
CREATE TABLE "messages" (
    "id" INTEGER,
    "patient_id" INTEGER NOT NULL,
    "doctor_id" INTEGER NOT NULL,
    "sender" TEXT NOT NULL CHECK("sender" IN ('patient', 'doctor')),
    "parent_message_id" INTEGER,
    "content" TEXT NOT NULL,
    "sent_at" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("patient_id") REFERENCES "patients"("id"),
    FOREIGN KEY("doctor_id") REFERENCES "doctors"("id"),
    FOREIGN KEY("parent_message_id") REFERENCES "messages"("id")
);

-- Represent posts made by doctors: specialty tips, advice, chamber updates
CREATE TABLE "posts" (
    "id" INTEGER,
    "doctor_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "posted_at" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("doctor_id") REFERENCES "doctors"("id")
);

-- Represent a prescription written by a doctor for a patient,
-- optionally originating from a specific message thread
CREATE TABLE "prescriptions" (
    "id" INTEGER,
    "doctor_id" INTEGER NOT NULL,
    "patient_id" INTEGER NOT NULL,
    "message_id" INTEGER,
    "issued_at" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("doctor_id") REFERENCES "doctors"("id"),
    FOREIGN KEY("patient_id") REFERENCES "patients"("id"),
    FOREIGN KEY("message_id") REFERENCES "messages"("id")
);

-- Represent individual medicine line items within a prescription
CREATE TABLE "prescription_items" (
    "id" INTEGER,
    "prescription_id" INTEGER NOT NULL,
    "medicine_id" INTEGER NOT NULL,
    "dosage" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL CHECK("quantity" > 0),
    PRIMARY KEY("id"),
    FOREIGN KEY("prescription_id") REFERENCES "prescriptions"("id"),
    FOREIGN KEY("medicine_id") REFERENCES "medicines"("id")
);

-- Represent free medicine samples pharmaceutical companies give doctors
CREATE TABLE "medicine_samples" (
    "id" INTEGER,
    "pharma_company_id" INTEGER NOT NULL,
    "doctor_id" INTEGER NOT NULL,
    "medicine_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL CHECK("quantity" > 0),
    "provided_at" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("pharma_company_id") REFERENCES "pharma_companies"("id"),
    FOREIGN KEY("doctor_id") REFERENCES "doctors"("id"),
    FOREIGN KEY("medicine_id") REFERENCES "medicines"("id")
);

-- Represent bulk medicine supply from pharmaceutical companies to pharmacies
CREATE TABLE "pharmacy_supplies" (
    "id" INTEGER,
    "pharma_company_id" INTEGER NOT NULL,
    "pharmacy_id" INTEGER NOT NULL,
    "medicine_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL CHECK("quantity" > 0),
    "supplied_at" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("pharma_company_id") REFERENCES "pharma_companies"("id"),
    FOREIGN KEY("pharmacy_id") REFERENCES "pharmacies"("id"),
    FOREIGN KEY("medicine_id") REFERENCES "medicines"("id")
);

-- Represent a patient collecting a prescribed medicine item from a pharmacy
CREATE TABLE "medicine_collections" (
    "id" INTEGER,
    "prescription_item_id" INTEGER NOT NULL,
    "pharmacy_id" INTEGER NOT NULL,
    "collected_at" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("prescription_item_id") REFERENCES "prescription_items"("id"),
    FOREIGN KEY("pharmacy_id") REFERENCES "pharmacies"("id")
);

-- Create indexes to speed common searches
CREATE INDEX "doctor_name_search" ON "doctors" ("first_name", "last_name");
CREATE INDEX "doctor_specialty_search" ON "doctors" ("specialty");
CREATE INDEX "patient_name_search" ON "patients" ("first_name", "last_name");
CREATE INDEX "medicine_name_search" ON "medicines" ("name");
CREATE INDEX "follows_follower_search" ON "follows" ("follower_type", "follower_id");
CREATE INDEX "follows_followee_search" ON "follows" ("followee_type", "followee_id");
CREATE INDEX "messages_thread_search" ON "messages" ("patient_id", "doctor_id");
CREATE INDEX "prescriptions_patient_search" ON "prescriptions" ("patient_id");
