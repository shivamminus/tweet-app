CREATE DATABASE  IF NOT EXISTS `twitter` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `twitter`;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invalid_tokens`
--

LOCK TABLES `invalid_tokens` WRITE;
/*!40000 ALTER TABLE `invalid_tokens` DISABLE KEYS */;
INSERT INTO `invalid_tokens` VALUES (1,'c02831df-35ee-4de5-ae2d-6c51b70f8ffa');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,NULL,3,39),(2,NULL,3,40);
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (2,'robots the And','And so the robots spared humanity ... https://t.co/v7JUJQWfCv\'','02 July\'22 03:28 PM',NULL,'0',3),(3,'that\'s Exactly. Tesla','@ForIn2020 @waltmossberg @mims @defcon_5 Exactly. Tesla is absurdly overvalued if based on the past, but that\'s irr\\xe2\\x80\\xa6 https://t.co/qQcTqkzgMl\"','02 July\'22 03:28 PM',NULL,'0',3),(4,'@defcon_5 Et Walt?\'','@waltmossberg @mims @defcon_5 Et tu, Walt?\'','02 July\'22 03:28 PM',NULL,'0',3),(5,'Shortville weather ...\'','Stormy weather in Shortville ...\'','02 July\'22 03:28 PM',NULL,'0',3),(6,'dead.\" dying is','@DaveLeeBBC @verge Coal is dying due to nat gas fracking. It\'s basically dead.\"','02 July\'22 03:28 PM',NULL,'0',3),(7,'helicopter just helicopter\'s','@Lexxxzis It\'s just a helicopter in helicopter\'s clothing\"','02 July\'22 03:28 PM',NULL,'0',3),(8,'@verge','@verge It won\'t matter\"','02 July\'22 03:28 PM',NULL,'0',3),(9,'good\'','@SuperCoolCube Pretty good\'','02 July\'22 03:28 PM',NULL,'0',3),(10,'Damn obtuse! have','Why did we waste so much time developing silly rockets? Damn you, aliens! So obtuse! You have all this crazy tech, but can\'t speak English!?\"','02 July\'22 03:28 PM',NULL,'0',3),(11,'are actually the','Technology breakthrough: turns out chemtrails are actually a message from time-traveling aliens describing the secret of teleportation\'','02 July\'22 03:28 PM',NULL,'0',3),(12,'trained world\'s entirely','RT @OpenAI: We\'ve created the world\'s first Spam-detecting AI trained entirely in simulation and deployed on a physical robot: https://t.co\\xe2\\x80\\xa6\"','02 July\'22 03:28 PM',NULL,'0',3),(13,'This rockets to','RT @ProfBrianCox: This is extremely important from @elonmusk and @SpaceX - reusable rockets bring us MUCH closer to becoming a spacefaring\\xe2\\x80\\xa6\'','02 July\'22 03:28 PM',NULL,'0',3),(14,'that\' Ludicrous+, after','@adamsbj Def P100D with Ludicrous+, although the rocket starts going a lot faster after that\'','02 July\'22 03:28 PM',NULL,'0',3),(15,'of we weight','@BadAstronomer We can def bring it back like Dragon. Just a question of how much weight we need to add.\'','02 July\'22 03:28 PM',NULL,'0',3),(16,'Working @tesla_addict it\'','@tesla_addict @TeslaMotors Working on it\'','02 July\'22 03:28 PM',NULL,'0',3),(17,'fully mode.\" in','@jasonlamb Looks like it could do 20% more with some structural upgrades to handle higher loads. But that\'s in fully expendable mode.\"','02 July\'22 03:28 PM',NULL,'0',3),(18,'@cheron','@cheron A lot\'','02 July\'22 03:28 PM',NULL,'0',3),(19,'giant Silliest https://t.co/68nMJkiPsC\'','@Cardoso Silliest thing we can imagine! Secret payload of 1st Dragon flight was a giant wheel of cheese. Inspired b\\xe2\\x80\\xa6 https://t.co/68nMJkiPsC\'','02 July\'22 03:28 PM',NULL,'0',3),(20,'to &gt;0% point,','@redletterdave Good point, odds go from 0% to &gt;0% :)\'','02 July\'22 03:28 PM',NULL,'0',3),(21,'Heavy scheduled Falcon','Falcon Heavy test flight currently scheduled for late summer\'','02 July\'22 03:28 PM',NULL,'0',3),(22,'stage demo back','Considering trying to bring upper stage back on Falcon Heavy demo flight for full reusability. Odds of success low, but maybe worth a shot.\'','02 July\'22 03:34 PM',NULL,'0',1),(23,'already or underlyin\\xe2\\x80\\xa6','@oxfordteddy Browser is already a little better. Kernel and browser update in prob 6 weeks or so (lots of underlyin\\xe2\\x80\\xa6 https://t.co/XtgQGwJ21D\'','02 July\'22 03:34 PM',NULL,'0',1),(24,'landing today\\xe2\\x80\\x99s photos','RT @SpaceX: More photos from today\\xe2\\x80\\x99s Falcon 9 launch and first stage landing \\xe2\\x86\\x92 https://t.co/095WHX44BX https://t.co/c3UYhMrDec\'','02 July\'22 03:34 PM',NULL,'0',1),(25,'@SpaceX','@BadAstronomer @SpaceX Thanks Phil!\'','02 July\'22 03:34 PM',NULL,'0',1),(26,'Next Incredibly is','Incredibly proud of the SpaceX team for achieving this milestone in space! Next goal is reflight within 24 hours.\'','02 July\'22 03:34 PM',NULL,'0',1),(27,'of Course Still','RT @SpaceX: Falcon 9 first stage has landed on Of Course I Still Love You \\xe2\\x80\\x94 world\\xe2\\x80\\x99s first reflight of an orbital class rocket.\'','02 July\'22 03:34 PM',NULL,'0',1),(28,'\\xe2\\x86\\x92 SES-10 are','RT @SpaceX: ~60 minutes until launch window for SES-10 opens. All systems and weather are go. Watch here \\xe2\\x86\\x92 https://t.co/gtC39uBC7z https://\\xe2\\x80\\xa6\'','02 July\'22 03:34 PM',NULL,'0',1),(29,'EDT, UTC. on','RT @SpaceX: Falcon 9 and SES-10 vertical on Kennedy Space Center\\xe2\\x80\\x99s historic Pad 39A. Launch window opens at 6:27pm EDT, 10:27pm UTC. https:\\xe2\\x80\\xa6\'','02 July\'22 03:34 PM',NULL,'0',1),(30,'pad Made sketch','Made today on Tesla sketch pad https://t.co/Z8dFP2NN41\'','02 July\'22 03:34 PM',NULL,'0',1),(31,'screen tap you','If you just downloaded V8.1, tap the the T on center screen three times\'','02 July\'22 03:34 PM',NULL,'0',1),(32,'On center *will*','@drmanejwala @arctechinc On center screen. Also, center screen *will* show speed as an overlay that changes opacity according to relevance.\'','02 July\'22 03:34 PM',NULL,'0',1),(33,'We yet 3.\'','@danahull Very few. We have yet to do a China (or Europe) launch of Model 3.\'','02 July\'22 03:34 PM',NULL,'0',1),(34,'as have advisor','@business Glad to have Tencent as an investor and advisor to Tesla\'','02 July\'22 03:34 PM',NULL,'0',1),(35,'@chouky02','@nickg_uk @chouky02 No\'','02 July\'22 03:34 PM',NULL,'0',1),(36,'@chouky02 care\" @nickg_uk','@nickg_uk @chouky02 You won\'t care\"','02 July\'22 03:34 PM',NULL,'0',1),(37,'@NakatomiTim me gave','@NakatomiTim What gave me away?\'','02 July\'22 03:34 PM',NULL,'0',1),(38,'No\'','@nickg_uk No\'','02 July\'22 03:34 PM',NULL,'0',1),(39,'few Here space.','Here is the latest SpaceX travel ad for the flight around the moon &amp; into deep space. Maybe needs a few edits ... https://t.co/mA8ZgutrbE\'','02 July\'22 03:34 PM',NULL,'0',1),(40,'dedicate existential Neuralink','Long Neuralink piece coming out on @waitbutwhy in about a week. Difficult to dedicate the time, but existential risk is too high not to.\'','02 July\'22 03:34 PM',NULL,'0',1),(41,'Reinforcement RT New','RT @OpenAI: New research release: overcoming many of Reinforcement Learning\'s limitations with Evolution Strategies: https://t.co/fVIStOFdoU\"','02 July\'22 03:34 PM',NULL,'0',1),(42,'disaster. be get','@erikhaaland We cannot make all country versions simultaneously or the production start would be a disaster. You would get first in Norway.\'','02 July\'22 03:34 PM',NULL,'0',1),(43,'best S RT','RT @RicardoTwumasi: @elonmusk My Tesla Model S is the best car I\'ve ever had https://t.co/OBkDjOPrUo\"','02 July\'22 03:35 PM',NULL,'0',2),(44,'i\'ve @Shkottt: my','RT @Shkottt: @elonmusk my Tesla Roadster is the best car i\'ve ever had\"','02 July\'22 03:35 PM',NULL,'0',2),(45,'9 in in','@TimShelton @FredericLambert @JimPengelly First in line for dual motor as soon as we can make it, which is probably in 6 to 9 months.\'','02 July\'22 03:35 PM',NULL,'0',2),(46,'we straight 8.1','@meangene2030 Damn straight we do! Coming with 8.1 next week.\'','02 July\'22 03:35 PM',NULL,'0',2),(47,'https://t.co/zcs6j1YRa4\' release of','First drive of a release candidate version of Model 3 https://t.co/zcs6j1YRa4\'','02 July\'22 03:35 PM',NULL,'0',2),(48,'one @FredericLambert It','@FredericLambert It still has one display\'','02 July\'22 03:35 PM',NULL,'0',2),(49,'model I\'ve RT','RT @danieltadros: @bobbykansara @elonmusk @MrThorman My model S is the best car I\'ve ever had !!\"','02 July\'22 03:35 PM',NULL,'0',2),(50,'would new and','@VoltzCoreAudio Nothing majorly new that a consumer would notice. Lots of new tech in the design and production process though.\'','02 July\'22 03:35 PM',NULL,'0',2),(51,'car more @arctechinc','@arctechinc The more autonomous a car is, the less dash info you need. How often do you look at the instrument pane\\xe2\\x80\\xa6 https://t.co/Ie6abxs7LD\'','02 July\'22 03:35 PM',NULL,'0',2),(52,'just release Model','@asimo3089 How about the video we just took of the first Model 3 release candidate drive?\'','02 July\'22 03:35 PM',NULL,'0',2),(53,'@bobbykansara: Period.\' is','RT @bobbykansara: @MrThorman @elonmusk My Model X is the greatest thing I have ever purchased. Period.\'','02 July\'22 03:35 PM',NULL,'0',2),(54,'and machine next','@trabru Yup, machine arrives next month and we start digging the tunnel!\'','02 July\'22 03:35 PM',NULL,'0',2),(55,'so\'','@oakhaller I think so\'','02 July\'22 03:35 PM',NULL,'0',2),(56,'schedul\\xe2\\x80\\xa6 on complexity','@FredericLambert @JimPengelly No, we are minimizing configuration complexity to keep the production ramp on schedul\\xe2\\x80\\xa6 https://t.co/REhQOY149t\'','02 July\'22 03:35 PM',NULL,'0',2),(57,'Tues/Wed\'','@Trojan81 Tues/Wed\'','02 July\'22 03:35 PM',NULL,'0',2),(58,'and the was','@jDaz Because I was a dumb idiot and didn\'t realize at the time that it would cause confusion\"','02 July\'22 03:35 PM',NULL,'0',2),(59,'Tues/Wed','@timothymjr Tues/Wed next week\'','02 July\'22 03:35 PM',NULL,'0',2),(60,'which few @Skate_a_book','@Skate_a_book Yes. Model S will always be the fastest Tesla until next gen Roadster, which is a few years away.\'','02 July\'22 03:35 PM',NULL,'0',2),(61,'until not Yes,','@JimPengelly Yes, but not until next year\'','02 July\'22 03:35 PM',NULL,'0',2),(62,'Hardware @AlSaibie production','@AlSaibie Yes. Hardware already on all production S and X cars.\'','02 July\'22 03:35 PM',NULL,'0',2),(63,'https://t.co/m7gxmtjGrZ\' series 5','@theKen_Miller Sorta. Model 3 is like a BMW 3 series or Audi A4. Model S is like BMW 5 and 6 series, but much faste\\xe2\\x80\\xa6 https://t.co/m7gxmtjGrZ\'','02 July\'22 03:35 PM',NULL,'0',2);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retweet`
--

LOCK TABLES `retweet` WRITE;
/*!40000 ALTER TABLE `retweet` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeline`
--

LOCK TABLES `timeline` WRITE;
/*!40000 ALTER TABLE `timeline` DISABLE KEYS */;
INSERT INTO `timeline` VALUES (1,NULL,NULL),(2,2,NULL),(3,3,NULL),(4,4,NULL),(5,5,NULL),(6,6,NULL),(7,7,NULL),(8,8,NULL),(9,9,NULL),(10,10,NULL),(11,11,NULL),(12,12,NULL),(13,13,NULL),(14,14,NULL),(15,15,NULL),(16,16,NULL),(17,17,NULL),(18,18,NULL),(19,19,NULL),(20,20,NULL),(21,21,NULL),(22,22,NULL),(23,23,NULL),(24,24,NULL),(25,25,NULL),(26,26,NULL),(27,27,NULL),(28,28,NULL),(29,29,NULL),(30,30,NULL),(31,31,NULL),(32,32,NULL),(33,33,NULL),(34,34,NULL),(35,35,NULL),(36,36,NULL),(37,37,NULL),(38,38,NULL),(39,39,NULL),(40,40,NULL),(41,41,NULL),(42,42,NULL),(43,43,NULL),(44,44,NULL),(45,45,NULL),(46,46,NULL),(47,47,NULL),(48,48,NULL),(49,49,NULL),(50,50,NULL),(51,51,NULL),(52,52,NULL),(53,53,NULL),(54,54,NULL),(55,55,NULL),(56,56,NULL),(57,57,NULL),(58,58,NULL),(59,59,NULL),(60,60,NULL),(61,61,NULL),(62,62,NULL),(63,63,NULL);
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

-- Dump completed on 2022-07-02 16:33:46
