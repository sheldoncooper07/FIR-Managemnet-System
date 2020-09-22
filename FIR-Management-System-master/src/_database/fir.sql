-- PRAGMA foreign_keys = ON; 
CREATE TABLE Person(
 CNIC integer PRIMARY KEY, 
 Name varchar(255) NOT NULL, 
 Father_Name varchar(255) NOT NULL, 
 Age integer NOT NULL, 
 Address varchar(255) NOT NULL,
 DOA integer NOT NULL,
 Gender integer NOT NULL,
 check ( CNIC > 0 ),
 check (Age >= 0),
 check (Gender in (1,2,3)),
 Check (DOA in (1,2))
);

CREATE TABLE Person_Contact(
 CNIC integer NOT NULL,
 Contact integer NOT NULL,
 PRIMARY KEY (CNIC, Contact),
 FOREIGN KEY (CNIC) REFERENCES Person(CNIC), 
 check ( Contact >= 0 )
);

create table police_station
(
police_station_id integer primary key,
police_station_name varchar(255) not null,
location varchar(255) not null,
city varchar(255) not null,
head_id integer not null unique,
foreign key (head_id) references Person (CNIC),
Check (police_station_id > 0) 
);

CREATE TABLE police_station_contact
(
police_station_id integer not null,
 contact integer not null,
 PRIMARY KEY (police_station_id, contact),
 FOREIGN KEY (police_station_id) REFERENCES police_station(police_station_id), 
 check ( contact > 0 )
);


CREATE TABLE Police_Officer
(
Officer_ID integer PRIMARY KEY,
Email varchar(255) NOT NULL,
Police_Station_ID integer NOT NULL,
Officer_phone integer NOT NULL,
FOREIGN KEY (Officer_ID) REFERENCES Person(CNIC),
FOREIGN KEY (police_station_ID) REFERENCES police_station(police_station_ID)
);


CREATE TABLE PRISON
(
        Prison_ID INTEGER,
        Prison_Address varchar(265) not null,
        PRIMARY KEY(Prison_ID),
        check (Prison_ID > 0)
); 

Create table prisoner (
prisoner_no integer not null,
prisoner_id integer not null,
identification_mark varchar(255) not null,
crime_description varchar(255) not null,
prison_id integer not null,
Primary key (prisoner_id),
foreign key (prisoner_id) references Person (CNIC),
foreign key (prison_id) references PRISON (Prison_ID), 
Check (prisoner_no > 0),
Check (prisoner_id > 0),
Check (prison_id > 0)
);

CREATE TABLE SECTIONS 
(
        Section_ID INTEGER not null,
        Crime_Desc VARCHAR(200) not null,
        Prison_Time INTEGER not null,
        Fine INTEGER not null,
        PRIMARY KEY(Section_ID),
        check (Section_ID > 0),
        check (Prison_Time >=0),
        check (Fine >= 0)
);


CREATE TABLE FIR
(
 FIR_ID integer PRIMARY KEY,
 Date_of_Report date NOT NULL,
 Officer_ID integer NOT NULL,
 Description varchar(1000) NOT NULL,
 Complainer_ID integer NOT NULL,
 FOREIGN KEY (Officer_ID) REFERENCES Police_Officer(Officer_ID),
FOREIGN KEY (Complainer_ID) REFERENCES Person(CNIC)
);


CREATE TABLE Cases(
        Case_ID INTEGER ,
        Witness INTEGER not null,
        Court varchar(265) not null, 
        Prosecution_Lawyer_ID INTEGER not null,        
        Defence_Lawyer_ID INTEGER not null,
        Judge_ID INTEGER not null,
        Case_Status INTEGER not null,
        Section_ID INTEGER not null,
        Charge_Sheet_No INTEGER not null,
        FIR_ID INTEGER not null,
        Prisoner_ID INTEGER null,
        PRIMARY KEY(Case_ID),
        FOREIGN KEY(Section_ID) references SECTIONS(Section_ID),
        FOREIGN KEY(Prisoner_ID) references prisoner(prisoner_id),
        FOREIGN KEY(FIR_ID) references FIR (FIR_ID),
        Check (Case_ID > 0),
        Check(Judge_ID >0),
        Check (Section_ID > 0),
        Check (Charge_Sheet_No >0),
        Check (FIR_ID >0),
        Check (Prisoner_ID >0)
);

CREATE TABLE Accused_Status
(
 Status integer PRIMARY KEY,
 Meaning varchar(255) NOT NULL,
 check(Status in (1,2))
);

INSERT INTO Accused_Status Values(1,'Not in custody');
INSERT INTO Accused_Status Values(2,'In Custody');

CREATE TABLE Accused
(
 Accused_ID integer PRIMARY KEY,
 Remarks varchar(255) NULL,
 Status integer NULL,
 FOREIGN KEY (Accused_ID) REFERENCES Person(CNIC),
 check(Status in (1,2))
);


CREATE TABLE Victims_FIR
(
Victim_ID integer,
FIR_ID integer,
FOREIGN KEY (Victim_ID) REFERENCES Person(CNIC),
FOREIGN KEY (FIR_ID) REFERENCES FIR (FIR_ID),
PRIMARY KEY(Victim_ID, FIR_ID)
);

CREATE TABLE Accused_FIR
(
 Accused_ID integer not null,
FIR_ID integer not null,
 FOREIGN KEY (Accused_ID) REFERENCES Person(CNIC),
FOREIGN KEY (Accused_ID) REFERENCES Accused(Accused_ID),
FOREIGN KEY (FIR_ID) REFERENCES FIR(FIR_ID),
PRIMARY KEY(FIR_ID, Accused_ID)
);

CREATE TABLE CASE_FIR
(
CASE_ID integer not null,
FIR_ID integer not null,
FOREIGN KEY (CASE_ID) REFERENCES Cases (Case_ID),
FOREIGN KEY (FIR_ID) REFERENCES FIR(FIR_ID),
PRIMARY KEY(FIR_ID, CASE_ID)
);

CREATE TABLE Charge_Sheet
(
        Charge_Sheet_No integer PRIMARY KEY,
        Description VARCHAR(1000),
        Date date NOT NULL
);
CREATE TABLE Charge_Sheet_Sections
(
        Charge_Sheet_No integer,
        Section_ID integer,
        FOREIGN KEY (Section_ID) REFERENCES SECTIONS(Section_ID),
        FOREIGN KEY (Charge_Sheet_No) REFERENCES Charge_Sheet(Charge_Sheet_No),
        PRIMARY KEY (Charge_Sheet_No, Section_ID)
);

Create table Accused_charge_sheet_no
(
Accused_id integer not null,
charge_sheet_no integer not null,
Primary Key (Accused_id, charge_sheet_no),
Foreign Key (Accused_id) references Accused (Accused_ID),
FOREIGN KEY (charge_sheet_No) REFERENCES Charge_Sheet(Charge_Sheet_No),
Check (charge_sheet_no > 0)
);


INSERT INTO Person Values(10001,'Abhinav Shukla','Vibhor',20,'Kalyanpur,Kanpur',2,1);
INSERT INTO Person Values(10002,'Raghukul Raman','Vibhor',20,'Kanpur',2,1);
INSERT INTO Person Values(10003,'Rhaegar Targaryen','Mad King',40,'Kings Landing',1,1);
INSERT INTO Person Values(10004,'Lyanna Stark','some stark',39,'Winterfell',1,2);
INSERT INTO Person Values(10005,'Aegon Targaryen','Rhaegar Targaryen',29,'Winterfell',2,1);
INSERT INTO Person Values(10006,'Shubhi ','Shyamal',34,'Mumbai',2,2);
INSERT INTO Person Values(10007,'Shivam','Mayank',45,'Jaipur',2,1);
INSERT INTO Person Values(10008,'Kamla','Harsh',34,'Delhi',2,2);
INSERT INTO Person Values(10009,'Sharmishta','Sushil',37,'Kolkata',2,2);
-- Judges - 
INSERT INTO Person Values(10010,'Arya','Kabir',56,'Kanpur',2,1);
INSERT INTO Person Values(10011,'Deepak','Sachin',61,'Delhi',2,1);
INSERT INTO Person Values(10012,'Ketan','Rahul',57,'Kolkata',2,1);
-- Lawyers - 
INSERT INTO Person Values(10013,'Supriyo','Jatin',34,'Kanpurl',2,1);
INSERT INTO Person Values(10014,'Abhijit','Jai',37,'Kanpur',2,1);
INSERT INTO Person Values(10015,'Lalit','Harpreet',39,'Delhil',2,1);
INSERT INTO Person Values(10016,'Shyama','Tarun',28,'Kolkata',2,2);
-- Police officers - 
INSERT INTO Person Values(10017,'Harish','Akash',35,'Jaipur',2,1);
INSERT INTO Person Values(10018,'Karan','Aman',45,'Kolkatal',2,1);
INSERT INTO Person Values(10019,'Hardik','Kaushal',38,'Delhi',2,1);
INSERT INTO Person Values(10020,'Ashdeep','Sameer',29,'Kanpur',2,1);
INSERT INTO Person Values(10021,'Deep','Sarthak',25,'Mumbai',2,1);
-- Accused - 
INSERT INTO Person Values(10022,'Joffrey','Robert',19,'Jaipur',2,1);
INSERT INTO Person Values(10023,'Voldemort','Tom',85,'Kolkatal',2,1);
INSERT INTO Person Values(10024,'Draco','Lucius',28,'Delhi',2,1);
INSERT INTO Person Values(10025,'Duryodhana','Dhritarashtra',49,'Kanpur',2,1);
INSERT INTO Person Values(10026,'Tyrion','Tywin',45,'Mumbai',2,1);


INSERT INTO Person_Contact Values(10001, 5578);
INSERT INTO Person_Contact Values(10002,6756 );
INSERT INTO Person_Contact Values(10003,5689 );
INSERT INTO Person_Contact Values(10004, 6754);
INSERT INTO Person_Contact Values(10005, 4577);
INSERT INTO Person_Contact Values(10006,2390 );
INSERT INTO Person_Contact Values(10007,6673 );
INSERT INTO Person_Contact Values(10008,7755 );
INSERT INTO Person_Contact Values(10009,2739 );
INSERT INTO Person_Contact Values(10010, 2753);
INSERT INTO Person_Contact Values(10011,7762 );
INSERT INTO Person_Contact Values(10012,6755 );
INSERT INTO Person_Contact Values(10013, 2272);
INSERT INTO Person_Contact Values(10014,7854 );
INSERT INTO Person_Contact Values(10015,4830 );
INSERT INTO Person_Contact Values(10016,2355 );
INSERT INTO Person_Contact Values(10017,2343 );
INSERT INTO Person_Contact Values(10018,2344 );
INSERT INTO Person_Contact Values(10019,7893 );
INSERT INTO Person_Contact Values(10020, 6729);
INSERT INTO Person_Contact Values(10021, 6721);



INSERT INTO police_station Values(1,'Kalyanpur Station' ,'Kalyanpur','Kanpur' ,10020 );
INSERT INTO police_station Values(2, 'Gokulpura Station', 'Gokulpura' ,'Jaipur' ,10017 );
INSERT INTO police_station Values(3, 'Lajpat Nagar Station','Lajpat Nagar' ,'Delhi' ,10019 );
INSERT INTO police_station Values(4, 'Shyampur Station','Shyampur' ,'Kolkata' ,10018 );
INSERT INTO police_station Values(5,'Andheri Station' ,'Andheri' ,'Mumbai' ,10021 );

INSERT INTO police_station_contact Values(1, 4673);
INSERT INTO police_station_contact Values(2, 3882);
INSERT INTO police_station_contact Values(3, 2922);
INSERT INTO police_station_contact Values(4, 4892);
INSERT INTO police_station_contact Values(5, 2839);

INSERT INTO Police_Officer Values(10017,'karan' ,2 ,2343 );
INSERT INTO Police_Officer Values(10018,'ashdeep' ,4 ,2344 );
INSERT INTO Police_Officer Values(10019,'hardik' ,3 ,7893 );
INSERT INTO Police_Officer Values(10020,'harish' ,1 ,6729 );
INSERT INTO Police_Officer Values(10021,'deep' ,5 , 6721);

INSERT INTO PRISON values (101, 'Kalyanpur, Kanpur');
INSERT INTO PRISON values (102, 'Jaipur');
INSERT INTO PRISON values (103, 'King’s Landing');
INSERT INTO PRISON values (104, 'Winterfell');
INSERT INTO PRISON values (105, 'Jaipur');
INSERT INTO PRISON values (106, 'Pune');
INSERT INTO PRISON values (107, 'Mumbai');
INSERT INTO PRISON values (108, 'Kolkata');
INSERT INTO PRISON values (109, 'Pune');


INSERT INTO FIR Values(1,"2009-09-12",10017,'The accused beated me',10001);
INSERT INTO FIR Values(2,"2016-09-11",10018,'Murder',10006);
INSERT INTO FIR Values(3,"2016-10-10",10019,'Murder',10002);
INSERT INTO FIR Values(4,"2018-09-01",10020,'Theft',10004);
INSERT INTO FIR Values(5,"2019-01-11",10021,'Robbery',10005);

INSERT INTO prisoner Values(1, 10005, 'Black spot on neck', 'Murder and Theft', 101);
INSERT INTO prisoner Values(1, 10006, '6 fingers on Right Hand', 'Theft and Kidnapping', 102);
INSERT INTO prisoner Values(1, 10004, 'Birthmark on Stomach', 'Domestic Violence', 107);

INSERT INTO SECTIONS VALUES(311, 'Murder', 14, 10000);
INSERT INTO SECTIONS VALUES(431, 'Theft', 2 , 5000);
INSERT INTO SECTIONS VALUES(201, 'Caste Atrocities', 5, 8000);
INSERT INTO SECTIONS VALUES(312, 'Domestic Violence', 4, 10000);
INSERT INTO SECTIONS VALUES(420, 'Corruption', 6, 100000);

INSERT into Cases values (101, 10001, 'Delhi Local Court', 10002, 10003, 10004, 1, 311, 1, 1,  10005);
INSERT into Cases values (102, 10002, 'Kanpur Local Court', 10003, 10004, 10001, 0, 420, 11, 2,  10006);
INSERT into Cases values (103, 10005, 'High Court', 10001, 10002, 10003, 1, 431, 5, 3,  10004);
INSERT into Cases values (104, 10006, 'Supreme Court', 10003, 10001, 10002, 0, 201, 9, 4,  10005);
INSERT into Cases values (105, 10004, 'Delhi Court', 10001, 10003, 10002, 0, 312, 15, 5,  10006);
INSERT into Cases values (106, 10007, 'Delhi Court', 10001, 10002, 10003, 1, 420, 25, 5,  10005);

INSERT into Accused Values(10022, 'tall, no past record', 1);
INSERT into Accused Values(10023, 'Fair, blue eyes', 2);
INSERT into Accused Values(10024, 'Long hair, thin', 1);
INSERT into Accused Values(10025, 'bald', 1);
INSERT into Accused Values(10026, 'short, dwarf', 2);

INSERT into Accused_FIR Values(10022, 1);
INSERT into Accused_FIR Values(10023, 2);
INSERT into Accused_FIR Values(10024, 3);
INSERT into Accused_FIR Values(10025, 4);
INSERT into Accused_FIR Values(10026, 5);

INSERT into CASE_FIR Values(101, 1);
INSERT into CASE_FIR Values(102, 2);
INSERT into CASE_FIR Values(103, 3);
INSERT into CASE_FIR Values(104, 4);
INSERT into CASE_FIR Values(105, 5);

INSERT into Victims_FIR Values(10012, 1);
INSERT into Victims_FIR Values(10013, 1);
INSERT into Victims_FIR Values(10022, 2);
INSERT into Victims_FIR Values(10002, 3);
INSERT into Victims_FIR Values(10009, 4);
INSERT into Victims_FIR Values(10017, 5);
INSERT into Victims_FIR Values(10004, 5);

INSERT into Charge_Sheet Values(1, 'Murder, Rape', "2019-02-12");
INSERT into Charge_Sheet Values(2, 'Theft', "2019-03-14");
INSERT into Charge_Sheet Values(3, 'Caste Atrocities', "2019-04-20");

INSERT into Charge_Sheet_Sections Values(3, 201);
INSERT into Charge_Sheet_Sections Values(1, 311);
INSERT into Charge_Sheet_Sections Values(2, 431);

INSERT into Accused_charge_sheet_no Values(10022, 3);
INSERT into Accused_charge_sheet_no Values(10025, 2);
INSERT into Accused_charge_sheet_no Values(10023, 1);
