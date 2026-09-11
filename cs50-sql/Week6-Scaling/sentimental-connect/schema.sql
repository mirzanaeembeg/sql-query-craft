CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL
);

CREATE TABLE schools (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type ENUM('Primary', 'Secondary', 'Higher Education') NOT NULL,
    location VARCHAR(255) NOT NULL,
    founded_year YEAR NOT NULL
);

CREATE TABLE companies (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    industry ENUM('Technology', 'Education', 'Business') NOT NULL,
    location VARCHAR(255) NOT NULL
);

CREATE TABLE connections (
    user_id  INT UNSIGNED NOT NULL,
    connection_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, connection_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (connection_id) REFERENCES users(id) ON DELETE CASCADE,
    CHECK (user_id <> connection_id)
);

CREATE TABLE education (
    user_id  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    school_id INT UNSIGNED NOT NULL,
    degree VARCHAR(50),
    start_date DATE NOT NULL,
    end_date Date,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE
);

CREATE TABLE employment (
    id  INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    company_id INT UNSIGNED NOT NULL,
    title VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date Date,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
);
