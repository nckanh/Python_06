-- Question1
SELECT a.full_name,d.department_name 
FROM `account` a
JOIN department d
ON a.department_id = d.department_id;

-- Question2
SELECT * 
FROM `account` 
WHERE create_date > '2020-10-20';

-- Question3
SELECT * 
FROM `account` a
JOIN `position` p
ON a.position_id = p.position_id WHERE p.position_name LIKE '%dev%';

-- Question4
SELECT d.department_name, count(a.account_id) AS 'Số nhân viên' 
FROM `account` a
JOIN department d
ON a.department_id = d.department_id
GROUP BY d.department_id
HAVING count(a.account_id) > 3;

-- Question5
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

-- Question6
SELECT c.*,COUNT(*) AS so_luong
FROM category_question c
JOIN question q ON c.category_id = q.category_id
GROUP BY category_id;

-- Question7
SELECT q.*,count(*) AS so_luong
FROM question q
JOIN exam_question e ON q.question_id = e.question_id
GROUP BY q.question_id;

-- Question8
SELECT q.question_id,q.content 
FROM question q
JOIN answer a ON q.question_id = a.question_id
GROUP BY q.question_id
HAVING COUNT(*) =
(SELECT MAX(answer_quantity)
FROM
(SELECT COUNT(*) AS answer_quantity
FROM answer
GROUP BY question_id) AS answer_quantity_tbl);

-- Question9
SELECT g.*,COUNT(*) AS account_quantity
FROM `group` g
JOIN group_account ga ON g.group_id = ga.group_id
GROUP BY g.group_id;

-- Question10
SELECT p.*
FROM position p
JOIN `account` a ON p.position_id = a.position_id
GROUP BY p.position_id
HAVING COUNT(*) =
(SELECT MIN(account_quantity)
FROM
(SELECT COUNT(*) AS account_quantity
FROM `account`
GROUP BY position_id) AS account_quantity_tbl);

-- Question11
SELECT g.group_id,p.position_name,count(a.account_id) AS account_quantity
FROM `group` g 
LEFT JOIN group_account ga ON g.group_id = ga.group_id
LEFT JOIN `account` a ON a.account_id = ga.account_id
LEFT JOIN `position` p ON p.position_id = a.position_id
GROUP BY g.group_id,p.position_id
ORDER BY g.group_id;

-- Question12
SELECT q.question_id,q.content,t.type_name,c.category_name,a.full_name,an.content
FROM question q
LEFT JOIN type_question t ON q.type_id = t.type_id
LEFT JOIN category_question c ON q.category_id = c.category_id
LEFT JOIN `account` a ON q.creator_id = a.account_id
LEFT JOIN answer an ON q.question_id = an.question_id
ORDER BY q.question_id;

-- Question13
SELECT t.*,COUNT(*) AS question_quantity
FROM type_question t
JOIN question q ON t.type_id = q.type_id
GROUP BY q.type_id;

-- Question14
SELECT g.*,COUNT(ga.group_id) AS account_quantity
FROM `group` g
LEFT JOIN group_account ga ON g.group_id = ga.group_id
GROUP BY g.group_id
HAVING account_quantity = 0;

-- Question15
SELECT g.*,count(ga.group_id) AS account_quantity
FROM `group` g
LEFT JOIN group_account ga ON g.group_id = ga.group_id
GROUP BY g.group_id
HAVING account_quantity = 0;

-- Question16
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

