/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `thrift_shop_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `thrift_shop_db`;

CREATE TABLE IF NOT EXISTS `tbl_category` (
  `categoryID` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DELETE FROM `tbl_category`;
INSERT INTO `tbl_category` (`categoryID`, `category_name`, `createdAt`, `updatedAt`) VALUES
	(1, 'T-Shirts', '2026-05-21 05:17:03', '2026-05-21 05:17:03'),
	(2, 'Pants', '2026-05-21 05:17:03', '2026-05-21 05:17:03'),
	(3, 'Jackets', '2026-05-21 05:17:03', '2026-05-21 05:17:03'),
	(4, 'Shoes', '2026-05-21 05:17:03', '2026-05-21 05:17:03'),
	(5, 'Bags', '2026-05-21 05:17:03', '2026-05-21 05:17:03'),
	(6, 'Accessories', '2026-05-21 05:17:03', '2026-05-21 05:17:03');

CREATE TABLE IF NOT EXISTS `tbl_order` (
  `orderID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) DEFAULT 0.00,
  `order_status` varchar(50) DEFAULT 'Pending',
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`orderID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DELETE FROM `tbl_order`;
INSERT INTO `tbl_order` (`orderID`, `userID`, `order_date`, `total_amount`, `order_status`, `createdAt`, `updatedAt`) VALUES
	(1, 2, '2026-05-01 10:30:00', 530.00, 'Completed', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(2, 3, '2026-05-03 14:15:00', 950.00, 'Completed', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(3, 4, '2026-05-05 09:45:00', 300.00, 'Pending', '2026-05-21 05:17:04', '2026-05-21 05:17:04');

CREATE TABLE IF NOT EXISTS `tbl_order_item` (
  `orderItemID` int(11) NOT NULL AUTO_INCREMENT,
  `orderID` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`orderItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DELETE FROM `tbl_order_item`;
INSERT INTO `tbl_order_item` (`orderItemID`, `orderID`, `productID`, `quantity`, `price`, `subtotal`, `createdAt`, `updatedAt`) VALUES
	(1, 1, 1, 1, 180.00, 180.00, '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(2, 1, 4, 1, 350.00, 350.00, '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(3, 2, 7, 1, 500.00, 500.00, '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(4, 2, 11, 1, 450.00, 450.00, '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(5, 3, 5, 1, 300.00, 300.00, '2026-05-21 05:17:04', '2026-05-21 05:17:04');

CREATE TABLE IF NOT EXISTS `tbl_payment` (
  `paymentID` int(11) NOT NULL AUTO_INCREMENT,
  `orderID` int(11) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_amount` decimal(10,2) NOT NULL,
  `payment_status` int(11) DEFAULT 1,
  `payment_date` datetime DEFAULT current_timestamp(),
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`paymentID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DELETE FROM `tbl_payment`;
INSERT INTO `tbl_payment` (`paymentID`, `orderID`, `payment_method`, `payment_amount`, `payment_status`, `payment_date`, `createdAt`, `updatedAt`) VALUES
	(1, 1, 'Cash', 530.00, 0, '2026-05-01 10:35:00', '2026-05-21 05:17:04', '2026-05-21 05:35:46'),
	(2, 2, 'GCash', 950.00, 0, '2026-05-03 14:20:00', '2026-05-21 05:17:04', '2026-05-21 05:35:46'),
	(3, 3, 'Cash', 300.00, 1, '2026-05-05 09:50:00', '2026-05-21 05:17:04', '2026-05-21 05:35:46');

CREATE TABLE IF NOT EXISTS `tbl_product` (
  `productID` int(11) NOT NULL AUTO_INCREMENT,
  `categoryID` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_desc` varchar(255) DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `condition_status` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `product_status` varchar(50) DEFAULT 'Available',
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`productID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DELETE FROM `tbl_product`;
INSERT INTO `tbl_product` (`productID`, `categoryID`, `product_name`, `product_desc`, `size`, `color`, `condition_status`, `price`, `product_status`, `createdAt`, `updatedAt`) VALUES
	(1, 1, 'Vintage Graphic T-Shirt', 'Pre-loved graphic shirt with retro print', 'Medium', 'Black', 'Good', 180.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(2, 1, 'Plain Cotton Shirt', 'Simple cotton shirt for casual wear', 'Large', 'White', 'Like New', 150.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(3, 1, 'Oversized Streetwear Tee', 'Loose fit streetwear t-shirt', 'XL', 'Gray', 'Good', 220.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(4, 2, 'Denim Jeans', 'Classic blue denim jeans', '32', 'Blue', 'Good', 350.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(5, 2, 'Cargo Pants', 'Utility cargo pants with side pockets', '34', 'Olive Green', 'Fair', 300.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(6, 2, 'Black Slacks', 'Formal black pants', '30', 'Black', 'Like New', 280.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(7, 3, 'Denim Jacket', 'Vintage denim jacket', 'Large', 'Blue', 'Good', 500.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(8, 3, 'Windbreaker Jacket', 'Lightweight windbreaker jacket', 'Medium', 'Red', 'Fair', 420.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(9, 3, 'Hooded Jacket', 'Comfortable hoodie jacket', 'Large', 'Navy Blue', 'Good', 450.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(10, 4, 'White Sneakers', 'Casual white sneakers', '9', 'White', 'Good', 600.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(11, 4, 'Running Shoes', 'Used running shoes', '8', 'Black', 'Fair', 450.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(12, 4, 'Leather Loafers', 'Formal leather loafers', '10', 'Brown', 'Like New', 700.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(13, 5, 'Canvas Tote Bag', 'Simple reusable tote bag', 'One Size', 'Beige', 'Good', 200.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(14, 5, 'Mini Backpack', 'Small casual backpack', 'One Size', 'Black', 'Good', 350.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(15, 5, 'Shoulder Bag', 'Trendy shoulder bag', 'One Size', 'Brown', 'Fair', 250.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(16, 6, 'Baseball Cap', 'Adjustable cap', 'One Size', 'Black', 'Good', 120.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(17, 6, 'Silver Necklace', 'Simple fashion necklace', 'One Size', 'Silver', 'Like New', 180.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(18, 6, 'Leather Belt', 'Classic leather belt', 'Medium', 'Brown', 'Good', 150.00, 'Available', '2026-05-21 05:17:04', '2026-05-21 05:17:04');

CREATE TABLE IF NOT EXISTS `tbl_role` (
  `roleID` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`roleID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DELETE FROM `tbl_role`;
INSERT INTO `tbl_role` (`roleID`, `role_name`, `createdAt`, `updatedAt`) VALUES
	(1, 'Admin', '2026-05-21 05:17:03', '2026-05-21 05:17:03'),
	(2, 'Customer', '2026-05-21 05:17:03', '2026-05-21 05:17:03');

CREATE TABLE IF NOT EXISTS `tbl_stock` (
  `stockID` int(11) NOT NULL AUTO_INCREMENT,
  `productID` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `stock_status` varchar(50) DEFAULT 'In Stock',
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`stockID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DELETE FROM `tbl_stock`;
INSERT INTO `tbl_stock` (`stockID`, `productID`, `quantity`, `stock_status`, `createdAt`, `updatedAt`) VALUES
	(1, 1, 5, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(2, 2, 8, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(3, 3, 4, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(4, 4, 6, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(5, 5, 3, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(6, 6, 5, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(7, 7, 2, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(8, 8, 3, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(9, 9, 4, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(10, 10, 2, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(11, 11, 3, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(12, 12, 1, 'Low Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(13, 13, 6, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(14, 14, 3, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(15, 15, 2, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(16, 16, 7, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(17, 17, 4, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04'),
	(18, 18, 5, 'In Stock', '2026-05-21 05:17:04', '2026-05-21 05:17:04');

CREATE TABLE IF NOT EXISTS `tbl_user` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `roleID` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` varchar(50) DEFAULT 'Active',
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DELETE FROM `tbl_user`;
INSERT INTO `tbl_user` (`userID`, `roleID`, `full_name`, `email`, `contact_number`, `username`, `password`, `status`, `createdAt`, `updatedAt`) VALUES
	(1, 1, 'qq', NULL, 'qq', 'qq', 'qq', 'Active', '2026-05-20 14:42:42', '2026-05-20 14:42:42'),
	(2, 1, 'Juan Dela Cruz', 'juan.admin@gmail.com', '09171234567', 'admin', 'admin123', 'Active', '2026-05-21 05:17:03', '2026-05-21 05:17:03'),
	(3, 2, 'Andrei Reyessss', 'andrei.customer@gmail.com', '09191234567', 'andrei', 'andrei123', 'Active', '2026-05-21 05:17:03', '2026-05-21 05:23:19'),
	(4, 2, 'Carla Mendoza', 'carla.customer@gmail.com', '09201234567', 'carla', 'carla123', 'Active', '2026-05-21 05:17:03', '2026-05-21 05:17:03'),
	(5, 2, 'Rico Bautista', 'rico.customer@gmail.com', '09211234567', 'rico', 'rico123', 'Inactive', '2026-05-21 05:17:03', '2026-05-21 05:17:03'),
	(6, 1, 'dww', 'dwwd@gmail.com', '222222222', 'cscsc', 'cscszc', 'Active', '2026-05-21 06:07:13', '2026-05-21 06:07:13'),
	(7, 1, 'qq', 'qq@gmail.com', 'qq', 'qqdwd', 'qqdwadwdw', 'Active', '2026-05-21 06:13:29', '2026-05-21 06:13:29');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
