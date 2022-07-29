-- Question1
INSERT INTO department	(department_id	,department_name)
VALUES  				(6				,N'Phòng Sale 2'),
						(7				,N'Phòng Sale Online'),
						(8				,N'Phòng Sale 3'),
						(9				,N'Phòng Marketing 2'),
						(10				,N'Phòng Maintenance 2');
        
INSERT INTO `account`	(account_id	,email			,user_name	,full_name		,department_id	,position_id,create_date)
VALUES  				(6			,'nvf@gmail.com','nvf123'	,N'Nguyễn Văn F',1				,1			,'2019-03-19'),
						(7			,'ttg@gmail.com','ttg123'	,N'Trần Thị G'	,3				,2			,'2019-02-19'),
						(8			,'ndh@gmail.com','ndh123'	,N'Ngô Đình H'	,1				,4			,'2020-06-19'),
						(9			,'dmi@gmail.com','dmi123'	,N'Đỗ Mai I'	,5				,2			,'2020-07-21'),
						(10			,'nvk@gmail.com','nvk123'	,N'Nguyễn Vũ K'	,1				,3			,'2021-07-19');
        
INSERT INTO `group`	(group_id	,group_name				,creator_id	,create_date)
VALUES  			(6			,N'Cơ sở Thái Thịnh'	,3			,'2019-07-19'),
					(7			,N'Cơ sở Quang Trung'	,3			,'2018-07-19'),
					(8			,N'Cơ sở Lê Lai'		,3			,'2020-07-19'),
					(9			,N'Cơ sở Đăng Văn Ngữ'	,3			,'2018-07-19'),
					(10			,N'Cơ sở Hai Bà Trưng'	,3			,'2020-07-19');

INSERT INTO group_account	(group_id	,account_id	,join_date)
VALUES  					(6			,6			,'2020-01-01'),
							(7			,7			,'2019-01-01'),
							(8			,8			,'2021-01-01'),
							(9			,9			,'2021-01-01'),
							(10			,10			,'2022-01-01');
        
INSERT INTO category_question	(category_id,category_name)
VALUES  						(6			,N'Văn'),
								(7			,N'Toán'),
								(8			,N'Hóa'),
								(9			,N'Anh'),
								(10			,N'Lý');
			
INSERT INTO question(question_id,content						,category_id,type_id,creator_id	,create_date)
VALUES  			(6			,N'1 + 1 = ?'					,7			,1		,3			,'2020-07-19'),
					(7			,N'H2O + O2 = ?'				,8			,1		,3			,'2019-07-19'),
					(8			,N'Ai đã đặt tên cho dòng sông?',6			,1		,3			,'2019-07-19'),
					(9			,N'Người ấy là ai?'				,6			,1		,3			,'2021-07-19'),
					(10			,N'Newton bao nhiêu tuổi?'		,10			,1		,3			,'2021-07-19');

INSERT INTO answer	(answer_id	,content		,question_id,is_correct)
VALUES  			(6			,6				,1			,1),
					(7			,'HOHO'			,7			,0),
					(8			,N'Không Biết'	,8			,0),
					(9			,'John Cena'	,9			,1),
					(10			,'1000'			,10			,0);

INSERT INTO exam(exam_id,`code`		,title					,category_id,duration	,creator_id	,create_date)
VALUES  		(6		,'000006'	,'Test giữa giờ số 6'	,7			,60			,3			,'2021-07-19'),
				(7		,'000007'	,'Test giữa giờ số 7'	,8			,5			,3			,'2021-07-19'),
				(8		,'000008'	,'Test giữa giờ số 8'	,6			,5			,3			,'2020-07-19'),
				(9		,'000009'	,'Test giữa giờ số 9'	,6			,5			,3			,'2020-07-19'),
				(10		,'000010'	,'Test giữa giờ số 10'	,10			,20			,3			,'2022-07-19');

INSERT INTO exam_question	(exam_id,question_id)
VALUES 						(6		,6),
							(7		,7),
							(8		,8),
							(9		,9),
							(10		,10);

-- Question2
SELECT * 
FROM department;

-- Question3
SELECT department_id 
FROM department 
WHERE department_name like '%Sale%';

-- Question4
SELECT * 
FROM `account` 
WHERE LENGTH(full_name) = (SELECT MAX(LENGTH(full_name)) FROM `account`);

-- Question5
SELECT * 
FROM `account` 
WHERE LENGTH(full_name) = 
(SELECT MAX(LENGTH(full_name)) 
FROM `account` WHERE department_id = 3) and department_id = 3;

-- Question6
SELECT * 
FROM `group` 
WHERE create_date < '2019-12-20';
-- c2
SELECT * 
FROM `group` 
WHERE DATE(create_date) < DATE('2019-12-20');

-- Question7
SELECT question_id,COUNT(*) as 'Số câu trả lời' 
FROM answer 
GROUP BY question_id
HAVING COUNT(*) >= 4;

-- Question8
SELECT * 
FROM exam 
WHERE duration >= 60 AND create_date < '2019-12-20';

-- Question9
SELECT * 
FROM `group` 
ORDER BY create_date DESC LIMIT 5;

-- Question10
SELECT COUNT(*) 
FROM `account`
WHERE department_id = '2';

-- Question11
SELECT * FROM `account` WHERE full_name like 'D%o';

-- Question12
DELETE FROM exam 
WHERE create_date < '2019-12-20';

-- Question13
DELETE FROM question 
WHERE content like 'câu hỏi%';

-- Question14
UPDATE `account` SET full_name = N'Nguyễn Bá Lộc',email = 'loc.nguyenba@vti.com.vn' 
WHERE accountID = '5';

-- Question15
UPDATE group_account set group_id = 4 WHERE account_id = 5;
