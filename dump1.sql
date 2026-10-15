-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: lll
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app1_comments1`
--

DROP TABLE IF EXISTS `app1_comments1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app1_comments1` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment` longtext NOT NULL,
  `dong_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app1_comments1_dong_id_6a87e386_fk_app1_dongtai_id` (`dong_id`),
  KEY `app1_comments1_user_id_58886aca_fk_app1_users_id` (`user_id`),
  CONSTRAINT `app1_comments1_dong_id_6a87e386_fk_app1_dongtai_id` FOREIGN KEY (`dong_id`) REFERENCES `app1_dongtai` (`id`),
  CONSTRAINT `app1_comments1_user_id_58886aca_fk_app1_users_id` FOREIGN KEY (`user_id`) REFERENCES `app1_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app1_comments1`
--

LOCK TABLES `app1_comments1` WRITE;
/*!40000 ALTER TABLE `app1_comments1` DISABLE KEYS */;
INSERT INTO `app1_comments1` VALUES (63,'da\'s\'d',90,NULL,'2026-08-21 17:02'),(112,'333',122,NULL,'2026-09-01 19:22');
/*!40000 ALTER TABLE `app1_comments1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app1_dongtai`
--

DROP TABLE IF EXISTS `app1_dongtai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app1_dongtai` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `img1_url` varchar(200) DEFAULT NULL,
  `img2_url` varchar(200) DEFAULT NULL,
  `img3_url` varchar(200) DEFAULT NULL,
  `img4_url` varchar(200) DEFAULT NULL,
  `img5_url` varchar(200) DEFAULT NULL,
  `img6_url` varchar(200) DEFAULT NULL,
  `text` longtext NOT NULL,
  `likes` int NOT NULL,
  `comments` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `username` varchar(12) NOT NULL,
  `ava_url` varchar(200) DEFAULT NULL,
  `time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app1_dongtai`
--

LOCK TABLES `app1_dongtai` WRITE;
/*!40000 ALTER TABLE `app1_dongtai` DISABLE KEYS */;
INSERT INTO `app1_dongtai` VALUES (56,'','','','','','','gfjgg',0,0,'用户lllllll','lllllll','http://tf6f8c63.natappfree.cc//media/avatar/blob','2026-08-18 12:57'),(90,'','','','','','','啊啊啊啊啊啊啊啊啊啊啊啊啊啊',2,1,'用户77777777777','77777777777','http://v864b24c.natappfree.cc/media/avatar/1787302797070v4ugwvi1.jpg','2026-08-21 16:57'),(94,'','','','','','','哦啦啦啦啦啦',2,0,'用户77777777777','77777777777','/media/avatar/1787302797070v4ugwvi1.jpg','2026-08-22 13:40'),(122,'media/article/1a82560e-2329-4e6a-8cb7-2a42177c593d.jpg','','','','','','666',3,1,'师','88888888','http://ha79d439.natappfree.cc/media/avatar/1788261221531j6ydmpwt.jpg','2026-09-01 19:12'),(159,'media/article/c3079b19-55c2-4099-a2db-f3e51ace71d4.jpg','','','','','','666',1,0,'师','88888888','/media/avatar/1788261221531j6ydmpwt.jpg','2026-09-03 19:15');
/*!40000 ALTER TABLE `app1_dongtai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app1_fans`
--

DROP TABLE IF EXISTS `app1_fans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app1_fans` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(12) NOT NULL,
  `fans_username` varchar(12) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app1_fans`
--

LOCK TABLES `app1_fans` WRITE;
/*!40000 ALTER TABLE `app1_fans` DISABLE KEYS */;
INSERT INTO `app1_fans` VALUES (1,'888888','888888'),(4,'lllllll','lllllll'),(5,'123456','123456'),(39,'123456','123456'),(41,'410621','410621'),(44,'123456','410621'),(49,'77777777777','77777777777'),(61,'77777777777','123456'),(92,'410621','123456'),(108,'88888888','88888888'),(117,'123456','88888888'),(118,'410621','88888888'),(120,'77777777777','88888888'),(128,'666666','666666'),(139,'12345678','12345678'),(140,'410621','12345678'),(141,'88888888','12345678'),(142,'77777777777','12345678');
/*!40000 ALTER TABLE `app1_fans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app1_files`
--

DROP TABLE IF EXISTS `app1_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app1_files` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(12) NOT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `age` varchar(3) DEFAULT NULL,
  `birth` varchar(20) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `job` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app1_files`
--

LOCK TABLES `app1_files` WRITE;
/*!40000 ALTER TABLE `app1_files` DISABLE KEYS */;
INSERT INTO `app1_files` VALUES (8,'123456','♀','80','2026-08-10','北京','客服'),(9,'410621','','','','未知',''),(11,'77777777777','','','','未知',''),(13,'88888888','','','','未知',''),(15,'666666','','','','未知',''),(17,'12345678','','','','未知','');
/*!40000 ALTER TABLE `app1_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app1_users`
--

DROP TABLE IF EXISTS `app1_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app1_users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(12) NOT NULL,
  `name` varchar(20) NOT NULL,
  `fans` int NOT NULL,
  `guanzhu` int NOT NULL,
  `fangke` int NOT NULL,
  `avatar` varchar(100) NOT NULL,
  `dongtai` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app1_users`
--

LOCK TABLES `app1_users` WRITE;
/*!40000 ALTER TABLE `app1_users` DISABLE KEYS */;
INSERT INTO `app1_users` VALUES (10,'123456','花开富贵',3,3,0,'avatar/1787489229193vnjqshhd.jpg',-2),(11,'410621','用户410621',3,4,0,'avatar/1787303290102jji9nyu4.jpg',2),(13,'77777777777','用户77777777777',3,0,0,'avatar/1787302797070v4ugwvi1.jpg',3),(15,'88888888','师',2,5,0,'avatar/1788261221531j6ydmpwt.jpg',2),(17,'666666','用户666666',1,1,0,'avatar\\img.png',0),(19,'12345678','用户12345678',0,3,0,'avatar\\img.png',0);
/*!40000 ALTER TABLE `app1_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app1_users_who_likes`
--

DROP TABLE IF EXISTS `app1_users_who_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app1_users_who_likes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dong_id` int NOT NULL,
  `username` varchar(12) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=551 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app1_users_who_likes`
--

LOCK TABLES `app1_users_who_likes` WRITE;
/*!40000 ALTER TABLE `app1_users_who_likes` DISABLE KEYS */;
INSERT INTO `app1_users_who_likes` VALUES (97,30,'888888'),(99,26,'888888'),(102,32,'888888'),(108,34,'888888'),(160,59,'李轩昂是个屁'),(164,37,'888888'),(167,70,'66666666'),(168,69,'66666666'),(173,78,'333333'),(176,84,'333333'),(177,84,'777777'),(183,85,'777777'),(190,89,'12345678'),(259,95,'12345678'),(475,90,'123456'),(476,94,'123456'),(477,95,'123456'),(487,96,'12345678'),(489,96,'123456'),(492,107,'123456'),(493,108,'123456'),(502,110,'12345678'),(511,119,'999999'),(512,121,'999999'),(517,107,'12345678'),(522,120,'12345678'),(524,121,'12345678'),(526,122,'12345678'),(536,122,'12345678'),(538,155,'12345678'),(539,154,'12345678'),(540,119,'999999'),(543,122,'88888888'),(544,94,'88888888'),(545,90,'88888888'),(546,160,'12345678'),(547,138,'12345678'),(548,162,'666666'),(549,161,'666666'),(550,159,'12345678');
/*!40000 ALTER TABLE `app1_users_who_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add users',7,'add_users'),(26,'Can change users',7,'change_users'),(27,'Can delete users',7,'delete_users'),(28,'Can view users',7,'view_users'),(29,'Can add dongtai',8,'add_dongtai'),(30,'Can change dongtai',8,'change_dongtai'),(31,'Can delete dongtai',8,'delete_dongtai'),(32,'Can view dongtai',8,'view_dongtai'),(33,'Can add fans',9,'add_fans'),(34,'Can change fans',9,'change_fans'),(35,'Can delete fans',9,'delete_fans'),(36,'Can view fans',9,'view_fans'),(37,'Can add users_ who_ likes',10,'add_users_who_likes'),(38,'Can change users_ who_ likes',10,'change_users_who_likes'),(39,'Can delete users_ who_ likes',10,'delete_users_who_likes'),(40,'Can view users_ who_ likes',10,'view_users_who_likes'),(41,'Can add comments1',11,'add_comments1'),(42,'Can change comments1',11,'change_comments1'),(43,'Can delete comments1',11,'delete_comments1'),(44,'Can view comments1',11,'view_comments1'),(45,'Can add files',12,'add_files'),(46,'Can change files',12,'change_files'),(47,'Can delete files',12,'delete_files'),(48,'Can view files',12,'view_files');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (18,'pbkdf2_sha256$320000$EMEf6c18TqzbVd6nExLaLT$0dLscpacURbuRQO4hR1LgqFF5dwqAYAvZXCXFoT4ASM=',NULL,0,'123456','','','779400255@qq.com',0,1,'2026-08-21 08:35:49.186994'),(19,'pbkdf2_sha256$320000$lem92iwD4TeiAoiv5Fq9G4$gocHIo//PObXgFgmqsKz/ESZCT4iBtIjdPfq9vWIDYc=',NULL,0,'410621','','','459292210@qq.com',0,1,'2026-08-21 08:46:37.078079'),(21,'pbkdf2_sha256$320000$t7ebwGXJg0T7YZDh5P20dP$hnzHxHB07XjxxY+C1QJKqqQYuRf41/err3uwyVWxXSs=',NULL,0,'77777777777','','','875415300@qq.com',0,1,'2026-08-21 08:56:21.431138'),(23,'pbkdf2_sha256$320000$8eWxrsfk7vDZDa756UIVIH$oZiVHouR5Fr9aIbFy8UoS8LyA6m5Ydg9WOReWGc4yEY=',NULL,0,'88888888','','','3133634238@qq.com',0,1,'2026-09-01 11:12:09.594775'),(25,'pbkdf2_sha256$320000$QeakdFQ6JhjsWnjTZBGzG2$KIy3Znnh5RAMiS1PzBJ2OioVBpVsglaxbcyjYvhbshk=',NULL,0,'666666','','','1005103630@qq.com',0,1,'2026-09-03 11:30:39.866292'),(27,'pbkdf2_sha256$320000$tgU0qLuY6czqVPzgZrjYKy$KQp0SU8poQznE+oGC+SfTsCmyedklPoZSn7BG1SKuVg=',NULL,0,'12345678','','','3163981881@qq.com',0,1,'2026-09-03 13:44:54.117135');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(11,'app1','comments1'),(8,'app1','dongtai'),(9,'app1','fans'),(12,'app1','files'),(7,'app1','users'),(10,'app1','users_who_likes'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-07-24 11:39:14.275481'),(2,'auth','0001_initial','2026-07-24 11:39:15.594149'),(3,'admin','0001_initial','2026-07-24 11:39:15.852441'),(4,'admin','0002_logentry_remove_auto_add','2026-07-24 11:39:15.864670'),(5,'admin','0003_logentry_add_action_flag_choices','2026-07-24 11:39:15.873686'),(6,'app1','0001_initial','2026-07-24 11:39:15.913932'),(7,'contenttypes','0002_remove_content_type_name','2026-07-24 11:39:16.077175'),(8,'auth','0002_alter_permission_name_max_length','2026-07-24 11:39:16.191895'),(9,'auth','0003_alter_user_email_max_length','2026-07-24 11:39:16.223375'),(10,'auth','0004_alter_user_username_opts','2026-07-24 11:39:16.232768'),(11,'auth','0005_alter_user_last_login_null','2026-07-24 11:39:16.314899'),(12,'auth','0006_require_contenttypes_0002','2026-07-24 11:39:16.321932'),(13,'auth','0007_alter_validators_add_error_messages','2026-07-24 11:39:16.332162'),(14,'auth','0008_alter_user_username_max_length','2026-07-24 11:39:16.433961'),(15,'auth','0009_alter_user_last_name_max_length','2026-07-24 11:39:16.539974'),(16,'auth','0010_alter_group_name_max_length','2026-07-24 11:39:16.567839'),(17,'auth','0011_update_proxy_permissions','2026-07-24 11:39:16.580358'),(18,'auth','0012_alter_user_first_name_max_length','2026-07-24 11:39:16.706033'),(19,'sessions','0001_initial','2026-07-24 11:39:16.776633'),(20,'app1','0002_delete_users','2026-07-24 13:20:13.954993'),(21,'app1','0003_initial','2026-08-04 13:17:32.869505'),(22,'app1','0004_users_dongtai','2026-08-07 14:37:48.847004'),(23,'app1','0005_dongtai_comments_dongtai_name_alter_dongtai_likes_and_more','2026-08-10 14:50:51.801351'),(24,'app1','0006_remove_dongtai_username_dongtai_user_id','2026-08-10 14:55:30.958865'),(25,'app1','0007_alter_dongtai_img1_url_alter_dongtai_img2_url_and_more','2026-08-10 15:37:06.624867'),(26,'app1','0008_alter_dongtai_img1_url_alter_dongtai_img2_url_and_more','2026-08-10 15:41:24.090971'),(27,'app1','0009_alter_dongtai_img1_url_alter_dongtai_img2_url_and_more','2026-08-10 15:43:09.415068'),(28,'app1','0010_remove_fans_fans_fans_fans_username','2026-08-10 15:55:16.677119'),(29,'app1','0011_remove_dongtai_user_id_dongtai_username','2026-08-11 12:23:48.967889'),(30,'app1','0012_alter_dongtai_username','2026-08-11 13:43:04.889035'),(31,'app1','0013_dongtai_ava_url','2026-08-11 14:15:29.972072'),(32,'app1','0014_dongtai_time','2026-08-11 14:33:40.380817'),(33,'app1','0015_users_who_likes','2026-08-12 16:09:41.112951'),(34,'app1','0016_comments1','2026-08-14 14:26:09.426464'),(35,'app1','0017_comments1_time','2026-08-14 14:50:38.328630'),(36,'app1','0018_files','2026-08-16 09:21:39.813855'),(37,'app1','0019_alter_users_name','2026-08-16 10:50:49.183612'),(38,'app1','0020_alter_dongtai_name','2026-08-16 11:56:36.660682'),(39,'app1','0021_alter_files_age_alter_files_birth_alter_files_gender_and_more','2026-08-18 14:00:22.342579'),(40,'app1','0022_alter_files_ip','2026-08-20 12:10:45.457831'),(41,'app1','0023_alter_files_ip','2026-08-20 12:11:36.128966');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('00mee016bnut4k3b61gu742yfzkybrhv','eyJlbWFpbCI6Ijc3OTQwMDI1NUBxcS5jb20iLCJ2ZXIiOiI0NjUzODcifQ:1wwBq5:r7KYQfpzQDMCEMapkQm-G_ELMZo_XR5Mg7Cc1vmRcuA','2026-09-01 04:54:17.386903'),('17cfhgtfmr5n99fo7osxdcnxo4aimp6z','e30:1wvYVr:WkL6K_zZNKSsnSKkfeIhY11s8Z7XIudQm5O747eSoJ0','2026-08-30 10:54:47.936515'),('1iyhdspoqp0f8lbqhioh8sorj3lk800y','eyJlbWFpbCI6IjM0ODgzNjQ4NjRAcXEuY29tIiwidmVyIjoiMzg1OTExIn0:1x25O0:0uCPYXUfxM6GL0I7gV29nfJIVPU4IkOVEEEvgldtw4s','2026-09-17 11:13:40.644971'),('1ly5p0a3cbvuyu69kdovmuyj3xzm5qa2','e30:1x25eS:EVqBQnJTbV9Zetq99XTnOI9GO0W3ODTACf_VdlWiXQA','2026-09-17 11:30:40.031342'),('4n3xawjtcyyx593bubptong3wjk7u9et','eyJlbWFpbCI6Ijc3OTQwMDI1NUBxcS5jb20iLCJ2ZXIiOiI1Nzc0NTEifQ:1wsLYW:X7yuhmLQ9VLZGB5POgbkFLNW1C3ZdKzJ0Sc0jAibEnI','2026-08-21 14:28:16.678680'),('bhqbo4dumj4rkwo0uwqs12czwumu9qig','e30:1wwBro:l4KG69pBu9Olz0jdCp2H06N613B8xy5D7TZTlSdFJNk','2026-09-01 04:56:04.852068'),('dpkbtvp6mm8r72qaue68q2hckbwbk7jd','e30:1wxKxc:F9PqdFSmKU15xA_0NAWADhHd5_DPp8vFZ7F_GWGRKGU','2026-09-04 08:50:48.226624'),('eq65kfnsgqa3865vntcddxljvyb0xngz','e30:1wxL2z:2sZJLeRaPQLMjmFXKp5M6Ynb1vdGQxbdTFzbs7X-A6E','2026-09-04 08:56:21.598795'),('ey3x6yc8xa4zu2i1myvjblrzc5gwmk6t','e30:1wpoRP:9weLQWiH2kNkqCFNhoYsaykhGQEoWeVR4DDz6KhOw0o','2026-08-14 14:42:27.174701'),('ffeurew32mcd6wybl1tkgc0zfzwfatmn','e30:1x27kM:vPyFMdl-JlQB1uzHTsFaiq9rNfaodTBSKzOCvh3KdVY','2026-09-17 13:44:54.209468'),('i1hsjke2ac0guvyvn5pctt5g2qmm82ks','e30:1wxKtZ:js4PxMFTwUQtBRcBIsoBZ4Gw4_KSV8wjRbk87Ea62M8','2026-09-04 08:46:37.166040'),('jcc1z36wbitbe7g0w7g9vtwz1at05t3n','e30:1x1MPR:qN5_-LDJxeB0dg2DrFaE8jF5ULlEdLpeV6u1K1XiFa0','2026-09-15 11:12:09.726802'),('l6rv09rxycrxdb86efq6kmbjwp1knksj','eyJlbWFpbCI6Ijc3OTQwMDI1NUBxcS5jb20iLCJ2ZXIiOiI1MjU3MjcifQ:1wvYN1:QFE2MasJHnmTM4E5Z5Yd2_UnBU8DtCNxqk2Z9a5_d9o','2026-08-30 10:45:39.712920'),('plu8wd0i0hzu9n9hmxg1uu816537wr6a','e30:1wwCOT:wD_Z20WkCQQBFUuqKoOKTRKZdcCwRCBmSgA_CbqDYZE','2026-09-01 05:29:49.587976'),('pntjlcnzoibdzdp0nxnly9ovt7veute0','e30:1wwKzf:o5EhaFOWjnk2fHhV9G-h77N4dF2KpiQXmCJc6Obi6iM','2026-09-01 14:40:47.248627'),('q8ro0j27vnnmj7nmambp8nncfh06ec1l','e30:1x1MNS:_DfPtwxBsJrQYfQXDWj5yNdSBOPjqxjYhzEbyyg5AFQ','2026-09-15 11:10:06.356166'),('vq7ft6wbzbdg5urs75wrq4ruh18vqi1s','e30:1wwiHu:1pi5ZgDWZXH8gQVPV6G_REWJAJT-Bc-A6lDswIJEsco','2026-09-02 15:33:10.229903'),('wrstgs72a59b65nqzgacmoa5vg2b1k0p','eyJlbWFpbCI6IjEwMDUxMDM2MzBAcXEuY29tIiwidmVyIjoiMjc5MjY0In0:1x21cV:SEgAg9GhEJETXwi0vs3TYxN6cAwiJ6_iTKQl9KiDjr8','2026-09-17 07:12:23.819366'),('yjlw23130qrocey20i6nu3xbq3fba5cd','eyJlbWFpbCI6Ijg4ODg4OEBxcS5jb20iLCJ2ZXIiOiI2OTc4NzEifQ:1wvYHc:NQEWsfvf-iIlNxpnphbzTRPRWoGa7BQbCK9vsppOah0','2026-08-30 10:40:04.878870'),('yv5n1316cznwfhzvs2budmsapb7ppbg6','e30:1wxKj7:BQcu5tWE4YqD83zsDjJYii5x6kbsaxU9OI8wwMJtduQ','2026-09-04 08:35:49.292741'),('zwio9540rwc6ntuytqdc8x8wkwgrn6mn','eyJlbWFpbCI6IjMxNjM5ODE4ODFAcXEuY29tIiwidmVyIjoiOTA4NTI2In0:1x27de:Im416g03bxP2VwepcfQB_ZdA0NVUSYIZIQTbh-L6FfQ','2026-09-17 13:37:58.563931');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-19 17:59:53
