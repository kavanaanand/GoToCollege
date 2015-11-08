-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: localhost    Database: gotocollege
-- ------------------------------------------------------
-- Server version	5.7.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `university_details`
--

DROP TABLE IF EXISTS `university_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `university_details` (
  `univ_id` int(10) unsigned NOT NULL,
  `univ_name` varchar(100) NOT NULL,
  `department_name` varchar(45) NOT NULL,
  `major` varchar(45) NOT NULL,
  `degree_level` varchar(45) NOT NULL,
  `tution_fees` double NOT NULL,
  `living_expenses` double NOT NULL,
  `minimum_scholarship` double DEFAULT NULL,
  `location` varchar(45) NOT NULL,
  PRIMARY KEY (`univ_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university_details`
--

LOCK TABLES `university_details` WRITE;
/*!40000 ALTER TABLE `university_details` DISABLE KEYS */;
INSERT INTO `university_details` VALUES (1,'Stony Brook','Computer Science','Computer Science','Masters',13000,10000,9000,'NY'),(2,'NC State','Computer Science','Computer Science','Masters',20000,8000,4000,'NC'),(3,'University of Florida','Computer Science','Computer Science','Masters',20900,5000,7000,'FL');
/*!40000 ALTER TABLE `university_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userprofile`
--

DROP TABLE IF EXISTS `userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userprofile` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `income` double NOT NULL,
  `savings` double NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uid_UNIQUE` (`uid`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userprofile`
--

LOCK TABLES `userprofile` WRITE;
/*!40000 ALTER TABLE `userprofile` DISABLE KEYS */;
INSERT INTO `userprofile` VALUES (1,'Rutuja','5',1000,0),(2,'AVC','gfd',1000,0),(3,'TAN','vb',1000,0),(4,'tanvi','tanvi@234',1098.5,234.5),(12,'kkkk','abcdef',77,88),(14,'anand','opc.com',899,67),(15,'kanand','kavana@gmail.com',110000,2000),(16,'dsf','dddd@gmail.com',110000,2000),(17,'swijal','swij@gmail.com',110000,20000),(18,'shrey','ss@gmail.com',105000,30000),(19,'fdgdg','dddgdedd@gmail.com',110000,2000),(20,'sfsfs','dfdfdff@gmail.com',113400,200),(21,'testname','test@email.com',115999,2000),(22,'hello','world.com',6238,323),(23,'hellooooo','hehehe.com',1313,313131),(24,'blah','fsssff@gmail.com',113400,2000),(26,'bladfdh','fsssfsfssfsff@gmail.com',113000,2000),(27,'imptrial','dontgo.com',115000,2000),(30,'amritha','am@gmail.com',11000,2000),(31,'udit','bakwaas@gmail.com',78733,6834),(33,'fafdfa','afadf.vom',32424,22),(34,'adg','dsgs.com',224342,2232),(35,'fdsfds','safa.com',23223,232),(36,'fadfd','asa.com',2332,2311),(37,'afdfadf','dfa.com',24242,2424),(38,'fajfa','fhkfad.com',2424,242),(39,'sajf','afaf.com',24204,223),(40,'afakf','aby.com',2313,22),(41,'afafa','abcf.com',224,24),(42,'fadfad','r.com',223,1);
/*!40000 ALTER TABLE `userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userproperty`
--

DROP TABLE IF EXISTS `userproperty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userproperty` (
  `uid` int(11) NOT NULL,
  `property_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(25) NOT NULL,
  `area` double NOT NULL,
  `evaluation` double NOT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userproperty`
--

LOCK TABLES `userproperty` WRITE;
/*!40000 ALTER TABLE `userproperty` DISABLE KEYS */;
/*!40000 ALTER TABLE `userproperty` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-08 10:59:16
