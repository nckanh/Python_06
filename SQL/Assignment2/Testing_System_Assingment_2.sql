DROP DATABASE IF EXISTS testing_system_assignment_1;

CREATE DATABASE testing_system_assignment_1;

USE testing_system_assignment_1;

-- Table1
CREATE TABLE department(
	department_id TINYINT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100)
);

-- Table2
CREATE TABLE `position` (
	position_id TINYINT PRIMARY KEY AUTO_INCREMENT,
    position_name ENUM('Dev','Test','Scrum Master','PM')
);


-- Table3
CREATE TABLE `account` (
	account_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE KEY,
    user_name VARCHAR(100),
    full_name VARCHAR(100),
    department_id TINYINT,
    position_id TINYINT,
    create_date DATE,
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    FOREIGN KEY (position_id) REFERENCES `position`(position_id)
);

-- Table4
CREATE TABLE `group` (
	group_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(100),
    creator_id MEDIUMINT,
    create_date DATE
);


-- Table5
CREATE TABLE group_account (
	group_id SMALLINT,
    account_id INT,
    join_date DATE,
    FOREIGN KEY (group_id) REFERENCES `group`(group_id),
    FOREIGN KEY (account_id) REFERENCES `account`(account_id)
);

        
-- Table6
CREATE TABLE type_question (
	type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name ENUM('Essay','Multiple-Choice')
);


-- Table7
CREATE TABLE category_question (
	category_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100)
);
       
-- Table8
CREATE TABLE question (
	question_id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(200),
    category_id SMALLINT,
    type_id INT,
    creator_id MEDIUMINT,
    create_date DATE,
    FOREIGN KEY (type_id) REFERENCES type_question(type_id),
    FOREIGN KEY (category_id) REFERENCES category_question(category_id)
);


-- Table9
CREATE TABLE answer (
	answer_id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(200),
    question_id INT,
    is_correct BOOLEAN
);


-- Table10
CREATE TABLE exam (
	exam_id MEDIUMINT PRIMARY KEY AUTO_INCREMENT,
    `code` INT,
    title VARCHAR(200),
    category_id SMALLINT,
    duration VARCHAR(50),
    creator_id MEDIUMINT,
    create_date DATE,
    FOREIGN KEY (category_id) REFERENCES category_question(category_id)
);

-- Table11
CREATE TABLE exam_question (
	exam_id MEDIUMINT,
    question_id INT,
	FOREIGN KEY (exam_id) REFERENCES exam(exam_id),
    FOREIGN KEY (question_id) REFERENCES question(question_id)
);

-- Insert
INSERT INTO department	department_id,	department_name)
VALUES  				(1,				N'Phòng Dev'),
						(2,				N'Phòng Sale'),
						(3,				N'Phòng Support'),
						(4,				N'Phòng Marketing'),
						(5,				N'Phòng Maintenance');

INSERT INTO `position`	(position_id,	position_name)
VALUES  				(1,				'Dev'),
						(2,				'Test'),
						(3,				'Scrum Master'),
						(4,				'PM');

INSERT INTO `account`	(account_id,email,			user_name,	full_name,		department_id,	position_id,create_date)
VALUES  				(1,			'nva@gmail.com','nva123',	N'Nguyễn Văn A',1,				1,			'2022-07-19'),
						(2,			'ttb@gmail.com','ttb123',	N'Trần Thanh B',3,				2,			'2022-07-19'),
						(3,			'nvc@gmail.com','nvc123',	N'Ngô Văn C',	1,				4,			'2022-07-19'),
						(4,			'dyd@gmail.com','dyd123',	N'Đỗ Yến D',	5,				2,			'2022-07-19'),
						(5,			'nce@gmail.com','nce123',	N'Nguyễn Cao E',1,				3,			'2022-07-19');

INSERT INTO `group`	(group_id,	group_name,				creator_id,	create_date)
VALUES  			(1,			N'Cơ sở Thái Hà',		3,			'2022-07-19'),
					(2,			N'Cơ sở Duy Tân',		3,			'2022-07-19'),
					(3,			N'Cơ sở Lê Văn Lương',	3,			'2022-07-19'),
					(4,			N'Cơ sở Tây Sơn',		3,			'2022-07-19'),
					(5,			N'Cơ sở Hoàn Kiếm',		3,			'2022-07-19');

INSERT INTO group_account	(group_id,	account_id,	join_date)
VALUES  					(1,			1,			'2022-01-01'),
							(1,			2,			'2022-01-01'),
							(1,			3,			'2022-01-01'),
							(2,			4,			'2022-01-01'),
							(2,			5,			'2022-01-01');

INSERT INTO type_question	(type_id	,type_name)
VALUES  					(1			,'Essay'),
							(2			,'Multiple-Choice');

INSERT INTO category_question	(category_id,category_name)
VALUES  						(1			,'SQL'),
								(2			,'BackEnd'),
								(3			,'FrontEnd'),
								(4			,'Api'),
								(5			,'AI');

INSERT INTO question(question_id,content			,category_id,type_id,creator_id	,create_date)
VALUES  			(1			,N'Database là gì?'	,1			,1		,3			,'2022-07-19'),
					(2			,N'BackEnd là gì?'	,2			,1		,3			,'2022-07-19'),
					(3			,N'FrontEnd là gì?'	,3			,1		,3			,'2022-07-19'),
					(4			,N'API là gì?'		,4			,1		,3			,'2022-07-19'),
					(5			,N'AI là gì?'		,5			,1		,3			,'2022-07-19');

INSERT INTO answer	(answer_id	,content																																													,question_id,is_correct)
VALUES  			(1			,N'Database là cơ sở dữ liệu, là một bộ sưu tập dữ liệu được tổ chức bày bản và thường được truy cập từ hệ thống máy tính hoặc tồn tại dưới dạng tập tin trong hệ quản trị cơ sở dữ liệu'	,1			,1),
					(2			,N'BackEnd là tất cả những phần hỗ trợ hoạt động của website hoặc ứng dụng mà người dùng không thể nhìn thấy được'																			,2			,1),
					(3			,N'FrontEnd là giao diện máy tính'																																							,3			,0),
					(4			,N'API là các phương thức, giao thức kết nối với các thư viện và ứng dụng khác. Nó là viết tắt của Application Programming Interface'														,4			,1),
					(5			,N'Trí tuệ nhân tạo hay trí thông minh nhân tạo (Artificial Intelligence – viết tắt là AI) là một ngành thuộc lĩnh vực khoa học máy tính (Computer science)'								,5			,1);


INSERT INTO exam(exam_id,`code`		,title					,category_id,duration	,creator_id	,create_date)
VALUES  		(1		,'000001'	,'Test giữa giờ số 1'	,1			,60			,3			,'2022-07-19'),
				(2		,'000002'	,'Test giữa giờ số 2'	,2			,10			,3			,'2022-07-19'),
				(3		,'000003'	,'Test giữa giờ số 3'	,3			,120		,3			,'2022-07-19'),
				(4		,'000004'	,'Test giữa giờ số 4'	,4			,70			,3			,'2022-07-19'),
				(5		,'000005'	,'Test giữa giờ số 5'	,5			,30			,3			,'2022-07-19');

INSERT INTO exam_question	(exam_id,question_id)
VALUES  					(1		,1),
							(2		,2),
							(3		,3),
							(4		,4),
							(5		,5);