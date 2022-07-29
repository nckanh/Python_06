-- Question1
SELECT a.full_name,d.department_name 
FROM `account` a
JOIN department d
ON a.department_id = d.department_id;

-- Question2
SELECT * 
FROM `account` 
WHERE create_date > '2020-10-20';

-- Question3: Viết lệnh để lấy ra tất cả các developer
SELECT * 
FROM `account` a
JOIN `position` p
ON a.position_id = p.position_id WHERE p.position_name LIKE '%dev%';

-- Question4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT d.department_name, count(a.account_id) AS 'Số nhân viên' 
FROM `account` a
JOIN department d
ON a.department_id = d.department_id
GROUP BY d.department_id
HAVING count(a.account_id) > 3;

-- Question5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT q.*
FROM question q
JOIN exam_question e ON q.question_id = e.question_id
GROUP BY q.question_id
HAVING COUNT(q.question_id) =
(SELECT MAX(Soluongcauhoi)
FROM
(SELECT COUNT(*) AS Soluongcauhoi
FROM exam_question
GROUP BY question_id) AS Bangsoluongcauhoi)
;

-- Question6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT c.*,COUNT(q.question_id) AS so_luong, GROUP_CONCAT(q.question_id)
FROM category_question c
LEFT JOIN question q ON c.category_id = q.category_id
GROUP BY c.category_id;

-- Question7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT q.*,COUNT(e.question_id) AS so_luong, GROUP_CONCAT(e.exam_id)
FROM question q
LEFT JOIN exam_question e ON q.question_id = e.question_id
GROUP BY q.question_id;

-- Question8: Lấy ra Question có nhiều câu trả lời nhất
SELECT q.question_id,q.content,COUNT(*) AS max_quantity
FROM question q
JOIN answer a ON q.question_id = a.question_id
GROUP BY q.question_id
HAVING max_quantity =
(SELECT MAX(answer_quantity)
FROM
(SELECT COUNT(*) AS answer_quantity
FROM answer
GROUP BY question_id) AS answer_quantity_tbl);

-- Question9: Thống kê số lượng account trong mỗi group
SELECT g.*,COUNT(ga.account_id) AS account_quantity, GROUP_CONCAT(ga.account_id) AS `account`
FROM `group` g
LEFT JOIN group_account ga ON g.group_id = ga.group_id
GROUP BY g.group_id;

-- Question10: Tìm chức vụ có ít người nhất
SELECT p.*,COUNT(a.account_id) AS account_quantity
FROM position p
LEFT JOIN `account` a ON p.position_id = a.position_id
GROUP BY p.position_id
HAVING account_quantity =
(SELECT MIN(account_quantity)
FROM
(SELECT COUNT(a.account_id) AS account_quantity
FROM `position` p
LEFT JOIN `account` a ON p.position_id = a.position_id 
GROUP BY p.position_id) AS account_quantity_tbl);

-- Question11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM

SELECT d.department_name,p.position_name,count(a.account_id) AS account_quantity
FROM department d
JOIN `account` a ON a.department_id = d.department_id
JOIN `position` p ON a.position_id = p.position_id
GROUP BY d.department_id,a.position_id
ORDER BY d.department_id;

-- Question12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, 
SELECT q.question_id,q.content,t.type_name,c.category_name,a.full_name,an.content
FROM question q
LEFT JOIN type_question t ON q.type_id = t.type_id
LEFT JOIN category_question c ON q.category_id = c.category_id
LEFT JOIN `account` a ON q.creator_id = a.account_id
LEFT JOIN answer an ON q.question_id = an.question_id
ORDER BY q.question_id;

-- Question13:  Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT t.*,COUNT(q.question_id) AS question_quantity
FROM type_question t
LEFT JOIN question q ON t.type_id = q.type_id
GROUP BY q.type_id;

-- Question14: Lấy ra group không có account nào
SELECT g.*,COUNT(ga.group_id) AS account_quantity
FROM `group` g
LEFT JOIN group_account ga ON g.group_id = ga.group_id
GROUP BY g.group_id
HAVING account_quantity = 0;

-- Question15: Lấy ra group không có account nào
SELECT g.*,count(ga.group_id) AS account_quantity
FROM `group` g
LEFT JOIN group_account ga ON g.group_id = ga.group_id
WHERE ga.group_id IS NULL
GROUP BY g.group_id;

-- Question16: Lấy ra question không có answer nào
SELECT q.*,COUNT(a.question_id) AS answer_quantity
FROM question q
LEFT JOIN answer a ON q.question_id = a.question_id
GROUP BY q.question_id
HAVING answer_quantity = 0;

-- Question17
SELECT * 
FROM `account` a 
JOIN group_account g ON a.account_id = g.account_id
WHERE g.group_id = 1

UNION

SELECT * 
FROM `account` a 
JOIN group_account g ON a.account_id = g.account_id
WHERE g.group_id = 2;

-- Question18
SELECT * 
FROM `group` g1
JOIN group_account g2 ON g1.group_id = g2.group_id
GROUP BY g1.group_id
HAVING COUNT(*) > 5
UNION
SELECT * 
FROM `group` g1
JOIN group_account g2 ON g1.group_id = g2.group_id
GROUP BY g1.group_id
HAVING COUNT(*) < 7

