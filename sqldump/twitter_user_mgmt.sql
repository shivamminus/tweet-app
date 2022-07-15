-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: twitter
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `user_mgmt`
--

DROP TABLE IF EXISTS `user_mgmt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_mgmt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `password` varchar(150) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `contact` varchar(12) NOT NULL,
  `loginid` varchar(50) NOT NULL,
  `image_file` varchar(20) DEFAULT NULL,
  `bg_file` varchar(20) DEFAULT NULL,
  `bio` varchar(200) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `bday` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `loginid` (`loginid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_mgmt`
--

LOCK TABLES `user_mgmt` WRITE;
/*!40000 ALTER TABLE `user_mgmt` DISABLE KEYS */;
INSERT INTO `user_mgmt` VALUES (1,'dubeyshivam044@gmail.com','pbkdf2:sha256:260000$CHOU437ozQaOkiHi$f6b4bfd292fe3b85e9578b8e7fc7a03579798c870d574db627ffade1d42ca9b3','shivam','dubey','7982267437','cicada','default.jpg','default_bg.jpg',NULL,NULL,NULL),(2,'natansh.upadhyay@gmail.com','pbkdf2:sha256:260000$0TgaaanHHtjXPZyK$7a507f4495b8cd47d732b4be2f41e380def335ac25cc8d9a9c63a86ce20e6cae','natansh','upadhyay','7985546782','nats','default.jpg','default_bg.jpg',NULL,NULL,NULL),(3,'elonmusk@gmail.com','pbkdf2:sha256:260000$lnx0VT625U1RN1jJ$0143f54f755ce79ba95dfb0a09297d444e0bad773b3edaee83aea395b7e01349','Elon','Mast','9876543423','elon_says','default.jpg','default_bg.jpg',NULL,NULL,NULL);
/*!40000 ALTER TABLE `user_mgmt` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-02 15:49:42
