CREATE DATABASE  IF NOT EXISTS `wallet_production` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `wallet_production`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 185.100.233.95    Database: wallet_production
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
-- Table structure for table `withdraw_email_jobs`
--

DROP TABLE IF EXISTS `withdraw_email_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdraw_email_jobs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `withdraw_history_id` bigint NOT NULL,
  `member_id` bigint NOT NULL,
  `uid` varchar(45) NOT NULL,
  `withdraw_currency` varchar(50) NOT NULL,
  `withdraw_amount` decimal(38,14) NOT NULL,
  `fee_amount` decimal(38,14) NOT NULL,
  `fee_currency` varchar(50) NOT NULL,
  `txid` varchar(128) DEFAULT NULL,
  `tid` varchar(64) NOT NULL,
  `rid` varchar(512) NOT NULL,
  `status` enum('pending','sent','failed') DEFAULT 'pending',
  `retry_count` int DEFAULT '0',
  `last_attempt_at` datetime(3) DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `withdraw_history_id` (`withdraw_history_id`),
  UNIQUE KEY `uniq_withdraw_history_id` (`withdraw_history_id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_fee_currency` (`fee_currency`),
  KEY `idx_member_id` (`member_id`),
  KEY `idx_status_retry` (`status`,`retry_count`),
  KEY `idx_withdraw_currency` (`withdraw_currency`)
) ENGINE=InnoDB AUTO_INCREMENT=804 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-10  9:20:17
