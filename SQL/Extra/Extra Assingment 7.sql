/* Exercise 1: Tiếp tục với Database ở buổi 6
Viết triggers để tránh trường hợp người dùng nhập thông tin module Project không hợp
lệ
(Project_Modules.ProjectModulesDate < Projects.ProjectStartDate,
Project_Modules.ProjectModulesCompletedOn > Projects.ProjectCompletedOn) */

DROP TRIGGER IF EXISTS date_rule;

DELIMITER $$
CREATE TRIGGER date_rule
BEFORE 
INSERT ON Project_Modules
FOR EACH ROW
BEGIN
	
	IF NEW.ProjectModuleDate < ProjectStartDate THEN
    SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'MODULE_DATE_CANNOT_BE_BEFORE_PROJECT_DATE';
    END IF;
END $$;
DELIMITER ;