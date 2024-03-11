
DROP DATABASE IF EXISTS cs122a_hw4;
CREATE DATABASE cs122a_hw4;
USE cs122a_hw4;

-- User Table
CREATE TABLE Users (
    UCINetID VARCHAR(20) PRIMARY KEY NOT NULL,
    FirstName VARCHAR(50),
    MiddleName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Student Delta Table
CREATE TABLE Students (
    UCINetID VARCHAR(20) PRIMARY KEY NOT NULL,
    FOREIGN KEY (UCINetID) REFERENCES Users(UCINetID)
      ON DELETE CASCADE
);

-- Administrator Delta Table
CREATE TABLE Administrators (
    UCINetID VARCHAR(20) PRIMARY KEY NOT NULL,
    FOREIGN KEY (UCINetID) REFERENCES Users(UCINetID)
      ON DELETE CASCADE
);

-- Course Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY NOT NULL,
    Title VARCHAR(100),
    Quarter VARCHAR(20)
);

-- Project Table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(100),
    Description TEXT,
    CourseID INT NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Machine Table
CREATE TABLE Machines (
    MachineID INT PRIMARY KEY NOT NULL,
    IPAddress VARCHAR(15),
    OperationalStatus VARCHAR(50),
    Location VARCHAR(255)
);

CREATE TABLE MachineHostnames (
    MachineID INT NOT NULL,
    Hostname VARCHAR(255),
    PRIMARY KEY (MachineID, Hostname),
    FOREIGN KEY (MachineID) REFERENCES Machines (MachineID)
    ON DELETE CASCADE
);


-- Software Table
CREATE TABLE Software (
    SoftwareID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(100),
    VersionNumber VARCHAR(50),
    LicenseKey VARCHAR(255)
);

-- Task Table
CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY NOT NULL,
    MachineID INT NOT NULL,
    Description TEXT,
    PriorityLevel INT,
    AssignedDate  DATETIME,
    FOREIGN KEY (MachineID) REFERENCES Machines (MachineID)
);

-- MaintenanceRecord Table
CREATE TABLE MaintenanceRecords (
    RecordID INT PRIMARY KEY NOT NULL,
    ServiceDate DATE,
    Duration INT,
    ServiceType VARCHAR(100),
    MachineID INT NOT NULL,
    FOREIGN KEY (MachineID) REFERENCES Machines(MachineID)
);

-- Install Relationship Table
CREATE TABLE SoftwareOfProjectInstallOnMachine (
    MachineID INT,
    SoftwareID INT,
    ProjectID INT,
    InstallDate DATE,
    PRIMARY KEY (MachineID, SoftwareID, ProjectID),
    FOREIGN KEY (MachineID) REFERENCES Machines(MachineID),
    FOREIGN KEY (SoftwareID) REFERENCES Software(SoftwareID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);


-- Use Relationship Table
CREATE TABLE StudentUseMachinesInProject (
    ProjectID INT,
    StudentUCINetID VARCHAR(20),
    MachineID INT,
    UseDate DATETIME,
    PRIMARY KEY (ProjectID, StudentUCINetID, MachineID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (StudentUCINetID) REFERENCES Students(UCINetID),
    FOREIGN KEY (MachineID) REFERENCES Machines(MachineID)
);

-- Administrator Machine Management Table
CREATE TABLE AdministratorManageMachines (
    AdministratorUCINetID VARCHAR(20),
    MachineID INT,
    PRIMARY KEY (AdministratorUCINetID, MachineID),
    FOREIGN KEY (AdministratorUCINetID) REFERENCES Administrators(UCINetID),
    FOREIGN KEY (MachineID) REFERENCES Machines(MachineID)
);

INSERT INTO `Users` VALUES
('1','Ada','','Larson'),
('10','Therese','Ronaldo','Wiegand'),
('11','Garnett','Burley','Wisozk'),
('12','Willard','','Strosin'),
('13','Rosamond','','Wintheiser'),
('14','Danielle','','Gislason'),
('15','Norma','Lexi','Hauck'),
('16','Gordon','Kailyn','Kilback'),
('17','Chandler','Kenyon','Sauer'),
('18','Isaac','','Walsh'),
('19','Korey','','Davis'),
('2','Mya','Bert','Harvey'),
('20','Candice','Kattie','Becker'),
('3','Darrel','Brendon','Hoeger'),
('4','Zion','','Bauch'),
('5','Daphney','','Fadel'),
('6','Naomie','Eliseo','Hamill'),
('7','Lesley','Katelynn','Kohler'),
('8','Noel','Nicole','Baumbach'),
('9','Barbara','Cecilia','Maggio');

INSERT INTO `Students` VALUES
('1'),
('10'),
('11'),
('12'),
('13'),
('14'),
('15'),
('2'),
('3'),
('4'),
('5'),
('6'),
('7'),
('8'),
('9');

INSERT INTO `Administrators` VALUES
('16'),
('17'),
('18'),
('19'),
('20');


INSERT INTO `Courses` VALUES
(1,'Professional Writing Skills','fall'),
(2,'Graphic Design Principles','spring'),
(3,'Music Theory Introduction','winter'),
(4,'International Relations and Diplomacy','winter'),
(5,'World Religions Overview','winter'),
(6,'Mechanical Systems Design','winter'),
(7,'Public Speaking Mastery','winter'),
(8,'Mobile App Development','winter'),
(9,'Network Security Protocols','fall'),
(10,'Investment Strategies','winter');

INSERT INTO `Machines` VALUES
(1,'172.16.254.7','busy','91422 Sporer Rue Suite 780\nHershelfurt, SC 14307-6149'),
(2,'10.1.1.7','busy','808 Purdy Junction Apt. 386\nReillyborough, NJ 09796-7002'),
(3,'10.1.1.3','idle','519 Grady Landing\nPort Inesfort, MI 73681-6822'),
(4,'10.0.0.4','idle','462 Sabina Stream Apt. 823\nNew Cecile, NM 51163-4543'),
(5,'172.16.0.2','busy','32526 Lorenza Circle\nMertzshire, MD 91123'),
(6,'172.16.0.6','busy','292 Edison Roads Apt. 600\nAlliestad, VA 52205-1063'),
(7,'192.168.0.107','idle','99996 Domenica Tunnel\nHermannland, IN 28203'),
(8,'172.16.0.7','idle','824 Bruen Village\nSouth Deshaunshire, NJ 82446-3353');

INSERT INTO `Projects` VALUES
(1,'Volunteer Matching Application','Fuga ut fuga ut laborum. Et laudantium voluptatem laboriosam. In libero aperiam sequi quaerat non dolor. Quia reprehenderit adipisci rerum voluptatibus.',6),
(2,'Augmented Reality Shopping Assistant','Error qui et sit non quod pariatur. Exercitationem ea rerum quasi et impedit vitae amet. Rem unde non et magni tempora et enim.',3),
(3,'Personalized Skincare Formulation','Accusamus voluptatem eligendi sunt enim aut suscipit sit. Deleniti sapiente blanditiis unde velit nemo. Deserunt qui provident voluptates ab et quia.',6),
(4,'Online Platform for Indie Filmmakers','Iure non quas quod voluptas. Eveniet veritatis aliquid neque rem magnam illo. Esse molestiae sit laudantium voluptatum aliquid id. Quod libero voluptatem dolor nemo.',9),
(5,'3D Printed Prosthetic Development','Eveniet nulla consequatur iusto veritatis. Qui error ratione sapiente sit quisquam quisquam. Vel quibusdam fuga quo ut optio officiis doloremque.',5),
(6,'AI-Based Crop Disease Diagnosis','Voluptatem voluptatem tempore sint accusamus quod magni. Quia error cumque maxime ut. Quo asperiores aut doloremque eius.',2),
(7,'Custom 3D Home Design Tool','Accusantium omnis fuga impedit magni quod nihil. Unde quisquam debitis autem esse. Est vel quia rerum molestiae error voluptatem iste.',8),
(8,'Virtual Reality Meditation App','Velit perspiciatis ipsam aut quisquam reprehenderit. Distinctio aliquid qui dicta rerum ut non. Occaecati alias nostrum et commodi labore suscipit quam. A rerum facilis ut molestias.',8),
(9,'AR Historical Landmarks Guide','Dolorum repellendus consequatur ratione. Id occaecati omnis ab ut. Quas et qui repellendus cum qui libero ipsa. Et nostrum ex quos eos repellendus ab ullam.',10),
(10,'Customizable Meal Planning App','Rerum dolores quia sed distinctio distinctio odio illum. Dolores debitis sunt reiciendis beatae est. Aliquid cum non dolor repudiandae excepturi eos. Aut perferendis accusamus at velit quasi debitis unde.',2),
(11,'Virtual Reality Art Gallery','Repudiandae non aut dolor ea vel odio. Cum non quas praesentium quaerat corporis. Deserunt aut suscipit aut laboriosam eos inventore eum.',6),
(12,'Internet of Things Weather Station','Eum occaecati eligendi consequatur temporibus. Alias eaque totam ullam delectus nostrum ex eos. Et sunt qui corrupti minima veritatis et alias.',7),
(13,'Blockchain-Based Copyright Registry','Deserunt aut ut ut necessitatibus aut. Nobis dolore exercitationem provident deserunt consequatur voluptatem laudantium. Ut ullam maxime voluptatem vitae doloribus.',5),
(14,'Smart Home Security Solution','Et quo dolorum qui. Dolorem cum aut ipsum minima qui. Porro magnam quae saepe autem. Dolore aliquam numquam officiis commodi laboriosam exercitationem qui.',1),
(15,'Peer-to-Peer Book Exchange','Expedita dolores ad dolorem voluptates harum consequatur. Maiores molestiae laudantium dolor hic. Soluta eligendi ad dignissimos reprehenderit.',9);

INSERT INTO `Software` VALUES
(1,'SolarFlare Analytics','v2.1','Itaque quidem facilis aut culpa dolorem iure ullam.'),
(2,'DigiSign Electronic Signature','v5.3','Voluptatem aut dolor libero et sed.'),
(3,'Orbit Social Network Analyzer','v2.2','Amet laborum et a inventore et nemo.'),
(4,'QuantumNet Security','v3.3','Et cupiditate doloribus eos.'),
(5,'EchoCrypt Encryption Suite','v3.3','Non fugit placeat non.'),
(6,'CloudPulse Management System','v2.1','Vitae et sit officia consequuntur quidem.'),
(7,'VisionBoard Creative Toolkit','v3.3','Et et dolores ipsam sed et laudantium.'),
(8,'LightWave Renderer','v52.0','Nemo illum quae architecto possimus praesentium aut totam.'),
(9,'CrystalClear VoIP Service','v4.0','Unde quisquam necessitatibus voluptatem dicta.'),
(10,'VirtuLearn Platform','v2.1','Enim voluptatum recusandae necessitatibus animi repellendus pariatur voluptas alias.'),
(11,'SparkCharge EV Management','v11.2','Et fuga repellat est omnis voluptatum sequi sapiente nihil.'),
(12,'MindMap Brainstorming Tool','v3.3','Nihil qui tempora explicabo nihil quis vitae sed.'),
(13,'EchoCrypt Encryption Suite','v1.1','Provident autem ea quis odio et vel.'),
(14,' CodeStream IDE','v5.3','Molestias sint veniam reprehenderit et ut ut nihil possimus.'),
(15,'DigiSign Electronic Signature','v4.0','Voluptas amet rerum perferendis repellendus accusamus consequatur.'),
(16,'CloudPulse Management System','v5.2','Quia sint laborum consequuntur nisi.'),
(17,'PathFinder GPS Navigator','v5.2','Cumque explicabo dignissimos sunt id accusantium.'),
(18,'TerraForm Landscape Designer','v2.1','Est odio qui est numquam.'),
(19,'NovaNote Digital Workspace','v52.0','Ea ut porro et quia quas.'),
(20,'InfinityLoop DevOps Tool','v3.3','Officiis veniam consectetur magnam eveniet.');


INSERT INTO `Tasks` VALUES
(1,2,'Consequuntur dolore ullam id ab voluptatem. Reprehenderit qui occaecati libero aperiam quia. Soluta dolores voluptate quas quam asperiores assumenda qui non.',4,'2023-12-21 00:00:00'),
(2,3,'Nisi voluptas et dolor aut. Harum eveniet quam qui esse aut. Ipsum quis quas dolorem doloremque sint et soluta.',2,'1992-12-15 00:00:00'),
(3,6,'Expedita deserunt incidunt sit quis repellendus voluptas. Culpa libero iusto voluptatum et asperiores vero commodi et. Optio earum placeat voluptate nobis ab id est.',4,'1974-09-15 00:00:00'),
(4,7,'Dolorum sed labore omnis non ut dicta quidem. Ut voluptatem ut provident qui eum dolores laboriosam ut. Velit quae qui nisi fugit facere illo labore. Minus quia excepturi et sint.',3,'2014-09-24 00:00:00'),
(5,4,'Consequatur aut quis dolorem odio quos eveniet. Non molestiae aut dolor labore sit. Incidunt sed optio repudiandae omnis quasi. Iure sed fugiat exercitationem sit cupiditate temporibus at.',2,'2008-04-14 00:00:00'),
(6,2,'Distinctio ut tempore culpa non est. Ducimus aliquam necessitatibus eum. Magni consequuntur voluptatem cumque ut aut. Sit ea qui autem natus reprehenderit ipsam ratione.',3,'2005-12-22 00:00:00'),
(7,7,'Sit sequi inventore neque natus qui ipsa iure. Ratione voluptatem fuga et aut optio iste. Sapiente maiores et eos illo cumque vero mollitia. Nesciunt voluptas modi et ut quaerat odit.',3,'1976-10-25 00:00:00'),
(8,5,'Excepturi nam aut esse dolor dolorem aut consequuntur. Voluptatem dolor nobis eveniet voluptatem in nam. Totam aut odit cum perferendis animi et. Vel aperiam fugit modi commodi consectetur.',2,'1974-04-21 00:00:00'),
(9,1,'Sit minima atque qui et magni. Non minima voluptatem tempore illum assumenda explicabo dolor. Unde praesentium accusamus rerum quo qui distinctio.',1,'1982-10-16 00:00:00'),
(10,3,'Eius ut libero atque officiis. Fugiat cumque magni omnis. Ipsam aliquam adipisci culpa eos et impedit. Sed occaecati sed architecto.',1,'1994-05-30 00:00:00'),
(11,3,'Maxime tenetur aperiam nihil in aut dolores non. Occaecati earum veritatis excepturi et. Deserunt voluptatum sit in.',1,'1980-04-21 00:00:00'),
(12,3,'Voluptas eos odio sed veritatis architecto atque rerum. Et aperiam aut iste a facilis laudantium. Et vitae assumenda impedit tenetur deserunt aut. Laboriosam provident odio sed at.',3,'1982-06-23 00:00:00'),
(13,7,'Corporis tenetur ullam facere qui soluta sunt aut reprehenderit. Voluptas saepe iusto et dignissimos. Ratione recusandae voluptas ad occaecati accusantium id. Voluptatem occaecati perferendis cum veritatis vitae eligendi.',3,'2020-12-02 00:00:00'),
(14,2,'Fuga neque dolores deserunt error. Architecto adipisci et quo quam voluptatem natus. Maiores temporibus ad deleniti consequuntur. Doloribus facere mollitia aut saepe autem reiciendis aut.',3,'1998-09-20 00:00:00'),
(15,7,'Aut voluptatem odit eligendi ut voluptas quam minus sapiente. Qui dolore consequuntur enim quaerat esse. Ut ipsam iusto vel voluptas aliquam nam consequatur.',4,'2007-11-29 00:00:00'),
(16,7,'Nihil ut illum corrupti minus qui ea ut. Quam aut nihil et ut et. Quia voluptatem nostrum omnis enim consequatur.',2,'1997-05-02 00:00:00'),
(17,5,'Ad voluptas enim saepe asperiores tempore. Perferendis repudiandae dignissimos quasi est ipsam esse ea. Qui quia natus quia similique unde cum.',2,'2002-08-30 00:00:00'),
(18,4,'Et est nisi voluptatem sit debitis accusantium. Unde enim dolorem fugit rem ipsam. Rem non quae nesciunt aliquid illum unde. Quia ipsa consectetur vero consectetur facilis ut.',5,'2020-08-21 00:00:00'),
(19,2,'Repellendus exercitationem expedita ipsam rem omnis. Fugiat quis eius ad amet. Aut eaque maiores repellat. Perferendis voluptas nihil porro illo corporis.',4,'1975-05-15 00:00:00'),
(20,1,'Nihil tempora earum qui fugiat. Fugit eum velit pariatur officia ad vel. Non magnam voluptatem eaque alias.',5,'1988-07-23 00:00:00'),
(21,4,'Consequatur quo aut exercitationem dolores nostrum asperiores magni. Adipisci et et nihil aut ducimus. Eum quisquam tempora beatae repellat velit voluptatem in.',1,'2021-05-27 00:00:00'),
(22,2,'Iusto impedit vero ut rem porro qui. Occaecati voluptatem est sunt voluptatem tempore aliquam consequuntur. Accusantium sint facere quia dicta nobis autem temporibus.',1,'2014-09-05 00:00:00'),
(23,7,'Autem esse est magnam consequatur esse voluptas et. Sit unde odit accusantium corporis fuga reiciendis et ut. Quos eligendi aspernatur reiciendis eum tempore laboriosam quidem. A voluptates consequatur qui eveniet laudantium aut veritatis consequatur.',4,'1975-09-25 00:00:00'),
(24,2,'Modi atque voluptatem doloremque animi fugit et. A velit voluptatem temporibus. Ex ut sunt quam omnis. Atque odit error sed quas non exercitationem.',5,'2002-11-06 00:00:00'),
(25,1,'Sit ex libero omnis voluptate voluptatem alias. Impedit aspernatur dolores voluptas possimus labore recusandae. Iure soluta consequatur voluptatem nesciunt ut qui.',3,'1999-06-02 00:00:00'),
(26,3,'Quibusdam aut dolore esse. Sapiente maiores vel ab distinctio voluptas consequatur. Est dolor eaque atque.',2,'2015-03-25 00:00:00'),
(27,5,'Deserunt temporibus sed similique pariatur nihil alias officiis. Nihil perspiciatis eum omnis laboriosam. Est expedita facilis libero eveniet dolor aliquid. Illo quidem dolorum consectetur corporis fugiat.',4,'1997-05-28 00:00:00'),
(28,2,'Ipsum sed est illum illo perferendis error hic. Molestias temporibus ipsum qui praesentium temporibus rem. Voluptates nihil unde incidunt. Asperiores magni omnis odio ut sint natus.',2,'1989-10-07 00:00:00'),
(29,2,'Enim deleniti explicabo laudantium eius tempora. Vel animi inventore perspiciatis debitis numquam. Quia dolorum voluptas et laboriosam ut cupiditate fugiat.',2,'1979-11-15 00:00:00'),
(30,2,'Non voluptate voluptate eveniet illo. Omnis itaque maiores sint itaque et libero. Nam rerum velit dolorem eveniet veniam.',3,'2007-05-13 00:00:00');

INSERT INTO `MaintenanceRecords` VALUES
(1,'2007-03-19',5,'upgrade',3),
(2,'1982-06-29',6,'fix',8),
(3,'2009-03-09',9,'replace',2),
(4,'1982-04-27',4,'replace',3),
(5,'1974-06-20',9,'fix',1),
(6,'2016-04-05',6,'upgrade',2),
(7,'2016-05-03',5,'upgrade',8),
(8,'2011-11-24',6,'replace',8),
(9,'2015-03-19',3,'reboot',2),
(10,'2005-02-27',4,'upgrade',2),
(11,'1996-10-07',9,'replace',2),
(12,'1988-06-20',8,'upgrade',4),
(13,'2020-04-15',3,'replace',3),
(14,'1984-08-26',5,'reboot',4),
(15,'2023-12-25',4,'replace',8),
(16,'2020-09-14',5,'replace',3),
(17,'1986-10-31',4,'fix',8),
(18,'2001-09-11',9,'replace',7),
(19,'1998-05-25',4,'upgrade',2),
(20,'1972-03-10',6,'replace',6);

INSERT INTO `SoftwareOfProjectInstallOnMachine` VALUES
(1,3,7,'1973-08-07'),
(1,4,4,'1974-10-24'),
(1,11,7,'2013-05-27'),
(1,19,11,'1984-05-17'),
(2,1,10,'2004-07-17'),
(2,2,3,'1994-01-01'),
(2,4,12,'2012-01-31'),
(2,12,6,'1998-02-13'),
(2,12,7,'1977-02-28'),
(2,12,12,'2019-01-02'),
(2,17,11,'2003-01-03'),
(3,3,1,'1971-03-01'),
(3,17,8,'1993-12-02'),
(4,3,11,'2012-05-03'),
(4,10,10,'2007-06-08'),
(5,5,1,'1978-02-23'),
(5,8,12,'1983-05-14'),
(5,10,11,'1978-01-03'),
(5,13,6,'2003-12-23'),
(5,15,15,'1997-07-17'),
(5,18,15,'1972-11-26'),
(5,19,11,'2005-09-08'),
(6,1,15,'2023-10-14'),
(6,10,3,'2006-06-23'),
(6,12,3,'1980-10-18'),
(6,19,7,'2000-11-29'),
(7,2,4,'1989-08-04'),
(7,5,7,'1971-07-23'),
(7,6,8,'1998-04-03'),
(8,3,1,'1971-11-08');

INSERT INTO `StudentUseMachinesInProject` VALUES
(1,'15',1,'1980-06-20 00:00:00'),
(1,'2',8,'1991-03-29 00:00:00'),
(1,'4',5,'1979-09-18 00:00:00'),
(1,'4',7,'2010-04-09 00:00:00'),
(2,'11',7,'1988-09-04 00:00:00'),
(2,'14',7,'1998-07-10 00:00:00'),
(2,'2',6,'2017-06-25 00:00:00'),
(2,'7',6,'1988-05-05 00:00:00'),
(3,'10',8,'1977-12-08 00:00:00'),
(4,'13',4,'1971-06-09 00:00:00'),
(4,'5',1,'1983-03-25 00:00:00'),
(5,'12',4,'1997-08-25 00:00:00'),
(5,'14',1,'2007-01-02 00:00:00'),
(5,'4',2,'1993-05-07 00:00:00'),
(5,'9',3,'1974-05-30 00:00:00'),
(6,'3',4,'1974-05-15 00:00:00'),
(6,'4',8,'1974-03-02 00:00:00'),
(7,'11',8,'2003-09-22 00:00:00'),
(7,'14',1,'2013-11-12 00:00:00'),
(7,'15',4,'1984-12-08 00:00:00'),
(7,'2',5,'2015-04-25 00:00:00'),
(7,'4',2,'1982-09-10 00:00:00'),
(7,'5',8,'2001-09-20 00:00:00'),
(7,'6',2,'2020-02-21 00:00:00'),
(8,'14',8,'1989-11-17 00:00:00'),
(8,'3',6,'1984-02-01 00:00:00'),
(9,'11',2,'1998-07-04 00:00:00'),
(9,'11',7,'1998-02-02 00:00:00'),
(9,'14',2,'1992-08-06 00:00:00'),
(9,'14',8,'2017-07-09 00:00:00'),
(9,'15',8,'1983-03-24 00:00:00'),
(9,'4',4,'1979-11-02 00:00:00'),
(9,'5',4,'1980-09-22 00:00:00'),
(9,'9',4,'2005-06-13 00:00:00'),
(10,'13',7,'2020-12-02 00:00:00'),
(10,'14',3,'1992-11-22 00:00:00'),
(10,'3',5,'1987-08-05 00:00:00'),
(10,'6',8,'1994-06-16 00:00:00'),
(11,'14',4,'2010-01-28 00:00:00'),
(11,'4',2,'2007-12-19 00:00:00'),
(12,'7',5,'1997-05-25 00:00:00'),
(13,'11',6,'2012-05-17 00:00:00'),
(13,'4',4,'1990-01-19 00:00:00'),
(13,'7',8,'1995-10-10 00:00:00'),
(13,'8',3,'1972-10-07 00:00:00'),
(14,'7',4,'1976-03-18 00:00:00'),
(14,'8',8,'2008-04-04 00:00:00'),
(14,'9',5,'2004-01-12 00:00:00'),
(15,'1',5,'1981-06-19 00:00:00'),
(15,'10',7,'1995-09-07 00:00:00');

INSERT INTO `AdministratorManageMachines` VALUES
('16',1),
('16',3),
('16',5),
('16',6),
('16',7),
('17',1),
('17',7),
('18',1),
('18',2),
('18',4),
('18',7),
('19',7),
('20',1),
('20',3),
('20',5);

