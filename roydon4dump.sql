CREATE DATABASE  IF NOT EXISTS `roydon7` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `roydon7`;
-- MySQL dump 10.13  Distrib 8.0.28, for macos11 (x86_64)
--
-- Host: localhost    Database: roydon7
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
  `appstatusid` int DEFAULT '1',
  `jobid` int DEFAULT NULL,
  `userid` int DEFAULT NULL,
  `submitdate` datetime DEFAULT NULL,
  PRIMARY KEY (`applicationid`),
  UNIQUE KEY `uk_userjobid` (`jobid`,`userid`),
  KEY `fk_applicationjobid_idx` (`jobid`),
  KEY `fk_applicationuserid_idx` (`userid`),
  KEY `fk_appstatusid_idx` (`appstatusid`),
  CONSTRAINT `fk_applicationjobid_idx` FOREIGN KEY (`jobid`) REFERENCES `job` (`jobid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_applicationuserid_idx` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_appstatusid_idx` FOREIGN KEY (`appstatusid`) REFERENCES `job_app_status` (`statusid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application` VALUES (1,'Java, Python, SQL','MSCS(Northeastern University)','SDE1-11 months-IBM, SDE Intern-3 months-AWS',1,2,5,NULL),(2,'Java, Python, SQL','MSCS(Northeastern University)','SDE1-11 months-IBM, SDE Intern-3 months-AWS',1,3,5,NULL),(3,'Java, Python, SQL','MSCS(Northeastern University)','SDE1-11 months-IBM, SDE Intern-3 months-AWS',2,4,5,'2022-04-29 02:29:08'),(5,'Tissue Culture, RTPCR, MassSpectrometry','MSBiotech(Northeastern University)',NULL,2,5,3,'2022-04-28 03:40:09'),(6,'Tissue Culture, RTPCR, MassSpectrometry','MSBiotech(Northeastern University)',NULL,2,2,3,'2022-04-28 03:40:09'),(7,'Pharmacy, Chemistry','MSBiotech(Northeastern University)',NULL,2,5,9,'2022-04-28 02:29:08'),(8,'Pharmacy, Chemistry','MSBiotech(Northeastern University)',NULL,1,2,9,NULL),(9,'Java, Python, SQL','MSCS(Northeastern University)',NULL,1,3,6,NULL),(11,'Java, Python, SQL','MSCS(Northeastern University)',NULL,1,4,6,NULL);
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_applicant_count_insert` AFTER INSERT ON `application` FOR EACH ROW BEGIN 
    call update_applicant_count(new.jobid);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_applicant_count_update` AFTER UPDATE ON `application` FOR EACH ROW BEGIN 
    call update_applicant_count(old.jobid);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_applicant_count_delete` AFTER DELETE ON `application` FOR EACH ROW BEGIN 
    call update_applicant_count(old.jobid);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_document_on_jobdelete` AFTER DELETE ON `application` FOR EACH ROW BEGIN 
    delete from document where applicationid= old.applicationid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
  CONSTRAINT `fk_citystateid` FOREIGN KEY (`stateid`) REFERENCES `state` (`stateid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Lowell','MA'),(2,'Lexington','MA'),(3,'Boston','MA'),(4,'Cambridge','MA'),(5,'Portland','ME'),(6,'Brookline','MA'),(7,'Charlotte','NC'),(8,'Newton Center','MA'),(9,'Raritan','NJ'),(10,'Sydney','FL'),(11,'Wakefield','MA'),(12,'Needham','MA'),(13,'Woburn','MA'),(14,'Vancouver','WA'),(15,'Providence','RI'),(16,'Pawtucket','RI'),(17,'New York','NY'),(18,'Watertown','MA'),(19,'Waltham','MA'),(20,'Newton','MA');
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
  CONSTRAINT `fk_documentapplicationid` FOREIGN KEY (`applicationid`) REFERENCES `application` (`applicationid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
INSERT INTO `document` VALUES (1,'CV','http://cv1.com',3),(2,'Cover Letter','http://cl1.com',3),(3,'CV','http://cv2.com',2),(4,'CV','http://cv3.com',1),(5,'Resume','http://r1.com',5),(6,'Transcripts','http://tr1.com',6),(7,'cv','cv.com',9),(14,'cv','cv.com',11),(15,'coverletter','coverl.com',11),(16,'transcript','trscipt.net',11);
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
  `jobstatusid` int DEFAULT '1',
  `vacancycount` int DEFAULT NULL,
  `orgid` int DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `userid` int DEFAULT NULL,
  `applicantcount` int DEFAULT '0',
  PRIMARY KEY (`jobid`),
  KEY `fk_joborgid_idx` (`orgid`),
  KEY `fk_jobuserid_idx` (`userid`),
  KEY `fk_jobstatusid_idx` (`jobstatusid`),
  CONSTRAINT `fk_joborgid_idx` FOREIGN KEY (`orgid`) REFERENCES `organization` (`orgid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_jobstatusid_idx` FOREIGN KEY (`jobstatusid`) REFERENCES `job_app_status` (`statusid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_jobuserid` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES (1,'Project Management','Part-Time','This is part time work for 4-5 hours daily at KEVAHEALTH Inc','2022-04-28 02:29:08',2,2,3,'Healthcare',2,0),(2,'Project Management Intern','Internship','<p>This is an unpaid Internship at KEVAHEALTH Inc as a Project Management Intern for 40 hours per week. In this position, you will report directly to Jyotsna Mehta beginning May 9, 2022.</p>\r\n<p>This is in accordance with the Fair Labor Standards Act ref.','2022-04-28 02:29:08',2,2,3,'Healthcare',2,1),(3,'Software Developer Intern','Internship','<p>This is an paid Internship at KEVAHEALTH Inc as a SDE Intern for 40 hours per week. In this position, you will report directly to Richard Smith beginning May 9, 2022.</p>\r\n<p>This is in accordance with the Fair Labor Standards Act ref.','2022-04-28 02:29:08',2,3,3,'IT',2,0),(4,'Software Engineer Co-op','Full Time / Part Time','<p>ABOUT ACTIV</p>\r\n<p>Founded in 2017, Activ Surgical is a first-of-its kind digital surgery company focused on improving surgical efficiency, accuracy, patient outcomes and accessibility for both endoscopic and robotically assisted procedures','2022-04-28 02:29:08',2,5,4,'Software',1,1),(5,'Biotech Co-op','Full Time / Part Time','<p>ABOUT ACTIV</p>\r\n<p>Founded in 2017, Activ Surgical is a first-of-its kind digital surgery company focused on improving surgical efficiency, accuracy, patient outcomes and accessibility for both endoscopic and robotically assisted procedures','2022-04-28 02:29:08',2,2,4,'Healthcare',1,2),(6,'Biotech Internship','Internship','<p>ABOUT ACTIV</p>\r\n<p>Founded in 2017, Activ Surgical is a first-of-its kind digital surgery company focused on improving surgical efficiency, accuracy, patient outcomes and accessibility for both endoscopic and robotically assisted procedures',NULL,1,2,4,'Healthcare',1,0),(7,'IT Developer Intern','Internship','<p>Internship for 3 months</p>',NULL,1,25,21,'IT',1,0);
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_joblocation_on_jobdelete` AFTER DELETE ON `job` FOR EACH ROW BEGIN 
    delete from joblocation where jobid= old.jobid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `job_app_status`
--

DROP TABLE IF EXISTS `job_app_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_app_status` (
  `statusid` int NOT NULL,
  `statusdesc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`statusid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_app_status`
--

LOCK TABLES `job_app_status` WRITE;
/*!40000 ALTER TABLE `job_app_status` DISABLE KEYS */;
INSERT INTO `job_app_status` VALUES (1,'Saved'),(2,'Submitted');
/*!40000 ALTER TABLE `job_app_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `joblocation`
--

DROP TABLE IF EXISTS `joblocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `joblocation` (
  `joblocationid` int NOT NULL AUTO_INCREMENT,
  `cityid` int DEFAULT NULL,
  `jobid` int DEFAULT NULL,
  PRIMARY KEY (`joblocationid`),
  UNIQUE KEY `uk_jobcityid` (`cityid`,`jobid`),
  KEY `fk_jobid_idx` (`jobid`),
  KEY `fk_jobcityid_idx` (`cityid`),
  CONSTRAINT `fk_jobcityid_idx` FOREIGN KEY (`cityid`) REFERENCES `city` (`cityid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_jobid_idx` FOREIGN KEY (`jobid`) REFERENCES `job` (`jobid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `joblocation`
--

LOCK TABLES `joblocation` WRITE;
/*!40000 ALTER TABLE `joblocation` DISABLE KEYS */;
INSERT INTO `joblocation` VALUES (1,1,1),(2,2,1),(3,3,1),(5,3,3),(11,3,7),(4,4,2),(6,4,3),(7,13,4),(8,18,4),(9,18,5),(10,18,6);
/*!40000 ALTER TABLE `joblocation` ENABLE KEYS */;
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
  PRIMARY KEY (`orgid`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (2,'KForce Recruitment','20-30','Recruiting for all companies','https://www.kforce.com/'),(3,'KevaHealth Inc','20-40','The idea for Keva Health formed when the founders daughter was diagnosed with asthma at the age of 3. They then realized that this was not just their daughter but millions of kids and adults who have asthma. With 25 years experience in healthcare, the founders worked with a team of professionals and launched an app that helps the patient and a platform that helps physicians to remotely manage their patients.','https://www.kevahealth.com/'),(4,'Activ Surgical','20','Activ Surgical is a pioneering digital surgery imaging startup that is developing groundbreaking intraoperative surgical intelligence hardware and software. Having completed the world’s first autonomous robotic surgery of soft tissue in 2018, the company is focused on enhanced, real-time visualization capabilities for surgeons that combine advanced augmented reality (AR), artificial intelligence (AI), and machine learning (ML) technology.','https://www.activsurgical.com/'),(5,'Brigham and Women\'s Hospital','1000-1500',NULL,NULL),(6,'Cambridge Health Alliance','500',NULL,NULL),(7,'Power of Patients','500',NULL,NULL),(8,'Arbour HRI Hospital','20',NULL,NULL),(9,'Lighthouse Lab Services','100',NULL,NULL),(10,'The Massachusetts Eye and Ear Infirmary','50',NULL,NULL),(11,'Beth Israel Deaconess Healthcare','500',NULL,NULL),(12,'Johnson & Johnson','50',NULL,'https://www.jnj.com/'),(13,'South End Community Health Center, Inc. (East Boston Community Health Center)','100',NULL,NULL),(14,'Massachusetts General Hospital, Department of Pharmacy','20',NULL,NULL),(15,'Boston Children\'s Hospital','20',NULL,NULL),(16,'Internships Down Under ','100',NULL,NULL),(17,'Meaden & Moore, LLP','100',NULL,NULL),(18,'E.J. Callahan & Associates','50',NULL,NULL),(19,'Grassi & Co.','100',NULL,NULL),(20,'Monotype','20',NULL,NULL),(21,'Apple','1000',NULL,NULL),(22,'Hasbro, Inc.','100',NULL,'https://www.hasbrogameplan.com/'),(23,'IFactory Inc.','1000',NULL,NULL),(24,'Adapt Agency','50',NULL,NULL),(25,'Greene Naftali','100',NULL,NULL),(26,'Playa Society','20',NULL,NULL),(27,'Interiology Design Co.','100',NULL,NULL),(28,'Earnix','20',NULL,NULL),(29,'QSimulate','1000',NULL,NULL),(30,' Powerhouse Dynamics (PhD)','500',NULL,NULL),(31,'Zilla Security','500',NULL,NULL),(32,'Zeta Surgical','500',NULL,NULL),(33,'Funnel.io','500',NULL,NULL);
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orglocation`
--

DROP TABLE IF EXISTS `orglocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orglocation` (
  `orglocationid` int NOT NULL AUTO_INCREMENT,
  `cityid` int DEFAULT NULL,
  `orgid` int DEFAULT NULL,
  PRIMARY KEY (`orglocationid`),
  UNIQUE KEY `uk_orgcityid` (`cityid`,`orgid`),
  KEY `fk_orgid_idx` (`orgid`),
  KEY `fk_orgcityid_idx` (`cityid`),
  CONSTRAINT `fk_orgcityid_idx` FOREIGN KEY (`cityid`) REFERENCES `city` (`cityid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orgid_idx` FOREIGN KEY (`orgid`) REFERENCES `organization` (`orgid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orglocation`
--

LOCK TABLES `orglocation` WRITE;
/*!40000 ALTER TABLE `orglocation` DISABLE KEYS */;
INSERT INTO `orglocation` VALUES (1,1,3),(2,2,3),(7,3,2),(3,3,3),(8,4,2),(4,4,3),(5,13,3),(9,13,4),(6,18,3),(10,18,4);
/*!40000 ALTER TABLE `orglocation` ENABLE KEYS */;
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
  `userid` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `firstname` varchar(45) DEFAULT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `bio` varchar(45) DEFAULT NULL,
  `roleid` int DEFAULT NULL,
  `orgid` int DEFAULT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `user_id_UNIQUE` (`userid`),
  KEY `fk_roleid_idx` (`roleid`),
  KEY `fk_userorgid_idx` (`orgid`),
  CONSTRAINT `fk_roleid` FOREIGN KEY (`roleid`) REFERENCES `role` (`roleid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_userorgid` FOREIGN KEY (`orgid`) REFERENCES `organization` (`orgid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (4,'bs@gmail.com','Bree','Snider','abc12345','test bio 2',1,NULL),(2,'ck@kforce.com','Callum','Mckenzie','abc12345','Recruiting for kforce affiliated companies',2,2),(5,'dr@gmail.com','Derek','Ruiz','abc12345','test bio 3',1,NULL),(9,'hs@gmail.com','Hayleigh','Stuart','abc12345','test bio 7',1,NULL),(1,'kh@kforce.com','Kirstie','Hibbert','abc12345','Recruiting for kforce affiliated companies',2,2),(10,'km@gmail.com','Karol','Mcnamara','abc12345','test bio 8',1,NULL),(8,'mb@gmail.com','Morgan','Burton','abc12345','test bio 6',1,NULL),(3,'mc@gmail.com','Macie','Chen','abc12345','test bio 1',1,NULL),(6,'nl@gmail.com','Nimra','Lowe','abc12345','test bio 4',1,NULL),(7,'tk@gmail.com','Tiya','Knights','abc12345','test bio 5',1,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'roydon7'
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
SELECT userid, CONCAT(lastname,',',firstname) as name, roleid, email 
FROM user where email like username and password like pass;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_new_application` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_application`(IN pinuserid int, IN pvarskills varchar(45), 
IN pvareducation varchar(45), IN pvarexperience varchar(45), IN pinstatus int, IN pinjobid int, 
IN pvardocname varchar(200), IN pvardocurl varchar(200), OUT result INT)
BEGIN
	DECLARE varappid int;
    DECLARE front1,front2 TEXT DEFAULT NULL;
	DECLARE frontlen1,frontlen2 INT DEFAULT NULL;
	DECLARE vardocname,vardocurl TEXT DEFAULT NULL;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    
    INSERT INTO application (skills, education, experience, appstatusid, jobid, userid, submitdate)
	VALUES (pvarskills, pvareducation, pvarexperience, pinstatus, pinjobid, pinuserid, IF(pinstatus=2, now(), null));
    
    SELECT LAST_INSERT_ID() INTO varappid; 
  
    IF result = 0 THEN
		iterator:
		LOOP  
			IF LENGTH(TRIM(pvardocname)) = 0 OR pvardocname IS NULL THEN
				LEAVE iterator;
			END IF;
            
			SET front1 = SUBSTRING_INDEX(pvardocname,',',1);
            SET front2 = SUBSTRING_INDEX(pvardocurl,',',1);
			
            SET frontlen1 = LENGTH(front1);
            SET frontlen2 = LENGTH(front2);
			
            SET vardocname = TRIM(front1);
            SET vardocurl = TRIM(front2);
			
            INSERT INTO document (docname, docurl, applicationid) VALUES (vardocname, vardocurl, varappid);
			
            SET pvardocname = INSERT(pvardocname,1,frontlen1 + 1,'');
            SET pvardocurl = INSERT(pvardocurl,1,frontlen2 + 1,'');
		END LOOP;
        
    END IF;
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_new_jobpost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_jobpost`(IN pvarposition varchar(255),IN pvartype varchar(45),IN pvardescription longtext,
IN pinjobstatusid int, IN pinvacancycount int, IN pinorgid int, IN pvarcategory varchar(45), IN pinuserid int,
IN pvarstate varchar(200), IN pvarcity varchar(200), OUT result INT)
BEGIN
	-- DECLARE errno varchar(500);
	DECLARE varjobid, varcityexists, varcityid, varorgid int;
    DECLARE front1,front2 TEXT DEFAULT NULL;
	DECLARE frontlen1,frontlen2 INT DEFAULT NULL;
	DECLARE varcityname,varstatename TEXT DEFAULT NULL;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		-- GET CURRENT DIAGNOSTICS CONDITION 1 errno = MESSAGE_TEXT;
		-- SELECT errno AS MYSQL_ERROR;
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    
    IF pinorgid = 0 THEN
		SELECT orgid INTO varorgid from user WHERE userid = pinuserid;
	ELSE 
		SET varorgid = pinorgid;
    END IF;
    
	INSERT INTO job (position, type, description, publishdate, jobstatusid, vacancycount, orgid, category, userid)
	VALUES (pvarposition, pvartype, pvardescription, IF(pinjobstatusid=2, now(), null), pinjobstatusid, pinvacancycount, varorgid, pvarcategory, pinuserid);
    
    SELECT LAST_INSERT_ID() INTO varjobid; 
  
    IF result = 0 THEN
		iterator:
		LOOP  
			IF LENGTH(TRIM(pvarcity)) = 0 OR pvarcity IS NULL THEN
				LEAVE iterator;
			END IF;
            
			SET front1 = SUBSTRING_INDEX(pvarcity,',',1);
            SET front2 = SUBSTRING_INDEX(pvarstate,',',1);
			
            SET frontlen1 = LENGTH(front1);
            SET frontlen2 = LENGTH(front2);
			
            SET varcityname = TRIM(front1);
            SET varstatename = TRIM(front2);
            
            SELECT count(*) into varcityexists FROM city where lower(cityname)=lower(varcityname);
            IF varcityexists=1 THEN
				SELECT cityid into varcityid FROM city where lower(cityname)=lower(varcityname);
                INSERT INTO `joblocation`(cityid, jobid) VALUES (varcityid, varjobid);
			ELSEIF varcityexists > 1 THEN
				SELECT cityid into varcityid FROM city where lower(cityname)=lower(varcityname)
                AND lower(statename)=lower(varstatename);
                INSERT INTO `joblocation`(cityid, jobid) VALUES (varcityid, varjobid);
            END IF;
            
            SET pvarcity = INSERT(pvarcity,1,frontlen1 + 1,'');
            SET pvarstate = INSERT(pvarstate,1,frontlen2 + 1,'');
		END LOOP;
    END IF;
    
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_application` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_application`(IN appid int ,OUT result INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    DELETE from document where applicationid=appid;
    DELETE from application where applicationid=appid;
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_job` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_job`(IN pinjobid int ,OUT result INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    DELETE from application where jobid = pinjobid;
    DELETE from job where jobid=pinjobid;
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_applicant_applications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_applicant_applications`(IN pinuserid int)
BEGIN
SELECT 
    a.applicationid,
    s.statusdesc,
    a.submitdate,
    a.skills,
    a.education,
    a.experience,
    o.name,
    j.position,
    j.type,
    j.description
FROM
    application a
        INNER JOIN
    job j ON a.jobid = j.jobid
        INNER JOIN
    organization o ON j.orgid = o.orgid
		INNER JOIN
    job_app_status s ON a.appstatusid = s.statusid
WHERE
    a.userid = pinuserid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_job_applications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_job_applications`(IN pinjobid int)
BEGIN
SELECT 
    a.applicationid,
    u.firstname,
    u.lastname,
    u.email,
    u.bio,
    a.skills,
    a.education,
    a.experience,
    a.submitdate
FROM
    application a
        INNER JOIN
    user u ON a.userid = u.userid
WHERE
    a.jobid = pinjobid AND a.appstatusid = 2;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_published_jobs`(IN pvarposition varchar(255), IN pincityid int, IN ordering varchar(10))
BEGIN
DECLARE varcityname varchar(100);
SET @varposition = pvarposition;
SET @selectstart = 'SELECT 
    *
FROM
    (SELECT 
        j.jobid,
            o.name,
            j.position,
            j.type,
            j.description,
            j.publishdate,
            j.vacancycount,
            j.category,
            GROUP_CONCAT(CONCAT(c.cityname, ''-'', s.statename)) AS location
    FROM
        job j
    INNER JOIN organization o ON j.orgid = o.orgid
    INNER JOIN job_app_status js ON j.jobstatusid = js.statusid
    LEFT OUTER JOIN joblocation jl ON j.jobid = jl.jobid
    INNER JOIN city c ON jl.cityid = c.cityid
    INNER JOIN state s ON c.stateid = s.stateid
    WHERE
        LOWER(js.statusid) = 2';
    
IF pvarposition IS NOT NULL THEN
	SET @positionfilter = " AND lower(position) LIKE lower(CONCAT( '%',?,'%'))";
ELSE 
	SET @positionfilter = ' ';
END IF;

SET @grouping = ' GROUP BY j.jobid';

IF lower(ordering) = 'asc' THEN 
	SET @sortorder= ' ORDER BY j.publishdate ASC';
ELSE
	SET @sortorder= ' ORDER BY j.publishdate DESC';
END IF;

SET @selectmiddle = ' ) pub_jobs';

IF pincityid <> 0 THEN
	SELECT cityname INTO varcityname FROM city where cityid = pincityid;
    SET @varcity = varcityname;
    SET @cityfilter = " WHERE lower(pub_jobs.location) LIKE lower(CONCAT( '%',?,'%'))";
ELSE 
	SET @cityfilter = ' ';
END IF;

SET @selectend = ';';

SET @s = CONCAT (@selectstart, @positionfilter, @grouping, @sortorder, @selectmiddle, @cityfilter, @selectend); 
SELECT @s;
PREPARE stmt FROM @s;
IF pvarposition IS NOT NULL AND pincityid <> 0 THEN
	EXECUTE stmt USING @varposition, @varcity;
ELSEIF pvarposition IS NOT NULL AND pincityid = 0 THEN
	EXECUTE stmt USING @varposition;
ELSEIF pvarposition IS NULL AND pincityid <> 0 THEN
	EXECUTE stmt USING @varcity;
ELSE 
	EXECUTE stmt;
END IF;
DEALLOCATE PREPARE stmt;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_usercreated_jobs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_usercreated_jobs`(IN pinuserid int, IN pinjobstatusid int, IN ordering varchar(10))
BEGIN
SET @inputuserid = pinuserid;
SET @jobstatus = pinjobstatusid;
SET @selectstmt = 'SELECT 
    j.jobid,
    o.name,
    j.position,
    j.type,
    j.description,
    js.statusdesc,
    j.publishdate,
    j.vacancycount,
    j.applicantcount,
    j.category,
    GROUP_CONCAT(CONCAT(c.cityname, ''-'', s.statename)) AS location
FROM
	job j
        INNER JOIN
    organization o ON j.orgid = o.orgid
        INNER JOIN
    job_app_status js ON j.jobstatusid = js.statusid
        LEFT OUTER JOIN
    joblocation jl ON j.jobid = jl.jobid
        INNER JOIN
    city c ON jl.cityid = c.cityid
        INNER JOIN
    state s ON c.stateid = s.stateid
WHERE
    j.userid= ?';
    
IF pinjobstatusid = 0 THEN
	SET @filter = ' ';
ELSE 
	SET @filter = ' AND j.jobstatusid = ?';
END IF;

SET @grouping = ' GROUP BY j.jobid';

IF lower(ordering) = 'asc' AND pinjobstatusid = 2 THEN 
	SET @sortorder= ' ORDER BY j.publishdate asc;';
ELSEIF lower(ordering) = 'desc' AND pinjobstatusid = 2 THEN
	SET @sortorder= ' ORDER BY j.publishdate desc;';
ELSE
	SET @sortorder= ' ORDER BY j.jobid desc;';
END IF;
SET @s = CONCAT (@selectstmt, @filter, @grouping, @sortorder); 
SELECT @s;
PREPARE stmt FROM @s;
IF pinjobstatusid = 0 THEN
	EXECUTE stmt USING @inputuserid;
ELSE
	EXECUTE stmt USING @inputuserid, @jobstatus;
END IF;
DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_application_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_application_data`(IN appid int)
BEGIN
SELECT 
    a.applicationid,
    a.skills,
    a.education,
    a.experience,
    o.name,
    j.position,
    j.type,
    j.description,
    s.statusdesc,
    a.submitdate,
    GROUP_CONCAT(CONCAT(d.docname)) AS docname,
    GROUP_CONCAT(CONCAT(d.docurl)) AS docurl
FROM
    application a
        INNER JOIN
    job j ON a.jobid = j.jobid
        INNER JOIN
    organization o ON j.orgid = o.orgid
		INNER JOIN
    job_app_status s ON a.appstatusid = s.statusid
        LEFT OUTER JOIN
    document d ON a.applicationid = d.applicationid
WHERE
    a.applicationid = appid
GROUP BY a.applicationid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_job_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_job_data`(IN pinjobid int)
BEGIN
SELECT 
    j.jobid,
    o.name,
    j.position,
    j.type,
    j.description,
    js.statusdesc,
    j.publishdate,
    j.vacancycount,
    j.applicantcount,
    j.category,
    GROUP_CONCAT(CONCAT(c.cityname, '-', s.statename)) AS location
FROM
    job j
        INNER JOIN
    organization o ON j.orgid = o.orgid
        INNER JOIN
    job_app_status js ON j.jobstatusid = js.statusid
        LEFT OUTER JOIN
    joblocation jl ON j.jobid = jl.jobid
        INNER JOIN
    city c ON jl.cityid = c.cityid
        INNER JOIN
    state s ON c.stateid = s.stateid
WHERE
    j.jobid = pinjobid
GROUP BY j.jobid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_applicant_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_applicant_count`(IN job_id INT)
BEGIN
    UPDATE job 
	SET applicantcount = (SELECT COUNT(*) FROM application
							WHERE jobid = job_id
							AND appstatusid = 2)
	WHERE jobid = job_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_jobpost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_jobpost`(IN pinjobid int, IN pvarposition varchar(255),IN pvartype varchar(45),
IN pvardescription longtext, IN pinjobstatusid int, IN pinvacancycount int, IN pinorgid int, 
IN pvarcategory varchar(45), IN pvarstate varchar(200), IN pvarcity varchar(200), OUT result INT)
BEGIN
	-- DECLARE errno varchar(500);
	DECLARE varjobid, varcityexists, varcityid, varorgid int;
    DECLARE front1,front2 TEXT DEFAULT NULL;
	DECLARE frontlen1,frontlen2 INT DEFAULT NULL;
	DECLARE varcityname,varstatename TEXT DEFAULT NULL;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		-- GET CURRENT DIAGNOSTICS CONDITION 1 errno = MESSAGE_TEXT;
		-- SELECT errno AS MYSQL_ERROR;
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    
    IF pinorgid = 0 THEN
		SELECT orgid INTO varorgid from job WHERE jobid=pinjobid;
	ELSE
		SET varorgid = pinorgid;
    END IF;
    
    UPDATE job SET 
    position=pvarposition, 
    type=pvartype, 
    description=pvardescription, 
    publishdate=IF(pinjobstatusid=2, now(), null), 
    jobstatusid=pinjobstatusid, 
    vacancycount=pinvacancycount, 
    orgid=varorgid, 
    category=pvarcategory
	where jobid=pinjobid;
    
    IF result = 0 THEN
		DELETE from joblocation where jobid=pinjobid;
		iterator:
		LOOP  
			IF LENGTH(TRIM(pvarcity)) = 0 OR pvarcity IS NULL THEN
				LEAVE iterator;
			END IF;
            
			SET front1 = SUBSTRING_INDEX(pvarcity,',',1);
            SET front2 = SUBSTRING_INDEX(pvarstate,',',1);
			
            SET frontlen1 = LENGTH(front1);
            SET frontlen2 = LENGTH(front2);
			
            SET varcityname = TRIM(front1);
            SET varstatename = TRIM(front2);
            
            SELECT count(*) into varcityexists FROM city where lower(cityname)=lower(varcityname);
            IF varcityexists=1 THEN
				SELECT cityid into varcityid FROM city where lower(cityname)=lower(varcityname);
                INSERT INTO `joblocation`(cityid, jobid) VALUES (varcityid, pinjobid);
			ELSEIF varcityexists > 1 THEN
				SELECT cityid into varcityid FROM city where lower(cityname)=lower(varcityname)
                AND lower(statename)=lower(varstatename);
                INSERT INTO `joblocation`(cityid, jobid) VALUES (varcityid, pinjobid);
            END IF;
            
            SET pvarcity = INSERT(pvarcity,1,frontlen1 + 1,'');
            SET pvarstate = INSERT(pvarstate,1,frontlen2 + 1,'');
		END LOOP;
    END IF;
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_saved_application` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_saved_application`(IN appid int, IN pvarskills varchar(45), IN pvareducation varchar(45),
IN pvarexperience varchar(45), IN pinstatus int, IN pvardocname varchar(200), IN pvardocurl varchar(200),
OUT result INT)
BEGIN
	DECLARE errno varchar(500);
    DECLARE front1,front2 TEXT DEFAULT NULL;
	DECLARE frontlen1,frontlen2 INT DEFAULT NULL;
	DECLARE vardocname,vardocurl TEXT DEFAULT NULL;
	DECLARE appid_var INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		GET CURRENT DIAGNOSTICS CONDITION 1 errno = MESSAGE_TEXT;
		SELECT errno AS MYSQL_ERROR;
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    
    UPDATE application SET 
    skills = pvarskills, 
    education= pvareducation,
	experience= pvarexperience, 
    appstatusid= pinstatus, 
    submitdate=IF(pinstatus=2, now(), null)
	where applicationid=appid;
  
    IF result = 0 THEN	
		DELETE from document where applicationid=appid;
        iterator:
		LOOP  
			IF LENGTH(TRIM(pvardocname)) = 0 OR pvardocname IS NULL THEN
				LEAVE iterator;
			END IF;
            
			SET front1 = SUBSTRING_INDEX(pvardocname,',',1);
            SET front2 = SUBSTRING_INDEX(pvardocurl,',',1);
			
            SET frontlen1 = LENGTH(front1);
            SET frontlen2 = LENGTH(front2);
			
            SET vardocname = TRIM(front1);
            SET vardocurl = TRIM(front2);
			
            INSERT INTO document (docname, docurl, applicationid) VALUES (vardocname, vardocurl, appid);
			
            SET pvardocname = INSERT(pvardocname,1,frontlen1 + 1,'');
            SET pvardocurl = INSERT(pvardocurl,1,frontlen2 + 1,'');
		END LOOP;
    END IF;
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
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

-- Dump completed on 2022-04-30 19:59:22
