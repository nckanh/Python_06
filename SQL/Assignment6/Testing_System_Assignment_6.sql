-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS danh_sach_nhan_vien;

DELIMITER $$
CREATE PROCEDURE danh_sach_nhan_vien (IN `Name` VARCHAR(100))
BEGIN
	SELECT a.*
	FROM `account`  a
    JOIN department d ON a.department_id = d.department_id
	WHERE department_name = `Name`;
END $$
DELIMITER ;

CALL danh_sach_nhan_vien('Phòng Dev');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS so_luong_nhan_vien;

DELIMITER $$
CREATE PROCEDURE so_luong_nhan_vien ()
BEGIN
	SELECT g.group_name,COUNT(ga.account_id) AS SL
	FROM `group` g
    LEFT JOIN group_account ga ON g.group_id = ga.group_id
	GROUP BY g.group_id;
END $$
DELIMITER ;

CALL so_luong_nhan_vien ();

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS f_question_quantity;

DELIMITER $$
CREATE PROCEDURE f_question_quantity ()
BEGIN
    SELECT COUNT(*) AS question_quantity
	FROM question 
    WHERE MONTH(create_date) = MONTH(NOW()) AND YEAR(create_date) = YEAR(NOW())
	GROUP BY type_id;
END $$
DELIMITER ;

CALL f_question_quantity ();

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
-- FUNCTION
DROP FUNCTION IF EXISTS f_max_question;

SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER $$
CREATE FUNCTION f_max_question () RETURNS INT
BEGIN
	DECLARE v_max_question INT;
	WITH max_question AS (	SELECT MAX(question_quantity)
							FROM (	SELECT COUNT(q.question_id) AS question_quantity
									FROM type_question t
                                    LEFT JOIN question q ON t.type_id = q.type_id
                                    GROUP BY t.type_id) AS A)
	SELECT type_id INTO v_max_question
    FROM question
    GROUP BY  type_id
    HAVING count(*) = (SELECT * FROM max_question)
    LIMIT 1; 
    RETURN v_max_question;
END $$
DELIMITER ;
-- Store
DROP PROCEDURE IF EXISTS So_cau_hoi;

DELIMITER $$
CREATE PROCEDURE So_cau_hoi()
BEGIN
	WITH max_type AS (	SELECT count(*)
						FROM question
						GROUP BY type_id)
	SELECT type_id
    FROM question
    GROUP BY type_id
	HAVING count(question_id) >= ALL (SELECT * FROM max_type);
END $$;
DELIMITER ; 

CALL So_cau_hoi();

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question

SELECT type_name
FROM type_question
WHERE type_id = f_max_question() ;


/* Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
chuỗi của người dùng nhập vào */
DROP PROCEDURE IF EXISTS thong_tin_nguoi_dung;

DELIMITER $$
CREATE PROCEDURE thong_tin_nguoi_dung (IN p_group_name VARCHAR(100),IN p_user_name VARCHAR(100))
BEGIN
SELECT g.group_name,a.full_name
FROM `group` g
LEFT JOIN group_account ga ON g.group_id = ga.group_id
LEFT JOIN `account` a ON ga.account_id = a.account_id
WHERE g.group_name LIKE CONCAT('%',p_group_name,'%') OR a.full_name LIKE CONCAT('%',p_user_name,'%');
END$$;
DELIMITER ;

/* Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
username sẽ giống email nhưng bỏ phần @..mail đi
positionID: sẽ có default là developer
departmentID: sẽ được cho vào 1 phòng chờ
Sau đó in ra kết quả tạo thành công */
DROP PROCEDURE IF EXISTS create_user;

DELIMITER $$
CREATE PROCEDURE create_user(IN p_full_name VARCHAR(100),IN p_email VARCHAR(100))
BEGIN
	DECLARE v_positionID INT;
    DECLARE v_departmentID INT;
    
    SELECT position_id INTO v_positionID
    FROM position
    WHERE position_name = 'Dev';
    
    SELECT department_id INTO v_departmentID
    FROM department
    WHERE department_name = 'Phòng ban chờ việc';
    
    INSERT INTO `account` 	(email,user_name,full_name,department_id,position_id)
    VALUES 					(p_email,substring_index(p_email,"@",1),p_full_name,v_departmentID,v_positionID);
    
	SELECT *
    FROM `account`
    WHERE email = p_email;
END$$;
DELIMITER ;

CALL create_user('Anh','anhsk@gmail.com');


/* Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất */
 DROP PROCEDURE IF EXISTS longest_content;
 
 DELIMITER $$
CREATE PROCEDURE longest_content (IN p_type VARCHAR(100))
BEGIN
	WITH 	find_type_id AS (SELECT type_id
							FROM type_question
							WHERE type_name = p_type),
			question_long AS (	SELECT CHAR_LENGTH(q1.content) AS Do_dai
								FROM question q1
								WHERE type_id IN (	SELECT * 
													FROM find_type_id)
								ORDER BY CHAR_LENGTH(q1.content) DESC LIMIT 1)                         
	SELECT *
    FROM question q2
    WHERE CHAR_LENGTH(q2.content) = (SELECT Do_dai FROM question_long);
END $$;
DELIMITER ;

CALL longest_content ('Essay');

/* Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID */
DROP PROCEDURE IF EXISTS delete_exam;

DELIMITER $$
CREATE PROCEDURE delete_exam (IN p_exam INT)
BEGIN
	DELETE
    FROM exam_question
    WHERE exam_id = p_exam;
	DELETE
    FROM exam
    WHERE exam_id = p_exam;
END $$;
DELIMITER ;

CALL delete_exam (10);


/* Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
Sau đó in số lượng record đã remove từ các table liên quan trong khi removing */
DROP PROCEDURE IF EXISTS delete_exam_3y_ago;

DELIMITER $$
CREATE PROCEDURE delete_exam_3y_ago (IN p_exam INT)
BEGIN
	WITH id_delete AS (SELECT exam_id
						FROM exam
                        WHERE YEAR(create_date) = YEAR(NOW))
	SELECT eq.exam_id AS ID_bi_xoa, COUNT(eq.exam_id) AS so_luong_record
    FROM exam_question eq
    JOIN id_delete id ON eq.exam_id = id.exam_id
    GROUP BY eq.exam_id;
    
    DELETE
    FROM exam
    WHERE exam_id IN (SELECT * FROM id_delete);
END $$;
DELIMITER ;


/* Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuyển về phòng ban default là phòng ban chờ việc */
DROP PROCEDURE IF EXISTS delete_department;

DELIMITER $$
CREATE PROCEDURE delete_department (p_department_name VARCHAR(100))
BEGIN
	WITH 	find_department AS (SELECT department_id
								FROM department
                                WHERE department_name = p_department_name),
			find_department_dafault AS (SELECT department_id
										FROM department
										WHERE department_name like 'phòng ban chờ việc')
	UPDATE `account` 
    SET department_id = (SELECT * FROM find_department_dafault)
    WHERE department_id = (SELECT * FROM find_department);
    DELETE FROM department 
    WHERE department_id = (SELECT * FROM find_department);
END $$;
DELIMITER ;

CALL delete_department();

/* Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay */
DROP PROCEDURE IF EXISTS quantity_question_create_by_month;

DELIMITER $$
CREATE PROCEDURE quantity_question_create_by_month ()
BEGIN
	SELECT date_format(create_date,'%M') AS `Month`,count(*) AS quantity_question
	FROM question
	WHERE YEAR(create_date) = YEAR(NOW())
	GROUP BY MONTH(create_date);
END $$;
DELIMITER ;

CALL quantity_question_create_by_month ();

/* Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
(Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng") */
DROP PROCEDURE IF EXISTS question_quantity_create_last_6m;

DELIMITER $$
CREATE PROCEDURE question_quantity_create_last_6m ()
BEGIN
	WITH table_month AS(SELECT MONTH(CURRENT_DATE - INTERVAL 1 MONTH) AS MONTH
						UNION SELECT MONTH(CURRENT_DATE - INTERVAL 2 MONTH) AS MONTH
                        UNION SELECT MONTH(CURRENT_DATE - INTERVAL 3 MONTH) AS MONTH
                        UNION SELECT MONTH(CURRENT_DATE - INTERVAL 4 MONTH) AS MONTH
                        UNION SELECT MONTH(CURRENT_DATE - INTERVAL 5 MONTH) AS MONTH
                        UNION SELECT MONTH(CURRENT_DATE - INTERVAL 0 MONTH) AS MONTH),
		question_create_last_6m AS (SELECT *
									FROM question
                                    WHERE create_date > DATE_SUB(NOW(), INTERVAL 6 MONTH))
	SELECT tm.`MONTH`,COUNT(qcl6.question_id),
    CASE 
    WHEN COUNT(qcl6.question_id) > 0 THEN COUNT(qcl6.question_id)
    ELSE 'không có câu hỏi nào trong tháng'
    END AS 'Số câu hỏi'
    FROM table_month tm
    LEFT JOIN question_create_last_6m qcl6 ON tm.`MONTH` =  MONTH(qcl6.create_date)
    GROUP BY tm.`MONTH`
    ORDER BY tm.`MONTH`;
END $$;
DELIMITER ;

CALL question_quantity_create_last_6m();