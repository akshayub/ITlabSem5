DROP database IF EXISTS healthcare;

CREATE database healthcare;

USE healthcare;

CREATE TABLE Patient(
    pat_id int primary key,
    pat_name varchar(30) not null,
    age int not null,
    sex char not null,
    address varchar(50),
    dob date,
    mob varchar(13)
);

CREATE TABLE Room(
    room_id int primary key,
    room_no int not null,
    room_type varchar(10) not null,
    room_cost int not null
);

CREATE TABLE Receptionist(
    rcp_id int primary key,
    rcp_name varchar(30) not null,
    age int not null,
    address varchar(50),
    mob varchar(13),
    salary decimal(10,2) not null
);

CREATE TABLE Admission(
    admsn_id int primary key,
    pat_id int not null,
    room_id int not null,
    rcp_id int not null,
    admn_date date not null,
    admn_time time,
    foreign key (pat_id) references Patient(pat_id) on update cascade on delete cascade,
    foreign key (room_id) references Room(room_id) on update cascade on delete cascade,
    foreign key (rcp_id) references Receptionist(rcp_id) on update cascade on delete cascade
);

CREATE TABLE Doctor(
    doc_id int primary key,
    doc_name varchar(30) not null,
    age int not null,
    address varchar(50),
    salary decimal(10,2) not null,
    mob varchar(13),
    designation varchar(20),
    passed_from varchar(40)
);

CREATE TABLE Appointment(
    ap_id int primary key,
    pat_id int not null,
    doc_id int not null,
    rcp_id int not null,
    ap_date date not null,
    ap_time time not null,
    foreign key (pat_id) references Patient(pat_id) on update cascade on delete cascade,
    foreign key (doc_id) references Doctor(doc_id) on update cascade on delete cascade,
    foreign key (rcp_id) references Receptionist(rcp_id) on update cascade on delete cascade
);

CREATE TABLE Bill(
    bill_id int primary key,
    bill_purpose varchar(30),
    bill_total decimal(10,2) not null
);

CREATE TABLE Accountant(
    acct_id int primary key,
    acct_name varchar(30) not null,
    age int not null,
    address varchar(50),
    mob varchar(13),
    working_time varchar(15),
    acct_salary decimal(10,2) not null
);

CREATE TABLE Payment(
    pay_id int not null,
    bill_id int not null,
    pat_id int not null,
    acct_id int not null,
    pay_type varchar(10),
    pay_date date,
    primary key (pay_id, bill_id),
    foreign key (pat_id) references Patient(pat_id) on update cascade on delete cascade,
    foreign key (bill_id) references Bill(bill_id) on update cascade on delete cascade,
    foreign key (acct_id) references Accountant(acct_id) on update cascade on delete cascade
);

CREATE TABLE Medicine(
    mdcn_id int primary key,
    mdcn_name varchar(30) not null,
    company varchar(30) not null,
    m_date date not null,
    e_date date,
    price decimal(10,2) not null
);

CREATE TABLE Prescription(
    prs_id int not null,
    doc_id int not null,
    mdcn_id int not null,
    pat_id int not null,
    p_date date not null,
    fee decimal(10,2) not null,
    primary key (prs_id, mdcn_id),
    foreign key (pat_id) references Patient(pat_id) on update cascade on delete cascade,
    foreign key (doc_id) references Doctor(doc_id) on update cascade on delete cascade,
    foreign key (mdcn_id) references Medicine(mdcn_id) on update cascade on delete cascade
);

CREATE TABLE Test(
    test_id int primary key,
    test_name varchar(30) not null,
    t_date date not null,
    rep_date date not null,
    fee decimal(10,2) not null
);

CREATE TABLE Assist(
    srl_no int not null,
    pat_id int not null,
    doc_id int not null,
    test_id int not null,
    a_time time,
    a_date date not null,
    primary key (srl_no, test_id),
    foreign key (pat_id) references Patient(pat_id) on update cascade on delete cascade,
    foreign key (doc_id) references Doctor(doc_id) on update cascade on delete cascade,
    foreign key (test_id) references Test(test_id) on update cascade on delete cascade
);

CREATE TABLE OT(
    ot_id int primary key,
    ot_room_no int not null
);

CREATE TABLE Operation(
    op_id int not null,
    pat_id int not null,
    doc_id int not null,
    ot_id int not null,
    op_date date not null,
    op_time time,
    primary key (op_id, doc_id),
    foreign key (pat_id) references Patient(pat_id) on update cascade on delete cascade,
    foreign key (doc_id) references Doctor(doc_id) on update cascade on delete cascade,
    foreign key (ot_id) references OT(ot_id) on update cascade on delete cascade
);

CREATE TABLE Department(
    dept_id int primary key,
    dept_name varchar(30) not null,
    treatment varchar(50)
);

CREATE TABLE Doctor_From_Department(
    dfd_id int not null,
    doc_id int not null,
    dept_id int not null,
    primary key (dfd_id, doc_id, dept_id),
    foreign key (doc_id) references Doctor(doc_id) on update cascade on delete cascade,
    foreign key (dept_id) references Department(dept_id) on update cascade on delete cascade
);

CREATE TABLE Nurse(
    nrs_id int primary key,
    nrs_name varchar(30) not null,
    age int not null,
    address varchar(50),
    mob varchar(13),
    nrs_wo_shift varchar(30),
    experience int,
    salary decimal(10,2) not null
);

CREATE TABLE Nursing_Service(
    ns_id int not null,
    pat_id int not null,
    nrs_id int not null,
    room_id int not null,
    primary key (ns_id, pat_id, nrs_id),
    foreign key (pat_id) references Patient(pat_id) on update cascade on delete cascade,
    foreign key (nrs_id) references Nurse(nrs_id) on update cascade on delete cascade,
    foreign key (room_id) references Room(room_id) on update cascade on delete cascade
);

CREATE TABLE Ward_Boy(
    wb_id int primary key,
    wb_name varchar(30) not null,
    mob varchar(13),
    w_shift varchar(20),
    salary decimal(10,2) not null
);

CREATE TABLE Cleaning_Service(
    cls_id int not null,
    pat_id int not null,
    wb_id int not null,
    room_id int not null,
    primary key (cls_id, pat_id, wb_id),
    foreign key (pat_id) references Patient(pat_id) on update cascade on delete cascade,
    foreign key (wb_id) references Ward_Boy(wb_id) on update cascade on delete cascade,
    foreign key (room_id) references Room(room_id) on update cascade on delete cascade
);

CREATE TABLE Driver(
    dr_id int primary key,
    dr_name varchar(30) not null,
    mob varchar(13),
    address varchar(50),
    shift varchar(40),
    salary decimal(10,2) not null
);

CREATE TABLE Ambulance(
    amb_id int primary key,
    amb_num int not null,
    capacity int
);

CREATE TABLE Ambulance_Service(
    as_id int primary key,
    pat_id int not null,
    dr_id int not null,
    amb_id int not null,
    foreign key (pat_id) references Patient(pat_id) on update cascade on delete cascade,
    foreign key (dr_id) references Driver(dr_id) on update cascade on delete cascade,
    foreign key (amb_id) references Ambulance(amb_id) on update cascade on delete cascade
);

CREATE TABLE Carriers(
    cr_id int primary key,
    cr_name varchar(30) not null,
    mob varchar(13),
    address varchar(50),
    salary decimal(10,2) not null
);

CREATE TABLE Carrying_Service(
    cs_id int not null,
    cr_id int not null,
    amb_id int not null,
    pat_id int not null,
    primary key (cs_id, cr_id),
    foreign key (pat_id) references Patient(pat_id) on update cascade on delete cascade,
    foreign key (cr_id) references Carriers(cr_id) on update cascade on delete cascade,
    foreign key (amb_id) references Ambulance(amb_id) on update cascade on delete cascade
);


INSERT INTO Patient VALUES 
(1,'Ross',30,'M','Church Street','1987-08-14','4208409801'),
(2,'Joey',28,'M','Baker Street','1989-08-19','4204204201'),
(3,'Monica',27,'F','Park Street','1990-04-22','8520147854');

INSERT INTO Room VALUES
(1,608,'Orange',5000),
(2,611,'Grey',4500),
(3,610,'Green',6000);

INSERT INTO Receptionist VALUES
(1,'Sheldon',25,'Pasedina','9852632547',45000.00),
(2,'Leonard',26,'Los Angeles','8596425478',40000.00),
(3,'Howard',24,'Harvard','1147852369',30000.00);

INSERT INTO Admission VALUES
(1, 1, 1, 2, "2017/10/10", "20:00:00"),
(2, 2, 2, 3, "2017/10/10", "20:00:00"),
(3, 1, 3, 1, "2015/10/10", "20:00:00");

INSERT INTO Doctor VALUES
(1, "Gregory House", 50, "Louis Lane", 6800000, "9852645784", "Diagnostic Medicine", "John Hopkins University"),
(2, "James Wilson", 51, "Bart Street", 5200000, "9545454784", "Head of Oncology", "McGill University"),
(3, "Lisa Cuddy", 45, "Baker Street", 7900000, "9885445784", "Dean Of Medicine", "University of Michigan");

INSERT INTO Appointment VALUES
(1, 2, 2, 3, "2017/10/09", "20:10:00"),
(2, 3, 1, 2, "2017/10/01", "15:00:00"),
(3, 1, 1, 1, "2014/01/15", "14:00:01");

INSERT INTO Bill VALUES
(1, "Lupus treatment", 45000),
(2, "Anasthesia", 13000),
(3, "Ambulance Charges", 120);

INSERT INTO Accountant VALUES
(1, "Mike", 25, "Peter street", "8526932475", "9 to 9", 45000),
(2, "Harvey", 35, "Gryffin street", "8852432475", "8 to 7", 58000),
(3, "Louis", 36, "Lincoln street", "8522547475", "9 to 8", 40000);

INSERT INTO Payment VALUES
(1, 1, 1, 1, "Cash", "2017/10/10"),
(1, 2, 1, 2, "Cheque", "2017/10/10"),
(2, 3, 3, 3, "Card", "2017/10/01");

INSERT INTO Medicine VALUES
(1, "Calpol", "GSK", "2017/08/08", "2020/08/07", 150),
(2, "Dolo 650", "HST", "2017/08/08", "2019/08/07", 250),
(3, "Lopamide", "Indocine", "2016/12/10", "2018/12/09", 50);

INSERT INTO Prescription VALUES
(1, 1, 1, 1, "2017/10/09", 150),
(1, 1, 2, 1, "2017/10/09", 150),
(2, 3, 3, 3, "2016/12/31", 500);

INSERT INTO Test VALUES
(1, "MRI", "2017/10/07", "2017/10/06", 15000),
(2, "Bone Marrow Biopsy", "2017/10/10", "2017/10/10", 12000),
(3, "X-ray", "2017/08/08", "2017/08/07", 1200);

INSERT INTO Assist VALUES
(1, 1, 2, 1, "20:00:00", "2017/10/06"),
(1, 1, 2, 2, "08:00:00", "2017/10/10"),
(2, 2, 2, 3, "12:00:00", "2017/08/08");

INSERT INTO OT VALUES
(1, 105),
(2, 248),
(3, 743);

INSERT INTO Operation VALUES
(1, 1, 1, 1, "2017/10/10", "23:59:59"),
(1, 1, 2, 2, "2017/10/09", "22:00:00"),
(2, 3, 3, 3, "2017/08/08", "05:00:00");

INSERT INTO Department VALUES
(1, "Oncology", "Cancer"),
(2, "Diagnostic Medicine", "Anything but Lupus"),
(3, "Orthopaedic", "Bone damage");

INSERT INTO Doctor_From_Department VALUES
(1, 2, 1),
(2, 1, 2),
(3, 3, 1);

INSERT INTO Nurse VALUES
(1, "Max", 22, "MGM Street", "9854785698", "Morning", 5, 45000),
(2, "Caroline", 21, "World Street", "7418529630", "Night", 3, 40000),
(3, "Elisabeth", 26, "Abby Street", "3692581470", "Evening", 6, 50000);

INSERT INTO Nursing_Service VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 1, 3);

INSERT INTO Ward_Boy VALUES
(1, "Gunther", "7896541230", "Morning", 4500),
(2, "Mike", "7458963210", "Evening", 4000),
(3, "Rob", "7458963120", "Night", 4500);

INSERT INTO Cleaning_Service VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 2, 2, 2);

INSERT INTO Driver VALUES
(1, "Jeremy Clarkson", "7894512646", "Baker street", "Morning", 45000),
(2, "Richard Hammond", "7536984120", "Lane street", "Evening", 45000),
(3, "James May", "1452369870", "Abby street", "Night", 45000);

INSERT INTO Ambulance VALUES
(1, 123, 2),
(2, 541, 3),
(3, 547, 3);

INSERT INTO Ambulance_Service VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 3, 3, 3);

INSERT INTO Carriers VALUES
(1, "Gordon", "1234567890", "Gordon street", 4000),
(2, "Ramsey", "9876543210", "Arryn street", 5000),
(3, "Robert", "9999999999", "Array street", 4500);

INSERT INTO Carrying_Service VALUES
(1, 1, 1, 1),
(1, 2, 1, 1),
(2, 3, 2, 3);