-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 15, 2025 lúc 04:01 PM
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
-- Cơ sở dữ liệu: `coffee_management`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `member_since` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_of_birth` date DEFAULT NULL,
  `loyalty_points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `customer`
--

INSERT INTO `customer` (`customer_id`, `name`, `phone`, `email`, `member_since`, `date_of_birth`, `loyalty_points`) VALUES
(1, 'Nguyễn Thị Lan', '0916000016', 'lan@khach.vn', '2023-01-09 17:00:00', '1990-04-05', 120),
(2, 'Trần Văn Bình', '0917000017', 'binh@khach.vn', '2022-05-19 17:00:00', '1988-07-12', 80),
(3, 'Lê Thị Hoa', '0918000018', 'hoa@khach.vn', '2023-03-14 17:00:00', '1992-09-30', 50),
(4, 'Phạm Văn Tuấn', '0919000019', 'tuan@khach.vn', '2022-11-30 17:00:00', '1985-11-20', 200),
(5, 'Hoàng Thị Mai', '0920000020', 'mai@khach.vn', '2023-06-04 17:00:00', '1993-02-14', 30),
(6, 'Vũ Đình Quang', '0921000021', 'quang@khach.vn', '2022-08-21 17:00:00', '1987-06-18', 150),
(7, 'Đỗ Thị Hạnh', '0922000022', 'hanh@khach.vn', '2023-02-27 17:00:00', '1991-10-08', 60),
(8, 'Bùi Văn Sơn', '0923000023', 'son@khach.vn', '2022-11-10 17:00:00', '1989-12-25', 90),
(9, 'Ngô Thị Kim', '0924000024', 'kim@khach.vn', '2023-04-17 17:00:00', '1994-03-03', 40),
(10, 'Phạm Thị Nga', '0925000025', 'nga@khach.vn', '2022-07-06 17:00:00', '1990-08-19', 110),
(11, 'Lê Văn Trung', '0926000026', 'trung@khach.vn', '2023-05-11 17:00:00', '1992-05-22', 70),
(12, 'Trương Thị Yến', '0927000027', 'yen@khach.vn', '2022-09-29 17:00:00', '1986-01-30', 130),
(13, 'Khổng Thị Phương', '0928000028', 'phuong@khach.vn', '2023-03-21 17:00:00', '1993-07-07', 55),
(14, 'Võ Văn Hải', '0929000029', 'hai@khach.vn', '2022-10-14 17:00:00', '1988-02-28', 95),
(15, 'Đinh Thị Thu', '0930000030', 'thu@khach.vn', '2023-02-04 17:00:00', '1991-11-11', 65);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `drink`
--

CREATE TABLE `drink` (
  `drink_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `description` text DEFAULT NULL,
  `size` varchar(20) DEFAULT 'medium'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `drink`
--

INSERT INTO `drink` (`drink_id`, `name`, `category`, `price`, `is_available`, `description`, `size`) VALUES
(1, 'Cà phê đen', 'cà phê', 25000.00, 1, 'Cà phê nguyên chất phin', 'medium'),
(2, 'Cà phê sữa', 'cà phê', 30000.00, 1, 'Thêm sữa đặc béo ngậy', 'medium'),
(3, 'Bạc xỉu', 'cà phê', 32000.00, 1, 'Cà phê sữa và nhiều foam', 'small'),
(4, 'Capuchino', 'cà phê', 35000.00, 1, 'Espresso + sữa và bọt sữa', 'large'),
(5, 'Mocha', 'cà phê', 38000.00, 1, 'Cà phê + ca cao', 'medium'),
(6, 'Trà xanh', 'trà', 22000.00, 1, 'Trà matcha Nhật Bản', 'medium'),
(7, 'Trà chanh', 'trà', 20000.00, 1, 'Trà đen + chanh tươi', 'small'),
(8, 'Trà vải', 'trà', 23000.00, 0, 'Trà vải thơm mát', 'small'),
(9, 'Sinh tố dâu', 'smoothie', 40000.00, 1, 'Dâu tươi + sữa chua', 'large'),
(10, 'Sinh tố xoài', 'smoothie', 42000.00, 1, 'Xoài chín + đá xay', 'large'),
(11, 'Nước cam', 'nước ép', 35000.00, 1, 'Cam tươi vắt nguyên chất', 'medium'),
(12, 'Nước ép táo', 'nước ép', 30000.00, 1, 'Táo xanh pha chua ngọt', 'medium'),
(13, 'Latte', 'cà phê', 36000.00, 1, 'Espresso + sữa nóng', 'medium'),
(14, 'Chai latte', 'trà', 31000.00, 1, 'Trà gia vị + sữa', 'medium'),
(15, 'Frappuccino', 'cà phê', 45000.00, 0, 'Cà phê xay + kem tươi', 'large');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `employee`
--

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `employee`
--

INSERT INTO `employee` (`employee_id`, `full_name`, `birth_date`, `phone`, `email`, `position`, `hire_date`, `user_id`, `address`, `salary`) VALUES
(1, 'Nguyễn Văn A', '1990-01-15', '0901000001', 'a@coffee.vn', 'Pha chế', '2022-01-01', 1, 'Hà Nội', 8000000.00),
(2, 'Trần Thị B', '1988-03-22', '0902000002', 'b@coffee.vn', 'Quản lý', '2021-06-15', 2, 'TP.HCM', 12000000.00),
(3, 'Lê Văn C', '1992-07-10', '0903000003', 'c@coffee.vn', 'Thu ngân', '2023-02-10', 3, 'Đà Nẵng', 7000000.00),
(4, 'Phạm Thị D', '1991-12-05', '0904000004', 'd@coffee.vn', 'Pha chế', '2022-11-01', 4, 'Hải Phòng', 8000000.00),
(5, 'Hoàng Văn E', '1985-05-30', '0905000005', 'e@coffee.vn', 'Quản lý', '2020-09-20', 5, 'Cần Thơ', 12000000.00),
(6, 'Vũ Thị F', '1993-09-12', '0906000006', 'f@coffee.vn', 'Pha chế', '2022-05-05', 6, 'Nha Trang', 8000000.00),
(7, 'Đỗ Văn G', '1994-04-18', '0907000007', 'g@coffee.vn', 'Thu ngân', '2023-01-20', 7, 'Huế', 7000000.00),
(8, 'Bùi Thị H', '1989-11-11', '0908000008', 'h@coffee.vn', 'Pha chế', '2021-12-01', 8, 'Hải Dương', 8000000.00),
(9, 'Nguyễn Thị I', '1995-02-25', '0909000009', 'i@coffee.vn', 'Thu ngân', '2023-04-10', 9, 'Quảng Ninh', 7000000.00),
(10, 'Lê Thị K', '1990-08-08', '0910000010', 'k@coffee.vn', 'Quản lý', '2021-03-15', 10, 'Vũng Tàu', 12000000.00),
(11, 'Trần Văn L', '1992-06-02', '0911000011', 'l@coffee.vn', 'Pha chế', '2022-07-22', 11, 'Bình Định', 8000000.00),
(12, 'Phạm Văn M', '1987-10-16', '0912000012', 'm@coffee.vn', 'Thu ngân', '2020-05-30', 12, 'Thanh Hóa', 7000000.00),
(13, 'Hồ Thị N', '1993-01-05', '0913000013', 'n@coffee.vn', 'Pha chế', '2022-10-12', 13, 'Bắc Ninh', 8000000.00),
(14, 'Vũ Văn O', '1986-03-19', '0914000014', 'o@coffee.vn', 'Quản lý', '2019-11-25', 14, 'Nam Định', 12000000.00),
(15, 'Đỗ Thị P', '1994-12-29', '0915000015', 'p@coffee.vn', 'Thu ngân', '2023-03-05', 15, 'Hưng Yên', 7000000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `content` text DEFAULT NULL,
  `rating` tinyint(4) NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `response_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `feedback`
--

INSERT INTO `feedback` (`feedback_id`, `customer_id`, `content`, `rating`, `submitted_at`, `response_date`) VALUES
(1, 1, 'Cà phê rất ngon!', 5, '2025-06-15 13:59:47', '2025-06-02 03:00:00'),
(2, 2, 'Nhân viên thân thiện.', 4, '2025-06-15 13:59:47', NULL),
(3, 3, 'Cà phê hơi nguội.', 3, '2025-06-15 13:59:47', NULL),
(4, 4, 'Thích latte art.', 5, '2025-06-15 13:59:47', '2025-06-03 07:30:00'),
(5, 5, 'Quán yên tĩnh, sạch.', 4, '2025-06-15 13:59:47', NULL),
(6, 6, 'Trà hơi ngọt.', 2, '2025-06-15 13:59:47', NULL),
(7, 7, 'Phục vụ nhanh.', 5, '2025-06-15 13:59:47', NULL),
(8, 8, 'Nhạc hơi to.', 3, '2025-06-15 13:59:47', NULL),
(9, 9, 'Quán sạch sẽ.', 4, '2025-06-15 13:59:47', '2025-06-04 09:00:00'),
(10, 10, 'Giá hợp lý.', 5, '2025-06-15 13:59:47', NULL),
(11, 11, 'Chờ lâu một chút.', 2, '2025-06-15 13:59:47', NULL),
(12, 12, 'Sinh tố rất ngon.', 5, '2025-06-15 13:59:47', NULL),
(13, 13, 'Trà hơi lạnh.', 3, '2025-06-15 13:59:47', NULL),
(14, 14, 'Nước ép tươi.', 4, '2025-06-15 13:59:47', '2025-06-05 04:00:00'),
(15, 15, 'Trải nghiệm tuyệt vời.', 5, '2025-06-15 13:59:47', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ingredient`
--

CREATE TABLE `ingredient` (
  `ingredient_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `quantity_in_stock` decimal(10,2) DEFAULT 0.00,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp(),
  `supplier` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `ingredient`
--

INSERT INTO `ingredient` (`ingredient_id`, `name`, `unit`, `quantity_in_stock`, `last_updated`, `supplier`) VALUES
(1, 'Hạt cà phê', 'gram', 500.00, '2025-06-01 01:00:00', 'Công ty A'),
(2, 'Sữa tươi', 'ml', 1000.00, '2025-06-01 02:00:00', 'Công ty B'),
(3, 'Đường', 'gram', 200.00, '2025-06-01 03:00:00', 'Công ty C'),
(4, 'Ca cao', 'gram', 150.00, '2025-06-01 04:00:00', 'Công ty D'),
(5, 'Lá trà xanh', 'gram', 300.00, '2025-06-01 05:00:00', 'Công ty E'),
(6, 'Đá viên', 'gram', 800.00, '2025-06-01 06:00:00', 'Công ty F'),
(7, 'Dâu tây', 'gram', 250.00, '2025-06-01 07:00:00', 'Công ty G'),
(8, 'Xoài', 'gram', 300.00, '2025-06-01 08:00:00', 'Công ty H'),
(9, 'Cam', 'gram', 400.00, '2025-06-01 09:00:00', 'Công ty I'),
(10, 'Nước lọc', 'ml', 2000.00, '2025-06-01 10:00:00', 'Công ty J'),
(11, 'Sữa chua', 'gram', 200.00, '2025-06-01 11:00:00', 'Công ty K'),
(12, 'Mật ong', 'gram', 100.00, '2025-06-01 12:00:00', 'Công ty L'),
(13, 'Quế', 'gram', 50.00, '2025-06-01 13:00:00', 'Công ty M'),
(14, 'Sirô vani', 'ml', 120.00, '2025-06-01 14:00:00', 'Công ty N'),
(15, 'Kem tươi', 'gram', 180.00, '2025-06-01 15:00:00', 'Công ty O');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoice`
--

CREATE TABLE `invoice` (
  `invoice_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_method` varchar(20) DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `invoice`
--

INSERT INTO `invoice` (`invoice_id`, `employee_id`, `customer_id`, `total_amount`, `timestamp`, `payment_method`, `discount`) VALUES
(16, 1, 1, 150000.00, '2025-06-15 13:59:47', 'tiền mặt', 0.00),
(17, 2, 2, 200000.00, '2025-06-15 13:59:47', 'thẻ', 10000.00),
(18, 3, 3, 87500.00, '2025-06-15 13:59:47', 'QR', 0.00),
(19, 4, 4, 120000.00, '2025-06-15 13:59:47', 'tiền mặt', 5000.00),
(20, 5, 5, 253000.00, '2025-06-15 13:59:47', 'thẻ', 0.00),
(21, 6, 6, 182000.00, '2025-06-15 13:59:47', 'QR', 20000.00),
(22, 7, 7, 95000.00, '2025-06-15 13:59:47', 'tiền mặt', 0.00),
(23, 8, 8, 140000.00, '2025-06-15 13:59:47', 'thẻ', 0.00),
(24, 9, 9, 221000.00, '2025-06-15 13:59:47', 'QR', 15000.00),
(25, 10, 10, 78000.00, '2025-06-15 13:59:47', 'tiền mặt', 0.00),
(26, 11, 11, 164000.00, '2025-06-15 13:59:47', 'thẻ', 0.00),
(27, 12, 12, 190000.00, '2025-06-15 13:59:47', 'QR', 10000.00),
(28, 13, 13, 112500.00, '2025-06-15 13:59:47', 'tiền mặt', 0.00),
(29, 14, 14, 239000.00, '2025-06-15 13:59:47', 'thẻ', 0.00),
(30, 15, 15, 176000.00, '2025-06-15 13:59:47', 'QR', 5000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `online_order`
--

CREATE TABLE `online_order` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `delivery_address` text DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `payment_status` varchar(20) DEFAULT 'unpaid'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `online_order`
--

INSERT INTO `online_order` (`order_id`, `customer_id`, `order_time`, `delivery_address`, `total_amount`, `status`, `payment_status`) VALUES
(1, 1, '2025-06-01 02:00:00', '123 Phố A, Q1, HCM', 125000.00, 'đang chờ', 'unpaid'),
(2, 2, '2025-06-01 03:15:00', '456 Đường B, Q2, HCM', 200000.00, 'đang chuẩn bị', 'paid'),
(3, 3, '2025-06-02 04:30:00', '789 Phố C, Q3, HCM', 157500.00, 'đã giao', 'paid'),
(4, 4, '2025-06-02 05:45:00', '321 Đường D, Q4, HCM', 182000.00, 'đã hủy', 'unpaid'),
(5, 5, '2025-06-03 07:00:00', '654 Phố E, Q5, HCM', 224000.00, 'đang chờ', 'unpaid'),
(6, 6, '2025-06-03 08:10:00', '987 Đường F, Q6, HCM', 199000.00, 'đang chuẩn bị', 'paid'),
(7, 7, '2025-06-04 09:25:00', '159 Phố G, Q7, HCM', 113000.00, 'đã giao', 'paid'),
(8, 8, '2025-06-04 10:40:00', '753 Đường H, Q8, HCM', 246000.00, 'đang chờ', 'unpaid'),
(9, 9, '2025-06-05 11:55:00', '852 Phố I, Q9, HCM', 135000.00, 'đang chuẩn bị', 'paid'),
(10, 10, '2025-06-05 12:05:00', '951 Đường J, Q10, HCM', 178000.00, 'đã hủy', 'unpaid'),
(11, 11, '2025-06-06 01:20:00', '258 Phố K, Q11, HCM', 142000.00, 'đang chờ', 'unpaid'),
(12, 12, '2025-06-06 02:35:00', '369 Đường L, Q12, HCM', 210000.00, 'đã giao', 'paid'),
(13, 13, '2025-06-07 03:50:00', '147 Phố M, Thủ Đức', 167500.00, 'đang chuẩn bị', 'paid'),
(14, 14, '2025-06-07 05:05:00', '258 Đường N, Bình Thạnh', 193000.00, 'đang chờ', 'unpaid'),
(15, 15, '2025-06-08 06:20:00', '369 Phố O, Gò Vấp', 231000.00, 'đã giao', 'paid');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `recipe`
--

CREATE TABLE `recipe` (
  `recipe_id` int(11) NOT NULL,
  `drink_id` int(11) NOT NULL,
  `steps` text DEFAULT NULL,
  `preparation_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `recipe`
--

INSERT INTO `recipe` (`recipe_id`, `drink_id`, `steps`, `preparation_time`) VALUES
(1, 1, 'Pha phin ủ 4–5 phút, khuấy đều.', 4),
(2, 2, 'Pha phin, thêm sữa, khuấy nhẹ.', 5),
(3, 3, 'Pha phin, thêm sữa đặc và ít bọt.', 5),
(4, 4, 'Espresso, thêm foam và sữa nóng.', 5),
(5, 5, 'Pha phin, thêm ca cao, đánh bọt.', 6),
(6, 6, 'Hãm trà matcha trong nước 80°C.', 3),
(7, 7, 'Hãm trà đen, thêm đường và chanh.', 4),
(8, 8, 'Ngâm trà vải, lắc đều với đá.', 4),
(9, 9, 'Xay dâu + sữa chua + đá.', 7),
(10, 10, 'Xay xoài + sữa chua + đá.', 7),
(11, 11, 'Vắt cam, lọc bã, thêm đá.', 3),
(12, 12, 'Vắt táo, thêm đá và đường.', 3),
(13, 13, 'Pha espresso, tạo foam nhẹ.', 3),
(14, 14, 'Đun nước và gia vị chai, thêm sữa.', 5),
(15, 15, 'Pha phin, xay cộng đá và sữa lạnh.', 8);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `shift_management`
--

CREATE TABLE `shift_management` (
  `shift_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `shift_type` varchar(20) DEFAULT 'normal',
  `note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `shift_management`
--

INSERT INTO `shift_management` (`shift_id`, `employee_id`, `date`, `start_time`, `end_time`, `shift_type`, `note`) VALUES
(1, 1, '2025-06-01', '08:00:00', '16:00:00', 'normal', ''),
(2, 2, '2025-06-02', '09:00:00', '17:00:00', 'normal', ''),
(3, 3, '2025-06-03', '08:00:00', '16:00:00', 'normal', ''),
(4, 4, '2025-06-04', '10:00:00', '18:00:00', 'normal', 'Ca UK'),
(5, 5, '2025-06-05', '08:00:00', '16:00:00', 'normal', ''),
(6, 6, '2025-06-06', '09:00:00', '17:00:00', 'normal', ''),
(7, 7, '2025-06-07', '08:00:00', '16:00:00', 'normal', ''),
(8, 8, '2025-06-08', '10:00:00', '18:00:00', 'normal', ''),
(9, 9, '2025-06-09', '08:00:00', '16:00:00', 'normal', ''),
(10, 10, '2025-06-10', '09:00:00', '17:00:00', 'normal', ''),
(11, 11, '2025-06-11', '08:00:00', '16:00:00', 'normal', ''),
(12, 12, '2025-06-12', '10:00:00', '18:00:00', 'normal', ''),
(13, 13, '2025-06-13', '08:00:00', '16:00:00', 'normal', ''),
(14, 14, '2025-06-14', '09:00:00', '17:00:00', 'normal', ''),
(15, 15, '2025-06-15', '08:00:00', '16:00:00', 'normal', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_account`
--

CREATE TABLE `user_account` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user_account`
--

INSERT INTO `user_account` (`user_id`, `username`, `password`, `role`, `created_at`, `last_login`, `status`) VALUES
(1, 'user01', 'mk01', 'admin', '2025-06-15 13:56:31', '2025-06-01 01:00:00', 'active'),
(2, 'user02', 'mk02', 'nhân viên', '2025-06-15 13:56:31', '2025-06-02 02:15:00', 'active'),
(3, 'user03', 'mk03', 'nhân viên', '2025-06-15 13:56:31', '2025-06-03 03:30:00', 'active'),
(4, 'user04', 'mk04', 'nhân viên', '2025-06-15 13:56:31', '2025-06-04 04:45:00', 'inactive'),
(5, 'user05', 'mk05', 'admin', '2025-06-15 13:56:31', '2025-06-05 05:00:00', 'active'),
(6, 'user06', 'mk06', 'nhân viên', '2025-06-15 13:56:31', '2025-06-06 06:20:00', 'active'),
(7, 'user07', 'mk07', 'nhân viên', '2025-06-15 13:56:31', '2025-06-07 07:35:00', 'active'),
(8, 'user08', 'mk08', 'nhân viên', '2025-06-15 13:56:31', '2025-06-08 08:50:00', 'active'),
(9, 'user09', 'mk09', 'nhân viên', '2025-06-15 13:56:31', '2025-06-09 09:05:00', 'inactive'),
(10, 'user10', 'mk10', 'admin', '2025-06-15 13:56:31', '2025-06-10 10:10:00', 'active'),
(11, 'user11', 'mk11', 'nhân viên', '2025-06-15 13:56:31', '2025-06-11 01:25:00', 'active'),
(12, 'user12', 'mk12', 'nhân viên', '2025-06-15 13:56:31', '2025-06-12 02:40:00', 'active'),
(13, 'user13', 'mk13', 'nhân viên', '2025-06-15 13:56:31', '2025-06-13 03:55:00', 'active'),
(14, 'user14', 'mk14', 'nhân viên', '2025-06-15 13:56:31', '2025-06-14 05:10:00', 'active'),
(15, 'user15', 'mk15', 'admin', '2025-06-15 13:56:31', '2025-06-15 06:25:00', 'active');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Chỉ mục cho bảng `drink`
--
ALTER TABLE `drink`
  ADD PRIMARY KEY (`drink_id`);

--
-- Chỉ mục cho bảng `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Chỉ mục cho bảng `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`ingredient_id`);

--
-- Chỉ mục cho bảng `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoice_id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Chỉ mục cho bảng `online_order`
--
ALTER TABLE `online_order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Chỉ mục cho bảng `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`recipe_id`),
  ADD KEY `drink_id` (`drink_id`);

--
-- Chỉ mục cho bảng `shift_management`
--
ALTER TABLE `shift_management`
  ADD PRIMARY KEY (`shift_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Chỉ mục cho bảng `user_account`
--
ALTER TABLE `user_account`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `drink`
--
ALTER TABLE `drink`
  MODIFY `drink_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `ingredient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `invoice`
--
ALTER TABLE `invoice`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `online_order`
--
ALTER TABLE `online_order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `recipe`
--
ALTER TABLE `recipe`
  MODIFY `recipe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `shift_management`
--
ALTER TABLE `shift_management`
  MODIFY `shift_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `user_account`
--
ALTER TABLE `user_account`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`);

--
-- Các ràng buộc cho bảng `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Các ràng buộc cho bảng `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  ADD CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Các ràng buộc cho bảng `online_order`
--
ALTER TABLE `online_order`
  ADD CONSTRAINT `online_order_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Các ràng buộc cho bảng `recipe`
--
ALTER TABLE `recipe`
  ADD CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`drink_id`) REFERENCES `drink` (`drink_id`);

--
-- Các ràng buộc cho bảng `shift_management`
--
ALTER TABLE `shift_management`
  ADD CONSTRAINT `shift_management_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
