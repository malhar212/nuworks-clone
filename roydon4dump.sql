CREATE DATABASE  IF NOT EXISTS `roydon4` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `roydon4`;
-- MySQL dump 10.13  Distrib 8.0.28, for macos11 (x86_64)
--
-- Host: localhost    Database: roydon4
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `applicationid` int NOT NULL AUTO_INCREMENT,
  `skills` varchar(45) DEFAULT NULL,
  `education` varchar(45) DEFAULT NULL,
  `experience` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `jobid` int DEFAULT NULL,
  `userid` int DEFAULT NULL,
  `submitdate` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`applicationid`),
  KEY `fk_applicationjobid_idx` (`jobid`),
  KEY `fk_applicationuserid_idx` (`userid`),
  CONSTRAINT `fk_applicationjobid_idx` FOREIGN KEY (`jobid`) REFERENCES `job` (`jobid`),
  CONSTRAINT `fk_applicationuserid_idx` FOREIGN KEY (`userid`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `cityid` int NOT NULL AUTO_INCREMENT,
  `cityname` varchar(45) DEFAULT NULL,
  `stateid` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`cityid`),
  KEY `fk_stateid_idx` (`stateid`),
  CONSTRAINT `fk_citystateid` FOREIGN KEY (`stateid`) REFERENCES `state` (`stateid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (2,'Lexington','MA'),(3,'Boston','MA'),(4,'Cambridge','MA'),(5,'Portland','ME'),(6,'Brookline','MA'),(7,'Charlotte','NC'),(8,'Newton Center','MA'),(9,'Raritan','NJ'),(10,'Sydney','FL'),(11,'Wakefield','MA'),(12,'Needham','MA'),(13,'Woburn','MA'),(14,'Vancouver','WA'),(15,'Providence','RI'),(16,'Pawtucket','RI'),(17,'New York','NY'),(18,'Watertown','MA'),(19,'Waltham','MA'),(20,'Newton','MA');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document` (
  `docid` int NOT NULL AUTO_INCREMENT,
  `docname` varchar(45) DEFAULT NULL,
  `docurl` varchar(45) DEFAULT NULL,
  `applicationid` int DEFAULT NULL,
  PRIMARY KEY (`docid`),
  KEY `fk_documentapplicationid_idx` (`applicationid`),
  CONSTRAINT `fk_documentapplicationid` FOREIGN KEY (`applicationid`) REFERENCES `application` (`applicationid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job` (
  `jobid` int NOT NULL AUTO_INCREMENT,
  `position` varchar(255) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `description` longtext,
  `publishdate` datetime DEFAULT NULL,
  `vacancy_count` varchar(45) DEFAULT NULL,
  `status` int DEFAULT '1',
  `locationid` int DEFAULT NULL,
  `organizationid` int DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `userid` int DEFAULT NULL,
  `applicantcount` int DEFAULT '0',
  PRIMARY KEY (`jobid`),
  KEY `fk_joblocationid_idx` (`locationid`),
  KEY `fk_joborganizationid_idx` (`organizationid`),
  KEY `fk_jobuserid_idx` (`userid`),
  KEY `fk_jobstatusid_idx` (`status`),
  CONSTRAINT `fk_joblocationid` FOREIGN KEY (`locationid`) REFERENCES `location` (`locationid`),
  CONSTRAINT `fk_joborganizationid` FOREIGN KEY (`organizationid`) REFERENCES `organization` (`orgid`),
  CONSTRAINT `fk_jobstatusid_idx` FOREIGN KEY (`status`) REFERENCES `jobstatus` (`jobstatusid`),
  CONSTRAINT `fk_jobuserid` FOREIGN KEY (`userid`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES (3,'Project Management Intern','Internship','<p>This is an unpaid Internship at KEVAHEALTH Inc as a Project Management Intern for 40 hours per week. In this position, you will report directly to Jyotsna Mehta beginning May 9, 2022.</p>\r\n<p>This is in accordance with the Fair Labor Standards Act ref.',NULL,'2',2,3,3,'Healthcare',3,0),(4,'Software Engineer Co-op','Full Time / Part Time','<p>ABOUT ACTIV</p>\r\n<p>Founded in 2017, Activ Surgical is a first-of-its kind digital surgery company focused on improving surgical efficiency, accuracy, patient outcomes and accessibility for both endoscopic and robotically assisted procedures. Activ Sur',NULL,'18',2,4,4,'Healthcare',3,0),(5,'Traverso Laboratory - Medical Devices Co-op','Full Time / Part Time','<p>Project Description:<br />Our lab is currently developing the next generation of drug delivery systems. These include extended-release and localized delivery of therapeutic agents. These disruptive technologies will impact the lives of many, helping tr',NULL,'9',3,5,5,'Healthcare',3,0),(6,'Medical Assistant - BWH Ambulatory Infusion Clinic','Co-op','<p><strong>About this unit:</strong> The Medical Assistant (MA) is an integral member of the healthcare team and is accountable for patient care as assigned<br />by a licensed independent provider (LIP: MD, NP, PA,0), a Licensed Practical Nurse (LPN) or a R',NULL,'8',3,4,5,'Healthcare',3,0),(7,'Performance Improvement Intern (Unpaid) - Summer 22','Co-op','<p>CHA Performance Improvement Internship-- (unpaid- Summer/ Fall 2022)</p>\r\n<p>&nbsp;</p>\r\n<p>About Cambridge Health Alliance</p>\r\n<p>Cambridge Health Alliance (CHA) is a vibrant, innovative health system dedicated to providing essential services to all ',NULL,'19',1,5,6,'Healthcare',3,0),(8,'Performance Improvement Intern (Unpaid) Fall 22','Internship','<p>CHA Performance Improvement Internship-- (unpaid- Summer/ Fall 2022)</p>\r\n<p>&nbsp;</p>\r\n<p>About Cambridge Health Alliance</p>\r\n<p>Cambridge Health Alliance (CHA) is a vibrant, innovative health system dedicated to providing essential services to all ',NULL,'5',1,5,6,'Healthcare',3,0),(9,'Predictive Modeling Co-op','Internship','<p>Power of Patients is a digital health tech company and has created a Traumatic Brain Injury (TBI) dashboard for patients and caregivers.</p>\r\n<p>Power of Patients is looking for a Predictive Modeling Co-op that can build and deploy modern analytics sol',NULL,'7',3,6,7,'Healthcare',3,0),(10,'Inpatient Mental Health Worker ','Internship','<p>he opportunity to make a difference that drives you. It\'s taking the time to really listen to a patient so you can do your best to help. It\'s the camaraderie among professionals who push you further than you ever thought you could go. You are physicall',NULL,'8',3,7,8,'Healthcare',3,0),(11,'Staff Accountant - Part Time','Full Time / Part Time','<p>As a Staff Accountant - Part Time, you will work directly with all members of the accounting team including the VP of Finance and Controller to assist in maintaining financial records, documenting supporting schedules, preparing reports, harvesting and',NULL,'3',2,8,9,'Healthcare',3,0),(12,'Medical Assistant','Internship','<p><strong>Otolaryngology Clinics</strong></p>\r\n<p><strong></strong></p>\r\n<ul>\r\n<ul>\r\n<li>Review daily schedule of patients making sure that all the appropriate preparations are in place to facilitate patient flow.</li>\r\n</ul>\r\n</ul>\r\n<p></p>\r\n<ul>\r\n<ul>\r',NULL,'7',1,4,10,'Healthcare',3,0),(13,'Research Assistant','Co-op','<p>The Focused Ultrasound Laboratory at Brigham and Women&rsquo;s Hospital is seeking a talented and motivated recent graduate for a 1-year Technical Research Assistant position.</p>\r\n<p>&nbsp;</p>\r\n<p>We are seeking a candidate to join an on-going resear',NULL,'14',1,4,5,'Healthcare',3,0),(14,'Medical Assistant-Practice Assistant','Full Time / Part Time','<p>Perform Medical Assistant and Practice Assistant related duties, including:</p>\r\n<ul>\r\n<li>Greet patients, perform check in, registration, scheduling, verification of demographic information. Collect co-payments, schedule, reschedule, and cancel appoin',NULL,'2',1,9,11,'Healthcare',3,0),(15,'2022 Supply Chain & Engineering Fall Co-op (June Start)','Internship','<p><strong>Note: This posting is recruiting for the Raritan, NJ site only.</strong></p>\r\n<p><strong>After submitting your resume on NUworks, you also need to click &ldquo;Apply On Website&rdquo; and submit your application on J&amp;J\'s career portal. Your',NULL,'5',1,10,12,'Healthcare',3,0),(16,'Medical Scribe','Co-op','<p><strong>***Must be fluent in English and conversational in Spanish***</strong></p>\r\n<p><br />South End Community Health Center (SECHC) is a comprehensive health care organization for all residents of the South End and surrounding communities. The cente',NULL,'6',3,4,13,'Healthcare',3,0),(17,'Blue Prism Developer / Data Scientist ','Co-op','<p>We are looking to add a Blue Prism Developer / Data Scientist to our Analytics and Business Intelligence Team at the Massachusetts General Hospital\'s Department of Pharmacy!</p>\r\n<p>Massachusetts General Hospital (MGH,0), part of the MGB enterprise, is a',NULL,'8',2,4,14,'Healthcare',3,0),(18,'Clinical Research Recruitment in Developmental Medicine','Co-op','<p>The Boston Children&rsquo;s Hospital Division of Developmental Medicine has an opportunity for a student to work on a project that will support clinical research and provide an opportunity for direct patient contact and research experience in a clinica',NULL,'14',2,4,15,'Healthcare',3,0),(19,'Research Co-Op','Full Time / Part Time','<p><strong>Company Overview</strong></p>\r\n<p>Founded in 2017, Activ Surgical is a new breed medical device start-up focused on improving patient outcomes and reducing costs to healthcare systems through the integration of advanced computer vision, artific',NULL,'19',3,4,4,'Healthcare',3,0),(20,'Traverso Laboratory - Department of Medicine Co-op','Co-op','<p>Traverso Laboratory, Department of Medicine, Brigham and Women&rsquo;s Hospital, Harvard Medical School, Full-time, 40 hours/week</p>\r\n<p>Project Description:<br />We are seeking a&nbsp;cooperative (co-op) education students,&nbsp;in the Traverso Lab a',NULL,'14',1,5,5,'Healthcare',3,0),(21,'Supplier Contracting Services Co-Op (June Start)','Internship','<p><strong>After submitting your resume on NUworks, you also need to click &ldquo;Apply On Website&rdquo; and submit your application on J&amp;J\'s career portal. Your application will only be considered if you\'ve applied in both places.</strong></p>\r\n<p><',NULL,'10',3,10,12,'Healthcare',3,0),(22,'Group Global Co-op - Sydney, Australia','Full Time / Part Time','<p><strong>Group&nbsp;Co-op Program in Sydney, Australia</strong>&nbsp;&nbsp;<br /><br />&nbsp;<br /><br /><strong>Program Description</strong><br /><br /><br /><br />Northeastern is offering,&nbsp;for the first time,&nbsp;a new exciting way of thinking a',NULL,'11',1,11,16,'Accounting',3,0),(23,'Forensic Staff Accountant','Full Time / Part Time','<p>Firm:<br />Meaden &amp; Moore is a leading CPA and business consulting firm that is a five- time winner of The Plain Dealer\'s Top Workplaces, and a four-time winner of Ohio Magazine\'s Best Places to Work who is committed to providing outstanding profes',NULL,'16',1,4,17,'Accounting',3,0),(24,'Audit / Tax Coop (hybrid) - Fall 2022','Co-op','<p>E.J. Callahan &amp; Associates Company Description</p>\r\n<p>&nbsp;</p>\r\n<p>Teamwork. Focus. Passion.</p>\r\n<p></p>\r\n<p>This is a four month co-op - September - December</p>\r\n<p>&nbsp;</p>\r\n<p>Ranked one of the 50 fastest growing companies in Massachusett',NULL,'12',1,12,18,'Accounting',3,0),(25,'Senior Audit Associate (Hybrid) - Fall 2022','Full Time / Part Time','<p><strong>E.J. Callahan &amp; Associates Company Description:</strong></p>\r\n<p>Teamwork. Focus. Passion.</p>\r\n<p>Ranked one of the 50 fastest growing companies in Massachusetts by the Boston Business Journal for 3 consecutive years, E. J. Callahan &amp; ',NULL,'3',2,12,18,'Accounting',3,0),(26,'Senior Tax Associate (Hybrid) - Fall 2022','Full Time / Part Time','<p>E.J. Callahan &amp; Associates Company Description</p>\r\n<p>&nbsp;</p>\r\n<p>Teamwork. Focus. Passion.</p>\r\n<p>&nbsp;</p>\r\n<p>Ranked one of the 50 fastest growing companies in Massachusetts by the Boston Business Journal for 3 consecutive years, E. J. Cal',NULL,'11',2,12,18,'Accounting',3,0),(27,'Tax Internship - January 2023','Internship','<p>As the 64th largest accounting firm in the nation, Grassi is a leading provider of advisory, tax and accounting services to businesses and individuals. Grassi advisors specialize in providing industry-specific business consulting, audit, tax, and techn',NULL,'13',2,13,19,'Accounting',3,0),(28,'Tax/Audit Associate ','Co-op','<p>As the 64th largest accounting firm in the nation, Grassi is a leading provider of advisory, tax and accounting services to businesses and individuals. Grassi advisors specialize in providing industry-specific business consulting, audit, tax, and techn',NULL,'17',3,13,19,'Accounting',3,0),(29,'Finance Co-op - Revenue and Royalties ','Full Time / Part Time','<p></p>\r\n<ol>\r\n<ol>\r\n<li>Scope</li>\r\n</ol>\r\n</ol>\r\n<p><br /><br />&nbsp;<br /><br />Our finance department is looking for a Co-Op/Intern to join the royalty and revenue team to assist with their daily operations.&Acirc;&nbsp; This role will not only aid t',NULL,'7',3,14,20,'Media And Arts',3,0),(30,'Software Engineer, Web - iWork','Internship','<p>Imagine what you could do here. At Apple, new ideas have a way of becoming great products, services, and customer experiences very quickly. Bring passion and dedication to your job and there\'s no telling what you could accomplish. ** We are hiring in V',NULL,'4',3,15,21,'Media And Arts',3,0),(31,'iOS or macOS Software Engineer - iWork','Internship','<p>Imagine what you could do here. At Apple, new ideas have a way of becoming great products, services, and customer experiences very quickly. Bring passion and dedication to your job and there\'s no telling what you could accomplish. ** We are hiring in P',NULL,'7',1,15,21,'Media And Arts',3,0),(32,'Global Logistics Co-op (Hybrid)','Co-op','<p><strong>After submitting your resume on NUworks, you also need to click &ldquo;Apply On Website&rdquo; and submit your application on Hasbro\'s career portal. Your application will only be considered if you\'ve applied in both places.</strong></p>\r\n<p><s',NULL,'5',2,16,22,'Media And Arts',3,0),(33,'Global Supply Chain Co-op (Hybrid)','Co-op','<p><strong>After submitting your resume on NUworks, you also need to click &ldquo;Apply On Website&rdquo; and submit your application on Hasbro\'s career portal. Your application will only be considered if you\'ve applied in both places.</strong></p>\r\n<p><s',NULL,'7',3,16,22,'Media And Arts',3,0),(34,'Animatronics Co-op ','Co-op','<p>Animatronics Co-op</p>\r\n<p>Hasbro is currently recruiting enthusiastic, technically curious &amp; creative engineering students for our Advanced Technology and Innovation (ATI) team.&nbsp; This group researches &amp; presents relevant new technologies ',NULL,'11',3,17,22,'Media And Arts',3,0),(35,'Product Engineering Co-op','Internship','<p>At Hasbro, we&rsquo;re changing the face of play and entertainment! We&rsquo;re looking for people who want to explore, experiment, and innovate to come up with the best ideas. Our culture of Community, Passion, Integrity, Creativity, and Inclusion has',NULL,'8',1,17,22,'Media And Arts',3,0),(36,'REMOTE: Interactive Design Co-op','Co-op','<p style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: proximanova, helvetica neue, helvetica, arial, sans-serif; line-height: 21px;\">iFactory isn\'t just a company, but a clo',NULL,'18',1,4,23,'Media And Arts',3,0),(37,'UX Designer','Internship','<p>Our team is looking for a motivated and passionate individual to support our UX practice. You&rsquo;ll work to optimize our users&rsquo; experience and turn insights into engaging, actionable recommendations that make a difference for our clients.</p>\r',NULL,'14',1,6,24,'Media And Arts',3,0),(38,'Finance Associate','Co-op','<p>FINANCE ASSOCIATE One of New York&rsquo;s leading contemporary art galleries is seeking an energetic, responsible, self-motivated professional to fill a full-time position as Finance Associate.</p>\r\n<p>Founded in 1995 in the historic Chelsea neighborho',NULL,'15',3,18,25,'Media And Arts',3,0),(39,'Brand Management Co-op','Co-op','<p>Playa Society is a fast-growing streetwear brand looking for an MVP Brand and Business Manager who is resourceful, outgoing, and thinks outside of the box. If you&rsquo;re a good teammate, organized, and loves story-telling, keep reading!</p>\r\n<p><br /',NULL,'14',1,4,26,'Media And Arts',3,0),(40,'Data Engineer Intern','Internship','<p>Do you have a passion for data? We are growing our Analytics team! We have an opportunity available for a Data Engineer Intern who will work with partners in IT and across the organization to enable data-driven decisions. This person\'s main responsibil',NULL,'12',3,17,22,'Media And Arts',3,0),(41,'Chemistry Lab Co-op','Internship','<p><em>At Hasbro, we&rsquo;re changing the face of play and entertainment! We&rsquo;re looking for people who want to explore, experiment and innovate to come up with the best ideas. Our culture of Community, Passion, Integrity, Creativity and Inclusion h',NULL,'16',1,17,22,'Media And Arts',3,0),(42,'Inventor Relations/ Fun Lab Split Co-op','Internship','<p>We are looking for team members who are detail oriented, fearless collaborators, and hungry to gain experience and develop their talents. &nbsp;</p>\r\n<p>As the Inventor Relations and Fun Lab Co-Op, you will be embedded in two dynamic teams, working dir',NULL,'10',1,17,22,'Media And Arts',3,0),(43,'Group Global Co-op - Sydney, Australia','Co-op','<p><strong>Group&nbsp;Co-op Program in Sydney, Australia</strong>&nbsp;&nbsp;<br /><br />&nbsp;<br /><br /><strong>Program Description</strong><br /><br /><br /><br />Northeastern is offering,&nbsp;for the first time,&nbsp;a new exciting way of thinking a',NULL,'2',2,11,16,'Media And Arts',3,0),(44,'Interior Designer','Co-op','<p>The Interior Designer is the creative force that turns ideas into reality. You understand the architectural design process and how to integrate interior design concepts. You partner with clients and team members to develop and execute unique, creative ',NULL,'3',3,19,27,'Media And Arts',3,0),(45,'Design Engineer Co-op ','Internship','<p>Design Engineer Co-op</p>\r\n<p>Hasbro is currently recruiting enthusiastic, technically curious &amp; creative engineering students to assist Engineer Managers in the development of our products. You will learn how a toy is developed from initial concep',NULL,'9',1,17,22,'Media And Arts',3,0),(46,'Level 2 Customer Support Engineer','Co-op','<p><strong>PLEASE NOTE: This is not an entry-level role and requires at least 4 solid years of software product support, 2 of which must be at Level II, to be considered.</strong></p>\r\n<p>We are looking for an L2 Support Engineer to join our Customer Supp',NULL,'7',2,20,28,'Computer Science',3,0),(47,'Operations Intern','Full Time / Part Time','<p>Do you want to be part of a cutting-edge effort to use quantum mechanics to change the world?</p>\r\n<p><br />QSimulate is building a world-class team to accelerate scientific discovery. Our platform provides paradigm-shifting quantum-mechanics-based too',NULL,'18',1,4,29,'Computer Science',3,0),(48,'Staff Accountant','Full Time / Part Time','<p><strong>Staff Accountant &ndash; New Position! Open due to growth! Hybrid</strong><br />&nbsp;</p>\r\n<p><strong>Do you want to be part of a dynamic, growing organization? &nbsp;Are you looking for a work/life balance?&nbsp; Come work with us to help our',NULL,'8',1,21,30,'Computer Science',3,0),(49,'Sales Development Representative','Internship','<p>Zilla Security is seeking a Sales Development Representative (SDR) to help in identifying new sales opportunities for account executives to close.</p>\r\n<p>Zilla Security is looking for junior sales talent that wants to build a career. Our Sales Develop',NULL,'18',2,4,31,'Computer Science',3,0),(50,'Principal Product Engineer','Full Time / Part Time','<p><strong>About</strong></p>\r\n<p>Zeta Surgical is a digital surgery company focused on improving the accuracy, safety and accessibility of image guided surgery. Its navigation and robotics platform Zeta&nbsp;leverages cutting-edge computer vision and art',NULL,'10',3,4,32,'Computer Science',3,0),(51,'Software Engineer','Full Time / Part Time','<p><strong>About</strong></p>\r\n<p>Zeta Surgical is a digital surgery company focused on improving the accuracy, safety and accessibility of image guided surgery. Its navigation and robotics platform Zeta leverages cutting-edge computer vision and artifici',NULL,'14',2,4,32,'Computer Science',3,0),(52,'Systems Engineer','Full Time / Part Time','<p><strong>About</strong></p>\r\n<p>Zeta Surgical is a digital surgery company focused on improving the accuracy, safety and accessibility of image guided surgery. Its navigation and robotics platform Zeta&nbsp;leverages cutting-edge computer vision and art',NULL,'5',3,4,32,'Computer Science',3,0),(53,'Data Integration Co-op - Mandarin speaking a PLUS!','Full Time / Part Time','<p>Funnel, a well-funded startup in marketing tech, is searching for their next colleagues to join the Data Operations team and help customers solve their newest and often most complex data problems. If you\'re intrigued by the prospect of joining a rapidl',NULL,'8',1,4,33,'Computer Science',3,0);
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobstatus`
--

DROP TABLE IF EXISTS `jobstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobstatus` (
  `jobstatusid` int NOT NULL,
  `statusdesc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`jobstatusid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobstatus`
--

LOCK TABLES `jobstatus` WRITE;
/*!40000 ALTER TABLE `jobstatus` DISABLE KEYS */;
INSERT INTO `jobstatus` VALUES (1,'Unpublished'),(2,'Published'),(3,'Deactivated');
/*!40000 ALTER TABLE `jobstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `locationid` int NOT NULL AUTO_INCREMENT,
  `cityid` int NOT NULL,
  `stateid` varchar(2) NOT NULL,
  PRIMARY KEY (`locationid`),
  KEY `cityid_idx` (`cityid`),
  KEY `stateid_idx` (`stateid`),
  CONSTRAINT `cityid` FOREIGN KEY (`cityid`) REFERENCES `city` (`cityid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stateid` FOREIGN KEY (`stateid`) REFERENCES `state` (`stateid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (3,2,'MA'),(4,3,'MA'),(5,4,'MA'),(6,5,'ME'),(7,6,'MA'),(8,7,'NC'),(9,8,'MA'),(10,9,'NJ'),(11,10,'FL'),(12,11,'MA'),(13,12,'MA'),(14,13,'MA'),(15,14,'WA'),(16,15,'RI'),(17,16,'RI'),(18,17,'NY'),(19,18,'MA'),(20,19,'MA'),(21,20,'MA');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization` (
  `orgid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `size` varchar(45) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `website` varchar(45) DEFAULT NULL,
  `locationid` int DEFAULT NULL,
  PRIMARY KEY (`orgid`),
  KEY `fk_organizationlocationid_idx` (`locationid`),
  CONSTRAINT `fk_organizationlocationid` FOREIGN KEY (`locationid`) REFERENCES `location` (`locationid`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (3,'KevaHealth Inc','20','The idea for Keva Health formed when the founders daughter was diagnosed with asthma at the age of 3. They then realized that this was not just their daughter but millions of kids and adults who have asthma. With 25 years experience in healthcare, the founders worked with a team of professionals and launched an app that helps the patient and a platform that helps physicians to remotely manage their patients.','https://www.kevahealth.com/',3),(4,'Activ Surgical','20','Activ Surgical is a pioneering digital surgery imaging startup that is developing groundbreaking intraoperative surgical intelligence hardware and software. Having completed the world’s first autonomous robotic surgery of soft tissue in 2018, the company is focused on enhanced, real-time visualization capabilities for surgeons that combine advanced augmented reality (AR), artificial intelligence (AI), and machine learning (ML) technology.','https://www.activsurgical.com/',4),(5,'Brigham and Women\'s Hospital','1000',NULL,NULL,5),(6,'Cambridge Health Alliance','500',NULL,NULL,5),(7,'Power of Patients','500',NULL,NULL,6),(8,'Arbour HRI Hospital','20',NULL,NULL,7),(9,'Lighthouse Lab Services','100',NULL,NULL,8),(10,'The Massachusetts Eye and Ear Infirmary','50',NULL,NULL,4),(11,'Beth Israel Deaconess Healthcare','500',NULL,NULL,9),(12,'Johnson & Johnson','50',NULL,'https://www.jnj.com/',10),(13,'South End Community Health Center, Inc. (East Boston Community Health Center)','100',NULL,NULL,4),(14,'Massachusetts General Hospital, Department of Pharmacy','20',NULL,NULL,4),(15,'Boston Children\'s Hospital','20',NULL,NULL,4),(16,'Internships Down Under ','100',NULL,NULL,11),(17,'Meaden & Moore, LLP','100',NULL,NULL,4),(18,'E.J. Callahan & Associates','50',NULL,NULL,12),(19,'Grassi & Co.','100',NULL,NULL,13),(20,'Monotype','20',NULL,NULL,14),(21,'Apple','1000',NULL,NULL,15),(22,'Hasbro, Inc.','100',NULL,'https://www.hasbrogameplan.com/',16),(23,'IFactory Inc.','1000',NULL,NULL,4),(24,'Adapt Agency','50',NULL,NULL,6),(25,'Greene Naftali','100',NULL,NULL,18),(26,'Playa Society','20',NULL,NULL,4),(27,'Interiology Design Co.','100',NULL,NULL,19),(28,'Earnix','20',NULL,NULL,20),(29,'QSimulate','1000',NULL,NULL,4),(30,' Powerhouse Dynamics (PhD)','500',NULL,NULL,21),(31,'Zilla Security','500',NULL,NULL,4),(32,'Zeta Surgical','500',NULL,NULL,4),(33,'Funnel.io','500',NULL,NULL,4);
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `roleid` int NOT NULL AUTO_INCREMENT,
  `rolename` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Applicant'),(2,'Recruiter');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state` (
  `stateid` varchar(2) NOT NULL,
  `statename` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`stateid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES ('AK','Alaska'),('AL','Alabama'),('AR','Arkansas'),('AZ','Arizona'),('CA','California'),('CO','Colorado'),('CT','Connecticut'),('DC','District of Columbia'),('DE','Delaware'),('FL','Florida'),('GA','Georgia'),('HI','Hawaii'),('IA','Iowa'),('ID','Idaho'),('IL','Illinois'),('IN','Indiana'),('KS','Kansas'),('KY','Kentucky'),('LA','Louisiana'),('MA','Massachusetts'),('MD','Maryland'),('ME','Maine'),('MI','Michigan'),('MN','Minnesota'),('MO','Missouri'),('MS','Mississippi'),('MT','Montana'),('NC','North Carolina'),('ND','North Dakota'),('NE','Nebraska'),('NH','New Hampshire'),('NJ','New Jersey'),('NM','New Mexico'),('NV','Nevada'),('NY','New York'),('OH','Ohio'),('OK','Oklahoma'),('OR','Oregon'),('PA','Pennsylvania'),('PR','Puerto Rico'),('RI','Rhode Island'),('SC','South Carolina'),('SD','South Dakota'),('TN','Tennessee'),('TX','Texas'),('UT','Utah'),('VA','Virginia'),('VT','Vermont'),('WA','Washington'),('WI','Wisconsin'),('WV','West Virginia'),('WY','Wyoming');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `bio` varchar(45) DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  KEY `fk_roleid_idx` (`role_id`),
  CONSTRAINT `fk_roleid` FOREIGN KEY (`role_id`) REFERENCES `role` (`roleid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (5,'a1be2ca@gmail.com','aa2ebc','xa2ye','2abcad22123','bio1',1),(3,'ab2ca@gmail.com','aa2bc','xa2y','2abcad22123','bio1',2),(1,'abca@gmail.com','aabc','xay','abcad2123','bio1',2),(4,'abe2ca@gmail.com','aa2ebc','xa2ye','2abcad22123','bio1',2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'roydon4'
--
/*!50003 DROP PROCEDURE IF EXISTS `check_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_user`(IN username VARCHAR(255), IN pass VARCHAR(255))
BEGIN
SELECT first_name, role_id, email FROM user where email like username and password like pass;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_published_jobs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_published_jobs`()
BEGIN
	SELECT 
    j.jobid,
    j.position,
    j.description,
    j.publishdate,
    j.vacancy_count,
    j.category,
    c.cityname,
    s.statename,
    o.name
FROM
    job j
        INNER JOIN
    organization o ON j.organizationid = o.orgid
        LEFT OUTER JOIN
    location l ON j.locationid = l.locationid
        INNER JOIN
    state s ON l.stateid = s.stateid
        INNER JOIN
    city c ON l.cityid = c.cityid
        INNER JOIN
    jobstatus js ON j.status = js.jobstatusid
WHERE
    LOWER(js.statusdesc) = 'published';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-27 20:35:19
