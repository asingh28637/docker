CREATE DATABASE  IF NOT EXISTS `stake_production` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `stake_production`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 185.100.233.95    Database: stake_production
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
-- Table structure for table `staking_products`
--

DROP TABLE IF EXISTS `staking_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staking_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(40) NOT NULL,
  `currency_id` varchar(20) NOT NULL,
  `kind` enum('locked') NOT NULL DEFAULT 'locked',
  `host_uid` varchar(64) NOT NULL,
  `host_id` int NOT NULL,
  `pool_size` decimal(36,18) NOT NULL DEFAULT '0.000000000000000000',
  `pool_filled` decimal(36,18) NOT NULL DEFAULT '0.000000000000000000',
  `lock_days` int unsigned NOT NULL,
  `apr_base` decimal(9,6) NOT NULL,
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `min_amount` decimal(36,18) NOT NULL DEFAULT '0.000000000000000000',
  `max_amount` decimal(36,18) DEFAULT NULL,
  `status` enum('active','paused','retired') NOT NULL DEFAULT 'active',
  `metadata` json DEFAULT NULL,
  `table_position` int DEFAULT NULL,
  `carousel_position` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_prod_code` (`code`),
  KEY `idx_prod_currency_status` (`currency_id`,`status`),
  KEY `idx_prod_term` (`lock_days`,`status`),
  CONSTRAINT `chk_apr_nonneg` CHECK ((`apr_base` >= 0)),
  CONSTRAINT `chk_minmax_amount` CHECK (((`max_amount` is null) or (`max_amount` >= `min_amount`)))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-10  9:15:09
