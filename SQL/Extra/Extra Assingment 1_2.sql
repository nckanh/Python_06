-- Exercise1
USE Testing_System_Assignment_1;

DROP TABLE IF EXISTS Trainee;

CREATE TABLE IF NOT EXISTS Trainee(
	TraineeID INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name VARCHAR(100),
    Birth_Date DATE,
    Gender ENUM('male','female','unknown'),
    ET_IQ TINYINT CHECK(ET_IQ <= 20 AND ET_IQ >= 0),
    ET_Gmath TINYINT CHECK(ET_Gmath <= 20 AND ET_Gmath >= 0),
    ET_English TINYINT CHECK(ET_English <= 50 AND ET_English >= 0),
    Training_Class INT,
    Evaluation_Notes TEXT
);

ALTER TABLE Trainee ADD COLUMN VTI_Account VARCHAR(200) NOT NULL UNIQUE;

-- Exercise2
CREATE TABLE DataTypes1(
	ID MEDIUMINT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(200),
    Code CHAR(5),
    ModifiedDate DATETIME
);

-- Exercise3
CREATE TABLE DataTypes2(
	ID MEDIUMINT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(200),
    BirthDate DATE,
    Gender TINYINT CHECK(Gender >= 0 AND Gender <= 1),
    IsDeletedFlag BOOLEAN
);
