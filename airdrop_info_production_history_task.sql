CREATE DATABASE  IF NOT EXISTS `airdrop_info_production` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `airdrop_info_production`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 185.100.233.95    Database: airdrop_info_production
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `history_task`
--

DROP TABLE IF EXISTS `history_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_task` (
  `airdrop_id` varchar(50) NOT NULL,
  `uid` varchar(50) NOT NULL,
  `choose_language` varchar(45) DEFAULT NULL,
  `come_group` tinyint DEFAULT NULL,
  `come_new_channel` tinyint DEFAULT NULL,
  `come_airdrophub_channel` tinyint DEFAULT NULL,
  `come_twitter` tinyint DEFAULT NULL,
  `retweet_task` tinyint DEFAULT NULL,
  `come_vote_coingecko` tinyint DEFAULT NULL,
  `vote_photo_in_coingecko` varchar(200) DEFAULT NULL,
  `come_vote_dextools` tinyint DEFAULT NULL,
  `vote_photo_in_dextools` varchar(200) DEFAULT NULL,
  `come_vote_poocoin` tinyint DEFAULT NULL,
  `vote_photo_in_poocoin` varchar(200) DEFAULT NULL,
  `subscribe_youtube` tinyint DEFAULT NULL,
  `follow_facebook` tinyint DEFAULT NULL,
  `follow_instagram` tinyint DEFAULT NULL,
  `follow_medium` tinyint DEFAULT NULL,
  `follow_discord` tinyint DEFAULT NULL,
  `register_account` tinyint DEFAULT NULL,
  `submit_task` tinyint DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`airdrop_id`,`uid`),
  KEY `history_task_ibfk_2_idx` (`uid`),
  KEY `history_task_ibfk_2_idx1` (`airdrop_id`),
  KEY `fk_history_task_user` (`uid`,`airdrop_id`) USING BTREE,
  CONSTRAINT `fk_history_task_user` FOREIGN KEY (`airdrop_id`, `uid`) REFERENCES `user` (`airdrop_id`, `uid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-21 10:22:53
