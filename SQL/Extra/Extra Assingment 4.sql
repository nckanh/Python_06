-- Question1
employee_skill_tabledepartmentemployee_tableUSE fresher;

CREATE TABLE department (
	department_number SMALLINT PRIMARY KEY AUTO_INCREMENT,
    department_name NVARCHAR(200)
);

CREATE TABLE employee_table (
	employee_number INT PRIMARY KEY AUTO_INCREMENT,
    employee_name NVARCHAR(200),
    department_number SMALLINT,
    FOREIGN KEY (department_number) REFERENCES department(department_number)
);

CREATE TABLE employee_skill_table (
	employee_number INT,
    skill_code VARCHAR(50),
    date_registered DATE,
    FOREIGN KEY (employee_number) REFERENCES employee_table(employee_number)
);

-- Question2
INSERT INTO department 	(department_name) 
VALUES					('Sale'),
						('Dev'),
                        ('Support'),
                        ('Marketing'),
                        ('Design'),
                        ('Logistics'),
                        ('Transport'),
                        ('Media'),
                        ('Financial'),
                        ('Manager');

INSERT INTO employee_table 	(employee_name,			department_number) 
VALUES						(N'Phạm Minh Tuấn',		2),
							(N'Phạm Thị Thinh',		2),
							(N'Nguyễn Hoài Anh',	2),
							(N'Hoàng Thu Quỳnh',	3),
							(N'Nguyễn Minh Hà',		3),
							(N'Đỗ Lệ Quyên',		1),
							(N'Nguyễn Tuấn Trung',	1),
							(N'Lê Hồng Sơn',		2),
							(N'Đào Duy Nghĩa',		2),
							(N'Lâm Thị Hương',		10);

INSERT INTO employee_skill_table 	(employee_number,	skill_code,	date_registered) 
VALUES								(1,					'JAVA',		'2020-01-01'),
									(1,					'PYTHON',	'2020-01-01'),
									(2,					'JAVA',		'2020-01-01'),
									(2,					'C++',		'2020-01-01'),
									(3,					'C++',		'2020-01-01'),
									(4,					'EXCEL',	'2020-01-01'),
									(5,					'SQL',		'2020-01-01'),
									(8,					'JAVA',		'2020-01-01'),
									(9,					'PYTHON',	'2020-01-01'),
									(10,				'JAVA',		'2020-01-01');
                                    
-- Question3
SELECT e.employee_name,es.skill_code
FROM employee_table e
JOIN employee_skill_table es ON e.employee_number = es.employee_number
WHERE es.skill_code = 'JAVA';

-- Question4
SELECT d.department_name,count(e.employee_number) AS employee_quantity
FROM department d
LEFT JOIN employee_table e ON d.department_number = e.department_number
GROUP BY d.department_number
HAVING count(e.employee_number) > 3;

-- Question5
SELECT d.department_name,e.employee_name
FROM department d 
LEFT JOIN employee_table e ON d.department_number = e.department_number
ORDER BY d.department_number;

-- Question6
SELECT e.employee_name,count(es.skill_code) AS skill_quantity
FROM employee_table e
LEFT JOIN employee_skill_table es ON e.employee_number = es.employee_number
GROUP BY e.employee_number
HAVING count(es.skill_code) > 1   