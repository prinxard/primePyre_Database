
CREATE DATABASE `primepyre_schema`; 
USE `primepyre_schema`;

CREATE TABLE IF NOT EXISTS `customers` (
  `customer_id` int  NOT NULL AUTO_INCREMENT,
  `name` varchar(100)  NOT NULL,
  `email` varchar(100)  NOT NULL,
  `phone` varchar(15)  NOT NULL,
  `address` text  NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `status` enum('1','0')  NOT NULL DEFAULT '1',
  PRIMARY KEY (`customer_id`)
);


CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `total_price` float(10,2) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `status` enum('1','0')  NOT NULL DEFAULT '1',
  PRIMARY KEY (`order_id`)
) ;



CREATE TABLE IF NOT EXISTS `order_items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `FK_order_id` (`order_id`),
  CONSTRAINT `FK_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `quantity_in_stock` int NOT NULL,
  `name` varchar(200)  NOT NULL,
  `product_category` varchar(100),
  `description` text  NOT NULL,
  `price` float(16,2) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `status` enum('1','0')  NOT NULL DEFAULT '1',
  PRIMARY KEY (`product_id`),
  KEY `FK_item_id` (`item_id`),
  CONSTRAINT `FK_item_id` FOREIGN KEY (`item_id`) REFERENCES `order_items` (`item_id`)
) ;

CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `payment_method` enum('inter switch','Paypal') NULL,
  `amount` decimal(16,2) NOT NULL,
  `date` datetime NOT NULL,
   `status` enum('1', '0') NOT NULL,
   PRIMARY KEY (`payment_id`),
   KEY `FK_product_id` (`product_id`),
   CONSTRAINT `FK_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
);



