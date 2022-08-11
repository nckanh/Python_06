-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước
DROP TRIGGER IF EXISTS trigger_group;

DELIMITER $$
CREATE TRIGGER trigger_group
BEFORE 
INSERT ON `group`
FOR EACH ROW
BEGIN
	IF NEW.create_date < DATE_SUB(NOW(), INTERVAL 1 YEAR) THEN
    SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'INVALID_CREATE_DATE';
    END IF;
END $$;
DELIMITER ;

INSERT INTO `group`	(group_id,	group_name,creator_id,	create_date)
VALUES  			(120,			N'ACCC',		3,	'2019-07-19');

/* Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào department "Sale" nữa, 
khi thêm thì hiện ra thông báo "Department "Sale" cannot add more user"  */

DROP TRIGGER IF EXISTS stop_create_account_sale;

DELIMITER $$
CREATE TRIGGER stop_create_account_sale
BEFORE
INSERT ON `account`
FOR EACH ROW
BEGIN
	IF NEW.department_id IN (	SELECT department_id
								FROM department
								WHERE department_name like '%sale%') THEN
    SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'Department "Sale" cannot add more user';
    END IF;								
END $$
DELIMITER ;

-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
DROP TRIGGER IF EXISTS max_account_in_group;

DELIMITER $$
CREATE TRIGGER max_account_in_group
BEFORE
INSERT ON group_account
FOR EACH ROW
BEGIN
	DECLARE account_quantity INT;
    
    SELECT COUNT(account_id) INTO account_quantity
    FROM group_account
    WHERE group_id = NEW.group_id
    GROUP BY group_id;
    
	IF account_quantity > 5 THEN
	SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'Maximum account quantity';
    END IF;
END $$
DELIMITER ;

INSERT INTO group_account	(group_id	,account_id	,join_date)
VALUES  					(1			,7			,'2022-01-01'),
							(1			,8			,'2022-01-01'),
							(1			,9			,'2022-01-01');

-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
DROP TRIGGER IF EXISTS max_question_in_exam;

DELIMITER $$
CREATE TRIGGER max_question_in_exam
BEFORE
INSERT ON exam_question
FOR EACH ROW
BEGIN
	DECLARE question_quantity INT;
    
    SELECT COUNT(question_id) INTO question_quantity
    FROM exam_question
    WHERE exam_id = NEW.exam_id
    GROUP BY exam_id;
    
	IF question_quantity > 10 THEN
	SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'Maximum question quantity';
    END IF;
END $$
DELIMITER ;

/* Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
tin liên quan tới user đó */
DROP TRIGGER IF EXISTS max_question_in_exam;

DELIMITER $$
CREATE TRIGGER max_question_in_exam
BEFORE
DELETE ON `account`
FOR EACH ROW
BEGIN
	IF 
    OLD.email = 'admin@gmail.com' THEN
	SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'CAN_NOT_DELETE_ADMIN_ACCOUNT';
    ELSE 
    DELETE FROM group_account WHERE account_id IN(	SELECT account_id 
													FROM `account` 
                                                    WHERE OLD.email <> 'admin@gmail.com');
    END IF;
END $$;
DELIMITER ;

DELETE FROM `account` WHERE account_id = 1;


/* Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
vào departmentID thì sẽ được phân vào phòng ban "waiting Department" */

DROP TRIGGER IF EXISTS update_department;

DELIMITER $$
CREATE TRIGGER update_department
BEFORE
INSERT ON `account`
FOR EACH ROW
BEGIN
	IF NEW.department_id IS NULL THEN
    SET NEW.department_id = (	SELECT department_id 
								FROM department 
								WHERE department_name = 'waiting Department');
    END IF;
END $$
DELIMITER ;
INSERT INTO `account` (`account_id`, `email`, `user_name`, `full_name`, `position_id`, `create_date`) 
VALUES ('16', '12c7@gmail.com', 'nvc123', 'Ng', '3', '2021-07-19');

-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi question, trong đó có tối đa 2 đáp án đúng.

DROP TRIGGER IF EXISTS exam_rule;

DELIMITER $$
CREATE TRIGGER exam_rule
BEFORE
INSERT ON answer
FOR EACH ROW
BEGIN
	DECLARE answer_quanity INT;
    DECLARE right_answer_quantity INT;
    
    SELECT COUNT(answer_id) INTO answer_quanity
	FROM answer
    WHERE question_id = NEW.question_id
	GROUP BY question_id;
    
    SELECT COUNT(is_correct) INTO right_answer_quantity
	FROM answer
    WHERE question_id = NEW.question_id AND is_correct = 1
	GROUP BY question_id;
    
    IF answer_quanity > 4 THEN
	SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'MAXIMUM_ANSWER_IS_4';
    ELSEIF right_answer > 2 THEN
	SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'MAXIMUM_RIGHT_ANSWER_IS_2';  
    END IF;
END $$;
DELIMITER ;

/*Question 8: Viết trigger sửa lại dữ liệu cho đúng:
Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database*/

DROP TRIGGER IF EXISTS update_gender;

DELIMITER $$
CREATE TRIGGER update_gender
BEFORE
INSERT ON `account`
FOR EACH ROW
BEGIN
	IF NEW.gender LIKE 'nam' THEN
	SET NEW.gender = 'M';
    ELSEIF NEW.gender LIKE 'nữ' THEN
    SET NEW.gender = 'F';
    ELSEIF NEW.gender LIKE 'chưa xác định' THEN
    SET NEW.gender = 'U';    
    END IF;
END $$;
DELIMITER ;

ALTER TABLE `account` ADD COLUMN gender VARCHAR(50);
INSERT INTO `account`	(account_id,email,			user_name,	full_name,		department_id,	position_id,create_date,gender)
VALUES  				(122,			'naaaa@gmail.com','naa123',	N'Nguyễn Vănaaa',2,				3,			'2022-07-19','nam');
-- Error Code: 1442. Can't update table 'account' in stored function/trigger because it is already used by 
-- statement which invoked this stored function/trigger.


-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS delete_exam_rule;

DELIMITER $$
CREATE TRIGGER delete_exam_rule
BEFORE
DELETE ON exam
FOR EACH ROW
BEGIN
	IF OLD.create_date > DATE_SUB(NOW(), INTERVAL 2 DAY) THEN
	SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'CAN_NOT_DELETE_EXAM';
    END IF;
END $$;
DELIMITER ;

-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các question khi question đó chưa nằm trong exam nào
DROP TRIGGER IF EXISTS update_question_rule;

DELIMITER $$
CREATE TRIGGER update_question_rule
BEFORE
UPDATE ON question
FOR EACH ROW
BEGIN
	DECLARE v_question INT;

	SELECT COUNT(eq.question_id)  INTO v_question
    FROM question q
    LEFT JOIN exam_question eq ON q.question_id = eq.question_id
    WHERE q.question_id = NEW.question_id;
    
    IF v_question > 0 THEN
 	SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'QUESTION_EXISTS_IN_EXAM'; 
    END IF;
END $$;
DELIMITER ;

UPDATE `question` SET `content` = 'Database là gì?11' WHERE (`question_id` = '1');

DROP TRIGGER IF EXISTS delete_question_rule;

DELIMITER $$
CREATE TRIGGER delete_question_rule
BEFORE
DELETE ON question
FOR EACH ROW
BEGIN
	DECLARE v_question INT;

	SELECT COUNT(eq.question_id)  INTO v_question
    FROM question q
    LEFT JOIN exam_question eq ON q.question_id = eq.question_id
    WHERE q.question_id = OLD.question_id;
    
    IF v_question > 0 THEN
 	SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'QUESTION_EXISTS_IN_EXAM'; 
    END IF;
END $$;
DELIMITER ;

DELETE FROM  question WHERE question_id = '1';


/* Question 12 Lấy ra thông tin exam trong đó:
Duration <= 30 thì sẽ đổi thành giá trị "Short time"
30 < Duration <= 60 thì sẽ đổi thành giá trị "Mediu
Duration > 60 thì sẽ đổi thành giá trị "Long time" */

SELECT *,
	CASE
		WHEN duration <= 30 THEN 'Short time'
        WHEN duration >30 AND duration <= 60 THEN 'Medium time'
        ELSE 'Long time'
        END AS duration_type
FROM exam;

/* Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
là the_number_user_amount và mang giá trị được quy định như sau:2
Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher */

SELECT g.group_id,
	CASE
		WHEN COUNT(ga.account_id) <= 5 THEN 'few'
        WHEN COUNT(ga.account_id) >20 THEN 'higher'
        ELSE 'normal'
        END AS the_number_user_amount
FROM `group` g
LEFT JOIN group_account ga ON g.group_id = ga.group_id
GROUP BY g.group_id;

/* Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban
không có user thì sẽ thay đổi giá trị 0 thành "Không có User" */

SELECT d.department_id,
	CASE
    WHEN COUNT(a.account_id) <> 0 THEN COUNT(a.account_id)
    ELSE 'Không có User'
    END AS account_quantity
FROM department d
LEFT JOIN `account` a ON d.department_id = a.department_id
GROUP BY d.department_id;