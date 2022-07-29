-- Exercise1

CREATE DATABASE fresher;

USE fresher;

DROP TABLE IF EXISTS trainee;

CREATE TABLE IF NOT EXISTS trainee(
	trainee_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name NVARCHAR(100),
    birth_date DATE,
    gender ENUM('male','female','unknown'),
    et_iq TINYINT CHECK(et_iq <= 20 AND ET_IQ >= 0),
    et_gmath TINYINT CHECK(et_gmath <= 20 AND et_gmath >= 0),
	et_english TINYINT CHECK(et_english <= 50 AND et_english >= 0),
    training_class INT,
    evaluation_notes TEXT
);

ALTER TABLE trainee ADD COLUMN vti_account NVARCHAR(200) NOT NULL UNIQUE;

-- Exercise2
CREATE TABLE data_types1(
	id MEDIUMINT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(200),
    `code` CHAR(5),
    modified_date DATETIME
);

-- Exercise3
CREATE TABLE data_types2(
	id MEDIUMINT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(200),
    birth_date DATE,
    gender TINYINT CHECK(gender >= 0 AND gender <= 1),
    is_deleted_flag BOOLEAN
);
