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
-- Table structure for table `config_bot`
--

DROP TABLE IF EXISTS `config_bot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_bot` (
  `airdrop_id` varchar(50) NOT NULL,
  `has_send_token` tinyint DEFAULT '0',
  `tele_username_bot` varchar(100) NOT NULL,
  `tele_token` varchar(200) NOT NULL,
  `tele_echo_token` varchar(200) DEFAULT NULL,
  `tele_username_group` varchar(100) DEFAULT NULL,
  `tele_id_group` varchar(100) DEFAULT NULL,
  `name_site` varchar(100) DEFAULT NULL,
  `currency_code` varchar(10) DEFAULT NULL,
  `tele_username_channel` varchar(45) DEFAULT NULL,
  `tele_id_channel` varchar(100) DEFAULT NULL,
  `tele_username_airdrophub_channel` varchar(100) DEFAULT NULL,
  `tele_id_airdrophub_channel` varchar(100) DEFAULT NULL,
  `twitter_username` varchar(100) DEFAULT NULL,
  `congecko_coin` varchar(45) DEFAULT NULL,
  `coingecko_src_img` varchar(200) DEFAULT NULL,
  `dextool_constract` varchar(200) DEFAULT NULL,
  `dextool_src_img` varchar(200) DEFAULT NULL,
  `value_of_gift` varchar(50) NOT NULL,
  `value_of_gift_ref` varchar(50) DEFAULT NULL,
  `brand_of_gift_one_task` decimal(32,18) DEFAULT NULL,
  `dollar_of_gift_one_task` decimal(32,18) DEFAULT NULL,
  `poocoin_constract` varchar(200) DEFAULT NULL,
  `poocoin_src_img` varchar(200) DEFAULT NULL,
  `src_img_claim` varchar(200) DEFAULT NULL,
  `subscribe_youtube` varchar(45) DEFAULT NULL,
  `follow_facebook` varchar(45) DEFAULT NULL,
  `follow_instagram` varchar(45) DEFAULT NULL,
  `follow_medium` varchar(45) DEFAULT NULL,
  `follow_discord` varchar(45) DEFAULT NULL,
  `register_account` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`airdrop_id`),
  UNIQUE KEY `tele_username_bot_UNIQUE` (`tele_username_bot`),
  UNIQUE KEY `tele_token_UNIQUE` (`tele_token`),
  CONSTRAINT `fk_config_bot_airdrop` FOREIGN KEY (`airdrop_id`) REFERENCES `bot` (`airdrop_id`) ON UPDATE CASCADE
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

-- Dump completed on 2025-08-21 10:23:01
