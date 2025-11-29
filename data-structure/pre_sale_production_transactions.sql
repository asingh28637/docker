CREATE DATABASE  IF NOT EXISTS `pre_sale_production` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pre_sale_production`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 185.100.233.95    Database: pre_sale_production
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
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for each transaction',
  `member_id` bigint NOT NULL COMMENT 'ID of the member making the transaction',
  `user_id` varchar(50) NOT NULL COMMENT 'ID of the user making the transaction',
  `project_id` int NOT NULL COMMENT 'ID of the project involved in the transaction',
  `method_id` int NOT NULL COMMENT 'ID of the payment method used',
  `payment_details` json DEFAULT NULL,
  `bonus_id` int DEFAULT NULL COMMENT 'ID of the applied bonus (NULL if no bonus applied)',
  `bonus_details` json DEFAULT NULL,
  `amount` decimal(34,18) NOT NULL COMMENT 'Amount paid in the payment token',
  `bonus_received` decimal(34,18) DEFAULT NULL COMMENT 'Bonus tokens received for the transaction',
  `total_tokens_received` decimal(34,18) DEFAULT NULL COMMENT 'Total tokens received (purchase + bonus)',
  `purchase_amount` decimal(34,18) DEFAULT NULL COMMENT 'Purchase amount without bonuses applied',
  `status` enum('pending','completed','failed','cancelled') NOT NULL DEFAULT 'pending' COMMENT 'Status of the transaction',
  `error` text,
  `is_bot` tinyint DEFAULT '0',
  `transaction_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Time when the transaction occurred',
  PRIMARY KEY (`transaction_id`),
  KEY `idx_project_id` (`project_id`),
  KEY `idx_member_id` (`member_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_method_id` (`method_id`),
  KEY `idx_bonus_id` (`bonus_id`),
  CONSTRAINT `fk_transactions_bonus` FOREIGN KEY (`bonus_id`) REFERENCES `coin_bonus` (`bonus_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_transactions_payment_method` FOREIGN KEY (`method_id`) REFERENCES `payment_methods` (`method_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_transactions_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON DELETE CASCADE
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

-- Dump completed on 2025-10-10  9:17:58
