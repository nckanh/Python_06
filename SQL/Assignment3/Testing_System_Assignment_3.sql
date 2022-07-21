-- Question1
INSERT INTO Department(DepartmentID,DepartmentName)
VALUES  ('6',N'Phòng Sale 2'),
		('7',N'Phòng Sale Online'),
        ('8',N'Phòng Sale 3'),
        ('9',N'Phòng Marketing 2'),
        ('10',N'Phòng Maintenance 2');
        
INSERT INTO Account(AccountID,Email,Username,FullName,DepartmentID,PositionID,CreateDate)
VALUES  ('6','nvf@gmail.com','nvf123',N'Nguyễn Văn F','1','1','2019-03-19'),
		('7','ttg@gmail.com','ttg123',N'Trần Thị G','3','2','2019-02-19'),
        ('8','ndh@gmail.com','ndh123',N'Ngô Đình H','1','4','2020-06-19'),
        ('9','dmi@gmail.com','dmi123',N'Đỗ Mai I','5','2','2020-07-21'),
        ('10','nvk@gmail.com','nvk123',N'Nguyễn Vũ K','1','3','2021-07-19');
        
INSERT INTO `Group`(GroupID,GroupName,CreatorID,CreateDate)
VALUES  ('6',N'Cơ sở Thái Thịnh','3','2019-07-19'),
		('7',N'Cơ sở Quang Trung','3','2018-07-19'),
        ('8',N'Cơ sở Lê Lai','3','2020-07-19'),
        ('9',N'Cơ sở Đăng Văn Ngữ','3','2018-07-19'),
        ('10',N'Cơ sở Hai Bà Trưng','3','2020-07-19');

INSERT INTO GroupAccount(GroupID,AccountID,JoinDate)
VALUES  ('6','6','2020-01-01'),
		('7','7','2019-01-01'),
        ('8','8','2021-01-01'),
        ('9','9','2021-01-01'),
        ('10','10','2022-01-01');
        
INSERT INTO CategoryQuestion(CategoryID,CategoryName)
VALUES  ('6',N'Văn'),
		('7',N'Toán'),
        ('8',N'Hóa'),
        ('9',N'Anh'),
        ('10',N'Lý');
        
INSERT INTO Question(QuestionID,Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES  ('6',N'1 + 1 = ?','7','1','3','2020-07-19'),
		('7',N'H2O + O2 = ?','8','1','3','2019-07-19'),
        ('8',N'Ai đã đặt tên cho dòng sông?','6','1','3','2019-07-19'),
        ('9',N'Người ấy là ai?','6','1','3','2021-07-19'),
        ('10',N'Newton bao nhiêu tuổi?','10','1','3','2021-07-19');

INSERT INTO Answer(AnswerID,Content,QuestionID,isCorrect)
VALUES  ('6','6','1','1'),
		('7','HOHO','7','0'),
        ('8',N'Không Biết','8','0'),
        ('9','John Cena','9','1'),
        ('10','1000','10','0');

INSERT INTO Exam(ExamID,Code,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES  ('6','000006','Test giữa giờ số 6','7',N'5 phút','3','2021-07-19'),
		('7','000007','Test giữa giờ số 7','8',N'5 phút','3','2021-07-19'),
        ('8','000008','Test giữa giờ số 8','6',N'5 phút','3','2020-07-19'),
        ('9','000009','Test giữa giờ số 9','6',N'5 phút','3','2020-07-19'),
        ('10','000010','Test giữa giờ số 10','10',N'5 phút','3','2022-07-19');

INSERT INTO ExamQuestion(ExamID,QuestionID)
VALUES  ('6','6'),
		('7','7'),
        ('8','8'),
        ('9','9'),
        ('10','10');

-- Question2
SELECT * FROM Department;
-- Question3
SELECT DepartmentID FROM Department WHERE DepartmentName like '%Sale%';
-- Question4
SELECT * FROM Account WHERE LENGTH(FullName) = (SELECT MAX(LENGTH(FullName)) FROM Account);
-- Question5
SELECT * FROM Account WHERE LENGTH(FullName) = (SELECT MAX(LENGTH(FullName)) FROM Account WHERE DepartmentID = 3) and DepartmentID = 3;
-- Question6
SELECT * FROM `Group` WHERE CreateDate < '2019-12-20';
-- Question7
SELECT QuestionID,COUNT(*) as 'Số câu trả lời' FROM Answer 
GROUP BY QuestionID
HAVING COUNT(*) >= 4;
-- Question8
SELECT * FROM Exam WHERE Duration >= 60 and CreateDate < '2019-12-20';
-- Question9
SELECT * FROM `Group` ORDER BY CreateDate desc LIMIT 5;
-- Question10
SELECT COUNT(*) FROM Account WHERE DepartmentID = '2';
-- Question11
SELECT * FROM Account WHERE Fullname like 'D%o';
-- Question12
DELETE FROM Exam WHERE CreateDate < '2019-12-20';
-- Question13
DELETE FROM Question WHERE Content like 'câu hỏi%';
-- Question14
UPDATE Account set Fullname = N'Nguyễn Bá Lộc',Email = 'loc.nguyenba@vti.com.vn' WHERE AccountID = '5';
-- Question15
SELECT GroupID FROM Groupaccount WHERE AccountID = 4;
UPDATE Groupaccount set GroupID = 2 WHERE AccountID = 5;
