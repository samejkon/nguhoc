-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th5 19, 2025 lúc 02:30 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `nguhoc`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `accessory`
--

CREATE TABLE `accessory` (
  `id_accessory` int(11) NOT NULL,
  `name_products` varchar(150) NOT NULL,
  `cat_accessory` varchar(50) NOT NULL COMMENT 'phím, chuột, usb...'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `accessory`
--

INSERT INTO `accessory` (`id_accessory`, `name_products`, `cat_accessory`) VALUES
(1, 'Pin sạc dự phòng Powergo Smart 12w 10000mAh Innostyle', 'Phím'),
(2, 'Pin sạc dự phòng Magsafe QC 3.0/PD 20.5W', 'Phím'),
(3, 'Ốp lưng chống sốc iPhone 14', 'Chuột'),
(4, 'Ốp lưng iPhone 16 Pro Max', 'Chuột'),
(5, 'Tai nghe Bluetooth', 'Tai nghe');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `discount` int(10) UNSIGNED NOT NULL,
  `min_order_amount` decimal(10,2) DEFAULT NULL,
  `usage_limit` int(10) UNSIGNED DEFAULT NULL,
  `user_limit` int(10) UNSIGNED DEFAULT NULL,
  `start_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `coupons`
--

INSERT INTO `coupons` (`id`, `code`, `discount`, `min_order_amount`, `usage_limit`, `user_limit`, `start_date`, `end_date`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'CHAOHE', 300000, 20000000.00, 100, 1, '2025-05-18 16:55:53', '2025-05-19 17:00:00', 1, '2025-05-18 06:36:23', '2025-05-18 06:36:23'),
(2, 'CHAOTET', 300000, 0.00, 10, 1, '2025-05-18 16:41:08', '2025-05-22 17:00:00', 0, '2025-05-18 06:48:14', '2025-05-18 06:48:14'),
(3, 'CHAOBUOITOI', 500000, 15000000.00, 2, 1, '2025-05-18 16:58:54', '2025-05-18 17:00:00', 0, '2025-05-18 09:43:20', '2025-05-18 09:58:54'),
(4, 'XDYPFXBP', 300000, 450000.00, 10, 1, '2025-05-18 23:39:28', '2025-05-18 17:00:00', 0, '2025-05-18 16:38:08', '2025-05-18 16:39:28');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `coupon_users`
--

CREATE TABLE `coupon_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `coupon_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `used_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `coupon_users`
--

INSERT INTO `coupon_users` (`id`, `coupon_id`, `user_id`, `used_count`, `created_at`, `updated_at`) VALUES
(1, 1, 66, 2, '2025-05-18 07:24:00', '2025-05-18 07:25:57'),
(2, 3, 69, 1, '2025-05-18 09:57:29', '2025-05-18 09:57:29'),
(3, 3, 66, 1, '2025-05-18 09:58:54', '2025-05-18 09:58:54');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `discount`
--

CREATE TABLE `discount` (
  `id_discount` varchar(50) NOT NULL COMMENT 'giam100k, giam200k, giam300k ',
  `describes` varchar(255) DEFAULT NULL,
  `reduced_price` double NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `discount`
--

INSERT INTO `discount` (`id_discount`, `describes`, `reduced_price`, `start_date`, `end_date`) VALUES
('giam100k', 'Giam100k', 100000, '2023-06-28', '2023-08-22'),
('giam200k', 'Giảm 200k', 200000, '2023-06-28', '2023-08-30'),
('Giam300k', 'nhanh tay nào các bạn giảm giá hập dẫn', 300000, '2025-04-17', '2025-04-19'),
('giam500k', 'giamgia 500k sinh nhat cua web', 500000, '2023-06-29', '2023-07-31'),
('giam50k', 'Giam50k', 50000, '2025-05-05', '2025-05-05');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `feedback`
--

CREATE TABLE `feedback` (
  `id_feedback` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '0 là chưa đọc, 1 là đã đọc',
  `id_users` int(11) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `feedback`
--

INSERT INTO `feedback` (`id_feedback`, `content`, `status`, `id_users`, `date_created`) VALUES
(13, 'Tôi cần tư vấn laptop xịn', 1, 38, '2023-06-28 22:01:42'),
(14, 'tôi muốn mua 1 số ít sản phẩm nhờ shop tư vấn hàng nào chất lượng tầm giá tiền sv vs ạ', 1, 53, '2025-03-27 03:03:56'),
(15, 'muốn mua nhiều sản phẩm', 1, 54, '2025-04-15 04:37:23'),
(16, 'Tư vấn sản phẩm a', 1, 65, '2025-05-18 17:06:29'),
(17, 'Sản phẩm a này có tốt thật không', 0, 65, '2025-05-19 00:30:03');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `gift`
--

CREATE TABLE `gift` (
  `id_gift` int(11) NOT NULL,
  `name_products` varchar(150) NOT NULL,
  `id_products_1` int(11) DEFAULT NULL,
  `id_products_2` int(11) DEFAULT NULL,
  `id_products_3` int(11) DEFAULT NULL,
  `id_products_4` int(11) DEFAULT NULL,
  `id_products_5` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `gift`
--

INSERT INTO `gift` (`id_gift`, `name_products`, `id_products_1`, `id_products_2`, `id_products_3`, `id_products_4`, `id_products_5`) VALUES
(1, 'Pin sạc dự phòng Powergo Smart 12w 10000mAh Innostyle', NULL, NULL, NULL, NULL, NULL),
(2, 'Pin sạc dự phòng Magsafe QC 3.0/PD 20.5W', NULL, NULL, NULL, NULL, NULL),
(3, 'Ốp lưng chống sốc iPhone 14', NULL, NULL, NULL, NULL, NULL),
(4, 'Ốp lưng iPhone 16 Pro Max', NULL, NULL, NULL, NULL, NULL),
(5, 'Tai nghe Bluetooth', NULL, NULL, NULL, NULL, NULL),
(6, 'Samsung Galaxy A56', 2, NULL, NULL, NULL, NULL),
(7, 'iPhone 16 Pro Max', 2, 5, NULL, NULL, NULL),
(8, 'Xiaomi Poco M6 Pro', 2, 4, 5, NULL, NULL),
(10, 'iPhone 11', 1, 3, NULL, NULL, NULL),
(11, 'iPhone 14', 2, NULL, NULL, NULL, NULL),
(12, 'iPhone 15', 1, 3, 5, NULL, NULL),
(13, 'OPPO A3', 2, 4, 5, NULL, NULL),
(14, 'OPPO Reno12 F', NULL, NULL, NULL, NULL, NULL),
(16, 'Samsung Galaxy S25 Ultra', 1, 2, 5, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoice`
--

CREATE TABLE `invoice` (
  `id_invoice` int(11) NOT NULL,
  `name_receiver` varchar(50) NOT NULL,
  `phone_receiver` varchar(10) NOT NULL COMMENT 'chỉ chứa ký tự là số, 10 ký tự, ký tự đầu là 0',
  `address_receiver` varchar(255) NOT NULL,
  `id_users` int(11) NOT NULL,
  `id_discount` varchar(50) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `total_money` double NOT NULL COMMENT '(VND)',
  `delivery_status` tinyint(4) NOT NULL COMMENT '0 là đã hủy, 1 là chờ xác nhận,\r\n2 là đang chuẩn bị hàng, 3 là đang giao, 4 là đã giao thành công',
  `payments` tinyint(4) NOT NULL COMMENT '0 là tiền mặt, 1 là chuyển khoản, 2 là momo',
  `debt` double NOT NULL COMMENT '0 là đã thanh toán, !=0 là công nợ',
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `invoice`
--

INSERT INTO `invoice` (`id_invoice`, `name_receiver`, `phone_receiver`, `address_receiver`, `id_users`, `id_discount`, `note`, `total_money`, `delivery_status`, `payments`, `debt`, `date_created`) VALUES
(29, 'Tú Vinh', '0349521973', 'Tiền Giang', 38, NULL, NULL, 25650000, 4, 0, 0, '2023-06-28 21:43:31'),
(30, 'Test mot', '0907301577', 'Test', 37, NULL, 'tezst', 1000000, 4, 0, 0, '2023-06-28 23:00:50'),
(31, 'Test mot', '0907301577', 'Test', 37, NULL, NULL, 67000000, 4, 0, 0, '2023-06-28 23:07:39'),
(33, 'Test hai', '0907301579', 'Tiền Gian', 39, NULL, 'dasdasdd', 21790000, 4, 0, 0, '2023-06-29 11:18:30'),
(34, 'Test ba', '0907301576', 'Bến Tre', 40, NULL, 'Test', 115000000, 4, 0, 0, '2023-06-29 11:19:05'),
(35, 'Test Một', '0909936621', 'TpHCM', 41, NULL, 'dasdadada', 23240000, 4, 0, 0, '2023-06-29 11:54:57'),
(36, 'Test Một', '0909936621', 'TpHCM', 41, NULL, NULL, 18000000, 4, 0, 0, '2023-06-29 11:58:19'),
(37, 'TEst Muoi', '0909936628', 'Tien Giang', 42, 'giam500k', 'asdadadasda', 13000000, 4, 0, 0, '2023-06-29 12:19:16'),
(38, 'Test Mười', '0349521970', 'Tiền Giang', 43, 'giam500k', 'dasdadas', 43560000, 4, 0, 0, '2023-06-29 12:27:11'),
(39, 'Tú Vinh', '0349521973', 'Tiền Giang', 38, 'giam500k', 'dadadadsd', 23000000, 4, 0, 0, '2023-06-29 12:42:51'),
(40, 'test mười một', '0909912344', 'Test mười một', 44, NULL, 'dadasd', 23000000, 4, 0, 0, '2023-07-14 20:22:50'),
(41, 'fefe', '0689589493', 'grgrfcd', 46, NULL, NULL, 14750000, 4, 2, 0, '2023-07-15 16:05:02'),
(42, 'Thanh Thiên', '0349521979', 'Tiền Giang', 47, NULL, 'dasdadasd', 57300000, 4, 0, 0, '2023-07-25 10:26:28'),
(43, 'Test Mười Hai', '0964532140', 'Tiền Giang', 48, NULL, 'dasdadd', 338000000, 4, 0, 0, '2023-07-27 19:59:10'),
(45, 'Nguyễn Thanh Lâm', '0989275330', '55A Đinh Bộ Lĩnh,Phường 25 ,Quận Bình Thạnh,TP Hồ Chí Minh', 50, NULL, 'OKKK', 13000000, 4, 0, -13000000, '2023-10-05 10:25:46'),
(46, 'Nguyễn Thành Trung', '0987654321', '55A Đinh Bộ Lĩnh,Phường 25 ,Quận Bình Thạnh,TP Hồ Chí Minh', 51, NULL, 'OKKKKK', 67600000, 4, 0, -67600000, '2023-10-05 10:38:16'),
(47, 'Võ Ngọc Hiếu', '0704553346', 'Vũ phạm hàm, hòa sơn hòa vang TP Đà Nẵng', 53, NULL, 'nhanh nha shop', 51800000, 4, 2, 0, '2025-03-23 01:43:53'),
(48, 'trung thành', '0704564586', 'điện bàn quảng nam', 54, NULL, 'nhanh', 51800000, 4, 0, -51800000, '2025-04-15 02:45:34'),
(49, 'trung thành', '0704564586', 'điện bàn quảng nam', 54, NULL, NULL, 23000000, 4, 0, -23000000, '2025-04-15 03:40:18'),
(50, 'Võ Ngọc Hiếu', '0704553346', 'Vũ phạm hàm, hòa sơn hòa vang TP Đà Nẵng', 53, NULL, NULL, 18000000, 4, 1, 0, '2025-04-15 03:43:19'),
(51, 'Võ Ngọc H', '0905888888', 'điện bàn quảng nam', 55, NULL, NULL, 80000000, 4, 1, 0, '2025-04-21 21:13:50'),
(52, 'trung thành', '0704564586', 'điện bàn quảng nam', 54, NULL, NULL, 23000000, 2, 0, -23000000, '2025-04-23 06:06:52'),
(53, 'lê anh hoàng', '0905888963', 'núi thành đà nẵng', 56, 'giam50k', NULL, 180000000, 2, 2, 0, '2025-05-05 05:28:05'),
(54, 'Nguyễn Thị Huê', '0375616574', 'Quảng Trị', 66, NULL, NULL, 30700000, 2, 0, -30700000, '2025-05-18 14:24:00'),
(55, 'Nguyễn Thị Huê', '0375616574', 'Quảng Trị', 66, NULL, NULL, 25700000, 4, 0, -25700000, '2025-05-18 14:25:57'),
(56, 'Nguyễn Thị Huê', '0375616574', 'Quảng Trị', 66, NULL, NULL, 26000000, 2, 0, -26000000, '2025-05-18 14:38:03'),
(57, 'Hiếu', '0123464123', 'Đà Nẵng', 69, NULL, NULL, 25500000, 0, 0, -25500000, '2025-05-18 16:57:29'),
(58, 'Nguyễn Thị Huê', '0375616574', 'Quảng Trị', 66, NULL, NULL, 17500000, 1, 0, -17500000, '2025-05-18 16:58:54');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoice_details`
--

CREATE TABLE `invoice_details` (
  `id_invoice_details` int(11) NOT NULL,
  `id_invoice` int(11) NOT NULL,
  `id_products` int(11) NOT NULL,
  `guarantee` tinyint(4) NOT NULL COMMENT '	3, 6, 12...(tháng)',
  `qty` int(11) NOT NULL COMMENT '(cái)',
  `dongia` double NOT NULL COMMENT '(VND)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `invoice_details`
--

INSERT INTO `invoice_details` (`id_invoice_details`, `id_invoice`, `id_products`, `guarantee`, `qty`, `dongia`) VALUES
(248, 31, 1, 3, 1, 0),
(249, 31, 3, 6, 1, 0),
(250, 31, 5, 1, 1, 0),
(251, 31, 12, 12, 1, 23000000),
(252, 31, 2, 3, 1, 0),
(253, 31, 6, 12, 1, 10500000),
(254, 31, 1, 3, 1, 0),
(255, 31, 3, 6, 1, 0),
(256, 31, 5, 1, 1, 0),
(257, 31, 12, 12, 1, 23000000),
(258, 31, 2, 3, 1, 0),
(259, 31, 6, 12, 1, 10500000),
(281, 35, 1, 3, 1, 0),
(282, 35, 3, 6, 1, 0),
(283, 35, 4, 3, 1, 240000),
(284, 35, 5, 1, 1, 0),
(285, 35, 12, 12, 1, 23000000),
(300, 39, 1, 3, 1, 0),
(301, 39, 3, 6, 1, 0),
(302, 39, 5, 1, 1, 0),
(303, 39, 12, 12, 1, 23000000),
(308, 40, 1, 3, 1, 0),
(309, 40, 3, 6, 1, 0),
(310, 40, 5, 1, 1, 0),
(311, 40, 12, 12, 1, 23000000),
(312, 37, 2, 3, 1, 0),
(313, 37, 11, 3, 1, 13000000),
(314, 41, 3, 6, 1, 850000),
(315, 41, 2, 3, 1, 0),
(316, 41, 4, 3, 1, 0),
(317, 41, 5, 1, 1, 0),
(318, 41, 8, 3, 1, 15000000),
(319, 30, 14, 0, 1, 1000000),
(320, 33, 1, 3, 1, 0),
(321, 33, 3, 6, 1, 0),
(322, 33, 10, 24, 1, 21790000),
(323, 34, 1, 3, 5, 0),
(324, 34, 3, 6, 5, 0),
(325, 34, 5, 1, 5, 0),
(326, 34, 12, 12, 5, 23000000),
(327, 36, 1, 3, 1, 0),
(328, 36, 14, 3, 1, 18000000),
(329, 29, 2, 3, 1, 0),
(330, 29, 2, 3, 1, 0),
(331, 29, 5, 1, 1, 0),
(332, 29, 6, 12, 1, 10500000),
(333, 29, 7, 12, 1, 15150000),
(342, 42, 1, 3, 1, 0),
(343, 42, 2, 3, 1, 0),
(344, 42, 2, 3, 1, 0),
(345, 42, 2, 3, 1, 0),
(346, 42, 5, 1, 1, 0),
(347, 42, 6, 12, 1, 10500000),
(348, 42, 11, 3, 1, 13000000),
(349, 42, 16, 24, 1, 33800000),
(350, 38, 1, 3, 2, 0),
(351, 38, 3, 6, 2, 0),
(352, 38, 10, 24, 2, 21780000),
(357, 43, 1, 3, 10, 0),
(358, 43, 2, 3, 10, 0),
(359, 43, 5, 1, 10, 0),
(360, 43, 16, 24, 10, 33800000),
(377, 46, 1, 3, 2, 0),
(378, 46, 2, 3, 2, 0),
(379, 46, 5, 1, 2, 0),
(380, 46, 16, 24, 2, 33800000),
(381, 47, 1, 3, 1, 0),
(382, 47, 2, 3, 1, 0),
(383, 47, 5, 1, 1, 0),
(384, 47, 16, 24, 1, 33800000),
(385, 47, 1, 3, 1, 0),
(386, 47, 14, 3, 1, 18000000),
(387, 45, 2, 3, 1, 0),
(388, 45, 4, 3, 1, 0),
(389, 45, 5, 1, 1, 0),
(390, 45, 13, 3, 1, 13000000),
(397, 48, 1, 3, 1, 0),
(398, 48, 1, 3, 1, 0),
(399, 48, 2, 3, 1, 0),
(400, 48, 5, 1, 1, 0),
(401, 48, 14, 3, 1, 18000000),
(402, 48, 16, 24, 1, 33800000),
(403, 49, 1, 3, 1, 0),
(404, 49, 3, 6, 1, 0),
(405, 49, 5, 1, 1, 0),
(406, 49, 12, 12, 1, 23000000),
(411, 50, 1, 3, 1, 0),
(412, 50, 14, 3, 1, 18000000),
(413, 51, 10, 0, 10, 8000000),
(414, 52, 1, 3, 1, 0),
(415, 52, 3, 1, 1, 0),
(416, 52, 5, 6, 1, 0),
(417, 52, 12, 12, 1, 23000000),
(418, 53, 14, 12, 10, 18000000),
(419, 54, 14, 12, 1, 18000000),
(420, 54, 2, 3, 1, 0),
(421, 54, 4, 1, 1, 0),
(422, 54, 5, 6, 1, 0),
(423, 54, 13, 3, 1, 13000000),
(424, 55, 2, 3, 2, 0),
(425, 55, 4, 1, 2, 0),
(426, 55, 5, 6, 2, 0),
(427, 55, 13, 3, 2, 13000000),
(428, 56, 2, 3, 2, 0),
(429, 56, 4, 1, 2, 0),
(430, 56, 5, 6, 2, 0),
(431, 56, 13, 3, 2, 13000000),
(432, 57, 2, 3, 2, 0),
(433, 57, 4, 1, 2, 0),
(434, 57, 5, 6, 2, 0),
(435, 57, 13, 3, 2, 13000000),
(436, 58, 14, 12, 1, 18000000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `laptop`
--

CREATE TABLE `laptop` (
  `id_laptop` int(11) NOT NULL,
  `name_products` varchar(150) NOT NULL,
  `cpu` varchar(50) NOT NULL COMMENT 'core i3, core i5, core i7...',
  `ram` tinyint(4) NOT NULL COMMENT '4, 8, 16...(GB)',
  `card_laptop` tinyint(4) NOT NULL COMMENT '0 là onboard, 1 là nvidia, 2 là amd',
  `disk_laptop` smallint(6) NOT NULL COMMENT '128, 256, 512...(GB)',
  `screen` float NOT NULL COMMENT '13.3, 14.0, 15.6...(inch)',
  `demand` varchar(50) NOT NULL COMMENT 'sinh viên, đồ họa, gaming',
  `status` tinyint(4) NOT NULL COMMENT '0 là mới, 1 là cũ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `laptop`
--

INSERT INTO `laptop` (`id_laptop`, `name_products`, `cpu`, `ram`, `card_laptop`, `disk_laptop`, `screen`, `demand`, `status`) VALUES
(1, 'Samsung Galaxy A56', 'Intel Core i3-1005G1', 8, 2, 128, 6.9, 'Đồ Họa', 1),
(2, 'iPhone 16 Pro Max', 'Apple A18 Bionic', 8, 0, 256, 6.9, 'Gaming', 0),
(3, 'Xiaomi Poco M6 Pro', 'Helio G99-Ultra', 8, 1, 256, 14, 'Sinh Viên', 0),
(5, 'iPhone 11', 'Apple A11 Bionic', 16, 0, 256, 6.7, 'Đồ Họa', 0),
(6, 'iPhone 14', 'Apple A16 Bionic', 8, 0, 256, 6.5, 'Đồ Họa', 1),
(7, 'iPhone 15', 'Apple A16 Bionic', 16, 0, 256, 6.1, 'Đồ Họa', 0),
(8, 'OPPO A3', 'Mediatek Dimensity', 8, 2, 128, 6.8, 'Sinh Viên', 1),
(9, 'OPPO Reno12 F', 'Mediatek Dimensity', 8, 2, 256, 6.7, 'Đồ Họa', 1),
(10, 'Samsung Galaxy S25 Ultra', 'chip Snapdragon® 8 Elite', 16, 1, 256, 6.9, 'Đồ Họa', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `manufacturer`
--

CREATE TABLE `manufacturer` (
  `id_mfg` int(11) NOT NULL,
  `name_mfg` varchar(50) NOT NULL COMMENT 'asus, acer, dell...',
  `cat_mfg` tinyint(4) NOT NULL COMMENT '0 là hãng của laptop, 1 là hãng của phụ kiện'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `manufacturer`
--

INSERT INTO `manufacturer` (`id_mfg`, `name_mfg`, `cat_mfg`) VALUES
(6, 'LOGITECH', 1),
(7, 'IAOXAOCHO', 1),
(10, 'APPLE', 0),
(11, 'SAMSUNG', 0),
(12, 'XIAOMI', 0),
(13, 'OPPO', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_05_17_021828_create_coupons_table', 1),
(6, '2025_05_18_090717_create_coupon_users_table', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `photo`
--

CREATE TABLE `photo` (
  `id_photo` int(11) NOT NULL,
  `name_products` varchar(150) NOT NULL,
  `photo_1` varchar(255) NOT NULL COMMENT 'laptop.jpg, phim.png, chuot.jpeg...',
  `photo_2` varchar(255) DEFAULT NULL,
  `photo_3` varchar(255) DEFAULT NULL,
  `photo_4` varchar(255) DEFAULT NULL,
  `photo_5` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `photo`
--

INSERT INTO `photo` (`id_photo`, `name_products`, `photo_1`, `photo_2`, `photo_3`, `photo_4`, `photo_5`) VALUES
(1, 'Pin sạc dự phòng Powergo Smart 12w 10000mAh Innostyle', 'Pin sạc dự phòng Powergo Smart 12w 10000mAh Innostyle-1745236912-0.jpg', 'Pin sạc dự phòng Powergo Smart 12w 10000mAh Innostyle-1745236912-1.jpg', 'Pin sạc dự phòng Powergo Smart 12w 10000mAh Innostyle-1745236912-2.jpg', 'Pin sạc dự phòng Powergo Smart 12w 10000mAh Innostyle-1745236912-3.jpg', 'Pin sạc dự phòng Powergo Smart 12w 10000mAh Innostyle-1745236912-4.jpg'),
(2, 'Pin sạc dự phòng Magsafe QC 3.0/PD 20.5W', 'Pin sạc dự phòng Magsafe QC 3.0/PD 20.5W-1745236637-0.jpg', 'Pin sạc dự phòng Magsafe QC 3.0/PD 20.5W-1745236637-1.jpg', 'Pin sạc dự phòng Magsafe QC 3.0/PD 20.5W-1745236637-2.jpg', 'Pin sạc dự phòng Magsafe QC 3.0/PD 20.5W-1745236637-3.jpg', 'Pin sạc dự phòng Magsafe QC 3.0/PD 20.5W-1745236637-4.jpg'),
(3, 'Ốp lưng chống sốc iPhone 14', 'Ốp lưng chống sốc iPhone 14-1745236472-0.jpg', 'Ốp lưng chống sốc iPhone 14-1745236472-1.jpg', 'Ốp lưng chống sốc iPhone 14-1745236472-2.jpg', 'Ốp lưng chống sốc iPhone 14-1745236472-3.jpg', 'Ốp lưng chống sốc iPhone 14-1745236472-4.jpg'),
(4, 'Ốp lưng iPhone 16 Pro Max', 'Ốp lưng iPhone 16 Pro Max-1745236453-0.jpg', 'Ốp lưng iPhone 16 Pro Max-1745236453-1.jpg', 'Ốp lưng iPhone 16 Pro Max-1745236453-2.jpg', 'Ốp lưng iPhone 16 Pro Max-1745236453-3.jpg', 'Ốp lưng iPhone 16 Pro Max-1745236453-4.jpg'),
(5, 'Tai nghe Bluetooth', 'Tai nghe Bluetooth-1745236307-0.jpg', 'Tai nghe Bluetooth-1745236307-1.jpg', 'Tai nghe Bluetooth-1745236307-2.jpg', 'Tai nghe Bluetooth-1745236307-3.jpg', 'Tai nghe Bluetooth-1745236307-4.jpg'),
(6, 'Samsung Galaxy A56', 'Samsung Galaxy A56-1745238821-0.jpg', 'Samsung Galaxy A56-1745238821-1.jpg', 'Samsung Galaxy A56-1745238821-2.jpg', 'Samsung Galaxy A56-1745238821-3.jpg', 'Samsung Galaxy A56-1745238821-4.jpg'),
(7, 'iPhone 16 Pro Max', 'iPhone 16 Pro Max-1745238647-0.jpg', 'iPhone 16 Pro Max-1745238647-1.jpg', 'iPhone 16 Pro Max-1745238647-2.jpg', 'iPhone 16 Pro Max-1745238647-3.jpg', 'iPhone 16 Pro Max-1745238647-4.jpg'),
(8, 'Xiaomi Poco M6 Pro', 'Xiaomi Poco M6 Pro-1745225190-0.png', 'Xiaomi Poco M6 Pro-1745225190-1.jpg', 'Xiaomi Poco M6 Pro-1745225190-2.jpg', 'Xiaomi Poco M6 Pro-1745225190-3.jpg', 'Xiaomi Poco M6 Pro-1745225190-4.jpg'),
(10, 'iPhone 11', 'iPhone 11-1745239287-0.jpg', 'iPhone 11-1745239287-1.jpg', 'iPhone 11-1745239287-2.jpg', 'iPhone 11-1745239287-3.jpg', 'iPhone 11-1745239287-4.jpg'),
(11, 'iPhone 14', 'iPhone 14-1745239020-0.jpg', 'iPhone 14-1745239020-1.jpg', 'iPhone 14-1745239020-2.jpg', 'iPhone 14-1745239020-3.jpg', 'iPhone 14-1745239020-4.jpg'),
(12, 'iPhone 15', 'iPhone 15-1745239046-0.jpg', 'iPhone 15-1745239046-1.jpg', 'iPhone 15-1745239046-2.jpg', 'iPhone 15-1745239046-3.jpg', 'iPhone 15-1745239046-4.jpg'),
(13, 'OPPO A3', 'OPPO A3-1745240923-0.jpg', 'OPPO A3-1745240923-1.jpg', 'OPPO A3-1745240923-2.jpg', 'OPPO A3-1745240923-3.jpg', 'OPPO A3-1745240923-4.jpg'),
(14, 'OPPO Reno12 F', 'OPPO Reno12 F-1745241072-0.jpg', 'OPPO Reno12 F-1745241072-1.jpg', 'OPPO Reno12 F-1745241072-2.jpg', 'OPPO Reno12 F-1745241072-3.jpg', 'OPPO Reno12 F-1745241072-4.jpg'),
(16, 'Samsung Galaxy S25 Ultra', 'Samsung Galaxy S25 Ultra-1745238400-0.jpg', 'Samsung Galaxy S25 Ultra-1745238400-1.jpg', 'Samsung Galaxy S25 Ultra-1745238400-2.jpg', 'Samsung Galaxy S25 Ultra-1745238400-3.jpg', 'Samsung Galaxy S25 Ultra-1745238400-4.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id_products` int(11) NOT NULL,
  `name_products` varchar(150) NOT NULL COMMENT 'vivobook, swift, thinkpad...',
  `guarantee` tinyint(4) NOT NULL COMMENT '3, 6, 12...(tháng)',
  `describes` varchar(1024) DEFAULT NULL,
  `qty` int(11) NOT NULL COMMENT '12, 35, 0...(cái)',
  `entry_price` double NOT NULL COMMENT 'giá nhập hàng (VND)',
  `sale_price` double NOT NULL COMMENT 'giá bán cho khách (VND)',
  `promotional_price` double DEFAULT NULL COMMENT 'giá khuyến mãi nếu có sản phẩm sẽ dc bán theo giá này (VND)',
  `id_photo` int(11) DEFAULT NULL,
  `id_mfg` int(11) DEFAULT NULL,
  `id_gift` int(11) DEFAULT NULL,
  `id_laptop` int(11) DEFAULT NULL,
  `id_accessory` int(11) DEFAULT NULL,
  `cat_products` tinyint(4) NOT NULL COMMENT '0 là laptop, 1 là phụ kiện',
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id_products`, `name_products`, `guarantee`, `describes`, `qty`, `entry_price`, `sale_price`, `promotional_price`, `id_photo`, `id_mfg`, `id_gift`, `id_laptop`, `id_accessory`, `cat_products`, `date_created`) VALUES
(1, 'Pin sạc dự phòng Powergo Smart 12w 10000mAh Innostyle', 3, 'Sạc dự phòng Innostyle Powergo Smart 12W 10000mAh là một sản phẩm tích hợp nhiều tính năng nổi bật, giúp bạn tiện lợi và an tâm trong việc sạc năng lượng cho các thiết bị di động của mình.', -33, 100000, 350000, 320000, 1, 7, 1, NULL, 1, 1, '2022-06-18 16:10:26'),
(2, 'Pin sạc dự phòng Magsafe QC 3.0/PD 20.5W', 3, 'Sạc dự phòng Yoobao Magsafe QC 3.0/PD 20.5W 10.000 mAh là một sản phẩm đa chức năng với nhiều tính năng nổi bật.', -26, 100000, 130000, NULL, 2, 6, 2, NULL, 2, 1, '2022-06-18 16:11:52'),
(3, 'Ốp lưng chống sốc iPhone 14', 1, 'Ốp lưng YVS Silicone dành cho iPhone 14 Max (iPhone 14 Plus) là sự lựa chọn hoàn hảo để bảo vệ thiết bị của bạn một cách toàn diện. Với thiết kế trong suốt tinh tế', -15, 100000, 850000, NULL, 3, 7, 3, NULL, 3, 1, '2022-06-18 16:13:19'),
(4, 'Ốp lưng iPhone 16 Pro Max', 1, 'Là phụ kiện bảo vệ iPhone 16 Pro Max do chính Apple thiết kế, sản xuất và kiểm định chất lượng', -5, 100000, 240000, NULL, 4, 6, 4, NULL, 4, 1, '2022-06-18 16:14:25'),
(5, 'Tai nghe Bluetooth', 6, 'tai nghe thích hợp cho việc học online có mic đàm thoại\r\nTai Nghe Logitech H111\r\nbảo hành 1 tháng', -2, 875000, 1137500, NULL, 5, 6, 5, NULL, 5, 1, '2022-06-18 16:16:13'),
(6, 'Samsung Galaxy A56', 12, 'Samsung Galaxy A56 5G thuyết phục người dùng với bộ công cụ AI mạnh mẽ, tích hợp nhiều tính năng hiện đại, dễ sử dụng, cùng hiệu năng vượt trội từ vi xử lý Exynos 1580. Ngoài ra, thiết bị còn được hỗ trợ cập nhật phần mềm lên đến 6 năm, mang lại trải nghiệm ổn định và lâu dài, giúp người dùng yên tâm sử dụng.', -4, 10000000, 12000000, 10500000, 6, 11, 6, 1, NULL, 0, '2022-06-19 20:51:45'),
(7, 'iPhone 16 Pro Max', 12, 'Gây ấn tượng bởi kiểu dáng thanh lịch, iPhone 16 Pro Max có cấu trúc khung vỏ được chế tác kỳ công từ chất liệu Titan Cấp 5 siêu bền và siêu nhẹ. Ngoài ra, Apple cũng cải tiến cấu trúc tản nhiệt bên trong thân máy để duy trì hiệu suất tốt hơn 20% so với thế hệ cũ, đem đến cho người dùng một thiết bị vừa sang trọng, vừa mạnh mẽ.\r\n\r\nNgoài khả năng chống nước và chống bụi đáng kinh ngạc, iPhone 16 Pro Max còn đạt đến chuẩn mực mới về độ bền khi sử dụng chất liệu Ceramic Shield bảo vệ cực tốt cho màn hình. Sản phẩm lên kệ với các tùy chọn màu sang trọng gồm: Titan Đen, Titan Trắng, Titan Tự Nhiên và Titan Sa Mạc.', -1, 10000000, 16000000, 15150000, 7, 10, 7, 2, NULL, 0, '2022-06-19 21:01:20'),
(8, 'Xiaomi Poco M6 Pro', 12, 'Xiaomi Poco M6 Pro 8GB 256GB cũ đã kích hoạt có khả năng hoạt động mượt mà với CPU MediaTek Helio G99-Ultra cao cấp, dung lượng bộ nhớ trong đến 256GB. Điện thoại có ngoại hình gần như mới, kích thước màn hình 6.67 inches mang lại không gian hiển thị rộng rãi. Hệ thống camera hiện đại hỗ trợ người dùng chụp ảnh chuyên nghiệp, rõ nét.', -1, 10000000, 15000000, 13900000, 8, 12, 8, 3, NULL, 0, '2022-06-19 21:03:21'),
(10, 'iPhone 11', 12, 'Phiên bản iPhone 11 128GB được người dùng yêu thích bởi dung lượng bộ nhớ đủ dùng, camera kép cực đỉnh và những lựa chọn màu sắc vô cùng thời trang.\r\n\r\niPhone 11\r\n\r\nThiết kế cao cấp, hiện đại và tươi trẻ\r\nThật dễ dàng để thể hiện cá tính riêng của mình trên iPhone 11 128GB. Bạn sẽ có 6 lựa chọn màu sắc Tím, Vàng, Xanh lục, Đen, Trắng và Đỏ đầy phong cách. Vẻ đẹp của iPhone 11 đến từ thiết kế cao cấp khi được làm từ khung nhôm nguyên khối và mặt lưng liền lạc với một tấm kính duy nhất. Ở mặt trước, bạn sẽ được chiêm ngưỡng màn hình Liquid Retina lớn 6,1 inch, màu sắc vô cùng chân thực. Trên tay bạn là một chiếc iPhone vừa vặn, cao cấp và rất trẻ trung.', -13, 10000000, 22000000, 21780000, 10, 10, 10, 5, NULL, 0, '2022-06-19 21:07:06'),
(11, 'iPhone 14', 9, 'Khoác lên kiểu dáng đặc trưng của dòng điện thoại iPhone, phiên bản iPhone 14 được cải tiến mạnh ở thời lượng pin và tập trung nâng cấp mạnh về camera nhằm đem đến những thước phim, khuôn hình đầy chất nghệ thuật và đạt chuẩn điện ảnh.\r\n\r\nThiết kế đầy bản sắc, gọn gàng và thân thiện\r\nTrên iPhone 14, bạn sẽ tìm thấy một kiểu dáng mang đậm bản sắc Apple với thân máy được hoàn thiện tỉ mỉ, chắc chắn mà vẫn nhẹ nhàng. Loại nhôm cấu tạo nên khung vỏ iPhone 14 được tuyển chọn kỹ lưỡng và là nguyên liệu cao cấp được ứng dụng phổ biến trong ngành hàng không.', 8, 16000000, 20800000, NULL, 11, 10, 11, 6, NULL, 0, '2022-06-19 21:09:55'),
(12, 'iPhone 15', 12, 'Laptop MSI Alpha 15 B5EEK 205VN là dòng laptop gaming luôn được các game thủ tin tưởng và yêu thích bởi sức mạnh không ngừng được cải thiện và thông số kỹ thuật tuyệt vời. MSI Alpha 15 là sự lựa chọn hợp lý cho các game thủ chuyên nghiệp.\r\nBảo hành 12 tháng. CPU Amd Ryzen 7-5800H. RAM 16 GB. Nhu cầu gaming game. Tình trạng mới. Ổ cứng 512 GB. Màn hình 15,6 15.6 inch. Card đồ hoạ Amd.', -11, 10000000, 23000000, NULL, 12, 10, 12, 7, NULL, 0, '2022-06-19 21:11:42'),
(13, 'OPPO A3', 3, 'OPPO A3 sở hữu giá bán hợp lý với thiết kế hiện đại cùng hiệu suất vượt trội bởi chipset mượt mà Snapdragon 6s 4G Gen 1, pin 5.100mAh, hỗ trợ sạc nhanh 45W và bộ nhớ 256GB, rất phù hợp dành cho người dùng trẻ năng động. Đặc biệt, thiết bị còn bền bỉ khi đạt chuẩn độ bền quân đội và tích hợp kháng bụi/nước IP54, giúp bạn sử dụng dài lâu.', -3, 10000000, 13000000, NULL, 13, 13, 13, 8, NULL, 0, '2022-06-19 21:13:37'),
(14, 'OPPO Reno12 F', 12, 'Phục kích ở nơi hiểm yếu, quan sát kĩ càng kẻ địch trước khi xuất trận mạnh mẽ, MSI Bravo 15 B5DD 276VN đã sẵn sàng cho chiến trường game rực lửa. Kết hợp hoàn hảo giữa vi xử lí AMD Ryzen 5 5600H và card đồ họa AMD Radeon RX 5500M. \r\nBảo hành 3 tháng. CPU Amd Ryzen 5-5600H. RAM 16 GB. Nhu cầu gaming game. Tình trạng cũ. Ổ cứng 516 GB. Màn hình 15,6 15.6 inch. Card đồ hoạ Amd.', 10, 10000000, 18000000, NULL, 14, 13, 14, 9, NULL, 0, '2022-06-19 21:14:58'),
(16, 'Samsung Galaxy S25 Ultra', 12, 'Samsung Galaxy S25 Ultra là chiếc điện thoại cao cấp nhất của nhà Samsung với những tính năng tiên phong dẫn đầu. Smartphone sở hữu thiết kế sang trọng, bền bỉ bởi khung Titan đẳng cấp kết hợp đó là trọn bộ công cụ AI thế hệ mới và Snapdragon 8 Elite for Galaxy mạnh mẽ, đảm bảo hiệu suất vượt trội, khả năng xử lý thông minh và trải nghiệm người dùng đỉnh cao.', -15, 26000000, 33800000, NULL, 16, 11, 16, 10, NULL, 0, '2023-07-14 21:17:42');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `purchase_order`
--

CREATE TABLE `purchase_order` (
  `id_purchase_order` int(11) NOT NULL,
  `id_users` int(11) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `total_money` double NOT NULL COMMENT '(VND)',
  `debt` double NOT NULL COMMENT '0 là đã thanh toán, !=0 là công nợ',
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `purchase_order`
--

INSERT INTO `purchase_order` (`id_purchase_order`, `id_users`, `note`, `total_money`, `debt`, `date_created`) VALUES
(7, 54, 'nhanh nhá', 69000000, -69000000, '2025-04-21 09:27:03'),
(8, 51, NULL, 160000000, -160000000, '2025-04-21 09:30:12'),
(9, 50, NULL, 25375000, 0, '2025-04-21 12:45:35');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `purchase_order_details`
--

CREATE TABLE `purchase_order_details` (
  `id_purchase_order_details` int(11) NOT NULL,
  `id_purchase_order` int(11) NOT NULL,
  `id_products` int(11) NOT NULL,
  `qty` int(11) NOT NULL COMMENT '(cái)',
  `dongia` double NOT NULL COMMENT '(VND)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `purchase_order_details`
--

INSERT INTO `purchase_order_details` (`id_purchase_order_details`, `id_purchase_order`, `id_products`, `qty`, `dongia`) VALUES
(87, 7, 14, 15, 4600000),
(88, 8, 11, 10, 16000000),
(89, 9, 5, 29, 875000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id_users` bigint(20) UNSIGNED NOT NULL,
  `name_users` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT '1',
  `roles` varchar(255) NOT NULL DEFAULT '0',
  `email` varchar(255) DEFAULT NULL,
  `date_created` date NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id_users`, `name_users`, `phone`, `address`, `status`, `roles`, `email`, `date_created`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', '0967087508', '41 đường 232 Cao Lỗ phường 4 Quận 8 TpHCM', '1', '2', 'admin@gmail.com', '2022-06-22', NULL, '$2y$12$QiZDy1t3ik.WC.3AIBP.BO7wY/2jPaKNu/f6aktAebBm9sKDXQfnW', NULL, NULL, NULL),
(2, 'Nguyễn Thanh Quân', '0907301573', 'TpHCM', '1', '0', 'quan@gmail.com', '2022-06-22', NULL, '$2y$10$bYUnHAGch.tOj.lCY6IjMO8f8hvaCMETE5Fcy8pyT.EJrrulvmH9i', NULL, NULL, NULL),
(3, 'Shop Vi Tính', '0909123456', 'TpHCM', '1', '1', NULL, '2022-06-22', NULL, '', NULL, NULL, NULL),
(4, 'Trường Đại Học STU', '0880123456', '180 Cao Lỗ, P4, Q8, HCM', '1', '0', NULL, '2022-06-22', NULL, '', NULL, NULL, NULL),
(20, 'Admin Vi Tính Shop', '0123123123', '41 đường 232 Cao Lỗ phường 4 Quận 8 TpHCM', '1', '2', 'admin@gmail.com', '2022-07-04', NULL, '$2y$10$bYUnHAGch.tOj.lCY6IjMO8f8hvaCMETE5Fcy8pyT.EJrrulvmH9i', NULL, NULL, NULL),
(37, 'Test mot', '0907301577', 'Test', '1', '0', 'test1@gmail.com', '2023-06-28', NULL, '$2y$10$UD7nX59sfI6kOc8smlXdHOlNjkt2Xkifbbn6Y.366Jx4XZrhViZte', NULL, NULL, NULL),
(38, 'Tú Vinh', '0349521973', 'Tiền Giang', '1', '0', 'vinh@gmail.com', '2023-06-28', NULL, '$2y$10$3HXmAQg5qLgx/McYjBbo5eqnYujc6bi1Bd4ohThmFzRKr7xXt53uK', NULL, NULL, NULL),
(39, 'Test hai', '0907301579', 'Tiền Gian', '1', '0', NULL, '2023-06-29', NULL, '', NULL, NULL, NULL),
(40, 'Test ba', '0907301576', 'Bến Tre', '1', '0', NULL, '2023-06-29', NULL, '', NULL, NULL, NULL),
(41, 'Test Một', '0909936621', 'TpHCM', '1', '0', 'test10@gmail.com', '2023-06-29', NULL, '$2y$10$Qswlm.F0UVfP2VLXdQvfVOl.MW/ZmDqnwAvWPEDq.amEL2.9CxlMi', NULL, NULL, NULL),
(42, 'TEst Muoi', '0909936628', 'Tien Giang', '1', '0', NULL, '2023-06-29', NULL, '', NULL, NULL, NULL),
(43, 'Test Mười', '0349521970', 'Tiền Giang', '1', '0', NULL, '2023-06-29', NULL, '', NULL, NULL, NULL),
(44, 'test mười một', '0909912344', 'Test mười một', '1', '0', NULL, '2023-07-14', NULL, '', NULL, NULL, NULL),
(45, 'Shop Vi Tính Hai', '0907301572', 'Tiền Giang', '1', '1', NULL, '2023-07-14', NULL, '', NULL, NULL, NULL),
(46, 'fefe', '0689589493', 'grgrfcd', '1', '0', NULL, '2023-07-15', NULL, '', NULL, NULL, NULL),
(47, 'Thanh Thiên', '0349521979', 'Tiền Giang', '1', '0', NULL, '2023-07-25', NULL, '', NULL, NULL, NULL),
(48, 'Test Mười Hai', '0964532140', 'Tiền Giang', '1', '0', NULL, '2023-07-27', NULL, '', NULL, NULL, NULL),
(49, 'Test mười bốn', '0969874125', 'Thái Nguyên', '1', '0', NULL, '2023-07-27', NULL, '', NULL, NULL, NULL),
(50, 'Nguyễn Thanh Lâm', '0989275330', '55A Đinh Bộ Lĩnh,Phường 25 ,Quận Bình Thạnh,TP Hồ Chí Minh', '1', '0', 'nguyenthanhlam@gmail.com', '2023-10-05', NULL, '$2y$10$d9bzt7uN.mFOC1QoO4s1AugtFez8geC1XDEc2QLARcxoYW.g9Rytm', NULL, NULL, NULL),
(51, 'Nguyễn Thành Trung', '0987654321', '55A Đinh Bộ Lĩnh,Phường 25 ,Quận Bình Thạnh,TP Hồ Chí Minh', '1', '0', 'nguyenthanhtrung@gmail.com', '2023-10-05', NULL, '$2y$10$dFOwqxxaE2NIYkVRkNJOMO.4JcQWrm/y8YkVd7Fpe./Zc.3eNBH26', NULL, NULL, NULL),
(52, 'SHhgshshs', '0989786626', 'TPĐJJDJ', '1', '0', 'Test12345@gmail.com', '2024-05-09', NULL, '$2y$12$QiZDy1t3ik.WC.3AIBP.BO7wY/2jPaKNu/f6aktAebBm9sKDXQfnW', NULL, NULL, NULL),
(54, 'trung thành', '0704564586', 'điện bàn quảng nam', '1', '0', 'thanh123@gmail.com', '2025-04-15', NULL, '$2y$12$0foXFVdLhyY307JVSsbjE.AFOvKIV5pYOiiVV8fZf0eN07RjwoCXW', NULL, NULL, NULL),
(55, 'Võ Ngọc H', '0905888888', 'điện bàn quảng nam', '1', '0', NULL, '2025-04-21', NULL, '', NULL, NULL, NULL),
(56, 'lê anh hoàng', '0905888963', 'núi thành đà nẵng', '1', '0', 'ngochieu@gmail.com', '2025-05-05', NULL, '$2y$12$fsMvPgNlvFDGmP6v4I/ITuGDkxS0u4H3zPQ0.jFG/h2wW6vzkAi4K', NULL, NULL, NULL),
(57, 'dang long', '0799400599', 'hoa vang', '1', '2', 'danglong@gmail.com', '2025-05-05', NULL, '$2y$12$yZohZHjEjKqhTNiPJWyi.uE9hcxGL8.Jl4cz7fK9bcZz5jnmJSySS', NULL, NULL, NULL),
(58, 'Nguyễn Vũ Hán', '0704556565', 'tp hà nội', '0', '0', NULL, '2025-05-05', NULL, '', NULL, NULL, NULL),
(59, 'khanh khanh', '0905344599', 'da nang', '1', '0', NULL, '2025-05-05', NULL, '', NULL, NULL, NULL),
(60, 'khanh ngan ha', '0794561234', '432', '1', '0', 'khanhkhanh@gmail.com', '2025-05-05', NULL, '$2y$12$IKEbCN9I2QabudtR3piwC.NvkxJcvC2dP2o6TcaGWmDo0UyfOPj4W', NULL, NULL, NULL),
(61, 'Khanh Hong', '0376772343', 'hoa vang', '1', '0', 'khanhh@gmail.com', '2025-05-05', NULL, '$2y$12$oohx8OJA8uRz4xxbp4qIQ.T9wl6PGjgBePm8xee6EWdYvluWeV8.W', NULL, NULL, NULL),
(62, 'Khanh', '0905123123', '@ad', '1', '0', 'khanhhh@gmail.com', '2025-05-05', NULL, '$2y$12$YOt71dC7OI9zazbGLL2OsOjPcSfpOffpcW8Sf/08qXSm5EUqcbdjq', NULL, NULL, NULL),
(63, 'dang cong long', '0799344599', 'hoa vang', '1', '1', NULL, '2025-05-05', NULL, '', NULL, NULL, NULL),
(64, 'dang cong long', '0799344789', 'hoa vang', '1', '1', NULL, '2025-05-05', NULL, '', NULL, NULL, NULL),
(65, 'Ngáo', '0375616574', 'Quảng Trị', '1', '2', 'lequocphaikql@gmail.com', '0000-00-00', '2025-05-18 06:26:28', '$2y$12$soHTEDuF5PP/vJlS3ERdGe4ALFFx7GxeGHjYrAOzxW24LeAKez376', NULL, NULL, NULL),
(66, 'Ngáo', '0375616574', 'Quảng Trị', '1', '0', 'hue67.nguyen@gmail.com', '0000-00-00', '2025-05-18 06:35:07', '$2y$12$xeDV25K6AGSsZkQAGpTe0uHc3VKYANOZu8PlHavuGNtn5.0VU109e', NULL, NULL, NULL),
(68, 'Hùng', '0123456789', 'Đà Nẵng', '1', '1', 'vuminhhungltt904@gmail.com', '0000-00-00', '2025-05-18 08:19:05', '$2y$12$EdJqNLiW6iwubjTB87NwSeH53CpL8lyogSHJ/Z3GFNb8tfPX2N7WG', NULL, '2025-05-18 08:18:31', '2025-05-18 08:19:05'),
(69, 'Hiếu', '0123464123', 'Đà Nẵng', '1', '0', 'raysmon46@gmail.com', '0000-00-00', '2025-05-18 09:53:11', '$2y$12$04WHqpRHZpEnsKfe5bzKvOMj9rrLQy524K64CXXtMQ.1tiftJyXm2', NULL, '2025-05-18 09:51:07', '2025-05-18 09:53:11');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `accessory`
--
ALTER TABLE `accessory`
  ADD PRIMARY KEY (`id_accessory`);

--
-- Chỉ mục cho bảng `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coupons_code_unique` (`code`);

--
-- Chỉ mục cho bảng `coupon_users`
--
ALTER TABLE `coupon_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coupon_users_coupon_id_user_id_unique` (`coupon_id`,`user_id`),
  ADD KEY `coupon_users_user_id_foreign` (`user_id`);

--
-- Chỉ mục cho bảng `discount`
--
ALTER TABLE `discount`
  ADD PRIMARY KEY (`id_discount`);

--
-- Chỉ mục cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Chỉ mục cho bảng `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id_feedback`),
  ADD KEY `id_users` (`id_users`);

--
-- Chỉ mục cho bảng `gift`
--
ALTER TABLE `gift`
  ADD PRIMARY KEY (`id_gift`);

--
-- Chỉ mục cho bảng `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id_invoice`),
  ADD KEY `id_users` (`id_users`,`id_discount`),
  ADD KEY `makhuyenmai` (`id_discount`);

--
-- Chỉ mục cho bảng `invoice_details`
--
ALTER TABLE `invoice_details`
  ADD PRIMARY KEY (`id_invoice_details`),
  ADD KEY `madonhang` (`id_invoice`,`id_products`),
  ADD KEY `id_products` (`id_products`);

--
-- Chỉ mục cho bảng `laptop`
--
ALTER TABLE `laptop`
  ADD PRIMARY KEY (`id_laptop`);

--
-- Chỉ mục cho bảng `manufacturer`
--
ALTER TABLE `manufacturer`
  ADD PRIMARY KEY (`id_mfg`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Chỉ mục cho bảng `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Chỉ mục cho bảng `photo`
--
ALTER TABLE `photo`
  ADD PRIMARY KEY (`id_photo`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id_products`),
  ADD KEY `id_mfg` (`id_mfg`),
  ADD KEY `id_gift` (`id_gift`),
  ADD KEY `mahinh` (`id_photo`),
  ADD KEY `id_laptop` (`id_laptop`),
  ADD KEY `id_accessory` (`id_accessory`);

--
-- Chỉ mục cho bảng `purchase_order`
--
ALTER TABLE `purchase_order`
  ADD PRIMARY KEY (`id_purchase_order`),
  ADD KEY `id_users` (`id_users`);

--
-- Chỉ mục cho bảng `purchase_order_details`
--
ALTER TABLE `purchase_order_details`
  ADD PRIMARY KEY (`id_purchase_order_details`),
  ADD KEY `id_purchase_order` (`id_purchase_order`,`id_products`),
  ADD KEY `id_products` (`id_products`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_users`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `accessory`
--
ALTER TABLE `accessory`
  MODIFY `id_accessory` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `coupon_users`
--
ALTER TABLE `coupon_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id_feedback` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT cho bảng `gift`
--
ALTER TABLE `gift`
  MODIFY `id_gift` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT cho bảng `invoice`
--
ALTER TABLE `invoice`
  MODIFY `id_invoice` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT cho bảng `invoice_details`
--
ALTER TABLE `invoice_details`
  MODIFY `id_invoice_details` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=437;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id_users` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `coupon_users`
--
ALTER TABLE `coupon_users`
  ADD CONSTRAINT `coupon_users_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `coupon_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_users`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
