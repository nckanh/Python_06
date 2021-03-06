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
VALUES  				(1,				N'Ph??ng Dev'),
						(2,				N'Ph??ng Sale'),
						(3,				N'Ph??ng Support'),
						(4,				N'Ph??ng Marketing'),
						(5,				N'Ph??ng Maintenance');

INSERT INTO `position`	(position_id,	position_name)
VALUES  				(1,				'Dev'),
						(2,				'Test'),
						(3,				'Scrum Master'),
						(4,				'PM');

INSERT INTO `account`	(account_id,email,			user_name,	full_name,		department_id,	position_id,create_date)
VALUES  				(1,			'nva@gmail.com','nva123',	N'Nguy???n V??n A',1,				1,			'2022-07-19'),
						(2,			'ttb@gmail.com','ttb123',	N'Tr???n Thanh B',3,				2,			'2022-07-19'),
						(3,			'nvc@gmail.com','nvc123',	N'Ng?? V??n C',	1,				4,			'2022-07-19'),
						(4,			'dyd@gmail.com','dyd123',	N'????? Y???n D',	5,				2,			'2022-07-19'),
						(5,			'nce@gmail.com','nce123',	N'Nguy???n Cao E',1,				3,			'2022-07-19');

INSERT INTO `group`	(group_id,	group_name,				creator_id,	create_date)
VALUES  			(1,			N'C?? s??? Th??i H??',		3,			'2022-07-19'),
					(2,			N'C?? s??? Duy T??n',		3,			'2022-07-19'),
					(3,			N'C?? s??? L?? V??n L????ng',	3,			'2022-07-19'),
					(4,			N'C?? s??? T??y S??n',		3,			'2022-07-19'),
					(5,			N'C?? s??? Ho??n Ki???m',		3,			'2022-07-19');

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
VALUES  			(1			,N'Database l?? g???'	,1			,1		,3			,'2022-07-19'),
					(2			,N'BackEnd l?? g???'	,2			,1		,3			,'2022-07-19'),
					(3			,N'FrontEnd l?? g???'	,3			,1		,3			,'2022-07-19'),
					(4			,N'API l?? g???'		,4			,1		,3			,'2022-07-19'),
					(5			,N'AI l?? g???'		,5			,1		,3			,'2022-07-19');

INSERT INTO answer	(answer_id	,content																																													,question_id,is_correct)
VALUES  			(1			,N'Database l?? c?? s??? d??? li???u, l?? m???t b??? s??u t???p d??? li???u ???????c t??? ch???c b??y b???n v?? th?????ng ???????c truy c???p t??? h??? th???ng m??y t??nh ho???c t???n t???i d?????i d???ng t???p tin trong h??? qu???n tr??? c?? s??? d??? li???u'	,1			,1),
					(2			,N'BackEnd l?? t???t c??? nh???ng ph???n h??? tr??? ho???t ?????ng c???a website ho???c ???ng d???ng m?? ng?????i d??ng kh??ng th??? nh??n th???y ???????c'																			,2			,1),
					(3			,N'FrontEnd l?? giao di???n m??y t??nh'																																							,3			,0),
					(4			,N'API l?? c??c ph????ng th???c, giao th???c k???t n???i v???i c??c th?? vi???n v?? ???ng d???ng kh??c. N?? l?? vi???t t???t c???a Application Programming Interface'														,4			,1),
					(5			,N'Tr?? tu??? nh??n t???o hay tr?? th??ng minh nh??n t???o (Artificial Intelligence ??? vi???t t???t l?? AI) l?? m???t ng??nh thu???c l??nh v???c khoa h???c m??y t??nh (Computer science)'								,5			,1);


INSERT INTO exam(exam_id,`code`		,title					,category_id,duration	,creator_id	,create_date)
VALUES  		(1		,'000001'	,'Test gi???a gi??? s??? 1'	,1			,60			,3			,'2022-07-19'),
				(2		,'000002'	,'Test gi???a gi??? s??? 2'	,2			,10			,3			,'2022-07-19'),
				(3		,'000003'	,'Test gi???a gi??? s??? 3'	,3			,120		,3			,'2022-07-19'),
				(4		,'000004'	,'Test gi???a gi??? s??? 4'	,4			,70			,3			,'2022-07-19'),
				(5		,'000005'	,'Test gi???a gi??? s??? 5'	,5			,30			,3			,'2022-07-19');

INSERT INTO exam_question	(exam_id,question_id)
VALUES  					(1		,1),
							(2		,2),
							(3		,3),
							(4		,4),
							(5		,5);