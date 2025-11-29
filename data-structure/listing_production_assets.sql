CREATE DATABASE  IF NOT EXISTS `listing_production` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `listing_production`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 185.100.233.95    Database: listing_production
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
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pack_id` varchar(45) DEFAULT NULL,
  `member_id` bigint NOT NULL,
  `name` varchar(500) NOT NULL,
  `contact` varchar(500) NOT NULL,
  `telegram_id` varchar(500) DEFAULT NULL,
  `token_name` varchar(500) NOT NULL,
  `token_ticker` varchar(500) DEFAULT NULL,
  `token_type` varchar(500) NOT NULL,
  `token_address` varchar(500) DEFAULT NULL,
  `website` varchar(500) DEFAULT NULL,
  `explorer_address` varchar(500) DEFAULT NULL,
  `logo_url` varchar(500) DEFAULT NULL,
  `coin_gekko_url` varchar(500) DEFAULT NULL,
  `coin_marketcap_url` varchar(500) DEFAULT NULL,
  `twitter_url` varchar(500) DEFAULT NULL,
  `telegram_group` varchar(500) DEFAULT NULL,
  `discord_channel` varchar(500) DEFAULT NULL,
  `bitcointalk_post` varchar(500) DEFAULT NULL,
  `github_url` varchar(500) DEFAULT NULL,
  `api_endpoint` varchar(45) DEFAULT NULL,
  `other_listed` varchar(500) DEFAULT NULL,
  `selected_market` varchar(500) DEFAULT NULL,
  `asset_description` varchar(500) DEFAULT NULL,
  `fee_number` varchar(45) DEFAULT NULL,
  `fee_currency` varchar(45) DEFAULT NULL,
  `status` varchar(100) NOT NULL DEFAULT 'processing',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
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

-- Dump completed on 2025-10-10  9:16:23
