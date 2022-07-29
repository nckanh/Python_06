-- Question1
insert into trainee values
(1,N'Nguyễn Ngọc Anh','2004-04-05','female',15,12,35,1,'','nna@vti'),
(2,N'Nguyễn Minh Anh','2004-06-09','female',12,13,25,1,'','nma@vti'),
(3,N'Trần Anh Quân','2004-07-12','male',16,14,38,1,'','taq@vti'),
(4,N'Nguyễn Tuấn Tú','2004-03-24','male',10,12,24,1,'','ntt@vti'),
(5,N'Tô Minh Hương','2004-10-25','female',6,10,12,1,'','tmh@vti'),
(6,N'Đỗ Quỳnh Nga','2004-04-30','female',14,14,20,1,'','dqn@vti'),
(7,N'Phạm Tiến Dũng','2004-08-02','male',10,9,30,1,'','ptd@vti'),
(8,N'Chu Minh Tùng','2004-08-05','male',11,7,33,1,'','cmt@vti'),
(9,N'Nguyễn Tiến','2004-12-05','male',4,12,27,1,'','nt@vti'),
(10,N'Vũ Minh Thư','2004-11-19','female',15,8,28,1,'','vmt@vti');

-- Question2 
SELECT date_format(Birth_Date,'%m') as 'Tháng sinh',COUNT(*) as 'Số TTS' FROM Trainee
GROUP BY date_format(Birth_Date,'%m');
-- Question3
SELECT * FROM Trainee WHERE CHAR_LENGTH(Full_Name) = (SELECT MAX(CHAR_LENGTH(Full_Name))  FROM Trainee);
-- Question4
SELECT * FROM Trainee WHERE 
ET_IQ >= 8 AND
ET_Gmath >= 8 AND
ET_English >= 18 AND
ET_IQ + ET_Gmath >= 20;
-- Question5
DELETE FROM Trainee WHERE TraineeID = 3;
-- Question6
UPDATE Trainee set Training_Class = (select Training_Class WHERE TraineeID = 4) WHERE TraineeID = 5;