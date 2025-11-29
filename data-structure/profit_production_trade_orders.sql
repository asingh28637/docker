CREATE DATABASE  IF NOT EXISTS `profit_production` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `profit_production`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 185.100.233.95    Database: profit_production
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
-- Table structure for table `trade_orders`
--

DROP TABLE IF EXISTS `trade_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trade_orders` (
  `trade_id` bigint NOT NULL,
  `trade_price` decimal(32,16) NOT NULL,
  `trade_amount` decimal(32,16) NOT NULL,
  `trade_total` decimal(32,16) NOT NULL DEFAULT '0.0000000000000000',
  `maker_order_id` bigint NOT NULL,
  `taker_order_id` bigint NOT NULL,
  `trade_market_id` varchar(20) NOT NULL,
  `maker_id` bigint NOT NULL,
  `taker_id` bigint NOT NULL,
  `maker_uid` varchar(32) DEFAULT NULL,
  `taker_uid` varchar(32) DEFAULT NULL,
  `taker_type` varchar(20) NOT NULL DEFAULT '',
  `trade_created_at` datetime(3) NOT NULL,
  `trade_updated_at` datetime(3) NOT NULL,
  `maker_order_snapshot` json NOT NULL,
  `taker_order_snapshot` json NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`trade_id`),
  KEY `idx_trade_maker_order_id` (`maker_order_id`),
  KEY `idx_trade_taker_order_id` (`taker_order_id`),
  KEY `idx_trade_market_created` (`trade_market_id`,`trade_created_at`),
  KEY `idx_trade_maker_id` (`maker_id`),
  KEY `idx_trade_taker_id` (`taker_id`),
  KEY `idx_trade_taker_type` (`taker_type`),
  KEY `idx_trade_created_at` (`trade_created_at`),
  KEY `idx_trade_updated_at` (`trade_updated_at`),
  KEY `idx_trade_maker_uid` (`maker_uid`),
  KEY `idx_trade_taker_uid` (`taker_uid`),
  KEY `idx_trade_maker_uid_created` (`maker_uid`,`trade_created_at`),
  KEY `idx_trade_taker_uid_created` (`taker_uid`,`trade_created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-10  9:18:30
