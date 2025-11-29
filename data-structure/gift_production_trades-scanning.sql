CREATE DATABASE  IF NOT EXISTS `gift_production` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gift_production`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 185.100.233.95    Database: gift_production
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
-- Table structure for table `trades-scanning`
--

DROP TABLE IF EXISTS `trades-scanning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trades-scanning` (
  `id` varchar(100) NOT NULL,
  `trade_id` bigint NOT NULL,
  `price` decimal(32,16) NOT NULL,
  `amount` decimal(32,16) NOT NULL,
  `total` decimal(32,16) NOT NULL DEFAULT '0.0000000000000000',
  `maker_order_id` bigint NOT NULL,
  `taker_order_id` bigint NOT NULL,
  `market_id` varchar(20) NOT NULL,
  `market_base_unit` varchar(20) DEFAULT NULL,
  `market_quote_unit` varchar(20) DEFAULT NULL,
  `maker_id` bigint NOT NULL,
  `taker_id` bigint NOT NULL,
  `taker_type` varchar(20) NOT NULL DEFAULT '',
  `scan_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trade_id_UNIQUE` (`trade_id`),
  KEY `index_trades_on_maker_order_id` (`maker_order_id`) USING BTREE,
  KEY `index_trades_on_taker_order_id` (`taker_order_id`) USING BTREE,
  KEY `index_trades_on_market_id_and_created_at` (`market_id`,`scan_at`),
  KEY `index_trades_on_created_at` (`scan_at`),
  KEY `index_trades_on_maker_id` (`maker_id`),
  KEY `index_trades_on_taker_id` (`taker_id`),
  KEY `index_trades_on_taker_type` (`taker_type`)
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

-- Dump completed on 2025-10-10  9:19:28
