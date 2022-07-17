-- Database
create DATABASE Testing_System_Assignment_1;

USE Testing_System_Assignment_1;

-- Table1
create TABLE Department(
	DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(50)
);

-- Table2
create TABLE Position (
	PositionID INT PRIMARY KEY AUTO_INCREMENT,
    PositionName ENUM('Dev','Test','Scrum Master','PM')
);

-- Table3
create TABLE Account (
	AccountID INT PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(50),
    Username VARCHAR(50),
    FullName VARCHAR(50),
    DepartmentID INT,
    PositionID INT,
    CreateDate DATE
);

-- Table4
create TABLE `Group` (
	GroupID INT PRIMARY KEY AUTO_INCREMENT,
    GroupName varchar(50),
    CreatorID INT,
    CreateDate DATE
);

-- Table5
create TABLE GroupAccount (
	GroupID INT,
    AccountID INT,
    JoinDate DATE
);

-- Table6
create TABLE TypeQuestion (
	TypeID INT PRIMARY KEY AUTO_INCREMENT,
    TypeName ENUM('Essay','Multiple-Choice')
);

-- Table7
create TABLE CategoryQuestion (
	CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50)
);

-- Table8
create TABLE Question (
	QuestionID INT PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(50),
    CategoryID INT,
    TypeID INT,
    CreatorID INT,
    CreateDate DATE
);

-- Table9
create TABLE Answer (
	AnswerID INT PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(50),
    QuestionID INT,
    isCorrect BOOLEAN
);

-- Table10
create TABLE Exam (
	ExamID INT PRIMARY KEY AUTO_INCREMENT,
    Code INT,
    Title VARCHAR(50),
    CategoryID INT,
    Duration DATETIME,
    CreatorID INT,
    CreateDate DATE
);

-- Table11
create TABLE ExamQuestion (
	ExamID INT,
    QuestionID INT
);