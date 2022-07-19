-- Exercise1
USE Testing_System_Assignment_1;

CREATE TABLE Trainee(
	TraineeID INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name VARCHAR(100),
    Birth_Date DATE,
    Gender ENUM('male','female','unknown'),
    ET_IQ INT(20),
    ET_Gmath INT(20),
    ET_English INT(20),
    Training_Class INT,
    Evaluation_Notes TEXT
);

ALTER TABLE Trainee ADD COLUMN VTI_Account INT NOT NULL UNIQUE;

-- Exercise2
CREATE TABLE DataTypes1(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(200),
    Code CHAR(5),
    ModifiedDate DATETIME
);

-- Exercise3
CREATE TABLE DataTypes2(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(200),
    BirthDate DATE,
    Gender INT,
    IsDeletedFlag BOOLEAN
);
