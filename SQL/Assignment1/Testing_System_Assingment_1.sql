CREATE DATABASE testing_system_assignment_1;

USE testing_system_assignment_1;

-- Table1
CREATE TABLE department(
	department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50)
);

-- Table2
CREATE TABLE position (
	position_id INT PRIMARY KEY AUTO_INCREMENT,
    position_name ENUM('Dev','Test','Scrum Master','PM')
);

-- Table3
CREATE TABLE `account` (
	account_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50),
    user_name VARCHAR(50),
    full_name VARCHAR(50),
    department_id INT,
    position_id INT,
    create_date DATE
);

-- Table4
CREATE TABLE `group` (
	group_id INT PRIMARY KEY AUTO_INCREMENT,
    group_name varchar(50),
    creator_id INT,
    create_date DATE
);

-- Table5
CREATE TABLE group_account (
	group_id INT,
    account_id INT,
    join_date DATE
);

-- Table6
CREATE TABLE type_question (
	type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name ENUM('Essay','Multiple-Choice')
);

-- Table7
CREATE TABLE category_question (
	category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50)
);

-- Table8
CREATE TABLE question (
	question_id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(50),
    category_id INT,
    type_id INT,
    creator_id INT,
    create_date DATE
);

-- Table9
CREATE TABLE answer (
	answer_id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(50),
    question_id INT,
    is_correct BOOLEAN
);

-- Table10
CREATE TABLE exam (
	exam_id INT PRIMARY KEY AUTO_INCREMENT,
    `code` INT,
    title VARCHAR(50),
    category_id INT,
    duration DATETIME,
    creator_id INT,
    create_date DATE
);

-- Table11
CREATE TABLE exam_question (
	exam_id INT,
    question_id INT
);