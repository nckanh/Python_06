DROP DATABASE IF EXISTS Testing_System_Assignment_1;

CREATE DATABASE Testing_System_Assignment_1;

USE Testing_System_Assignment_1;

-- Table1
CREATE TABLE Department(
	DepartmentID TINYINT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100)
);

INSERT INTO Department(DepartmentID,DepartmentName)
VALUES  (1,N'Phòng Dev'),
		(2,N'Phòng Sale'),
        (3,N'Phòng Support'),
        (4,N'Phòng Marketing'),
        (5,N'Phòng Maintenance');

-- Table2
CREATE TABLE `Position` (
	PositionID TINYINT PRIMARY KEY AUTO_INCREMENT,
    PositionName ENUM('Dev','Test','Scrum Master','PM')
);

INSERT INTO `Position`(PositionID,PositionName)
VALUES  (1,'Dev'),
		(2,'Test'),
        (3,'Scrum Master'),
        (4,'PM');

-- Table3
CREATE TABLE Account (
	AccountID INT PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(100) UNIQUE KEY,
    Username VARCHAR(100),
    FullName VARCHAR(100),
    DepartmentID TINYINT,
    PositionID TINYINT,
    CreateDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID)
);

INSERT INTO Account(AccountID,Email,Username,FullName,DepartmentID,PositionID,CreateDate)
VALUES  (1,'nva@gmail.com','nva123',N'Nguyễn Văn A','1','1','2022-07-19'),
		(2,'ttb@gmail.com','ttb123',N'Trần Thanh B','3','2','2022-07-19'),
        (3,'nvc@gmail.com','nvc123',N'Ngô Văn C','1','4','2022-07-19'),
        (4,'dyd@gmail.com','dyd123',N'Đỗ Yến D','5','2','2022-07-19'),
        (5,'nce@gmail.com','nce123',N'Nguyễn Cao E','1','3','2022-07-19');

-- Table4
CREATE TABLE `Group` (
	GroupID SMALLINT PRIMARY KEY AUTO_INCREMENT,
    GroupName VARCHAR(100),
    CreatorID MEDIUMINT,
    CreateDate DATE
);

INSERT INTO `Group`(GroupID,GroupName,CreatorID,CreateDate)
VALUES  (1,N'Cơ sở Thái Hà','3','022-07-19'),
		(2,N'Cơ sở Duy Tân','3','2022-07-19'),
        (3,N'Cơ sở Lê Văn Lương','3','2022-07-19'),
        (4,N'Cơ sở Tây Sơn','3','2022-07-19'),
        (5,N'Cơ sở Hoàn Kiếm','3','2022-07-19');

-- Table5
CREATE TABLE GroupAccount (
	GroupID SMALLINT,
    AccountID INT,
    JoinDate DATE,
    FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

INSERT INTO GroupAccount(GroupID,AccountID,JoinDate)
VALUES  (1,1,'2022-01-01'),
		(1,2,'2022-01-01'),
        (1,3,'2022-01-01'),
        (2,4,'2022-01-01'),
        (2,5,'2022-01-01');
        
-- Table6
CREATE TABLE TypeQuestion (
	TypeID INT PRIMARY KEY AUTO_INCREMENT,
    TypeName ENUM('Essay','Multiple-Choice')
);

INSERT INTO TypeQuestion(TypeID,TypeName)
VALUES  (1,'Essay'),
		(2,'Multiple-Choice');

-- Table7
CREATE TABLE CategoryQuestion (
	CategoryID SMALLINT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100)
);

INSERT INTO CategoryQuestion(CategoryID,CategoryName)
VALUES  (1,N'SQL'),
		(2,N'BackEnd'),
        (3,N'FrontEnd'),
        (4,N'Api'),
        (5,N'AI');
        
-- Table8
CREATE TABLE Question (
	QuestionID INT PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(200),
    CategoryID SMALLINT,
    TypeID INT,
    CreatorID MEDIUMINT,
    CreateDate DATE,
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID)
);

INSERT INTO Question(QuestionID,Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES  (1,N'Database là gì?','1','1','3','2022-07-19'),
		(2,N'BackEnd là gì?','2','1','3','2022-07-19'),
        (3,N'FrontEnd là gì?','3','1','3','2022-07-19'),
        (4,N'API là gì?','4','1','3','2022-07-19'),
        (5,N'AI là gì?','5','1','3','2022-07-19');

-- Table9
CREATE TABLE Answer (
	AnswerID INT PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(200),
    QuestionID INT,
    isCorrect BOOLEAN
);

INSERT INTO Answer(AnswerID,Content,QuestionID,isCorrect)
VALUES  (1,N'Database là cơ sở dữ liệu, là một bộ sưu tập dữ liệu được tổ chức bày bản và thường được truy cập từ hệ thống máy tính hoặc tồn tại dưới dạng tập tin trong hệ quản trị cơ sở dữ liệu','1','1'),
		(2,N'BackEnd là tất cả những phần hỗ trợ hoạt động của website hoặc ứng dụng mà người dùng không thể nhìn thấy được','2','1'),
        (3,N'FrontEnd là giao diện máy tính','3','0'),
        (4,N'API là các phương thức, giao thức kết nối với các thư viện và ứng dụng khác. Nó là viết tắt của Application Programming Interface','4','1'),
        (5,N'Trí tuệ nhân tạo hay trí thông minh nhân tạo (Artificial Intelligence – viết tắt là AI) là một ngành thuộc lĩnh vực khoa học máy tính (Computer science)','5','1');

-- Table10
CREATE TABLE Exam (
	ExamID MEDIUMINT PRIMARY KEY AUTO_INCREMENT,
    Code INT,
    Title VARCHAR(200),
    CategoryID SMALLINT,
    Duration VARCHAR(50),
    CreatorID MEDIUMINT,
    CreateDate DATE,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID)
);

INSERT INTO Exam(ExamID,Code,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES  (1,'000001','Test giữa giờ số 1','1',60,'3','2022-07-19'),
		(2,'000002','Test giữa giờ số 2','2',10,'3','2022-07-19'),
        (3,'000003','Test giữa giờ số 3','3',120,'3','2022-07-19'),
        (4,'000004','Test giữa giờ số 4','4',70,'3','2022-07-19'),
        (5,'000005','Test giữa giờ số 5','5',30,'3','2022-07-19');

-- Table11
CREATE TABLE ExamQuestion (
	ExamID MEDIUMINT,
    QuestionID INT,
	FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

INSERT INTO ExamQuestion(ExamID,QuestionID)
VALUES  (1,1),
		(2,2),
        (3,3),
        (4,4),
        (5,5);