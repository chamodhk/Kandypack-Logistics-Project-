CREATE DATABASE  IF NOT EXISTS `kandypacklogistics` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `kandypacklogistics`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: kandypacklogistics
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `assistant`
--

DROP TABLE IF EXISTS `assistant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assistant` (
  `employee_id` int NOT NULL,
  `consecutive_deliveries` int NOT NULL DEFAULT '0',
  `next_available_time` datetime NOT NULL,
  `status` enum('On Duty','Available','On Leave','Break') NOT NULL DEFAULT 'Available',
  `last_delivery_time` datetime DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `assistant_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `city_id` int NOT NULL AUTO_INCREMENT,
  `city_name` varchar(50) NOT NULL,
  PRIMARY KEY (`city_id`),
  UNIQUE KEY `city_name` (`city_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(50) NOT NULL,
  `registration_date` date NOT NULL,
  `customer_type_id` int DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `idx_customer_type` (`customer_type_id`),
  CONSTRAINT `customer_ibfk_2` FOREIGN KEY (`customer_type_id`) REFERENCES `customertype` (`customer_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customeraddress`
--

DROP TABLE IF EXISTS `customeraddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customeraddress` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `address_line_1` varchar(30) NOT NULL,
  `address_line_2` varchar(30) DEFAULT NULL,
  `city_id` int NOT NULL,
  `district` varchar(25) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`address_id`),
  KEY `city_id` (`city_id`),
  KEY `idx_customer_address` (`customer_id`,`city_id`),
  CONSTRAINT `customeraddress_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `customeraddress_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customercontactnumber`
--

DROP TABLE IF EXISTS `customercontactnumber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customercontactnumber` (
  `contact_number` varchar(10) NOT NULL,
  `customer_id` int NOT NULL,
  `is_primary` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`contact_number`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customercontactnumber_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customertype`
--

DROP TABLE IF EXISTS `customertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customertype` (
  `customer_type_id` int NOT NULL AUTO_INCREMENT,
  `customer_type` varchar(20) NOT NULL,
  `credit_limit` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`customer_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS `driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `driver` (
  `employee_id` int NOT NULL,
  `consecutive_deliveries` int NOT NULL DEFAULT '0',
  `next_available_time` datetime NOT NULL,
  `status` enum('On Duty','Available','On Leave','Break') NOT NULL DEFAULT 'Available',
  `last_delivery_time` datetime DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `driver_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `employee_nic` varchar(12) NOT NULL,
  `official_contact_number` varchar(10) DEFAULT NULL,
  `registrated_date` date NOT NULL,
  `employee_status` varchar(20) DEFAULT 'Active',
  `total_hours_week` double DEFAULT '0',
  `role_id` int NOT NULL,
  `store_id` int NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `employee_nic` (`employee_nic`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_employee_role` (`role_id`),
  KEY `idx_employee_store` (`store_id`),
  KEY `idx_employee_status` (`employee_status`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`),
  CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `address_id` int DEFAULT NULL,
  `order_date` date NOT NULL,
  `required_date` date NOT NULL,
  `status` varchar(20) DEFAULT 'Pending',
  `placed_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `packed_date` datetime DEFAULT NULL,
  `total_quantity` int DEFAULT '0',
  `total_price` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`order_id`),
  KEY `idx_order_customer` (`customer_id`),
  KEY `idx_order_date` (`order_date`),
  KEY `idx_order_status` (`status`),
  KEY `order_ibfk_2` (`address_id`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `customeraddress` (`address_id`),
  CONSTRAINT `order_chk_1` CHECK ((`required_date` >= (`order_date` + interval 7 day)))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orderitem`
--

DROP TABLE IF EXISTS `orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitem` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `product_id` (`product_id`),
  KEY `idx_orderitem_order` (`order_id`),
  CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) NOT NULL,
  `unit_space` float NOT NULL,
  `unit_price` float NOT NULL,
  `product_type_id` int NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `fk_product_type` (`product_type_id`),
  CONSTRAINT `fk_product_type` FOREIGN KEY (`product_type_id`) REFERENCES `product_type` (`product_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_type`
--

DROP TABLE IF EXISTS `product_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_type` (
  `product_type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  PRIMARY KEY (`product_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `max_hours_week` double NOT NULL,
  PRIMARY KEY (`role_id`),
  CONSTRAINT `roles_chk_1` CHECK ((`max_hours_week` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store` (
  `store_id` int NOT NULL AUTO_INCREMENT,
  `store_name` varchar(50) NOT NULL,
  `contact_number` varchar(10) NOT NULL,
  `city_id` int DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  KEY `fk_store_city` (`city_id`),
  CONSTRAINT `fk_store_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `train_id` int NOT NULL AUTO_INCREMENT,
  `train_name` varchar(50) NOT NULL,
  `start_station` varchar(50) NOT NULL,
  `destination_station` varchar(50) NOT NULL,
  `departure_date_time` datetime NOT NULL,
  `arrival_date_time` datetime NOT NULL,
  `capacity_space` double NOT NULL,
  `status` varchar(20) DEFAULT 'on-time',
  `template_id` int DEFAULT NULL,
  PRIMARY KEY (`train_id`),
  KEY `template_id` (`template_id`),
  CONSTRAINT `train_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `traintemplate` (`template_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trainallocation`
--

DROP TABLE IF EXISTS `trainallocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainallocation` (
  `trip_id` int NOT NULL AUTO_INCREMENT,
  `train_id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `store_id` int NOT NULL,
  `allocated_qty` int NOT NULL,
  `start_date_time` datetime NOT NULL,
  `reached_date_time` datetime DEFAULT NULL,
  `status` varchar(30) DEFAULT 'Allocated',
  `unit_space` double NOT NULL,
  `total_space_used` double GENERATED ALWAYS AS ((`allocated_qty` * `unit_space`)) STORED,
  PRIMARY KEY (`trip_id`),
  KEY `order_id` (`order_id`,`product_id`),
  KEY `store_id` (`store_id`),
  KEY `idx_train_allocation` (`train_id`,`order_id`,`product_id`),
  CONSTRAINT `trainallocation_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `train` (`train_id`) ON DELETE CASCADE,
  CONSTRAINT `trainallocation_ibfk_2` FOREIGN KEY (`order_id`, `product_id`) REFERENCES `orderitem` (`order_id`, `product_id`) ON DELETE CASCADE,
  CONSTRAINT `trainallocation_ibfk_3` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `traintemplate`
--

DROP TABLE IF EXISTS `traintemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traintemplate` (
  `template_id` int NOT NULL AUTO_INCREMENT,
  `train_name` varchar(50) NOT NULL,
  `start_station` varchar(50) NOT NULL,
  `destination_station` varchar(50) NOT NULL,
  `departure_time` time NOT NULL,
  `arrival_time` time NOT NULL,
  `capacity_space` double NOT NULL,
  `status` varchar(20) DEFAULT 'on-time',
  `frequency_days` varchar(100) NOT NULL DEFAULT 'Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday',
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `truck`
--

DROP TABLE IF EXISTS `truck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `truck` (
  `truck_id` int NOT NULL AUTO_INCREMENT,
  `store_id` int NOT NULL,
  `plate_number` varchar(10) NOT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`truck_id`),
  UNIQUE KEY `plate_number` (`plate_number`),
  KEY `idx_truck_store` (`store_id`),
  CONSTRAINT `truck_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `truckdelivery`
--

DROP TABLE IF EXISTS `truckdelivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `truckdelivery` (
  `delivery_id` int NOT NULL AUTO_INCREMENT,
  `store_id` int NOT NULL,
  `order_id` int NOT NULL,
  `route_id` varchar(5) NOT NULL,
  `truck_id` int NOT NULL,
  `scheduled_departure` datetime NOT NULL,
  `actual_departure` datetime DEFAULT NULL,
  `actual_arrival` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Scheduled',
  PRIMARY KEY (`delivery_id`),
  KEY `store_id` (`store_id`),
  KEY `idx_delivery_order` (`order_id`),
  KEY `idx_delivery_route` (`route_id`),
  KEY `idx_delivery_truck` (`truck_id`),
  KEY `idx_delivery_date` (`scheduled_departure`),
  CONSTRAINT `truckdelivery_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`),
  CONSTRAINT `truckdelivery_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`),
  CONSTRAINT `truckdelivery_ibfk_3` FOREIGN KEY (`route_id`) REFERENCES `truckroute` (`route_id`),
  CONSTRAINT `truckdelivery_ibfk_4` FOREIGN KEY (`truck_id`) REFERENCES `truck` (`truck_id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `truckemployeeassignment`
--

DROP TABLE IF EXISTS `truckemployeeassignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `truckemployeeassignment` (
  `assignment_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `truck_delivery_id` int NOT NULL,
  `assigned_hours` double DEFAULT '0',
  PRIMARY KEY (`assignment_id`),
  KEY `idx_assignment_employee` (`employee_id`),
  KEY `idx_assignment_delivery` (`truck_delivery_id`),
  CONSTRAINT `truckemployeeassignment_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `truckemployeeassignment_ibfk_2` FOREIGN KEY (`truck_delivery_id`) REFERENCES `truckdelivery` (`delivery_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_consecutive_driver_deliveries` BEFORE INSERT ON `truckemployeeassignment` FOR EACH ROW BEGIN
    DECLARE role_name VARCHAR(20);
    DECLARE last_delivery_time DATETIME;
    DECLARE new_delivery_time DATETIME;

    SELECT r.role_name 
    INTO role_name
    FROM employee e
    JOIN roles r ON e.role_id = r.role_id
    WHERE e.employee_id = NEW.employee_id;

    IF role_name = 'Driver' THEN
        SELECT td.scheduled_departure 
        INTO new_delivery_time
        FROM truckdelivery td
        WHERE td.delivery_id = NEW.truck_delivery_id;

        SELECT td.scheduled_departure
        INTO last_delivery_time
        FROM truckemployeeassignment tea
        JOIN truckdelivery td ON tea.truck_delivery_id = td.delivery_id
        WHERE tea.employee_id = NEW.employee_id
        ORDER BY td.scheduled_departure DESC
        LIMIT 1;

        IF last_delivery_time IS NOT NULL 
           AND ABS(TIMESTAMPDIFF(HOUR, last_delivery_time, new_delivery_time)) < 4 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Driver cannot be assigned to consecutive deliveries without rest period.';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_weekly_hours` BEFORE INSERT ON `truckemployeeassignment` FOR EACH ROW BEGIN
    DECLARE total_hours DOUBLE DEFAULT 0;
    DECLARE role_name VARCHAR(20) DEFAULT '';
    DECLARE max_hours DOUBLE DEFAULT 0;
    DECLARE new_delivery_week INT DEFAULT 0;
    DECLARE msg VARCHAR(255) DEFAULT '';

    SELECT r.role_name, r.max_hours_week
    INTO role_name, max_hours
    FROM employee e
    JOIN roles r ON e.role_id = r.role_id
    WHERE e.employee_id = NEW.employee_id
    LIMIT 1;

    SELECT WEEK(td.scheduled_departure)
    INTO new_delivery_week
    FROM truckdelivery td
    WHERE td.delivery_id = NEW.truck_delivery_id
    LIMIT 1;

    SELECT IFNULL(SUM(ta.assigned_hours), 0)
    INTO total_hours
    FROM truckemployeeassignment ta
    JOIN truckdelivery td ON ta.truck_delivery_id = td.delivery_id
    WHERE ta.employee_id = NEW.employee_id
      AND WEEK(td.scheduled_departure) = new_delivery_week;

    IF total_hours + NEW.assigned_hours > max_hours THEN
        SET msg = CONCAT('Weekly hour limit exceeded for ', role_name, '. Max allowed: ', max_hours, ' hours. Currently assigned: ', total_hours + NEW.assigned_hours);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `truckroute`
--

DROP TABLE IF EXISTS `truckroute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `truckroute` (
  `route_id` varchar(5) NOT NULL,
  `area_name` varchar(20) NOT NULL,
  `max_delivery_time` double NOT NULL,
  PRIMARY KEY (`route_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `truckstopsat`
--

DROP TABLE IF EXISTS `truckstopsat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `truckstopsat` (
  `route_id` varchar(5) NOT NULL,
  `city_id` int NOT NULL,
  `stop_sequence` int NOT NULL,
  PRIMARY KEY (`route_id`,`city_id`),
  KEY `idx_truckstops_city` (`city_id`),
  CONSTRAINT `truckstopsat_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `truckroute` (`route_id`) ON DELETE CASCADE,
  CONSTRAINT `truckstopsat_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'kandypacklogistics'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `generate_trains_rolling_14d` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `generate_trains_rolling_14d` ON SCHEDULE EVERY 1 DAY STARTS '2025-10-21 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  CALL sp_populate_trains_for_next_n_days(14);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'kandypacklogistics'
--
/*!50003 DROP PROCEDURE IF EXISTS `finish_truck_delivery` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `finish_truck_delivery`(IN p_delivery_id INT)
BEGIN
    -- Declare variables
    DECLARE p_order_id INT;
    DECLARE p_truck_id INT;
    DECLARE v_departure_time DATETIME;
    DECLARE v_duration_hours DOUBLE;

    -- Error handler for transaction rollback
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Transaction failed. Delivery completion rolled back.';
    END;

    START TRANSACTION;

    -- 1️⃣ Get related order, truck, and actual departure time
    SELECT order_id, truck_id, actual_departure 
    INTO p_order_id, p_truck_id, v_departure_time
    FROM truckdelivery 
    WHERE delivery_id = p_delivery_id
    FOR UPDATE;

    -- 2️⃣ Calculate duration from actual departure to now
    -- (in hours, fractional precision)
    SET v_duration_hours = TIMESTAMPDIFF(MINUTE, v_departure_time, NOW()) / 60;

    -- 3️⃣ Mark delivery as completed
    UPDATE truckdelivery
    SET status = 'Delivered',
        actual_arrival = NOW()
    WHERE delivery_id = p_delivery_id;

    -- 4️⃣ Free the truck
    UPDATE truck
    SET is_available = 1
    WHERE truck_id = p_truck_id;

    -- 5️⃣ Mark the order as delivered
    UPDATE `order`
    SET status = 'Delivered'
    WHERE order_id = p_order_id;

    -- 6️⃣ Update employee total weekly hours 
    -- Add both assigned hours (if any) and calculated duration hours
    UPDATE employee e
    JOIN truckemployeeassignment tea ON e.employee_id = tea.employee_id
    SET e.total_hours_week = e.total_hours_week + IFNULL(v_duration_hours, 0)
    WHERE tea.truck_delivery_id = p_delivery_id;

    -- 7️⃣ Update driver (must rest after each delivery)
    UPDATE driver d
    JOIN truckemployeeassignment tea ON d.employee_id = tea.employee_id
    JOIN employee e ON e.employee_id = tea.employee_id
    SET d.status = 'Break',
        d.consecutive_deliveries = 0,
        d.last_delivery_time = NOW(),
        d.next_available_time = DATE_ADD(NOW(), INTERVAL 4 HOUR)
    WHERE e.role_id = 2
      AND tea.truck_delivery_id = p_delivery_id;

    -- 8️⃣ Update assistant (can do up to 2 consecutive deliveries)
    UPDATE assistant a
    JOIN truckemployeeassignment tea ON a.employee_id = tea.employee_id
    JOIN employee e ON e.employee_id = tea.employee_id
    SET a.consecutive_deliveries = a.consecutive_deliveries + 1,
        a.last_delivery_time = NOW(),
        a.next_available_time =
            CASE
                WHEN a.consecutive_deliveries + 1 >= 2 THEN DATE_ADD(NOW(), INTERVAL 2 HOUR)
                ELSE NOW()
            END,
        a.status =
            CASE
                WHEN a.consecutive_deliveries + 1 >= 2 THEN 'Break'
                ELSE 'Available'
            END
    WHERE e.role_id = 4
      AND tea.truck_delivery_id = p_delivery_id;

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEmployeeInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEmployeeInfo`(IN emp_id INT)
BEGIN
    DECLARE emp_role INT;
    SELECT role_id INTO emp_role
    FROM employee
    WHERE employee_id = emp_id;
    IF emp_role = 2 THEN
        SELECT 
            e.employee_id,
            e.employee_name,
            e.username,
            e.official_contact_number,
            e.employee_nic,
            e.registrated_date,
            e.role_id,
            e.store_id,
            d.status,
            e.total_hours_week,
            d.consecutive_deliveries,
            d.next_available_time,
            d.last_delivery_time
        FROM employee e
        LEFT JOIN driver d ON e.employee_id = d.employee_id
        WHERE e.employee_id = emp_id;
    ELSEIF emp_role = 3 THEN
        SELECT 
            e.employee_id,
            e.employee_name,
            e.username,
            e.official_contact_number,
            e.employee_nic,
            e.registrated_date,
            e.role_id,
            e.store_id,
            a.status,
            a.total_hours_week,
            a.consecutive_deliveries,
            a.next_available_time,
            a.last_delivery_time
        FROM employee e
        LEFT JOIN assistant a ON e.employee_id = a.employee_id
        WHERE e.employee_id = emp_id;
    ELSE
        SELECT 
            e.employee_id,
            e.employee_name,
            e.username,
            e.official_contact_number,
            e.employee_nic,
            e.registrated_date,
            e.role_id,
            e.store_id,
            NULL AS status,
            NULL AS total_hours_week,
            NULL AS consecutive_deliveries,
            NULL AS next_available_time,
            NULL AS last_delivery_time
        FROM employee e
        WHERE e.employee_id = emp_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_active_deliveries_for_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_active_deliveries_for_user`(
IN p_role VARCHAR(50),
IN p_store_id INT
)
BEGIN
IF p_role = 'store_manager' THEN
SELECT tr.route_id,
td.delivery_id,
tr.max_delivery_time,
td.actual_departure
FROM truckdelivery td
JOIN truckroute tr USING(route_id)
WHERE td.status <> 'Delivered'
AND td.store_id = p_store_id;
ELSE
SELECT tr.route_id,
td.delivery_id,
tr.max_delivery_time,
td.actual_departure
FROM truckdelivery td
JOIN truckroute tr USING(route_id)
WHERE td.status <> 'Delivered';
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_assistants_for_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_assistants_for_user`(
    IN p_role VARCHAR(50),
    IN p_store_id INT
)
BEGIN
    IF p_role = 'store_manager' THEN
        SELECT 
            e.employee_id,
            e.employee_name,
            e.total_hours_week,
            e.official_contact_number,
            a.status,
            a.consecutive_deliveries,
            a.next_available_time
        FROM assistant a
        JOIN employee e USING (employee_id)
        WHERE e.store_id = p_store_id;
    ELSE
        SELECT 
            e.employee_id,
            e.employee_name,
            e.total_hours_week,
            e.official_contact_number,
            a.status,
            a.consecutive_deliveries,
            a.next_available_time,
            e.store_id
        FROM assistant a
        JOIN employee e USING (employee_id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_drivers_for_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_drivers_for_user`(
    IN p_role VARCHAR(50),
    IN p_store_id INT
)
BEGIN
    IF p_role = 'store_manager' THEN
        SELECT e.employee_id,
                e.employee_name,
                e.total_hours_week,
                e.official_contact_number,
                d.consecutive_deliveries,
                d.next_available_time
        FROM driver d
        JOIN employee e using (employee_id)
        WHERE e.store_id = p_store_id;
    ELSE
        SELECT e.employee_id,
                e.employee_name,
                e.total_hours_week,
                e.official_contact_number,
                d.next_available_time
        FROM driver d
        JOIN employee e using (employee_id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_eligible_employees_for_route` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_eligible_employees_for_route`(
    IN p_store_id INT,
    IN p_route_id VARCHAR(5)
)
BEGIN
    DECLARE v_route_hours DOUBLE;

    -- 1️⃣ Get max delivery time for the route
    SELECT max_delivery_time 
    INTO v_route_hours
    FROM truckroute
    WHERE route_id = p_route_id;

    -- 2️⃣ Eligible Drivers
    SELECT 
        e.employee_id,
        e.employee_name,
        'Driver' AS role,
        e.total_hours_week,
        d.status,
        d.next_available_time,
        d.consecutive_deliveries,
        r.max_hours_week,
        v_route_hours AS upcoming_delivery_hours,
        ROUND(e.total_hours_week + v_route_hours, 2) AS projected_total_hours
    FROM driver d
    JOIN employee e ON d.employee_id = e.employee_id
    JOIN roles r ON e.role_id = r.role_id
    WHERE 
        e.store_id = p_store_id
        AND d.status = 'Available'
        AND d.next_available_time <= NOW()
        AND (e.total_hours_week + v_route_hours) <= r.max_hours_week
        AND d.consecutive_deliveries = 0   -- Drivers must rest between deliveries
        AND e.employee_id NOT IN (
            SELECT tea.employee_id
            FROM truckemployeeassignment tea
            JOIN truckdelivery td ON tea.truck_delivery_id = td.delivery_id
            WHERE td.status IN ('Scheduled', 'On Route')
        )
    UNION ALL
    -- 3️⃣ Eligible Assistants
    SELECT 
        e.employee_id,
        e.employee_name,
        'Assistant' AS role,
        e.total_hours_week,
        a.status,
        a.next_available_time,
        a.consecutive_deliveries,
        r.max_hours_week,
        v_route_hours AS upcoming_delivery_hours,
        ROUND(e.total_hours_week + v_route_hours, 2) AS projected_total_hours
    FROM assistant a
    JOIN employee e ON a.employee_id = e.employee_id
    JOIN roles r ON e.role_id = r.role_id
    WHERE 
        e.store_id = p_store_id
        AND a.status = 'Available'
        AND a.next_available_time <= NOW()
        AND (e.total_hours_week + v_route_hours) <= r.max_hours_week
        AND a.consecutive_deliveries < 2
        AND e.employee_id NOT IN (
            SELECT tea.employee_id
            FROM truckemployeeassignment tea
            JOIN truckdelivery td ON tea.truck_delivery_id = td.delivery_id
            WHERE td.status IN ('Scheduled', 'On Route')
        );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_summary_for_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_summary_for_user`(
    IN p_role VARCHAR(50),
    IN p_store_id INT
)
BEGIN
    DECLARE on_duty_drivers INT DEFAULT 0;
    DECLARE on_duty_assistants INT DEFAULT 0;
    DECLARE available_to_schedule INT DEFAULT 0;
    IF p_role = 'store_manager' THEN
        SELECT 
            SUM(CASE WHEN e.role_id = 2 AND d.status = 'On Duty' THEN 1 ELSE 0 END) AS on_duty_drivers,
            SUM(CASE WHEN e.role_id = 1 AND a.status = 'On Duty' THEN 1 ELSE 0 END) AS on_duty_assistants,
            SUM(CASE 
                    WHEN (d.status = 'Available' AND d.next_available_time <= NOW()) OR 
                         (a.status = 'Available' AND a.next_available_time <= NOW())
                    THEN 1 ELSE 0 
                END) AS available_to_schedule
        INTO on_duty_drivers, on_duty_assistants, available_to_schedule
        FROM employee e
        LEFT JOIN driver d ON e.employee_id = d.employee_id
        LEFT JOIN assistant a ON e.employee_id = a.employee_id
        WHERE e.store_id = p_store_id;
    ELSE
        SELECT 
            SUM(CASE WHEN e.role_id = 2 AND d.status = 'On Duty' THEN 1 ELSE 0 END) AS on_duty_drivers,
            SUM(CASE WHEN e.role_id = 1 AND a.status = 'On Duty' THEN 1 ELSE 0 END) AS on_duty_assistants,
            SUM(CASE 
                    WHEN (d.status = 'Available' AND d.next_available_time <= NOW()) OR 
                         (a.status = 'Available' AND a.next_available_time <= NOW())
                    THEN 1 ELSE 0 
                END) AS available_to_schedule
        INTO on_duty_drivers, on_duty_assistants, available_to_schedule
        FROM employee e
        LEFT JOIN driver d ON e.employee_id = d.employee_id
        LEFT JOIN assistant a ON e.employee_id = a.employee_id;
    END IF;
    SELECT 
        on_duty_drivers AS on_duty_drivers,
        40 AS drivers_weekly_limit,
        on_duty_assistants AS on_duty_assistants,
        60 AS assistants_weekly_limit,
        available_to_schedule AS available_to_schedule,
        'Compliance met' AS compliance;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_trucks_for_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_trucks_for_user`(
    IN p_role VARCHAR(50),
    IN p_store_id INT
)
BEGIN
    IF p_role = 'store_manager' THEN
        SELECT t.truck_id,
               t.plate_number,
               t.is_available
        FROM truck t
        WHERE t.store_id = p_store_id;
    ELSE
        SELECT *
        FROM truck;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_populate_trains_for_next_n_days` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_populate_trains_for_next_n_days`(IN days_ahead INT)
BEGIN
  DECLARE d INT DEFAULT 0;
  DECLARE target_date DATE;
  WHILE d < days_ahead DO
    SET target_date = DATE_ADD(CURDATE(), INTERVAL d DAY);
    INSERT INTO Train (
      train_name,
      start_station,
      destination_station,
      departure_date_time,
      arrival_date_time,
      capacity_space,
      status,
      template_id
    )
    SELECT
      t.train_name,
      t.start_station,
      t.destination_station,
      CONCAT(target_date, ' ', t.departure_time),
      CONCAT(target_date, ' ', t.arrival_time),
      t.capacity_space,
      t.status,
      t.template_id
    FROM TrainTemplate t
    JOIN (
      SELECT 0 AS offset,'Monday' AS day_name UNION ALL
      SELECT 1,'Tuesday' UNION ALL
      SELECT 2,'Wednesday' UNION ALL
      SELECT 3,'Thursday' UNION ALL
      SELECT 4,'Friday' UNION ALL
      SELECT 5,'Saturday' UNION ALL
      SELECT 6,'Sunday'
    ) days
      ON days.offset = WEEKDAY(target_date)
     AND FIND_IN_SET(days.day_name, t.frequency_days) > 0
    WHERE NOT EXISTS (
      SELECT 1
      FROM Train tr
      WHERE tr.template_id = t.template_id
        AND DATE(tr.departure_date_time) = target_date
    );
    SET d = d + 1;
  END WHILE;
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

-- Dump completed on 2025-12-08  2:37:23
