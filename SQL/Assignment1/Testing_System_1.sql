CREATE DATABASE Testing_System_Assignment_1;

USE Testing_System_Assignment_1;

-- Table1
CREATE TABLE Department(
	DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(50)
);

-- Table2
CREATE TABLE Position (
	PositionID INT PRIMARY KEY AUTO_INCREMENT,
    PositionName ENUM('Dev','Test','Scrum Master','PM')
);

-- Table3
CREATE TABLE Account (
	AccountID INT PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(50),
    Username VARCHAR(50),
    FullName VARCHAR(50),
    DepartmentID INT,
    PositionID INT,
    CreateDate DATE
);

-- Table4
CREATE TABLE `Group` (
	GroupID INT PRIMARY KEY AUTO_INCREMENT,
    GroupName varchar(50),
    CreatorID INT,
    CreateDate DATE
);

-- Table5
CREATE TABLE GroupAccount (
	GroupID INT,
    AccountID INT,
    JoinDate DATE
);

-- Table6
CREATE TABLE TypeQuestion (
	TypeID INT PRIMARY KEY AUTO_INCREMENT,
    TypeName ENUM('Essay','Multiple-Choice')
);

-- Table7
CREATE TABLE CategoryQuestion (
	CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50)
);

-- Table8
CREATE TABLE Question (
	QuestionID INT PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(50),
    CategoryID INT,
    TypeID INT,
    CreatorID INT,
    CreateDate DATE
);

-- Table9
CREATE TABLE Answer (
	AnswerID INT PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(50),
    QuestionID INT,
    isCorrect BOOLEAN
);

-- Table10
CREATE TABLE Exam (
	ExamID INT PRIMARY KEY AUTO_INCREMENT,
    Code INT,
    Title VARCHAR(50),
    CategoryID INT,
    Duration DATETIME,
    CreatorID INT,
    CreateDate DATE
);

-- Table11
CREATE TABLE ExamQuestion (
	ExamID INT,
    QuestionID INT
);