CREATE DATABASE rand_company;
USE rand_company;
CREATE TABLE department(
	dept_num INT NOT NULL PRIMARY KEY,
	name VARCHAR(30) NOT NULL UNIQUE,
	manager_start_date DATE NOT NULL,
	manager_id CHAR(4) NOT NULL UNIQUE
);

CREATE TABLE locations(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	dept_num INT NOT NULL,
	location VARCHAR(100),
	FOREIGN KEY (dept_num) REFERENCES department(dept_num) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE employee(
	ssn CHAR(4) NOT NULL PRIMARY KEY,
	fname VARCHAR(20) NOT NULL,
	mname VARCHAR(20),
	lname VARCHAR(20) NOT NULL,
	sex CHAR(1) NOT NULL,
	address VARCHAR(100),
	salary INT NOT NULL,
	bdate DATE NOT NULL,
	supervised_by CHAR(4),
	dept_num INT NOT NULL UNIQUE,
	FOREIGN KEY (dept_num) REFERENCES department(dept_num) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (supervised_by) REFERENCES employee(ssn) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE department ADD FOREIGN KEY (manager_id) REFERENCES employee(ssn) ON UPDATE CASCADE ON DELETE CASCADE;

CREATE TABLE project(
	name VARCHAR(30) NOT NULL UNIQUE,
	num INT PRIMARY KEY,
	location VARCHAR(50),
	controlling_dept INT NOT NULL,
	FOREIGN KEY (controlling_dept) REFERENCES department(dept_num) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE p_works(
	hours INT NOT NULL,
	employee_id CHAR(4) NOT NULL,
	project_id INT NOT NULL,
	FOREIGN KEY (employee_id) REFERENCES employee(ssn) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (project_id) REFERENCES project(num) ON UPDATE CASCADE ON DELETE CASCADE
);

