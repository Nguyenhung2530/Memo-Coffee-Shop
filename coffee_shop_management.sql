-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th5 03, 2025 lúc 05:24 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `coffee_shop_management`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer`
--

CREATE TABLE `customer` (
  `CustomerID` int(11) NOT NULL,
  `FullName` varchar(100) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `BirthDate` date DEFAULT NULL,
  `Gender` enum('Nam','Nữ','Khác') DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `JoinDate` date DEFAULT curdate(),
  `Points` int(11) DEFAULT 0 CHECK (`Points` >= 0),
  `TotalSpent` decimal(15,2) DEFAULT 0.00 CHECK (`TotalSpent` >= 0),
  `LastVisit` datetime DEFAULT NULL,
  `Notes` text DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `UpdatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `customer`
--

INSERT INTO `customer` (`CustomerID`, `FullName`, `Phone`, `Email`, `BirthDate`, `Gender`, `Address`, `JoinDate`, `Points`, `TotalSpent`, `LastVisit`, `Notes`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 'Đặng Văn Hải', '0987654321', 'hai.dang@example.com', NULL, 'Nam', NULL, '2023-01-10', 100, 120.00, NULL, NULL, '2025-04-30 16:08:34', '2025-05-03 12:53:16'),
(2, 'Nguyễn Thị Lan', '0987654322', 'lan.nguyen@example.com', NULL, 'Nữ', NULL, '2023-02-15', 50, 234.00, NULL, NULL, '2025-04-30 16:08:34', '2025-05-03 12:53:16'),
(3, 'Trần Văn Minh', '0987654323', 'minh.tran@example.com', NULL, 'Nam', NULL, '2023-03-20', 200, 230.00, NULL, NULL, '2025-04-30 16:08:34', '2025-05-03 12:53:16'),
(4, 'Lê Thị Nga', '0987654324', 'nga.le@example.com', NULL, 'Nữ', NULL, '2023-04-25', 75, 532.00, NULL, NULL, '2025-04-30 16:08:34', '2025-05-03 12:53:53'),
(5, 'Phạm Văn Oanh', '0987654325', 'oanh.pham@example.com', NULL, 'Nữ', NULL, '2023-05-30', 150, 109.00, NULL, NULL, '2025-04-30 16:08:34', '2025-05-03 12:53:53'),
(6, 'Nguyễn Hữu Hùng', '0927902214', 'nguyenhung25030@gmail.com', NULL, 'Nam', '', '2025-05-03', 100, 2503205.00, NULL, '', '2025-05-03 21:45:29', '2025-05-03 21:53:43');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `drink`
--

CREATE TABLE `drink` (
  `DrinkID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Category` enum('Cà phê','Trà','Sinh tố','Nước ép','Đá xay','Khác') NOT NULL,
  `SubCategory` varchar(50) DEFAULT NULL,
  `Size` enum('S','M','L') DEFAULT 'M',
  `Price` decimal(10,2) NOT NULL CHECK (`Price` > 0),
  `Cost` decimal(10,2) DEFAULT NULL CHECK (`Cost` >= 0),
  `Status` tinyint(1) DEFAULT 1 COMMENT 'TRUE là còn bán, FALSE là ngừng bán',
  `Description` text DEFAULT NULL,
  `PreparationTime` int(11) DEFAULT NULL COMMENT 'Thời gian chuẩn bị (phút)',
  `ImageURL` varchar(255) DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `UpdatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `drink`
--

INSERT INTO `drink` (`DrinkID`, `Name`, `Category`, `SubCategory`, `Size`, `Price`, `Cost`, `Status`, `Description`, `PreparationTime`, `ImageURL`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 'Cà phê đen', 'Cà phê', NULL, 'S', 15000.00, NULL, 1, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34'),
(2, 'Cà phê sữa', 'Cà phê', NULL, 'M', 20000.00, NULL, 1, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34'),
(3, 'Trà đào', 'Trà', NULL, 'L', 30000.00, NULL, 1, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34'),
(4, 'Sinh tố bơ', 'Sinh tố', NULL, 'M', 35000.00, NULL, 1, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34'),
(5, 'Nước cam ép', 'Nước ép', NULL, 'L', 40000.00, NULL, 1, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34'),
(6, 'Latte', 'Cà phê', NULL, 'L', 45000.00, NULL, 1, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34'),
(7, 'Trà sữa trân châu', 'Trà', NULL, 'L', 50000.00, NULL, 1, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34'),
(8, 'Nước ép xoài', 'Nước ép', NULL, 'L', 45000.00, NULL, 0, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-05-03 20:43:40'),
(9, 'Dưa Hấu', 'Nước ép', NULL, 'M', 40000.00, NULL, 1, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-05-03 20:35:13'),
(10, 'Cappuccino', 'Cà phê', NULL, 'M', 40000.00, NULL, 1, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34'),
(11, 'Cà phê chồn', 'Cà phê', NULL, 'L', 45000.00, NULL, 1, NULL, NULL, NULL, '2025-05-01 12:12:03', '2025-05-03 20:44:06'),
(14, 'Sầu', 'Cà phê', NULL, 'S', 35000.00, NULL, 0, NULL, NULL, NULL, '2025-05-01 12:21:21', '2025-05-03 21:06:03'),
(15, 'Bạc xỉu', 'Cà phê', NULL, 'S', 15000.00, NULL, 0, NULL, NULL, NULL, '2025-05-02 15:22:26', '2025-05-02 15:22:26');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `employee`
--

CREATE TABLE `employee` (
  `EmpID` int(11) NOT NULL,
  `FullName` varchar(100) NOT NULL,
  `Gender` enum('Nam','Nữ','Khác') NOT NULL,
  `BirthDate` date DEFAULT NULL,
  `Phone` varchar(15) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `Position` enum('Quản lý','Thu ngân','Pha chế','Phục vụ','Giao hàng','Bảo vệ','Khác') NOT NULL,
  `Salary` decimal(12,2) NOT NULL CHECK (`Salary` >= 0),
  `StartDate` date NOT NULL,
  `EndDate` date DEFAULT NULL,
  `Status` enum('Đang làm','Nghỉ việc','Tạm nghỉ') DEFAULT 'Đang làm',
  `ImageURL` varchar(255) DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `UpdatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `employee`
--

INSERT INTO `employee` (`EmpID`, `FullName`, `Gender`, `BirthDate`, `Phone`, `Email`, `Address`, `Position`, `Salary`, `StartDate`, `EndDate`, `Status`, `ImageURL`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 'Nguyễn Văn An', 'Nam', NULL, '0912345678', NULL, NULL, 'Quản lý', 15000000.00, '2022-01-15', NULL, 'Đang làm', NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34'),
(2, 'Trần Thị Bình', 'Nữ', NULL, '0912345679', NULL, NULL, 'Thu ngân', 8000000.00, '2022-03-20', NULL, 'Đang làm', NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34'),
(3, 'Lê Hoàng Cường', 'Nam', NULL, '0912345680', NULL, NULL, 'Pha chế', 9000000.00, '2022-05-10', NULL, 'Đang làm', NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34'),
(4, 'Phạm Thị Dung', 'Nữ', NULL, '0912345681', NULL, NULL, 'Phục vụ', 7000000.00, '2022-07-05', NULL, 'Đang làm', NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34'),
(5, 'Vũ Minh Đức', 'Nam', NULL, '0912345682', NULL, NULL, 'Giao hàng', 7500000.00, '2022-09-12', NULL, 'Đang làm', NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ingredient`
--

CREATE TABLE `ingredient` (
  `IngrID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Unit` varchar(10) DEFAULT NULL,
  `StockQty` decimal(10,3) NOT NULL CHECK (`StockQty` >= 0),
  `PricePerUnit` decimal(10,2) NOT NULL CHECK (`PricePerUnit` >= 0),
  `ShelfLife` int(11) DEFAULT NULL COMMENT 'Hạn sử dụng (ngày)',
  `StorageCondition` enum('Thường','Mát','Đông lạnh','Khác') DEFAULT NULL,
  `Notes` text DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `UpdatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Status` tinyint(4) DEFAULT 1,
  `Note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `ingredient`
--

INSERT INTO `ingredient` (`IngrID`, `Name`, `Unit`, `StockQty`, `PricePerUnit`, `ShelfLife`, `StorageCondition`, `Notes`, `CreatedAt`, `UpdatedAt`, `Status`, `Note`) VALUES
(1, 'Cà phê Arabica', 'kg', 50.000, 200000.00, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-05-03 12:55:49', 0, NULL),
(2, 'Sữa đặc', 'lít', 100.000, 25000.00, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-05-03 12:46:44', 1, NULL),
(3, 'Đào tươi', 'kg', 30.000, 50000.00, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34', 1, NULL),
(4, 'Bơ', 'kg', 20.000, 80000.00, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34', 1, NULL),
(5, 'Cam', 'kg', 40.000, 40000.00, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34', 1, NULL),
(6, 'Trà Earl Grey', 'g', 5000.000, 0.50, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34', 1, NULL),
(7, 'Trân châu trắng', 'kg', 25.000, 100000.00, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34', 1, NULL),
(8, 'Dâu tây', 'kg', 15.000, 120000.00, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34', 1, NULL),
(9, 'Dưa hấu', 'kg', 35.000, 20000.00, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-04-30 16:08:34', 1, NULL),
(10, 'Sữa tươi', 'lít', 50.000, 30000.00, NULL, NULL, NULL, '2025-04-30 16:08:34', '2025-05-03 12:46:44', 1, NULL),
(11, 'Cà phê Arabica', 'kg', 50.000, 200000.00, NULL, NULL, NULL, '2025-04-30 16:12:00', '2025-04-30 16:12:00', 1, NULL),
(12, 'Sữa đặc', 'lít', 100.000, 25000.00, NULL, NULL, NULL, '2025-04-30 16:12:00', '2025-05-03 12:46:44', 1, NULL),
(13, 'Đào tươi', 'kg', 30.000, 50000.00, NULL, NULL, NULL, '2025-04-30 16:12:00', '2025-04-30 16:12:00', 1, NULL),
(14, 'Bơ', 'kg', 20.000, 80000.00, NULL, NULL, NULL, '2025-04-30 16:12:00', '2025-04-30 16:12:00', 1, NULL),
(15, 'Cam', 'kg', 40.000, 40000.00, NULL, NULL, NULL, '2025-04-30 16:12:00', '2025-04-30 16:12:00', 1, NULL),
(16, 'Trà Earl Grey', 'g', 5000.000, 0.50, NULL, NULL, NULL, '2025-04-30 16:12:00', '2025-04-30 16:12:00', 1, NULL),
(17, 'Trân châu trắng', 'kg', 25.000, 100000.00, NULL, NULL, NULL, '2025-04-30 16:12:00', '2025-04-30 16:12:00', 1, NULL),
(18, 'Dâu tây', 'kg', 15.000, 120000.00, NULL, NULL, NULL, '2025-04-30 16:12:00', '2025-04-30 16:12:00', 1, NULL),
(19, 'Dưa hấu', 'kg', 35.000, 20000.00, NULL, NULL, NULL, '2025-04-30 16:12:00', '2025-04-30 16:12:00', 1, NULL),
(20, 'Sữa tươi', 'lít', 50.000, 30000.00, NULL, NULL, NULL, '2025-04-30 16:12:00', '2025-04-30 16:12:00', 1, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoice`
--

CREATE TABLE `invoice` (
  `InvoiceID` int(11) NOT NULL,
  `EmpID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `InvoiceNumber` varchar(20) DEFAULT NULL,
  `DateTime` datetime DEFAULT current_timestamp(),
  `TableNumber` varchar(10) DEFAULT NULL,
  `NumberOfGuests` int(11) DEFAULT 1 CHECK (`NumberOfGuests` > 0),
  `SubTotal` decimal(12,2) NOT NULL CHECK (`SubTotal` >= 0),
  `Discount` decimal(12,2) DEFAULT 0.00 CHECK (`Discount` >= 0),
  `Tax` decimal(12,2) DEFAULT 0.00 CHECK (`Tax` >= 0),
  `ServiceCharge` decimal(12,2) DEFAULT 0.00 CHECK (`ServiceCharge` >= 0),
  `TotalAmount` decimal(12,2) NOT NULL CHECK (`TotalAmount` >= 0),
  `PaymentMethod` enum('Tiền mặt','Thẻ','Chuyển khoản','Ví điện tử','Khác') NOT NULL,
  `PaymentStatus` enum('Chưa thanh toán','Đã thanh toán','Một phần') DEFAULT 'Đã thanh toán',
  `Notes` text DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `UpdatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `invoice`
--

INSERT INTO `invoice` (`InvoiceID`, `EmpID`, `CustomerID`, `InvoiceNumber`, `DateTime`, `TableNumber`, `NumberOfGuests`, `SubTotal`, `Discount`, `Tax`, `ServiceCharge`, `TotalAmount`, `PaymentMethod`, `PaymentStatus`, `Notes`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 1, 1, 'INV0001', '2025-05-01 09:15:00', 'A1', 2, 150000.00, 10000.00, 5000.00, 5000.00, 150000.00, 'Tiền mặt', 'Đã thanh toán', 'Khách quen, giảm giá 10k', '2025-05-03 13:11:38', '2025-05-03 13:11:38'),
(2, 2, 4, 'INV0002', '2025-05-01 10:30:00', 'B2', 1, 50000.00, 0.00, 2500.00, 2500.00, 55000.00, 'Thẻ', 'Đã thanh toán', NULL, '2025-05-03 13:11:38', '2025-05-03 13:15:38'),
(3, 1, 2, 'INV0003', '2025-05-02 14:00:00', 'C3', 3, 300000.00, 20000.00, 10000.00, 10000.00, 300000.00, 'Chuyển khoản', 'Chưa thanh toán', 'Đặt bàn trước, chưa thanh toán', '2025-05-03 13:11:38', '2025-05-03 13:11:38'),
(4, 3, 3, 'INV0004', '2025-05-03 18:45:00', 'D4', 4, 400000.00, 0.00, 20000.00, 20000.00, 420000.00, 'Ví điện tử', 'Một phần', 'Khách thanh toán trước 200k', '2025-05-03 13:11:38', '2025-05-03 13:11:38'),
(5, 2, 1, 'INV0005', '2025-05-04 08:20:00', 'A2', 2, 120000.00, 0.00, 6000.00, 4000.00, 130000.00, 'Tiền mặt', 'Đã thanh toán', NULL, '2025-05-03 13:11:38', '2025-05-03 13:11:38');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoice_detail`
--

CREATE TABLE `invoice_detail` (
  `InvoiceDetailID` int(11) NOT NULL,
  `InvoiceID` int(11) NOT NULL,
  `DrinkID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL CHECK (`Quantity` > 0),
  `UnitPrice` decimal(10,2) NOT NULL CHECK (`UnitPrice` >= 0),
  `Discount` decimal(10,2) DEFAULT 0.00 CHECK (`Discount` >= 0),
  `SubTotal` decimal(12,2) GENERATED ALWAYS AS (`Quantity` * (`UnitPrice` - `Discount`)) STORED,
  `Note` text DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `online_order`
--

CREATE TABLE `online_order` (
  `OrderID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `OrderNumber` varchar(20) DEFAULT NULL,
  `OrderTime` datetime DEFAULT current_timestamp(),
  `DeliveryAddress` text NOT NULL,
  `DeliveryLat` decimal(10,8) DEFAULT NULL,
  `DeliveryLng` decimal(11,8) DEFAULT NULL,
  `ContactPhone` varchar(15) NOT NULL,
  `ContactName` varchar(100) NOT NULL,
  `DeliveryFee` decimal(10,2) DEFAULT 0.00 CHECK (`DeliveryFee` >= 0),
  `SubTotal` decimal(12,2) NOT NULL CHECK (`SubTotal` >= 0),
  `Discount` decimal(12,2) DEFAULT 0.00 CHECK (`Discount` >= 0),
  `TotalAmount` decimal(12,2) NOT NULL CHECK (`TotalAmount` >= 0),
  `PaymentMethod` enum('Tiền mặt','Thẻ','Chuyển khoản','Ví điện tử') NOT NULL,
  `PaymentStatus` enum('Chưa thanh toán','Đã thanh toán','Thất bại') DEFAULT 'Chưa thanh toán',
  `OrderStatus` enum('Chờ xác nhận','Đã xác nhận','Đang chuẩn bị','Đang giao','Đã giao','Đã hủy') DEFAULT 'Chờ xác nhận',
  `EstimatedDeliveryTime` datetime DEFAULT NULL,
  `ActualDeliveryTime` datetime DEFAULT NULL,
  `CancellationReason` text DEFAULT NULL,
  `Notes` text DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `UpdatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `online_order`
--

INSERT INTO `online_order` (`OrderID`, `UserID`, `OrderNumber`, `OrderTime`, `DeliveryAddress`, `DeliveryLat`, `DeliveryLng`, `ContactPhone`, `ContactName`, `DeliveryFee`, `SubTotal`, `Discount`, `TotalAmount`, `PaymentMethod`, `PaymentStatus`, `OrderStatus`, `EstimatedDeliveryTime`, `ActualDeliveryTime`, `CancellationReason`, `Notes`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 1, 'OD1001', '2024-06-01 11:00:00', '123 Lê Lợi, Q.1', NULL, NULL, '0909999999', 'Phạm Minh D', 15000.00, 100000.00, 5000.00, 110000.00, 'Tiền mặt', 'Chưa thanh toán', 'Chờ xác nhận', NULL, NULL, NULL, 'Giao giờ trưa', '2025-05-03 13:28:49', '2025-05-03 13:28:49'),
(2, 2, 'OD1002', '2024-06-01 12:00:00', '456 Nguyễn Trãi, Q.5', NULL, NULL, '0918888888', 'Vũ Thị E', 20000.00, 120000.00, 0.00, 140000.00, 'Thẻ', 'Đã thanh toán', 'Đã giao', NULL, NULL, NULL, '', '2025-05-03 13:28:49', '2025-05-03 13:28:49');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `online_order_detail`
--

CREATE TABLE `online_order_detail` (
  `OrderDetailID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `DrinkID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL CHECK (`Quantity` > 0),
  `UnitPrice` decimal(10,2) NOT NULL CHECK (`UnitPrice` >= 0),
  `SpecialRequest` text DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `recipe`
--

CREATE TABLE `recipe` (
  `RecipeID` int(11) NOT NULL,
  `DrinkID` int(11) NOT NULL,
  `IngrID` int(11) NOT NULL,
  `Amount` decimal(10,3) NOT NULL CHECK (`Amount` > 0),
  `Unit` varchar(20) NOT NULL,
  `StepNumber` int(11) DEFAULT NULL,
  `Instructions` text DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `UpdatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `recipe`
--

INSERT INTO `recipe` (`RecipeID`, `DrinkID`, `IngrID`, `Amount`, `Unit`, `StepNumber`, `Instructions`, `CreatedAt`, `UpdatedAt`) VALUES
(31, 1, 1, 0.020, 'kg', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(32, 2, 1, 0.020, 'kg', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(33, 2, 2, 0.050, 'lon', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(34, 3, 3, 0.100, 'kg', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(35, 3, 6, 0.010, 'g', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(36, 4, 4, 0.150, 'kg', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(37, 5, 5, 0.300, 'kg', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(38, 6, 1, 0.030, 'kg', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(39, 6, 10, 0.200, 'lít', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(40, 7, 6, 0.010, 'g', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(41, 7, 2, 0.100, 'lon', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(42, 7, 7, 0.050, 'kg', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(43, 8, 8, 0.150, 'kg', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(44, 9, 9, 0.400, 'kg', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03'),
(45, 10, 1, 0.030, 'kg', NULL, NULL, '2025-04-30 16:15:03', '2025-04-30 16:15:03');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_account`
--

CREATE TABLE `user_account` (
  `UserID` int(11) NOT NULL,
  `FullName` varchar(100) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `Salt` varchar(255) DEFAULT '',
  `Role` enum('Khách hàng','Nhân viên','Quản lý','Admin') DEFAULT 'Khách hàng',
  `Status` enum('Active','Inactive','Banned') DEFAULT 'Active',
  `LastLogin` datetime DEFAULT NULL,
  `JoinDate` datetime DEFAULT current_timestamp(),
  `ResetToken` varchar(100) DEFAULT NULL,
  `ResetTokenExpiry` datetime DEFAULT NULL,
  `VerificationToken` varchar(100) DEFAULT NULL,
  `IsVerified` tinyint(1) DEFAULT 0,
  `CustomerID` int(11) DEFAULT NULL,
  `EmpID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user_account`
--

INSERT INTO `user_account` (`UserID`, `FullName`, `Phone`, `Email`, `PasswordHash`, `Salt`, `Role`, `Status`, `LastLogin`, `JoinDate`, `ResetToken`, `ResetTokenExpiry`, `VerificationToken`, `IsVerified`, `CustomerID`, `EmpID`) VALUES
(1, 'Đặng Văn Hải', '0987654321', 'hai.dang@example.com', 'hashed_password_1', '', 'Khách hàng', 'Active', NULL, '2025-04-30 16:16:36', NULL, NULL, NULL, 0, NULL, NULL),
(2, 'Nguyễn Thị Lan', '0987654322', 'lan.nguyen@example.com', 'hashed_password_2', '', 'Khách hàng', 'Active', NULL, '2025-04-30 16:16:36', NULL, NULL, NULL, 0, NULL, NULL),
(3, 'Trần Văn Minh', '0987654323', 'minh.tran@example.com', 'hashed_password_3', '', 'Khách hàng', 'Active', NULL, '2025-04-30 16:16:36', NULL, NULL, NULL, 0, NULL, NULL),
(4, 'Lê Thị Nga', '0987654324', 'nga.le@example.com', 'hashed_password_4', '', 'Khách hàng', 'Active', NULL, '2025-04-30 16:16:36', NULL, NULL, NULL, 0, NULL, NULL),
(5, 'Phạm Văn Oanh', '0987654325', 'oanh.pham@example.com', 'hashed_password_5', '', 'Khách hàng', 'Active', NULL, '2025-04-30 16:16:36', NULL, NULL, NULL, 0, NULL, NULL),
(6, 'Admin', '', 'admin@example.com', 'admin', '', 'Admin', 'Active', NULL, '2025-05-02 16:05:29', NULL, NULL, NULL, 0, NULL, NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustomerID`),
  ADD UNIQUE KEY `Phone` (`Phone`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `idx_phone` (`Phone`),
  ADD KEY `idx_points` (`Points`);

--
-- Chỉ mục cho bảng `drink`
--
ALTER TABLE `drink`
  ADD PRIMARY KEY (`DrinkID`),
  ADD KEY `idx_category` (`Category`),
  ADD KEY `idx_status` (`Status`),
  ADD KEY `idx_price` (`Price`);

--
-- Chỉ mục cho bảng `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`EmpID`),
  ADD UNIQUE KEY `Phone` (`Phone`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `idx_position` (`Position`),
  ADD KEY `idx_status` (`Status`);

--
-- Chỉ mục cho bảng `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`IngrID`),
  ADD KEY `idx_name` (`Name`);

--
-- Chỉ mục cho bảng `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`InvoiceID`),
  ADD UNIQUE KEY `InvoiceNumber` (`InvoiceNumber`),
  ADD KEY `idx_datetime` (`DateTime`),
  ADD KEY `idx_customer` (`CustomerID`),
  ADD KEY `idx_employee` (`EmpID`);

--
-- Chỉ mục cho bảng `invoice_detail`
--
ALTER TABLE `invoice_detail`
  ADD PRIMARY KEY (`InvoiceDetailID`),
  ADD KEY `idx_invoice` (`InvoiceID`),
  ADD KEY `idx_drink` (`DrinkID`);

--
-- Chỉ mục cho bảng `online_order`
--
ALTER TABLE `online_order`
  ADD PRIMARY KEY (`OrderID`),
  ADD UNIQUE KEY `OrderNumber` (`OrderNumber`),
  ADD KEY `idx_user` (`UserID`),
  ADD KEY `idx_status` (`OrderStatus`),
  ADD KEY `idx_order_time` (`OrderTime`);

--
-- Chỉ mục cho bảng `online_order_detail`
--
ALTER TABLE `online_order_detail`
  ADD PRIMARY KEY (`OrderDetailID`),
  ADD KEY `idx_order` (`OrderID`),
  ADD KEY `idx_drink` (`DrinkID`);

--
-- Chỉ mục cho bảng `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`RecipeID`),
  ADD UNIQUE KEY `uk_drink_ingredient` (`DrinkID`,`IngrID`),
  ADD KEY `idx_drink` (`DrinkID`),
  ADD KEY `idx_ingredient` (`IngrID`);

--
-- Chỉ mục cho bảng `user_account`
--
ALTER TABLE `user_account`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Phone` (`Phone`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `CustomerID` (`CustomerID`),
  ADD KEY `EmpID` (`EmpID`),
  ADD KEY `idx_email` (`Email`),
  ADD KEY `idx_phone` (`Phone`),
  ADD KEY `idx_role` (`Role`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `customer`
--
ALTER TABLE `customer`
  MODIFY `CustomerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `drink`
--
ALTER TABLE `drink`
  MODIFY `DrinkID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `employee`
--
ALTER TABLE `employee`
  MODIFY `EmpID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `IngrID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `invoice`
--
ALTER TABLE `invoice`
  MODIFY `InvoiceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `invoice_detail`
--
ALTER TABLE `invoice_detail`
  MODIFY `InvoiceDetailID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `online_order`
--
ALTER TABLE `online_order`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `online_order_detail`
--
ALTER TABLE `online_order_detail`
  MODIFY `OrderDetailID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `recipe`
--
ALTER TABLE `recipe`
  MODIFY `RecipeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT cho bảng `user_account`
--
ALTER TABLE `user_account`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`EmpID`) REFERENCES `employee` (`EmpID`),
  ADD CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `invoice_detail`
--
ALTER TABLE `invoice_detail`
  ADD CONSTRAINT `invoice_detail_ibfk_1` FOREIGN KEY (`InvoiceID`) REFERENCES `invoice` (`InvoiceID`) ON DELETE CASCADE,
  ADD CONSTRAINT `invoice_detail_ibfk_2` FOREIGN KEY (`DrinkID`) REFERENCES `drink` (`DrinkID`);

--
-- Các ràng buộc cho bảng `online_order`
--
ALTER TABLE `online_order`
  ADD CONSTRAINT `online_order_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user_account` (`UserID`);

--
-- Các ràng buộc cho bảng `online_order_detail`
--
ALTER TABLE `online_order_detail`
  ADD CONSTRAINT `online_order_detail_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `online_order` (`OrderID`) ON DELETE CASCADE,
  ADD CONSTRAINT `online_order_detail_ibfk_2` FOREIGN KEY (`DrinkID`) REFERENCES `drink` (`DrinkID`);

--
-- Các ràng buộc cho bảng `recipe`
--
ALTER TABLE `recipe`
  ADD CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`DrinkID`) REFERENCES `drink` (`DrinkID`) ON DELETE CASCADE,
  ADD CONSTRAINT `recipe_ibfk_2` FOREIGN KEY (`IngrID`) REFERENCES `ingredient` (`IngrID`);

--
-- Các ràng buộc cho bảng `user_account`
--
ALTER TABLE `user_account`
  ADD CONSTRAINT `user_account_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE SET NULL,
  ADD CONSTRAINT `user_account_ibfk_2` FOREIGN KEY (`EmpID`) REFERENCES `employee` (`EmpID`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
