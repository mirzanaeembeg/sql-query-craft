CREATE TABLE passengers (
    id INTEGER NOT NULL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    age INTEGER NOT NULL
);

CREATE TABLE flights (
    id INTEGER NOT NULL PRIMARY KEY,
    flight_no INTEGER NOT NULL,
    operator_airline TEXT NOT NULL UNIQUE,
    depart_airport_code TEXT NOT NULL,
    head_airport_code TEXT NOT NULL,
    depart_datetime NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    arrival_datetime NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE check_ins (
    id INTEGER NOT NULL PRIMARY KEY,
    checked_in_time NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    flight_id INTEGER NOT NULL,
    FOREIGN KEY("flight_id") REFERENCES flights("id")
);

CREATE TABLE airlines (
    id INTEGER NOT NULL PRIMARY KEY,
    airline_name TEXT NOT NULL,
    concourse TEXT NOT NULL CHECK(concourse IN ('A', 'B', 'C', 'D', 'E', 'F', 'T'))
);
