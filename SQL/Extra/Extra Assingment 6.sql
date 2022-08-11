-- Create table
DROP DATABASE IF EXISTS Projects_Management;

CREATE DATABASE IF NOT EXISTS Projects_Management;

USE Projects_Management;

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (	EmployeeID 				INT AUTO_INCREMENT,
						EmployeeLastName 		NVARCHAR(100),
                        EmployeeFirstName 		NVARCHAR(100),
                        EmployeeHireDate 		DATE,
                        EmployeeStatus 			NVARCHAR(50),
                        SupervisorID 			INT,
                        SocialSecurityNumber 	VARCHAR(20),
						CONSTRAINT PR_Employee_EmployeeID PRIMARY KEY (EmployeeID)
);

DROP TABLE IF EXISTS Projects;

CREATE TABLE Projects (	ProjectID			INT AUTO_INCREMENT,
						ManagerID			INT,
                        ProjectName			VARCHAR(200),
                        ProjectStartDate	DATE,
                        ProjectDescription	NVARCHAR(200),
                        ProjectDetail		NVARCHAR(200),
                        ProjectCompletedOn	DATE NULL DEFAULT NULL,
                        CONSTRAINT PR_Projects_ProjectID PRIMARY KEY (ProjectID),
                        CONSTRAINT FR_Projects_ManagerID FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID)
);

DROP TABLE IF EXISTS Project_Modules;

CREATE TABLE Project_Modules (	ModuleID 					SMALLINT AUTO_INCREMENT,
								ProjectID 					INT,
                                EmployeeID 					INT,
                                ProjectModuleDate 			DATE,
                                ProjectModuleCompleteOn 	DATE NULL DEFAULT NULL,
                                ProjectModuleDescription 	NVARCHAR(200),
								CONSTRAINT PR_Project_Modules_ModuleID PRIMARY KEY (ModuleID),
								CONSTRAINT FR_Project_Modules_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
                                CONSTRAINT FR_Project_Modules_ProjectID FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);


DROP TABLE IF EXISTS Work_Done;

CREATE TABLE Work_Done (WorkDoneID 			INT AUTO_INCREMENT,
						EmployeeID 			INT,
                        ModuleID 			SMALLINT,
                        WorkDoneDate 		DATE NULL DEFAULT NULL,
                        WorkDoneDescription NVARCHAR(200),
                        WorkDoneStatus 		NVARCHAR(50),
						CONSTRAINT PR_Work_Done_WorkDoneID PRIMARY KEY (WorkDoneID),
						CONSTRAINT FR_Work_Done_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
						CONSTRAINT FR_Work_Done_ModuleID FOREIGN KEY (ModuleID) REFERENCES Project_Modules(ModuleID)
);

-- Insert
INSERT INTO Employee 	(EmployeeLastName	,EmployeeFirstName	,EmployeeHireDate	,EmployeeStatus	,SupervisorID	,SocialSecurityNumber)
VALUES					(N'Văn A'			,N'Nguyễn'			,'2020-01-01'		,N'Đang làm việc',5				,190290389),
						(N'Linh'			,N'Trần'			,'2020-06-01'		,N'Đang làm việc',5				,190489201),
                        (N'Liệt'			,N'Hoàng'			,'2021-10-01'		,N'Đang làm việc',4				,171920568),
                        (N'Hiền'			,N'Đinh'			,'2019-01-01'		,N'Đang làm việc',5				,185192573),
                        (N'Tuấn'			,N'Lê'				,'2019-01-01'		,N'Đang làm việc',NULL			,184022900);

INSERT INTO Projects 	(ManagerID	,ProjectName						,ProjectStartDate	,ProjectDescription				,ProjectDetail				,ProjectCompletedOn)
VALUES					(1			,N'Quản lý sách NXB'				,'2020-11-01'		,N'Quản lý nhập xuất sách'		,N'Xuất nhập tồn'			,NULL),
						(2			,N'Quản lý nhân lực'				,'2022-02-01'		,N'QUản lý số nhân viên'		,N'Số lượng, tiền lương'	,'2021-06-12'),
                        (4			,N'Quản lý tài chính công ty Hathaco','2022-01-01'		,N'Kế toán tiền,Phải thu,...'	,N'Hạch toán'				,NULL),
                        (5			,N'Chấm công'						,'2019-12-01'		,N'TÍnh công và lương'			,N'Tăng ca'					,'2021-12-21'),
                        (5			,N'Hóa đơn điện tử'					,'2021-11-01'		,N'Chuyển đổi HDDT'				,N'Thông tư 78'				,'2022-04-30');


INSERT INTO Project_Modules 	(ModuleID	,ProjectID	,EmployeeID	,ProjectModuleDate	,ProjectModuleCompleteOn,ProjectModuleDescription)
VALUES							(1			,1			,1			,'2020-11-01'		,'2021-09-30'			,'Cashbank'),
								(2			,2			,2			,'2021-10-01'		,NULL					,'Warehouse'),
								(3			,2			,4			,'2022-02-01'		,NULL					,'Employee'),
								(4			,3			,5			,'2022-01-01'		,'2022-05-31'			,'Sale'),
								(5			,3			,5			,'2022-06-01'		,NULL					,'Purchase');


INSERT INTO Work_Done 	(WorkDoneID	,EmployeeID	,ModuleID	,WorkDoneDate	,WorkDoneDescription,WorkDoneStatus)
VALUES					(1			,1			,1			,'2021-09-30'	,'Bank list'		,'Done'),
						(2			,2			,2			,'2021-12-01'	,'Warehouse list'	,'Working'),
						(3			,3			,3			,'2022-05-01'	,'Employee list'	,'Working'),
						(4			,4			,4			,'2022-05-31'	,'Sale invoice'		,'Done'),
						(5			,5			,5			,'2022-07-01'	,'Purchase invoice'	,'Working');
                        
-- Question

/* b) Viết stored procedure (không có parameter) để Remove tất cả thông tin
project đã hoàn thành sau 3 tháng kể từ ngày hiện. In số lượng record đã
remove từ các table liên quan trong khi removing (dùng lệnh print) */

DROP PROCEDURE IF EXISTS delete_project_after_3m;

DELIMITER $$
CREATE PROCEDURE delete_project_after_3m()
BEGIN
	WITH 	find_project AS(SELECT ProjectID
							FROM Projects
							WHERE ProjectCompletedOn < DATE_SUB(NOW(), INTERVAL 3 MONTH)),
    
			find_modules AS (	SELECT ModuleID 
								FROM Project_Modules 
								WHERE ProjectID IN (SELECT * FROM find_project))
                                
	DELETE FROM Work_Done WHERE ModuleID IN (SELECT * FROM find_modules); 
    
	WITH 	find_project AS(SELECT ProjectID
							FROM Projects
							WHERE ProjectCompletedOn < DATE_SUB(NOW(), INTERVAL 3 MONTH))
                            
    DELETE FROM Project_Modules WHERE ProjectID IN (SELECT * FROM find_project);
    
	WITH 	find_project AS(SELECT ProjectID
							FROM Projects
							WHERE ProjectCompletedOn < DATE_SUB(NOW(), INTERVAL 3 MONTH))    
	DELETE FROM Projects WHERE ProjectID IN (SELECT * FROM find_project);

END $$;
DELIMITER ;

CALL delete_project_after_3m();

-- c) Viết stored procedure (có parameter) để in ra các module đang được thực hiện)

DROP PROCEDURE IF EXISTS project_processing;

DELIMITER $$
CREATE PROCEDURE project_processing(IN p_projectid INT)
BEGIN
	SELECT *
    FROM Project_Modules
    WHERE ProjectModuleCompleteOn IS NULL AND ProjectID = p_projectid;
END $$;
DELIMITER ;

CALL project_processing(2);

-- d) Viết hàm (có parameter) trả về thông tin 1 nhân viên đã tham gia làm mặc dù không ai giao việc cho nhân viên đó (trong bảng Works)

DROP PROCEDURE IF EXISTS employee_info;

DELIMITER $$
CREATE PROCEDURE employee_info(IN p_ModuleID INT)
BEGIN
	WITH modules_and_work AS (	SELECT wd.EmployeeID
								FROM Project_Modules pm
                                JOIN Work_Done wd ON pm.ModuleID = wd.ModuleID
                                WHERE pm.EmployeeID <> wd.EmployeeID
                                AND pm.ModuleID = p_ModuleID)
    SELECT * 
    FROM Employee 
    WHERE EmployeeID IN (SELECT * FROM modules_and_work);
END $$;
DELIMITER ;

CALL employee_info(3);