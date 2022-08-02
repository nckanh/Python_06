-- Question1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
-- Subquery
DROP VIEW IF EXISTS question_1;
CREATE VIEW question_1 AS
SELECT *
FROM `account` 
WHERE department_id IN (SELECT department_id
						FROM department
                        WHERE department_name LIKE '%sale%');

-- CTE
WITH Phong_ban_sale AS (SELECT department_id
						FROM department
                        WHERE department_name LIKE '%sale%')
SELECT *
FROM `account` 
WHERE department_id IN (SELECT department_id
						FROM Phong_ban_sale);
                        
-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
-- Subquery
DROP VIEW IF EXISTS question_2;
CREATE VIEW question_2 AS
SELECT a.*
FROM `account` a
JOIN group_account ga ON a.account_id = ga.account_id
GROUP BY a.account_id
HAVING COUNT(ga.account_id) = (	SELECT MAX(group_quantity)
								FROM (	SELECT COUNT(*) group_quantity
										FROM group_account
                                        GROUP BY account_id) AS A);
                                        
-- CTE
WITH 	Bang_so_luong AS (	SELECT COUNT(*) AS So_luong
							FROM group_account
							GROUP BY account_id
							ORDER BY So_luong desc LIMIT 1)
SELECT a.*
FROM `account` a
JOIN group_account ga ON a.account_id = ga.account_id
GROUP BY a.account_id
HAVING COUNT(ga.account_id) = (	SELECT So_luong
								FROM Bang_so_luong);

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
DROP VIEW IF EXISTS question_3;
CREATE VIEW question_3 AS
SELECT *
FROM question 
WHERE char_length(content) > 300;  

DELETE FROM question_3;


-- CTE
WITH  content_dai AS (	SELECT question_id
						FROM question
                        WHERE char_length(content) > 300)
SELECT * FROM question WHERE question_id IN (SELECT question_id 
											FROM content_dai);

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
-- Subquery
DROP VIEW IF EXISTS question_4;
CREATE VIEW question_4 AS
SELECT d.*,COUNT(a.account_id) AS So_nhan_vien
FROM department d
JOIN `account` a ON d.department_id = a.department_id
GROUP BY d.department_id
HAVING COUNT(a.account_id) = (	SELECT MAX(So_luong)
								FROM (	SELECT COUNT(*) AS So_luong
										FROM `account`
                                        GROUP BY department_id) AS A);
                                        
-- CTE
WITH 	Bang_so_luong AS (	SELECT COUNT(*) AS So_luong
						FROM `account`
						GROUP BY department_id
                        ORDER BY So_luong desc LIMIT 1)
                        
SELECT d.*,COUNT(a.account_id) AS So_nhan_vien
FROM department d
JOIN `account` a ON d.department_id = a.department_id
GROUP BY d.department_id
HAVING COUNT(a.account_id) = (	SELECT So_luong 
								FROM Bang_so_luong);
                                        
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
-- Subquery
DROP VIEW IF EXISTS question_5;
CREATE VIEW question_5 AS
SELECT *
FROM question
WHERE creator_id IN 	(SELECT account_id
						FROM `account`
						WHERE full_name LIKE 'Nguyễn%');
                        
-- CTE

WITH account_nguyen AS (SELECT account_id
						FROM `account`
						WHERE full_name LIKE '%Nguyễn%')
SELECT *
FROM question
WHERE creator_id IN (	SELECT account_id 
						FROM account_nguyen);
                        
                       