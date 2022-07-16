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
-- Table structure for table `invalid_tokens`
--

DROP TABLE IF EXISTS `invalid_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invalid_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `jti` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_invalid_tokens_jti` (`jti`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invalid_tokens`
--

LOCK TABLES `invalid_tokens` WRITE;
/*!40000 ALTER TABLE `invalid_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `invalid_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `like_count` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `tweet_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `tweet_id` (`tweet_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_mgmt` (`id`),
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`tweet_id`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tweet_title` varchar(80) NOT NULL,
  `tweet` varchar(500) NOT NULL,
  `stamp` varchar(20) NOT NULL,
  `post_img` varchar(20) DEFAULT NULL,
  `like_count` varchar(10) DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_mgmt` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (2,'asdasd','<p>mongo</p>','15 July\'22 09:29 PM','default.jpg','0',1),(3,'second tweet','<p>hello all</p>','15 July\'22 09:30 PM','default.jpg','0',1);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retweet`
--

DROP TABLE IF EXISTS `retweet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retweet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tweet_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `retweet_stamp` varchar(20) NOT NULL,
  `retweet_text` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tweet_id` (`tweet_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `retweet_ibfk_1` FOREIGN KEY (`tweet_id`) REFERENCES `post` (`id`),
  CONSTRAINT `retweet_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_mgmt` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retweet`
--

LOCK TABLES `retweet` WRITE;
/*!40000 ALTER TABLE `retweet` DISABLE KEYS */;
INSERT INTO `retweet` VALUES (1,NULL,1,'15 July\'22 09:27 PM','<p>I have to edit this!</p>'),(2,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(3,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(4,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(5,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(6,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(7,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(8,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(9,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(10,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(11,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(12,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(13,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(14,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(15,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(16,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(17,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(18,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(19,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(20,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(21,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(22,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(23,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(24,NULL,1,'15 July\'22 09:28 PM','<p>I have to edit this!</p>'),(25,2,1,'15 July\'22 09:30 PM','<p>retweeting this first tweet</p>'),(26,2,1,'15 July\'22 09:31 PM','<p>second retweet</p>'),(27,3,1,'15 July\'22 09:34 PM','<p>heyyyy</p>');
/*!40000 ALTER TABLE `retweet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeline`
--

DROP TABLE IF EXISTS `timeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timeline` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int DEFAULT NULL,
  `retweet_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  KEY `retweet_id` (`retweet_id`),
  CONSTRAINT `timeline_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  CONSTRAINT `timeline_ibfk_2` FOREIGN KEY (`retweet_id`) REFERENCES `retweet` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeline`
--

LOCK TABLES `timeline` WRITE;
/*!40000 ALTER TABLE `timeline` DISABLE KEYS */;
INSERT INTO `timeline` VALUES (1,NULL,NULL),(2,NULL,1),(3,NULL,2),(4,NULL,3),(5,NULL,4),(6,NULL,5),(7,NULL,6),(8,NULL,7),(9,NULL,8),(10,NULL,9),(11,NULL,10),(12,NULL,11),(13,NULL,12),(14,NULL,13),(15,NULL,14),(16,NULL,15),(17,NULL,16),(18,NULL,17),(19,NULL,18),(20,NULL,19),(21,NULL,20),(22,NULL,21),(23,NULL,22),(24,NULL,23),(25,NULL,24),(26,2,NULL),(27,2,25),(28,3,NULL),(29,2,26),(30,3,27);
/*!40000 ALTER TABLE `timeline` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_mgmt`
--

LOCK TABLES `user_mgmt` WRITE;
/*!40000 ALTER TABLE `user_mgmt` DISABLE KEYS */;
INSERT INTO `user_mgmt` VALUES (1,'elon_musk@gmail.com','pbkdf2:sha256:260000$rYLtXoBdymkMUid2$329189aadead7d31b7e3f1e6d28f5510bc689f5acdd552ba05f09bd9e57cde0f','elon','musk','7982267437','elon_says','default.jpg','default_bg.jpg',NULL,NULL,NULL);
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

-- Dump completed on 2022-07-16 14:02:10
