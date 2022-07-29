-- Question1
SELECT a.FullName,d.DepartmentName 
FROM `account` a
JOIN department d
ON a.DepartmentID = d.DepartmentID;

-- Question2
SELECT * 
FROM `account` 
WHERE CreateDate > '2020-10-20';

-- Question3
SELECT * 
FROM `account` a
JOIN position p
ON a.PositionID = p.PositionID WHERE p.PositionName LIKE '%dev%';

-- Question4
SELECT d.DepartmentName, count(a.AccountID) AS 'Số nhân viên' 
FROM `account` a
JOIN department d
ON a.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentID
HAVING count(a.AccountID) > 3;

-- Question5
SELECT q.*
FROM question q
JOIN examquestion e ON q.QuestionID = e.QuestionID
GROUP BY q.QuestionID
HAVING count(q.QuestionID) =
(SELECT MAX(Soluongcauhoi)
FROM
(SELECT count(*) AS Soluongcauhoi
FROM examquestion
GROUP BY QuestionID) AS Bangsoluongcauhoi)
;

-- Question6
SELECT c.*,count(*) AS so_luong
FROM categoryquestion c
JOIN question q ON c.CategoryID = q.CategoryID
GROUP BY CategoryID;

-- Question7
SELECT q.*,count(*) AS so_luong
FROM question q
JOIN examquestion e ON q.QuestionID = e.QuestionID
GROUP BY q.QuestionID;

-- Question8
SELECT q.QuestionID,q.Content 
FROM question q
JOIN answer a ON q.QuestionID = a.QuestionID
GROUP BY q.QuestionID
HAVING count(*) =
(SELECT max(answer_quantity)
FROM
(SELECT count(*) AS answer_quantity
FROM answer
GROUP BY QuestionID) AS answer_quantity_tbl);

-- Question9
SELECT g.*,count(*) AS account_quantity
FROM `group` g
JOIN groupaccount ga ON g.GroupID = ga.GroupID
GROUP BY g.GroupID;

-- Question10
SELECT p.*
FROM position p
JOIN `account` a ON p.PositionID = a.PositionID
GROUP BY p.PositionID
HAVING count(*) =
(SELECT min(account_quantity)
FROM
(SELECT count(*) AS account_quantity
FROM `account`
GROUP BY PositionID) AS account_quantity_tbl);

-- Question11
SELECT g.GroupID,p.PositionName,count(a.AccountID) AS account_quantity
FROM `group` g 
LEFT JOIN groupaccount ga ON g.GroupID = ga.GroupID
LEFT JOIN `account` a ON a.AccountID = ga.AccountID
LEFT JOIN position p ON p.PositionID = a.PositionID
GROUP BY g.GroupID,p.PositionID
ORDER BY g.GroupID;

-- Question12
SELECT q.QuestionID,q.Content,t.TypeName,c.CategoryName,a.FullName,an.Content
FROM question q
LEFT JOIN typequestion t ON q.TypeID = t.TypeID
LEFT JOIN categoryquestion c ON q.CategoryID = c.CategoryID
LEFT JOIN `account` a ON q.CreatorID = a.AccountID
LEFT JOIN answer an ON q.QuestionID = an.QuestionID
ORDER BY q.QuestionID;

-- Question13
SELECT t.*,count(*) AS question_quantity
FROM typequestion t
JOIN question q ON t.TypeID = q.TypeID
GROUP BY q.TypeID;

-- Question14
SELECT g.*,count(ga.GroupID) AS account_quantity
FROM `group` g
LEFT JOIN groupaccount ga ON g.GroupID = ga.GroupID
GROUP BY g.GroupID
HAVING account_quantity = 0;

-- Question15
SELECT g.*,count(ga.GroupID) AS account_quantity
FROM `group` g
LEFT JOIN groupaccount ga ON g.GroupID = ga.GroupID
GROUP BY g.GroupID
HAVING account_quantity = 0;

-- Question16
SELECT q.*,count(a.QuestionID) AS answer_quantity
FROM question q
LEFT JOIN answer a ON q.QuestionID = a.QuestionID
GROUP BY q.QuestionID
HAVING answer_quantity = 0;

-- Question17
SELECT * 
FROM `account` a 
JOIN groupaccount g ON a.AccountID = g.AccountID
WHERE g.GroupID = 1

UNION

SELECT * 
FROM `account` a 
JOIN groupaccount g ON a.AccountID = g.AccountID
WHERE g.GroupID = 2;

-- Question18
SELECT * 
FROM `group` g1
JOIN groupaccount g2 ON g1.GroupID = g2.GroupID
GROUP BY g1.GroupID
HAVING count(*) > 5
UNION
SELECT * 
FROM `group` g1
JOIN groupaccount g2 ON g1.GroupID = g2.GroupID
GROUP BY g1.GroupID
HAVING count(*) < 7

