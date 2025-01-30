CREATE DATABASE  IF NOT EXISTS `rufrent` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `rufrent`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: rufrent
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `dy_amenities`
--

DROP TABLE IF EXISTS `dy_amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dy_amenities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amenity` int DEFAULT NULL,
  `community` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `ammenity_fk_id_idx` (`amenity`),
  KEY `community_fk_id_idx` (`community`),
  CONSTRAINT `ammenity_fk_id` FOREIGN KEY (`amenity`) REFERENCES `st_amenities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `community_fk_id` FOREIGN KEY (`community`) REFERENCES `st_community` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for amenities percommunity';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dy_amenities`
--

LOCK TABLES `dy_amenities` WRITE;
/*!40000 ALTER TABLE `dy_amenities` DISABLE KEYS */;
INSERT INTO `dy_amenities` VALUES (1,1,10),(2,43,2),(3,2,5),(4,42,9),(5,6,1),(6,29,8),(7,7,6),(8,28,4),(9,16,3),(10,17,7),(11,29,5),(12,2,4),(13,42,3),(14,1,2),(15,43,1),(16,16,7),(17,6,2),(18,28,5),(19,7,6),(20,6,8),(21,17,9),(22,6,3),(23,17,4),(24,43,7),(25,2,9),(26,2,6),(27,2,6),(28,3,6),(29,5,6),(30,1,NULL),(31,2,NULL),(32,3,NULL),(33,1,34),(34,2,34),(35,3,34),(36,3,35),(37,2,35),(38,1,35),(39,3,36),(40,2,36),(41,1,36),(42,5,36),(43,2,8),(44,3,8),(45,5,8),(46,1,3),(47,1,10),(48,43,10),(49,6,10),(50,3,10),(51,2,10),(52,1,10);
/*!40000 ALTER TABLE `dy_amenities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dy_landmarks`
--

DROP TABLE IF EXISTS `dy_landmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dy_landmarks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `landmark_name` varchar(60) DEFAULT NULL,
  `distance` double DEFAULT NULL,
  `landmark_category_id` int DEFAULT NULL,
  `community_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_landmark_cat_id_idx` (`landmark_category_id`),
  KEY `fk_community_id_idx` (`community_id`),
  CONSTRAINT `fk_community_id` FOREIGN KEY (`community_id`) REFERENCES `st_community` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_landmark_cat_id` FOREIGN KEY (`landmark_category_id`) REFERENCES `st_landmarks_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table For Landmarks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dy_landmarks`
--

LOCK TABLES `dy_landmarks` WRITE;
/*!40000 ALTER TABLE `dy_landmarks` DISABLE KEYS */;
INSERT INTO `dy_landmarks` VALUES (1,'Oakridge International School',4.1,1,1),(2,'Delhi World School',1.6,1,7),(3,'Continental Hospitals',2.4,3,3),(4,'Inorbit Mall',1.6,2,5),(5,'CARE Hospitals',1.3,3,6),(6,'Phoenix Greens International School',0.8,1,7),(7,'Sri Mohana Krishna Sannidhi',0.7,7,8),(8,'Raidurg Metro Station Indira Nagar',1.5,4,9),(9,'Jain Heritage A Cambridge School',2.1,1,10),(10,'American Laser Eye Hospital',1.9,3,21),(11,'Infinity World School',0.8,1,22),(12,'Sreenidhi High School',1.6,1,23),(13,'Marrichettu Junction Bus Stop',1.6,6,26),(14,'Marrichettu Junction Bus Stop',1.6,6,27),(15,'villa',6,4,3),(16,'Sunshine Park',2,1,NULL),(17,'City Mall',5,2,NULL),(18,'Sunshine Park',2,1,34),(19,'City Mall',5,2,34),(20,'Sunshine Park',2.5,4,35),(21,'City Mall',5.5,5,35),(22,'Sunshine Park',2.5,4,36),(23,'City Mall',5.5,5,36),(24,'villa',6,4,1),(25,'Infinity World School',0.8,1,35),(26,'Infinity World School',0.8,1,20),(27,'villa',6,4,7),(28,'Oakridge International School',4.1,1,7);
/*!40000 ALTER TABLE `dy_landmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dy_orders_history`
--

DROP TABLE IF EXISTS `dy_orders_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dy_orders_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` varchar(50) NOT NULL,
  `user_id` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `time` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `dy_orders_history_ibfk_1` (`user_id`),
  CONSTRAINT `dy_orders_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dy_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dy_orders_history`
--

LOCK TABLES `dy_orders_history` WRITE;
/*!40000 ALTER TABLE `dy_orders_history` DISABLE KEYS */;
INSERT INTO `dy_orders_history` VALUES (1,'order_PmojJo5PxIdUb3',1,500,'2025-01-23 13:52:23'),(2,'order_PmoonZt8GEQLo0',2,300,'2025-01-23 13:57:34'),(3,'order_Pmopve82uMNHQP',2,500,'2025-01-23 13:58:39'),(4,'order_PmotrsEoaEwQ1X',2,500,'2025-01-23 14:02:22'),(5,'order_PnY562n4oAna8J',1,500,'2025-01-25 10:14:13'),(6,'order_PnY65694Ga1VUk',1,500,'2025-01-25 10:15:09'),(7,'order_PnY7EeZH5dLzAs',1,500,'2025-01-25 10:16:14'),(8,'order_PnZgprbxJAdfel',2,500,'2025-01-25 11:48:38');
/*!40000 ALTER TABLE `dy_orders_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dy_payments_info`
--

DROP TABLE IF EXISTS `dy_payments_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dy_payments_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `property_id` int NOT NULL,
  `payment_id` varchar(100) NOT NULL,
  `order_id` varchar(100) NOT NULL,
  `amount` decimal(7,2) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `status` varchar(50) NOT NULL,
  `payment_data` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_order_id` (`order_id`),
  CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `dy_orders_history` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dy_payments_info`
--

LOCK TABLES `dy_payments_info` WRITE;
/*!40000 ALTER TABLE `dy_payments_info` DISABLE KEYS */;
INSERT INTO `dy_payments_info` VALUES (1,43,53,'pay_Pmop0KEn6iUJJt','order_PmoonZt8GEQLo0',300.00,'INR','captured','{\"id\": \"pay_Pmop0KEn6iUJJt\", \"fee\": 708, \"tax\": 108, \"vpa\": null, \"bank\": \"BARB_R\", \"email\": \"testing@qtiminds.com\", \"notes\": [], \"amount\": 30000, \"entity\": \"payment\", \"method\": \"netbanking\", \"status\": \"captured\", \"wallet\": null, \"card_id\": null, \"contact\": \"+91123456789\", \"captured\": true, \"currency\": \"INR\", \"order_id\": \"order_PmoonZt8GEQLo0\", \"created_at\": 1737620867, \"error_code\": null, \"error_step\": null, \"invoice_id\": null, \"description\": \"Testing the payment method\", \"error_reason\": null, \"error_source\": null, \"acquirer_data\": {\"bank_transaction_id\": \"1275818\"}, \"international\": false, \"refund_status\": null, \"amount_refunded\": 0, \"error_description\": null}','2025-01-23 08:27:47','2025-01-23 08:28:03'),(2,43,53,'pay_PmoqQVHdH7q29h','order_Pmopve82uMNHQP',500.00,'INR','captured','{\"id\": \"pay_PmoqQVHdH7q29h\", \"fee\": 1180, \"tax\": 180, \"vpa\": null, \"bank\": \"CNRB\", \"email\": \"testing@qtiminds.com\", \"notes\": [], \"amount\": 50000, \"entity\": \"payment\", \"method\": \"netbanking\", \"status\": \"captured\", \"wallet\": null, \"card_id\": null, \"contact\": \"+91123456789\", \"captured\": true, \"currency\": \"INR\", \"order_id\": \"order_Pmopve82uMNHQP\", \"created_at\": 1737620947, \"error_code\": null, \"error_step\": null, \"invoice_id\": null, \"description\": \"Testing the payment method\", \"error_reason\": null, \"error_source\": null, \"acquirer_data\": {\"bank_transaction_id\": \"8725186\"}, \"international\": false, \"refund_status\": null, \"amount_refunded\": 0, \"error_description\": null}','2025-01-23 08:29:07','2025-01-23 08:29:24'),(3,43,53,'pay_PmotxSNwN56C9U','order_PmotrsEoaEwQ1X',500.00,'INR','captured','{\"id\": \"pay_PmotxSNwN56C9U\", \"fee\": 1180, \"tax\": 180, \"vpa\": null, \"bank\": \"UTBI\", \"email\": \"testing@qtiminds.com\", \"notes\": [], \"amount\": 50000, \"entity\": \"payment\", \"method\": \"netbanking\", \"status\": \"captured\", \"wallet\": null, \"card_id\": null, \"contact\": \"+91123456789\", \"captured\": true, \"currency\": \"INR\", \"order_id\": \"order_PmotrsEoaEwQ1X\", \"created_at\": 1737621148, \"error_code\": null, \"error_step\": null, \"invoice_id\": null, \"description\": \"Testing the payment method\", \"error_reason\": null, \"error_source\": null, \"acquirer_data\": {\"bank_transaction_id\": \"6304007\"}, \"international\": false, \"refund_status\": null, \"amount_refunded\": 0, \"error_description\": null}','2025-01-23 08:32:28','2025-01-23 08:32:45'),(4,43,53,'pay_PnY6l2dRNP8ccR','order_PnY65694Ga1VUk',500.00,'INR','captured','{\"id\": \"pay_PnY6l2dRNP8ccR\", \"fee\": 1000, \"tax\": 0, \"vpa\": null, \"bank\": null, \"card\": {\"id\": \"card_PnY6lAPpZ0a5yO\", \"emi\": false, \"name\": \"\", \"type\": \"prepaid\", \"last4\": \"1111\", \"entity\": \"card\", \"issuer\": null, \"network\": \"Visa\", \"sub_type\": \"consumer\", \"token_iin\": null, \"international\": false}, \"email\": \"testing@qtiminds.com\", \"notes\": [], \"amount\": 50000, \"entity\": \"payment\", \"method\": \"card\", \"status\": \"captured\", \"wallet\": null, \"card_id\": \"card_PnY6lAPpZ0a5yO\", \"contact\": \"+91123456789\", \"captured\": true, \"currency\": \"INR\", \"order_id\": \"order_PnY65694Ga1VUk\", \"created_at\": 1737780348, \"error_code\": null, \"error_step\": null, \"invoice_id\": null, \"description\": \"Testing the payment method\", \"error_reason\": null, \"error_source\": null, \"acquirer_data\": {\"auth_code\": \"813837\"}, \"international\": false, \"refund_status\": null, \"amount_refunded\": 0, \"error_description\": null}','2025-01-25 04:45:48','2025-01-25 04:46:08'),(5,43,53,'pay_PnZgv79499Xrbe','order_PnZgprbxJAdfel',500.00,'INR','captured','{\"id\": \"pay_PnZgv79499Xrbe\", \"fee\": 1180, \"tax\": 180, \"vpa\": null, \"bank\": \"BARB_R\", \"email\": \"testing@qtiminds.com\", \"notes\": [], \"amount\": 50000, \"entity\": \"payment\", \"method\": \"netbanking\", \"status\": \"captured\", \"wallet\": null, \"card_id\": null, \"contact\": \"+91123456789\", \"captured\": true, \"currency\": \"INR\", \"order_id\": \"order_PnZgprbxJAdfel\", \"created_at\": 1737785923, \"error_code\": null, \"error_step\": null, \"invoice_id\": null, \"description\": \"Testing the payment method\", \"error_reason\": null, \"error_source\": null, \"acquirer_data\": {\"bank_transaction_id\": \"1391283\"}, \"international\": false, \"refund_status\": null, \"amount_refunded\": 0, \"error_description\": null}','2025-01-25 06:18:43','2025-01-25 06:18:59');
/*!40000 ALTER TABLE `dy_payments_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dy_property`
--

DROP TABLE IF EXISTS `dy_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dy_property` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `prop_type_id` int DEFAULT NULL,
  `home_type_id` int DEFAULT NULL,
  `prop_desc_id` int DEFAULT NULL,
  `community_id` int DEFAULT NULL,
  `no_beds` int DEFAULT NULL,
  `no_baths` int DEFAULT NULL,
  `no_balconies` varchar(10) DEFAULT NULL,
  `tenant_type_id` int DEFAULT NULL,
  `tenant_eat_pref_id` int DEFAULT NULL,
  `parking_type_id` int DEFAULT NULL,
  `parking_count_id` int DEFAULT NULL,
  `deposit_range_id` int DEFAULT NULL,
  `gender_pref` int DEFAULT NULL,
  `availabl_date` datetime DEFAULT NULL,
  `current_status` int DEFAULT '1',
  `tower_no` int DEFAULT NULL,
  `floor_no` int DEFAULT NULL,
  `flat_no` int DEFAULT NULL,
  `images_location` text,
  `rec_add_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `rec_last_update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rental_low` double DEFAULT NULL,
  `maintenance_id` tinyint DEFAULT NULL,
  `rental_high` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `prop_fk_user_id_idx` (`user_id`),
  KEY `prop_fk_prop_type_id_idx` (`prop_type_id`),
  KEY `prop_fk_prop_desc_id_idx` (`prop_desc_id`),
  KEY `prop_fk_home_type_id_idx` (`home_type_id`),
  KEY `prop_fk_comm_id_idx` (`community_id`),
  KEY `prop_fk_bed_id_idx` (`no_beds`),
  KEY `prop_fk_bath_id_idx` (`no_baths`),
  KEY `prop_fk_balcony_id_idx` (`no_balconies`),
  KEY `prop_fk_user_type_id_idx` (`tenant_type_id`),
  KEY `prop_fk_tenant_eat_pref_id_idx` (`tenant_eat_pref_id`),
  KEY `prop_fk_park_type_id_idx` (`parking_type_id`),
  KEY `prop_fk_park_count_idx` (`parking_count_id`),
  KEY `prop_fk_dep_id_idx` (`deposit_range_id`),
  KEY `prop_gen_pref_id_idx` (`gender_pref`),
  KEY `prop_fk_current_status_id_idx` (`current_status`),
  KEY `prop_fk_maint_id_idx` (`maintenance_id`),
  CONSTRAINT `prop_fk_bath_id` FOREIGN KEY (`no_baths`) REFERENCES `st_baths` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prop_fk_bed_id` FOREIGN KEY (`no_beds`) REFERENCES `st_beds` (`id`),
  CONSTRAINT `prop_fk_comm_id` FOREIGN KEY (`community_id`) REFERENCES `st_community` (`id`),
  CONSTRAINT `prop_fk_current_status_id` FOREIGN KEY (`current_status`) REFERENCES `st_current_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prop_fk_dep_id` FOREIGN KEY (`deposit_range_id`) REFERENCES `st_deposit_range` (`id`),
  CONSTRAINT `prop_fk_gen_pref_id` FOREIGN KEY (`gender_pref`) REFERENCES `st_gender` (`id`),
  CONSTRAINT `prop_fk_home_type_id` FOREIGN KEY (`home_type_id`) REFERENCES `st_home_type` (`id`),
  CONSTRAINT `prop_fk_park_count` FOREIGN KEY (`parking_count_id`) REFERENCES `st_parking_count` (`id`),
  CONSTRAINT `prop_fk_park_type_id` FOREIGN KEY (`parking_type_id`) REFERENCES `st_parking_type` (`id`),
  CONSTRAINT `prop_fk_prop_desc_id` FOREIGN KEY (`prop_desc_id`) REFERENCES `st_prop_desc` (`id`),
  CONSTRAINT `prop_fk_prop_type_id` FOREIGN KEY (`prop_type_id`) REFERENCES `st_prop_type` (`id`),
  CONSTRAINT `prop_fk_tenant_eat_pref_id` FOREIGN KEY (`tenant_eat_pref_id`) REFERENCES `st_tenant_eat_pref` (`id`),
  CONSTRAINT `prop_fk_tenant_type_id` FOREIGN KEY (`tenant_type_id`) REFERENCES `st_tenant` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Property Data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dy_property`
--

LOCK TABLES `dy_property` WRITE;
/*!40000 ALTER TABLE `dy_property` DISABLE KEYS */;
INSERT INTO `dy_property` VALUES (1,3,1,1,1,7,1,1,'1',1,1,1,1,1,NULL,'2025-01-01 00:00:00',3,1,1,1,'','2024-12-18 07:35:06','2025-01-27 04:30:07',1,1,1),(2,2,2,2,2,3,2,2,'2',2,2,2,2,2,NULL,'2025-02-01 00:00:00',24,2,2,2,NULL,'2024-12-18 07:35:06','2025-01-09 04:59:26',1,2,1),(3,1,3,2,3,2,6,4,'5',2,2,NULL,3,5,NULL,'2025-01-01 00:00:00',NULL,2,3,5,'','2024-12-19 11:15:14','2024-12-19 11:15:14',1,1,1),(4,1,3,2,3,2,6,4,'5',2,2,NULL,3,5,NULL,'2025-01-01 00:00:00',24,2,3,5,'','2024-12-19 11:16:23','2025-01-07 10:00:19',1,1,1),(5,1,3,2,3,2,6,4,'5',2,2,NULL,3,5,NULL,'2025-01-01 00:00:00',NULL,2,3,5,NULL,'2024-12-19 11:18:07','2024-12-19 11:18:07',1,1,1),(6,2,3,2,3,2,6,4,'5',2,2,NULL,3,5,NULL,'2025-01-01 00:00:00',NULL,2,3,5,NULL,'2024-12-19 11:19:52','2024-12-19 11:19:52',1,1,1),(7,2,3,5,3,2,6,4,'5',2,2,NULL,3,5,NULL,'2025-01-01 00:00:00',NULL,2,3,5,NULL,'2024-12-20 05:30:46','2024-12-20 05:30:46',1,1,1),(8,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-20 09:12:52','2024-12-20 09:12:52',NULL,NULL,NULL),(9,2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-20 09:14:29','2024-12-20 09:14:29',NULL,NULL,NULL),(10,1,2,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-20 09:17:36','2024-12-20 09:17:36',NULL,NULL,NULL),(11,1,2,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-20 09:19:47','2024-12-20 09:19:47',NULL,NULL,NULL),(12,1,2,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-20 09:21:07','2024-12-20 09:21:07',NULL,NULL,NULL),(13,3,2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-20 09:24:38','2024-12-20 09:24:38',NULL,NULL,NULL),(14,3,3,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-20 09:25:05','2024-12-20 09:25:05',NULL,NULL,NULL),(15,3,3,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-20 09:27:05','2024-12-20 09:27:05',NULL,NULL,NULL),(16,2,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-20 10:01:05','2024-12-20 10:01:05',NULL,NULL,NULL),(17,1,NULL,NULL,NULL,1,NULL,1,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,'2024-12-27 02:56:34','2024-12-27 02:56:34',10000,NULL,1),(18,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 04:09:09','2024-12-27 04:09:09',NULL,NULL,1),(19,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 04:31:00','2024-12-27 04:31:00',NULL,NULL,1),(20,1,NULL,NULL,NULL,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,'2024-12-27 06:08:19','2024-12-27 06:08:19',1000,NULL,1),(21,1,NULL,NULL,NULL,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,'2024-12-27 06:10:41','2024-12-27 06:10:41',1000,NULL,1),(22,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 06:19:12','2024-12-27 06:19:12',NULL,NULL,1),(23,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 06:19:42','2024-12-27 06:19:42',NULL,NULL,1),(24,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 06:29:08','2024-12-27 06:29:08',NULL,NULL,1),(25,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 06:52:00','2024-12-27 06:52:00',NULL,NULL,1),(26,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 06:55:53','2024-12-27 06:55:53',NULL,NULL,NULL),(27,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 06:57:31','2024-12-27 06:57:31',NULL,NULL,NULL),(28,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 07:00:58','2024-12-27 07:00:58',NULL,NULL,NULL),(29,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 07:06:35','2024-12-27 07:06:35',NULL,NULL,NULL),(30,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 07:07:21','2024-12-27 07:07:21',NULL,NULL,NULL),(33,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 07:09:07','2024-12-27 07:09:07',NULL,NULL,NULL),(34,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 07:17:34','2024-12-27 07:17:34',NULL,NULL,NULL),(35,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 07:19:47','2024-12-27 07:19:47',NULL,NULL,NULL),(36,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 07:24:03','2024-12-27 07:24:03',NULL,NULL,NULL),(37,1,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 07:27:50','2024-12-27 07:27:50',NULL,NULL,NULL),(38,1,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 10:29:46','2024-12-27 10:29:46',NULL,NULL,NULL),(39,1,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 10:58:46','2024-12-27 10:58:46',NULL,NULL,NULL),(40,1,2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 10:59:46','2024-12-27 10:59:46',NULL,NULL,NULL),(41,1,2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 11:00:19','2024-12-27 11:00:19',NULL,NULL,NULL),(42,1,2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 11:13:56','2024-12-27 11:13:56',NULL,NULL,NULL),(43,1,2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 11:18:55','2024-12-27 11:18:55',NULL,NULL,NULL),(44,1,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 11:19:31','2024-12-27 11:19:31',NULL,NULL,NULL),(45,1,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 11:24:17','2024-12-27 11:24:17',NULL,NULL,NULL),(46,1,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-27 11:26:56','2024-12-27 11:26:56',NULL,NULL,NULL),(47,1,1,1,1,1,NULL,1,'1',1,1,NULL,1,NULL,NULL,NULL,NULL,1,2,2,NULL,'2024-12-27 13:23:49','2024-12-27 13:23:49',25,NULL,NULL),(58,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-01-10 14:25:35','2025-01-10 14:25:35',NULL,NULL,NULL),(59,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-01-10 14:26:56','2025-01-10 14:26:56',NULL,NULL,NULL),(60,3,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-01-10 14:30:22','2025-01-10 14:40:48',NULL,NULL,NULL),(61,1,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-01-13 02:13:12','2025-01-13 02:13:12',NULL,NULL,NULL),(62,1,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-01-13 02:14:58','2025-01-13 02:14:58',NULL,NULL,NULL),(63,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-01-13 02:25:46','2025-01-13 02:25:46',NULL,NULL,NULL),(64,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-01-13 02:29:19','2025-01-13 02:29:19',NULL,NULL,NULL),(65,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-01-13 05:35:31','2025-01-13 05:35:31',NULL,NULL,NULL),(67,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-01-16 10:21:52','2025-01-16 10:21:52',NULL,NULL,NULL),(68,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-01-16 10:31:08','2025-01-16 10:31:08',NULL,NULL,NULL),(69,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-02-21 10:57:21','2025-01-25 04:20:26',NULL,NULL,NULL),(70,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-01-25 10:23:50','2025-01-25 10:23:50',NULL,NULL,NULL),(71,1,2,3,NULL,4,2,2,'1',5,1,2,1,3,1,'2025-01-31 00:00:00',1,10,5,503,NULL,'2025-01-28 09:11:25','2025-01-28 09:11:25',10000,NULL,15000),(72,1,2,3,1,4,2,2,'1',5,1,NULL,1,NULL,NULL,NULL,1,10,5,503,NULL,'2025-01-28 09:40:14','2025-01-28 09:40:14',10000,1,15000);
/*!40000 ALTER TABLE `dy_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dy_refferal_history`
--

DROP TABLE IF EXISTS `dy_refferal_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dy_refferal_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `refferral_id` int DEFAULT NULL,
  `referral_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_user_ref_id_idx` (`user_id`),
  KEY `fk_user_refferal_id_idx` (`refferral_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Tracking Referral History';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dy_refferal_history`
--

LOCK TABLES `dy_refferal_history` WRITE;
/*!40000 ALTER TABLE `dy_refferal_history` DISABLE KEYS */;
INSERT INTO `dy_refferal_history` VALUES (1,5,12,'2025-01-01 10:00:00'),(2,3,7,'2025-01-05 10:05:00'),(3,8,4,'2025-01-08 10:10:00'),(4,10,6,'2025-01-05 10:15:00'),(5,2,9,'2025-01-07 10:20:00'),(6,1,11,'2025-01-03 10:25:00'),(7,13,3,'2025-01-02 10:30:00'),(8,7,14,'2025-01-01 10:35:00'),(9,4,5,'2025-01-03 10:40:00'),(10,12,2,'2025-01-06 10:45:00');
/*!40000 ALTER TABLE `dy_refferal_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dy_rm_fm_com_map`
--

DROP TABLE IF EXISTS `dy_rm_fm_com_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dy_rm_fm_com_map` (
  `id` int NOT NULL AUTO_INCREMENT,
  `community_id` int DEFAULT '-999',
  `rm_id` int DEFAULT '-9999',
  `fm_id` int DEFAULT '-99999',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_com_map_data_idx` (`community_id`),
  KEY `fk_rm_map_data_idx` (`rm_id`),
  KEY `fk_fm_map_data_idx` (`fm_id`),
  CONSTRAINT `fk_com_map_data` FOREIGN KEY (`community_id`) REFERENCES `st_community` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rm_map_data` FOREIGN KEY (`rm_id`) REFERENCES `dy_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Dynamic Table for Mapping RM and FM with Community';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dy_rm_fm_com_map`
--

LOCK TABLES `dy_rm_fm_com_map` WRITE;
/*!40000 ALTER TABLE `dy_rm_fm_com_map` DISABLE KEYS */;
INSERT INTO `dy_rm_fm_com_map` VALUES (1,1,5,9),(2,2,6,10),(3,3,7,11),(4,7,8,12);
/*!40000 ALTER TABLE `dy_rm_fm_com_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dy_services_details`
--

DROP TABLE IF EXISTS `dy_services_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dy_services_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `service_status` varchar(45) DEFAULT NULL,
  `service_start_date` datetime DEFAULT NULL,
  `service_end_date` datetime DEFAULT NULL,
  `service_Description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Services Details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dy_services_details`
--

LOCK TABLES `dy_services_details` WRITE;
/*!40000 ALTER TABLE `dy_services_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `dy_services_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dy_transactions`
--

DROP TABLE IF EXISTS `dy_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dy_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `prop_id` int DEFAULT NULL,
  `bp_id` int DEFAULT NULL,
  `svcs_id` int DEFAULT NULL,
  `tr_st_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `tr_upd_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `prev_stat_code` int DEFAULT '1',
  `cur_stat_code` int DEFAULT '1',
  `rm_id` int DEFAULT NULL,
  `fm_id` int DEFAULT NULL,
  `schedule_time` varchar(8) DEFAULT NULL,
  `schedule_date` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_user_dar_id_idx` (`user_id`),
  KEY `fk_prop_data_id_idx` (`prop_id`),
  KEY `fk_billing_data_id_idx` (`bp_id`),
  KEY `fk_service_data_id_idx` (`svcs_id`),
  KEY `fk_rm_tr_data_idx` (`rm_id`),
  KEY `fk_fm_tr_data_idx` (`fm_id`),
  KEY `fk_status_prev_code_idx` (`prev_stat_code`),
  KEY `fk_status_cur_code_idx` (`cur_stat_code`),
  CONSTRAINT `fk_billing_data_id` FOREIGN KEY (`bp_id`) REFERENCES `st_billing_plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_prop_data_id` FOREIGN KEY (`prop_id`) REFERENCES `dy_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rm_tr_data` FOREIGN KEY (`rm_id`) REFERENCES `dy_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_service_data_id` FOREIGN KEY (`svcs_id`) REFERENCES `dy_services_details` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_status_cur_code` FOREIGN KEY (`cur_stat_code`) REFERENCES `st_current_status` (`id`),
  CONSTRAINT `fk_status_prev_code` FOREIGN KEY (`prev_stat_code`) REFERENCES `st_current_status` (`id`),
  CONSTRAINT `fk_user_data_id` FOREIGN KEY (`user_id`) REFERENCES `dy_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for dynamic transactions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dy_transactions`
--

LOCK TABLES `dy_transactions` WRITE;
/*!40000 ALTER TABLE `dy_transactions` DISABLE KEYS */;
INSERT INTO `dy_transactions` VALUES (1,1,1,NULL,NULL,'2024-12-18 07:37:21','2025-01-18 03:53:54',1,3,7,9,'10:30:00','2024-12-18'),(2,2,2,NULL,NULL,'2024-12-18 07:38:04','2025-01-08 04:30:54',1,24,8,12,'12:30:00','2024-12-19'),(3,1,1,NULL,NULL,'2024-12-20 09:30:52','2024-12-20 09:30:52',1,1,NULL,NULL,NULL,NULL),(4,1,1,NULL,NULL,'2024-12-28 10:21:24','2024-12-28 10:21:24',1,1,5,NULL,NULL,NULL),(5,1,4,NULL,NULL,'2024-12-31 03:30:19','2025-01-07 10:00:19',1,24,NULL,11,NULL,NULL),(6,2,2,NULL,NULL,'2024-12-31 03:37:52','2024-12-31 03:37:52',1,1,7,NULL,NULL,NULL),(7,2,2,NULL,NULL,'2024-12-31 03:39:00','2024-12-31 03:39:00',1,1,8,NULL,NULL,NULL),(10,7,3,NULL,NULL,'2024-12-31 14:16:51','2024-12-31 14:16:51',1,1,NULL,NULL,NULL,NULL),(11,7,3,NULL,NULL,'2024-12-31 14:17:37','2024-12-31 14:17:37',1,1,NULL,NULL,NULL,NULL),(12,7,3,NULL,NULL,'2024-12-31 14:18:47','2024-12-31 14:18:47',1,1,NULL,NULL,NULL,NULL),(13,1,3,NULL,NULL,'2024-12-31 14:19:36','2024-12-31 14:19:36',1,1,NULL,NULL,NULL,NULL),(14,1,2,NULL,NULL,'2025-01-01 02:54:43','2025-01-01 02:54:43',1,1,7,NULL,NULL,NULL),(15,1,1,NULL,NULL,'2025-01-01 02:56:38','2025-01-01 02:56:38',1,1,6,NULL,NULL,NULL),(17,5,1,NULL,NULL,'2025-01-01 07:08:01','2025-01-02 09:02:25',1,1,6,NULL,'1:00','2024-12-23'),(18,1,6,NULL,NULL,'2025-01-06 03:51:14','2025-01-06 03:51:14',1,1,NULL,NULL,NULL,NULL),(19,2,5,NULL,NULL,'2025-01-09 10:19:46','2025-01-09 10:19:46',1,1,6,NULL,NULL,NULL),(20,2,5,NULL,NULL,'2025-01-11 08:18:20','2025-01-11 08:18:20',1,1,NULL,NULL,NULL,NULL),(21,2,5,NULL,NULL,'2025-01-11 08:22:20','2025-01-11 08:22:20',1,1,NULL,NULL,NULL,NULL),(22,2,5,NULL,NULL,'2025-01-11 08:26:14','2025-01-11 08:26:14',1,1,5,NULL,NULL,NULL),(23,2,5,NULL,NULL,'2025-01-11 08:26:22','2025-01-11 08:26:22',1,1,5,NULL,NULL,NULL),(24,2,5,NULL,NULL,'2025-01-11 08:26:27','2025-01-11 08:26:27',1,1,8,NULL,NULL,NULL),(25,2,6,NULL,NULL,'2025-01-11 08:43:57','2025-01-11 08:43:57',1,1,5,NULL,NULL,NULL),(26,2,7,NULL,NULL,'2025-01-11 09:48:31','2025-01-11 09:48:31',1,1,6,NULL,NULL,NULL),(27,2,8,NULL,NULL,'2025-01-13 02:29:43','2025-01-13 02:29:43',1,1,7,NULL,NULL,NULL),(28,2,10,NULL,NULL,'2025-01-13 05:35:50','2025-01-13 05:35:50',1,1,8,NULL,NULL,NULL),(29,2,11,NULL,NULL,'2025-01-13 11:00:49','2025-01-13 11:00:49',1,1,5,NULL,NULL,NULL),(30,2,12,NULL,NULL,'2025-01-16 10:30:58','2025-01-16 10:30:58',1,1,6,NULL,NULL,NULL);
/*!40000 ALTER TABLE `dy_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dy_user`
--

DROP TABLE IF EXISTS `dy_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dy_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) DEFAULT NULL,
  `user_name` varchar(45) DEFAULT NULL,
  `email_id` varchar(45) DEFAULT NULL,
  `mobile_no` varchar(15) DEFAULT NULL,
  `role_id` int DEFAULT '2',
  `permission_id` int DEFAULT '1',
  `ref_code` varchar(10) DEFAULT NULL,
  `mobile_verified` tinyint DEFAULT '0',
  `email_verified` tinyint DEFAULT '0',
  `passwd` varchar(512) DEFAULT NULL,
  `reconfirm_passwd` varchar(45) DEFAULT NULL,
  `passwd_exp_time` varchar(45) DEFAULT NULL,
  `signuptime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `gender_id` int DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bill_plan` int DEFAULT NULL,
  `rstatus` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_role_id_idx` (`role_id`),
  KEY `fk_perm_id_idx` (`permission_id`),
  KEY `fk_gender_id_idx` (`gender_id`),
  KEY `fk_bill_id_idx` (`bill_plan`),
  CONSTRAINT `fk_bill_id` FOREIGN KEY (`bill_plan`) REFERENCES `st_billing_plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_gender_id` FOREIGN KEY (`gender_id`) REFERENCES `st_gender` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_perm_id` FOREIGN KEY (`permission_id`) REFERENCES `st_permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `st_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dy_user`
--

LOCK TABLES `dy_user` WRITE;
/*!40000 ALTER TABLE `dy_user` DISABLE KEYS */;
INSERT INTO `dy_user` VALUES (1,NULL,'Asif','mdalsifraza820@gmail.com','9876543210',2,1,NULL,0,0,'$2b$10$wRnyGswtTou2NUIoOPmSpuHh5s/123vGv9kLT27/gvgUsbaO1dsQ2',NULL,NULL,NULL,NULL,'2025-01-02 09:48:59',NULL,1),(2,NULL,'Bheem','bheem@gmail.com','8765432190',2,1,NULL,0,0,'$2b$10$rKh0FCjsYY2J6T9VB893fuDIc/xr/./zwgCOPnoLg5IYRqnNYpCQu',NULL,NULL,NULL,NULL,'2025-01-11 08:45:38',NULL,1),(3,NULL,'Pavan','Pavan@gmail.com',NULL,2,1,NULL,0,0,'$2b$10$SlP3Zr/lvh4iqnmhNQQtUeDuWCki/L68uqJruCpX3OxfvWm41wxQW',NULL,NULL,NULL,NULL,NULL,NULL,1),(4,NULL,'Ganti','Ganti@gmail.com',NULL,2,1,NULL,0,0,'$2b$10$/O6u3giCUUoxdo2JhWxiheXlQ9jUnPNlfgwY9dlz0WBq/13/eW6Uy',NULL,NULL,NULL,NULL,NULL,NULL,1),(5,NULL,'Mani','Mani@gmail.com','6543210987',3,1,NULL,0,0,'$2b$10$IXodw6W/RWFca5Rig4p1nOP0/MyLGIRNHvh5wlWJnMgcjkf6N07Ei',NULL,NULL,NULL,NULL,'2025-01-11 08:46:35',NULL,1),(6,NULL,'Varun','Varun@gmail.com',NULL,3,1,NULL,0,0,'$2b$10$EThg84ONdXigbCXdKVHtjuSkEKgkusaZ51T/8Te5sO66RRowJPftW',NULL,NULL,NULL,NULL,'2024-12-18 06:43:28',NULL,1),(7,NULL,'Abhishek','Abhishek@gmail.com','1234567890',3,1,NULL,0,0,'$2b$10$ykmfsijZh.FICqBTqiAwF.Iqmw/UiHDLYv/dsTjIa.3ELEdqZj5JG',NULL,NULL,NULL,NULL,'2025-01-19 06:10:10',NULL,1),(8,NULL,'Paras','Paras@gmail.com',NULL,3,1,NULL,0,0,'$2b$10$15svyCx/eAKwrpW1uwKQfeRxystbkPJam7G1Cg5UC2XI4CLMIbtpO',NULL,NULL,NULL,NULL,'2024-12-18 06:43:28',NULL,1),(9,NULL,'Vijay','Vijay@gmail.com',NULL,4,1,NULL,0,0,'$2b$10$zgC7g1otD7gtQoKSMrRD5.4GvQ9pemPoTU.hwQ5ZRh8ouNZl2jfTa',NULL,NULL,NULL,NULL,'2024-12-18 06:43:28',NULL,1),(10,NULL,'Ashok','Ashok@gmail.com',NULL,4,1,NULL,0,0,'$2b$10$PoI9bcJPX4cmw7ejo61I6u3x4mkjEhGrqf6oaiGWCvML3mIncOtz6',NULL,NULL,NULL,NULL,'2024-12-18 06:43:28',NULL,1),(11,NULL,'johnDoe','johnDoe@gmail.com',NULL,4,1,NULL,0,0,'$2b$10$Nr0zEmgSYZPt96n42SlZeeeCm2N.j/FBkJLc0VwD12BDZIaxuUMjy',NULL,NULL,NULL,NULL,'2024-12-18 06:43:28',NULL,1),(12,NULL,'janeDoe','janeDoe@gmail.com',NULL,4,1,NULL,0,0,'$2b$10$k6Stb48SG42kNscGO18mPeKFqjyU/42NDs6l61G08svwZiTH5McM2',NULL,NULL,NULL,NULL,'2024-12-18 06:43:28',NULL,1),(13,NULL,'bobSmith','bobSmith@gmail.com',NULL,2,1,NULL,0,0,'$2b$10$7o7Y1x82duSrKSMmNrYEQe86ROh.PQ6bJLYvPi99tlOJ.MXzI.tda',NULL,NULL,NULL,NULL,NULL,NULL,1),(14,NULL,'aliceJohnson','aliceJohnson@gmail.com',NULL,2,1,NULL,0,0,'$2b$10$AC7N31nGhUzo48kGysGvF.HeQcpbB.PB18sVLQx4UFEwWTwEb3r3K',NULL,NULL,NULL,NULL,NULL,NULL,1),(15,NULL,'mikeWilliams','mikeWilliams@gmail.com',NULL,2,1,NULL,0,0,'$2b$10$cRpetyAvVaxrMtl4VGUblOjJxtDpUHBhHfnnaBcR637gFzyTsW1uu',NULL,NULL,NULL,NULL,NULL,NULL,1),(16,'12345ABC','John Doe','user@example.com','1234567890',2,1,'X64NP1FZ',0,0,NULL,NULL,NULL,'2025-01-28 08:27:53',NULL,'2025-01-28 08:27:53',NULL,1),(17,'12345ABCD','John Doe','user@example.com','1234567890',2,1,'YYNO94XH',0,0,NULL,NULL,NULL,'2025-01-28 08:31:20',NULL,'2025-01-28 08:31:20',NULL,1),(18,'12345ABCDE','John','user1@example.com','1234567890',2,1,'fer40iqe',0,0,NULL,NULL,NULL,'2025-01-28 08:55:13',NULL,'2025-01-28 08:55:13',NULL,1),(19,'12345ABCDEF',NULL,'user2@example.com',NULL,2,1,'kr0ejnd2',0,0,NULL,NULL,NULL,'2025-01-29 04:25:03',NULL,'2025-01-29 04:25:03',NULL,1),(20,'12345ABCDEFG',NULL,'user3@example.com',NULL,2,1,'5kiarav1',0,0,NULL,NULL,NULL,'2025-01-29 04:49:25',NULL,'2025-01-29 04:49:25',NULL,1);
/*!40000 ALTER TABLE `dy_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dy_user_actions`
--

DROP TABLE IF EXISTS `dy_user_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dy_user_actions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `property_id` int DEFAULT NULL,
  `status_code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_user_id_idx` (`user_id`),
  KEY `fk_property_id_idx` (`property_id`),
  KEY `fk_action_status_idx` (`status_code`),
  CONSTRAINT `fk_action_property_id` FOREIGN KEY (`property_id`) REFERENCES `dy_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_action_user_id` FOREIGN KEY (`user_id`) REFERENCES `dy_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='"user actions like viewed,favourites,filters,rejected"';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dy_user_actions`
--

LOCK TABLES `dy_user_actions` WRITE;
/*!40000 ALTER TABLE `dy_user_actions` DISABLE KEYS */;
INSERT INTO `dy_user_actions` VALUES (1,1,1,'27'),(2,2,2,'28'),(3,2,3,'28'),(4,2,5,'27');
/*!40000 ALTER TABLE `dy_user_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dy_user_profile`
--

DROP TABLE IF EXISTS `dy_user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dy_user_profile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `current_city` varchar(45) DEFAULT NULL,
  `conv_mode_id` int DEFAULT '1',
  `alt_email_id` varchar(45) DEFAULT NULL,
  `alt_mobile_no` varchar(12) DEFAULT NULL,
  `allow_promotion_campaign` int DEFAULT '1',
  `Interests` tinytext,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `d_UNIQUE` (`id`),
  KEY `fk_user_id_idx` (`user_id`),
  KEY `fk_conv_mode_id_idx` (`conv_mode_id`),
  CONSTRAINT `fk_conv_mode_id` FOREIGN KEY (`conv_mode_id`) REFERENCES `st_conv_mode` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for User Profile';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dy_user_profile`
--

LOCK TABLES `dy_user_profile` WRITE;
/*!40000 ALTER TABLE `dy_user_profile` DISABLE KEYS */;
INSERT INTO `dy_user_profile` VALUES (1,2,'Delhi',3,'john.doe@example.com','1234567890',1,'Reading\nTraveling\nMusic','2025-01-09 10:00:00'),(2,4,'Mumbai',1,'jane.smith@example.com','0987654321',0,'Sports\nMovies','2025-01-09 10:05:00'),(3,7,'Bangalore',4,'mark.jones@example.com','1122334455',1,'Cooking\nGaming','2025-01-09 10:10:00'),(4,4,'Chennai',2,'alice.miller@example.com','6677889900',1,'Fitness\nTraveling','2025-01-09 10:15:00'),(5,5,'Kolkata',3,'robert.wilson@example.com','2233445566',0,'Music\nMovies','2025-01-09 10:20:00'),(6,3,'Hyderabad',1,'lisa.white@example.com','4455667788',1,'Art\nTechnology','2025-01-09 10:25:00'),(7,2,'Ahmedabad',4,'charles.taylor@example.com','5566778899',0,'Hiking\nReading','2025-01-09 10:30:00'),(8,8,'Pune',2,'paul.jackson@example.com','6677889900',1,'Photography\nTraveling','2025-01-09 10:35:00'),(9,4,'Surat',3,'mary.martinez@example.com','7788990011',0,'Cooking\nGardening','2025-01-09 10:40:00'),(10,8,'Jaipur',1,'kevin.brown@example.com','8899001122',1,'Sports\nFitness','2025-01-09 10:45:00'),(11,9,'Lucknow',2,'elizabeth.moore@example.com','9900112233',0,'Movies\nMusic','2025-01-09 10:50:00'),(12,5,'Chandigarh',4,'daniel.lee@example.com','0011223344',1,'Gaming\nTechnology','2025-01-09 10:55:00'),(13,8,'Indore',3,'susan.rodriguez@example.com','1122334455',1,'Traveling\nArt','2025-01-09 11:00:00'),(14,4,'Bhopal',1,'michael.garcia@example.com','2233445566',0,'Photography\nSports','2025-01-09 11:05:00'),(15,3,'Patna',2,'david.harris@example.com','3344556677',1,'Reading\nMovies','2025-01-09 11:10:00');
/*!40000 ALTER TABLE `dy_user_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_amenities`
--

DROP TABLE IF EXISTS `st_amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_amenities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amenity_name` varchar(75) DEFAULT NULL,
  `amenity_category_id` int DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_am_cat_id` (`amenity_category_id`),
  CONSTRAINT `fk_am_cat_id` FOREIGN KEY (`amenity_category_id`) REFERENCES `st_amenity_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Amenities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_amenities`
--

LOCK TABLES `st_amenities` WRITE;
/*!40000 ALTER TABLE `st_amenities` DISABLE KEYS */;
INSERT INTO `st_amenities` VALUES (1,'yoga',1,1),(2,'meditation',1,1),(3,'bicycling',1,1),(4,'joggingtrack',1,1),(5,'walkingtrack',1,1),(6,'dancefloor',2,1),(7,'musicclub',2,1),(8,'paintingclub',2,1),(9,'theatregroup',2,1),(10,'vintageclub',2,1),(11,'professionalclub',2,1),(12,'kittypartyclub',2,1),(13,'amatuersclub',2,1),(14,'childrenclub',2,1),(15,'toddlerclub',2,1),(16,'cricket',3,1),(17,'basketball',3,1),(18,'throwball',3,1),(19,'football',3,1),(20,'skatingring',3,1),(21,'volleyball',3,1),(22,'lawntennis',3,1),(24,'outdoorshuttlecourt',3,1),(25,'parks',2,1),(26,'amphiteatre',2,1),(27,'minigolf',3,1),(28,'carroms',4,1),(29,'chess',4,1),(30,'cards',4,1),(31,'billiards',4,1),(32,'snooker',4,1),(33,'foosball',4,1),(34,'videogames',4,1),(35,'tabletennis',4,1),(36,'squash',4,1),(37,'shuttlecourt',4,1),(38,'fencing',4,1),(39,'zudoring',4,1),(40,'wrestlingring',4,1),(41,'armwrestling',4,1),(42,'compoundwall',5,1),(43,'cctvsurveyance',5,1),(44,'securitypersonnel',5,1),(45,'maingatesecurity',5,1),(46,'24hrsequrity',5,1),(47,'frontservice',6,1),(48,'guestrooms',6,1),(49,'multipurposeroom',6,1),(50,'blacktoproads',6,1),(51,'commongardening',6,1),(52,'supermarket',6,1),(53,'dispensery',1,1),(54,'commoncanteen',6,1),(55,'conferencerooms',6,1),(56,'laundry',6,1),(57,'salons',6,1),(58,'shoppingoutlets',6,1),(59,'brokerageservices',6,1),(60,'cleaningservices',6,1),(61,'commonwastebins',7,1),(62,'wasteducts',7,1),(63,'wastecollection',7,1),(64,'wetwaste',7,1),(65,'drywaste',7,1),(66,'biowaste',7,1),(67,'wasterecycling',7,1),(68,'biogasgeneration',7,1),(69,'compostgeneration',7,1),(70,'hazardouswaste',7,1),(71,'ewaste',7,1),(72,'waterharvesting',8,1),(73,'waterrecycling',8,1),(74,'allroundwater',8,1),(75,'watermetering',8,1),(76,'externalplantation',9,1),(77,'lawns',9,1),(78,'treeprotection',9,1),(79,'sculputeres',9,1),(80,'fountains',9,1),(81,'artificialwaterfalls',9,1),(82,'allroundpower',10,1),(83,'powerbackup',10,1),(84,'streetlighting',10,1),(85,'undergroundelectrification',10,1),(86,'sewagetratment',11,1),(87,'sewageclearance',11,1),(88,'drainagemaintenance',11,1),(89,'manholesmaintenance',11,1),(90,'generatorbackup',10,1),(91,'indoorswimmingpool',4,1),(92,'outdoorswimmingpool',3,1),(93,'creche',6,1),(94,'kidsarea',4,1),(95,'clubhouse',6,1);
/*!40000 ALTER TABLE `st_amenities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_amenity_category`
--

DROP TABLE IF EXISTS `st_amenity_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_amenity_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amenity_category` varchar(45) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Amenity Category';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_amenity_category`
--

LOCK TABLES `st_amenity_category` WRITE;
/*!40000 ALTER TABLE `st_amenity_category` DISABLE KEYS */;
INSERT INTO `st_amenity_category` VALUES (1,'Health_mgmnt',1),(2,'Recreation_mgmnt',1),(3,'Outdoor_sports_mgmnt',1),(4,'Indoor_sports_mgmnt',1),(5,'Security_mgmnt',1),(6,'Utilities_mgmnt',1),(7,'Waste_mgmnt',1),(8,'Water_mgmnt',1),(9,'Gardening_mgmnt',1),(10,'Power_mgmnt',1),(11,'Sewage_mgmnt',1);
/*!40000 ALTER TABLE `st_amenity_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_balcony`
--

DROP TABLE IF EXISTS `st_balcony`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_balcony` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nbalcony` varchar(5) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table For Balcony';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_balcony`
--

LOCK TABLES `st_balcony` WRITE;
/*!40000 ALTER TABLE `st_balcony` DISABLE KEYS */;
INSERT INTO `st_balcony` VALUES (1,'1',1),(2,'2',1),(3,'3',1),(4,'4',1),(5,'5',1),(6,'6',0),(7,'7',0),(8,'8',0),(9,'9',0),(10,'10',0);
/*!40000 ALTER TABLE `st_balcony` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_baths`
--

DROP TABLE IF EXISTS `st_baths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_baths` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nbaths` varchar(45) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Bathrooms';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_baths`
--

LOCK TABLES `st_baths` WRITE;
/*!40000 ALTER TABLE `st_baths` DISABLE KEYS */;
INSERT INTO `st_baths` VALUES (1,'1',1),(2,'2',1),(3,'3',1),(4,'4',1),(5,'5',1),(6,'6',0),(7,'7',0),(8,'8',0),(9,'9',0),(10,'10',0);
/*!40000 ALTER TABLE `st_baths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_beds`
--

DROP TABLE IF EXISTS `st_beds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_beds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nbeds` int DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table For Bedrooms';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_beds`
--

LOCK TABLES `st_beds` WRITE;
/*!40000 ALTER TABLE `st_beds` DISABLE KEYS */;
INSERT INTO `st_beds` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1),(6,6,0),(7,7,0),(8,8,0),(9,9,0),(10,10,0);
/*!40000 ALTER TABLE `st_beds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_billing_plan`
--

DROP TABLE IF EXISTS `st_billing_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_billing_plan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `billing_plan` varchar(25) DEFAULT NULL,
  `billing_amount` double DEFAULT NULL,
  `billing_duration` int DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Billing_Pla_Details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_billing_plan`
--

LOCK TABLES `st_billing_plan` WRITE;
/*!40000 ALTER TABLE `st_billing_plan` DISABLE KEYS */;
INSERT INTO `st_billing_plan` VALUES (1,'free',0,15,0),(2,'basic',499,60,0),(3,'standard',799,75,0),(4,'premium',999,180,0),(5,'ultra premium',1599,365,0);
/*!40000 ALTER TABLE `st_billing_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_brokerage`
--

DROP TABLE IF EXISTS `st_brokerage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_brokerage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `brokerage_amount` double DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table For Brokerage';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_brokerage`
--

LOCK TABLES `st_brokerage` WRITE;
/*!40000 ALTER TABLE `st_brokerage` DISABLE KEYS */;
INSERT INTO `st_brokerage` VALUES (1,10000,0);
/*!40000 ALTER TABLE `st_brokerage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_builder`
--

DROP TABLE IF EXISTS `st_builder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_builder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_city_id_1_idx` (`city_id`),
  CONSTRAINT `fk_city_id_1` FOREIGN KEY (`city_id`) REFERENCES `st_city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Builder';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_builder`
--

LOCK TABLES `st_builder` WRITE;
/*!40000 ALTER TABLE `st_builder` DISABLE KEYS */;
INSERT INTO `st_builder` VALUES (1,'MyHome',198,1),(2,'Aparna',198,1),(3,'Rajpushpa',198,1),(4,'HonerHomes',198,0),(5,'Vamsiram',198,0),(6,'Vertex',198,0),(7,'Prestige',198,1),(8,'Vasavi',198,0),(9,'Hallmark',198,0),(10,'Gowra',198,0),(11,'Ramky',198,1),(12,'ASBL',198,0),(13,'CyberCity',198,0),(14,'Praneeth',198,0),(15,'APR',198,0),(16,'GreenSpace',198,0),(17,'Alekhya',198,0),(18,'Radhey',198,0),(19,'Giridhari',198,0),(20,'SriAditya',198,0),(21,'Lansum',198,0),(22,'MVV Builders',11,0),(23,'Subhagruha',11,0),(24,'Bhoomatha',11,0),(25,'MK Builders',11,0),(26,'Vaisakhi',11,0),(27,'Aditya',11,0),(28,'Prakruthi',11,0),(29,'Balaji',11,0),(30,'ShriRam',11,0),(31,'VK',11,0),(32,'Sardar',11,0),(33,'Peram',11,0),(34,'Swathi',11,0),(35,'Charan',11,0),(36,'Flora',11,0),(37,'Sai Infra',11,0),(38,'SriVaibhava',11,0),(39,'utkarsha',11,0),(40,'Lansum',11,0),(41,'Pranathi',11,0),(42,'Himaja',2,0),(43,'Raki Avenues',2,0),(44,'V Cube',2,0),(45,'Akshar Group',66,0),(46,'Sangani Infra',66,0),(47,'Shreenath Infra',66,0),(48,'Sky Seven Infra',66,0),(49,'Nilamber',66,0),(50,'Pratham Realty',66,0),(51,'J P Iscon',66,0),(52,'Narayan Realty',66,0),(53,'Darshanam Realty',66,0),(54,'Mangla Group',66,0),(55,'Fortune Group',66,0),(56,'vraj Builders',67,0),(57,'Godrej Properties',68,0),(58,'Adani Group',68,0),(59,'Applewoods',68,0),(60,'Bakeri',68,0),(61,'Ganesh Housing',68,0),(62,'Sheetal Infra',68,0),(63,'Shivalik Infra',68,0),(64,'Saanvi Nirman',68,0),(65,'Adani Realty',68,0),(66,'Goyal & Co',68,0),(67,'Rajhans Group',69,0),(68,'Happy Home Group',69,0),(69,'Sangini Group',69,0),(70,'Raghuvir Corporation',69,0),(71,'Avadh Group',69,0),(72,'Western Group',69,0),(73,'Vaishnodevi Group',69,0),(74,'Akash Group',69,0),(75,'Green Group',69,0),(76,'Pramukh Group',69,0),(77,'Prestige Group',101,0),(78,'Sobha Ltd',101,0),(79,'Brigade Group',101,0),(80,'godrej Properties',101,0),(81,'purvankara Group',101,0),(82,'mahindra lifespace',101,0),(83,'Mana Projects',101,0),(84,'Century Real Estate',101,0),(85,'Assetz Group',101,0),(86,'Sattva Group',101,0),(87,'Lodha Group',131,0),(88,'Oberoi Realty',131,0),(89,'K Raheja Group',131,0),(90,'godrej Properties',131,0),(91,'L&T Realty',131,0),(92,'Runwal Realty',131,0),(93,'Rustomjee Group',131,0),(94,'Hiranandani Group',131,0),(95,'Prestige Group',131,0),(96,'Piramal Group',131,0),(97,'Mani Group',233,0),(98,'Merlin Group',233,0),(99,'PS Group',233,0),(100,'Siddha Group',233,0),(101,'Ambuja Neotia',233,0),(102,'Mayfair Group',233,0),(103,'Sugam Group',233,0),(104,'Bhawani Group',233,0),(105,'Srijan Realty',233,0),(106,'Eden Group',233,0),(107,'DLF Ltd',248,0),(108,'Raheja Group',248,0),(109,'Adarsh Homes',248,0),(110,'DGR Homes',248,0),(111,'EMAAR India',248,0),(112,'Supertech Limited',248,0),(113,'parsvnath Group',248,0),(114,'Ashiana Group',248,0),(115,'Veera Group',248,0),(116,'Godrej Properties',248,0),(117,'Casagrand Group',188,0),(118,'Appaswamy Group',188,0),(119,'VGN Group',188,0),(120,'Jain Housing',188,0),(121,'Lancor Holdings',188,0),(122,'Pacifica Group',188,0),(123,'urbantree Infra',188,0),(124,'Radiance Realty',188,0),(125,'DRA Homes',188,0),(126,'DAC Developers',188,0);
/*!40000 ALTER TABLE `st_builder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_city`
--

DROP TABLE IF EXISTS `st_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_city` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `state_id` int DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_state_id_1` (`state_id`),
  CONSTRAINT `fk_state_id_1` FOREIGN KEY (`state_id`) REFERENCES `st_state` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for City';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_city`
--

LOCK TABLES `st_city` WRITE;
/*!40000 ALTER TABLE `st_city` DISABLE KEYS */;
INSERT INTO `st_city` VALUES (1,'amaravati',1,0),(2,'vijaywada',1,0),(3,'guntur',1,0),(4,'elluru',1,0),(5,'tadipallegudam',1,0),(6,'nellore',1,0),(7,'ongole',1,0),(8,'Tirupati',1,0),(9,'cuddapah',1,0),(10,'vijaynagaram',1,0),(11,'visakhapatnam',1,0),(12,'srikakulam',1,0),(13,'narsapuram',1,0),(14,'narsaraopeta',1,0),(15,'bhivaram',1,0),(16,'tuni',1,0),(17,'anakapalli',1,0),(18,'rajahmundry',1,0),(19,'samalkota',1,0),(20,'kakinada',1,0),(21,'itanagar',2,0),(22,'eastsaing',2,0),(23,'tawang',2,0),(24,'seppo',2,0),(25,'aalo',2,0),(26,'daporijo',2,0),(27,'namsai',2,0),(28,'tezu',2,0),(29,'pasighat',2,0),(30,'naharlagun',2,0),(31,'dispur',3,0),(32,'tezpur',3,0),(33,'guwahati',3,0),(34,'dibrugarh',3,0),(35,'jorhat',3,0),(36,'silchar',3,0),(37,'karimganj',3,0),(38,'dhubri',3,0),(39,'nagaon',3,0),(40,'hojai',3,0),(41,'patna',4,0),(42,'gaya',4,0),(43,'vaishali',4,0),(44,'nalanda',4,0),(45,'madhubani',4,0),(46,'bhagalpur',4,0),(47,'rajgir',4,0),(48,'muzzafarpur',4,0),(49,'bodhgaya',4,0),(50,'chapra',4,0),(51,'raipur',5,0),(52,'bilaspur',5,0),(53,'bhilai',5,0),(54,'korba',5,0),(55,'rajnanndgaon',5,0),(56,'jagadalpur',5,0),(57,'ambikapur',5,0),(58,'dhamtari',5,0),(59,'mahasamund',5,0),(60,'champa',5,0),(61,'panaji',6,0),(62,'mapusa',6,0),(63,'madgoan',6,0),(64,'ponda',6,0),(65,'vascodagama',6,0),(66,'Vadodara',7,0),(67,'Rajkot',7,0),(68,'Ahmedabad',7,0),(69,'surat',7,0),(70,'jamnagar',7,0),(71,'bhavnagar',7,0),(72,'junagadh',7,0),(73,'porbandar',7,0),(74,'Gandhinagar',7,0),(75,'gurgoan',8,0),(76,'faridabad',8,0),(77,'karnal',8,0),(78,'panchkula',8,0),(79,'kaithal',8,0),(80,'bhiwani',8,0),(81,'rewari',8,0),(82,'sonipat',8,0),(83,'shimla',9,0),(84,'mandi',9,0),(85,'kullu',9,0),(86,'manali',9,0),(87,'bilaspur',9,0),(88,'chamba',9,0),(89,'dharamshala',9,0),(90,'solan',9,0),(91,'ranchi',10,0),(92,'dhanbad',10,0),(93,'bokaro city',10,0),(94,'deogarh',10,0),(95,'jamshedpur',10,0),(96,'giridh',10,0),(97,'hazaribagh',10,0),(98,'medininagar',10,0),(99,'ramgarhcantonment',10,0),(100,'chaibasa',10,0),(101,'Bengaluru',11,0),(102,'mangaluru',11,0),(103,'shivamoga',11,0),(104,'mysore',11,0),(105,'kalaburigi',11,0),(106,'udipi',11,0),(107,'ballari',11,0),(108,'davegere',11,0),(109,'tumakuru',11,0),(110,'raichur',11,0),(111,'kochi',12,0),(112,'thiruvananthpuram',12,0),(113,'khozikode',12,0),(114,'kollam',12,0),(115,'thrissur',12,0),(116,'kannur',12,0),(117,'mallapuram',12,0),(118,'allapuzha',12,0),(119,'palakkad',12,0),(120,'kottayam',12,0),(121,'Bhopal',13,0),(122,'Indore',13,0),(123,'Gwalior',13,0),(124,'ujjain',13,0),(125,'ratlam',13,0),(126,'rewa',13,0),(127,'jabalpur',13,0),(128,'sagar',13,0),(129,'satna',13,0),(130,'chindwara',13,0),(131,'Mumbai',14,0),(132,'pune',14,0),(133,'nagpur',14,0),(134,'aurangabad',14,0),(135,'nashik',14,0),(136,'kolhapur',14,0),(137,'amravati',14,0),(138,'solapur',14,0),(139,'thane',14,0),(140,'sangli',14,0),(141,'imphal',15,0),(142,'thoubal',15,0),(143,'shillong',16,0),(144,'tura',16,0),(145,'nongstoin',16,0),(146,'Aizawl',17,0),(147,'lunglei',17,0),(148,'serchipp',17,0),(149,'kohima',18,0),(150,'dimapur',18,0),(151,'tuensang',18,0),(152,'bhubaneswar',19,0),(153,'cuttack',19,0),(154,'brahmapur',19,0),(155,'puri',19,0),(156,'rourkela',19,0),(157,'barripada',19,0),(158,'balasore',19,0),(159,'bhadrak',19,0),(160,'sambalpur',19,0),(161,'jharsguda',19,0),(162,'koraput',19,0),(163,'amritsar',20,0),(164,'patiala',20,0),(165,'ludhaina',20,0),(166,'bhatinda',20,0),(167,'jalandhar',20,0),(168,'moga',20,0),(169,'kapurthala',20,0),(170,'hoshiarpur',20,0),(171,'sahibzada Ajit Singh Nagar',20,0),(172,'gurdaspur',20,0),(173,'barnala',20,0),(174,'jodhpur',21,0),(175,'udaipur',21,0),(176,'pali',21,0),(177,'bikaner',21,0),(178,'jaipur',21,0),(179,'ajmer',21,0),(180,'kota',21,0),(181,'sikar',21,0),(182,'alwar',21,0),(183,'bhilwara',21,0),(184,'sawaimadhopur',21,0),(185,'gangtok',22,0),(186,'namchi',22,0),(187,'rangpo',22,0),(188,'chennai',23,0),(189,'salem',23,0),(190,'madurai',23,0),(191,'coimbatore',23,0),(192,'thiruchapalli',23,0),(193,'kancheepuram',23,0),(194,'vellore',23,0),(195,'tiruppur',23,0),(196,'Thoothukudi',23,0),(197,'Secunderabad',24,0),(198,'Hyderabad',24,1),(199,'warangal',24,0),(200,'khammam',24,0),(201,'nizamabad',24,0),(202,'karimnagar',24,0),(203,'sirpurkagaznagar',24,0),(204,'siddipet',24,0),(205,'mahbubnagar',24,0),(206,'nalgonda',24,0),(207,'adilabad',24,0),(208,'suryapet',24,0),(209,'agartala',25,0),(210,'dharmanagar',25,0),(211,'Kailashahar',25,0),(212,'dehradun',26,0),(213,'rishikesh',26,0),(214,'nainital',26,0),(215,'mussorie',26,0),(216,'haridwar',26,0),(217,'almora',26,0),(218,'haldwani',26,0),(219,'roorkee',26,0),(220,'kashipur',26,0),(221,'lucknow',27,0),(222,'noida',27,0),(223,'agra',27,0),(224,'prayagraj',27,0),(225,'varnasi',27,0),(226,'kanpur',27,0),(227,'jhansi',27,0),(228,'ghaziabad',27,0),(229,'mathura',27,0),(230,'gorakhpur',27,0),(231,'meerut',27,0),(232,'philibit',27,0),(233,'kolkata',28,0),(234,'howrah',28,0),(235,'siliguri',28,0),(236,'asansol',28,0),(237,'malda',28,0),(238,'darjeeling',28,0),(239,'berhampur',28,0),(240,'kharagpur',28,0),(241,'eastmedinipur',28,0),(242,'westmedinipur',28,0),(243,'purabbardhaman',28,0),(244,'south24parganas',28,0),(245,'north24parganas',28,0),(246,'durgapur',28,0),(247,'haldia',28,0),(248,'NewDelhi',37,0);
/*!40000 ALTER TABLE `st_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_community`
--

DROP TABLE IF EXISTS `st_community`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_community` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `map_url` varchar(250) DEFAULT NULL,
  `total_area` double DEFAULT NULL,
  `open_area` double DEFAULT NULL,
  `nblocks` int DEFAULT NULL,
  `nfloors_per_block` int DEFAULT NULL,
  `nhouses_per_floor` int DEFAULT NULL,
  `address` varchar(300) DEFAULT NULL,
  `major_area` varchar(45) DEFAULT NULL,
  `builder_id` int DEFAULT NULL,
  `totflats` int DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  `default_images` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_builder_id_idx` (`builder_id`),
  CONSTRAINT `fk_builder_id` FOREIGN KEY (`builder_id`) REFERENCES `st_builder` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Community';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_community`
--

LOCK TABLES `st_community` WRITE;
/*!40000 ALTER TABLE `st_community` DISABLE KEYS */;
INSERT INTO `st_community` VALUES (1,'Avatar','https://maps.app.goo.gl/GcBS9FEeCnCe2pqCA',22.75,83.5,10,31,9,'Sy. Nos. 217 to 225, Narsingi Village, Rajendranagar, Revenue Mandal, Puppalguda, Hyderabad, Telangana 500089',NULL,1,2800,'completed',1,'https://drive.google.com/file/d/1T2tub-sjB8FUb2xQsaawl7ESy8zrYcG5/view?usp=drive_link'),(2,'Krishe','https://maps.app.goo.gl/oz5QfXprYdkUzETz6',6.75,80,4,26,9,'Cluster_serilingampally 13, Block 1, MY HOME KRISHE, SY.NO. 38 to 41 Gopannapally Village, Mandal, Gachibowli, Serilingampalle (M), Hyderabad, Telangana 500046',NULL,1,650,'completed',1,'https://drive.google.com/file/d/1K5_57AxL_oZc9oit287y5U3iYM5wz8-P/view?usp=drive_link'),(3,'Vihanga','https://maps.app.goo.gl/eyf5A4b2bwcoLPnj9https://maps.app.goo.gl/eyf5A4b2bwcoLPnj9',21,80,20,18,6,'C8JJ+XCG, Gachibowli, Hyderabad, Telangana 500032',NULL,1,1996,'completed',1,'https://drive.google.com/file/d/1jQC6N-ccR6CgunqDUgRN6SkefPI_rgf8/view?usp=drive_link'),(4,'Jewel','https://maps.app.goo.gl/zDsC2ZC7YpszPUgq8',22.5,68,14,15,12,'My Home Jewels Apartments, Manjeera Pipeline Rd, Hafeezpet, Madeenaguda, Hyderabad, Telangana 500133',NULL,1,2016,'completed',1,NULL),(5,'Abhra','https://maps.app.goo.gl/a1hZmzNUpjp55m6s6',5,73,5,17,5,'Inorbit Mall, Road, Mindspace Madhapur Rd, Silpa Gram Craft Village, HITEC City, Hyderabad, Telangana 500081',NULL,1,387,'completed',1,NULL),(6,'Bhooja','https://maps.app.goo.gl/idBVxo8h6epFFTGw8',18,80,11,36,4,'Plot No 22 to 24, and 31 to 33, Sy.No.83/1 Raidurgam Panmakta, Serilingampally, Hyderabad, Telangana 500032',NULL,1,1560,'completed',1,NULL),(7,'Tarkshya','https://maps.app.goo.gl/EmWQcRk3fEbouNcf9',5.82,78,4,32,5,'Golden Mile Rd, Kokapet, Hyderabad, Telangana 500075',NULL,1,660,'completed',1,'https://drive.google.com/file/d/1JKLr6JzkP4lSTSAoXWOE-0UG-3Fq_3jo/view?usp=drive_link'),(8,'Ankura','https://maps.app.goo.gl/kmRBmfJhBd5EGQk37',75.46,80,603,3,1,'My Home Ankura Main St, Tellapur, Hyderabad, Telangana 502300',NULL,1,603,'completed',1,NULL),(9,'Navadweepa','https://maps.app.goo.gl/zUwnz6wVv8fMPcDj7',9.5,80,4,9,16,'Vayu Block, Patrika Nagar, Madhapur, 79, Hitech City Rd, HITEC City, Hyderabad, Telangana 500081',NULL,1,556,'completed',1,NULL),(10,'Mangala','https://maps.app.goo.gl/DkB7koJaJYyKsqGt5',20,77,11,15,12,'Sy.No.98 Kondapur Village, Serilingampally Mandal, Hyderabad, Telangana 500084',NULL,1,1879,'completed',1,NULL),(11,'Akrida','https://maps.app.goo.gl/yHYJSQnLV3SbJnwN6',24.99,81,12,39,8,'Tellapur Village Ramachandrapuram, Nallagandla, Hyderabad, Telangana 500019',NULL,1,3780,'ongoing',0,NULL),(12,'Sayuk','https://maps.app.goo.gl/HsgY8jVYRoyvtMzZ7',25.37,81,12,39,8,'Sy.No. 366/P, 368/P,369/P Tellapur Village Ramachandrapuram, Mandal Sangareddy, District, Hyderabad, Telangana 502032',NULL,1,3780,'ongoing',0,NULL),(13,'Tridasa','https://maps.app.goo.gl/Y9jNiDzDnihp17Ts7',22.56,84,9,29,10,'Radial Rd 7, Tellapur, Ramachandrapuram, Hyderabad, Telangana 502032',NULL,1,2682,'ongoing',0,NULL),(14,'Vipina','https://maps.app.goo.gl/1Fi6ah3ELAkCgLQt5',20.61,81,8,46,10,'Radial Rd 7, Tellapur, Ramachandrapuram, Hyderabad, Telangana 502032',NULL,1,3720,'ongoing',0,NULL),(15,'Grava','https://maps.app.goo.gl/B1hwUprtF7WmUEJD8',17.52,80,7,54,4,'C829+GW, Kokapet, Hyderabad, Telangana 500075',NULL,1,1289,'ongoing',0,NULL),(16,'Apas','https://maps.app.goo.gl/kbQkz4v1Wrcsf4uQ6',13.52,81.6,6,44,4,'C83H+7FG, Kokapet, Hyderabad, Telangana 500075',NULL,1,1338,'ongoing',0,NULL),(17,'99','https://maps.app.goo.gl/ejqsyTsCXhnQuzXa9',1.74,0,1,53,2,'Khanapur Survey No : 240/P Gandipet, Hyderabad, Telangana 500075',NULL,1,99,'ongoing',0,NULL),(18,'Avali','https://maps.app.goo.gl/8EqGkh82dttEY6FM7',8.37,81,4,46,3,'F76V+P6, Tellapur, Hyderabad, Telangana 500019',NULL,1,744,'ongoing',0,NULL),(19,'Nishada','https://maps.app.goo.gl/stXWE1BG3o2vzayJ6',16.68,80,8,44,4,'Mandal, Survey No. 239/240 plot no 3&4, Neopolis, Kokapet, Gandipet, Telangana 500075',NULL,1,744,'ongoing',0,NULL),(20,'Raka','https://maps.app.goo.gl/WhmYgUrhqXN5K3qFA',2.4,81.6,9,34,1,'Sy. No.97(P), 98, Madeenaguda, Serilingampally Mandal, Telangana 500049',NULL,1,300,'ongoing',0,NULL),(21,'Silver Oaks','https://maps.app.goo.gl/MkKMzcQPXuq18BFe8',7,80,6,14,1,'APARNA HILL PARK SILVER OAKS, Gangaram Cheruvu, Bandam Kommu, Chanda Nagar, Hyderabad, Ramachandrapuram, Telangana 500050',NULL,2,606,'completed',1,NULL),(22,'Lake Breeze','https://maps.app.goo.gl/kzUQc55DM5cSEEeE9',12,80,11,14,6,'Aparna Hillpark Rd, Bandam Kommu, Chanda Nagar, Hyderabad, Telangana 500050',NULL,2,943,'completed',1,'https://drive.google.com/file/d/1H7vW8ZceqIEUlFoWosd14p1BO64FB3i1/view?usp=drive_link'),(23,'Boulevard','https://maps.app.goo.gl/bAznEiDmnzqTyB5U9',12,80,95,3,1,'Bandam Kommu, Hyderabad, Ramachandrapuram, Telangana 500133',NULL,2,95,'completed',1,NULL),(24,'Gardenia','https://maps.app.goo.gl/TopzmoJ6d7gEcrD69',16,80,116,3,1,'Bandam Kommu, Hyderabad, Ramachandrapuram, Telangana 500133',NULL,2,116,'completed',1,NULL),(25,'Avenues','https://maps.app.goo.gl/HUAvaqcp39z86yWA7',9,80,6,12,12,'Beside road of Violet Purple Showroom Chandanagar, Serilingapally Mandal, 275, Aparna Hillpark Rd, Bandam Kommu, Hyderabad, Telangana 500050',NULL,2,707,'completed',1,NULL),(26,'WestSide','https://maps.app.goo.gl/ARfwJQFXK4px8WfR6',1.7,80,1,14,9,'500089, Sai Aishwarya Layout, Chitrapuri Colony, Manikonda, Telangana 500089',NULL,2,128,'completed',1,NULL),(27,'WestSide','https://maps.app.goo.gl/ARfwJQFXK4px8WfR6',1.7,80,1,14,9,'500089, Sai Aishwarya Layout, Chitrapuri Colony, Manikonda, Telangana 500089',NULL,2,128,'completed',1,NULL),(28,'Sunrise Heights','https://maps.example.com/sunrise_heights',50000,15000,5,10,4,'123 Sunset Blvd, Sunshine City','Sunshine City',1,200,'active',1,'https://example.com/images/sunrise_heights.jpg'),(29,'Sunrise Heights','https://maps.example.com/sunrise_heights',50000,15000,5,10,4,'123 Sunset Blvd, Sunshine City','Sunshine City',1,200,'active',1,'https://example.com/images/sunrise_heights.jpg'),(30,'Sunrise Heights','https://maps.example.com/sunrise_heights',50000,15000,5,10,4,'123 Sunset Blvd, Sunshine City','Sunshine City',1,200,'active',1,'https://example.com/images/sunrise_heights.jpg'),(31,'Sunrise Heights','https://maps.example.com/sunrise_heights',50000,15000,5,10,4,'123 Sunset Blvd, Sunshine City','Sunshine City',1,200,'active',1,'https://example.com/images/sunrise_heights.jpg'),(32,'Sunrise Heights','https://maps.example.com/sunrise_heights',50000,15000,5,10,4,'123 Sunset Blvd, Sunshine City','Sunshine City',1,200,'active',1,'https://example.com/images/sunrise_heights.jpg'),(33,'Sunrise Heights','https://maps.example.com/sunrise_heights',50000,15000,5,10,4,'123 Sunset Blvd, Sunshine City','Sunshine City',1,200,'active',1,'https://example.com/images/sunrise_heights.jpg'),(34,'Sunrise Heights','https://maps.example.com/sunrise_heights',50000,15000,5,10,4,'123 Sunset Blvd, Sunshine City','Sunshine City',1,200,'active',1,'https://example.com/images/sunrise_heights.jpg'),(35,'West Heights','https://maps.example.com/sunrise_heights',50000,15000,5,10,4,'123 Sunset Blvd, Sunshine City','Sunshine City',1,200,'active',1,'https://example.com/images/sunrise_heights.jpg'),(36,'West Heights','https://maps.example.com/sunrise_heights',50000,15000,5,10,4,'123 Sunset Blvd, Sunshine City','Sunshine City',1,200,'active',1,'https://example.com/images/sunrise_heights.jpg');
/*!40000 ALTER TABLE `st_community` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_conv_mode`
--

DROP TABLE IF EXISTS `st_conv_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_conv_mode` (
  `id` int NOT NULL AUTO_INCREMENT,
  `conv_mode` varchar(25) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Conversation Mode';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_conv_mode`
--

LOCK TABLES `st_conv_mode` WRITE;
/*!40000 ALTER TABLE `st_conv_mode` DISABLE KEYS */;
INSERT INTO `st_conv_mode` VALUES (1,'All',0),(2,'Chat',0),(3,'Email',0),(4,'Mobile',1);
/*!40000 ALTER TABLE `st_conv_mode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_current_status`
--

DROP TABLE IF EXISTS `st_current_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_current_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status_category` varchar(45) DEFAULT NULL,
  `status_code` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_stat_cat_id_idx` (`status_category`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Status';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_current_status`
--

LOCK TABLES `st_current_status` WRITE;
/*!40000 ALTER TABLE `st_current_status` DISABLE KEYS */;
INSERT INTO `st_current_status` VALUES (1,'SYS','Review'),(2,'ADM','Invalid-Input'),(3,'ADM','Approved'),(4,'SYS','Info-RM'),(5,'RMA','CallUser'),(6,'RMA','CallOwner'),(7,'RMA','Scheduled'),(8,'FMA','Req-reschedule'),(9,'RMA','Rescheduled'),(10,'FMA','Arrived'),(11,'FMA','VisitDone'),(12,'RMA','Pending'),(13,'RMA','Rej-User'),(14,'RMA','Rej-Owner'),(15,'RMA','BGV-Start'),(16,'RMA','BGV-Done'),(17,'RMA','Agreed'),(18,'RMA','Pay-Requested'),(19,'RMA','Pay-Pend'),(20,'RMA','Pay-Done'),(21,'RMA','RA Signed'),(22,'RMA','PS1-Sched'),(23,'FMA','PS1-Done'),(24,'RMA','Rented'),(25,'RMA','PS2-Sched'),(26,'FMA','PS2-Done'),(27,'SYS','Viewed'),(28,'SYS','Favoured'),(29,'SYS','Inactive'),(30,'RMA','Inactive'),(31,'RMA','goodiesdelivered');
/*!40000 ALTER TABLE `st_current_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_deposit_range`
--

DROP TABLE IF EXISTS `st_deposit_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_deposit_range` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nmonths` int DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Deposit Range';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_deposit_range`
--

LOCK TABLES `st_deposit_range` WRITE;
/*!40000 ALTER TABLE `st_deposit_range` DISABLE KEYS */;
INSERT INTO `st_deposit_range` VALUES (1,1,0),(2,2,0),(3,3,0),(4,4,0),(5,5,0),(6,6,0),(7,7,0),(8,8,0),(9,9,0),(10,10,0),(11,11,0),(12,12,0);
/*!40000 ALTER TABLE `st_deposit_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_floor_range`
--

DROP TABLE IF EXISTS `st_floor_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_floor_range` (
  `id` int NOT NULL AUTO_INCREMENT,
  `floor_lower_limit` int DEFAULT NULL,
  `floor_upper_limit` int DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Floor Range';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_floor_range`
--

LOCK TABLES `st_floor_range` WRITE;
/*!40000 ALTER TABLE `st_floor_range` DISABLE KEYS */;
INSERT INTO `st_floor_range` VALUES (1,1,5,0),(2,6,10,0),(3,11,15,0),(4,16,20,0),(5,21,25,0),(6,26,30,0),(7,31,35,0),(8,36,40,0),(9,41,45,0),(10,46,50,0),(11,51,55,0),(12,56,60,0),(13,61,65,0),(14,66,70,0),(15,71,75,0),(16,76,80,0),(17,81,85,0),(18,86,90,0),(19,91,95,0),(20,96,100,0),(21,101,105,0),(22,106,110,0),(23,111,115,0),(24,116,120,0),(25,121,125,0),(26,126,130,0),(27,131,135,0),(28,136,140,0),(29,141,145,0),(30,146,150,0);
/*!40000 ALTER TABLE `st_floor_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_gender`
--

DROP TABLE IF EXISTS `st_gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_gender` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gender_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Gender';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_gender`
--

LOCK TABLES `st_gender` WRITE;
/*!40000 ALTER TABLE `st_gender` DISABLE KEYS */;
INSERT INTO `st_gender` VALUES (1,'Male'),(2,'Female'),(3,'Not Wish to Disclose');
/*!40000 ALTER TABLE `st_gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_home_type`
--

DROP TABLE IF EXISTS `st_home_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_home_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `home_type` varchar(20) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Home Type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_home_type`
--

LOCK TABLES `st_home_type` WRITE;
/*!40000 ALTER TABLE `st_home_type` DISABLE KEYS */;
INSERT INTO `st_home_type` VALUES (1,'1 Bhk',1),(2,'2 Bhk',1),(3,'3 Bhk',1),(4,'4 Bhk',1),(5,'5 Bhk',1),(6,'6 Bhk',0),(7,'7 Bhk',0),(8,'8 Bhk',0),(9,'9 Bhk',0),(10,'10 Bhk',0),(11,'11 Bhk',0),(12,'12 Bhk',0),(13,'13 Bhk',0),(14,'14 Bhk',0),(15,'15 Bhk',0);
/*!40000 ALTER TABLE `st_home_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_landmarks_category`
--

DROP TABLE IF EXISTS `st_landmarks_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_landmarks_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `landmark_category` varchar(75) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table For Landmarks Category';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_landmarks_category`
--

LOCK TABLES `st_landmarks_category` WRITE;
/*!40000 ALTER TABLE `st_landmarks_category` DISABLE KEYS */;
INSERT INTO `st_landmarks_category` VALUES (1,'school',1),(2,'malls',1),(3,'hospital',1),(4,'metro station ',1),(5,'railway station',1),(6,'bus station',1),(7,'temples',1),(8,'police station',1),(9,'hotels',1);
/*!40000 ALTER TABLE `st_landmarks_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_maintenance`
--

DROP TABLE IF EXISTS `st_maintenance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_maintenance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maintenance_type` varchar(45) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Maintenance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_maintenance`
--

LOCK TABLES `st_maintenance` WRITE;
/*!40000 ALTER TABLE `st_maintenance` DISABLE KEYS */;
INSERT INTO `st_maintenance` VALUES (1,'Included',1),(2,'Not Included',1);
/*!40000 ALTER TABLE `st_maintenance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_parking_count`
--

DROP TABLE IF EXISTS `st_parking_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_parking_count` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parking_count` varchar(15) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_parking_count`
--

LOCK TABLES `st_parking_count` WRITE;
/*!40000 ALTER TABLE `st_parking_count` DISABLE KEYS */;
INSERT INTO `st_parking_count` VALUES (1,'1',1),(2,'2',1),(3,'3',1),(4,'4',1),(5,'5',1);
/*!40000 ALTER TABLE `st_parking_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_parking_type`
--

DROP TABLE IF EXISTS `st_parking_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_parking_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parking_type` varchar(15) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Parking Type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_parking_type`
--

LOCK TABLES `st_parking_type` WRITE;
/*!40000 ALTER TABLE `st_parking_type` DISABLE KEYS */;
INSERT INTO `st_parking_type` VALUES (1,'Car',0),(2,'Bike',0),(3,'Bicycle',0);
/*!40000 ALTER TABLE `st_parking_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_permissions`
--

DROP TABLE IF EXISTS `st_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permission` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Permissions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_permissions`
--

LOCK TABLES `st_permissions` WRITE;
/*!40000 ALTER TABLE `st_permissions` DISABLE KEYS */;
INSERT INTO `st_permissions` VALUES (1,'Read'),(2,'Write'),(3,'Edit'),(4,'Delete');
/*!40000 ALTER TABLE `st_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_prop_desc`
--

DROP TABLE IF EXISTS `st_prop_desc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_prop_desc` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prop_desc` varchar(30) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table For Property Description';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_prop_desc`
--

LOCK TABLES `st_prop_desc` WRITE;
/*!40000 ALTER TABLE `st_prop_desc` DISABLE KEYS */;
INSERT INTO `st_prop_desc` VALUES (1,'UnFurnished',1),(2,'SemiFurnished',1),(3,'FullyFurnished',1),(4,'OptimallyFurnished',1);
/*!40000 ALTER TABLE `st_prop_desc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_prop_facing`
--

DROP TABLE IF EXISTS `st_prop_facing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_prop_facing` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prop_facing` varchar(45) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Property Facing';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_prop_facing`
--

LOCK TABLES `st_prop_facing` WRITE;
/*!40000 ALTER TABLE `st_prop_facing` DISABLE KEYS */;
INSERT INTO `st_prop_facing` VALUES (1,'North',0),(2,'East',0),(3,'South',0),(4,'West',0),(5,'NorthEast',0),(6,'NorthWest',0),(7,'SouthEast',0),(8,'SouthWest',0),(9,'Central',0);
/*!40000 ALTER TABLE `st_prop_facing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_prop_type`
--

DROP TABLE IF EXISTS `st_prop_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_prop_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prop_type` varchar(45) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Property Type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_prop_type`
--

LOCK TABLES `st_prop_type` WRITE;
/*!40000 ALTER TABLE `st_prop_type` DISABLE KEYS */;
INSERT INTO `st_prop_type` VALUES (1,'Apartment',1),(2,'Independent House',0),(3,'Villa',1),(4,'RowHouse',0),(5,'Commercial',0);
/*!40000 ALTER TABLE `st_prop_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_referral_details`
--

DROP TABLE IF EXISTS `st_referral_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_referral_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `referral_amt` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Referral Amount';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_referral_details`
--

LOCK TABLES `st_referral_details` WRITE;
/*!40000 ALTER TABLE `st_referral_details` DISABLE KEYS */;
INSERT INTO `st_referral_details` VALUES (1,1000);
/*!40000 ALTER TABLE `st_referral_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_rental_range`
--

DROP TABLE IF EXISTS `st_rental_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_rental_range` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lower_limit` varchar(45) DEFAULT NULL,
  `higher_limit` varchar(45) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table For Rental Range';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_rental_range`
--

LOCK TABLES `st_rental_range` WRITE;
/*!40000 ALTER TABLE `st_rental_range` DISABLE KEYS */;
INSERT INTO `st_rental_range` VALUES (1,'0','999999',0);
/*!40000 ALTER TABLE `st_rental_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_role`
--

DROP TABLE IF EXISTS `st_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for Roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_role`
--

LOCK TABLES `st_role` WRITE;
/*!40000 ALTER TABLE `st_role` DISABLE KEYS */;
INSERT INTO `st_role` VALUES (1,'Admin'),(2,'User'),(3,'RM'),(4,'FM'),(5,'System');
/*!40000 ALTER TABLE `st_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_stat_cat`
--

DROP TABLE IF EXISTS `st_stat_cat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_stat_cat` (
  `id` int NOT NULL,
  `stat_category` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='static table for status categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_stat_cat`
--

LOCK TABLES `st_stat_cat` WRITE;
/*!40000 ALTER TABLE `st_stat_cat` DISABLE KEYS */;
INSERT INTO `st_stat_cat` VALUES (1,'Admin'),(2,'system'),(3,'rm'),(4,'fm');
/*!40000 ALTER TABLE `st_stat_cat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_state`
--

DROP TABLE IF EXISTS `st_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_state` (
  `id` int NOT NULL AUTO_INCREMENT,
  `scode` varchar(5) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table for States';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_state`
--

LOCK TABLES `st_state` WRITE;
/*!40000 ALTER TABLE `st_state` DISABLE KEYS */;
INSERT INTO `st_state` VALUES (1,'AP','Andhra Pradesh',0),(2,'AR','Arunachal Pradesh',0),(3,'AS','Assam',0),(4,'BR','Bihar',0),(5,'CG','Chhattisgarh',0),(6,'GA','Goa',0),(7,'GJ','Gujarat',0),(8,'HR','Haryana',0),(9,'HP','Himachal Pradesh',0),(10,'JH','Jharkhand',0),(11,'KA','Karnataka',0),(12,'KL','Kerala',0),(13,'MP','Madhya Pradesh',0),(14,'MH','Maharashtra',0),(15,'MN','Manipur',0),(16,'ML','Meghalaya',0),(17,'MZ','Mizoram',0),(18,'NL','Nagaland',0),(19,'OR','Odisha',0),(20,'PB','Punjab',0),(21,'RJ','Rajasthan',0),(22,'SK','Sikkim',0),(23,'TN','Tamil Nadu',0),(24,'TS','Telangana',1),(25,'TR','Tripura',0),(26,'UK','Uttarakhand',0),(27,'UP','Uttar Pradesh',0),(28,'WB','West Bengal',0),(29,'AN','Andaman,Nicobar Islands',0),(30,'CH','Chandigarh',0),(31,'DD','Dadra,NagarHaveli,Daman,Diu',0),(32,'DL','The Government of NCT of Delhi',0),(33,'JK','Jammu & Kashmir',0),(34,'LD','Ladakh',0),(35,'LA','Lakshadweep',0),(36,'PY','Puducherry',0),(37,'DL','Delhi-NCR',0);
/*!40000 ALTER TABLE `st_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_tenant`
--

DROP TABLE IF EXISTS `st_tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_tenant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tenant_type` varchar(20) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table For Tenant';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_tenant`
--

LOCK TABLES `st_tenant` WRITE;
/*!40000 ALTER TABLE `st_tenant` DISABLE KEYS */;
INSERT INTO `st_tenant` VALUES (1,'NA',1),(2,'Bachelor',1),(3,'Expats',1),(4,'Spinster',1),(5,'Family',1);
/*!40000 ALTER TABLE `st_tenant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_tenant_eat_pref`
--

DROP TABLE IF EXISTS `st_tenant_eat_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_tenant_eat_pref` (
  `id` int NOT NULL AUTO_INCREMENT,
  `eat_pref` varchar(15) DEFAULT NULL,
  `rstatus` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table For Eat Preference';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_tenant_eat_pref`
--

LOCK TABLES `st_tenant_eat_pref` WRITE;
/*!40000 ALTER TABLE `st_tenant_eat_pref` DISABLE KEYS */;
INSERT INTO `st_tenant_eat_pref` VALUES (1,'Anything',1),(2,'Non-Veg',1),(3,'Veg-Only',1);
/*!40000 ALTER TABLE `st_tenant_eat_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'rufrent'
--

--
-- Dumping routines for database 'rufrent'
--
/*!50003 DROP PROCEDURE IF EXISTS `addNewRecord` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewRecord`(
IN Tbl_Name varchar(60),
IN Field_Names varchar(350),
IN Field_Values text
)
BEGIN
    SET @sql_query = CONCAT('INSERT INTO ', Tbl_Name, ' (', Field_Names, ') VALUES (', Field_Values, ')');

    -- Prepare the dynamic SQL statement
    PREPARE statement FROM @sql_query;

    -- Execute the prepared statement
    EXECUTE statement;
	  -- Return the insertId after the insert operation
  SELECT LAST_INSERT_ID() AS insertId;

    -- Clean up the prepared statement
    DEALLOCATE PREPARE statement;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteRecord` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteRecord`(
IN Tbl_Name varchar(60),
IN Where_Condition varchar(350)
)
BEGIN

 -- Variable to hold the dynamic SQL query
    SET @sql_query = CONCAT('DELETE from ', Tbl_Name);

    -- Add WHERE clause if provided
    IF where_condition IS NOT NULL AND where_condition <> '' THEN
        SET @sql_query = CONCAT(@sql_query, ' WHERE ', Where_Condition);
    END IF;    

	-- SELECT @sql_query;
    -- Prepare and execute the query dynamically
    PREPARE statement FROM @sql_query;
    EXECUTE statement;

    -- Clean up the prepared statement
    DEALLOCATE PREPARE statement;
    
        -- Return the number of affected rows
    SELECT ROW_COUNT() AS affectedRows;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAggregateValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAggregateValue`(
    IN Tbl_name VARCHAR(60),
    IN Field_Name VARCHAR(60),
    IN Agg_Func_Name VARCHAR(30),
    IN Where_Condition VARCHAR(255)
)
BEGIN
    -- Check if the aggregate function is valid
    IF Agg_Func_Name NOT IN ('SUM', 'AVG', 'MAX', 'MIN', 'COUNT') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid aggregate function';
    END IF;

    -- Declare a variable to hold the dynamic query
    SET @sql_query = CONCAT('SELECT ', Agg_Func_Name, '(', Field_Name, ') AS result FROM ', Tbl_name);
    
    -- Append WHERE condition if provided
    IF Where_Condition IS NOT NULL THEN
        SET @sql_query = CONCAT(@sql_query, ' WHERE ', Where_Condition);
    END IF;

    -- Prepare and execute the dynamic query
    PREPARE stmt FROM @sql_query;
    EXECUTE stmt;

    -- Clean up the prepared statement
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDataWithLimits` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDataWithLimits`(
	IN Tbl_Name VARCHAR(64),        
	IN Grp_Fld VARCHAR(64),   
	IN Agg_Fld VARCHAR(64),  
	IN Agg_Func VARCHAR(20),
	IN Ord_Fld VARCHAR(64),   
	IN Srt_Typ VARCHAR(4),
	IN Lmt_Rows INT
)
BEGIN

	-- Validate the aggregate function
    IF Agg_Func NOT IN ('SUM', 'AVG', 'MAX', 'MIN', 'COUNT') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid aggregate function. Use SUM, AVG, MAX, MIN, or COUNT.';
    END IF;

    -- Validate the sort direction
    IF Srt_Typ NOT IN ('ASC', 'DESC') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid sort direction. Use ASC or DESC.';
    END IF;

    -- Construct the dynamic SQL query
    SET @sql_query = CONCAT(
        'SELECT ', Grp_Fld, ', ',
        Agg_Func, '(', Agg_Fld, ') AS aggregate_result ',
        'FROM ', Tbl_Name, ' ',
        'GROUP BY ', Grp_Fld, ' ',
        'ORDER BY ', Ord_Fld, ' ', Srt_Typ, ' ',
        'LIMIT ', Lmt_Rows
    );

    -- Debugging: Print the query (optional for testing)
    -- SELECT @sql_query;

    -- Prepare and execute the dynamic query
    PREPARE statement FROM @sql_query;
    EXECUTE statement;

    -- Clean up the prepared statement
    DEALLOCATE PREPARE statement;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getGroupedData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getGroupedData`(
    IN Tbl_Name text,       
    IN Grp_Fld VARCHAR(64),  
    IN Agg_Fld VARCHAR(64), 
    IN Agg_Func VARCHAR(20),
    IN Where_Condition VARCHAR(255)
)
BEGIN
    -- Validate the aggregate function
    IF Agg_Func NOT IN ('SUM', 'AVG', 'MAX', 'MIN', 'COUNT') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid aggregate function';
    END IF;

    -- Construct the dynamic SQL query
    SET @sql_query = CONCAT(
        'SELECT ', Grp_Fld, ', ',
        Agg_Func, '(', Agg_Fld, ') AS Agg_Res ',
        'FROM ', Tbl_Name
    );

    -- Append WHERE condition if provided
    IF Where_Condition IS NOT NULL AND Where_Condition != '' THEN
        SET @sql_query = CONCAT(@sql_query, ' WHERE ', Where_Condition);
    END IF;

    -- Add GROUP BY clause
    SET @sql_query = CONCAT(@sql_query, ' GROUP BY ', Grp_Fld);

    -- Debugging: Print the query (optional for testing)
    -- SELECT @sql_query;

    -- Prepare and execute the dynamic query
    PREPARE statement FROM @sql_query;
    EXECUTE statement;

    -- Clean up the prepared statement
    DEALLOCATE PREPARE statement;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getJoinedData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getJoinedData`(
    IN Sc_Tbl_Name VARCHAR(64),        -- Main table name
    IN Join_Clauses TEXT,              -- Join clauses (JSON or text)
    IN Fld_Nms TEXT,           -- Fields to select
    IN Where_Clause TEXT               -- Optional WHERE condition
)
BEGIN

    -- Initialize the dynamic SQL query
    SET @sql_query = CONCAT('SELECT ', Fld_Nms, ' FROM ', Sc_Tbl_Name);

    -- Append join clauses if provided
    IF Join_Clauses IS NOT NULL AND LENGTH(Join_Clauses) > 0 THEN
        SET @sql_query = CONCAT(@sql_query, ' ', Join_Clauses);
    END IF;

    -- Append the WHERE clause if provided
    IF Where_Clause IS NOT NULL AND LENGTH(Where_Clause) > 0 THEN
        -- Ensure WHERE is only added if it's not already present
        IF LOCATE('WHERE', @sql_query) = 0 THEN
            SET @sql_query = CONCAT(@sql_query, ' WHERE ', Where_Clause);
        ELSE
            SET @sql_query = CONCAT(@sql_query, ' AND ', Where_Clause);
        END IF;
    END IF;

    -- Debugging: Print the query (optional for testing)
    -- SELECT @sql_query;

    -- Prepare and execute the dynamic query
    PREPARE statement FROM @sql_query;
    EXECUTE statement;

    -- Clean up the prepared statement
    DEALLOCATE PREPARE statement;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRecordByPK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRecordByPK`(
IN Tbl_Name varchar(60),
IN PK_Name varchar(60),
IN PK_Value varchar(60))
BEGIN
	if Tbl_Name is NULL then
		set Tbl_Name = 'st_state';
	end if;
    if PK_Name is NULL then 
		set PK_Name = 'id';
	end if;
    if PK_Value is NULL then 
		set PK_Value = 1;
	end if;
    
     SET @sql_query = CONCAT('SELECT * FROM ', Tbl_Name, ' WHERE ', PK_Name, ' = ?');

    -- Prepare the dynamic query
    PREPARE statement FROM @sql_query;
	SET @key_value = PK_Value; -- Pass the primary key value
    EXECUTE statement USING @key_value; -- Execute the query with the provided column_value
    
    -- Clean up the prepared statement
    DEALLOCATE PREPARE statement;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRecordsByFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRecordsByFields`(
IN Tbl_Name TEXT,
IN Field_Names varchar(350),
IN Where_Condition varchar(350)
)
BEGIN
    
    -- Variable to hold the dynamic query
    SET @sql_query = CONCAT('SELECT ', Field_Names, ' FROM ', Tbl_Name);

    -- Add WHERE condition if provided
    IF where_condition IS NOT NULL AND where_condition <> '' THEN
        SET @sql_query = CONCAT(@sql_query, ' WHERE ', Where_Condition);
    END IF;
	
    -- Prepare the dynamic SQL statement
    PREPARE statement FROM @sql_query;

    -- Execute the prepared statement
    EXECUTE statement;

	
    -- Clean up the prepared statement
    DEALLOCATE PREPARE statement;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetReportCountDynamic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetReportCountDynamic`(
    IN tableName VARCHAR(255),
    IN dateField VARCHAR(255),
    IN reportType ENUM('daily', 'weekly', 'monthly', 'yearly'),
    IN startDate DATE,
    IN endDate DATE
)
BEGIN
    DECLARE queryText TEXT;
    DECLARE dynamicYears TEXT;

    -- Default endDate to the current date if NULL
    IF endDate IS NULL THEN
        SET endDate = CURDATE();
    END IF;

    -- Validate reportType
    IF reportType NOT IN ('daily', 'weekly', 'monthly', 'yearly') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid reportType. Valid values are daily, weekly, monthly, yearly.';
    END IF;

    -- Validate tableName and dateField
    IF tableName IS NULL OR tableName = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'tableName cannot be NULL or empty.';
    END IF;

    IF dateField IS NULL OR dateField = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'dateField cannot be NULL or empty.';
    END IF;

    -- Generate dynamic range of years based on startDate and endDate
    SET dynamicYears = CONCAT(
        'SELECT DISTINCT YEAR(DATE_ADD("', startDate, '", INTERVAL seq YEAR)) AS year ',
        'FROM (SELECT 0 AS seq UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 ',
        'UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS x ',
        'WHERE YEAR(DATE_ADD("', startDate, '", INTERVAL seq YEAR)) <= YEAR("', endDate, '")'
    );

    -- Initialize the query string
    SET queryText = 'SELECT ';

    -- Handle the monthly report case
    IF reportType = 'monthly' THEN
        SET queryText = CONCAT(
            queryText,
            'years.year, months.month, ',
            'IFNULL(COUNT(t.', dateField, '), 0) AS totalCount ',
            'FROM (', dynamicYears, ') AS years ',
            'CROSS JOIN (SELECT 1 AS month UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL ',
            'SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL ',
            'SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL ',
            'SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12) AS months '
        );

        -- Perform a LEFT JOIN with conditions in the ON clause
        SET queryText = CONCAT(
            queryText,
            'LEFT JOIN ', tableName, ' t ON YEAR(t.', dateField, ') = years.year ',
            'AND MONTH(t.', dateField, ') = months.month ',
            'AND t.', dateField, ' >= "', startDate, '" AND t.', dateField, ' <= "', endDate, '" '
        );

        -- WHERE clause to filter months within the date range
        SET queryText = CONCAT(
            queryText,
            'WHERE (years.year > YEAR("', startDate, '") OR (years.year = YEAR("', startDate, '") AND months.month >= MONTH("', startDate, '"))) ',
            'AND (years.year < YEAR("', endDate, '") OR (years.year = YEAR("', endDate, '") AND months.month <= MONTH("', endDate, '"))) '
        );

        -- GROUP BY clause (group only by year and month)
        SET queryText = CONCAT(
            queryText,
            ' GROUP BY years.year, months.month '
        );

        -- ORDER BY clause for consistent output
        SET queryText = CONCAT(queryText, ' ORDER BY years.year, months.month');

    -- Handle the weekly report case (Fixed: Limit to 5 weeks per month)
    ELSEIF reportType = 'weekly' THEN
        SET queryText = CONCAT(
            queryText,
            'SELECT 
                years.year, 
                MONTH(t.', dateField, ') AS month, 
                CEIL(DAY(t.', dateField, ') / 7) AS week, 
                IFNULL(COUNT(t.', dateField, '), 0) AS totalCount 
            FROM ', tableName, ' t 
            JOIN (', dynamicYears, ') AS years 
                ON YEAR(t.', dateField, ') = years.year 
            WHERE t.', dateField, ' BETWEEN "', startDate, '" AND "', endDate, '" 
            GROUP BY years.year, month, week 
            ORDER BY years.year, month, week'
        );

    -- Handle the yearly report case
    ELSEIF reportType = 'yearly' THEN
        SET queryText = CONCAT(
            queryText,
            'years.year, ',
            'IFNULL(COUNT(t.', dateField, '), 0) AS totalCount ',
            'FROM (', dynamicYears, ') AS years ',
            'LEFT JOIN ', tableName, ' t ON YEAR(t.', dateField, ') = years.year ',
            'AND t.', dateField, ' >= "', startDate, '" AND t.', dateField, ' <= "', endDate, '" ',
            'GROUP BY years.year ',
            'ORDER BY years.year'
        );

    END IF;

    -- Prepare and execute the dynamic query
    SET @dynamicQuery = queryText;
    PREPARE stmt FROM @dynamicQuery;
    EXECUTE stmt;

    -- Clean up
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetReportWithFieldsDynamic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetReportWithFieldsDynamic`(
    IN tableName VARCHAR(255),
    IN fields VARCHAR(255), -- Comma-separated list of fields
    IN joinConditions TEXT, -- JOIN conditions
    IN startDate DATE,
    IN endDate DATE
)
BEGIN
    DECLARE queryText TEXT;

    -- Start constructing the query
    SET queryText = CONCAT('SELECT ', fields, ' FROM ', tableName);

    -- Add JOIN conditions if provided
    IF joinConditions IS NOT NULL AND joinConditions != '' THEN
        SET queryText = CONCAT(queryText, ' ', joinConditions);
    END IF;

    -- Add WHERE clause for date range
    IF startDate IS NOT NULL OR endDate IS NOT NULL THEN
        SET queryText = CONCAT(queryText, ' WHERE TRUE');

        IF startDate IS NOT NULL THEN
            SET queryText = CONCAT(queryText, ' AND rec_last_update_time >= "', startDate, '"');
        END IF;

        IF endDate IS NOT NULL THEN
            SET queryText = CONCAT(queryText, ' AND rec_last_update_time <= "', endDate, '"');
        END IF;
    END IF;

    -- Debugging: Output the dynamic query
    -- SELECT queryText;

    -- Prepare and execute the dynamic query
    SET @dynamicQuery = queryText;
    PREPARE stmt FROM @dynamicQuery;
    EXECUTE stmt;

    -- Clean up
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSortedData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSortedData`(
IN Tbl_Name text,
IN Order_Field_Name varchar(60),
IN Sort_Type varchar(10)
)
BEGIN

	IF sort_type NOT IN ('ASC', 'DESC') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid sort direction. Use ASC or DESC.';
    END IF;

    -- Construct the dynamic SQL query
    SET @sql_query = CONCAT('SELECT * FROM ', Tbl_Name, ' ORDER BY ', Order_Field_Name, ' ', Sort_Type);

    -- Debugging: Print the query (optional for testing)
    -- SELECT @sql_query;

    -- Prepare and execute the dynamic query
    PREPARE statement FROM @sql_query;
    EXECUTE statement;

    -- Clean up the prepared statement
    DEALLOCATE PREPARE statement;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateRecord` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateRecord`(
IN Tbl_Name varchar(60),
IN Field_Value_Pairs varchar(350),
IN Where_Condition varchar(350)
)
BEGIN

 -- Variable to hold the dynamic SQL query
    SET @sql_query = CONCAT('UPDATE ', Tbl_Name, ' SET ', field_value_pairs);

    -- Add WHERE clause if provided
    IF where_condition IS NOT NULL AND where_condition <> '' THEN
        SET @sql_query = CONCAT(@sql_query, ' WHERE ', Where_Condition);
    END IF;    

    -- Prepare and execute the query dynamically
    PREPARE statement FROM @sql_query;
    EXECUTE statement;

    -- Clean up the prepared statement
    DEALLOCATE PREPARE statement;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-30  8:52:44
