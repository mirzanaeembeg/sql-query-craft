CREATE TABLE users (
    id INTEGER NOT NULL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    username TEXT NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE schools_and_universities (
    id INTEGER NOT NULL PRIMARY KEY,
    user_id INTEGER,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    location TEXT NOT NULL,
    founded_year INTEGER NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES users("id")
);

CREATE TABLE companies (
    id INTEGER NOT NULL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    company_industry TEXT NOT NULL,
    location TEXT NOT NULL
);

CREATE TABLE people_connections (
    id INTEGER NOT NULL PRIMARY KEY,
    user_id INTEGER,
    from_user TEXT NOT NULL,
    to_user TEXT NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES users("id")
);

CREATE TABLE schools_connections (
    id INTEGER NOT NULL PRIMARY KEY,
    user_id INTEGER,
    attend_date NUMERIC NOT NULL,
    end_date NUMERIC NOT NULL,
    degree_type TEXT NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES users("id")
);

CREATE TABLE companies_connections (
    id INTEGER NOT NULL PRIMARY KEY,
    user_id INTEGER,
    began_date NUMERIC NOT NULL,
    left_date NUMERIC NOT NULL,
    job_title TEXT NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES users("id")
);

