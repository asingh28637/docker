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
-- Table structure for table `stakes_user`
--

DROP TABLE IF EXISTS `stakes_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stakes_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `member_id` bigint unsigned NOT NULL,
  `uid` varchar(64) NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `lock_days` int unsigned NOT NULL,
  `apr_base` decimal(9,6) NOT NULL,
  `currency_id` varchar(20) NOT NULL,
  `amount` decimal(36,18) NOT NULL,
  `reward` decimal(36,18) DEFAULT NULL,
  `status` enum('pending','staked','redeemed','canceled') NOT NULL DEFAULT 'staked',
  `started_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `unlock_at` datetime NOT NULL,
  `idempotency_key` varchar(64) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_idem` (`member_id`,`idempotency_key`),
  UNIQUE KEY `uq_uid` (`uid`,`idempotency_key`),
  KEY `fk_stake_product` (`product_id`),
  KEY `idx_user_status` (`member_id`,`status`),
  KEY `idx_member_unlock` (`member_id`,`unlock_at`),
  KEY `idx_unlock_status` (`unlock_at`,`status`),
  KEY `idx_started` (`started_at`),
  CONSTRAINT `fk_stake_product` FOREIGN KEY (`product_id`) REFERENCES `staking_products` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_amount_pos` CHECK ((`amount` > 0)),
  CONSTRAINT `chk_unlock_not_earlier` CHECK ((`unlock_at` >= `started_at`))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-10  9:15:13
