-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 08, 2021 at 03:36 AM
-- Server version: 5.7.24
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kohinoor`
--

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE `adjustments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `adjustment_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `item` double(8,2) NOT NULL,
  `total_qty` double(8,2) NOT NULL,
  `total_tax` double NOT NULL,
  `grand_total` double NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adjustments`
--

INSERT INTO `adjustments` (`id`, `adjustment_no`, `warehouse_id`, `item`, `total_qty`, `total_tax`, `grand_total`, `note`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(2, 'ADJ-0821526', 2, 2.00, 360.00, 0, 9360, 'Lorem Ipsum Dollar', 'Super Admin', 'Super Admin', '2021-08-10 13:45:52', '2021-08-10 18:29:18');

-- --------------------------------------------------------

--
-- Table structure for table `adjustment_products`
--

CREATE TABLE `adjustment_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `adjustment_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `batch_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `base_unit_qty` double NOT NULL,
  `base_unit_price` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adjustment_products`
--

INSERT INTO `adjustment_products` (`id`, `adjustment_id`, `product_id`, `batch_no`, `base_unit_id`, `base_unit_qty`, `base_unit_price`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 2, 2, '1006', 1, 240, 20, 0, 0, 4800, '2021-08-09 18:00:00', '2021-08-10 18:29:18'),
(2, 2, 3, '1006', 1, 120, 38, 0, 0, 4560, '2021-08-09 18:00:00', '2021-08-10 18:29:18');

-- --------------------------------------------------------

--
-- Table structure for table `asms`
--

CREATE TABLE `asms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `nid_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monthly_target_value` double DEFAULT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asms`
--

INSERT INTO `asms` (`id`, `name`, `username`, `phone`, `email`, `avatar`, `password`, `district_id`, `address`, `nid_no`, `monthly_target_value`, `status`, `created_by`, `modified_by`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Mohammad Arman', 'Arman1394', '01521225987', 'armanarman456789@gmail.com', 'Mohammad-Arman-681501.JPG', '$2y$10$JGRZ6jBEs65JlbHcuiSDnei9L1KcRKtYnDMb7fPXy4vi/doZ0LxEi', 46, 'Lorem ipsum dollar', '44445555', 80000, '1', 'Super Admin', 'Super Admin', NULL, '2021-07-14 09:50:04', '2021-07-14 11:02:16'),
(2, 'Mr. Shahed', 'Shahed94', '01626939219', 'shahedcse94@gmail.com', NULL, '$2y$10$MuBLgyVNoECGRwRdu24.L.JIhYe77U1GOY.zZX4a2XvUCwIPr/mS6', 5, 'Lorem Ipsum Dollar', '456484654654', NULL, '1', 'Super Admin', NULL, NULL, '2021-07-16 19:01:59', '2021-07-16 19:01:59');

-- --------------------------------------------------------

--
-- Table structure for table `asm_module`
--

CREATE TABLE `asm_module` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `module_id` bigint(20) UNSIGNED NOT NULL,
  `asm_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asm_module`
--

INSERT INTO `asm_module` (`id`, `module_id`, `asm_id`, `created_at`, `updated_at`) VALUES
(1, 119, 1, '2021-08-14 06:26:00', '2021-08-14 06:26:00'),
(2, 121, 1, '2021-08-14 06:26:00', '2021-08-14 06:26:00'),
(3, 122, 1, '2021-08-14 06:26:00', '2021-08-14 06:26:00'),
(4, 123, 1, '2021-08-14 06:26:00', '2021-08-14 06:26:00'),
(5, 124, 1, '2021-08-14 06:26:00', '2021-08-14 06:26:00'),
(6, 135, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(7, 136, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(8, 137, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(9, 134, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(10, 138, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(11, 139, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(12, 140, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(13, 128, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(14, 129, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(15, 130, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(16, 131, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(17, 132, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(18, 133, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(19, 145, 1, '2021-08-16 08:04:02', '2021-08-16 08:04:02'),
(20, 141, 1, '2021-08-16 08:04:02', '2021-08-16 08:04:02'),
(21, 142, 1, '2021-08-16 08:04:02', '2021-08-16 08:04:02'),
(22, 143, 1, '2021-08-16 08:04:02', '2021-08-16 08:04:02'),
(23, 144, 1, '2021-08-16 08:04:02', '2021-08-16 08:04:02'),
(26, 148, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(27, 149, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(28, 150, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(29, 151, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(30, 152, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(31, 153, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(32, 154, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(33, 155, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(34, 156, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(35, 157, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(36, 158, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(37, 159, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(38, 160, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(39, 161, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(40, 162, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(41, 163, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(43, 165, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(44, 166, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(45, 167, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(46, 168, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(47, 169, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(48, 170, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(49, 171, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(50, 172, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(51, 173, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(52, 174, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(54, 176, 1, '2021-08-30 05:18:21', '2021-08-30 05:18:21'),
(55, 177, 1, '2021-08-30 05:18:21', '2021-08-30 05:18:21'),
(56, 178, 1, '2021-08-30 05:18:21', '2021-08-30 05:18:21');

-- --------------------------------------------------------

--
-- Table structure for table `asm_permission`
--

CREATE TABLE `asm_permission` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `asm_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asm_permission`
--

INSERT INTO `asm_permission` (`id`, `permission_id`, `asm_id`, `created_at`, `updated_at`) VALUES
(1, 371, 1, '2021-08-14 06:26:00', '2021-08-14 06:26:00'),
(2, 372, 1, '2021-08-14 06:26:00', '2021-08-14 06:26:00'),
(3, 373, 1, '2021-08-14 06:26:00', '2021-08-14 06:26:00'),
(4, 374, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(5, 375, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(6, 376, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(7, 377, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(8, 378, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(9, 379, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(10, 380, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(11, 381, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(12, 382, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(13, 383, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(14, 384, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(15, 385, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(16, 386, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(17, 387, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(18, 388, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(19, 389, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(20, 390, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(21, 391, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(22, 392, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(23, 393, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(24, 394, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(25, 395, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(26, 396, 1, '2021-08-16 07:35:55', '2021-08-16 07:35:55'),
(27, 397, 1, '2021-08-16 08:04:02', '2021-08-16 08:04:02'),
(28, 398, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(29, 399, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(30, 400, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(31, 401, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(32, 402, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(33, 403, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(34, 404, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(35, 405, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(36, 406, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(37, 407, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(38, 408, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(39, 409, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(40, 410, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(41, 411, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(42, 412, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(43, 413, 1, '2021-08-16 08:04:03', '2021-08-16 08:04:03'),
(44, 414, 1, '2021-08-16 11:04:42', '2021-08-16 11:04:42'),
(45, 415, 1, '2021-08-17 19:24:07', '2021-08-17 19:24:07'),
(48, 418, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(49, 419, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(50, 420, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(51, 421, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(52, 422, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(53, 423, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(54, 424, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(55, 425, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(56, 426, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(57, 427, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(58, 430, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(59, 431, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(60, 432, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(61, 433, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(62, 434, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(63, 435, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(64, 436, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(65, 437, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(66, 438, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(68, 440, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(69, 441, 1, '2021-08-23 17:43:21', '2021-08-23 17:43:21'),
(70, 442, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(71, 443, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(72, 444, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(73, 445, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(74, 446, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(75, 447, 1, '2021-08-29 03:57:32', '2021-08-29 03:57:32'),
(77, 449, 1, '2021-08-30 05:18:21', '2021-08-30 05:18:21'),
(78, 450, 1, '2021-08-30 05:18:21', '2021-08-30 05:18:21'),
(79, 451, 1, '2021-08-30 05:18:21', '2021-08-30 05:18:21');

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banks`
--

INSERT INTO `banks` (`id`, `bank_name`, `account_name`, `account_number`, `warehouse_id`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(2, 'SIBL Jamalpur Branch', 'Kohinoor', '4564556', 1, '1', 'Super Admin', NULL, '2021-08-27 14:00:45', '2021-08-27 14:00:45'),
(3, 'DBBL Feni Branch', 'Kohinoor', '465646456845', 2, '1', 'Super Admin', NULL, '2021-08-29 04:44:53', '2021-08-29 04:44:53');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('keapl_cache_active_taxes', 'O:29:\"Illuminate\\Support\\Collection\":1:{s:8:\"\0*\0items\";a:1:{i:0;O:8:\"stdClass\":8:{s:2:\"id\";i:1;s:4:\"name\";s:2:\"5%\";s:4:\"rate\";s:1:\"5\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-14 01:13:58\";s:10:\"updated_at\";s:19:\"2021-07-14 01:13:58\";}}}', 1945658319),
('keapl_cache_active_warehouses', 'O:29:\"Illuminate\\Support\\Collection\":1:{s:8:\"\0*\0items\";a:2:{i:0;O:8:\"stdClass\":13:{s:2:\"id\";i:1;s:4:\"name\";s:18:\"Jamalpur Warehouse\";s:5:\"phone\";s:11:\"01626939219\";s:5:\"email\";s:24:\"keapl.jamalpur@gmail.com\";s:7:\"address\";s:18:\"Lorem Ipsum Dollar\";s:11:\"district_id\";i:5;s:6:\"asm_id\";i:2;s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";s:11:\"Super Admin\";s:10:\"created_at\";s:19:\"2021-07-17 01:02:43\";s:10:\"updated_at\";s:19:\"2021-07-17 01:03:42\";}i:1;O:8:\"stdClass\":13:{s:2:\"id\";i:2;s:4:\"name\";s:14:\"Feni Warehouse\";s:5:\"phone\";s:11:\"01521225987\";s:5:\"email\";s:20:\"keapl.feni@gmail.com\";s:7:\"address\";s:10:\"Feni Sadar\";s:11:\"district_id\";i:46;s:6:\"asm_id\";i:1;s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-17 01:04:37\";s:10:\"updated_at\";s:19:\"2021-07-17 01:04:37\";}}}', 1946313175),
('keapl_cache_banks', 'O:29:\"Illuminate\\Support\\Collection\":1:{s:8:\"\0*\0items\";a:2:{i:0;O:8:\"stdClass\":10:{s:2:\"id\";i:3;s:9:\"bank_name\";s:16:\"DBBL Feni Branch\";s:12:\"account_name\";s:8:\"Kohinoor\";s:14:\"account_number\";s:12:\"465646456845\";s:12:\"warehouse_id\";i:2;s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-08-29 10:44:53\";s:10:\"updated_at\";s:19:\"2021-08-29 10:44:53\";}i:1;O:8:\"stdClass\":10:{s:2:\"id\";i:2;s:9:\"bank_name\";s:20:\"SIBL Jamalpur Branch\";s:12:\"account_name\";s:8:\"Kohinoor\";s:14:\"account_number\";s:7:\"4564556\";s:12:\"warehouse_id\";i:1;s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-08-27 20:00:45\";s:10:\"updated_at\";s:19:\"2021-08-27 20:00:45\";}}}', 1946369744),
('keapl_cache_material_categories', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":1:{s:8:\"\0*\0items\";a:6:{i:0;O:19:\"App\\Models\\Category\":37:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:6;s:4:\"name\";s:3:\"Can\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-31 15:31:45\";s:10:\"updated_at\";s:19:\"2021-07-31 15:31:45\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:6;s:4:\"name\";s:3:\"Can\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-31 15:31:45\";s:10:\"updated_at\";s:19:\"2021-07-31 15:31:45\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:19:\"App\\Models\\Category\":37:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:2;s:4:\"name\";s:7:\"Element\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";s:11:\"Super Admin\";s:10:\"created_at\";s:19:\"2021-07-14 01:13:10\";s:10:\"updated_at\";s:19:\"2021-07-31 15:31:14\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:2;s:4:\"name\";s:7:\"Element\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";s:11:\"Super Admin\";s:10:\"created_at\";s:19:\"2021-07-14 01:13:10\";s:10:\"updated_at\";s:19:\"2021-07-31 15:31:14\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:19:\"App\\Models\\Category\":37:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:8;s:4:\"name\";s:4:\"Foil\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-31 15:31:59\";s:10:\"updated_at\";s:19:\"2021-07-31 15:31:59\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:8;s:4:\"name\";s:4:\"Foil\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-31 15:31:59\";s:10:\"updated_at\";s:19:\"2021-07-31 15:31:59\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:19:\"App\\Models\\Category\":37:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:1;s:4:\"name\";s:6:\"Liquid\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";s:11:\"Super Admin\";s:10:\"created_at\";s:19:\"2021-07-14 01:12:56\";s:10:\"updated_at\";s:19:\"2021-07-31 15:31:00\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:1;s:4:\"name\";s:6:\"Liquid\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";s:11:\"Super Admin\";s:10:\"created_at\";s:19:\"2021-07-14 01:12:56\";s:10:\"updated_at\";s:19:\"2021-07-31 15:31:00\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:19:\"App\\Models\\Category\":37:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:7;s:4:\"name\";s:5:\"Paper\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-31 15:31:52\";s:10:\"updated_at\";s:19:\"2021-07-31 15:31:52\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:7;s:4:\"name\";s:5:\"Paper\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-31 15:31:52\";s:10:\"updated_at\";s:19:\"2021-07-31 15:31:52\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:19:\"App\\Models\\Category\":37:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:5;s:4:\"name\";s:6:\"Powder\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-31 15:31:23\";s:10:\"updated_at\";s:19:\"2021-07-31 15:31:23\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:5;s:4:\"name\";s:6:\"Powder\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-31 15:31:23\";s:10:\"updated_at\";s:19:\"2021-07-31 15:31:23\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}}', 1946313163),
('keapl_cache_mobile_banks', 'O:29:\"Illuminate\\Support\\Collection\":1:{s:8:\"\0*\0items\";a:2:{i:0;O:8:\"stdClass\":10:{s:2:\"id\";i:1;s:9:\"bank_name\";s:17:\"Bkash Feni Branch\";s:12:\"account_name\";s:14:\"Kohinoor Bkash\";s:14:\"account_number\";s:11:\"01521225698\";s:12:\"warehouse_id\";i:2;s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";s:11:\"Super Admin\";s:10:\"created_at\";s:19:\"2021-08-27 19:53:20\";s:10:\"updated_at\";s:19:\"2021-08-27 19:57:15\";}i:1;O:8:\"stdClass\":10:{s:2:\"id\";i:2;s:9:\"bank_name\";s:21:\"Bkash Jamalpur Branch\";s:12:\"account_name\";s:14:\"Kohinoor Bkash\";s:14:\"account_number\";s:11:\"01521225684\";s:12:\"warehouse_id\";i:1;s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-09-07 16:18:22\";s:10:\"updated_at\";s:19:\"2021-09-07 16:18:22\";}}}', 1946369942),
('keapl_cache_product_categories', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":1:{s:8:\"\0*\0items\";a:2:{i:0;O:19:\"App\\Models\\Category\":34:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:4;s:4:\"name\";s:6:\"Liquid\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-26 15:46:06\";s:10:\"updated_at\";s:19:\"2021-07-26 15:46:06\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:4;s:4:\"name\";s:6:\"Liquid\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-26 15:46:06\";s:10:\"updated_at\";s:19:\"2021-07-26 15:46:06\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:19:\"App\\Models\\Category\":34:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:3;s:4:\"name\";s:6:\"Powder\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-26 15:45:49\";s:10:\"updated_at\";s:19:\"2021-07-26 15:45:49\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:3;s:4:\"name\";s:6:\"Powder\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-07-26 15:45:49\";s:10:\"updated_at\";s:19:\"2021-07-26 15:45:49\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}}', 1946116196);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Material Category, 2=Product Category',
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `type`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Liquid', '1', '1', 'Super Admin', 'Super Admin', '2021-07-13 19:12:56', '2021-07-31 09:31:00'),
(2, 'Element', '1', '1', 'Super Admin', 'Super Admin', '2021-07-13 19:13:10', '2021-07-31 09:31:14'),
(3, 'Powder', '2', '1', 'Super Admin', NULL, '2021-07-26 09:45:49', '2021-07-26 09:45:49'),
(4, 'Liquid', '2', '1', 'Super Admin', NULL, '2021-07-26 09:46:06', '2021-07-26 09:46:06'),
(5, 'Powder', '1', '1', 'Super Admin', NULL, '2021-07-31 09:31:23', '2021-07-31 09:31:23'),
(6, 'Can', '1', '1', 'Super Admin', NULL, '2021-07-31 09:31:45', '2021-07-31 09:31:45'),
(7, 'Paper', '1', '1', 'Super Admin', NULL, '2021-07-31 09:31:52', '2021-07-31 09:31:52'),
(8, 'Foil', '1', '1', 'Super Admin', NULL, '2021-07-31 09:31:59', '2021-07-31 09:31:59');

-- --------------------------------------------------------

--
-- Table structure for table `chart_of_accounts`
--

CREATE TABLE `chart_of_accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  `type` enum('A','L','I','E') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'A=Asset, L=Liabilty, I=income, E=Expense',
  `transaction` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Yes, 2=No',
  `general_ledger` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Yes, 2=No',
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `supplier_id` bigint(20) UNSIGNED DEFAULT NULL,
  `budget` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Yes, 2=No',
  `depreciation` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Yes, 2=No',
  `depreciation_rate` double NOT NULL DEFAULT '0',
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chart_of_accounts`
--

INSERT INTO `chart_of_accounts` (`id`, `code`, `name`, `parent_name`, `level`, `type`, `transaction`, `general_ledger`, `customer_id`, `supplier_id`, `budget`, `depreciation`, `depreciation_rate`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, '1', 'Assets', 'COA', 0, 'A', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(2, '2', 'Equity', 'COA', 0, 'L', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(3, '3', 'Income', 'COA', 0, 'I', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(4, '4', 'Expense', 'COA', 0, 'E', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(5, '5', 'Liabilities', 'COA', 0, 'L', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(6, '101', 'Non Current Asset', 'Assets', 1, 'A', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(7, '102', 'Current Asset', 'Assets', 1, 'A', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(8, '301', 'Product Sale', 'Income', 1, 'I', '1', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(9, '302', 'Service Income', 'Income', 1, 'I', '1', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(10, '401', 'Default Expense', 'Expense', 1, 'E', '1', '2', NULL, NULL, '1', '1', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(11, '402', 'Material Purchase', 'Expense', 1, 'E', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(12, '403', 'Employee Salary', 'Expense', 1, 'E', '1', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(13, '404', 'Machine Purchase', 'Expense', 1, 'E', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(14, '405', 'Maintenance Service', 'Expense', 1, 'E', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(15, '501', 'Non Current Liabilities', 'Liabilities', 1, 'L', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(16, '502', 'Current Liabilities', 'Liabilities', 1, 'L', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(17, '10101', 'Inventory', 'Non Current Asset', 1, 'A', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(18, '10201', 'Cash & Cash Equivalent', 'Current Asset', 2, 'A', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(19, '10202', 'Account Receivable', 'Current Asset', 2, 'A', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(20, '50201', 'Account Payable', 'Current Liabilities', 2, 'L', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(21, '50202', 'Employee Ledger', 'Current Liabilities', 2, 'L', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(22, '50203', 'Tax', 'Current Liabilities', 2, 'L', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(23, '1020101', 'Cash In Hand', 'Cash & Cash Equivalent', 3, 'A', '1', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(24, '1020102', 'Cash At Bank', 'Cash & Cash Equivalent', 3, 'A', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(25, '1020103', 'Cash At Mobile Bank', 'Cash & Cash Equivalent', 3, 'A', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(26, '1020201', 'Customer Receivable', 'Account Receivable', 3, 'A', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(27, '1020202', 'Loan Receivable', 'Account Receivable', 3, 'A', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-04-02 23:14:59', '2021-04-02 23:14:59'),
(28, '5020101', '1-Md. Arman', 'Account Payable', 3, 'L', '1', '2', NULL, 1, '2', '2', 0, '1', 'Super Admin', NULL, '2021-08-11 08:16:56', '2021-08-11 08:16:56'),
(29, '5020102', '2-Md. Shahed', 'Account Payable', 3, 'L', '1', '2', NULL, 2, '2', '2', 0, '1', 'Super Admin', NULL, '2021-08-11 08:18:23', '2021-08-11 08:18:23'),
(30, '10202010001', '1-Md. Rakib', 'Customer Receivable', 4, 'A', '1', '2', 1, NULL, '2', '2', 0, '1', 'Mohammad Arman', NULL, '2021-08-16 08:55:53', '2021-08-16 08:55:53'),
(31, '10202010002', '2-Md. Salam', 'Customer Receivable', 4, 'A', '1', '2', 2, NULL, '2', '2', 0, '1', 'Mohammad Arman', NULL, '2021-08-16 09:18:55', '2021-08-16 09:18:55'),
(32, '4000001', '1-Utility Bill', 'Expense', 1, 'E', '1', '2', NULL, NULL, '1', '1', 1, '1', 'Mohammad Arman', NULL, '2021-08-23 22:45:47', '2021-08-23 22:45:47'),
(33, '4000002', '2-Labor Bill', 'Expense', 1, 'E', '1', '2', NULL, NULL, '1', '1', 1, '1', 'Mohammad Arman', NULL, '2021-08-23 22:45:58', '2021-08-23 22:46:20'),
(36, '102010301', 'Bkash Feni Branch', 'Cash At Mobile Bank', 4, 'A', '1', '2', NULL, NULL, '2', '2', 0, '1', 'Super Admin', 'Super Admin', '2021-08-27 13:53:20', '2021-08-27 13:57:15'),
(37, '102010202', 'SIBL Jamalpur Branch', 'Cash At Bank', 4, 'A', '1', '2', NULL, NULL, '2', '2', 0, '1', 'Super Admin', 'Super Admin', '2021-08-27 13:59:19', '2021-08-27 14:00:45'),
(38, '102010203', 'DBBL Feni Branch', 'Cash At Bank', 4, 'A', '1', '2', NULL, NULL, '2', '2', 0, '1', 'Super Admin', NULL, '2021-08-29 04:44:53', '2021-08-29 04:44:53'),
(39, '102010302', 'Bkash Jamalpur Branch', 'Cash At Mobile Bank', 4, 'A', '1', '2', NULL, NULL, '2', '2', 0, '1', 'Super Admin', NULL, '2021-09-07 10:18:23', '2021-09-07 10:18:23');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shop_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_group_id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `upazila_id` bigint(20) UNSIGNED NOT NULL,
  `route_id` bigint(20) UNSIGNED NOT NULL,
  `area_id` bigint(20) UNSIGNED NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `shop_name`, `mobile`, `email`, `avatar`, `customer_group_id`, `district_id`, `upazila_id`, `route_id`, `area_id`, `address`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Md. Rakib', 'Rakib Store', '01521225987', NULL, '48564-309547.png', 1, 46, 425, 566, 581, 'Lorem Ipsum Dollar', '1', 'Mohammad Arman', 'Mohammad Arman', '2021-08-16 08:55:53', '2021-08-16 10:38:40'),
(2, 'Md. Salam', 'Salam Store', '01521225985', NULL, NULL, 1, 46, 425, 566, 582, 'Lorem Ipsum Dollar', '1', 'Mohammad Arman', NULL, '2021-08-16 09:18:55', '2021-08-16 09:18:55');

-- --------------------------------------------------------

--
-- Table structure for table `customer_groups`
--

CREATE TABLE `customer_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `group_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `percentage` double(8,2) DEFAULT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=active,2=inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_groups`
--

INSERT INTO `customer_groups` (`id`, `group_name`, `percentage`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Regular', 0.00, '1', 'Super Admin', NULL, '2021-07-13 19:17:13', '2021-07-13 19:17:13');

-- --------------------------------------------------------

--
-- Table structure for table `daily_closings`
--

CREATE TABLE `daily_closings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `last_day_closing` double DEFAULT NULL,
  `cash_in` double DEFAULT NULL,
  `cash_out` double DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `transfer` double DEFAULT NULL,
  `closing_amount` double DEFAULT NULL,
  `adjustment` double DEFAULT NULL,
  `date` date NOT NULL,
  `thousands` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `five_hundred` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `hundred` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `fifty` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `twenty` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `ten` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `five` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `two` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `one` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `daily_closings`
--

INSERT INTO `daily_closings` (`id`, `warehouse_id`, `last_day_closing`, `cash_in`, `cash_out`, `balance`, `transfer`, `closing_amount`, `adjustment`, `date`, `thousands`, `five_hundred`, `hundred`, `fifty`, `twenty`, `ten`, `five`, `two`, `one`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 2, 0, 3540, 350, 3190, 2190, 1000, NULL, '2021-09-04', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Mohammad Arman', '0', '2021-09-04 10:11:49', '2021-09-04 10:11:49'),
(2, 1, 0, 100, 50, 50, 0, 50, NULL, '2021-09-07', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Super Admin', '0', '2021-09-07 09:47:17', '2021-09-07 09:47:17');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `expense_item_id` bigint(20) UNSIGNED NOT NULL,
  `voucher_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `date` date NOT NULL,
  `payment_type` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Cash,2=Bank,3=Mobile',
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `warehouse_id`, `expense_item_id`, `voucher_no`, `amount`, `date`, `payment_type`, `account_id`, `remarks`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'EXP-21082404746', 200, '2021-09-04', '1', 23, 'Electricity BIll Paid 200', 'Mohammad Arman', 'Mohammad Arman', '2021-08-23 22:47:26', '2021-09-04 09:25:45'),
(2, 2, 2, 'EXP-21082404528', 100, '2021-09-04', '1', 23, 'Labor bill paid 100', 'Mohammad Arman', 'Mohammad Arman', '2021-08-23 22:48:06', '2021-09-04 09:25:38'),
(3, 2, 2, 'EXP-21082404526', 50, '2021-09-04', '1', 23, 'Labor bill paid 50', 'Mohammad Arman', 'Mohammad Arman', '2021-08-23 22:49:07', '2021-09-04 09:25:31'),
(4, 1, 1, 'EXP-20210828150718402', 200, '2021-08-28', '1', 23, NULL, 'Super Admin', NULL, '2021-08-28 09:07:18', '2021-08-28 09:07:18');

-- --------------------------------------------------------

--
-- Table structure for table `expense_items`
--

CREATE TABLE `expense_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_items`
--

INSERT INTO `expense_items` (`id`, `name`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Utility Bill', '1', 'Mohammad Arman', NULL, '2021-08-23 22:45:47', '2021-08-23 22:45:47'),
(2, 'Labor Bill', '1', 'Mohammad Arman', 'Mohammad Arman', '2021-08-23 22:45:58', '2021-08-23 22:46:20');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `grand_parent_id` int(10) UNSIGNED DEFAULT NULL,
  `grand_grand_parent_id` int(10) UNSIGNED DEFAULT NULL,
  `type` enum('1','2','3','4') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=District, 2=Upazila, 3=Route,4=Area',
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `parent_id`, `grand_parent_id`, `grand_grand_parent_id`, `type`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Dhaka', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(2, 'Faridpur', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(3, 'Gazipur', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(4, 'Gopalganj', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(5, 'Jamalpur', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(6, 'Kishoreganj', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(7, 'Madaripur', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(8, 'Manikganj', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(9, 'Munshiganj', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(10, 'Mymensingh', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(11, 'Narayanganj', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(12, 'Narsingdi', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(13, 'Netrokona', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(14, 'Rajbari', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(15, 'Shariatpur', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(16, 'Sherpur', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(17, 'Tangail', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(18, 'Bogra', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(19, 'Joypurhat', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(20, 'Naogaon', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(21, 'Natore', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(22, 'Nawabganj', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(23, 'Pabna', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(24, 'Rajshahi', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(25, 'Sirajgonj', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(26, 'Dinajpur', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(27, 'Gaibandha', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(28, 'Kurigram', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(29, 'Lalmonirhat', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(30, 'Nilphamari', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(31, 'Panchagarh', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(32, 'Rangpur', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(33, 'Thakurgaon', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(34, 'Barguna', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(35, 'Barisal', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(36, 'Bhola', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(37, 'Jhalokati', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(38, 'Patuakhali', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(39, 'Pirojpur', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(40, 'Bandarban', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(41, 'Brahmanbaria', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(42, 'Chandpur', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(43, 'Chittagong', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(44, 'Comilla', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(45, 'Cox\'s Bazar', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(46, 'Feni', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(47, 'Khagrachari', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(48, 'Lakshmipur', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(49, 'Noakhali', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(50, 'Rangamati', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(51, 'Habiganj', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(52, 'Maulvibazar', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(53, 'Sunamganj', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(54, 'Sylhet', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(55, 'Bagerhat', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(56, 'Chuadanga', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(57, 'Jessore', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(58, 'Jhenaidah', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(59, 'Khulna', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(60, 'Kushtia', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(61, 'Magura', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(62, 'Meherpur', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(63, 'Narail', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(64, 'Satkhira', 0, NULL, NULL, '1', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(65, 'Gulsan 1', 1, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(66, 'Dhamrai Upazila', 1, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(67, 'Dohar Upazila', 1, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(68, 'Keraniganj Upazila', 1, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(69, 'Nawabganj Upazila', 1, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(70, 'Savar Upazila', 1, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(71, 'Charbhadrasan Upazila', 2, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(72, 'Sadarpur Upazila', 2, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(73, 'Shaltha Upazila', 2, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(74, 'Nagarkanda Upazila', 2, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(75, 'Bhanga Upazila', 2, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(76, 'Madhukhali Upazila', 2, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(77, 'Alfadanga Upazila', 2, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(78, 'Boalmari Upazila', 2, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(79, 'Faridpur Sadar Upazila', 2, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(80, 'Tongi', 3, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(81, 'Kaliganj', 3, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(82, 'Sripur', 3, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(83, 'Kapasia', 3, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(84, 'Kaliakior', 3, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(85, 'Gazipur Sadar-Joydebpur', 3, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(86, 'Kotalipara Upazila', 4, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(87, 'Tungipara Upazila', 4, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(88, 'Muksudpur Upazila', 4, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(89, 'Kashiani Upazila', 4, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(90, 'Gopalganj Sadar Upazila', 4, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(91, 'Sarishabari Upazila', 5, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(92, 'Melandaha Upazila', 5, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(93, 'Narundi Police I.C', 5, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(94, 'Madarganj Upazila', 5, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(95, 'Jamalpur Sadar Upazila', 5, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(96, 'Islampur Upazila', 5, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(97, 'Baksiganj Upazila', 5, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(98, 'Dewanganj Upazila', 5, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(99, 'Tarail Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(100, 'Pakundia Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(101, 'Nikli Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(102, 'Mithamain Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(103, 'Kuliarchar Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(104, 'Kishoreganj Sadar Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(105, 'Karimganj Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(106, 'Itna Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(107, 'Astagram Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(108, 'Bajitpur Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(109, 'Hossainpur Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(110, 'Bhairab Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(111, 'Katiadi Upazila', 6, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(112, 'Kalkini', 7, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(113, 'Rajoir', 7, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(114, 'Madaripur Sadar', 7, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(115, 'Shibchar', 7, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(116, 'Harirampur Upazila', 8, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(117, 'Manikganj Sadar Upazila', 8, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(118, 'Daulatpur Upazila', 8, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(119, 'Ghior Upazila', 8, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(120, 'Singair Upazila', 8, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(121, 'Shibalaya Upazila', 8, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(122, 'Saturia Upazila', 8, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(123, 'Tongibari Upazila', 9, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(124, 'Sirajdikhan Upazila', 9, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(125, 'Munshiganj Sadar Upazila', 9, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(126, 'Sreenagar Upazila', 9, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(127, 'Gazaria Upazila', 9, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(128, 'Lohajang Upazila', 9, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(129, 'Nandail', 10, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(130, 'Phulpur', 10, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(131, 'Mymensingh Sadar', 10, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(132, 'Ishwarganj', 10, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(133, 'Gauripur', 10, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(134, 'Gaffargaon', 10, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(135, 'Fulbaria', 10, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(136, 'Dhobaura', 10, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(137, 'Trishal', 10, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(138, 'Haluaghat', 10, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(139, 'Bhaluka', 10, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(140, 'Muktagachha', 10, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(141, 'Rupganj Upazila', 11, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(142, 'Naryanganj Sadar Upazila', 11, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(143, 'Bandar', 11, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(144, 'Sonargaon Upazila', 11, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(145, 'Araihazar Upazila', 11, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(146, 'Siddirgonj Upazila', 11, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(147, 'Shibpur Upazila', 12, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(148, 'Raipura Upazila, Narsingdi', 12, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(149, 'Palash Upazila', 12, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(150, 'Narsingdi Sadar Upazila', 12, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(151, 'Monohardi Upazila', 12, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(152, 'Belabo Upazila', 12, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(153, 'Khaliajuri Upazilla', 13, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(154, 'Purbadhala Upazilla', 13, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(155, 'Netrakona-S Upazilla', 13, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(156, 'Mohanganj Upazilla', 13, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(157, 'Madan Upazilla', 13, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(158, 'Kalmakanda Upazilla', 13, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(159, 'Durgapur Upazilla', 13, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(160, 'Barhatta Upazilla', 13, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(161, 'Atpara Upazilla', 13, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(162, 'Kendua Upazilla', 13, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(163, 'Rajbari Sadar Upazila', 14, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(164, 'Kalukhali Upazila', 14, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(165, 'Pangsha Upazila', 14, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(166, 'Goalandaghat Upazila', 14, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(167, 'Baliakandi Upazila', 14, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(168, 'Gosairhat Upazila', 15, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(169, 'Bhedarganj Upazila', 15, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(170, 'Jajira Upazila', 15, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(171, 'Damudya Upazila', 15, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(172, 'Shariatpur Sadar -Palong', 15, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(173, 'Naria Upazila', 15, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(174, 'Sreebardi Upazila', 16, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(175, 'Sherpur Sadar Upazila', 16, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(176, 'Nalitabari Upazila', 16, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(177, 'Nakla Upazila', 16, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(178, 'Jhenaigati Upazila', 16, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(179, 'Tangail Sadar Upazila', 17, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(180, 'Sakhipur Upazila', 17, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(181, 'Basail Upazila', 17, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(182, 'Madhupur Upazila', 17, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(183, 'Ghatail Upazila', 17, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(184, 'Kalihati Upazila', 17, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(185, 'Dhanbari Upazila', 17, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(186, 'Bhuapur Upazila', 17, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(187, 'Delduar Upazila', 17, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(188, 'Gopalpur Upazila', 17, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(189, 'Mirzapur Upazila', 17, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(190, 'Nagarpur Upazila', 17, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(191, 'Sonatala', 18, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(192, 'Shibganj', 18, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(193, 'Sariakandi', 18, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(194, 'Sahajanpur', 18, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(195, 'Nandigram', 18, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(196, 'Kahaloo', 18, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(197, 'Adamdighi', 18, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(198, 'Gabtali', 18, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(199, 'Dhupchanchia', 18, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(200, 'Dhunat', 18, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(201, 'Bogra Sadar', 18, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(202, 'Panchbibi', 19, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(203, 'Khetlal', 19, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(204, 'Kalai', 19, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(205, 'Joypurhat S', 19, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(206, 'Akkelpur', 19, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(207, 'Patnitala Upazila', 20, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(208, 'Dhamoirhat Upazila', 20, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(209, 'Sapahar Upazila', 20, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(210, 'Porsha Upazila', 20, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(211, 'Badalgachhi Upazila', 20, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(212, 'Atrai Upazila', 20, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(213, 'Niamatpur Upazila', 20, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(214, 'Raninagar Upazila', 20, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(215, 'Manda Upazila', 20, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(216, 'Mohadevpur Upazila', 20, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(217, 'Naogaon Sadar Upazila', 20, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(218, 'Baraigram Upazila', 21, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(219, 'Natore Sadar Upazila', 21, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(220, 'Lalpur Upazila', 21, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(221, 'Bagatipara Upazila', 21, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(222, 'Shibganj Upazila', 22, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(223, 'Nawabganj Sadar Upazila', 22, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(224, 'Nachole Upazila', 22, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(225, 'Gomastapur Upazila', 22, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(226, 'Bholahat Upazila', 22, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(227, 'Sujanagar Upazila', 23, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(228, 'Santhia Upazila', 23, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(229, 'Pabna Sadar Upazila', 23, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(230, 'Ishwardi Upazila', 23, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(231, 'Faridpur Upazila', 23, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(232, 'Chatmohar Upazila', 23, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(233, 'Bhangura Upazila', 23, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(234, 'Bera Upazila', 23, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(235, 'Atgharia Upazila', 23, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(236, 'Godagari', 24, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(237, 'Tanore', 24, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(238, 'Puthia', 24, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(239, 'Paba', 24, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(240, 'Mohanpur', 24, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(241, 'Durgapur', 24, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(242, 'Charghat', 24, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(243, 'Bagmara', 24, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(244, 'Bagha', 24, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(245, 'Chauhali Upazila', 25, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(246, 'Ullahpara Upazila', 25, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(247, 'Tarash Upazila', 25, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(248, 'Shahjadpur Upazila', 25, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(249, 'Raiganj Upazila', 25, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(250, 'Kazipur Upazila', 25, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(251, 'Kamarkhanda Upazila', 25, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(252, 'Belkuchi Upazila', 25, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(253, 'Sirajganj Sadar Upazila', 25, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(254, 'Hakimpur Upazila', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(255, 'Kaharole Upazila', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(256, 'Khansama Upazila', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(257, 'Dinajpur Sadar Upazila', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(258, 'Nawabganj', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(259, 'Parbatipur Upazila', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(260, 'Ghoraghat Upazila', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(261, 'Phulbari Upazila', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(262, 'Chirirbandar Upazila', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(263, 'Bochaganj Upazila', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(264, 'Biral Upazila', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(265, 'Birganj', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(266, 'Birampur Upazila', 26, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(267, 'Sadullapur', 27, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(268, 'Saghata', 27, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(269, 'Sundarganj', 27, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(270, 'Palashbari', 27, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(271, 'Gaibandha sadar', 27, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(272, 'Fulchhari', 27, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(273, 'Gobindaganj', 27, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(274, 'Char Rajibpur', 28, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(275, 'Rowmari', 28, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(276, 'Chilmari', 28, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(277, 'Ulipur', 28, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(278, 'Rajarhat', 28, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(279, 'Phulbari', 28, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(280, 'Bhurungamari', 28, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(281, 'Nageshwari', 28, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(282, 'Kurigram Sadar', 28, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(283, 'Patgram', 29, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(284, 'Hatibandha', 29, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(285, 'Kaliganj', 29, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(286, 'Aditmari', 29, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(287, 'Lalmanirhat Sadar', 29, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(288, 'Dimla', 30, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(289, 'Domar', 30, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(290, 'Kishoreganj', 30, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(291, 'Jaldhaka', 30, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(292, 'Saidpur', 30, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(293, 'Nilphamari Sadar', 30, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(294, 'Panchagarh Sadar', 31, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(295, 'Debiganj', 31, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(296, 'Boda', 31, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(297, 'Atwari', 31, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(298, 'Tetulia', 31, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(299, 'Kaunia', 32, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(300, 'Badarganj', 32, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(301, 'Mithapukur', 32, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(302, 'Gangachara', 32, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(303, 'Rangpur Sadar', 32, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(304, 'Pirgachha', 32, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(305, 'Pirganj', 32, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(306, 'Taraganj', 32, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(307, 'Baliadangi Upazila', 33, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(308, 'Thakurgaon Sadar Upazila', 33, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(309, 'Pirganj Upazila', 33, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(310, 'Haripur Upazila', 33, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(311, 'Ranisankail Upazila', 33, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(312, 'Patharghata Upazila', 34, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(313, 'Betagi Upazila', 34, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(314, 'Barguna Sadar Upazila', 34, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(315, 'Bamna Upazila', 34, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(316, 'Taltali Upazila', 34, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(317, 'Amtali Upazila', 34, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(318, 'Gaurnadi Upazila', 35, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(319, 'Banaripara Upazila', 35, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(320, 'Hizla Upazila', 35, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(321, 'Mehendiganj Upazila', 35, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(322, 'Wazirpur Upazila', 35, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(323, 'Bakerganj Upazila', 35, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(324, 'Barisal Sadar Upazila', 35, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(325, 'Babuganj Upazila', 35, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(326, 'Muladi Upazila', 35, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(327, 'Agailjhara Upazila', 35, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(328, 'Daulatkhan Upazila', 36, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(329, 'Tazumuddin Upazila', 36, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(330, 'Manpura Upazila', 36, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(331, 'Lalmohan Upazila', 36, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(332, 'Char Fasson Upazila', 36, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(333, 'Burhanuddin Upazila', 36, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(334, 'Bhola Sadar Upazila', 36, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(335, 'Nalchity Upazila', 37, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(336, 'Rajapur Upazila', 37, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(337, 'Jhalokati Sadar Upazila', 37, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(338, 'Kathalia Upazila', 37, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(339, 'Mirzaganj Upazila', 38, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(340, 'Patuakhali Sadar Upazila', 38, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(341, 'Rangabali Upazila', 38, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(342, 'Dumki Upazila', 38, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(343, 'Kalapara Upazila', 38, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(344, 'Galachipa Upazila', 38, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(345, 'Dashmina Upazila', 38, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(346, 'Bauphal Upazila', 38, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(347, 'Zianagar', 39, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(348, 'Pirojpur Sadar', 39, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(349, 'Nazirpur', 39, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(350, 'Mathbaria', 39, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(351, 'Kaukhali', 39, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(352, 'Bhandaria', 39, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(353, 'Nesarabad', 39, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(354, 'Rowangchhari', 40, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(355, 'Ruma', 40, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(356, 'Ali kadam', 40, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(357, 'Naikhongchhari', 40, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(358, 'Lama', 40, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(359, 'Thanchi', 40, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(360, 'Bandarban Sadar', 40, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(361, 'Bancharampur Upazila', 41, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(362, 'Bijoynagar Upazila', 41, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(363, 'Ashuganj Upazila', 41, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(364, 'Akhaura Upazila', 41, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(365, 'Kasba Upazila', 41, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(366, 'Shahbazpur Town', 41, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(367, 'Sarail Upazila', 41, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(368, 'Nabinagar Upazila', 41, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(369, 'Nasirnagar Upazila', 41, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(370, 'Brahmanbaria Sadar Upazila', 41, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(371, 'Shahrasti', 42, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(372, 'Matlab Dakkhin', 42, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(373, 'Matlab Uttar', 42, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(374, 'Kachua', 42, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(375, 'Haziganj', 42, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(376, 'Faridganj', 42, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(377, 'Chandpur Sadar', 42, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(378, 'Haimchar', 42, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(379, 'Patiya Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(380, 'Rangunia Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(381, 'Raozan Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(382, 'Sandwip Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(383, 'Satkania Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(384, 'Sitakunda Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(385, 'Mirsharai Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(386, 'Lohagara Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(387, 'Hathazari Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(388, 'Fatikchhari Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(389, 'Chandanaish Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(390, 'Khulshi', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(391, 'Banshkhali Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(392, 'Anwara Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(393, 'Panchlaish', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(394, 'Boalkhali Upazila', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(395, 'Chittagong Port', 43, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(396, 'Chauddagram Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(397, 'Monohorgonj Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(398, 'Laksam Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(399, 'Comilla Sadar Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(400, 'Homna Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(401, 'Debidwar Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(402, 'Daudkandi Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(403, 'Chandina Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(404, 'Burichong Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(405, 'Brahmanpara Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(406, 'Barura Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(407, 'Meghna Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(408, 'Nangalkot Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(409, 'Comilla Sadar South Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(410, 'Titas Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(411, 'Muradnagar Upazila', 44, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(412, 'Kutubdia Upazila', 45, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(413, 'Pekua Upazila', 45, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(414, 'Ukhia Upazila', 45, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(415, 'Teknaf Upazila', 45, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(416, 'Ramu Upazila', 45, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(417, 'Maheshkhali Upazila', 45, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(418, 'Cox\'s Bazar Sadar Upazila', 45, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(419, 'Chakaria Upazila', 45, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(420, 'Sonagazi', 46, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(421, 'Fhulgazi', 46, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(422, 'Parshuram', 46, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(423, 'Chagalnaiya', 46, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(424, 'Feni Sadar', 46, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(425, 'Daganbhuiyan', 46, NULL, NULL, '2', '1', 'Super Admin', 'Mohammad Arman', '2021-01-27 21:58:52', '2021-08-16 03:18:26'),
(426, 'Dighinala Upazila', 47, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(427, 'Ramgarh Upazila', 47, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(428, 'Panchhari Upazila', 47, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(429, 'Matiranga Upazila', 47, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(430, 'Mahalchhari Upazila', 47, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(431, 'Lakshmichhari Upazila', 47, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(432, 'Khagrachhari Upazila', 47, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(433, 'Manikchhari Upazila', 47, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(434, 'Lakshmipur Sadar Upazila', 48, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(435, 'Komol Nagar Upazila', 48, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(436, 'Ramgati Upazila', 48, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(437, 'Raipur Upazila', 48, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(438, 'Ramganj Upazila', 48, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(439, 'Chatkhil Upazila', 49, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(440, 'Begumganj Upazila', 49, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(441, 'Noakhali Sadar Upazila', 49, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(442, 'Shenbag Upazila', 49, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(443, 'Hatia Upazila', 49, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(444, 'Kobirhat Upazila', 49, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(445, 'Sonaimuri Upazila', 49, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(446, 'Suborno Char Upazila', 49, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(447, 'Companyganj Upazila', 49, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(448, 'Bagaichhari Upazila', 50, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(449, 'Kaptai Upazila', 50, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(450, 'Langadu Upazila', 50, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(451, 'Nannerchar Upazila', 50, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(452, 'Kaukhali Upazila', 50, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(453, 'Rajasthali Upazila', 50, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(454, 'Juraichhari Upazila', 50, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(455, 'Barkal Upazila', 50, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(456, 'Rangamati Sadar Upazila', 50, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(457, 'Belaichhari Upazila', 50, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(458, 'Nabiganj', 51, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(459, 'Madhabpur', 51, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(460, 'Lakhai', 51, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(461, 'Habiganj Sadar', 51, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(462, 'Chunarughat', 51, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(463, 'Shaistagonj Upazila', 51, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(464, 'Bahubal', 51, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(465, 'Ajmiriganj', 51, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(466, 'Baniachang', 51, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(467, 'Sreemangal', 52, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(468, 'Rajnagar', 52, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(469, 'Kulaura', 52, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(470, 'Kamalganj', 52, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(471, 'Barlekha', 52, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(472, 'Moulvibazar Sadar', 52, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(473, 'Juri', 52, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(474, 'Sulla', 53, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(475, 'Jamalganj', 53, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(476, 'Tahirpur', 53, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(477, 'Jagannathpur', 53, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(478, 'Dowarabazar', 53, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(479, 'Dharampasha', 53, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(480, 'Derai', 53, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(481, 'Chhatak', 53, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(482, 'Bishwamvarpur', 53, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(483, 'Shanthiganj', 53, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(484, 'Sunamganj Sadar', 53, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(485, 'Sylhet Sadar', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(486, 'Beanibazar', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(487, 'Bishwanath', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(488, 'Balaganj', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(489, 'Companiganj', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(490, 'Golapganj', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(491, 'Gowainghat', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(492, 'Jaintiapur', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(493, 'Kanaighat', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(494, 'Fenchuganj', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(495, 'Zakiganj', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(496, 'Nobigonj', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(497, 'Dakshin Surma Upazila', 54, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(498, 'Chitalmari Upazila', 55, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(499, 'Bagerhat Sadar Upazila', 55, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(500, 'Fakirhat Upazila', 55, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(501, 'Kachua Upazila', 55, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(502, 'Mollahat Upazila', 55, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(503, 'Mongla Upazila', 55, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(504, 'Morrelganj Upazila', 55, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(505, 'Rampal Upazila', 55, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(506, 'Sarankhola Upazila', 55, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(507, 'Chuadanga-S Upazila', 56, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(508, 'Jibannagar Upazila', 56, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL);
INSERT INTO `locations` (`id`, `name`, `parent_id`, `grand_parent_id`, `grand_grand_parent_id`, `type`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(509, 'Alamdanga Upazila', 56, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(510, 'Damurhuda Upazila', 56, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(511, 'Manirampur Upazila', 57, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(512, 'Sharsha Upazila', 57, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(513, 'Jhikargachha Upazila', 57, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(514, 'Chaugachha Upazila', 57, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(515, 'Abhaynagar Upazila', 57, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(516, 'Jessore Sadar Upazila', 57, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(517, 'Bagherpara Upazila', 57, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(518, 'Keshabpur Upazila', 57, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(519, 'Harinakunda Upazila', 58, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(520, 'Shailkupa Upazila', 58, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(521, 'Kotchandpur Upazila', 58, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(522, 'Kaliganj Upazila', 58, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(523, 'Maheshpur Upazila', 58, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(524, 'Jhenaidah Sadar Upazila', 58, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(525, 'Batiaghata Upazila', 59, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(526, 'Dacope Upazila', 59, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(527, 'Dumuria Upazila', 59, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(528, 'Dighalia Upazila', 59, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(529, 'Koyra Upazila', 59, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(530, 'Paikgachha Upazila', 59, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(531, 'Rupsa Upazila', 59, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(532, 'Phultala Upazila', 59, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(533, 'Terokhada Upazila', 59, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(534, 'Mirpur', 60, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(535, 'Daulatpur', 60, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(536, 'Bheramara', 60, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(537, 'Khoksa', 60, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(538, 'Kumarkhali', 60, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(539, 'Kushtia Sadar', 60, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(540, 'Sreepur Upazila', 61, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(541, 'Magura Sadar Upazila', 61, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(542, 'Mohammadpur Upazila', 61, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(543, 'Shalikha Upazila', 61, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(544, 'Meherpur-S Upazila', 62, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(545, 'angni Upazila', 62, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(546, 'Mujib Nagar Upazila', 62, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(547, 'Kalia Upazilla', 63, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(548, 'Narail-S Upazilla', 63, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(549, 'Lohagara Upazilla', 63, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(550, 'Shyamnagar Upazila', 64, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(551, 'Kaliganj Upazila', 64, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(552, 'Kalaroa Upazila', 64, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(553, 'Tala Upazila', 64, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(554, 'Debhata Upazila', 64, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(555, 'Satkhira Sadar Upazila', 64, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(556, 'Assasuni Upazila', 64, NULL, NULL, '2', '1', 'Super Admin', NULL, '2021-01-27 21:58:52', NULL),
(560, 'Yakubpur', 425, 46, NULL, '3', '1', 'Super Admin', NULL, '2021-01-29 16:51:02', '2021-01-29 16:51:02'),
(561, 'Jailashkara', 425, 46, NULL, '3', '1', 'Super Admin', NULL, '2021-01-29 16:51:35', '2021-01-29 16:51:35'),
(562, 'Daganbhuiyan', 425, 46, NULL, '3', '1', 'Super Admin', NULL, '2021-01-29 16:51:58', '2021-01-29 16:51:58'),
(564, 'Mathu Bhuiyan', 425, 46, NULL, '3', '1', 'Super Admin', NULL, '2021-01-29 16:52:54', '2021-01-29 16:52:54'),
(565, 'Rajapur', 425, 46, NULL, '3', '1', 'Super Admin', NULL, '2021-01-29 16:53:19', '2021-01-29 16:53:19'),
(566, 'Sindurpur', 425, 46, NULL, '3', '1', 'Super Admin', NULL, '2021-01-29 16:53:39', '2021-01-29 16:53:39'),
(567, 'Amjadhat', 421, 46, NULL, '3', '1', 'Super Admin', NULL, '2021-01-29 17:04:37', '2021-01-29 17:04:37'),
(568, 'Anandapur', 421, 46, NULL, '3', '1', 'Super Admin', NULL, '2021-01-29 17:04:54', '2021-01-29 17:04:54'),
(569, 'Darbarpur', 421, 46, NULL, '3', '1', 'Super Admin', NULL, '2021-01-29 17:05:09', '2021-01-29 17:05:09'),
(570, 'Fulgazi', 421, 46, NULL, '3', '1', 'Super Admin', NULL, '2021-01-29 17:05:23', '2021-01-29 17:05:23'),
(571, 'G.M. Hat', 421, 46, NULL, '3', '1', 'Super Admin', NULL, '2021-01-29 17:05:37', '2021-01-29 17:05:37'),
(572, 'Munshirhat', 421, 46, NULL, '3', '1', 'Super Admin', NULL, '2021-01-29 17:05:54', '2021-02-01 22:11:59'),
(573, 'Shimuliya', 70, 1, NULL, '3', '1', 'Mr. XYZ', NULL, '2021-02-09 17:13:50', '2021-02-09 17:13:50'),
(574, 'Dhamshona', 70, 1, NULL, '3', '1', 'Mr. XYZ', NULL, '2021-02-09 17:14:07', '2021-02-09 17:14:07'),
(575, 'Pataliya', 70, 1, NULL, '3', '1', 'Mr. XYZ', NULL, '2021-02-09 17:14:22', '2021-02-09 17:14:22'),
(576, 'Biruliya', 70, 1, NULL, '3', '1', 'Mr. XYZ', NULL, '2021-02-09 17:14:36', '2021-02-09 17:14:36'),
(577, 'Savar', 70, 1, NULL, '3', '1', 'Mr. XYZ', NULL, '2021-02-09 17:14:50', '2021-02-09 17:14:50'),
(578, 'Tetulzhora', 70, 1, NULL, '3', '1', 'Mr. XYZ', NULL, '2021-02-09 17:15:09', '2021-02-09 17:15:09'),
(581, 'Darbesher Hat', 566, 425, 46, '4', '1', 'Super Admin', NULL, '2021-07-13 22:26:51', '2021-07-13 22:26:51'),
(582, 'Olatoli Bazar', 566, 425, 46, '4', '1', 'Super Admin', NULL, '2021-07-13 22:27:29', '2021-07-13 22:27:29');

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `material_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `material_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `unit_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_unit_id` bigint(20) UNSIGNED NOT NULL,
  `cost` double DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `alert_qty` double DEFAULT NULL,
  `tax_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_method` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Exclusive,2=Inclusive',
  `type` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Raw,2=Packaging',
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `has_opening_stock` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=Yes, 2=No',
  `opening_stock_qty` double DEFAULT NULL,
  `opening_cost` double DEFAULT NULL,
  `opening_warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`id`, `material_name`, `material_code`, `category_id`, `unit_id`, `purchase_unit_id`, `cost`, `qty`, `alert_qty`, `tax_id`, `tax_method`, `type`, `status`, `has_opening_stock`, `opening_stock_qty`, `opening_cost`, `opening_warehouse_id`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Pump Oil', '2101', 1, 9, 9, 28000, 40, 10, NULL, '2', '1', '1', '1', 40, 28000, 1, 'Super Admin', 'Super Admin', '2021-07-31 09:35:04', '2021-09-06 18:33:45'),
(2, 'Soubean Oil', '2102', 1, 9, 9, 32500, 25, 10, NULL, '2', '1', '1', '1', 25, 32500, 1, 'Super Admin', NULL, '2021-07-31 09:38:59', '2021-07-31 09:38:59'),
(3, 'Turmeric Seed', '4102', 5, 2, 2, 390, 1661, 500, NULL, '2', '1', '1', '1', 2200, 180, 1, 'Super Admin', NULL, '2021-07-31 09:42:39', '2021-08-29 03:50:06'),
(4, 'Kohinoor Turmeric Powder 50 Gm', '7101', 8, 2, 2, 643.33333333333, 419, 20, NULL, '1', '2', '1', '1', 420, 410, 1, 'Super Admin', 'Super Admin', '2021-07-31 10:04:07', '2021-08-28 13:12:49'),
(5, 'Kohinoor Turmeric Powder 100 Gm', '7102', 8, 2, 2, 420, 277, 20, NULL, '2', '2', '1', '1', 380, 420, 1, 'Super Admin', NULL, '2021-07-31 10:08:29', '2021-08-29 03:50:06'),
(6, 'Kohinoor Turmeric Powder 200 Gm', '7103', 8, 2, 2, 430, 325, 20, NULL, '2', '2', '1', '1', 325, 430, 1, 'Super Admin', NULL, '2021-07-31 10:09:29', '2021-07-31 10:09:29'),
(7, 'Kohinoor Turmeric Powder 500 Gm', '7104', 8, 2, 2, 450, 280, 20, NULL, '2', '2', '1', '1', 280, 450, 1, 'Super Admin', NULL, '2021-07-31 10:11:55', '2021-07-31 10:11:55'),
(8, 'Kohinoor Turmeric Powder 1000 Gm', '7105', 8, 2, 2, 470, 230, 20, NULL, '2', '2', '1', '1', 230, 470, 1, 'Super Admin', NULL, '2021-07-31 10:12:57', '2021-07-31 10:12:57'),
(9, 'Small 8\" - 14\" PP', '7136', 8, 2, 2, 160, 137, 20, NULL, '2', '2', '1', '1', 140, 160, 1, 'Super Admin', NULL, '2021-07-31 10:18:03', '2021-08-11 17:45:01'),
(10, 'Medium 14\" - 18\" PP', '7137', 8, 2, 2, 175, 100, 20, NULL, '2', '2', '1', '1', 128, 175, 1, 'Super Admin', NULL, '2021-07-31 10:18:58', '2021-08-29 03:50:06'),
(11, 'Medium 14\" - 22\" PP', '7138', 8, 2, 2, 180, 132, 20, NULL, '2', '2', '1', '1', 132, 180, 1, 'Super Admin', NULL, '2021-07-31 10:21:13', '2021-07-31 10:21:13'),
(12, 'Large 22\" - 28\" PP', '7139', 8, 2, 2, 210, 229, 20, NULL, '2', '2', '1', '1', 229, 210, 1, 'Super Admin', NULL, '2021-07-31 10:22:22', '2021-07-31 10:22:22'),
(13, 'Corrugated Box', '6111', 7, 1, 1, 21, 1200, 100, NULL, '2', '2', '1', '1', 1240, 21, 1, 'Super Admin', NULL, '2021-07-31 10:23:37', '2021-08-29 03:50:06');

-- --------------------------------------------------------

--
-- Table structure for table `material_purchase`
--

CREATE TABLE `material_purchase` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_id` bigint(20) UNSIGNED NOT NULL,
  `material_id` bigint(20) UNSIGNED NOT NULL,
  `qty` double NOT NULL,
  `received` double NOT NULL,
  `purchase_unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `net_unit_cost` double NOT NULL,
  `old_cost` double DEFAULT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `labor_cost` double DEFAULT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `material_purchase`
--

INSERT INTO `material_purchase` (`id`, `purchase_id`, `material_id`, `qty`, `received`, `purchase_unit_id`, `net_unit_cost`, `old_cost`, `discount`, `tax_rate`, `tax`, `labor_cost`, `total`, `created_at`, `updated_at`) VALUES
(1, 2, 4, 3000, 3000, 3, 0.41, 410, 0, 0, 0, 100, 1330, '2021-08-25 10:52:46', '2021-08-27 06:49:45'),
(2, 2, 3, 10, 10, 2, 180, 180, 0, 0, 0, 100, 1900, '2021-08-25 10:52:46', '2021-08-27 06:49:45');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `menu_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletable` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=No, 2=Yes',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `menu_name`, `deletable`, `created_at`, `updated_at`) VALUES
(1, 'Admin Sidebar Menu', '1', '2021-03-26 17:49:24', '2021-07-16 19:07:49'),
(2, 'ASM Sidebar Menu', '1', '2021-07-16 19:07:13', '2021-07-16 19:07:35');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_resets_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2020_11_09_121424_create_roles_table', 1),
(4, '2020_11_09_121426_create_users_table', 1),
(5, '2020_11_09_121433_create_menus_table', 1),
(6, '2020_11_09_121444_create_modules_table', 1),
(7, '2020_11_09_121457_create_permissions_table', 1),
(8, '2020_11_09_121707_class_module_role_table', 1),
(9, '2020_11_09_121724_class_permission_role_table', 1),
(10, '2020_11_09_121842_create_settings_table', 1),
(11, '2020_11_11_114846_create_sessions_table', 1),
(12, '2020_11_11_115012_create_cache_table', 1),
(13, '2020_11_14_070601_create_categories_table', 1),
(14, '2020_11_15_082501_create_units_table', 1),
(15, '2020_11_16_112644_create_taxes_table', 1),
(16, '2020_11_16_112645_create_locations_table', 1),
(17, '2020_11_16_112652_create_asms_table', 1),
(18, '2020_11_17_101058_create_warehouses_table', 1),
(19, '2020_11_17_101065_create_customer_groups_table', 1),
(20, '2021_11_17_102900_create_suppliers_table', 1),
(21, '2020_11_18_121707_class_asm_module_table', 2),
(22, '2020_11_18_121724_class_asm_permission_table', 2),
(25, '2020_12_27_043903_create_salesmen_table', 3),
(26, '2021_01_28_090833_create_sales_men_daily_routes_table', 3),
(29, '2021_03_28_032515_create_materials_table', 4),
(30, '2021_03_28_033220_create_warehouse_material_table', 4),
(40, '2020_11_19_081237_create_products_table', 5),
(41, '2020_11_19_081255_create_product_material_table', 5),
(42, '2020_11_19_081265_create_warehouse_product_table', 6),
(49, '2021_08_03_153419_create_productions_table', 7),
(50, '2021_08_03_153516_create_production_products_table', 7),
(53, '2021_08_03_153525_create_production_product_materials_table', 8),
(54, '2021_03_26_063920_create_customers_table', 9),
(55, '2021_03_27_111921_create_chart_of_accounts_table', 10),
(56, '2021_03_27_111946_create_transactions_table', 10),
(58, '2020_11_18_131359_create_purchases_table', 11),
(59, '2020_11_19_054144_create_material_purchase_table', 11),
(60, '2021_02_06_081548_create_purchase_payments_table', 11),
(61, '2020_11_19_081427_create_adjustments_table', 12),
(62, '2020_11_19_081454_create_adjustment_products_table', 12),
(63, '2021_08_03_153541_create_production_coupons_table', 13),
(64, '2021_08_12_011143_create_transfers_table', 14),
(65, '2021_08_12_011156_create_transfer_products_table', 14),
(66, '2021_02_03_094656_create_received_coupons_table', 15),
(67, '2021_03_30_115339_create_sales_table', 16),
(68, '2021_03_30_115349_create_sale_products_table', 16),
(69, '2021_04_01_033716_create_expense_items_table', 17),
(70, '2021_04_01_033719_create_expenses_table', 17),
(73, '2021_03_28_045127_create_banks_table', 18),
(74, '2021_03_28_045148_create_mobile_banks_table', 19),
(75, '2021_06_19_141703_create_purchase_returns_table', 20),
(76, '2021_06_19_141731_create_purchase_return_materials_table', 20),
(77, '2021_06_19_141741_create_sale_returns_table', 20),
(78, '2021_06_19_141758_create_sale_return_products_table', 20),
(79, '2021_03_27_112248_create_daily_closings_table', 21);

-- --------------------------------------------------------

--
-- Table structure for table `mobile_banks`
--

CREATE TABLE `mobile_banks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mobile_banks`
--

INSERT INTO `mobile_banks` (`id`, `bank_name`, `account_name`, `account_number`, `warehouse_id`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Bkash Feni Branch', 'Kohinoor Bkash', '01521225698', 2, '1', 'Super Admin', 'Super Admin', '2021-08-27 13:53:20', '2021-08-27 13:57:15'),
(2, 'Bkash Jamalpur Branch', 'Kohinoor Bkash', '01521225684', 1, '1', 'Super Admin', NULL, '2021-09-07 10:18:22', '2021-09-07 10:18:22');

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE `modules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=divider,2=module',
  `module_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `divider_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `target` enum('_self','_blank') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`id`, `menu_id`, `type`, `module_name`, `divider_title`, `icon_class`, `url`, `order`, `parent_id`, `target`, `created_at`, `updated_at`) VALUES
(1, 1, '2', 'Dashboard', NULL, 'fas fa-tachometer-alt', '/', 1, NULL, NULL, NULL, '2021-09-06 04:54:01'),
(2, 1, '1', NULL, 'Menus', NULL, NULL, 2, NULL, NULL, NULL, '2021-09-06 04:54:01'),
(3, 1, '1', NULL, 'Access Control', NULL, NULL, 18, NULL, NULL, NULL, '2021-09-06 04:54:02'),
(4, 1, '2', 'User', NULL, 'fas fa-users', 'user', 19, NULL, NULL, NULL, '2021-09-06 04:54:02'),
(5, 1, '2', 'Role', NULL, 'fas fa-user-tag', 'role', 20, NULL, NULL, NULL, '2021-09-06 04:54:02'),
(6, 1, '1', NULL, 'System', NULL, NULL, 23, NULL, NULL, NULL, '2021-09-06 04:54:02'),
(7, 1, '2', 'Setting', NULL, 'fas fa-cogs', NULL, 24, NULL, NULL, NULL, '2021-09-06 04:54:02'),
(8, 1, '2', 'Menu', NULL, 'fas fa-th-list', 'menu', 25, NULL, NULL, NULL, '2021-09-06 04:54:02'),
(9, 1, '2', 'Permission', NULL, 'fas fa-tasks', 'menu/module/permission', 26, NULL, NULL, NULL, '2021-09-06 04:54:02'),
(10, 1, '2', 'General Setting', NULL, NULL, 'setting', 1, 7, NULL, '2021-03-26 18:01:48', '2021-03-26 18:06:29'),
(11, 1, '2', 'Warehouse', NULL, NULL, 'warehouse', 2, 7, NULL, '2021-03-26 18:07:10', '2021-03-26 18:08:10'),
(12, 1, '2', 'Customer Group', NULL, NULL, 'customer-group', 3, 7, NULL, '2021-03-26 18:07:41', '2021-03-26 18:08:14'),
(13, 1, '2', 'Unit', NULL, NULL, 'unit', 4, 7, NULL, '2021-03-26 18:07:54', '2021-06-05 21:48:54'),
(14, 1, '2', 'Tax', NULL, NULL, 'tax', 5, 7, NULL, '2021-03-26 18:08:03', '2021-07-12 19:59:29'),
(15, 1, '2', 'Material', NULL, 'fas fa-toolbox', NULL, 3, NULL, NULL, '2021-07-13 04:20:56', '2021-09-06 04:54:01'),
(16, 1, '2', 'Category', NULL, NULL, 'material/category', 1, 15, '_self', '2021-07-13 04:21:32', '2021-07-13 04:42:48'),
(17, 1, '2', 'Manage Material', NULL, NULL, 'material', 2, 15, NULL, '2021-07-13 04:22:22', '2021-07-13 04:42:54'),
(18, 1, '2', 'Material Stock Report', NULL, NULL, 'material-stock-report', 3, 15, NULL, '2021-07-13 04:41:53', '2021-07-13 04:42:58'),
(20, 1, '2', 'Purchase', NULL, 'fas fa-cart-arrow-down', NULL, 4, NULL, NULL, '2021-07-13 04:45:27', '2021-09-06 04:54:01'),
(21, 1, '2', 'Add Purchase', NULL, NULL, 'purchase/add', 1, 20, NULL, '2021-07-13 04:46:05', '2021-07-13 04:46:35'),
(22, 1, '2', 'Manage Purchase', NULL, NULL, 'purchase', 2, 20, NULL, '2021-07-13 04:46:31', '2021-07-13 04:46:44'),
(23, 1, '2', 'Product', NULL, 'fas fa-box', NULL, 5, NULL, NULL, '2021-07-13 04:49:30', '2021-09-06 04:54:01'),
(24, 1, '2', 'Category', NULL, NULL, 'product/category', 1, 23, NULL, '2021-07-13 04:50:00', '2021-07-13 04:52:42'),
(25, 1, '2', 'Add Product', NULL, NULL, 'product/add', 2, 23, NULL, '2021-07-13 04:50:23', '2021-08-14 04:30:42'),
(26, 1, '2', 'Manage Product', NULL, NULL, 'product', 3, 23, NULL, '2021-07-13 04:51:10', '2021-08-14 04:30:42'),
(28, 1, '2', 'Print Barcode', NULL, NULL, 'print-barcode', 4, 23, NULL, '2021-07-13 04:53:40', '2021-08-14 04:30:42'),
(29, 1, '2', 'Add Adjustment', NULL, NULL, 'adjustment/add', 5, 23, NULL, '2021-07-13 04:54:21', '2021-08-14 04:30:42'),
(30, 1, '2', 'Manage Adjustment', NULL, NULL, 'adjustment', 6, 23, NULL, '2021-07-13 04:55:23', '2021-08-14 04:30:42'),
(31, 1, '2', 'Product Stock Report', NULL, NULL, 'product-stock-report', 7, 23, NULL, '2021-07-13 04:57:37', '2021-08-14 04:30:42'),
(33, 1, '2', 'Production', NULL, 'fas fa-industry', NULL, 6, NULL, NULL, '2021-07-13 05:47:47', '2021-09-06 04:54:01'),
(34, 1, '2', 'Add Production', NULL, NULL, 'production/add', 1, 33, NULL, '2021-07-13 05:48:09', '2021-07-13 05:49:41'),
(35, 1, '2', 'Manage Production', NULL, NULL, 'production', 2, 33, NULL, '2021-07-13 05:48:34', '2021-07-13 05:49:47'),
(40, 1, '2', 'Manage Stock Transfer', NULL, 'fas fa-share-square', 'transfer', 9, NULL, '_self', '2021-07-13 05:56:21', '2021-09-06 04:54:01'),
(41, 1, '2', 'Customer', NULL, 'far fa-handshake', NULL, 7, NULL, '_self', '2021-07-13 05:58:05', '2021-09-06 04:54:01'),
(42, 1, '2', 'Manage Customer', NULL, NULL, 'customer', 1, 41, NULL, '2021-07-13 05:59:22', '2021-07-13 06:01:37'),
(43, 1, '2', 'Customer Ledger', NULL, NULL, 'customer-ledger', 2, 41, NULL, '2021-07-13 05:59:47', '2021-07-13 06:01:37'),
(44, 1, '2', 'Credit Customer', NULL, NULL, 'credit-customer', 3, 41, NULL, '2021-07-13 06:00:15', '2021-07-13 06:01:40'),
(45, 1, '2', 'Paid Customer', NULL, NULL, 'paid-customer', 4, 41, NULL, '2021-07-13 06:00:44', '2021-07-13 06:01:43'),
(46, 1, '2', 'Customer Advance', NULL, NULL, 'customer-advance', 5, 41, NULL, '2021-07-13 06:01:22', '2021-07-13 06:01:47'),
(47, 1, '2', 'Supplier', NULL, 'fas fa-user-tie', NULL, 8, NULL, NULL, '2021-07-13 06:02:42', '2021-09-06 04:54:01'),
(48, 1, '2', 'Manage Supplier', NULL, NULL, 'supplier', 1, 47, NULL, '2021-07-13 06:03:11', '2021-07-13 06:04:20'),
(49, 1, '2', 'Supplier Ledger', NULL, NULL, 'supplier-ledger', 2, 47, NULL, '2021-07-13 06:03:44', '2021-07-13 06:04:37'),
(50, 1, '2', 'Supplier Advance', NULL, NULL, 'supplier-advance', 3, 47, NULL, '2021-07-13 06:04:13', '2021-07-13 06:04:37'),
(51, 1, '2', 'Stock Return', NULL, 'fas fa-undo-alt', NULL, 10, NULL, NULL, '2021-07-13 06:14:46', '2021-09-06 04:54:01'),
(52, 1, '2', 'Purchase Return', NULL, NULL, 'purchase-return', 1, 51, '_self', '2021-07-13 06:15:33', '2021-08-28 08:34:24'),
(53, 1, '2', 'Purchase Return List', NULL, NULL, 'purchase-return-list', 2, 51, NULL, '2021-07-13 06:16:14', '2021-07-13 06:17:01'),
(54, 1, '2', 'Sale Return List', NULL, NULL, 'sale-return-list', 3, 51, NULL, '2021-07-13 06:16:37', '2021-07-13 06:17:07'),
(55, 1, '2', 'Manage ASM', NULL, 'fas fa-user-shield', 'assistant-sales-manager', 21, NULL, '_self', '2021-07-13 06:22:38', '2021-09-06 04:54:02'),
(56, 1, '2', 'Manage SR', NULL, 'fas fa-user-secret', 'sales-representative', 22, NULL, '_self', '2021-07-13 06:25:04', '2021-09-06 04:54:02'),
(57, 1, '2', 'Location', NULL, 'fas fa-map-marker-alt', NULL, 17, NULL, NULL, '2021-07-13 06:56:46', '2021-09-06 04:54:02'),
(58, 1, '2', 'Manage District', NULL, NULL, 'district', 1, 57, '_self', '2021-07-13 06:57:29', '2021-07-13 06:58:53'),
(59, 1, '2', 'Manage Upazila', NULL, NULL, 'upazila', 2, 57, NULL, '2021-07-13 06:57:58', '2021-07-13 06:58:57'),
(60, 1, '2', 'Manage Route', NULL, NULL, 'route', 3, 57, NULL, '2021-07-13 06:58:27', '2021-07-13 06:59:00'),
(61, 1, '2', 'Manage Area', NULL, NULL, 'area', 4, 57, NULL, '2021-07-13 06:58:48', '2021-07-13 06:59:04'),
(62, 1, '2', 'Bank', NULL, 'fas fa-university', NULL, 14, NULL, NULL, '2021-07-13 08:16:58', '2021-09-06 04:54:02'),
(63, 1, '2', 'Manage Bank', NULL, NULL, 'bank', 1, 62, NULL, '2021-07-13 08:17:23', '2021-07-13 08:18:19'),
(64, 1, '2', 'Bank Transaction', NULL, NULL, 'bank-transaction', 2, 62, NULL, '2021-07-13 08:17:50', '2021-07-13 08:18:23'),
(65, 1, '2', 'Bank Ledger', NULL, NULL, 'bank-ledger', 3, 62, NULL, '2021-07-13 08:18:15', '2021-07-13 08:18:27'),
(66, 1, '2', 'Mobile Bank', NULL, 'fas fa-mobile-alt', NULL, 15, NULL, NULL, '2021-07-13 08:19:07', '2021-09-06 04:54:02'),
(67, 1, '2', 'Manage Mobile Bank', NULL, NULL, 'mobile-bank', 1, 66, NULL, '2021-07-13 08:19:31', '2021-07-13 08:20:41'),
(68, 1, '2', 'Mobile Bank Transaction', NULL, NULL, 'mobile-bank-transaction', 2, 66, NULL, '2021-07-13 08:20:10', '2021-09-06 04:19:26'),
(69, 1, '2', 'Mobile Bank Ledger', NULL, NULL, 'mobile-bank-ledger', 3, 66, NULL, '2021-07-13 08:20:37', '2021-09-06 04:19:54'),
(70, 1, '2', 'Expense', NULL, 'fas fa-money-check-alt', NULL, 13, NULL, NULL, '2021-07-13 09:00:55', '2021-09-06 04:54:02'),
(71, 1, '2', 'Manage Expense Item', NULL, NULL, 'expense-item', 1, 70, NULL, '2021-07-13 09:01:28', '2021-07-13 09:02:23'),
(72, 1, '2', 'Manage Expense', NULL, NULL, 'expense', 2, 70, NULL, '2021-07-13 09:01:50', '2021-07-13 09:02:31'),
(73, 1, '2', 'Expense Statement', NULL, NULL, 'expense-statement', 3, 70, NULL, '2021-07-13 09:02:19', '2021-07-13 09:02:36'),
(74, 1, '2', 'Accounts', NULL, 'far fa-money-bill-alt', NULL, 11, NULL, NULL, '2021-03-26 18:52:27', '2021-09-06 04:54:01'),
(75, 1, '2', 'Chart of Account', NULL, NULL, 'coa', 1, 74, NULL, '2021-03-26 18:52:53', '2021-05-11 06:10:34'),
(76, 1, '2', 'Opening Balance', NULL, NULL, 'opening-balance', 2, 74, NULL, '2021-03-26 18:53:20', '2021-05-11 06:10:34'),
(77, 1, '2', 'Supplier Payment', NULL, NULL, 'supplier-payment', 3, 74, NULL, '2021-03-26 18:53:43', '2021-05-11 06:10:34'),
(78, 1, '2', 'Customer Receive', NULL, NULL, 'customer-receive', 4, 74, NULL, '2021-03-26 18:54:01', '2021-05-11 06:10:34'),
(79, 1, '2', 'Cash Adjustment', NULL, NULL, 'cash-adjustment', 5, 74, NULL, '2021-03-26 18:54:30', '2021-05-11 06:10:34'),
(80, 1, '2', 'Debit Voucher', NULL, NULL, 'debit-voucher', 6, 74, NULL, '2021-03-26 18:54:52', '2021-05-11 06:10:34'),
(81, 1, '2', 'Credit Voucher', NULL, NULL, 'credit-voucher', 8, 74, NULL, '2021-03-26 18:55:10', '2021-09-07 09:55:45'),
(82, 1, '2', 'Contra Voucher', NULL, NULL, 'contra-voucher', 10, 74, NULL, '2021-03-26 18:55:31', '2021-09-07 09:56:40'),
(83, 1, '2', 'Contra Voucher List', NULL, NULL, 'contra-voucher/list', 11, 74, NULL, '2021-07-03 05:53:42', '2021-09-07 09:56:40'),
(84, 1, '2', 'Journal Voucher', NULL, NULL, 'journal-voucher', 12, 74, NULL, '2021-03-26 18:55:50', '2021-09-07 09:56:40'),
(85, 1, '2', 'Journal Voucher List', NULL, NULL, 'journal-voucher/list', 13, 74, NULL, '2021-07-03 05:54:24', '2021-09-07 09:56:40'),
(86, 1, '2', 'Voucher Approval', NULL, NULL, 'voucher-approval', 14, 74, NULL, '2021-03-26 18:56:21', '2021-09-07 09:56:40'),
(87, 1, '2', 'Report', NULL, 'fas fa-file-signature', NULL, 15, 74, NULL, '2021-03-26 18:58:02', '2021-09-07 09:56:40'),
(88, 1, '2', 'Cash Book', NULL, NULL, 'cash-book', 1, 87, NULL, '2021-03-26 18:58:53', '2021-03-26 19:01:24'),
(89, 1, '2', 'Inventory Ledger', NULL, NULL, 'inventory-ledger', 2, 87, NULL, '2021-03-26 18:59:21', '2021-03-26 19:01:25'),
(90, 1, '2', 'Bank Book', NULL, NULL, 'bank-book', 3, 87, NULL, '2021-03-26 18:59:42', '2021-03-26 19:01:30'),
(91, 1, '2', 'Mobile Bank Book', NULL, NULL, 'mobile-bank-book', 4, 87, NULL, '2021-03-26 19:00:00', '2021-03-26 19:01:41'),
(92, 1, '2', 'General Ledger', NULL, NULL, 'general-ledger', 5, 87, NULL, '2021-03-26 19:00:23', '2021-03-26 19:01:42'),
(93, 1, '2', 'Trial Balance', NULL, NULL, 'trial-balance', 6, 87, NULL, '2021-03-26 19:00:42', '2021-03-26 19:01:46'),
(94, 1, '2', 'Profit Loss', NULL, NULL, 'profit-loss', 7, 87, NULL, '2021-03-26 19:01:03', '2021-03-26 19:01:47'),
(95, 1, '2', 'Cash Flow', NULL, NULL, 'cash-flow', 8, 87, NULL, '2021-03-26 19:01:21', '2021-03-26 19:01:51'),
(96, 1, '2', 'Human Resource', NULL, 'fas fa-users', NULL, 12, NULL, NULL, '2021-04-03 10:54:02', '2021-09-06 04:54:01'),
(97, 1, '2', 'HRM', NULL, NULL, NULL, 1, 96, NULL, '2021-04-03 10:54:49', '2021-04-25 23:02:56'),
(98, 1, '2', 'Manage Department', NULL, NULL, 'department', 1, 97, NULL, '2021-04-03 10:55:36', '2021-04-25 22:59:58'),
(99, 1, '2', 'Manage Division', NULL, NULL, 'division', 2, 97, NULL, '2021-04-03 10:55:58', '2021-04-25 23:00:21'),
(100, 1, '2', 'Manage Designation', NULL, NULL, 'designation', 3, 97, NULL, '2021-04-03 10:56:21', '2021-04-25 23:01:09'),
(101, 1, '2', 'Shift', NULL, NULL, 'shift', 4, 97, NULL, '2021-04-26 01:09:53', '2021-04-26 01:20:08'),
(102, 1, '2', 'Add Employee', NULL, NULL, 'employee/add', 5, 97, NULL, '2021-04-03 10:57:01', '2021-04-25 23:02:24'),
(103, 1, '2', 'Manage Employee', NULL, NULL, 'employee', 6, 97, NULL, '2021-04-03 10:59:55', '2021-04-26 17:16:32'),
(104, 1, '2', 'Attendance', NULL, NULL, NULL, 2, 96, NULL, '2021-04-03 11:00:34', '2021-04-25 23:06:51'),
(105, 1, '2', 'Manage Attendance', NULL, NULL, 'attendance', 1, 104, NULL, '2021-04-03 11:01:28', '2021-04-25 23:04:12'),
(106, 1, '2', 'Attendance Report', NULL, NULL, 'attendance-report', 2, 104, NULL, '2021-04-03 11:01:53', '2021-04-25 23:04:16'),
(107, 1, '2', 'Payroll', NULL, NULL, NULL, 4, 96, NULL, '2021-04-03 11:08:19', '2021-04-25 23:09:25'),
(108, 1, '2', 'Manage Benifits', NULL, NULL, 'benifits', 1, 107, NULL, '2021-04-03 11:09:11', '2021-04-25 23:08:33'),
(109, 1, '2', 'Add Salary Setup', NULL, NULL, 'salary.setup/add', 2, 107, NULL, '2021-04-03 11:09:53', '2021-05-08 22:34:40'),
(110, 1, '2', 'Manage Salary Setup', NULL, NULL, 'salary-setup', 3, 107, NULL, '2021-04-03 11:10:19', '2021-04-25 23:08:57'),
(111, 1, '2', 'Manage Salary Generate', NULL, NULL, 'salary-generate', 4, 107, NULL, '2021-04-03 11:14:01', '2021-04-25 23:08:57'),
(112, 1, '2', 'Leave', NULL, NULL, NULL, 3, 96, NULL, '2021-04-03 12:02:43', '2021-04-25 23:06:51'),
(113, 1, '2', 'Weekly Holiday', NULL, NULL, 'weekly-holiday', 1, 112, NULL, '2021-04-03 12:03:11', '2021-04-25 23:05:09'),
(114, 1, '2', 'Holiday', NULL, NULL, 'holiday', 2, 112, NULL, '2021-04-03 12:03:29', '2021-04-26 01:11:00'),
(115, 1, '2', 'Manage Leave Type', NULL, NULL, 'leave-type', 3, 112, NULL, '2021-04-03 12:03:56', '2021-04-26 01:11:00'),
(116, 1, '2', 'Manage Leave Application', NULL, NULL, 'leave-application', 4, 112, NULL, '2021-04-03 12:04:31', '2021-04-26 01:11:00'),
(119, 2, '2', 'Dashboard', NULL, 'fas fa-tachometer-alt', '/', 1, NULL, '_self', '2021-07-16 19:28:05', '2021-08-30 05:16:15'),
(121, 2, '1', NULL, 'Menus', NULL, NULL, 2, NULL, NULL, '2021-07-16 19:30:20', '2021-08-30 05:16:15'),
(122, 2, '2', 'Product', NULL, 'fas fa-box', NULL, 3, NULL, NULL, '2021-07-16 19:31:30', '2021-08-30 05:16:15'),
(123, 2, '2', 'Manage Product', NULL, NULL, 'product', 1, 122, '_self', '2021-07-16 19:31:55', '2021-07-16 19:31:59'),
(124, 2, '2', 'Product Stock Report', NULL, NULL, 'product-stock-report', 2, 122, NULL, '2021-07-16 19:32:45', '2021-07-16 19:32:54'),
(126, 1, '2', 'Finish Goods', NULL, NULL, 'finish-goods', 3, 33, '_self', '2021-08-12 12:56:32', '2021-08-12 12:56:46'),
(127, 1, '2', 'ASM Permission', NULL, 'fas fa-tasks', 'asm-permission', 27, NULL, '_self', '2021-08-14 04:30:16', '2021-09-06 04:54:02'),
(128, 2, '2', 'Customer', NULL, 'far fa-handshake', NULL, 7, NULL, NULL, '2021-08-16 05:30:14', '2021-08-30 05:16:15'),
(129, 2, '2', 'Manage Customer', NULL, NULL, 'customer', 1, 128, '_self', '2021-08-16 05:30:53', '2021-08-16 05:33:41'),
(130, 2, '2', 'Customer Ledger', NULL, NULL, 'customer-ledger', 2, 128, '_self', '2021-08-16 05:31:33', '2021-08-16 05:33:51'),
(131, 2, '2', 'Credit Customer', NULL, NULL, 'credit-customer', 3, 128, '_self', '2021-08-16 05:32:01', '2021-08-16 05:33:54'),
(132, 2, '2', 'Paid Customer', NULL, NULL, 'paid-customer', 4, 128, '_self', '2021-08-16 05:32:29', '2021-08-16 05:34:05'),
(133, 2, '2', 'Customer Advance', NULL, NULL, 'customer-advance', 5, 128, '_self', '2021-08-16 05:32:58', '2021-08-16 05:34:11'),
(134, 2, '2', 'Stock Transfer', NULL, 'fas fa-share-square', 'transfer', 5, NULL, '_self', '2021-08-16 05:36:59', '2021-08-30 05:16:15'),
(135, 2, '2', 'Sale', NULL, 'fab fa-opencart', NULL, 4, NULL, '_self', '2021-08-16 05:39:15', '2021-08-30 05:16:15'),
(136, 2, '2', 'Add Sale', NULL, NULL, 'sale/add', 1, 135, '_self', '2021-08-16 05:39:45', '2021-08-16 05:40:16'),
(137, 2, '2', 'Manage Sale', NULL, NULL, 'sale', 2, 135, '_self', '2021-08-16 05:40:12', '2021-08-16 05:40:25'),
(138, 2, '2', 'Stock Return', NULL, 'fas fa-undo-alt', NULL, 6, NULL, NULL, '2021-08-16 05:41:56', '2021-08-30 05:16:15'),
(139, 2, '2', 'Return', NULL, NULL, 'return', 1, 138, '_self', '2021-08-16 05:42:21', '2021-08-16 05:45:29'),
(140, 2, '2', 'Manage Sale Return', NULL, NULL, 'sale-return', 2, 138, '_self', '2021-08-16 05:43:16', '2021-08-16 05:45:34'),
(141, 2, '2', 'Location', NULL, 'fas fa-map-marker-alt', NULL, 13, NULL, NULL, '2021-08-16 07:50:29', '2021-08-30 05:15:57'),
(142, 2, '2', 'Manage Upazila', NULL, NULL, 'upazila', 1, 141, '_self', '2021-08-16 07:51:01', '2021-08-16 07:51:58'),
(143, 2, '2', 'Manage Route', NULL, NULL, 'route', 2, 141, '_self', '2021-08-16 07:51:28', '2021-08-16 07:52:03'),
(144, 2, '2', 'Manage Area', NULL, NULL, 'area', 3, 141, '_self', '2021-08-16 07:51:51', '2021-08-16 07:56:16'),
(145, 2, '2', 'Manage SR', NULL, 'fas fa-user-secret', 'sales-representative', 12, NULL, '_self', '2021-08-16 07:57:44', '2021-08-30 05:15:57'),
(148, 2, '2', 'Expense', NULL, 'fas fa-money-check-alt', NULL, 8, NULL, NULL, '2021-08-23 13:56:43', '2021-08-30 05:16:15'),
(149, 2, '2', 'Manage Expense Item', NULL, NULL, 'expense-item', 1, 148, '_self', '2021-08-23 13:57:24', '2021-08-23 13:58:28'),
(150, 2, '2', 'Manage Expense', NULL, NULL, 'expense', 2, 148, '_self', '2021-08-23 13:57:55', '2021-08-23 13:58:39'),
(151, 2, '2', 'Expense Statement', NULL, NULL, 'expense-statement', 3, 148, '_self', '2021-08-23 13:58:23', '2021-08-23 13:58:44'),
(152, 2, '2', 'Report', NULL, 'fas fa-file-signature', NULL, 11, NULL, NULL, '2021-08-23 14:00:52', '2021-08-30 05:16:15'),
(153, 2, '2', 'Sales Report', NULL, NULL, 'sales-report', 4, 152, '_self', '2021-08-23 15:41:13', '2021-08-30 05:15:57'),
(154, 2, '2', 'Inventory Report', NULL, NULL, 'inventory-report', 5, 152, '_self', '2021-08-23 15:41:59', '2021-08-30 05:15:57'),
(155, 2, '2', 'Today\'s Customer Receipt', NULL, NULL, 'todays-customer-receipt', 6, 152, '_self', '2021-08-23 16:02:58', '2021-08-30 05:15:57'),
(156, 2, '2', 'Customer Receipt List', NULL, NULL, 'customer-receipt-list', 7, 152, '_self', '2021-08-23 16:03:49', '2021-08-30 05:15:57'),
(157, 2, '2', 'Salesman Wise Sales Report', NULL, NULL, 'salesman-wise-sales-report', 8, 152, '_self', '2021-08-23 16:05:31', '2021-08-30 05:15:57'),
(158, 2, '2', 'Due Report', NULL, NULL, 'due-report', 9, 152, '_self', '2021-08-23 16:06:23', '2021-08-30 05:15:57'),
(159, 2, '2', 'Shipping Cost Report', NULL, NULL, 'shipping-cost-report', 10, 152, '_self', '2021-08-23 16:07:07', '2021-08-30 05:15:57'),
(160, 2, '2', 'Product Wise Sales Report', NULL, NULL, 'product-wise-sales-report', 11, 152, '_self', '2021-08-23 16:08:05', '2021-08-30 05:15:57'),
(161, 2, '2', 'Damage Report', NULL, NULL, 'damage-report', 12, 152, '_self', '2021-08-23 16:08:37', '2021-08-30 05:15:57'),
(162, 2, '2', 'Warehouse Expense Report', NULL, NULL, 'warehouse-expense-report', 13, 152, '_self', '2021-08-23 16:09:14', '2021-08-30 05:15:57'),
(163, 2, '2', 'Collection Report', NULL, NULL, 'collection-report', 14, 152, '_self', '2021-08-23 16:10:01', '2021-08-30 05:15:57'),
(165, 2, '2', 'Warehouse Summary', NULL, NULL, 'warehouse-summary', 15, 152, '_self', '2021-08-23 16:11:38', '2021-09-06 04:04:59'),
(166, 2, '2', 'Coupon Received Report', NULL, NULL, 'coupon-received-report', 16, 152, '_self', '2021-08-23 16:26:24', '2021-09-06 04:04:59'),
(167, 2, '2', 'Bank', NULL, 'fas fa-university', NULL, 9, NULL, NULL, '2021-08-29 03:39:56', '2021-08-30 05:16:15'),
(168, 2, '2', 'Manage Bank', NULL, NULL, 'bank', 1, 167, '_self', '2021-08-29 03:40:34', '2021-08-29 03:41:31'),
(169, 2, '2', 'Bank Transaction', NULL, NULL, 'bank-transaction', 2, 167, '_self', '2021-08-29 03:41:02', '2021-08-29 03:41:43'),
(170, 2, '2', 'Bank Ledger', NULL, NULL, 'bank-ledger', 3, 167, '_self', '2021-08-29 03:41:25', '2021-08-29 03:41:51'),
(171, 2, '2', 'Mobile Bank', NULL, 'fas fa-mobile-alt', NULL, 10, NULL, '_self', '2021-08-29 03:43:48', '2021-08-30 05:16:15'),
(172, 2, '2', 'Manage Mobile Bank', NULL, NULL, 'mobile-bank', 1, 171, '_self', '2021-08-29 03:44:44', '2021-08-29 03:52:37'),
(173, 2, '2', 'Mobile Bank Transaction', NULL, NULL, 'mobile-bank-transaction', 2, 171, '_self', '2021-08-29 03:51:37', '2021-08-29 03:52:43'),
(174, 2, '2', 'Mobile Bank Ledger', NULL, NULL, 'mobile-bank-ledger', 3, 171, '_self', '2021-08-29 03:52:30', '2021-08-29 03:52:49'),
(176, 2, '2', 'Closing', NULL, NULL, 'closing', 1, 152, '_self', '2021-08-30 05:13:12', '2021-08-30 05:15:23'),
(177, 2, '2', 'Closing Report', NULL, NULL, 'closing-report', 2, 152, '_self', '2021-08-30 05:13:37', '2021-08-30 05:15:44'),
(178, 2, '2', 'Today Sales Report', NULL, NULL, 'today-sales-report', 3, 152, '_self', '2021-08-30 05:14:48', '2021-08-30 05:15:57'),
(179, 1, '2', 'Report', NULL, 'fas fa-file-signature', NULL, 16, NULL, NULL, '2021-09-06 04:06:13', '2021-09-06 04:54:02'),
(180, 1, '2', 'Closing', NULL, NULL, 'closing', 1, 179, '_self', '2021-09-06 04:06:36', '2021-09-06 04:15:28'),
(181, 1, '2', 'Closing Report', NULL, NULL, 'closing-report', 2, 179, '_self', '2021-09-06 04:06:57', '2021-09-06 04:15:33'),
(182, 1, '2', 'Today Sales Report', NULL, NULL, 'today-sales-report', 4, 179, '_self', '2021-09-06 04:07:35', '2021-09-07 09:19:11'),
(183, 1, '2', 'Sales Report', NULL, NULL, 'sales-report', 5, 179, '_self', '2021-09-06 04:07:55', '2021-09-07 09:19:11'),
(184, 1, '2', 'Inventory Report', NULL, NULL, 'inventory-report', 6, 179, '_self', '2021-09-06 04:08:24', '2021-09-07 09:19:11'),
(185, 1, '2', 'Today\'s Customer Receipt', NULL, NULL, 'todays-customer-receipt', 7, 179, '_self', '2021-09-06 04:09:08', '2021-09-07 09:19:12'),
(186, 1, '2', 'Customer Receipt List', NULL, NULL, 'customer-receipt-list', 8, 179, '_self', '2021-09-06 04:09:36', '2021-09-07 09:19:12'),
(187, 1, '2', 'Salesman Wise Sales Report', NULL, NULL, 'salesman-wise-sales-report', 9, 179, '_self', '2021-09-06 04:10:07', '2021-09-07 09:19:12'),
(188, 1, '2', 'Due Report', NULL, NULL, 'due-report', 10, 179, '_self', '2021-09-06 04:10:43', '2021-09-07 09:19:12'),
(189, 1, '2', 'Shipping Cost Report', NULL, NULL, 'shipping-cost-report', 11, 179, '_self', '2021-09-06 04:11:09', '2021-09-07 09:19:12'),
(190, 1, '2', 'Product Wise Sales Report', NULL, NULL, 'product-wise-sales-report', 12, 179, '_self', '2021-09-06 04:11:35', '2021-09-07 09:19:12'),
(191, 1, '2', 'Damage Report', NULL, NULL, 'damage-report', 13, 179, '_self', '2021-09-06 04:12:13', '2021-09-07 09:19:12'),
(192, 1, '2', 'Warehouse Expense Report', NULL, NULL, 'warehouse-expense-report', 14, 179, '_self', '2021-09-06 04:12:42', '2021-09-07 09:19:12'),
(193, 1, '2', 'Collection Report', NULL, NULL, 'collection-report', 15, 179, '_self', '2021-09-06 04:13:08', '2021-09-07 09:19:12'),
(194, 1, '2', 'Warehouse Summary', NULL, NULL, 'warehouse-summary', 16, 179, '_self', '2021-09-06 04:13:36', '2021-09-07 09:19:12'),
(195, 1, '2', 'Coupon Received Report', NULL, NULL, 'coupon-received-report', 17, 179, '_self', '2021-09-06 04:14:01', '2021-09-07 09:19:12'),
(196, 1, '2', 'Material Stock Alert Report', NULL, NULL, 'material-stock-alert-report', 22, 179, '_self', '2021-09-06 04:14:40', '2021-09-07 09:19:12'),
(198, 1, '2', 'Material Issue Report', NULL, NULL, 'material-issue-report', 21, 179, '_self', '2021-09-06 04:45:17', '2021-09-07 09:19:12'),
(199, 1, '2', 'Finish Goods Inventory Report', NULL, NULL, 'finish-goods-inventory-report', 19, 179, '_self', '2021-09-06 04:51:29', '2021-09-07 09:19:12'),
(200, 1, '2', 'Transfer Report', NULL, NULL, 'transfer-report', 20, 179, '_self', '2021-09-06 04:52:08', '2021-09-07 09:19:12'),
(201, 1, '2', 'Batch Wise Coupon Report', NULL, NULL, 'batch-wise-coupon-report', 18, 179, '_self', '2021-09-07 08:07:15', '2021-09-07 09:19:12'),
(202, 1, '2', 'Warehouse Closing Report', NULL, NULL, 'warehouse-closing-report', 3, 179, '_self', '2021-09-07 09:18:45', '2021-09-07 09:19:11'),
(203, 1, '2', 'Debit Voucher List', NULL, NULL, 'debit-voucher-list', 7, 74, '_self', '2021-09-07 09:55:31', '2021-09-07 09:55:45'),
(204, 1, '2', 'Credit Voucher List', NULL, NULL, 'credit-voucher-list', 9, 74, '_self', '2021-09-07 09:56:13', '2021-09-07 09:56:40');

-- --------------------------------------------------------

--
-- Table structure for table `module_role`
--

CREATE TABLE `module_role` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `module_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `module_role`
--

INSERT INTO `module_role` (`id`, `module_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(2, 2, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(3, 15, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(4, 16, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(5, 17, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(6, 18, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(7, 23, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(8, 24, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(10, 25, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(11, 26, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(12, 28, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(13, 29, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(14, 30, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(15, 31, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(16, 33, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(17, 34, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(18, 35, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(19, 126, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(20, 47, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(21, 48, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(22, 49, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(23, 50, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(24, 57, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(25, 58, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(26, 59, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(27, 60, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(28, 61, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(29, 3, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(30, 4, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(31, 5, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(32, 55, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(33, 56, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(34, 6, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(35, 7, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(36, 10, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(37, 11, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(38, 12, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(39, 13, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(40, 14, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `module_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `module_id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, 1, 'Dashboard Access', 'dashboard-access', '2021-03-26 17:49:24', NULL),
(2, 4, 'User Access', 'user-access', '2021-03-26 17:49:24', NULL),
(3, 4, 'User Add', 'user-add', '2021-03-26 17:49:24', NULL),
(4, 4, 'User Edit', 'user-edit', '2021-03-26 17:49:24', NULL),
(5, 4, 'User View', 'user-view', '2021-03-26 17:49:24', NULL),
(6, 4, 'User Delete', 'user-delete', '2021-03-26 17:49:24', NULL),
(7, 4, 'User Bulk Delete', 'user-bulk-delete', '2021-03-26 17:49:24', NULL),
(8, 4, 'User Report', 'user-report', '2021-03-26 17:49:24', NULL),
(9, 5, 'Role Access', 'role-access', '2021-03-26 17:49:24', NULL),
(10, 5, 'Role Add', 'role-add', '2021-03-26 17:49:24', NULL),
(11, 5, 'Role Edit', 'role-edit', '2021-03-26 17:49:24', NULL),
(12, 5, 'Role View', 'role-view', '2021-03-26 17:49:24', NULL),
(13, 5, 'Role Delete', 'role-delete', '2021-03-26 17:49:24', NULL),
(14, 5, 'Role Bulk Delete', 'role-bulk-delete', '2021-03-26 17:49:24', NULL),
(15, 5, 'Role Report', 'role-report', '2021-03-26 17:49:24', NULL),
(17, 8, 'Menu Access', 'menu-access', '2021-03-26 17:49:24', NULL),
(18, 8, 'Menu Add', 'menu-add', '2021-03-26 17:49:24', NULL),
(19, 8, 'Menu Edit', 'menu-edit', '2021-03-26 17:49:24', NULL),
(20, 8, 'Menu Delete', 'menu-delete', '2021-03-26 17:49:24', NULL),
(21, 8, 'Menu Bulk Delete', 'menu-bulk-delete', '2021-03-26 17:49:24', NULL),
(22, 8, 'Menu Report', 'menu-report', '2021-03-26 17:49:24', NULL),
(23, 8, 'Menu Builder Access', 'menu-builder-access', '2021-03-26 17:49:24', NULL),
(24, 8, 'Menu Module Add', 'menu-module-add', '2021-03-26 17:49:24', NULL),
(25, 8, 'Menu Module Edit', 'menu-module-edit', '2021-03-26 17:49:24', NULL),
(26, 8, 'Menu Module Delete', 'menu-module-delete', '2021-03-26 17:49:24', NULL),
(27, 9, 'Permission Access', 'permission-access', '2021-03-26 17:49:24', NULL),
(28, 9, 'Permission Add', 'permission-add', '2021-03-26 17:49:24', NULL),
(29, 9, 'Permission Edit', 'permission-edit', '2021-03-26 17:49:24', NULL),
(30, 9, 'Permission Delete', 'permission-delete', '2021-03-26 17:49:24', NULL),
(31, 9, 'Permission Bulk Delete', 'permission-bulk-delete', '2021-03-26 17:49:24', NULL),
(32, 9, 'Permission Report', 'permission-report', '2021-03-26 17:49:24', NULL),
(33, 11, 'Warehouse Access', 'warehouse-access', '2021-03-26 20:06:16', NULL),
(34, 11, 'Warehouse Add', 'warehouse-add', '2021-03-26 20:06:16', NULL),
(35, 11, 'Warehouse Edit', 'warehouse-edit', '2021-03-26 20:06:16', NULL),
(36, 11, 'Warehouse Delete', 'warehouse-delete', '2021-03-26 20:06:16', NULL),
(37, 11, 'Warehouse Bulk Delete', 'warehouse-bulk-delete', '2021-03-26 20:06:16', NULL),
(38, 11, 'Warehouse Report', 'warehouse-report', '2021-03-26 20:06:16', NULL),
(39, 10, 'General Setting Access', 'general-setting-access', '2021-03-26 20:07:15', NULL),
(40, 12, 'Customer Group Access', 'customer-group-access', '2021-03-26 20:08:50', NULL),
(41, 12, 'Customer Group Add', 'customer-group-add', '2021-03-26 20:08:50', NULL),
(42, 12, 'Customer Group Edit', 'customer-group-edit', '2021-03-26 20:08:50', NULL),
(43, 12, 'Customer Group Delete', 'customer-group-delete', '2021-03-26 20:08:50', NULL),
(44, 12, 'Customer Group Bulk Delete', 'customer-group-bulk-delete', '2021-03-26 20:08:50', NULL),
(45, 12, 'Customer Group Report', 'customer-group-report', '2021-03-26 20:08:50', NULL),
(46, 13, 'Unit Access', 'unit-access', '2021-03-26 20:10:02', NULL),
(47, 13, 'Unit Add', 'unit-add', '2021-03-26 20:10:02', NULL),
(48, 13, 'Unit Edit', 'unit-edit', '2021-03-26 20:10:02', NULL),
(49, 13, 'Unit Delete', 'unit-delete', '2021-03-26 20:10:02', NULL),
(50, 13, 'Unit Bulk Delete', 'unit-bulk-delete', '2021-03-26 20:10:02', NULL),
(51, 13, 'Unit Report', 'unit-report', '2021-03-26 20:10:02', NULL),
(52, 14, 'Tax Access', 'tax-access', '2021-03-26 20:10:46', NULL),
(53, 14, 'Tax Add', 'tax-add', '2021-03-26 20:10:46', NULL),
(54, 14, 'Tax Edit', 'tax-edit', '2021-03-26 20:10:46', NULL),
(55, 14, 'Tax Delete', 'tax-delete', '2021-03-26 20:10:46', NULL),
(56, 14, 'Tax Bulk Delete', 'tax-bulk-delete', '2021-03-26 20:10:46', NULL),
(57, 14, 'Tax Report', 'tax-report', '2021-03-26 20:10:46', NULL),
(58, 16, 'Material Category Access', 'material-category-access', '2021-07-13 10:31:39', NULL),
(59, 16, 'Material Category Add', 'material-category-add', '2021-07-13 10:31:39', NULL),
(60, 16, 'Material Category Edit', 'material-category-edit', '2021-07-13 10:31:39', NULL),
(61, 16, 'Material Category Delete', 'material-category-delete', '2021-07-13 10:31:39', NULL),
(62, 16, 'Material Category Bulk Delete', 'material-category-bulk-delete', '2021-07-13 10:31:39', NULL),
(63, 16, 'Material Category Report', 'material-category-report', '2021-07-13 10:31:39', NULL),
(64, 17, 'Material Access', 'material-access', '2021-07-13 10:34:53', NULL),
(65, 17, 'Material Add', 'material-add', '2021-07-13 10:34:53', NULL),
(66, 17, 'Material Edit', 'material-edit', '2021-07-13 10:34:53', NULL),
(67, 17, 'Material View', 'material-view', '2021-07-13 10:34:53', NULL),
(68, 17, 'Material Delete', 'material-delete', '2021-07-13 10:34:53', NULL),
(69, 17, 'Material Bulk Delete', 'material-bulk-delete', '2021-07-13 10:34:53', NULL),
(70, 17, 'Material Report', 'material-report', '2021-07-13 10:34:53', NULL),
(71, 18, 'Material Stock Report Access', 'material-stock-report-access', '2021-07-13 10:35:17', NULL),
(73, 22, 'Purchase Access', 'purchase-access', '2021-07-13 10:37:12', NULL),
(74, 22, 'Purchase Add', 'purchase-add', '2021-07-13 10:37:12', NULL),
(75, 22, 'Purchase Edit', 'purchase-edit', '2021-07-13 10:37:12', NULL),
(76, 22, 'Purchase View', 'purchase-view', '2021-07-13 10:37:12', NULL),
(77, 22, 'Purchase Delete', 'purchase-delete', '2021-07-13 10:37:12', NULL),
(78, 22, 'Purchase Bulk Delete', 'purchase-bulk-delete', '2021-07-13 10:37:12', NULL),
(79, 22, 'Purchase Report', 'purchase-report', '2021-07-13 10:37:12', NULL),
(80, 24, 'Product Category Access', 'product-category-access', '2021-07-13 10:38:23', NULL),
(81, 24, 'Product Category Add', 'product-category-add', '2021-07-13 10:38:23', NULL),
(82, 24, 'Product Category Edit', 'product-category-edit', '2021-07-13 10:38:23', NULL),
(83, 24, 'Product Category Delete', 'product-category-delete', '2021-07-13 10:38:23', NULL),
(84, 24, 'Product Category Bulk Delete', 'product-category-bulk-delete', '2021-07-13 10:38:23', NULL),
(85, 24, 'Product Category Report', 'product-category-report', '2021-07-13 10:38:23', NULL),
(92, 26, 'Product Access', 'product-access', '2021-07-13 10:42:37', NULL),
(93, 26, 'Product Add', 'product-add', '2021-07-13 10:42:37', NULL),
(94, 26, 'Product Edit', 'product-edit', '2021-07-13 10:42:37', NULL),
(95, 26, 'Product View', 'product-view', '2021-07-13 10:42:37', NULL),
(96, 26, 'Product Delete', 'product-delete', '2021-07-13 10:42:37', NULL),
(97, 26, 'Product Bulk Delete', 'product-bulk-delete', '2021-07-13 10:42:37', NULL),
(98, 26, 'Product Report', 'product-report', '2021-07-13 10:42:37', NULL),
(99, 28, 'Print Barcode Access', 'print-barcode-access', '2021-07-13 10:43:04', NULL),
(100, 30, 'Adjustment Access', 'adjustment-access', '2021-07-13 10:46:34', NULL),
(101, 30, 'Adjustment Add', 'adjustment-add', '2021-07-13 10:46:34', NULL),
(102, 30, 'Adjustment Edit', 'adjustment-edit', '2021-07-13 10:46:34', NULL),
(103, 30, 'Adjustment View', 'adjustment-view', '2021-07-13 10:46:34', NULL),
(104, 30, 'Adjustment Delete', 'adjustment-delete', '2021-07-13 10:46:34', NULL),
(105, 30, 'Adjustment Bulk Delete', 'adjustment-bulk-delete', '2021-07-13 10:46:34', NULL),
(106, 30, 'Adjustment Report', 'adjustment-report', '2021-07-13 10:46:34', NULL),
(107, 31, 'Product Stock Report Access', 'product-stock-report-access', '2021-07-13 10:47:01', NULL),
(109, 35, 'Production Access', 'production-access', '2021-07-13 10:59:50', NULL),
(110, 35, 'Production Add', 'production-add', '2021-07-13 10:59:50', NULL),
(111, 35, 'Production Edit', 'production-edit', '2021-07-13 10:59:50', NULL),
(112, 35, 'Production View', 'production-view', '2021-07-13 10:59:50', NULL),
(113, 35, 'Production Delete', 'production-delete', '2021-07-13 10:59:50', NULL),
(114, 35, 'Production Approve', 'production-approve', '2021-07-13 10:59:50', NULL),
(115, 35, 'Production Report', 'production-report', '2021-07-13 10:59:50', NULL),
(124, 42, 'Customer Access', 'customer-access', '2021-07-13 11:06:18', NULL),
(130, 42, 'Customer Report', 'customer-report', '2021-07-13 11:06:18', NULL),
(131, 43, 'Customer Ledger Access', 'customer-ledger-access', '2021-07-13 11:06:41', NULL),
(132, 44, 'Credit Customer Access', 'credit-customer-access', '2021-07-13 11:06:56', NULL),
(133, 45, 'Paid Customer Access', 'paid-customer-access', '2021-07-13 11:07:12', NULL),
(134, 46, 'Customer Advance Access', 'customer-advance-access', '2021-07-13 11:08:16', NULL),
(139, 46, 'Customer Advance Report', 'customer-advance-report', '2021-07-13 11:08:16', NULL),
(140, 48, 'Supplier Access', 'supplier-access', '2021-07-13 11:09:21', NULL),
(141, 48, 'Supplier Add', 'supplier-add', '2021-07-13 11:09:21', NULL),
(142, 48, 'Supplier Edit', 'supplier-edit', '2021-07-13 11:09:21', NULL),
(143, 48, 'Supplier View', 'supplier-view', '2021-07-13 11:09:21', NULL),
(144, 48, 'Supplier Delete', 'supplier-delete', '2021-07-13 11:09:21', NULL),
(145, 48, 'Supplier Bulk Delete', 'supplier-bulk-delete', '2021-07-13 11:09:21', NULL),
(146, 48, 'Supplier Report', 'supplier-report', '2021-07-13 11:09:21', NULL),
(147, 49, 'Supplier Ledger Access', 'supplier-ledger-access', '2021-07-13 11:09:45', NULL),
(148, 50, 'Supplier Advance Access', 'supplier-advance-access', '2021-07-13 11:10:00', NULL),
(152, 52, 'Purchase Return Access', 'purchase-return-access', '2021-07-13 11:18:24', '2021-08-28 08:35:16'),
(153, 53, 'Purchase Return Access', 'purchase-return-access', '2021-07-13 11:19:27', NULL),
(154, 53, 'Purchase Return Add', 'purchase-return-add', '2021-07-13 11:19:27', NULL),
(155, 53, 'Purchase Return View', 'purchase-return-view', '2021-07-13 11:19:27', NULL),
(156, 53, 'Purchase Return Delete', 'purchase-return-delete', '2021-07-13 11:19:27', NULL),
(157, 54, 'Sale Return Access', 'sale-return-access', '2021-07-13 11:20:02', NULL),
(158, 54, 'Sale Return Add', 'sale-return-add', '2021-07-13 11:20:02', NULL),
(159, 54, 'Sale Return View', 'sale-return-view', '2021-07-13 11:20:02', NULL),
(160, 75, 'Chart of Account Access', 'chart-of-account-access', '2021-07-13 16:12:36', NULL),
(161, 75, 'Chart of Account Add', 'chart-of-account-add', '2021-07-13 16:12:36', NULL),
(162, 75, 'Chart of Account Edit', 'chart-of-account-edit', '2021-07-13 16:12:36', NULL),
(163, 75, 'Chart of Account Delete', 'chart-of-account-delete', '2021-07-13 16:12:36', NULL),
(164, 76, 'Opening Balance Access', 'opening-balance-access', '2021-07-13 16:13:13', NULL),
(165, 77, 'Supplier Payment Access', 'supplier-payment-access', '2021-07-13 16:13:38', NULL),
(166, 78, 'Customer Receive Access', 'customer-receive-access', '2021-07-13 16:14:05', NULL),
(167, 79, 'Cash Adjustment Access', 'cash-adjustment-access', '2021-07-13 16:14:34', NULL),
(168, 80, 'Debit Voucher Access', 'debit-voucher-access', '2021-07-13 16:15:11', NULL),
(169, 81, 'Credit Voucher Access', 'credit-voucher-access', '2021-07-13 16:15:31', NULL),
(170, 83, 'Contra Voucher Access', 'contra-voucher-access', '2021-07-13 16:20:59', NULL),
(171, 83, 'Contra Voucher Add', 'contra-voucher-add', '2021-07-13 16:20:59', NULL),
(172, 83, 'Contra Voucher View', 'contra-voucher-view', '2021-07-13 16:20:59', NULL),
(173, 83, 'Contra Voucher Delete', 'contra-voucher-delete', '2021-07-13 16:20:59', NULL),
(174, 85, 'Jounal Voucher Access', 'jounal-voucher-access', '2021-07-13 16:21:48', NULL),
(175, 85, 'Jounal Voucher Add', 'jounal-voucher-add', '2021-07-13 16:21:48', NULL),
(176, 85, 'Jounal Voucher View', 'jounal-voucher-view', '2021-07-13 16:21:48', NULL),
(177, 85, 'Jounal Voucher Delete', 'jounal-voucher-delete', '2021-07-13 16:21:48', NULL),
(178, 86, 'Voucher Access', 'voucher-access', '2021-07-13 16:24:05', NULL),
(179, 86, 'Voucher Approve', 'voucher-approve', '2021-07-13 16:24:05', NULL),
(180, 86, 'Voucher Edit', 'voucher-edit', '2021-07-13 16:24:05', NULL),
(181, 86, 'Voucher Delete', 'voucher-delete', '2021-07-13 16:24:05', NULL),
(182, 88, 'Cash Book Access', 'cash-book-access', '2021-07-13 16:31:28', NULL),
(183, 89, 'Inventory Ledger Access', 'inventory-ledger-access', '2021-07-13 16:31:52', NULL),
(184, 90, 'Bank Book Access', 'bank-book-access', '2021-07-13 16:32:26', NULL),
(185, 91, 'Mobile Bank Book Access', 'mobile-bank-book-access', '2021-07-13 16:32:46', NULL),
(186, 92, 'General Ledger Access', 'general-ledger-access', '2021-07-13 17:00:34', NULL),
(187, 93, 'Trial Balance Access', 'trial-balance-access', '2021-07-13 17:00:59', NULL),
(188, 94, 'Profit Loss Access', 'profit-loss-access', '2021-07-13 17:01:20', NULL),
(189, 95, 'Cash Flow Access', 'cash-flow-access', '2021-07-13 17:01:40', NULL),
(190, 71, 'Expense Item Access', 'expense-item-access', '2021-07-13 17:03:02', NULL),
(191, 71, 'Expense Item Add', 'expense-item-add', '2021-07-13 17:03:02', NULL),
(192, 71, 'Expense Item Edit', 'expense-item-edit', '2021-07-13 17:03:02', NULL),
(193, 71, 'Expense Item Delete', 'expense-item-delete', '2021-07-13 17:03:02', NULL),
(194, 71, 'Expense Item Bulk Delete', 'expense-item-bulk-delete', '2021-07-13 17:03:02', NULL),
(195, 71, 'Expense Item Report', 'expense-item-report', '2021-07-13 17:03:02', NULL),
(196, 72, 'Expense Access', 'expense-access', '2021-07-13 17:04:23', NULL),
(197, 72, 'Expense Add', 'expense-add', '2021-07-13 17:04:23', NULL),
(198, 72, 'Expense Edit', 'expense-edit', '2021-07-13 17:04:23', NULL),
(199, 72, 'Expense Delete', 'expense-delete', '2021-07-13 17:04:23', NULL),
(200, 72, 'Expense Bulk Delete', 'expense-bulk-delete', '2021-07-13 17:04:23', NULL),
(201, 72, 'Expense Report', 'expense-report', '2021-07-13 17:04:23', NULL),
(202, 72, 'Expense Approve', 'expense-approve', '2021-07-13 17:04:23', NULL),
(203, 73, 'Expense Statement Access', 'expense-statement-access', '2021-07-13 17:04:44', NULL),
(204, 63, 'Bank Access', 'bank-access', '2021-07-13 17:06:06', NULL),
(205, 63, 'Bank Add', 'bank-add', '2021-07-13 17:06:06', NULL),
(206, 63, 'Bank Edit', 'bank-edit', '2021-07-13 17:06:06', NULL),
(207, 63, 'Bank Delete', 'bank-delete', '2021-07-13 17:06:06', NULL),
(208, 63, 'Bank Report', 'bank-report', '2021-07-13 17:06:06', NULL),
(209, 64, 'Bank Transaction Access', 'bank-transaction-access', '2021-07-13 17:09:48', NULL),
(210, 65, 'Bank Ledger Access', 'bank-ledger-access', '2021-07-13 17:10:05', NULL),
(211, 67, 'Mobile Bank Access', 'mobile-bank-access', '2021-07-13 17:17:15', NULL),
(212, 67, 'Mobile Bank Add', 'mobile-bank-add', '2021-07-13 17:17:15', NULL),
(213, 67, 'Mobile Bank Edit', 'mobile-bank-edit', '2021-07-13 17:17:15', NULL),
(214, 67, 'Mobile Bank Delete', 'mobile-bank-delete', '2021-07-13 17:17:15', NULL),
(215, 67, 'Mobile Bank Bulk Delete', 'mobile-bank-bulk-delete', '2021-07-13 17:17:15', NULL),
(216, 67, 'Mobile Bank Report', 'mobile-bank-report', '2021-07-13 17:17:15', NULL),
(217, 68, 'Mobile Bank Transaction Access', 'mobile-bank-transaction-access', '2021-07-13 17:17:36', NULL),
(218, 69, 'Mobile Bank Ledger Access', 'mobile-bank-ledger-access', '2021-07-13 17:17:56', NULL),
(219, 58, 'District Access', 'district-access', '2021-07-13 17:26:47', NULL),
(220, 58, 'District Add', 'district-add', '2021-07-13 17:26:47', NULL),
(221, 58, 'District Edit', 'district-edit', '2021-07-13 17:26:47', NULL),
(222, 58, 'District Delete', 'district-delete', '2021-07-13 17:26:47', NULL),
(223, 58, 'District Bulk Delete', 'district-bulk-delete', '2021-07-13 17:26:47', NULL),
(224, 58, 'District Report', 'district-report', '2021-07-13 17:26:47', NULL),
(225, 59, 'Upazila Access', 'upazila-access', '2021-07-13 17:30:37', NULL),
(226, 59, 'Upazila Add', 'upazila-add', '2021-07-13 17:30:37', NULL),
(227, 59, 'Upazila Edit', 'upazila-edit', '2021-07-13 17:30:37', NULL),
(228, 59, 'Upazila Delete', 'upazila-delete', '2021-07-13 17:30:37', NULL),
(229, 59, 'Upazila Bulk Delete', 'upazila-bulk-delete', '2021-07-13 17:30:37', NULL),
(230, 59, 'Upazila Report', 'upazila-report', '2021-07-13 17:30:37', NULL),
(231, 60, 'Route Access', 'route-access', '2021-07-13 17:31:38', NULL),
(232, 60, 'Route Add', 'route-add', '2021-07-13 17:31:38', NULL),
(233, 60, 'Route Edit', 'route-edit', '2021-07-13 17:31:38', NULL),
(234, 60, 'Route Delete', 'route-delete', '2021-07-13 17:31:38', NULL),
(235, 60, 'Route Bulk Delete', 'route-bulk-delete', '2021-07-13 17:31:38', NULL),
(236, 60, 'Route Report', 'route-report', '2021-07-13 17:31:38', NULL),
(237, 61, 'Area Access', 'area-access', '2021-07-13 17:32:53', NULL),
(238, 61, 'Area Add', 'area-add', '2021-07-13 17:32:53', NULL),
(239, 61, 'Area Edit', 'area-edit', '2021-07-13 17:32:53', NULL),
(240, 61, 'Area Delete', 'area-delete', '2021-07-13 17:32:53', NULL),
(241, 61, 'Area Bulk Delete', 'area-bulk-delete', '2021-07-13 17:32:53', NULL),
(242, 61, 'Area Report', 'area-report', '2021-07-13 17:32:53', NULL),
(243, 55, 'ASM Access', 'asm-access', '2021-07-13 17:35:08', NULL),
(244, 55, 'ASM Add', 'asm-add', '2021-07-13 17:35:08', NULL),
(245, 55, 'ASM Edit', 'asm-edit', '2021-07-13 17:35:08', NULL),
(246, 55, 'ASM View', 'asm-view', '2021-07-13 17:35:08', NULL),
(247, 55, 'ASM Delete', 'asm-delete', '2021-07-13 17:35:08', NULL),
(248, 55, 'ASM Bulk Delete', 'asm-bulk-delete', '2021-07-13 17:35:08', NULL),
(249, 55, 'ASM Report', 'asm-report', '2021-07-13 17:35:08', NULL),
(250, 55, 'ASM Permission', 'asm-permission', '2021-07-13 17:35:08', NULL),
(251, 56, 'SR Access', 'sr-access', '2021-07-13 17:48:06', NULL),
(252, 56, 'SR Add', 'sr-add', '2021-07-13 17:48:06', NULL),
(253, 56, 'SR Edit', 'sr-edit', '2021-07-13 17:48:06', NULL),
(254, 56, 'SR View', 'sr-view', '2021-07-13 17:48:06', NULL),
(255, 56, 'SR Delete', 'sr-delete', '2021-07-13 17:48:06', NULL),
(256, 56, 'SR Bulk Delete', 'sr-bulk-delete', '2021-07-13 17:48:06', NULL),
(257, 56, 'SR Report', 'sr-report', '2021-07-13 17:48:06', NULL),
(258, 98, 'Department Access', 'department-access', '2021-04-03 18:20:33', NULL),
(259, 98, 'Department Add', 'department-add', '2021-04-03 18:20:33', NULL),
(260, 98, 'Department Edit', 'department-edit', '2021-04-03 18:20:33', NULL),
(261, 98, 'Department Delete', 'department-delete', '2021-04-03 18:20:33', NULL),
(262, 98, 'Department Bulk Delete', 'department-bulk-delete', '2021-04-03 18:20:33', NULL),
(263, 98, 'Department Report', 'department-report', '2021-04-03 18:20:33', NULL),
(264, 99, 'Division Access', 'division-access', '2021-04-03 18:21:27', NULL),
(265, 99, 'Division Add', 'division-add', '2021-04-03 18:21:27', NULL),
(266, 99, 'Division Edit', 'division-edit', '2021-04-03 18:21:27', NULL),
(267, 99, 'Division Delete', 'division-delete', '2021-04-03 18:21:27', NULL),
(268, 99, 'Division Bulk Delete', 'division-bulk-delete', '2021-04-03 18:21:27', NULL),
(269, 99, 'Division Report', 'division-report', '2021-04-03 18:21:27', NULL),
(270, 100, 'Designation Access', 'designation-access', '2021-04-03 18:22:20', NULL),
(271, 100, 'Designation Add', 'designation-add', '2021-04-03 18:22:20', NULL),
(272, 100, 'Designation Edit', 'designation-edit', '2021-04-03 18:22:20', NULL),
(273, 100, 'Designation Delete', 'designation-delete', '2021-04-03 18:22:20', NULL),
(274, 100, 'Designation Bulk Delete', 'designation-bulk-delete', '2021-04-03 18:22:20', NULL),
(275, 100, 'Designation Report', 'designation-report', '2021-04-03 18:22:20', NULL),
(276, 103, 'Employee Access', 'employee-access', '2021-04-03 18:23:18', NULL),
(277, 103, 'Employee Add', 'employee-add', '2021-04-03 18:23:18', NULL),
(278, 103, 'Employee Edit', 'employee-edit', '2021-04-03 18:23:18', NULL),
(279, 103, 'Employee View', 'employee-view', '2021-04-03 18:23:18', NULL),
(280, 103, 'Employee Delete', 'employee-delete', '2021-04-03 18:23:18', NULL),
(281, 103, 'Employee Bulk Delete', 'employee-bulk-delete', '2021-04-03 18:23:18', NULL),
(282, 103, 'Employee Report', 'employee-report', '2021-04-03 18:23:18', NULL),
(283, 105, 'Attendance Access', 'attendance-access', '2021-04-03 18:24:19', NULL),
(284, 105, 'Attendance Add', 'attendance-add', '2021-04-03 18:24:19', NULL),
(285, 105, 'Attendance Edit', 'attendance-edit', '2021-04-03 18:24:19', NULL),
(286, 105, 'Attendance Delete', 'attendance-delete', '2021-04-03 18:24:19', NULL),
(287, 105, 'Attendance Bulk Delete', 'attendance-bulk-delete', '2021-04-03 18:24:19', NULL),
(288, 105, 'Attendance Report', 'attendance-report', '2021-04-03 18:24:19', NULL),
(289, 106, 'Attendance Report Access', 'attendance-report-access', '2021-04-03 18:24:43', NULL),
(290, 113, 'Weekly Holiday Access', 'weekly-holiday-access', '2021-04-03 18:26:00', NULL),
(291, 113, 'Weekly Holiday Add', 'weekly-holiday-add', '2021-04-03 18:26:00', NULL),
(292, 113, 'Weekly Holiday Edit', 'weekly-holiday-edit', '2021-04-03 18:26:00', NULL),
(293, 113, 'Weekly Holiday Delete', 'weekly-holiday-delete', '2021-04-03 18:26:00', NULL),
(294, 113, 'Weekly Holiday Bulk Delete', 'weekly-holiday-bulk-delete', '2021-04-03 18:26:00', NULL),
(295, 113, 'Weekly Holiday Report', 'weekly-holiday-report', '2021-04-03 18:26:00', NULL),
(296, 114, 'Holiday Access', 'holiday-access', '2021-04-03 18:26:54', NULL),
(297, 114, 'Holiday Add', 'holiday-add', '2021-04-03 18:26:54', NULL),
(298, 114, 'Holiday Edit', 'holiday-edit', '2021-04-03 18:26:54', NULL),
(299, 114, 'Holiday Delete', 'holiday-delete', '2021-04-03 18:26:54', NULL),
(300, 114, 'Holiday Bulk Delete', 'holiday-bulk-delete', '2021-04-03 18:26:54', NULL),
(301, 114, 'Holiday Report', 'holiday-report', '2021-04-03 18:26:54', NULL),
(302, 115, 'Leave Type Access', 'leave-type-access', '2021-04-03 18:27:42', NULL),
(303, 115, 'Leave Type Add', 'leave-type-add', '2021-04-03 18:27:42', NULL),
(304, 115, 'Leave Type Edit', 'leave-type-edit', '2021-04-03 18:27:42', NULL),
(305, 115, 'Leave Type Delete', 'leave-type-delete', '2021-04-03 18:27:42', NULL),
(306, 115, 'Leave Type Bulk Delete', 'leave-type-bulk-delete', '2021-04-03 18:27:42', NULL),
(307, 115, 'Leave Type Report', 'leave-type-report', '2021-04-03 18:27:42', NULL),
(308, 116, 'Leave Application Access', 'leave-application-access', '2021-04-03 18:29:45', NULL),
(309, 116, 'Leave Application Add', 'leave-application-add', '2021-04-03 18:29:45', NULL),
(310, 116, 'Leave Application Edit', 'leave-application-edit', '2021-04-03 18:29:45', NULL),
(311, 116, 'Leave Application Delete', 'leave-application-delete', '2021-04-03 18:29:45', NULL),
(312, 116, 'Leave Application Bulk Delete', 'leave-application-bulk-delete', '2021-04-03 18:29:45', NULL),
(313, 116, 'Leave Application Report', 'leave-application-report', '2021-04-03 18:29:45', NULL),
(314, 116, 'Leave Application Approve', 'leave-application-approve', '2021-04-03 18:29:45', NULL),
(315, 108, 'Benifits Access', 'benifits-access', '2021-04-03 18:30:33', NULL),
(316, 108, 'Benifits Add', 'benifits-add', '2021-04-03 18:30:33', NULL),
(317, 108, 'Benifits Edit', 'benifits-edit', '2021-04-03 18:30:33', NULL),
(318, 108, 'Benifits Delete', 'benifits-delete', '2021-04-03 18:30:33', NULL),
(319, 108, 'Benifits Bulk Delete', 'benifits-bulk-delete', '2021-04-03 18:30:33', NULL),
(320, 108, 'Benifits Report', 'benifits-report', '2021-04-03 18:30:33', NULL),
(321, 110, 'Salary Setup Access', 'salary-setup-access', '2021-04-03 18:31:37', NULL),
(322, 110, 'Salary Setup Add', 'salary-setup-add', '2021-04-03 18:31:37', NULL),
(323, 110, 'Salary Setup Edit', 'salary-setup-edit', '2021-04-03 18:31:37', NULL),
(324, 110, 'Salary Setup View', 'salary-setup-view', '2021-04-03 18:31:37', NULL),
(325, 110, 'Salary Setup Delete', 'salary-setup-delete', '2021-04-03 18:31:37', NULL),
(326, 110, 'Salary Setup Bulk Delete', 'salary-setup-bulk-delete', '2021-04-03 18:31:37', NULL),
(327, 110, 'Salary Setup Report', 'salary-setup-report', '2021-04-03 18:31:37', NULL),
(328, 111, 'Salary Generate Access', 'salary-generate-access', '2021-04-03 18:35:39', NULL),
(329, 111, 'Salary Generate Add', 'salary-generate-add', '2021-04-03 18:35:39', NULL),
(330, 111, 'Salary Generate Delete', 'salary-generate-delete', '2021-04-03 18:35:39', NULL),
(331, 111, 'Salary Generate Bulk Delete', 'salary-generate-bulk-delete', '2021-04-03 18:35:39', NULL),
(332, 111, 'Salary Generate Report', 'salary-generate-report', '2021-04-03 18:35:39', NULL),
(333, 101, 'Shift Access', 'shift-access', '2021-04-26 01:14:07', NULL),
(334, 101, 'Shift Add', 'shift-add', '2021-04-26 01:14:07', NULL),
(335, 101, 'Shift Edit', 'shift-edit', '2021-04-26 01:14:07', NULL),
(336, 101, 'Shift Delete', 'shift-delete', '2021-04-26 01:14:07', NULL),
(337, 101, 'Shift Bulk Delete', 'shift-bulk-delete', '2021-04-26 01:14:07', NULL),
(338, 101, 'Shift Report', 'shift-report', '2021-04-26 01:14:07', NULL),
(339, 101, 'Shift Manage Access', 'shift-manage-access', '2021-04-26 01:14:07', NULL),
(340, 101, 'Shift Manage Add', 'shift-manage-add', '2021-04-26 01:14:07', NULL),
(341, 101, 'Shift Manage Edit', 'shift-manage-edit', '2021-04-26 01:14:07', NULL),
(342, 101, 'Shift Manage Delete', 'shift-manage-delete', '2021-04-26 01:14:07', NULL),
(343, 101, 'Shift Manage Bulk Delete', 'shift-manage-bulk-delete', '2021-04-26 01:14:07', NULL),
(344, 101, 'Shift Manage Report', 'shift-manage-report', '2021-04-26 01:14:07', NULL),
(345, 101, 'Employee Shift Change', 'employee-shift-change', '2021-04-26 17:24:58', NULL),
(354, 35, 'Production Operation', 'production-operation', '2021-08-06 17:14:21', NULL),
(355, 35, 'Production Transfer', 'production-transfer', '2021-08-06 17:14:21', NULL),
(356, 50, 'Supplier Advance Add', 'supplier-advance-add', '2021-08-11 08:05:49', NULL),
(357, 50, 'Supplier Advance Edit', 'supplier-advance-edit', '2021-08-11 08:05:49', NULL),
(358, 50, 'Supplier Advance Delete', 'supplier-advance-delete', '2021-08-11 08:05:49', NULL),
(359, 50, 'Supplier Advance Bulk Delete', 'supplier-advance-bulk-delete', '2021-08-11 08:05:49', NULL),
(360, 50, 'Supplier Advance Approve', 'supplier-advance-approve', '2021-08-11 08:05:49', NULL),
(361, 40, 'Stock Transfer Access', 'stock-transfer-access', '2021-08-12 09:41:26', NULL),
(362, 40, 'Stock Transfer View', 'stock-transfer-view', '2021-08-12 09:41:26', NULL),
(363, 40, 'Stock Transfer Add', 'stock-transfer-add', '2021-08-12 09:43:53', NULL),
(364, 126, 'Finish Goods Access', 'finish-goods-access', '2021-08-12 12:57:26', NULL),
(365, 127, 'ASM Permission Access', 'asm-permission-access', '2021-08-14 04:32:25', NULL),
(366, 127, 'ASM Permission Add', 'asm-permission-add', '2021-08-14 04:32:25', NULL),
(367, 127, 'ASM Permission Edit', 'asm-permission-edit', '2021-08-14 04:32:25', NULL),
(368, 127, 'ASM Permission Delete', 'asm-permission-delete', '2021-08-14 04:32:25', NULL),
(369, 127, 'ASM Permission Bulk Delete', 'asm-permission-bulk-delete', '2021-08-14 04:32:25', NULL),
(370, 127, 'ASM Permission Report', 'asm-permission-report', '2021-08-14 04:32:25', NULL),
(371, 119, 'Dashboard Access', 'dashboard-access', '2021-08-14 04:54:25', NULL),
(372, 123, 'Product Access', 'product-access', '2021-08-14 04:54:54', NULL),
(373, 124, 'Product Stock Report Access', 'product-stock-report-access', '2021-08-14 04:55:19', NULL),
(374, 137, 'Sale Access', 'sale-access', '2021-08-16 06:28:48', NULL),
(375, 137, 'Sale Add', 'sale-add', '2021-08-16 06:28:48', NULL),
(376, 137, 'Sale Edit', 'sale-edit', '2021-08-16 06:28:48', NULL),
(377, 137, 'Sale View', 'sale-view', '2021-08-16 06:28:48', NULL),
(378, 137, 'Sale Delete', 'sale-delete', '2021-08-16 06:28:48', NULL),
(379, 137, 'Sale Export Button', 'sale-export-button', '2021-08-16 06:28:48', NULL),
(380, 134, 'Stock Transfer Access', 'stock-transfer-access', '2021-08-16 06:38:07', NULL),
(381, 139, 'Return Access', 'return-access', '2021-08-16 06:38:49', NULL),
(382, 140, 'Sale Return Access', 'sale-return-access', '2021-08-16 06:39:03', NULL),
(383, 129, 'Customer Access', 'customer-access', '2021-08-16 06:40:24', NULL),
(384, 129, 'Customer Add', 'customer-add', '2021-08-16 06:40:24', NULL),
(385, 129, 'Customer Edit', 'customer-edit', '2021-08-16 06:40:24', NULL),
(386, 129, 'Customer View', 'customer-view', '2021-08-16 06:40:24', NULL),
(387, 129, 'Customer Delete', 'customer-delete', '2021-08-16 06:40:24', NULL),
(388, 129, 'Customer Export Button', 'customer-export-button', '2021-08-16 06:40:24', NULL),
(389, 130, 'Customer Ledger Access', 'customer-ledger-access', '2021-08-16 06:40:53', NULL),
(390, 131, 'Credit Customer Access', 'credit-customer-access', '2021-08-16 06:41:16', NULL),
(391, 132, 'Paid Customer Access', 'paid-customer-access', '2021-08-16 06:41:40', NULL),
(392, 133, 'Customer Advance Access', 'customer-advance-access', '2021-08-16 06:42:40', NULL),
(393, 133, 'Customer Advance Add', 'customer-advance-add', '2021-08-16 06:42:40', NULL),
(394, 133, 'Customer Advance Edit', 'customer-advance-edit', '2021-08-16 06:42:40', NULL),
(395, 133, 'Customer Advance Delete', 'customer-advance-delete', '2021-08-16 06:42:40', NULL),
(396, 133, 'Customer Advance Export Button', 'customer-advance-export-button', '2021-08-16 06:42:40', NULL),
(397, 145, 'SR Access', 'sr-access', '2021-08-16 07:59:35', NULL),
(398, 145, 'SR Export Button', 'sr-export-button', '2021-08-16 07:59:35', NULL),
(399, 142, 'Upazila Access', 'upazila-access', '2021-08-16 08:00:51', NULL),
(400, 142, 'Upazila Add', 'upazila-add', '2021-08-16 08:00:51', NULL),
(401, 142, 'Upazila Edit', 'upazila-edit', '2021-08-16 08:00:51', NULL),
(402, 142, 'Upazila Delete', 'upazila-delete', '2021-08-16 08:00:51', NULL),
(403, 142, 'Upazila Export Button', 'upazila-export-button', '2021-08-16 08:00:51', NULL),
(404, 143, 'Route Access', 'route-access', '2021-08-16 08:01:53', NULL),
(405, 143, 'Route Add', 'route-add', '2021-08-16 08:01:53', NULL),
(406, 143, 'Route Edit', 'route-edit', '2021-08-16 08:01:53', NULL),
(407, 143, 'Route Delete', 'route-delete', '2021-08-16 08:01:53', NULL),
(408, 143, 'Route Export Button', 'route-export-button', '2021-08-16 08:01:53', NULL),
(409, 144, 'Area Access', 'area-access', '2021-08-16 08:02:56', NULL),
(410, 144, 'Area Add', 'area-add', '2021-08-16 08:02:56', NULL),
(411, 144, 'Area Edit', 'area-edit', '2021-08-16 08:02:56', NULL),
(412, 144, 'Area Delete', 'area-delete', '2021-08-16 08:02:56', NULL),
(413, 144, 'Area Export Button', 'area-export-button', '2021-08-16 08:02:56', NULL),
(414, 145, 'SR View', 'sr-view', '2021-08-16 10:50:22', NULL),
(415, 134, 'Stock Transfer Export Button', 'stock-transfer-export-button', '2021-08-17 19:23:27', NULL),
(418, 149, 'Expense Item Access', 'expense-item-access', '2021-08-23 16:33:55', NULL),
(419, 149, 'Expense Item Add', 'expense-item-add', '2021-08-23 16:33:55', NULL),
(420, 149, 'Expense Item Edit', 'expense-item-edit', '2021-08-23 16:33:55', NULL),
(421, 150, 'Expense Access', 'expense-access', '2021-08-23 16:34:50', NULL),
(422, 150, 'Expense Add', 'expense-add', '2021-08-23 16:34:50', NULL),
(423, 150, 'Expense Edit', 'expense-edit', '2021-08-23 16:34:50', NULL),
(424, 150, 'Expense Delete', 'expense-delete', '2021-08-23 16:34:50', NULL),
(425, 151, 'Expense Statement Access', 'expense-statement-access', '2021-08-23 16:38:04', NULL),
(426, 153, 'Sales Report Access', 'sales-report-access', '2021-08-23 16:38:35', NULL),
(427, 154, 'Inventory Report Access', 'inventory-report-access', '2021-08-23 16:45:08', NULL),
(430, 155, 'Todays Customer Receipt Access', 'todays-customer-receipt-access', '2021-08-23 17:36:21', NULL),
(431, 156, 'Customer Receipt List Access', 'customer-receipt-list-access', '2021-08-23 17:36:48', NULL),
(432, 157, 'Salesman Wise Sales Report Access', 'salesman-wise-sales-report-access', '2021-08-23 17:37:14', NULL),
(433, 158, 'Due Report Access', 'due-report-access', '2021-08-23 17:37:32', NULL),
(434, 159, 'Shipping Cost Report Access', 'shipping-cost-report-access', '2021-08-23 17:37:56', NULL),
(435, 160, 'Product Wise Sales Report Access', 'product-wise-sales-report-access', '2021-08-23 17:38:28', NULL),
(436, 161, 'Damage Report Access', 'damage-report-access', '2021-08-23 17:38:51', NULL),
(437, 162, 'Warehouse Expense Report', 'warehouse-expense-report', '2021-08-23 17:39:19', NULL),
(438, 163, 'Collection Report Access', 'collection-report-access', '2021-08-23 17:39:45', NULL),
(440, 165, 'Warehouse Summary Access', 'warehouse-summary-access', '2021-08-23 17:40:35', NULL),
(441, 166, 'Coupon Received Report Access', 'coupon-received-report-access', '2021-08-23 17:40:58', NULL),
(442, 168, 'Bank Access', 'bank-access', '2021-08-29 03:55:23', NULL),
(443, 169, 'Bank Transaction Access', 'bank-transaction-access', '2021-08-29 03:55:42', NULL),
(444, 170, 'Bank Ledger Access', 'bank-ledger-access', '2021-08-29 03:55:57', NULL),
(445, 172, 'Mobile Bank Access', 'mobile-bank-access', '2021-08-29 03:56:14', NULL),
(446, 173, 'Mobile Bank Transaction Access', 'mobile-bank-transaction-access', '2021-08-29 03:56:38', NULL),
(447, 174, 'Mobile Bank Ledger Access', 'mobile-bank-ledger-access', '2021-08-29 03:57:04', NULL),
(449, 176, 'Closing Access', 'closing-access', '2021-08-30 05:16:49', NULL),
(450, 177, 'Closing Report Access', 'closing-report-access', '2021-08-30 05:17:08', NULL),
(451, 178, 'Today Sales Report Access', 'today-sales-report-access', '2021-08-30 05:17:43', NULL),
(452, 180, 'Closing Access', 'closing-access', '2021-09-06 04:21:08', NULL),
(453, 181, 'Closing Report Access', 'closing-report-access', '2021-09-06 04:21:26', NULL),
(454, 182, 'Today Sales Report Access', 'today-sales-report-access', '2021-09-06 04:25:48', NULL),
(455, 183, 'Sales Report Access', 'sales-report-access', '2021-09-06 04:26:08', NULL),
(456, 184, 'Inventory Report Access', 'inventory-report-access', '2021-09-06 04:26:37', NULL),
(457, 185, 'Todays-customer-receipt-access', 'todays-customer-receipt-access', '2021-09-06 04:27:18', NULL),
(458, 186, 'Customer Receipt List Access', 'customer-receipt-list-access', '2021-09-06 04:27:40', NULL),
(459, 187, 'Salesman Wise Sales Report Access', 'salesman-wise-sales-report-access', '2021-09-06 04:28:10', NULL),
(460, 188, 'Due Report Access', 'due-report-access', '2021-09-06 04:28:26', NULL),
(461, 189, 'Shipping Cost Report Access', 'shipping-cost-report-access', '2021-09-06 04:28:49', NULL),
(462, 190, 'Product Wise Sales Report Access', 'product-wise-sales-report-access', '2021-09-06 04:29:23', NULL),
(463, 191, 'Damage Report Access', 'damage-report-access', '2021-09-06 04:29:48', NULL),
(464, 192, 'Warehouse Expense Report Access', 'warehouse-expense-report-access', '2021-09-06 04:30:41', NULL),
(465, 193, 'Collection Report Access', 'collection-report-access', '2021-09-06 04:31:04', NULL),
(466, 194, 'Warehouse Summary Access', 'warehouse-summary-access', '2021-09-06 04:31:26', NULL),
(467, 195, 'Coupon Received Report Access', 'coupon-received-report-access', '2021-09-06 04:31:50', NULL),
(468, 196, 'Material Stock Alert Report Access', 'material-stock-alert-report-access', '2021-09-06 04:32:12', '2021-09-06 18:30:08'),
(470, 199, 'Finish Goods Inventory Report Access', 'finish-goods-inventory-report-access', '2021-09-06 04:54:59', NULL),
(471, 200, 'Transfer Report Access', 'transfer-report-access', '2021-09-06 04:55:22', NULL),
(472, 198, 'Material Issue Report Access', 'material-issue-report-access', '2021-09-06 04:55:45', NULL),
(473, 201, 'Batch Wise Coupon Report Access', 'batch-wise-coupon-report-access', '2021-09-07 08:07:41', '2021-09-07 08:29:07'),
(474, 202, 'Warehouse Closing Report Access', 'warehouse-closing-report-access', '2021-09-07 09:19:45', NULL),
(475, 203, 'Debit Voucher List Access', 'debit-voucher-list-access', '2021-09-07 09:57:25', NULL),
(476, 204, 'Credit Voucher List Access', 'credit-voucher-list-access', '2021-09-07 09:59:32', NULL),
(477, 46, 'Customer Advance Add', 'customer-advance-add', '2021-09-07 10:34:17', NULL),
(478, 46, 'Customer Advance Edit', 'customer-advance-edit', '2021-09-07 10:34:50', NULL),
(479, 46, 'Customer Advance Delete', 'customer-advance-delete', '2021-09-07 10:34:50', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`id`, `permission_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(2, 58, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(3, 59, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(4, 60, 2, '2021-08-13 13:57:37', '2021-08-13 13:57:37'),
(5, 61, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(6, 62, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(7, 63, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(8, 64, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(9, 65, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(10, 66, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(11, 67, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(12, 68, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(13, 69, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(14, 70, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(15, 71, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(16, 80, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(17, 81, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(18, 82, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(19, 83, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(20, 84, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(21, 85, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(28, 92, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(29, 93, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(30, 94, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(31, 95, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(32, 96, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(33, 97, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(34, 98, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(35, 99, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(36, 100, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(37, 101, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(38, 102, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(39, 103, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(40, 104, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(41, 105, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(42, 106, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(43, 107, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(44, 109, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(45, 110, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(46, 111, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(47, 112, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(48, 113, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(49, 114, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(50, 115, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(51, 354, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(52, 355, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(53, 364, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(54, 140, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(55, 141, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(56, 142, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(57, 143, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(58, 144, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(59, 145, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(60, 146, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(61, 147, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(62, 148, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(63, 356, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(64, 357, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(65, 358, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(66, 359, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(67, 360, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(68, 219, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(69, 220, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(70, 221, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(71, 222, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(72, 223, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(73, 224, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(74, 225, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(75, 226, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(76, 227, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(77, 228, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(78, 229, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(79, 230, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(80, 231, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(81, 232, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(82, 233, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(83, 234, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(84, 235, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(85, 236, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(86, 237, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(87, 238, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(88, 239, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(89, 240, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(90, 241, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(91, 242, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(92, 2, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(93, 3, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(94, 4, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(95, 5, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(96, 6, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(97, 7, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(98, 8, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(99, 9, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(100, 10, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(101, 11, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(102, 12, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(103, 13, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(104, 14, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(105, 15, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(106, 243, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(107, 244, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(108, 245, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(109, 246, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(110, 247, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(111, 248, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(112, 249, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(113, 250, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(114, 251, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(115, 252, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(116, 253, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(117, 254, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(118, 255, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(119, 256, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(120, 257, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(121, 39, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(122, 33, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(123, 34, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(124, 35, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(125, 36, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(126, 37, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(127, 38, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(128, 40, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(129, 41, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(130, 42, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(131, 43, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(132, 44, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(133, 45, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(134, 46, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(135, 47, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(136, 48, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(137, 49, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(138, 50, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(139, 51, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(140, 52, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(141, 53, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(142, 54, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(143, 55, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(144, 56, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38'),
(145, 57, 2, '2021-08-13 13:57:38', '2021-08-13 13:57:38');

-- --------------------------------------------------------

--
-- Table structure for table `productions`
--

CREATE TABLE `productions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `batch_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `item` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=Approved, 2=Pending,3=Rejevted',
  `production_status` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Pending,2=Processing,3=Finished',
  `transfer_status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Pending,2=Complete',
  `transfer_date` date DEFAULT NULL,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productions`
--

INSERT INTO `productions` (`id`, `batch_no`, `warehouse_id`, `start_date`, `end_date`, `item`, `status`, `production_status`, `transfer_status`, `transfer_date`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, '1001', 2, '2021-08-11', '2021-08-11', '2', '1', '3', '2', '2021-08-12', 'Super Admin', '1', '2021-08-11 17:42:38', '2021-08-12 11:04:29'),
(2, '1002', 2, '2021-08-29', NULL, '1', '1', '2', '1', NULL, 'Super Admin', 'Super Admin', '2021-08-29 03:49:51', '2021-08-28 18:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `production_coupons`
--

CREATE TABLE `production_coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `production_product_id` bigint(20) UNSIGNED NOT NULL,
  `batch_no` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_code` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=Used, 2=Not Used',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `production_coupons`
--

INSERT INTO `production_coupons` (`id`, `production_product_id`, `batch_no`, `coupon_code`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, '1001', '64T1OSYJO2', '1', '2021-08-11 17:42:38', '2021-08-18 10:13:31'),
(2, 2, '1001', 'TLOHR74L8Q', '2', '2021-08-11 17:42:38', NULL),
(3, 2, '1001', 'MYRL88EZX6', '2', '2021-08-11 17:42:38', NULL),
(4, 2, '1001', 'AG94YSNROA', '2', '2021-08-11 17:42:38', NULL),
(5, 2, '1001', 'YE0996FIIV', '2', '2021-08-11 17:42:38', NULL),
(6, 2, '1001', 'VYTI0E1D1J', '2', '2021-08-11 17:42:38', NULL),
(7, 2, '1001', '92SUJECPF3', '2', '2021-08-11 17:42:38', NULL),
(8, 2, '1001', 'NU6KM1FMWU', '2', '2021-08-11 17:42:38', NULL),
(9, 2, '1001', 'AF9D7DG3C2', '2', '2021-08-11 17:42:38', NULL),
(10, 2, '1001', 'SLOVD2ZUNB', '2', '2021-08-11 17:42:38', NULL),
(11, 2, '1001', '16U96MZQ6B', '2', '2021-08-11 17:42:38', NULL),
(12, 2, '1001', '4DBBL2V3VP', '2', '2021-08-11 17:42:38', NULL),
(13, 2, '1001', 'TLKF9R9FEM', '2', '2021-08-11 17:42:38', NULL),
(14, 2, '1001', '14WD3WSLUM', '2', '2021-08-11 17:42:38', NULL),
(15, 2, '1001', 'QYDEUYKC2B', '2', '2021-08-11 17:42:38', NULL),
(16, 2, '1001', '3O02H49O18', '2', '2021-08-11 17:42:38', NULL),
(17, 2, '1001', '8XP6KM159W', '2', '2021-08-11 17:42:38', NULL),
(18, 2, '1001', 'WR8EKRPPRX', '2', '2021-08-11 17:42:38', NULL),
(19, 2, '1001', 'V9N4J1D4TJ', '2', '2021-08-11 17:42:38', NULL),
(20, 2, '1001', '6K8NZEZGQJ', '2', '2021-08-11 17:42:38', NULL),
(21, 3, '1002', '7K0OG8QFSD', '2', '2021-08-29 03:49:52', NULL),
(22, 3, '1002', 'GYUY5VM8YP', '2', '2021-08-29 03:49:52', NULL),
(23, 3, '1002', 'OSUAAYRJF7', '2', '2021-08-29 03:49:52', NULL),
(24, 3, '1002', 'WM52D2D7XA', '2', '2021-08-29 03:49:52', NULL),
(25, 3, '1002', 'I5FI6R9RVQ', '2', '2021-08-29 03:49:52', NULL),
(26, 3, '1002', '0N5VJRRINE', '2', '2021-08-29 03:49:52', NULL),
(27, 3, '1002', '08IF9TQSJ1', '2', '2021-08-29 03:49:52', NULL),
(28, 3, '1002', 'X7NKBDOIL8', '2', '2021-08-29 03:49:52', NULL),
(29, 3, '1002', 'HK76GONHP6', '2', '2021-08-29 03:49:52', NULL),
(30, 3, '1002', '2UXRB6KGND', '2', '2021-08-29 03:49:52', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `production_products`
--

CREATE TABLE `production_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `production_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `year` int(11) NOT NULL,
  `mfg_date` date NOT NULL,
  `exp_date` date NOT NULL,
  `has_coupon` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Yes, 2=No',
  `total_coupon` double(8,2) DEFAULT NULL,
  `coupon_price` double(8,2) DEFAULT NULL,
  `coupon_exp_date` date DEFAULT NULL,
  `base_unit_qty` double DEFAULT NULL,
  `per_unit_cost` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `production_products`
--

INSERT INTO `production_products` (`id`, `production_id`, `product_id`, `year`, `mfg_date`, `exp_date`, `has_coupon`, `total_coupon`, `coupon_price`, `coupon_exp_date`, `base_unit_qty`, `per_unit_cost`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 1, '2021-08-11', '2022-08-11', '2', NULL, NULL, NULL, 240, 13.84, '2021-08-11 17:42:38', '2021-08-11 17:49:16'),
(2, 1, 3, 1, '2021-08-11', '2022-08-11', '1', 20.00, 5.00, '2022-08-11', 120, 23.13, '2021-08-11 17:42:38', '2021-08-11 17:49:16'),
(3, 2, 3, 1, '2021-08-29', '2022-08-29', '1', 10.00, 10.00, '2022-08-29', NULL, NULL, '2021-08-29 03:49:51', '2021-08-29 03:49:51');

-- --------------------------------------------------------

--
-- Table structure for table `production_product_materials`
--

CREATE TABLE `production_product_materials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `production_product_id` bigint(20) UNSIGNED NOT NULL,
  `material_id` bigint(20) UNSIGNED NOT NULL,
  `unit_id` bigint(20) UNSIGNED NOT NULL,
  `qty` double(8,2) DEFAULT NULL,
  `cost` double(8,2) DEFAULT NULL,
  `total` double(8,2) DEFAULT NULL,
  `used_qty` double(8,2) DEFAULT NULL,
  `damaged_qty` double(8,2) DEFAULT NULL,
  `odd_qty` double(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `production_product_materials`
--

INSERT INTO `production_product_materials` (`id`, `production_product_id`, `material_id`, `unit_id`, `qty`, `cost`, `total`, `used_qty`, `damaged_qty`, `odd_qty`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 2, 14.00, 180.00, 2520.00, 12.00, 0.00, 2.00, '2021-08-11 17:42:38', '2021-08-11 17:49:16'),
(2, 1, 4, 2, 2.00, 410.00, 820.00, 2.00, 0.00, 0.00, '2021-08-11 17:42:38', '2021-08-11 17:49:16'),
(3, 1, 9, 2, 2.00, 160.00, 320.00, 2.00, 0.00, 0.00, '2021-08-11 17:42:38', '2021-08-11 17:49:16'),
(4, 1, 13, 1, 2.00, 21.00, 42.00, 1.00, 0.00, 1.00, '2021-08-11 17:42:38', '2021-08-11 17:49:16'),
(5, 2, 3, 2, 12.00, 180.00, 2160.00, 12.00, 0.00, 0.00, '2021-08-11 17:42:38', '2021-08-11 17:49:16'),
(6, 2, 5, 2, 1.00, 420.00, 420.00, 1.00, 0.00, 0.00, '2021-08-11 17:42:38', '2021-08-11 17:49:16'),
(7, 2, 10, 2, 1.00, 175.00, 175.00, 1.00, 0.00, 0.00, '2021-08-11 17:42:38', '2021-08-11 17:49:16'),
(8, 2, 13, 1, 1.00, 21.00, 21.00, 1.00, 0.00, 0.00, '2021-08-11 17:42:38', '2021-08-11 17:49:16'),
(9, 3, 3, 2, 500.00, 390.00, 195000.00, NULL, NULL, NULL, '2021-08-29 03:49:52', '2021-08-29 03:49:52'),
(10, 3, 5, 2, 100.00, 420.00, 42000.00, NULL, NULL, NULL, '2021-08-29 03:49:52', '2021-08-29 03:49:52'),
(11, 3, 10, 2, 25.00, 175.00, 4375.00, NULL, NULL, NULL, '2021-08-29 03:49:52', '2021-08-29 03:49:52'),
(12, 3, 13, 1, 35.00, 21.00, 735.00, NULL, NULL, NULL, '2021-08-29 03:49:52', '2021-08-29 03:49:52');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `product_type` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Can,2=Foil',
  `barcode_symbology` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cost` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Base Unit wise cost',
  `base_unit_mrp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Base Unit wise MRP',
  `base_unit_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Base Unit wise Price',
  `unit_mrp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Base Unit wise MRP',
  `unit_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Base Unit wise Price',
  `base_unit_qty` double DEFAULT NULL,
  `unit_qty` double DEFAULT NULL,
  `alert_quantity` double DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_method` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Exclusive, 2=Inclusive',
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `code`, `category_id`, `product_type`, `barcode_symbology`, `base_unit_id`, `unit_id`, `cost`, `base_unit_mrp`, `base_unit_price`, `unit_mrp`, `unit_price`, `base_unit_qty`, `unit_qty`, `alert_quantity`, `image`, `tax_id`, `tax_method`, `status`, `description`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(2, 'Kohinoor Turmeric Powder 50 Gram', '86346223', 3, '2', 'C128', 1, 6, NULL, '24', '20', '5760', '4800', NULL, NULL, 50, NULL, NULL, '1', '1', 'Lorem ipsum dollar', 'Super Admin', 'Super Admin', '2021-07-31 17:25:56', '2021-07-31 18:20:02'),
(3, 'Kohinoor Turmeric Powder 100 Gram', '42980958', 3, '2', 'C128', 1, 7, NULL, '42', '38', '5040', '4560', NULL, NULL, 50, NULL, NULL, '1', '1', NULL, 'Super Admin', NULL, '2021-08-02 09:02:37', '2021-08-02 09:02:37'),
(4, 'Kohinoor Turmeric Powder 200 Gram', '10446827', 3, '2', 'C128', 1, 8, NULL, '80', '70', '4800', '4200', NULL, NULL, 50, NULL, NULL, '1', '1', NULL, 'Super Admin', NULL, '2021-08-02 09:04:32', '2021-08-02 09:04:32');

-- --------------------------------------------------------

--
-- Table structure for table `product_material`
--

CREATE TABLE `product_material` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `material_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_material`
--

INSERT INTO `product_material` (`id`, `product_id`, `material_id`, `created_at`, `updated_at`) VALUES
(1, 2, 3, '2021-07-31 17:25:56', '2021-07-31 17:25:56'),
(2, 2, 4, '2021-07-31 17:25:56', '2021-07-31 17:25:56'),
(3, 2, 9, '2021-07-31 17:25:56', '2021-07-31 17:25:56'),
(4, 2, 13, '2021-07-31 17:25:56', '2021-07-31 17:25:56'),
(5, 3, 3, '2021-08-02 09:02:37', '2021-08-02 09:02:37'),
(6, 3, 5, '2021-08-02 09:02:37', '2021-08-02 09:02:37'),
(7, 3, 10, '2021-08-02 09:02:37', '2021-08-02 09:02:37'),
(8, 3, 13, '2021-08-02 09:02:37', '2021-08-02 09:02:37'),
(9, 4, 3, '2021-08-02 09:04:32', '2021-08-02 09:04:32'),
(10, 4, 6, '2021-08-02 09:04:32', '2021-08-02 09:04:32'),
(11, 4, 11, '2021-08-02 09:04:32', '2021-08-02 09:04:32'),
(12, 4, 13, '2021-08-02 09:04:32', '2021-08-02 09:04:32');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `memo_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `item` double(8,2) NOT NULL,
  `total_qty` double(8,2) NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_labor_cost` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `paid_amount` double NOT NULL,
  `due_amount` double NOT NULL,
  `purchase_status` enum('1','2','3','4') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Received,2=Partial,3=Pending,4=Ordered',
  `payment_status` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Paid,2=Partial,3=Due',
  `payment_method` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Cash,2=Cheque,3=Mobile',
  `document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `purchase_date` date NOT NULL,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `memo_no`, `warehouse_id`, `supplier_id`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_labor_cost`, `total_cost`, `order_tax_rate`, `order_tax`, `order_discount`, `shipping_cost`, `grand_total`, `paid_amount`, `due_amount`, `purchase_status`, `payment_status`, `payment_method`, `document`, `note`, `purchase_date`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(2, 'PINV-1001', 1, 1, 2.00, 3010.00, 0, 0, 200, 3230, 0, 0, 50, 200, 3380, 1970, 1410, '1', '2', '1', NULL, 'Lorem ipsum dollar', '2021-08-25', 'Super Admin', 'Super Admin', '2021-08-25 10:52:46', '2021-08-27 06:49:45');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_payments`
--

CREATE TABLE `purchase_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_debit_transaction_id` bigint(20) UNSIGNED NOT NULL,
  `amount` double NOT NULL,
  `payment_method` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Cash,2=Cheque,3=Mobile',
  `cheque_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_note` text COLLATE utf8mb4_unicode_ci,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_payments`
--

INSERT INTO `purchase_payments` (`id`, `purchase_id`, `account_id`, `transaction_id`, `supplier_debit_transaction_id`, `amount`, `payment_method`, `cheque_no`, `payment_note`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 2, 23, 32, 31, 1970, '1', '', NULL, 'Super Admin', NULL, '2021-08-25 10:52:46', '2021-08-25 10:52:46');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_returns`
--

CREATE TABLE `purchase_returns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `return_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `memo_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED DEFAULT NULL,
  `total_price` double NOT NULL,
  `total_deduction` double DEFAULT NULL,
  `tax_rate` double DEFAULT NULL,
  `total_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  `date` date NOT NULL,
  `return_date` date NOT NULL,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_returns`
--

INSERT INTO `purchase_returns` (`id`, `return_no`, `memo_no`, `warehouse_id`, `supplier_id`, `total_price`, `total_deduction`, `tax_rate`, `total_tax`, `grand_total`, `reason`, `date`, `return_date`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(2, 'PRINV-210834', 'PINV-1001', 1, 1, 410, 0, NULL, 0, 410, NULL, '2021-08-25', '2021-08-28', 'Super Admin', NULL, '2021-08-28 13:12:49', '2021-08-28 13:12:49');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_materials`
--

CREATE TABLE `purchase_return_materials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_return_id` bigint(20) UNSIGNED NOT NULL,
  `memo_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `material_id` bigint(20) UNSIGNED NOT NULL,
  `return_qty` double NOT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `material_rate` double NOT NULL,
  `deduction_rate` double DEFAULT NULL,
  `deduction_amount` double DEFAULT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_return_materials`
--

INSERT INTO `purchase_return_materials` (`id`, `purchase_return_id`, `memo_no`, `material_id`, `return_qty`, `unit_id`, `material_rate`, `deduction_rate`, `deduction_amount`, `total`, `created_at`, `updated_at`) VALUES
(2, 2, 'PINV-1001', 4, 1000, 3, 0.41, NULL, NULL, 410, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `received_coupons`
--

CREATE TABLE `received_coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `salesmen_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `coupon_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `received_coupons`
--

INSERT INTO `received_coupons` (`id`, `salesmen_id`, `customer_id`, `coupon_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2021-08-18 10:13:31', '2021-08-18 10:13:31');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletable` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=No, 2=Yes',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `deletable`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', '1', NULL, NULL, NULL, NULL),
(2, 'Admin', '1', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `memo_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `upazila_id` bigint(20) UNSIGNED NOT NULL,
  `route_id` bigint(20) UNSIGNED NOT NULL,
  `area_id` bigint(20) UNSIGNED NOT NULL,
  `salesmen_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `item` double(8,2) NOT NULL,
  `total_qty` double(8,2) NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `labor_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `previous_due` double DEFAULT NULL,
  `net_total` double DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `due_amount` double DEFAULT NULL,
  `payment_status` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Paid,2=Partial,3=Due',
  `payment_method` enum('1','2','3') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1=Cash,2=Bank,3=Mobile Bank',
  `account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reference_no` text COLLATE utf8mb4_unicode_ci,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `sale_date` date NOT NULL,
  `delivery_status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Pending,2=Delivered',
  `delivery_date` date DEFAULT NULL,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `memo_no`, `warehouse_id`, `district_id`, `upazila_id`, `route_id`, `area_id`, `salesmen_id`, `customer_id`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `order_tax_rate`, `order_tax`, `order_discount`, `shipping_cost`, `labor_cost`, `grand_total`, `previous_due`, `net_total`, `paid_amount`, `due_amount`, `payment_status`, `payment_method`, `account_id`, `reference_no`, `document`, `note`, `sale_date`, `delivery_status`, `delivery_date`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(2, 'SINV-21082274', 2, 46, 425, 566, 581, 1, 1, 3.00, 30.00, 0, 0, 870, 0, 0, 10, 50, 50, 960, 2000, 2960, 2960, 0, '1', '1', 23, NULL, NULL, 'Lorem ipsum dollar', '2021-09-04', '2', '2021-09-04', 'Mohammad Arman', NULL, '2021-08-22 00:17:09', '2021-09-04 08:47:47'),
(3, 'SINV-210830608', 2, 46, 425, 566, 582, 1, 2, 2.00, 20.00, 0, 0, 580, 0, 0, 0, 0, 0, 580, 0, 580, 580, 0, '1', '1', 23, NULL, NULL, NULL, '2021-09-04', '2', '2021-09-04', 'Mohammad Arman', NULL, '2021-08-30 08:32:38', '2021-09-04 08:46:56'),
(4, 'SINV-210905111', 2, 46, 425, 566, 581, 1, 1, 1.00, 10.00, 0, 0, 380, 0, 0, 0, 0, 0, 380, 0, 380, 0, 380, '3', NULL, NULL, NULL, NULL, NULL, '2021-09-05', '1', NULL, 'Mohammad Arman', NULL, '2021-09-05 01:28:53', '2021-09-05 01:28:53'),
(5, 'SINV-210905712', 2, 46, 425, 566, 582, 1, 2, 1.00, 20.00, 0, 0, 760, 0, 0, 0, 0, 0, 760, 0, 760, 0, 760, '3', NULL, NULL, NULL, NULL, NULL, '2021-09-06', '1', NULL, 'Mohammad Arman', NULL, '2021-09-05 01:29:49', '2021-09-05 01:29:49');

-- --------------------------------------------------------

--
-- Table structure for table `salesmen`
--

CREATE TABLE `salesmen` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `additional_phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `upazila_id` bigint(20) UNSIGNED NOT NULL,
  `nid_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monthly_target_value` double DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `salesmen`
--

INSERT INTO `salesmen` (`id`, `name`, `username`, `phone`, `additional_phone`, `email`, `avatar`, `password`, `warehouse_id`, `district_id`, `upazila_id`, `nid_no`, `monthly_target_value`, `address`, `status`, `created_by`, `modified_by`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Md. Arman', 'Arman1394', '01521225987', NULL, 'mohammadarman123456@gmail.com', 'Mohammad-Arman-901061.png', '$2y$10$8.XlmjmTZE1bEFPILSZ7QO7le0GTctd8uaW36DOezD.gM2S2QtgEW', 2, 46, 425, '4549845654', 20000, 'Lorem ipsum dollar', '1', 'Super Admin', 'Super Admin', NULL, '2021-07-17 18:40:23', '2021-07-17 19:02:30');

-- --------------------------------------------------------

--
-- Table structure for table `sales_men_daily_routes`
--

CREATE TABLE `sales_men_daily_routes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `salesmen_id` bigint(20) UNSIGNED NOT NULL,
  `day` enum('1','2','3','4','5','6') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Sat,2=Sun,3=Mon,4=Tue,5=Wed,6=Thu',
  `route_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales_men_daily_routes`
--

INSERT INTO `sales_men_daily_routes` (`id`, `salesmen_id`, `day`, `route_id`, `created_at`, `updated_at`) VALUES
(1, 1, '1', 560, '2021-07-17 18:40:23', '2021-07-17 19:02:30'),
(2, 1, '2', 561, '2021-07-17 18:40:23', '2021-07-17 19:02:30'),
(3, 1, '3', 562, '2021-07-17 18:40:23', '2021-07-17 19:02:30'),
(4, 1, '4', 564, '2021-07-17 18:40:23', '2021-07-17 19:02:30'),
(5, 1, '5', 565, '2021-07-17 18:40:23', '2021-07-17 19:02:30'),
(6, 1, '6', 566, '2021-07-17 18:40:23', '2021-07-17 19:02:30');

-- --------------------------------------------------------

--
-- Table structure for table `sale_products`
--

CREATE TABLE `sale_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` bigint(20) UNSIGNED NOT NULL,
  `batch_no` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_products`
--

INSERT INTO `sale_products` (`id`, `sale_id`, `batch_no`, `product_id`, `qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(5, 2, '1006', 2, 5, 1, 20, 0, 0, 0, 100, NULL, NULL),
(6, 2, '1001', 3, 15, 1, 38, 0, 0, 0, 570, NULL, NULL),
(7, 2, '1001', 2, 10, 1, 20, 0, 0, 0, 200, NULL, NULL),
(8, 3, '1001', 2, 10, 1, 20, 0, 0, 0, 200, NULL, NULL),
(9, 3, '1001', 3, 10, 1, 38, 0, 0, 0, 380, NULL, NULL),
(10, 4, '1006', 3, 10, 1, 38, 0, 0, 0, 380, NULL, NULL),
(11, 5, '1001', 3, 20, 1, 38, 0, 0, 0, 760, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sale_returns`
--

CREATE TABLE `sale_returns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `return_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `memo_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `total_price` double NOT NULL,
  `total_deduction` double DEFAULT NULL,
  `tax_rate` double DEFAULT NULL,
  `total_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  `date` date NOT NULL,
  `return_date` date NOT NULL,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_returns`
--

INSERT INTO `sale_returns` (`id`, `return_no`, `memo_no`, `warehouse_id`, `customer_id`, `total_price`, `total_deduction`, `tax_rate`, `total_tax`, `grand_total`, `reason`, `date`, `return_date`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(2, 'SRINV-210904712', 'SINV-21082274', 2, 1, 290, 0, NULL, 0, 290, NULL, '2021-08-30', '2021-09-04', 'Mohammad Arman', NULL, '2021-09-04 05:47:26', '2021-09-04 05:47:26');

-- --------------------------------------------------------

--
-- Table structure for table `sale_return_products`
--

CREATE TABLE `sale_return_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_return_id` bigint(20) UNSIGNED NOT NULL,
  `memo_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch_no` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `return_qty` double NOT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_rate` double NOT NULL,
  `deduction_rate` double DEFAULT NULL,
  `deduction_amount` double DEFAULT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_return_products`
--

INSERT INTO `sale_return_products` (`id`, `sale_return_id`, `memo_no`, `batch_no`, `product_id`, `return_qty`, `unit_id`, `product_rate`, `deduction_rate`, `deduction_amount`, `total`, `created_at`, `updated_at`) VALUES
(3, 2, 'SINV-21082274', '1001', 2, 5, 1, 20, NULL, NULL, 100, NULL, NULL),
(4, 2, 'SINV-21082274', '1001', 3, 5, 1, 38, NULL, NULL, 190, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('2EMPHJtVqURmynoq2EcmoLZFpURVOxnRPQzKKyvO', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:92.0) Gecko/20100101 Firefox/92.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibU9tajVXTXpieG5OZjVXMW1KSGVVZ3I1OXEySzlUbnJWdTlKRkNUNyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0NToiaHR0cDovL2tvaGlub29yLnRlc3Qvd2FyZWhvdXNlLWNsb3NpbmctcmVwb3J0Ijt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHA6Ly9rb2hpbm9vci50ZXN0L3dhcmVob3VzZS1jbG9zaW5nLXJlcG9ydCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1631006811),
('9eI62YDHpLHL7XTQjFEZpeX3joILcI6xsc8W6OyL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:92.0) Gecko/20100101 Firefox/92.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaVFDT2JycWFURUpVSndPMkxPTGlhU0xlUVN2OFJRcWFGSzJnUEJuZSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0NToiaHR0cDovL2tvaGlub29yLnRlc3QvYmF0Y2gtd2lzZS1jb3Vwb24tcmVwb3J0Ijt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHA6Ly9rb2hpbm9vci50ZXN0L2JhdGNoLXdpc2UtY291cG9uLXJlcG9ydCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1631004135),
('g7pfxOD1mGnKMF6MPSyxWqrC6yII8etyThQ2qK0W', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:92.0) Gecko/20100101 Firefox/92.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoia2tRNVRwQ2NBUm82ZHlxbzRDdUMwVVlGV09xaVVVYzM4dDFJcFN3bSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNzoiaHR0cDovL2tvaGlub29yLnRlc3QvaW52ZW50b3J5LXJlcG9ydCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM3OiJodHRwOi8va29oaW5vb3IudGVzdC9pbnZlbnRvcnktcmVwb3J0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1630952095);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('ozs1AAOPRQzvso1VKPHujyly64OENJqETq9PqiQg', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:92.0) Gecko/20100101 Firefox/92.0', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiajl4M2E2ejlhemRBcUdBQWFkZXhUcHluWm9ITUFONmswRXFQaDhiUSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMzOiJodHRwOi8va29oaW5vb3ItYXNtLnRlc3QvdHJhbnNmZXIiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6OToidXNlcl9tZW51IjtPOjM5OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XENvbGxlY3Rpb24iOjE6e3M6ODoiACoAaXRlbXMiO2E6MTM6e2k6MDtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6Mjg6e3M6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO2k6MjtzOjExOiJtb2R1bGVfbmFtZSI7aTozO3M6MTM6ImRpdmlkZXJfdGl0bGUiO2k6NDtzOjEwOiJpY29uX2NsYXNzIjtpOjU7czozOiJ1cmwiO2k6NjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO2k6ODtzOjY6InRhcmdldCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6MTE5O3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czo5OiJEYXNoYm9hcmQiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7czoyMToiZmFzIGZhLXRhY2hvbWV0ZXItYWx0IjtzOjM6InVybCI7czoxOiIvIjtzOjU6Im9yZGVyIjtpOjE7czo5OiJwYXJlbnRfaWQiO047czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDctMTcgMDE6Mjg6MDUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMzAgMTE6MTY6MTUiO31zOjExOiIAKgBvcmlnaW5hbCI7YToxMjp7czoyOiJpZCI7aToxMTk7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjk6IkRhc2hib2FyZCI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtzOjIxOiJmYXMgZmEtdGFjaG9tZXRlci1hbHQiO3M6MzoidXJsIjtzOjE6Ii8iO3M6NToib3JkZXIiO2k6MTtzOjk6InBhcmVudF9pZCI7TjtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wNy0xNyAwMToyODowNSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0zMCAxMToxNjoxNSI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6Mjp7czoxMDoibW9kdWxlX2FzbSI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoxOntzOjg6IgAqAGl0ZW1zIjthOjE6e2k6MDtPOjIwOiJBcHBcTW9kZWxzXEFTTU1vZHVsZSI6Mjg6e3M6ODoiACoAdGFibGUiO3M6MTA6ImFzbV9tb2R1bGUiO3M6MTE6IgAqAGZpbGxhYmxlIjthOjI6e2k6MDtzOjk6Im1vZHVsZV9pZCI7aToxO3M6NjoiYXNtX2lkIjt9czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6NTp7czoyOiJpZCI7aToxO3M6OToibW9kdWxlX2lkIjtpOjExOTtzOjY6ImFzbV9pZCI7aToxO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTQgMTI6MjY6MDAiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTQgMTI6MjY6MDAiO31zOjExOiIAKgBvcmlnaW5hbCI7YTo1OntzOjI6ImlkIjtpOjE7czo5OiJtb2R1bGVfaWQiO2k6MTE5O3M6NjoiYXNtX2lkIjtpOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNCAxMjoyNjowMCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNCAxMjoyNjowMCI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fX19czo4OiJjaGlsZHJlbiI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoxOntzOjg6IgAqAGl0ZW1zIjthOjA6e319fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fWk6MTtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6Mjg6e3M6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO2k6MjtzOjExOiJtb2R1bGVfbmFtZSI7aTozO3M6MTM6ImRpdmlkZXJfdGl0bGUiO2k6NDtzOjEwOiJpY29uX2NsYXNzIjtpOjU7czozOiJ1cmwiO2k6NjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO2k6ODtzOjY6InRhcmdldCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6MTIxO3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIxIjtzOjExOiJtb2R1bGVfbmFtZSI7TjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtzOjU6Ik1lbnVzIjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtOO3M6NToib3JkZXIiO2k6MjtzOjk6InBhcmVudF9pZCI7TjtzOjY6InRhcmdldCI7TjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA3LTE3IDAxOjMwOjIwIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTMwIDExOjE2OjE1Ijt9czoxMToiACoAb3JpZ2luYWwiO2E6MTI6e3M6MjoiaWQiO2k6MTIxO3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIxIjtzOjExOiJtb2R1bGVfbmFtZSI7TjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtzOjU6Ik1lbnVzIjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtOO3M6NToib3JkZXIiO2k6MjtzOjk6InBhcmVudF9pZCI7TjtzOjY6InRhcmdldCI7TjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA3LTE3IDAxOjMwOjIwIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTMwIDExOjE2OjE1Ijt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6ODoiACoAZGF0ZXMiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToyOntzOjEwOiJtb2R1bGVfYXNtIjtPOjM5OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XENvbGxlY3Rpb24iOjE6e3M6ODoiACoAaXRlbXMiO2E6MTp7aTowO086MjA6IkFwcFxNb2RlbHNcQVNNTW9kdWxlIjoyODp7czo4OiIAKgB0YWJsZSI7czoxMDoiYXNtX21vZHVsZSI7czoxMToiACoAZmlsbGFibGUiO2E6Mjp7aTowO3M6OToibW9kdWxlX2lkIjtpOjE7czo2OiJhc21faWQiO31zOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTo1OntzOjI6ImlkIjtpOjI7czo5OiJtb2R1bGVfaWQiO2k6MTIxO3M6NjoiYXNtX2lkIjtpOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNCAxMjoyNjowMCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNCAxMjoyNjowMCI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjU6e3M6MjoiaWQiO2k6MjtzOjk6Im1vZHVsZV9pZCI7aToxMjE7czo2OiJhc21faWQiO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE0IDEyOjI2OjAwIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE0IDEyOjI2OjAwIjt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6ODoiACoAZGF0ZXMiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoxMDoidGltZXN0YW1wcyI7YjoxO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319fX1zOjg6ImNoaWxkcmVuIjtPOjM5OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XENvbGxlY3Rpb24iOjE6e3M6ODoiACoAaXRlbXMiO2E6MDp7fX19czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoxMDoidGltZXN0YW1wcyI7YjoxO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319aToyO086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjoyODp7czoxMToiACoAZmlsbGFibGUiO2E6OTp7aTowO3M6NzoibWVudV9pZCI7aToxO3M6NDoidHlwZSI7aToyO3M6MTE6Im1vZHVsZV9uYW1lIjtpOjM7czoxMzoiZGl2aWRlcl90aXRsZSI7aTo0O3M6MTA6Imljb25fY2xhc3MiO2k6NTtzOjM6InVybCI7aTo2O3M6NToib3JkZXIiO2k6NztzOjk6InBhcmVudF9pZCI7aTo4O3M6NjoidGFyZ2V0Ijt9czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxMjp7czoyOiJpZCI7aToxMjI7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjc6IlByb2R1Y3QiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7czoxMDoiZmFzIGZhLWJveCI7czozOiJ1cmwiO047czo1OiJvcmRlciI7aTozO3M6OToicGFyZW50X2lkIjtOO3M6NjoidGFyZ2V0IjtOO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDctMTcgMDE6MzE6MzAiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMzAgMTE6MTY6MTUiO31zOjExOiIAKgBvcmlnaW5hbCI7YToxMjp7czoyOiJpZCI7aToxMjI7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjc6IlByb2R1Y3QiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7czoxMDoiZmFzIGZhLWJveCI7czozOiJ1cmwiO047czo1OiJvcmRlciI7aTozO3M6OToicGFyZW50X2lkIjtOO3M6NjoidGFyZ2V0IjtOO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDctMTcgMDE6MzE6MzAiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMzAgMTE6MTY6MTUiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czo4OiIAKgBkYXRlcyI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjI6e3M6MTA6Im1vZHVsZV9hc20iO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6MTp7czo4OiIAKgBpdGVtcyI7YToxOntpOjA7TzoyMDoiQXBwXE1vZGVsc1xBU01Nb2R1bGUiOjI4OntzOjg6IgAqAHRhYmxlIjtzOjEwOiJhc21fbW9kdWxlIjtzOjExOiIAKgBmaWxsYWJsZSI7YToyOntpOjA7czo5OiJtb2R1bGVfaWQiO2k6MTtzOjY6ImFzbV9pZCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjU6e3M6MjoiaWQiO2k6MztzOjk6Im1vZHVsZV9pZCI7aToxMjI7czo2OiJhc21faWQiO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE0IDEyOjI2OjAwIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE0IDEyOjI2OjAwIjt9czoxMToiACoAb3JpZ2luYWwiO2E6NTp7czoyOiJpZCI7aTozO3M6OToibW9kdWxlX2lkIjtpOjEyMjtzOjY6ImFzbV9pZCI7aToxO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTQgMTI6MjY6MDAiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTQgMTI6MjY6MDAiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czo4OiIAKgBkYXRlcyI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX19fXM6ODoiY2hpbGRyZW4iO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6MTp7czo4OiIAKgBpdGVtcyI7YToyOntpOjA7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjI4OntzOjExOiIAKgBmaWxsYWJsZSI7YTo5OntpOjA7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtpOjI7czoxMToibW9kdWxlX25hbWUiO2k6MztzOjEzOiJkaXZpZGVyX3RpdGxlIjtpOjQ7czoxMDoiaWNvbl9jbGFzcyI7aTo1O3M6MzoidXJsIjtpOjY7czo1OiJvcmRlciI7aTo3O3M6OToicGFyZW50X2lkIjtpOjg7czo2OiJ0YXJnZXQiO31zOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjEyOntzOjI6ImlkIjtpOjEyMztzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MTQ6Ik1hbmFnZSBQcm9kdWN0IjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6NzoicHJvZHVjdCI7czo1OiJvcmRlciI7aToxO3M6OToicGFyZW50X2lkIjtpOjEyMjtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wNy0xNyAwMTozMTo1NSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wNy0xNyAwMTozMTo1OSI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjEyMztzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MTQ6Ik1hbmFnZSBQcm9kdWN0IjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6NzoicHJvZHVjdCI7czo1OiJvcmRlciI7aToxO3M6OToicGFyZW50X2lkIjtpOjEyMjtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wNy0xNyAwMTozMTo1NSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wNy0xNyAwMTozMTo1OSI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo4OiJjaGlsZHJlbiI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoxOntzOjg6IgAqAGl0ZW1zIjthOjA6e319fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fWk6MTtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6Mjg6e3M6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO2k6MjtzOjExOiJtb2R1bGVfbmFtZSI7aTozO3M6MTM6ImRpdmlkZXJfdGl0bGUiO2k6NDtzOjEwOiJpY29uX2NsYXNzIjtpOjU7czozOiJ1cmwiO2k6NjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO2k6ODtzOjY6InRhcmdldCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6MTI0O3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czoyMDoiUHJvZHVjdCBTdG9jayBSZXBvcnQiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7TjtzOjM6InVybCI7czoyMDoicHJvZHVjdC1zdG9jay1yZXBvcnQiO3M6NToib3JkZXIiO2k6MjtzOjk6InBhcmVudF9pZCI7aToxMjI7czo2OiJ0YXJnZXQiO047czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wNy0xNyAwMTozMjo0NSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wNy0xNyAwMTozMjo1NCI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjEyNDtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MjA6IlByb2R1Y3QgU3RvY2sgUmVwb3J0IjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MjA6InByb2R1Y3Qtc3RvY2stcmVwb3J0IjtzOjU6Im9yZGVyIjtpOjI7czo5OiJwYXJlbnRfaWQiO2k6MTIyO3M6NjoidGFyZ2V0IjtOO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDctMTcgMDE6MzI6NDUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDctMTcgMDE6MzI6NTQiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czo4OiIAKgBkYXRlcyI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6ODoiY2hpbGRyZW4iO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6MTp7czo4OiIAKgBpdGVtcyI7YTowOnt9fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX19fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX1pOjM7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjI4OntzOjExOiIAKgBmaWxsYWJsZSI7YTo5OntpOjA7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtpOjI7czoxMToibW9kdWxlX25hbWUiO2k6MztzOjEzOiJkaXZpZGVyX3RpdGxlIjtpOjQ7czoxMDoiaWNvbl9jbGFzcyI7aTo1O3M6MzoidXJsIjtpOjY7czo1OiJvcmRlciI7aTo3O3M6OToicGFyZW50X2lkIjtpOjg7czo2OiJ0YXJnZXQiO31zOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjEyOntzOjI6ImlkIjtpOjEzNTtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6NDoiU2FsZSI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtzOjE1OiJmYWIgZmEtb3BlbmNhcnQiO3M6MzoidXJsIjtOO3M6NToib3JkZXIiO2k6NDtzOjk6InBhcmVudF9pZCI7TjtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMTozOToxNSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0zMCAxMToxNjoxNSI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjEzNTtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6NDoiU2FsZSI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtzOjE1OiJmYWIgZmEtb3BlbmNhcnQiO3M6MzoidXJsIjtOO3M6NToib3JkZXIiO2k6NDtzOjk6InBhcmVudF9pZCI7TjtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMTozOToxNSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0zMCAxMToxNjoxNSI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6Mjp7czoxMDoibW9kdWxlX2FzbSI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoxOntzOjg6IgAqAGl0ZW1zIjthOjE6e2k6MDtPOjIwOiJBcHBcTW9kZWxzXEFTTU1vZHVsZSI6Mjg6e3M6ODoiACoAdGFibGUiO3M6MTA6ImFzbV9tb2R1bGUiO3M6MTE6IgAqAGZpbGxhYmxlIjthOjI6e2k6MDtzOjk6Im1vZHVsZV9pZCI7aToxO3M6NjoiYXNtX2lkIjt9czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6NTp7czoyOiJpZCI7aTo2O3M6OToibW9kdWxlX2lkIjtpOjEzNTtzOjY6ImFzbV9pZCI7aToxO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTM6MzU6NTUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTM6MzU6NTUiO31zOjExOiIAKgBvcmlnaW5hbCI7YTo1OntzOjI6ImlkIjtpOjY7czo5OiJtb2R1bGVfaWQiO2k6MTM1O3M6NjoiYXNtX2lkIjtpOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMzozNTo1NSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMzozNTo1NSI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fX19czo4OiJjaGlsZHJlbiI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoxOntzOjg6IgAqAGl0ZW1zIjthOjI6e2k6MDtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6Mjg6e3M6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO2k6MjtzOjExOiJtb2R1bGVfbmFtZSI7aTozO3M6MTM6ImRpdmlkZXJfdGl0bGUiO2k6NDtzOjEwOiJpY29uX2NsYXNzIjtpOjU7czozOiJ1cmwiO2k6NjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO2k6ODtzOjY6InRhcmdldCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6MTM2O3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czo4OiJBZGQgU2FsZSI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtzOjg6InNhbGUvYWRkIjtzOjU6Im9yZGVyIjtpOjE7czo5OiJwYXJlbnRfaWQiO2k6MTM1O3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDExOjM5OjQ1IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDExOjQwOjE2Ijt9czoxMToiACoAb3JpZ2luYWwiO2E6MTI6e3M6MjoiaWQiO2k6MTM2O3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czo4OiJBZGQgU2FsZSI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtzOjg6InNhbGUvYWRkIjtzOjU6Im9yZGVyIjtpOjE7czo5OiJwYXJlbnRfaWQiO2k6MTM1O3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDExOjM5OjQ1IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDExOjQwOjE2Ijt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6ODoiACoAZGF0ZXMiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjg6ImNoaWxkcmVuIjtPOjM5OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XENvbGxlY3Rpb24iOjE6e3M6ODoiACoAaXRlbXMiO2E6MDp7fX19czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoxMDoidGltZXN0YW1wcyI7YjoxO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319aToxO086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjoyODp7czoxMToiACoAZmlsbGFibGUiO2E6OTp7aTowO3M6NzoibWVudV9pZCI7aToxO3M6NDoidHlwZSI7aToyO3M6MTE6Im1vZHVsZV9uYW1lIjtpOjM7czoxMzoiZGl2aWRlcl90aXRsZSI7aTo0O3M6MTA6Imljb25fY2xhc3MiO2k6NTtzOjM6InVybCI7aTo2O3M6NToib3JkZXIiO2k6NztzOjk6InBhcmVudF9pZCI7aTo4O3M6NjoidGFyZ2V0Ijt9czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxMjp7czoyOiJpZCI7aToxMzc7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjExOiJNYW5hZ2UgU2FsZSI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtzOjQ6InNhbGUiO3M6NToib3JkZXIiO2k6MjtzOjk6InBhcmVudF9pZCI7aToxMzU7czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6NDA6MTIiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6NDA6MjUiO31zOjExOiIAKgBvcmlnaW5hbCI7YToxMjp7czoyOiJpZCI7aToxMzc7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjExOiJNYW5hZ2UgU2FsZSI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtzOjQ6InNhbGUiO3M6NToib3JkZXIiO2k6MjtzOjk6InBhcmVudF9pZCI7aToxMzU7czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6NDA6MTIiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6NDA6MjUiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czo4OiIAKgBkYXRlcyI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6ODoiY2hpbGRyZW4iO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6MTp7czo4OiIAKgBpdGVtcyI7YTowOnt9fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX19fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX1pOjQ7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjI4OntzOjExOiIAKgBmaWxsYWJsZSI7YTo5OntpOjA7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtpOjI7czoxMToibW9kdWxlX25hbWUiO2k6MztzOjEzOiJkaXZpZGVyX3RpdGxlIjtpOjQ7czoxMDoiaWNvbl9jbGFzcyI7aTo1O3M6MzoidXJsIjtpOjY7czo1OiJvcmRlciI7aTo3O3M6OToicGFyZW50X2lkIjtpOjg7czo2OiJ0YXJnZXQiO31zOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjEyOntzOjI6ImlkIjtpOjEzNDtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MTQ6IlN0b2NrIFRyYW5zZmVyIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO3M6MTk6ImZhcyBmYS1zaGFyZS1zcXVhcmUiO3M6MzoidXJsIjtzOjg6InRyYW5zZmVyIjtzOjU6Im9yZGVyIjtpOjU7czo5OiJwYXJlbnRfaWQiO047czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6MzY6NTkiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMzAgMTE6MTY6MTUiO31zOjExOiIAKgBvcmlnaW5hbCI7YToxMjp7czoyOiJpZCI7aToxMzQ7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE0OiJTdG9jayBUcmFuc2ZlciI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtzOjE5OiJmYXMgZmEtc2hhcmUtc3F1YXJlIjtzOjM6InVybCI7czo4OiJ0cmFuc2ZlciI7czo1OiJvcmRlciI7aTo1O3M6OToicGFyZW50X2lkIjtOO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDExOjM2OjU5IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTMwIDExOjE2OjE1Ijt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6ODoiACoAZGF0ZXMiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToyOntzOjEwOiJtb2R1bGVfYXNtIjtPOjM5OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XENvbGxlY3Rpb24iOjE6e3M6ODoiACoAaXRlbXMiO2E6MTp7aTowO086MjA6IkFwcFxNb2RlbHNcQVNNTW9kdWxlIjoyODp7czo4OiIAKgB0YWJsZSI7czoxMDoiYXNtX21vZHVsZSI7czoxMToiACoAZmlsbGFibGUiO2E6Mjp7aTowO3M6OToibW9kdWxlX2lkIjtpOjE7czo2OiJhc21faWQiO31zOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTo1OntzOjI6ImlkIjtpOjk7czo5OiJtb2R1bGVfaWQiO2k6MTM0O3M6NjoiYXNtX2lkIjtpOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMzozNTo1NSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMzozNTo1NSI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjU6e3M6MjoiaWQiO2k6OTtzOjk6Im1vZHVsZV9pZCI7aToxMzQ7czo2OiJhc21faWQiO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDEzOjM1OjU1IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDEzOjM1OjU1Ijt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6ODoiACoAZGF0ZXMiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoxMDoidGltZXN0YW1wcyI7YjoxO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319fX1zOjg6ImNoaWxkcmVuIjtPOjM5OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XENvbGxlY3Rpb24iOjE6e3M6ODoiACoAaXRlbXMiO2E6MDp7fX19czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoxMDoidGltZXN0YW1wcyI7YjoxO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319aTo1O086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjoyODp7czoxMToiACoAZmlsbGFibGUiO2E6OTp7aTowO3M6NzoibWVudV9pZCI7aToxO3M6NDoidHlwZSI7aToyO3M6MTE6Im1vZHVsZV9uYW1lIjtpOjM7czoxMzoiZGl2aWRlcl90aXRsZSI7aTo0O3M6MTA6Imljb25fY2xhc3MiO2k6NTtzOjM6InVybCI7aTo2O3M6NToib3JkZXIiO2k6NztzOjk6InBhcmVudF9pZCI7aTo4O3M6NjoidGFyZ2V0Ijt9czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxMjp7czoyOiJpZCI7aToxMzg7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjEyOiJTdG9jayBSZXR1cm4iO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7czoxNToiZmFzIGZhLXVuZG8tYWx0IjtzOjM6InVybCI7TjtzOjU6Im9yZGVyIjtpOjY7czo5OiJwYXJlbnRfaWQiO047czo2OiJ0YXJnZXQiO047czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMTo0MTo1NiI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0zMCAxMToxNjoxNSI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjEzODtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MTI6IlN0b2NrIFJldHVybiI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtzOjE1OiJmYXMgZmEtdW5kby1hbHQiO3M6MzoidXJsIjtOO3M6NToib3JkZXIiO2k6NjtzOjk6InBhcmVudF9pZCI7TjtzOjY6InRhcmdldCI7TjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDExOjQxOjU2IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTMwIDExOjE2OjE1Ijt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6ODoiACoAZGF0ZXMiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToyOntzOjEwOiJtb2R1bGVfYXNtIjtPOjM5OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XENvbGxlY3Rpb24iOjE6e3M6ODoiACoAaXRlbXMiO2E6MTp7aTowO086MjA6IkFwcFxNb2RlbHNcQVNNTW9kdWxlIjoyODp7czo4OiIAKgB0YWJsZSI7czoxMDoiYXNtX21vZHVsZSI7czoxMToiACoAZmlsbGFibGUiO2E6Mjp7aTowO3M6OToibW9kdWxlX2lkIjtpOjE7czo2OiJhc21faWQiO31zOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTo1OntzOjI6ImlkIjtpOjEwO3M6OToibW9kdWxlX2lkIjtpOjEzODtzOjY6ImFzbV9pZCI7aToxO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTM6MzU6NTUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTM6MzU6NTUiO31zOjExOiIAKgBvcmlnaW5hbCI7YTo1OntzOjI6ImlkIjtpOjEwO3M6OToibW9kdWxlX2lkIjtpOjEzODtzOjY6ImFzbV9pZCI7aToxO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTM6MzU6NTUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTM6MzU6NTUiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czo4OiIAKgBkYXRlcyI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX19fXM6ODoiY2hpbGRyZW4iO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6MTp7czo4OiIAKgBpdGVtcyI7YToyOntpOjA7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjI4OntzOjExOiIAKgBmaWxsYWJsZSI7YTo5OntpOjA7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtpOjI7czoxMToibW9kdWxlX25hbWUiO2k6MztzOjEzOiJkaXZpZGVyX3RpdGxlIjtpOjQ7czoxMDoiaWNvbl9jbGFzcyI7aTo1O3M6MzoidXJsIjtpOjY7czo1OiJvcmRlciI7aTo3O3M6OToicGFyZW50X2lkIjtpOjg7czo2OiJ0YXJnZXQiO31zOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjEyOntzOjI6ImlkIjtpOjEzOTtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6NjoiUmV0dXJuIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6NjoicmV0dXJuIjtzOjU6Im9yZGVyIjtpOjE7czo5OiJwYXJlbnRfaWQiO2k6MTM4O3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDExOjQyOjIxIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDExOjQ1OjI5Ijt9czoxMToiACoAb3JpZ2luYWwiO2E6MTI6e3M6MjoiaWQiO2k6MTM5O3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czo2OiJSZXR1cm4iO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7TjtzOjM6InVybCI7czo2OiJyZXR1cm4iO3M6NToib3JkZXIiO2k6MTtzOjk6InBhcmVudF9pZCI7aToxMzg7czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6NDI6MjEiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6NDU6MjkiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czo4OiIAKgBkYXRlcyI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6ODoiY2hpbGRyZW4iO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6MTp7czo4OiIAKgBpdGVtcyI7YTowOnt9fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX1pOjE7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjI4OntzOjExOiIAKgBmaWxsYWJsZSI7YTo5OntpOjA7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtpOjI7czoxMToibW9kdWxlX25hbWUiO2k6MztzOjEzOiJkaXZpZGVyX3RpdGxlIjtpOjQ7czoxMDoiaWNvbl9jbGFzcyI7aTo1O3M6MzoidXJsIjtpOjY7czo1OiJvcmRlciI7aTo3O3M6OToicGFyZW50X2lkIjtpOjg7czo2OiJ0YXJnZXQiO31zOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjEyOntzOjI6ImlkIjtpOjE0MDtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MTg6Ik1hbmFnZSBTYWxlIFJldHVybiI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtzOjExOiJzYWxlLXJldHVybiI7czo1OiJvcmRlciI7aToyO3M6OToicGFyZW50X2lkIjtpOjEzODtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMTo0MzoxNiI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMTo0NTozNCI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjE0MDtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MTg6Ik1hbmFnZSBTYWxlIFJldHVybiI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtzOjExOiJzYWxlLXJldHVybiI7czo1OiJvcmRlciI7aToyO3M6OToicGFyZW50X2lkIjtpOjEzODtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMTo0MzoxNiI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMTo0NTozNCI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo4OiJjaGlsZHJlbiI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoxOntzOjg6IgAqAGl0ZW1zIjthOjA6e319fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fX19fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fWk6NjtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6Mjg6e3M6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO2k6MjtzOjExOiJtb2R1bGVfbmFtZSI7aTozO3M6MTM6ImRpdmlkZXJfdGl0bGUiO2k6NDtzOjEwOiJpY29uX2NsYXNzIjtpOjU7czozOiJ1cmwiO2k6NjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO2k6ODtzOjY6InRhcmdldCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6MTI4O3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czo4OiJDdXN0b21lciI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtzOjE2OiJmYXIgZmEtaGFuZHNoYWtlIjtzOjM6InVybCI7TjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO047czo2OiJ0YXJnZXQiO047czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMTozMDoxNCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0zMCAxMToxNjoxNSI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjEyODtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6ODoiQ3VzdG9tZXIiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7czoxNjoiZmFyIGZhLWhhbmRzaGFrZSI7czozOiJ1cmwiO047czo1OiJvcmRlciI7aTo3O3M6OToicGFyZW50X2lkIjtOO3M6NjoidGFyZ2V0IjtOO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6MzA6MTQiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMzAgMTE6MTY6MTUiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czo4OiIAKgBkYXRlcyI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjI6e3M6MTA6Im1vZHVsZV9hc20iO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6MTp7czo4OiIAKgBpdGVtcyI7YToxOntpOjA7TzoyMDoiQXBwXE1vZGVsc1xBU01Nb2R1bGUiOjI4OntzOjg6IgAqAHRhYmxlIjtzOjEwOiJhc21fbW9kdWxlIjtzOjExOiIAKgBmaWxsYWJsZSI7YToyOntpOjA7czo5OiJtb2R1bGVfaWQiO2k6MTtzOjY6ImFzbV9pZCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjU6e3M6MjoiaWQiO2k6MTM7czo5OiJtb2R1bGVfaWQiO2k6MTI4O3M6NjoiYXNtX2lkIjtpOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMzozNTo1NSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMzozNTo1NSI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjU6e3M6MjoiaWQiO2k6MTM7czo5OiJtb2R1bGVfaWQiO2k6MTI4O3M6NjoiYXNtX2lkIjtpOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMzozNTo1NSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMzozNTo1NSI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fX19czo4OiJjaGlsZHJlbiI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoxOntzOjg6IgAqAGl0ZW1zIjthOjU6e2k6MDtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6Mjg6e3M6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO2k6MjtzOjExOiJtb2R1bGVfbmFtZSI7aTozO3M6MTM6ImRpdmlkZXJfdGl0bGUiO2k6NDtzOjEwOiJpY29uX2NsYXNzIjtpOjU7czozOiJ1cmwiO2k6NjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO2k6ODtzOjY6InRhcmdldCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6MTI5O3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czoxNToiTWFuYWdlIEN1c3RvbWVyIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6ODoiY3VzdG9tZXIiO3M6NToib3JkZXIiO2k6MTtzOjk6InBhcmVudF9pZCI7aToxMjg7czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6MzA6NTMiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6MzM6NDEiO31zOjExOiIAKgBvcmlnaW5hbCI7YToxMjp7czoyOiJpZCI7aToxMjk7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE1OiJNYW5hZ2UgQ3VzdG9tZXIiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7TjtzOjM6InVybCI7czo4OiJjdXN0b21lciI7czo1OiJvcmRlciI7aToxO3M6OToicGFyZW50X2lkIjtpOjEyODtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMTozMDo1MyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMTozMzo0MSI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo4OiJjaGlsZHJlbiI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoxOntzOjg6IgAqAGl0ZW1zIjthOjA6e319fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fWk6MTtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6Mjg6e3M6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO2k6MjtzOjExOiJtb2R1bGVfbmFtZSI7aTozO3M6MTM6ImRpdmlkZXJfdGl0bGUiO2k6NDtzOjEwOiJpY29uX2NsYXNzIjtpOjU7czozOiJ1cmwiO2k6NjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO2k6ODtzOjY6InRhcmdldCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6MTMwO3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czoxNToiQ3VzdG9tZXIgTGVkZ2VyIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MTU6ImN1c3RvbWVyLWxlZGdlciI7czo1OiJvcmRlciI7aToyO3M6OToicGFyZW50X2lkIjtpOjEyODtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMTozMTozMyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMTozMzo1MSI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjEzMDtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MTU6IkN1c3RvbWVyIExlZGdlciI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtzOjE1OiJjdXN0b21lci1sZWRnZXIiO3M6NToib3JkZXIiO2k6MjtzOjk6InBhcmVudF9pZCI7aToxMjg7czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6MzE6MzMiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6MzM6NTEiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czo4OiIAKgBkYXRlcyI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6ODoiY2hpbGRyZW4iO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6MTp7czo4OiIAKgBpdGVtcyI7YTowOnt9fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX1pOjI7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjI4OntzOjExOiIAKgBmaWxsYWJsZSI7YTo5OntpOjA7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtpOjI7czoxMToibW9kdWxlX25hbWUiO2k6MztzOjEzOiJkaXZpZGVyX3RpdGxlIjtpOjQ7czoxMDoiaWNvbl9jbGFzcyI7aTo1O3M6MzoidXJsIjtpOjY7czo1OiJvcmRlciI7aTo3O3M6OToicGFyZW50X2lkIjtpOjg7czo2OiJ0YXJnZXQiO31zOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjEyOntzOjI6ImlkIjtpOjEzMTtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MTU6IkNyZWRpdCBDdXN0b21lciI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtzOjE1OiJjcmVkaXQtY3VzdG9tZXIiO3M6NToib3JkZXIiO2k6MztzOjk6InBhcmVudF9pZCI7aToxMjg7czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6MzI6MDEiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6MzM6NTQiO31zOjExOiIAKgBvcmlnaW5hbCI7YToxMjp7czoyOiJpZCI7aToxMzE7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE1OiJDcmVkaXQgQ3VzdG9tZXIiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7TjtzOjM6InVybCI7czoxNToiY3JlZGl0LWN1c3RvbWVyIjtzOjU6Im9yZGVyIjtpOjM7czo5OiJwYXJlbnRfaWQiO2k6MTI4O3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDExOjMyOjAxIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDExOjMzOjU0Ijt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6ODoiACoAZGF0ZXMiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjg6ImNoaWxkcmVuIjtPOjM5OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XENvbGxlY3Rpb24iOjE6e3M6ODoiACoAaXRlbXMiO2E6MDp7fX19czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoxMDoidGltZXN0YW1wcyI7YjoxO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319aTozO086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjoyODp7czoxMToiACoAZmlsbGFibGUiO2E6OTp7aTowO3M6NzoibWVudV9pZCI7aToxO3M6NDoidHlwZSI7aToyO3M6MTE6Im1vZHVsZV9uYW1lIjtpOjM7czoxMzoiZGl2aWRlcl90aXRsZSI7aTo0O3M6MTA6Imljb25fY2xhc3MiO2k6NTtzOjM6InVybCI7aTo2O3M6NToib3JkZXIiO2k6NztzOjk6InBhcmVudF9pZCI7aTo4O3M6NjoidGFyZ2V0Ijt9czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxMjp7czoyOiJpZCI7aToxMzI7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjEzOiJQYWlkIEN1c3RvbWVyIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MTM6InBhaWQtY3VzdG9tZXIiO3M6NToib3JkZXIiO2k6NDtzOjk6InBhcmVudF9pZCI7aToxMjg7czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6MzI6MjkiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6MzQ6MDUiO31zOjExOiIAKgBvcmlnaW5hbCI7YToxMjp7czoyOiJpZCI7aToxMzI7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjEzOiJQYWlkIEN1c3RvbWVyIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MTM6InBhaWQtY3VzdG9tZXIiO3M6NToib3JkZXIiO2k6NDtzOjk6InBhcmVudF9pZCI7aToxMjg7czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6MzI6MjkiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTE6MzQ6MDUiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31z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MjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxMjp7czoyOiJpZCI7aToxNzM7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjIzOiJNb2JpbGUgQmFuayBUcmFuc2FjdGlvbiI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtzOjIzOiJtb2JpbGUtYmFuay10cmFuc2FjdGlvbiI7czo1OiJvcmRlciI7aToyO3M6OToicGFyZW50X2lkIjtpOjE3MTtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0yOSAwOTo1MTozNyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0yOSAwOTo1Mjo0MyI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjE3MztzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MjM6Ik1vYmlsZSBCYW5rIFRyYW5zYWN0aW9uIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MjM6Im1vYmlsZS1iYW5rLXRyYW5zYWN0aW9uIjtzOjU6Im9yZGVyIjtpOjI7czo5OiJwYXJlbnRfaWQiO2k6MTcxO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTI5IDA5OjUxOjM3IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTI5IDA5OjUyOjQzIjt9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IjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxMjp7czoyOiJpZCI7aToxNTY7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjIxOiJDdXN0b21lciBSZWNlaXB0IExpc3QiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7TjtzOjM6InVybCI7czoyMToiY3VzdG9tZXItcmVjZWlwdC1saXN0IjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO2k6MTUyO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTIzIDIyOjAzOjQ5IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTMwIDExOjE1OjU3Ijt9czoxMToiACoAb3JpZ2luYWwiO2E6MTI6e3M6MjoiaWQiO2k6MTU2O3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czoyMToiQ3VzdG9tZXIgUmVjZWlwdCBMaXN0IjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MjE6ImN1c3RvbWVyLXJlY2VpcHQtbGlzdCI7czo1OiJvcmRlciI7aTo3O3M6OToicGFyZW50X2lkIjtpOjE1MjtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0yMyAyMjowMzo0OSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0zMCAxMToxNTo1NyI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7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AHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjEyOntzOjI6ImlkIjtpOjE2NTtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MTc6IldhcmVob3VzZSBTdW1tYXJ5IjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MTc6IndhcmVob3VzZS1zdW1tYXJ5IjtzOjU6Im9yZGVyIjtpOjE1O3M6OToicGFyZW50X2lkIjtpOjE1MjtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0yMyAyMjoxMTozOCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOS0wNiAxMDowNDo1OSI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjE2NTtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MTc6IldhcmVob3VzZSBTdW1tYXJ5IjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MTc6IndhcmVob3VzZS1zdW1tYXJ5IjtzOjU6Im9yZGVyIjtpOjE1O3M6OToicGFyZW50X2lkIjtpOjE1MjtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0yMyAyMjoxMTozOCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOS0wNiAxMDowNDo1OSI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo4OiJjaGlsZHJlbiI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoxOntzOjg6IgAqAGl0ZW1zIjthOjA6e319fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fWk6MTU7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjI4OntzOjExOiIAKgBmaWxsYWJsZSI7YTo5OntpOjA7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtpOjI7czoxMToibW9kdWxlX25hbWUiO2k6MztzOjEzOiJkaXZpZGVyX3RpdGxlIjtpOjQ7czoxMDoiaWNvbl9jbGFzcyI7aTo1O3M6MzoidXJsIjtpOjY7czo1OiJvcmRlciI7aTo3O3M6OToicGFyZW50X2lkIjtpOjg7czo2OiJ0YXJnZXQiO31zOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjEyOntzOjI6ImlkIjtpOjE2NjtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MjI6IkNvdXBvbiBSZWNlaXZlZCBSZXBvcnQiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7TjtzOjM6InVybCI7czoyMjoiY291cG9uLXJlY2VpdmVkLXJlcG9ydCI7czo1OiJvcmRlciI7aToxNjtzOjk6InBhcmVudF9pZCI7aToxNTI7czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMjMgMjI6MjY6MjQiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDktMDYgMTA6MDQ6NTkiO31zOjExOiIAKgBvcmlnaW5hbCI7YToxMjp7czoyOiJpZCI7aToxNjY7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjIyOiJDb3Vwb24gUmVjZWl2ZWQgUmVwb3J0IjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MjI6ImNvdXBvbi1yZWNlaXZlZC1yZXBvcnQiO3M6NToib3JkZXIiO2k6MTY7czo5OiJwYXJlbnRfaWQiO2k6MTUyO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTIzIDIyOjI2OjI0IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA5LTA2IDEwOjA0OjU5Ijt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6ODoiACoAZGF0ZXMiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjg6ImNoaWxkcmVuIjtPOjM5OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XENvbGxlY3Rpb24iOjE6e3M6ODoiACoAaXRlbXMiO2E6MDp7fX19czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoxMDoidGltZXN0YW1wcyI7YjoxO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319fX19czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoxMDoidGltZXN0YW1wcyI7YjoxO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319aToxMTtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6Mjg6e3M6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO2k6MjtzOjExOiJtb2R1bGVfbmFtZSI7aTozO3M6MTM6ImRpdmlkZXJfdGl0bGUiO2k6NDtzOjEwOiJpY29uX2NsYXNzIjtpOjU7czozOiJ1cmwiO2k6NjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO2k6ODtzOjY6InRhcmdldCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6MTQ1O3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czo5OiJNYW5hZ2UgU1IiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7czoxODoiZmFzIGZhLXVzZXItc2VjcmV0IjtzOjM6InVybCI7czoyMDoic2FsZXMtcmVwcmVzZW50YXRpdmUiO3M6NToib3JkZXIiO2k6MTI7czo5OiJwYXJlbnRfaWQiO047czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTM6NTc6NDQiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMzAgMTE6MTU6NTciO31zOjExOiIAKgBvcmlnaW5hbCI7YToxMjp7czoyOiJpZCI7aToxNDU7czo3OiJtZW51X2lkIjtpOjI7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjk6Ik1hbmFnZSBTUiI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtzOjE4OiJmYXMgZmEtdXNlci1zZWNyZXQiO3M6MzoidXJsIjtzOjIwOiJzYWxlcy1yZXByZXNlbnRhdGl2ZSI7czo1OiJvcmRlciI7aToxMjtzOjk6InBhcmVudF9pZCI7TjtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMzo1Nzo0NCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0zMCAxMToxNTo1NyI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6Mjp7czoxMDoibW9kdWxlX2FzbSI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoxOntzOjg6IgAqAGl0ZW1zIjthOjE6e2k6MDtPOjIwOiJBcHBcTW9kZWxzXEFTTU1vZHVsZSI6Mjg6e3M6ODoiACoAdGFibGUiO3M6MTA6ImFzbV9tb2R1bGUiO3M6MTE6IgAqAGZpbGxhYmxlIjthOjI6e2k6MDtzOjk6Im1vZHVsZV9pZCI7aToxO3M6NjoiYXNtX2lkIjt9czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6NTp7czoyOiJpZCI7aToxOTtzOjk6Im1vZHVsZV9pZCI7aToxNDU7czo2OiJhc21faWQiO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDE0OjA0OjAyIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDE0OjA0OjAyIjt9czoxMToiACoAb3JpZ2luYWwiO2E6NTp7czoyOiJpZCI7aToxOTtzOjk6Im1vZHVsZV9pZCI7aToxNDU7czo2OiJhc21faWQiO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDE0OjA0OjAyIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDE0OjA0OjAyIjt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6ODoiACoAZGF0ZXMiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoxMDoidGltZXN0YW1wcyI7YjoxO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319fX1zOjg6ImNoaWxkcmVuIjtPOjM5OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XENvbGxlY3Rpb24iOjE6e3M6ODoiACoAaXRlbXMiO2E6MDp7fX19czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoxMDoidGltZXN0YW1wcyI7YjoxO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319aToxMjtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6Mjg6e3M6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO2k6MjtzOjExOiJtb2R1bGVfbmFtZSI7aTozO3M6MTM6ImRpdmlkZXJfdGl0bGUiO2k6NDtzOjEwOiJpY29uX2NsYXNzIjtpOjU7czozOiJ1cmwiO2k6NjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO2k6ODtzOjY6InRhcmdldCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6MTQxO3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czo4OiJMb2NhdGlvbiI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtzOjIxOiJmYXMgZmEtbWFwLW1hcmtlci1hbHQiO3M6MzoidXJsIjtOO3M6NToib3JkZXIiO2k6MTM7czo5OiJwYXJlbnRfaWQiO047czo2OiJ0YXJnZXQiO047czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxMzo1MDoyOSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0zMCAxMToxNTo1NyI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjE0MTtzOjc6Im1lbnVfaWQiO2k6MjtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6ODoiTG9jYXRpb24iO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7czoyMToiZmFzIGZhLW1hcC1tYXJrZXItYWx0IjtzOjM6InVybCI7TjtzOjU6Im9yZGVyIjtpOjEzO3M6OToicGFyZW50X2lkIjtOO3M6NjoidGFyZ2V0IjtOO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMTYgMTM6NTA6MjkiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDgtMzAgMTE6MTU6NTciO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czo4OiIAKgBkYXRlcyI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjI6e3M6MTA6Im1vZHVsZV9hc20iO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6MTp7czo4OiIAKgBpdGVtcyI7YToxOntpOjA7TzoyMDoiQXBwXE1vZGVsc1xBU01Nb2R1bGUiOjI4OntzOjg6IgAqAHRhYmxlIjtzOjEwOiJhc21fbW9kdWxlIjtzOjExOiIAKgBmaWxsYWJsZSI7YToyOntpOjA7czo5OiJtb2R1bGVfaWQiO2k6MTtzOjY6ImFzbV9pZCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjU6e3M6MjoiaWQiO2k6MjA7czo5OiJtb2R1bGVfaWQiO2k6MTQxO3M6NjoiYXNtX2lkIjtpOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxNDowNDowMiI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxNDowNDowMiI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjU6e3M6MjoiaWQiO2k6MjA7czo5OiJtb2R1bGVfaWQiO2k6MTQxO3M6NjoiYXNtX2lkIjtpOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxNDowNDowMiI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0xNiAxNDowNDowMiI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fX19czo4OiJjaGlsZHJlbiI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoxOntzOjg6IgAqAGl0ZW1zIjthOjM6e2k6MDtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6Mjg6e3M6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO2k6MjtzOjExOiJtb2R1bGVfbmFtZSI7aTozO3M6MTM6ImRpdmlkZXJfdGl0bGUiO2k6NDtzOjEwOiJpY29uX2NsYXNzIjtpOjU7czozOiJ1cmwiO2k6NjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO2k6ODtzOjY6InRhcmdldCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6MTQyO3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czoxNDoiTWFuYWdlIFVwYXppbGEiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7TjtzOjM6InVybCI7czo3OiJ1cGF6aWxhIjtzOjU6Im9yZGVyIjtpOjE7czo5OiJwYXJlbnRfaWQiO2k6MTQxO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDEzOjUxOjAxIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDEzOjUxOjU4Ijt9czoxMToiACoAb3JpZ2luYWwiO2E6MTI6e3M6MjoiaWQiO2k6MTQyO3M6NzoibWVudV9pZCI7aToyO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czoxNDoiTWFuYWdlIFVwYXppbGEiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7TjtzOjM6InVybCI7czo3OiJ1cGF6aWxhIjtzOjU6Im9yZGVyIjtpOjE7czo5OiJwYXJlbnRfaWQiO2k6MTQxO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDEzOjUxOjAxIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTE2IDEzOjUxOjU4Ijt9czox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aGVzIjthOjA6e31zOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX19fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX19fXM6MTU6InVzZXJfcGVybWlzc2lvbiI7YTo3NTp7aTowO3M6MTY6ImRhc2hib2FyZC1hY2Nlc3MiO2k6MTtzOjE0OiJwcm9kdWN0LWFjY2VzcyI7aToyO3M6Mjc6InByb2R1Y3Qtc3RvY2stcmVwb3J0LWFjY2VzcyI7aTozO3M6MTU6ImN1c3RvbWVyLWFjY2VzcyI7aTo0O3M6MTI6ImN1c3RvbWVyLWFkZCI7aTo1O3M6MTM6ImN1c3RvbWVyLWVkaXQiO2k6NjtzOjEzOiJjdXN0b21lci12aWV3IjtpOjc7czoxNToiY3VzdG9tZXItZGVsZXRlIjtpOjg7czoyMjoiY3VzdG9tZXItZXhwb3J0LWJ1dHRvbiI7aTo5O3M6MjI6ImN1c3RvbWVyLWxlZGdlci1hY2Nlc3MiO2k6MTA7czoyMjoiY3JlZGl0LWN1c3RvbWVyLWFjY2VzcyI7aToxMTtzOjIwOiJwYWlkLWN1c3RvbWVyLWFjY2VzcyI7aToxMjtzOjIzOiJjdXN0b21lci1hZHZhbmNlLWFjY2VzcyI7aToxMztzOjIwOiJjdXN0b21lci1hZHZhbmNlLWFkZCI7aToxNDtzOjIxOiJjdXN0b21lci1hZHZhbmNlLWVkaXQiO2k6MTU7czoyMzoiY3VzdG9tZXItYWR2YW5jZS1kZWxldGUiO2k6MTY7czozMDoiY3VzdG9tZXItYWR2YW5jZS1leHBvcnQtYnV0dG9uIjtpOjE3O3M6MjE6InN0b2NrLXRyYW5zZmVyLWFjY2VzcyI7aToxODtzOjI4OiJzdG9jay10cmFuc2Zlci1leHBvcnQtYnV0dG9uIjtpOjE5O3M6MTE6InNhbGUtYWNjZXNzIjtpOjIwO3M6ODoic2FsZS1hZGQiO2k6MjE7czo5OiJzYWxlLWVkaXQiO2k6MjI7czo5OiJzYWxlLXZpZXciO2k6MjM7czoxMToic2FsZS1kZWxldGUiO2k6MjQ7czoxODoic2FsZS1leHBvcnQtYnV0dG9uIjtpOjI1O3M6MTM6InJldHVybi1hY2Nlc3MiO2k6MjY7czoxODoic2FsZS1yZXR1cm4tYWNjZXNzIjtpOjI3O3M6MTQ6InVwYXppbGEtYWNjZXNzIjtpOjI4O3M6MTE6InVwYXppbGEtYWRkIjtpOjI5O3M6MTI6InVwYXppbGEtZWRpdCI7aTozMDtzOjE0OiJ1cGF6aWxhLWRlbGV0ZSI7aTozMTtzOjIxOiJ1cGF6aWxhLWV4cG9ydC1idXR0b24iO2k6MzI7czoxMjoicm91dGUtYWNjZXNzIjtpOjMzO3M6OToicm91dGUtYWRkIjtpOjM0O3M6MTA6InJvdXRlLWVkaXQiO2k6MzU7czoxMjoicm91dGUtZGVsZXRlIjtpOjM2O3M6MTk6InJvdXRlLWV4cG9ydC1idXR0b24iO2k6Mzc7czoxMToiYXJlYS1hY2Nlc3MiO2k6Mzg7czo4OiJhcmVhLWFkZCI7aTozOTtzOjk6ImFyZWEtZWRpdCI7aTo0MDtzOjExOiJhcmVhLWRlbGV0ZSI7aTo0MTtzOjE4OiJhcmVhLWV4cG9ydC1idXR0b24iO2k6NDI7czo5OiJzci1hY2Nlc3MiO2k6NDM7czoxNjoic3ItZXhwb3J0LWJ1dHRvbiI7aTo0NDtzOjc6InNyLXZpZXciO2k6NDU7czoxOToiZXhwZW5zZS1pdGVtLWFjY2VzcyI7aTo0NjtzOjE2OiJleHBlbnNlLWl0ZW0tYWRkIjtpOjQ3O3M6MTc6ImV4cGVuc2UtaXRlbS1lZGl0IjtpOjQ4O3M6MTQ6ImV4cGVuc2UtYWNjZXNzIjtpOjQ5O3M6MTE6ImV4cGVuc2UtYWRkIjtpOjUwO3M6MTI6ImV4cGVuc2UtZWRpdCI7aTo1MTtzOjE0OiJleHBlbnNlLWRlbGV0ZSI7aTo1MjtzOjI0OiJleHBlbnNlLXN0YXRlbWVudC1hY2Nlc3MiO2k6NTM7czoxOToic2FsZXMtcmVwb3J0LWFjY2VzcyI7aTo1NDtzOjIzOiJpbnZlbnRvcnktcmVwb3J0LWFjY2VzcyI7aTo1NTtzOjMwOiJ0b2RheXMtY3VzdG9tZXItcmVjZWlwdC1hY2Nlc3MiO2k6NTY7czoyODoiY3VzdG9tZXItcmVjZWlwdC1saXN0LWFjY2VzcyI7aTo1NztzOjMzOiJzYWxlc21hbi13aXNlLXNhbGVzLXJlcG9ydC1hY2Nlc3MiO2k6NTg7czoxNzoiZHVlLXJlcG9ydC1hY2Nlc3MiO2k6NTk7czoyNzoic2hpcHBpbmctY29zdC1yZXBvcnQtYWNjZXNzIjtpOjYwO3M6MzI6InByb2R1Y3Qtd2lzZS1zYWxlcy1yZXBvcnQtYWNjZXNzIjtpOjYxO3M6MjA6ImRhbWFnZS1yZXBvcnQtYWNjZXNzIjtpOjYyO3M6MjQ6IndhcmVob3VzZS1leHBlbnNlLXJlcG9ydCI7aTo2MztzOjI0OiJjb2xsZWN0aW9uLXJlcG9ydC1hY2Nlc3MiO2k6NjQ7czoyNDoid2FyZWhvdXNlLXN1bW1hcnktYWNjZXNzIjtpOjY1O3M6Mjk6ImNvdXBvbi1yZWNlaXZlZC1yZXBvcnQtYWNjZXNzIjtpOjY2O3M6MTE6ImJhbmstYWNjZXNzIjtpOjY3O3M6MjM6ImJhbmstdHJhbnNhY3Rpb24tYWNjZXNzIjtpOjY4O3M6MTg6ImJhbmstbGVkZ2VyLWFjY2VzcyI7aTo2OTtzOjE4OiJtb2JpbGUtYmFuay1hY2Nlc3MiO2k6NzA7czozMDoibW9iaWxlLWJhbmstdHJhbnNhY3Rpb24tYWNjZXNzIjtpOjcxO3M6MjU6Im1vYmlsZS1iYW5rLWxlZGdlci1hY2Nlc3MiO2k6NzI7czoxNDoiY2xvc2luZy1hY2Nlc3MiO2k6NzM7czoyMToiY2xvc2luZy1yZXBvcnQtYWNjZXNzIjtpOjc0O3M6MjU6InRvZGF5LXNhbGVzLXJlcG9ydC1hY2Nlc3MiO319', 1630992276);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('uKo6yjOZdhgPuppocNLJQ2p5OfDCsWnjLtnzVfvj', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:92.0) Gecko/20100101 Firefox/92.0', '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eUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6NDA7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjIxOiJNYW5hZ2UgU3RvY2sgVHJhbnNmZXIiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7czoxOToiZmFzIGZhLXNoYXJlLXNxdWFyZSI7czozOiJ1cmwiO3M6ODoidHJhbnNmZXIiO3M6NToib3JkZXIiO2k6OTtzOjk6InBhcmVudF9pZCI7TjtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wNy0xMyAxMTo1NjoyMSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOS0wNiAxMDo1NDowMSI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjQwO3M6NzoibWVudV9pZCI7aToxO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czoyMToiTWFuYWdlIFN0b2NrIFRyYW5zZmVyIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO3M6MTk6ImZhcyBmYS1zaGFyZS1zcXVhcmUiO3M6MzoidXJsIjtzOjg6InRyYW5zZmVyIjtzOjU6Im9yZGVyIjtpOjk7czo5OiJwYXJlbnRfaWQiO047czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDctMTMgMTE6NTY6MjEiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDktMDYgMTA6NTQ6MDEiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czo4OiIAKgBkYXRlcyI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6ODoiY2hpbGRyZW4iO086MjY6IlR5cGlDTVNcTmVzdGFibGVDb2xsZWN0aW9uIjo3OntzOjg6IgAqAHRvdGFsIjtpOjA7czoxNToiACoAcGFyZW50Q29sdW1uIjtzOjk6InBhcmVudF9pZCI7czozMzoiACoAcmVtb3ZlSXRlbXNXaXRoTWlzc2luZ0FuY2VzdG9yIjtiOjE7czoxNDoiACoAaW5kZW50Q2hhcnMiO3M6ODoiwqDCoMKgwqAiO3M6MTU6IgAqAGNoaWxkcmVuTmFtZSI7czo1OiJpdGVtcyI7czoxNzoiACoAcGFyZW50UmVsYXRpb24iO3M6NjoicGFyZW50IjtzOjg6IgAqAGl0ZW1zIjthOjA6e319fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fWk6OTtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6Mjg6e3M6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO2k6MjtzOjExOiJtb2R1bGVfbmFtZSI7aTozO3M6MTM6ImRpdmlkZXJfdGl0bGUiO2k6NDtzOjEwOiJpY29uX2NsYXNzIjtpOjU7czozOiJ1cmwiO2k6NjtzOjU6Im9yZGVyIjtpOjc7czo5OiJwYXJlbnRfaWQiO2k6ODtzOjY6InRhcmdldCI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6NTE7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjEyOiJTdG9jayBSZXR1cm4iO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7czoxNToiZmFzIGZhLXVuZG8tYWx0IjtzOjM6InVybCI7TjtzOjU6Im9yZGVyIjtpOjEwO3M6OToicGFyZW50X2lkIjtOO3M6NjoidGFyZ2V0IjtOO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDctMTMgMTI6MTQ6NDYiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDktMDYgMTA6NTQ6MDEiO31zOjExOiIAKgBvcmlnaW5hbCI7YToxMjp7czoyOiJpZCI7aTo1MTtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MTI6IlN0b2NrIFJldHVybiI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtzOjE1OiJmYXMgZmEtdW5kby1hbHQiO3M6MzoidXJsIjtOO3M6NToib3JkZXIiO2k6MTA7czo5OiJwYXJlbnRfaWQiO047czo2OiJ0YXJnZXQiO047czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wNy0xMyAxMjoxNDo0NiI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOS0wNiAxMDo1NDowMSI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo4OiJjaGlsZHJlbiI7TzoyNjoiVHlwaUNNU1xOZXN0YWJsZUNvbGxlY3Rpb24iOjc6e3M6ODoiACoAdG90YWwiO2k6MztzOjE1OiIAKgBwYXJlbnRDb2x1bW4iO3M6OToicGFyZW50X2lkIjtzOjMzOiIAKgByZW1vdmVJdGVtc1dpdGhNaXNzaW5nQW5jZXN0b3IiO2I6MTtzOjE0OiIAKgBpbmRlbnRDaGFycyI7czo4OiLCoMKgwqDCoCI7czoxNToiACoAY2hpbGRyZW5OYW1lIjtzOjU6Iml0ZW1zIjtzOjE3OiIAKgBwYXJlbnRSZWxhdGlvbiI7czo2OiJwYXJlbnQiO3M6ODoiACoAaXRlbXMiO2E6Mzp7aTowO086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjoyODp7czoxMToiACoAZmlsbGFibGUiO2E6OTp7aTowO3M6NzoibWVudV9pZCI7aToxO3M6NDoidHlwZSI7aToyO3M6MTE6Im1vZHVsZV9uYW1lIjtpOjM7czoxMzoiZGl2aWRlcl90aXRsZSI7aTo0O3M6MTA6Imljb25fY2xhc3MiO2k6NTtzOjM6InVybCI7aTo2O3M6NToib3JkZXIiO2k6NztzOjk6InBhcmVudF9pZCI7aTo4O3M6NjoidGFyZ2V0Ijt9czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxMjp7czoyOiJpZCI7aTo1MjtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MTU6IlB1cmNoYXNlIFJldHVybiI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtzOjE1OiJwdXJjaGFzZS1yZXR1cm4iO3M6NToib3JkZXIiO2k6MTtzOjk6InBhcmVudF9pZCI7aTo1MTtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wNy0xMyAxMjoxNTozMyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOC0yOCAxNDozNDoyNCI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjUyO3M6NzoibWVudV9pZCI7aToxO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czoxNToiUHVyY2hhc2UgUmV0dXJuIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MTU6InB1cmNoYXNlLXJldHVybiI7czo1OiJvcmRlciI7aToxO3M6OToicGFyZW50X2lkIjtpOjUxO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA3LTEzIDEyOjE1OjMzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA4LTI4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ACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6OTE7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE2OiJNb2JpbGUgQmFuayBCb29rIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MTY6Im1vYmlsZS1iYW5rLWJvb2siO3M6NToib3JkZXIiO2k6NDtzOjk6InBhcmVudF9pZCI7aTo4NztzOjY6InRhcmdldCI7TjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTAzLTI3IDAxOjAwOjAwIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTAzLTI3IDAxOjAxOjQxIjt9czoxMToiACoAb3JpZ2luYWwiO2E6MTI6e3M6MjoiaWQiO2k6OTE7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE2OiJNb2JpbGUgQmFuayBCb29rIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MTY6Im1vYmlsZS1iYW5rLWJvb2siO3M6NToib3JkZXIiO2k6NDtzOjk6InBhcmVudF9pZCI7aTo4NztzOjY6InRhcmdldCI7TjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTAzLTI3IDAxOjAwOjAwIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTAzLTI3IDAxOjAxOjQx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IjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxMjp7czoyOiJpZCI7aToyMDI7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjI0OiJXYXJlaG91c2UgQ2xvc2luZyBSZXBvcnQiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7TjtzOjM6InVybCI7czoyNDoid2FyZWhvdXNlLWNsb3NpbmctcmVwb3J0IjtzOjU6Im9yZGVyIjtpOjM7czo5OiJwYXJlbnRfaWQiO2k6MTc5O3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA5LTA3IDE1OjE4OjQ1IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA5LTA3IDE1OjE5OjExIjt9czoxMToiACoAb3JpZ2luYWwiO2E6MTI6e3M6MjoiaWQiO2k6MjAyO3M6NzoibWVudV9pZCI7aToxO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czoyNDoiV2FyZWhvdXNlIENsb3NpbmcgUmVwb3J0IjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO047czozOiJ1cmwiO3M6MjQ6IndhcmVob3VzZS1jbG9zaW5nLXJlcG9ydCI7czo1OiJvcmRlciI7aTozO3M6OToicGFyZW50X2lkIjtpOjE3OTtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOS0wNyAxNToxODo0NSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOS0wNyAxNToxOToxMSI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoi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czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxMjp7czoyOiJpZCI7aToxOTI7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjI0OiJXYXJlaG91c2UgRXhwZW5zZSBSZXBvcnQiO3M6MTM6ImRpdmlkZXJfdGl0bGUiO047czoxMDoiaWNvbl9jbGFzcyI7TjtzOjM6InVybCI7czoyNDoid2FyZWhvdXNlLWV4cGVuc2UtcmVwb3J0IjtzOjU6Im9yZGVyIjtpOjE0O3M6OToicGFyZW50X2lkIjtpOjE3OTtzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wOS0wNiAxMDoxMjo0MiI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wOS0wNyAxNToxOToxMiI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjE5MjtzOjc6Im1lbnVfaWQiO2k6MTtzOjQ6InR5cGUiO3M6MToiMiI7czoxMToibW9kdWxlX25hbWUiO3M6MjQ6IldhcmVob3VzZSBFeHBlbnNlIFJlcG9ydCI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtOO3M6MzoidXJsIjtzOjI0OiJ3YXJlaG91c2UtZXhwZW5zZS1yZXBvcnQiO3M6NToib3JkZXIiO2k6MTQ7czo5OiJwYXJlbnRfaWQiO2k6MTc5O3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTA5LTA2IDEwOjEyOjQyIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTA5LTA3IDE1OjE5OjEyIjt9czoxMDoiACoAY2hhbmdl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fX19czoxNToidXNlcl9wZXJtaXNzaW9uIjthOjM2MDp7aTowO3M6MTY6ImRhc2hib2FyZC1hY2Nlc3MiO2k6MTtzOjExOiJ1c2VyLWFjY2VzcyI7aToyO3M6ODoidXNlci1hZGQiO2k6MztzOjk6InVzZXItZWRpdCI7aTo0O3M6OToidXNlci12aWV3IjtpOjU7czoxMToidXNlci1kZWxldGUiO2k6NjtzOjE2OiJ1c2VyLWJ1bGstZGVsZXRlIjtpOjc7czoxMToidXNlci1yZXBvcnQiO2k6ODtzOjExOiJyb2xlLWFjY2VzcyI7aTo5O3M6ODoicm9sZS1hZGQiO2k6MTA7czo5OiJyb2xlLWVkaXQiO2k6MTE7czo5OiJyb2xlLXZpZXciO2k6MTI7czoxMToicm9sZS1kZWxldGUiO2k6MTM7czoxNjoicm9sZS1idWxrLWRlbGV0ZSI7aToxNDtzOjExOiJyb2xlLXJlcG9ydCI7aToxNTtzOjExOiJtZW51LWFjY2VzcyI7aToxNjtzOjg6Im1lbnUtYWRkIjtpOjE3O3M6OToibWVudS1lZGl0IjtpOjE4O3M6MTE6Im1lbnUtZGVsZXRlIjtpOjE5O3M6MTY6Im1lbnUtYnVsay1kZWxldGUiO2k6MjA7czoxMToibWVudS1yZXBvcnQiO2k6MjE7czoxOToibWVudS1idWlsZGVyLWFjY2VzcyI7aToyMjtzOjE1OiJtZW51LW1vZHVsZS1hZGQiO2k6MjM7czoxNjoibWVudS1tb2R1bGUtZWRpdCI7aToyNDtzOjE4OiJtZW51LW1vZHVsZS1kZWxldGUiO2k6MjU7czoxNzoicGVybWlzc2lvbi1hY2Nlc3MiO2k6MjY7czoxNDoicGVybWlzc2lvbi1hZGQiO2k6Mjc7czoxNToicGVybWlzc2lvbi1lZGl0IjtpOjI4O3M6MTc6InBlcm1pc3Npb24tZGVsZXRlIjtpOjI5O3M6MjI6InBlcm1pc3Npb24tYnVsay1kZWxldGUiO2k6MzA7czoxNzoicGVybWlzc2lvbi1yZXBvcnQiO2k6MzE7czoxNjoid2FyZWhvdXNlLWFjY2VzcyI7aTozMjtzOjEzOiJ3YXJlaG91c2UtYWRkIjtpOjMzO3M6MTQ6IndhcmVob3VzZS1lZGl0IjtpOjM0O3M6MTY6IndhcmVob3VzZS1kZWxldGUiO2k6MzU7czoyMToid2FyZWhvdXNlLWJ1bGstZGVsZXRlIjtpOjM2O3M6MTY6IndhcmVob3VzZS1yZXBvcnQiO2k6Mzc7czoyMjoiZ2VuZXJhbC1zZXR0aW5nLWFjY2VzcyI7aTozODtzOjIxOiJjdXN0b21lci1ncm91cC1hY2Nlc3MiO2k6Mzk7czoxODoiY3VzdG9tZXItZ3JvdXAtYWRkIjtpOjQwO3M6MTk6ImN1c3RvbWVyLWdyb3VwLWVkaXQiO2k6NDE7czoyMToiY3VzdG9tZXItZ3JvdXAtZGVsZXRlIjtpOjQyO3M6MjY6ImN1c3RvbWVyLWdyb3VwLWJ1bGstZGVsZXRlIjtpOjQzO3M6MjE6ImN1c3RvbWVyLWdyb3VwLXJlcG9ydCI7aTo0NDtzOjExOiJ1bml0LWFjY2VzcyI7aTo0NTtzOjg6InVuaXQtYWRkIjtpOjQ2O3M6OToidW5pdC1lZGl0IjtpOjQ3O3M6MTE6InVuaXQtZGVsZXRlIjtpOjQ4O3M6MTY6InVuaXQtYnVsay1kZWxldGUiO2k6NDk7czoxMToidW5pdC1yZXBvcnQiO2k6NTA7czoxMDoidGF4LWFjY2VzcyI7aTo1MTtzOjc6InRheC1hZGQiO2k6NTI7czo4OiJ0YXgtZWRpdCI7aTo1MztzOjEwOiJ0YXgtZGVsZXRlIjtpOjU0O3M6MTU6InRheC1idWxrLWRlbGV0ZSI7aTo1NTtzOjEwOiJ0YXgtcmVwb3J0IjtpOjU2O3M6MjQ6Im1hdGVyaWFsLWNhdGVnb3J5LWFjY2VzcyI7aTo1NztzOjIxOiJtYXRlcmlhbC1jYXRlZ29yeS1hZGQiO2k6NTg7czoyMjoibWF0ZXJpYWwtY2F0ZWdvcnktZWRpdCI7aTo1OTtzOjI0OiJtYXRlcmlhbC1jYXRlZ29yeS1kZWxldGUiO2k6NjA7czoyOToibWF0ZXJpYWwtY2F0ZWdvcnktYnVsay1kZWxldGUiO2k6NjE7czoyNDoibWF0ZXJpYWwtY2F0ZWdvcnktcmVwb3J0IjtpOjYyO3M6MTU6Im1hdGVyaWFsLWFjY2VzcyI7aTo2MztzOjEyOiJtYXRlcmlhbC1hZGQiO2k6NjQ7czoxMzoibWF0ZXJpYWwtZWRpdCI7aTo2NTtzOjEzOiJtYXRlcmlhbC12aWV3IjtpOjY2O3M6MTU6Im1hdGVyaWFsLWRlbGV0ZSI7aTo2NztzOjIwOiJtYXRlcmlhbC1idWxrLWRlbGV0ZSI7aTo2ODtzOjE1OiJtYXRlcmlhbC1yZXBvcnQiO2k6Njk7czoyODoibWF0ZXJpYWwtc3RvY2stcmVwb3J0LWFjY2VzcyI7aTo3MDtzOjE1OiJwdXJjaGFzZS1hY2Nlc3MiO2k6NzE7czoxMjoicHVyY2hhc2UtYWRkIjtpOjcyO3M6MTM6InB1cmNoYXNlLWVkaXQiO2k6NzM7czoxMzoicHVyY2hhc2UtdmlldyI7aTo3NDtzOjE1OiJwdXJjaGFzZS1kZWxldGUiO2k6NzU7czoyMDoicHVyY2hhc2UtYnVsay1kZWxldGUiO2k6NzY7czoxNToicHVyY2hhc2UtcmVwb3J0IjtpOjc3O3M6MjM6InByb2R1Y3QtY2F0ZWdvcnktYWNjZXNzIjtpOjc4O3M6MjA6InByb2R1Y3QtY2F0ZWdvcnktYWRkIjtpOjc5O3M6MjE6InByb2R1Y3QtY2F0ZWdvcnktZWRpdCI7aTo4MDtzOjIzOiJwcm9kdWN0LWNhdGVnb3J5LWRlbGV0ZSI7aTo4MTtzOjI4OiJwcm9kdWN0LWNhdGVnb3J5LWJ1bGstZGVsZXRlIjtpOjgyO3M6MjM6InByb2R1Y3QtY2F0ZWdvcnktcmVwb3J0IjtpOjgzO3M6MTQ6InByb2R1Y3QtYWNjZXNzIjtpOjg0O3M6MTE6InByb2R1Y3QtYWRkIjtpOjg1O3M6MTI6InByb2R1Y3QtZWRpdCI7aTo4NjtzOjEyOiJwcm9kdWN0LXZpZXciO2k6ODc7czoxNDoicHJvZHVjdC1kZWxldGUiO2k6ODg7czoxOToicHJvZHVjdC1idWxrLWRlbGV0ZSI7aTo4OTtzOjE0OiJwcm9kdWN0LXJlcG9ydCI7aTo5MDtzOjIwOiJwcmludC1iYXJjb2RlLWFjY2VzcyI7aTo5MTtzOjE3OiJhZGp1c3RtZW50LWFjY2VzcyI7aTo5MjtzOjE0OiJhZGp1c3RtZW50LWFkZCI7aTo5MztzOjE1OiJhZGp1c3RtZW50LWVkaXQiO2k6OTQ7czoxNToiYWRqdXN0bWVudC12aWV3IjtpOjk1O3M6MTc6ImFkanVzdG1lbnQtZGVsZXRlIjtpOjk2O3M6MjI6ImFkanVzdG1lbnQtYnVsay1kZWxldGUiO2k6OTc7czoxNzoiYWRqdXN0bWVudC1yZXBvcnQiO2k6OTg7czoyNzoicHJvZHVjdC1zdG9jay1yZXBvcnQtYWNjZXNzIjtpOjk5O3M6MTc6InByb2R1Y3Rpb24tYWNjZXNzIjtpOjEwMDtzOjE0OiJwcm9kdWN0aW9uLWFkZCI7aToxMDE7czoxNToicHJvZHVjdGlvbi1lZGl0IjtpOjEwMjtzOjE1OiJwcm9kdWN0aW9uLXZpZXciO2k6MTAzO3M6MTc6InByb2R1Y3Rpb24tZGVsZXRlIjtpOjEwNDtzOjE4OiJwcm9kdWN0aW9uLWFwcHJvdmUiO2k6MTA1O3M6MTc6InByb2R1Y3Rpb24tcmVwb3J0IjtpOjEwNjtzOjE1OiJjdXN0b21lci1hY2Nlc3MiO2k6MTA3O3M6MTU6ImN1c3RvbWVyLXJlcG9ydCI7aToxMDg7czoyMjoiY3VzdG9tZXItbGVkZ2VyLWFjY2VzcyI7aToxMDk7czoyMjoiY3JlZGl0LWN1c3RvbWVyLWFjY2VzcyI7aToxMTA7czoyMDoicGFpZC1jdXN0b21lci1hY2Nlc3MiO2k6MTExO3M6MjM6ImN1c3RvbWVyLWFkdmFuY2UtYWNjZXNzIjtpOjExMjtzOjIzOiJjdXN0b21lci1hZHZhbmNlLXJlcG9ydCI7aToxMTM7czoxNToic3VwcGxpZXItYWNjZXNzIjtpOjExNDtzOjEyOiJzdXBwbGllci1hZGQiO2k6MTE1O3M6MTM6InN1cHBsaWVyLWVkaXQiO2k6MTE2O3M6MTM6InN1cHBsaWVyLXZpZXciO2k6MTE3O3M6MTU6InN1cHBsaWVyLWRlbGV0ZSI7aToxMTg7czoyMDoic3VwcGxpZXItYnVsay1kZWxldGUiO2k6MTE5O3M6MTU6InN1cHBsaWVyLXJlcG9ydCI7aToxMjA7czoyMjoic3VwcGxpZXItbGVkZ2VyLWFjY2VzcyI7aToxMjE7czoyMzoic3VwcGxpZXItYWR2YW5jZS1hY2Nlc3MiO2k6MTIyO3M6MjI6InB1cmNoYXNlLXJldHVybi1hY2Nlc3MiO2k6MTIzO3M6MjI6InB1cmNoYXNlLXJldHVybi1hY2Nlc3MiO2k6MTI0O3M6MTk6InB1cmNoYXNlLXJldHVybi1hZGQiO2k6MTI1O3M6MjA6InB1cmNoYXNlLXJldHVybi12aWV3IjtpOjEyNjtzOjIyOiJwdXJjaGFzZS1yZXR1cm4tZGVsZXRlIjtpOjEyNztzOjE4OiJzYWxlLXJldHVybi1hY2Nlc3MiO2k6MTI4O3M6MTU6InNhbGUtcmV0dXJuLWFkZCI7aToxMjk7czoxNjoic2FsZS1yZXR1cm4tdmlldyI7aToxMzA7czoyMzoiY2hhcnQtb2YtYWNjb3VudC1hY2Nlc3MiO2k6MTMxO3M6MjA6ImNoYXJ0LW9mLWFjY291bnQtYWRkIjtpOjEzMjtzOjIxOiJjaGFydC1vZi1hY2NvdW50LWVkaXQiO2k6MTMzO3M6MjM6ImNoYXJ0LW9mLWFjY291bnQtZGVsZXRlIjtpOjEzNDtzOjIyOiJvcGVuaW5nLWJhbGFuY2UtYWNjZXNzIjtpOjEzNTtzOjIzOiJzdXBwbGllci1wYXltZW50LWFjY2VzcyI7aToxMzY7czoyMzoiY3VzdG9tZXItcmVjZWl2ZS1hY2Nlc3MiO2k6MTM3O3M6MjI6ImNhc2gtYWRqdXN0bWVudC1hY2Nlc3MiO2k6MTM4O3M6MjA6ImRlYml0LXZvdWNoZXItYWNjZXNzIjtpOjEzOTtzOjIxOiJjcmVkaXQtdm91Y2hlci1hY2Nlc3MiO2k6MTQwO3M6MjE6ImNvbnRyYS12b3VjaGVyLWFjY2VzcyI7aToxNDE7czoxODoiY29udHJhLXZvdWNoZXItYWRkIjtpOjE0MjtzOjE5OiJjb250cmEtdm91Y2hlci12aWV3IjtpOjE0MztzOjIxOiJjb250cmEtdm91Y2hlci1kZWxldGUiO2k6MTQ0O3M6MjE6ImpvdW5hbC12b3VjaGVyLWFjY2VzcyI7aToxNDU7czoxODoiam91bmFsLXZvdWNoZXItYWRkIjtpOjE0NjtzOjE5OiJqb3VuYWwtdm91Y2hlci12aWV3IjtpOjE0NztzOjIxOiJqb3VuYWwtdm91Y2hlci1kZWxldGUiO2k6MTQ4O3M6MTQ6InZvdWNoZXItYWNjZXNzIjtpOjE0OTtzOjE1OiJ2b3VjaGVyLWFwcHJvdmUiO2k6MTUwO3M6MTI6InZvdWNoZXItZWRpdCI7aToxNTE7czoxNDoidm91Y2hlci1kZWxldGUiO2k6MTUyO3M6MTY6ImNhc2gtYm9vay1hY2Nlc3MiO2k6MTUzO3M6MjM6ImludmVudG9yeS1sZWRnZXItYWNjZXNzIjtpOjE1NDtzOjE2OiJiYW5rLWJvb2stYWNjZXNzIjtpOjE1NTtzOjIzOiJtb2JpbGUtYmFuay1ib29rLWFjY2VzcyI7aToxNTY7czoyMToiZ2VuZXJhbC1sZWRnZXItYWNjZXNzIjtpOjE1NztzOjIwOiJ0cmlhbC1iYWxhbmNlLWFjY2VzcyI7aToxNTg7czoxODoicHJvZml0LWxvc3MtYWNjZXNzIjtpOjE1OTtzOjE2OiJjYXNoLWZsb3ctYWNjZXNzIjtpOjE2MDtzOjE5OiJleHBlbnNlLWl0ZW0tYWNjZXNzIjtpOjE2MTtzOjE2OiJleHBlbnNlLWl0ZW0tYWRkIjtpOjE2MjtzOjE3OiJleHBlbnNlLWl0ZW0tZWRpdCI7aToxNjM7czoxOToiZXhwZW5zZS1pdGVtLWRlbGV0ZSI7aToxNjQ7czoyNDoiZXhwZW5zZS1pdGVtLWJ1bGstZGVsZXRlIjtpOjE2NTtzOjE5OiJleHBlbnNlLWl0ZW0tcmVwb3J0IjtpOjE2NjtzOjE0OiJleHBlbnNlLWFjY2VzcyI7aToxNjc7czoxMToiZXhwZW5zZS1hZGQiO2k6MTY4O3M6MTI6ImV4cGVuc2UtZWRpdCI7aToxNjk7czoxNDoiZXhwZW5zZS1kZWxldGUiO2k6MTcwO3M6MTk6ImV4cGVuc2UtYnVsay1kZWxldGUiO2k6MTcxO3M6MTQ6ImV4cGVuc2UtcmVwb3J0IjtpOjE3MjtzOjE1OiJleHBlbnNlLWFwcHJvdmUiO2k6MTczO3M6MjQ6ImV4cGVuc2Utc3RhdGVtZW50LWFjY2VzcyI7aToxNzQ7czoxMToiYmFuay1hY2Nlc3MiO2k6MTc1O3M6ODoiYmFuay1hZGQiO2k6MTc2O3M6OToiYmFuay1lZGl0IjtpOjE3NztzOjExOiJiYW5rLWRlbGV0ZSI7aToxNzg7czoxMToiYmFuay1yZXBvcnQiO2k6MTc5O3M6MjM6ImJhbmstdHJhbnNhY3Rpb24tYWNjZXNzIjtpOjE4MDtzOjE4OiJiYW5rLWxlZGdlci1hY2Nlc3MiO2k6MTgxO3M6MTg6Im1vYmlsZS1iYW5rLWFjY2VzcyI7aToxODI7czoxNToibW9iaWxlLWJhbmstYWRkIjtpOjE4MztzOjE2OiJtb2JpbGUtYmFuay1lZGl0IjtpOjE4NDtzOjE4OiJtb2JpbGUtYmFuay1kZWxldGUiO2k6MTg1O3M6MjM6Im1vYmlsZS1iYW5rLWJ1bGstZGVsZXRlIjtpOjE4NjtzOjE4OiJtb2JpbGUtYmFuay1yZXBvcnQiO2k6MTg3O3M6MzA6Im1vYmlsZS1iYW5rLXRyYW5zYWN0aW9uLWFjY2VzcyI7aToxODg7czoyNToibW9iaWxlLWJhbmstbGVkZ2VyLWFjY2VzcyI7aToxODk7czoxNToiZGlzdHJpY3QtYWNjZXNzIjtpOjE5MDtzOjEyOiJkaXN0cmljdC1hZGQiO2k6MTkxO3M6MTM6ImRpc3RyaWN0LWVkaXQiO2k6MTkyO3M6MTU6ImRpc3RyaWN0LWRlbGV0ZSI7aToxOTM7czoyMDoiZGlzdHJpY3QtYnVsay1kZWxldGUiO2k6MTk0O3M6MTU6ImRpc3RyaWN0LXJlcG9ydCI7aToxOTU7czoxNDoidXBhemlsYS1hY2Nlc3MiO2k6MTk2O3M6MTE6InVwYXppbGEtYWRkIjtpOjE5NztzOjEyOiJ1cGF6aWxhLWVkaXQiO2k6MTk4O3M6MTQ6InVwYXppbGEtZGVsZXRlIjtpOjE5OTtzOjE5OiJ1cGF6aWxhLWJ1bGstZGVsZXRlIjtpOjIwMDtzOjE0OiJ1cGF6aWxhLXJlcG9ydCI7aToyMDE7czoxMjoicm91dGUtYWNjZXNzIjtpOjIwMjtzOjk6InJvdXRlLWFkZCI7aToyMDM7czoxMDoicm91dGUtZWRpdCI7aToyMDQ7czoxMjoicm91dGUtZGVsZXRlIjtpOjIwNTtzOjE3OiJyb3V0ZS1idWxrLWRlbGV0ZSI7aToyMDY7czoxMjoicm91dGUtcmVwb3J0IjtpOjIwNztzOjExOiJhcmVhLWFjY2VzcyI7aToyMDg7czo4OiJhcmVhLWFkZCI7aToyMDk7czo5OiJhcmVhLWVkaXQiO2k6MjEwO3M6MTE6ImFyZWEtZGVsZXRlIjtpOjIxMTtzOjE2OiJhcmVhLWJ1bGstZGVsZXRlIjtpOjIxMjtzOjExOiJhcmVhLXJlcG9ydCI7aToyMTM7czoxMDoiYXNtLWFjY2VzcyI7aToyMTQ7czo3OiJhc20tYWRkIjtpOjIxNTtzOjg6ImFzbS1lZGl0IjtpOjIxNjtzOjg6ImFzbS12aWV3IjtpOjIxNztzOjEwOiJhc20tZGVsZXRlIjtpOjIxODtzOjE1OiJhc20tYnVsay1kZWxldGUiO2k6MjE5O3M6MTA6ImFzbS1yZXBvcnQiO2k6MjIwO3M6MTQ6ImFzbS1wZXJtaXNzaW9uIjtpOjIyMTtzOjk6InNyLWFjY2VzcyI7aToyMjI7czo2OiJzci1hZGQiO2k6MjIzO3M6Nzoic3ItZWRpdCI7aToyMjQ7czo3OiJzci12aWV3IjtpOjIyNTtzOjk6InNyLWRlbGV0ZSI7aToyMjY7czoxNDoic3ItYnVsay1kZWxldGUiO2k6MjI3O3M6OToic3ItcmVwb3J0IjtpOjIyODtzOjE3OiJkZXBhcnRtZW50LWFjY2VzcyI7aToyMjk7czoxNDoiZGVwYXJ0bWVudC1hZGQiO2k6MjMwO3M6MTU6ImRlcGFydG1lbnQtZWRpdCI7aToyMzE7czoxNzoiZGVwYXJ0bWVudC1kZWxldGUiO2k6MjMyO3M6MjI6ImRlcGFydG1lbnQtYnVsay1kZWxldGUiO2k6MjMzO3M6MTc6ImRlcGFydG1lbnQtcmVwb3J0IjtpOjIzNDtzOjE1OiJkaXZpc2lvbi1hY2Nlc3MiO2k6MjM1O3M6MTI6ImRpdmlzaW9uLWFkZCI7aToyMzY7czoxMzoiZGl2aXNpb24tZWRpdCI7aToyMzc7czoxNToiZGl2aXNpb24tZGVsZXRlIjtpOjIzODtzOjIwOiJkaXZpc2lvbi1idWxrLWRlbGV0ZSI7aToyMzk7czoxNToiZGl2aXNpb24tcmVwb3J0IjtpOjI0MDtzOjE4OiJkZXNpZ25hdGlvbi1hY2Nlc3MiO2k6MjQxO3M6MTU6ImRlc2lnbmF0aW9uLWFkZCI7aToyNDI7czoxNjoiZGVzaWduYXRpb24tZWRpdCI7aToyNDM7czoxODoiZGVzaWduYXRpb24tZGVsZXRlIjtpOjI0NDtzOjIzOiJkZXNpZ25hdGlvbi1idWxrLWRlbGV0ZSI7aToyNDU7czoxODoiZGVzaWduYXRpb24tcmVwb3J0IjtpOjI0NjtzOjE1OiJlbXBsb3llZS1hY2Nlc3MiO2k6MjQ3O3M6MTI6ImVtcGxveWVlLWFkZCI7aToyNDg7czoxMzoiZW1wbG95ZWUtZWRpdCI7aToyNDk7czoxMzoiZW1wbG95ZWUtdmlldyI7aToyNTA7czoxNToiZW1wbG95ZWUtZGVsZXRlIjtpOjI1MTtzOjIwOiJlbXBsb3llZS1idWxrLWRlbGV0ZSI7aToyNTI7czoxNToiZW1wbG95ZWUtcmVwb3J0IjtpOjI1MztzOjE3OiJhdHRlbmRhbmNlLWFjY2VzcyI7aToyNTQ7czoxNDoiYXR0ZW5kYW5jZS1hZGQiO2k6MjU1O3M6MTU6ImF0dGVuZGFuY2UtZWRpdCI7aToyNTY7czoxNzoiYXR0ZW5kYW5jZS1kZWxldGUiO2k6MjU3O3M6MjI6ImF0dGVuZGFuY2UtYnVsay1kZWxldGUiO2k6MjU4O3M6MTc6ImF0dGVuZGFuY2UtcmVwb3J0IjtpOjI1OTtzOjI0OiJhdHRlbmRhbmNlLXJlcG9ydC1hY2Nlc3MiO2k6MjYwO3M6MjE6IndlZWtseS1ob2xpZGF5LWFjY2VzcyI7aToyNjE7czoxODoid2Vla2x5LWhvbGlkYXktYWRkIjtpOjI2MjtzOjE5OiJ3ZWVrbHktaG9saWRheS1lZGl0IjtpOjI2MztzOjIxOiJ3ZWVrbHktaG9saWRheS1kZWxldGUiO2k6MjY0O3M6MjY6IndlZWtseS1ob2xpZGF5LWJ1bGstZGVsZXRlIjtpOjI2NTtzOjIxOiJ3ZWVrbHktaG9saWRheS1yZXBvcnQiO2k6MjY2O3M6MTQ6ImhvbGlkYXktYWNjZXNzIjtpOjI2NztzOjExOiJob2xpZGF5LWFkZCI7aToyNjg7czoxMjoiaG9saWRheS1lZGl0IjtpOjI2OTtzOjE0OiJob2xpZGF5LWRlbGV0ZSI7aToyNzA7czoxOToiaG9saWRheS1idWxrLWRlbGV0ZSI7aToyNzE7czoxNDoiaG9saWRheS1yZXBvcnQiO2k6MjcyO3M6MTc6ImxlYXZlLXR5cGUtYWNjZXNzIjtpOjI3MztzOjE0OiJsZWF2ZS10eXBlLWFkZCI7aToyNzQ7czoxNToibGVhdmUtdHlwZS1lZGl0IjtpOjI3NTtzOjE3OiJsZWF2ZS10eXBlLWRlbGV0ZSI7aToyNzY7czoyMjoibGVhdmUtdHlwZS1idWxrLWRlbGV0ZSI7aToyNzc7czoxNzoibGVhdmUtdHlwZS1yZXBvcnQiO2k6Mjc4O3M6MjQ6ImxlYXZlLWFwcGxpY2F0aW9uLWFjY2VzcyI7aToyNzk7czoyMToibGVhdmUtYXBwbGljYXRpb24tYWRkIjtpOjI4MDtzOjIyOiJsZWF2ZS1hcHBsaWNhdGlvbi1lZGl0IjtpOjI4MTtzOjI0OiJsZWF2ZS1hcHBsaWNhdGlvbi1kZWxldGUiO2k6MjgyO3M6Mjk6ImxlYXZlLWFwcGxpY2F0aW9uLWJ1bGstZGVsZXRlIjtpOjI4MztzOjI0OiJsZWF2ZS1hcHBsaWNhdGlvbi1yZXBvcnQiO2k6Mjg0O3M6MjU6ImxlYXZlLWFwcGxpY2F0aW9uLWFwcHJvdmUiO2k6Mjg1O3M6MTU6ImJlbmlmaXRzLWFjY2VzcyI7aToyODY7czoxMjoiYmVuaWZpdHMtYWRkIjtpOjI4NztzOjEzOiJiZW5pZml0cy1lZGl0IjtpOjI4ODtzOjE1OiJiZW5pZml0cy1kZWxldGUiO2k6Mjg5O3M6MjA6ImJlbmlmaXRzLWJ1bGstZGVsZXRlIjtpOjI5MDtzOjE1OiJiZW5pZml0cy1yZXBvcnQiO2k6MjkxO3M6MTk6InNhbGFyeS1zZXR1cC1hY2Nlc3MiO2k6MjkyO3M6MTY6InNhbGFyeS1zZXR1cC1hZGQiO2k6MjkzO3M6MTc6InNhbGFyeS1zZXR1cC1lZGl0IjtpOjI5NDtzOjE3OiJzYWxhcnktc2V0dXAtdmlldyI7aToyOTU7czoxOToic2FsYXJ5LXNldHVwLWRlbGV0ZSI7aToyOTY7czoyNDoic2FsYXJ5LXNldHVwLWJ1bGstZGVsZXRlIjtpOjI5NztzOjE5OiJzYWxhcnktc2V0dXAtcmVwb3J0IjtpOjI5ODtzOjIyOiJzYWxhcnktZ2VuZXJhdGUtYWNjZXNzIjtpOjI5OTtzOjE5OiJzYWxhcnktZ2VuZXJhdGUtYWRkIjtpOjMwMDtzOjIyOiJzYWxhcnktZ2VuZXJhdGUtZGVsZXRlIjtpOjMwMTtzOjI3OiJzYWxhcnktZ2VuZXJhdGUtYnVsay1kZWxldGUiO2k6MzAyO3M6MjI6InNhbGFyeS1nZW5lcmF0ZS1yZXBvcnQiO2k6MzAzO3M6MTI6InNoaWZ0LWFjY2VzcyI7aTozMDQ7czo5OiJzaGlmdC1hZGQiO2k6MzA1O3M6MTA6InNoaWZ0LWVkaXQiO2k6MzA2O3M6MTI6InNoaWZ0LWRlbGV0ZSI7aTozMDc7czoxNzoic2hpZnQtYnVsay1kZWxldGUiO2k6MzA4O3M6MTI6InNoaWZ0LXJlcG9ydCI7aTozMDk7czoxOToic2hpZnQtbWFuYWdlLWFjY2VzcyI7aTozMTA7czoxNjoic2hpZnQtbWFuYWdlLWFkZCI7aTozMTE7czoxNzoic2hpZnQtbWFuYWdlLWVkaXQiO2k6MzEyO3M6MTk6InNoaWZ0LW1hbmFnZS1kZWxldGUiO2k6MzEzO3M6MjQ6InNoaWZ0LW1hbmFnZS1idWxrLWRlbGV0ZSI7aTozMTQ7czoxOToic2hpZnQtbWFuYWdlLXJlcG9ydCI7aTozMTU7czoyMToiZW1wbG95ZWUtc2hpZnQtY2hhbmdlIjtpOjMxNjtzOjIwOiJwcm9kdWN0aW9uLW9wZXJhdGlvbiI7aTozMTc7czoxOToicHJvZHVjdGlvbi10cmFuc2ZlciI7aTozMTg7czoyMDoic3VwcGxpZXItYWR2YW5jZS1hZGQiO2k6MzE5O3M6MjE6InN1cHBsaWVyLWFkdmFuY2UtZWRpdCI7aTozMjA7czoyMzoic3VwcGxpZXItYWR2YW5jZS1kZWxldGUiO2k6MzIxO3M6Mjg6InN1cHBsaWVyLWFkdmFuY2UtYnVsay1kZWxldGUiO2k6MzIyO3M6MjQ6InN1cHBsaWVyLWFkdmFuY2UtYXBwcm92ZSI7aTozMjM7czoyMToic3RvY2stdHJhbnNmZXItYWNjZXNzIjtpOjMyNDtzOjE5OiJzdG9jay10cmFuc2Zlci12aWV3IjtpOjMyNTtzOjE4OiJzdG9jay10cmFuc2Zlci1hZGQiO2k6MzI2O3M6MTk6ImZpbmlzaC1nb29kcy1hY2Nlc3MiO2k6MzI3O3M6MjE6ImFzbS1wZXJtaXNzaW9uLWFjY2VzcyI7aTozMjg7czoxODoiYXNtLXBlcm1pc3Npb24tYWRkIjtpOjMyOTtzOjE5OiJhc20tcGVybWlzc2lvbi1lZGl0IjtpOjMzMDtzOjIxOiJhc20tcGVybWlzc2lvbi1kZWxldGUiO2k6MzMxO3M6MjY6ImFzbS1wZXJtaXNzaW9uLWJ1bGstZGVsZXRlIjtpOjMzMjtzOjIxOiJhc20tcGVybWlzc2lvbi1yZXBvcnQiO2k6MzMzO3M6MTQ6ImNsb3NpbmctYWNjZXNzIjtpOjMzNDtzOjIxOiJjbG9zaW5nLXJlcG9ydC1hY2Nlc3MiO2k6MzM1O3M6MjU6InRvZGF5LXNhbGVzLXJlcG9ydC1hY2Nlc3MiO2k6MzM2O3M6MTk6InNhbGVzLXJlcG9ydC1hY2Nlc3MiO2k6MzM3O3M6MjM6ImludmVudG9yeS1yZXBvcnQtYWNjZXNzIjtpOjMzODtzOjMwOiJ0b2RheXMtY3VzdG9tZXItcmVjZWlwdC1hY2Nlc3MiO2k6MzM5O3M6Mjg6ImN1c3RvbWVyLXJlY2VpcHQtbGlzdC1hY2Nlc3MiO2k6MzQwO3M6MzM6InNhbGVzbWFuLXdpc2Utc2FsZXMtcmVwb3J0LWFjY2VzcyI7aTozNDE7czoxNzoiZHVlLXJlcG9ydC1hY2Nlc3MiO2k6MzQyO3M6Mjc6InNoaXBwaW5nLWNvc3QtcmVwb3J0LWFjY2VzcyI7aTozNDM7czozMjoicHJvZHVjdC13aXNlLXNhbGVzLXJlcG9ydC1hY2Nlc3MiO2k6MzQ0O3M6MjA6ImRhbWFnZS1yZXBvcnQtYWNjZXNzIjtpOjM0NTtzOjMxOiJ3YXJlaG91c2UtZXhwZW5zZS1yZXBvcnQtYWNjZXNzIjtpOjM0NjtzOjI0OiJjb2xsZWN0aW9uLXJlcG9ydC1hY2Nlc3MiO2k6MzQ3O3M6MjQ6IndhcmVob3VzZS1zdW1tYXJ5LWFjY2VzcyI7aTozNDg7czoyOToiY291cG9uLXJlY2VpdmVkLXJlcG9ydC1hY2Nlc3MiO2k6MzQ5O3M6MzQ6Im1hdGVyaWFsLXN0b2NrLWFsZXJ0LXJlcG9ydC1hY2Nlc3MiO2k6MzUwO3M6MzY6ImZpbmlzaC1nb29kcy1pbnZlbnRvcnktcmVwb3J0LWFjY2VzcyI7aTozNTE7czoyMjoidHJhbnNmZXItcmVwb3J0LWFjY2VzcyI7aTozNTI7czoyODoibWF0ZXJpYWwtaXNzdWUtcmVwb3J0LWFjY2VzcyI7aTozNTM7czozMToiYmF0Y2gtd2lzZS1jb3Vwb24tcmVwb3J0LWFjY2VzcyI7aTozNTQ7czozMToid2FyZWhvdXNlLWNsb3NpbmctcmVwb3J0LWFjY2VzcyI7aTozNTU7czoyNToiZGViaXQtdm91Y2hlci1saXN0LWFjY2VzcyI7aTozNTY7czoyNjoiY3JlZGl0LXZvdWNoZXItbGlzdC1hY2Nlc3MiO2k6MzU3O3M6MjA6ImN1c3RvbWVyLWFkdmFuY2UtYWRkIjtpOjM1ODtzOjIxOiJjdXN0b21lci1hZHZhbmNlLWVkaXQiO2k6MzU5O3M6MjM6ImN1c3RvbWVyLWFkdmFuY2UtZGVsZXRlIjt9fQ==', 1631014191);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('US125wgDHkYtS2i7iZMZTq6NKzC1t0FwVTv1Vgd1', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:92.0) Gecko/20100101 Firefox/92.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWlZSOWVrNWJoQTFvc242VUxLTWFmOThPYkVwUE9iTlA4NmJJUlhVVSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozODoiaHR0cDovL2tvaGlub29yLnRlc3Qvd2FyZWhvdXNlLXN1bW1hcnkiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozODoiaHR0cDovL2tvaGlub29yLnRlc3Qvd2FyZWhvdXNlLXN1bW1hcnkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1630943868);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(1, 'title', 'KEAPL', NULL, NULL),
(2, 'email', 'keapl@gmail.com', NULL, NULL),
(3, 'contact_no', '01521225987', NULL, NULL),
(4, 'address', 'Lorem Ipsum Dollar', NULL, NULL),
(5, 'currency_code', 'BDT', NULL, NULL),
(6, 'currency_symbol', 'Tk', NULL, NULL),
(7, 'currency_position', '2', NULL, NULL),
(8, 'timezone', 'Asia/Dhaka', NULL, NULL),
(9, 'date_format', 'd-M-Y', NULL, NULL),
(10, 'logo', 'keapl-logo.png', NULL, NULL),
(11, 'favicon', 'keapl-favicon.png', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zipcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `company_name`, `mobile`, `email`, `city`, `zipcode`, `address`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Md. Arman', 'XYZ', '01521225987', 'arman@gmail.com', 'xyz', '5565', 'Lorem Ipsum Dollar', '1', 'Super Admin', 'Super Admin', '2021-08-11 08:16:56', '2021-08-11 08:17:18'),
(2, 'Md. Shahed', 'ABC', '01521225988', 'shahed@gmail.com', NULL, NULL, 'Lorem Ipsum Dollar', '1', 'Super Admin', NULL, '2021-08-11 08:18:23', '2021-08-11 08:18:23');

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `rate`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, '5%', '5', '1', 'Super Admin', NULL, '2021-07-13 19:13:58', '2021-07-13 19:13:58');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `voucher_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `voucher_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `voucher_date` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `debit` double DEFAULT NULL,
  `credit` double DEFAULT NULL,
  `is_opening` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=Yes, 2=No',
  `posted` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Yes, 2=No',
  `approve` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Yes, 2=No',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `chart_of_account_id`, `warehouse_id`, `voucher_no`, `voucher_type`, `voucher_date`, `description`, `debit`, `credit`, `is_opening`, `posted`, `approve`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 28, 1, 'PG2R8GHTMG', 'PR Balance', '2021-08-11', 'Supplier debit For Md. Arman', 5000, 0, '2', '1', '1', 'Super Admin', NULL, '2021-08-11 08:16:56', NULL),
(2, 17, 1, 'PG2R8GHTMG', 'PR Balance', '2021-08-11', 'Inventory credit For Old sale For Md. Arman', 0, 5000, '2', '1', '1', 'Super Admin', NULL, '2021-08-11 08:16:56', NULL),
(3, 30, 2, 'HNJRBFS6YK', 'PR Balance', '2021-08-16', 'Customer debit For Md. Rakib', 2000, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-16 08:55:53', NULL),
(4, 17, 2, 'HNJRBFS6YK', 'PR Balance', '2021-08-16', 'Inventory credit For Old sale For Md. Rakib', 0, 2000, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-16 08:55:53', NULL),
(15, 17, 2, 'SINV-21082274', 'INVOICE', '2021-09-04', 'Inventory Credit For Invoice No SINV-21082274', 0, 485.35, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-22 13:39:12', NULL),
(16, 30, 2, 'SINV-21082274', 'INVOICE', '2021-09-04', 'Customer debit For Invoice No -  SINV-21082274 Customer Md. Rakib', 960, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-22 13:39:12', NULL),
(17, 8, 2, 'SINV-21082274', 'INVOICE', '2021-09-04', 'Sale Income For Invoice NO - SINV-21082274 Customer Md. Rakib', 0, 960, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-22 13:39:12', NULL),
(18, 30, 2, 'SINV-21082274', 'INVOICE', '2021-09-04', 'Customer credit for Paid Amount For Customer Invoice NO- SINV-21082274 Customer- Md. Rakib', 0, 2960, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-22 13:39:12', NULL),
(19, 23, 2, 'SINV-21082274', 'INVOICE', '2021-09-04', 'Cash in Hand in Sale for Invoice No - SINV-21082274 customer- Md. Rakib', 2960, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-22 13:39:12', NULL),
(28, 28, 1, '2', 'Purchase', '2021-08-25', 'Supplier Md. Arman', 0, 3380, '2', '1', '1', 'Super Admin', 'Super Admin', '2021-08-25 10:52:46', '2021-08-27 06:38:01'),
(29, 17, 1, '2', 'Purchase', '2021-08-25', 'Inventory Debit For Supplier Md. Arman', 3380, 0, '2', '1', '1', 'Super Admin', 'Super Admin', '2021-08-25 10:52:46', '2021-08-27 06:38:01'),
(30, 11, 1, '2', 'Purchase', '2021-08-25', 'Company Credit For Supplier Md. Arman', 3380, 0, '2', '1', '1', 'Super Admin', 'Super Admin', '2021-08-25 10:52:46', '2021-08-27 06:38:01'),
(31, 28, 1, '2', 'Purchase', '2021-08-25', 'Supplier .Md. Arman', 1970, 0, '2', '1', '1', 'Super Admin', NULL, '2021-08-25 10:52:46', '2021-08-25 10:52:46'),
(32, 23, 1, '2', 'Purchase', '2021-08-25', 'Cash in Hand For Supplier Md. Arman', 0, 1970, '2', '1', '1', 'Super Admin', NULL, '2021-08-25 10:52:46', '2021-08-25 10:52:46'),
(33, 32, 1, 'EXP-20210828150718402', 'Expense', '2021-08-28', 'Utility Bill Expense EXP-20210828150718402', 200, 0, '2', '1', '1', 'Super Admin', NULL, '2021-08-28 09:07:18', NULL),
(34, 23, 1, 'EXP-20210828150718402', 'Expense', '2021-08-28', 'Utility Bill Expense EXP-20210828150718402', 0, 200, '2', '1', '1', 'Super Admin', NULL, '2021-08-28 09:07:18', NULL),
(36, 28, 1, 'PINV-1001', 'Return', '2021-08-28', 'Supplier Md. Arman debit for Product Return Memo No. - PINV-1001', 410, 0, '2', '1', '1', 'Super Admin', NULL, '2021-08-28 13:12:49', '2021-08-28 13:12:49'),
(37, 38, 2, '45664864', 'Bank Transaction', '2021-08-29', NULL, 1000, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-29 04:45:33', '2021-08-29 04:45:33'),
(38, 23, 2, '45664864', 'Bank Transaction', '2021-08-29', NULL, 0, 1000, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-29 04:45:33', '2021-08-29 04:45:33'),
(39, 38, 1, '456486464', 'Bank Transaction', '2021-08-29', NULL, 500, 0, '2', '1', '1', 'Super Admin', NULL, '2021-08-29 04:46:12', '2021-08-29 04:46:12'),
(40, 23, 1, '456486464', 'Bank Transaction', '2021-08-29', NULL, 0, 500, '2', '1', '1', 'Super Admin', NULL, '2021-08-29 04:46:12', '2021-08-29 04:46:12'),
(41, 36, 2, '645645454564', 'Mobile Bank Transaction', '2021-08-29', NULL, 500, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-29 07:56:02', '2021-08-29 07:56:02'),
(42, 23, 2, '645645454564', 'Mobile Bank Transaction', '2021-08-29', NULL, 0, 500, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-29 07:56:02', '2021-08-29 07:56:02'),
(45, 17, 2, 'SINV-210830608', 'INVOICE', '2021-09-04', 'Inventory Credit For Invoice No SINV-210830608', 0, 369.7, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-30 08:32:38', NULL),
(46, 31, 2, 'SINV-210830608', 'INVOICE', '2021-09-04', 'Customer debit For Invoice No -  SINV-210830608 Customer Md. Salam', 580, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-30 08:32:38', NULL),
(47, 8, 2, 'SINV-210830608', 'INVOICE', '2021-09-04', 'Sale Income For Invoice NO - SINV-210830608 Customer Md. Salam', 0, 580, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-30 08:32:38', NULL),
(48, 31, 2, 'SINV-210830608', 'INVOICE', '2021-09-04', 'Customer credit for Paid Amount For Customer Invoice NO- SINV-210830608 Customer- Md. Salam', 0, 580, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-30 08:32:38', NULL),
(49, 23, 2, 'SINV-210830608', 'INVOICE', '2021-09-04', 'Cash in Hand in Sale for Invoice No - SINV-210830608 customer- Md. Salam', 580, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-08-30 08:32:38', NULL),
(50, 30, 2, 'SINV-21082274', 'Return', '2021-09-04', 'Customer Md. Rakib credit for Product Return Invoice NO- ', 0, 290, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-04 05:47:26', '2021-09-04 05:47:26'),
(51, 33, 2, 'EXP-21082404526', 'Expense', '2021-09-04', 'Labor Bill Expense EXP-21082404526', 50, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-04 09:25:31', NULL),
(52, 23, 2, 'EXP-21082404526', 'Expense', '2021-09-04', 'Labor Bill Expense EXP-21082404526', 0, 50, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-04 09:25:31', NULL),
(53, 33, 2, 'EXP-21082404528', 'Expense', '2021-09-04', 'Labor Bill Expense EXP-21082404528', 100, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-04 09:25:38', NULL),
(54, 23, 2, 'EXP-21082404528', 'Expense', '2021-09-04', 'Labor Bill Expense EXP-21082404528', 0, 100, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-04 09:25:38', NULL),
(55, 32, 2, 'EXP-21082404746', 'Expense', '2021-09-04', 'Utility Bill Expense EXP-21082404746', 200, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-04 09:25:45', NULL),
(56, 23, 2, 'EXP-21082404746', 'Expense', '2021-09-04', 'Utility Bill Expense EXP-21082404746', 0, 200, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-04 09:25:45', NULL),
(57, 30, 2, '1P43FLIAO2', 'Advance', '2021-09-05', 'Customer Advance For Md. Rakib', 290, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-05 01:28:01', NULL),
(58, 23, 2, '1P43FLIAO2', 'Advance', '2021-09-05', 'Cash in Hand For Md. Rakib', 290, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-05 01:28:01', NULL),
(59, 17, 2, 'SINV-210905111', 'INVOICE', '2021-09-05', 'Inventory Credit For Invoice No SINV-210905111', 0, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-05 01:28:53', NULL),
(60, 30, 2, 'SINV-210905111', 'INVOICE', '2021-09-05', 'Customer debit For Invoice No -  SINV-210905111 Customer Md. Rakib', 380, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-05 01:28:53', NULL),
(61, 8, 2, 'SINV-210905111', 'INVOICE', '2021-09-05', 'Sale Income For Invoice NO - SINV-210905111 Customer Md. Rakib', 0, 380, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-05 01:28:53', NULL),
(62, 17, 2, 'SINV-210905712', 'INVOICE', '2021-09-05', 'Inventory Credit For Invoice No SINV-210905712', 0, 462.6, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-05 01:29:49', NULL),
(63, 31, 2, 'SINV-210905712', 'INVOICE', '2021-09-05', 'Customer debit For Invoice No -  SINV-210905712 Customer Md. Salam', 760, 0, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-05 01:29:49', NULL),
(64, 8, 2, 'SINV-210905712', 'INVOICE', '2021-09-05', 'Sale Income For Invoice NO - SINV-210905712 Customer Md. Salam', 0, 760, '2', '1', '1', 'Mohammad Arman', NULL, '2021-09-05 01:29:49', NULL),
(65, 37, 1, '456468456456', 'Bank Transaction', '2021-09-07', NULL, 2000, 0, '2', '1', '1', 'Super Admin', NULL, '2021-09-07 10:15:33', '2021-09-07 10:15:33'),
(66, 23, 1, '456468456456', 'Bank Transaction', '2021-09-07', NULL, 0, 2000, '2', '1', '1', 'Super Admin', NULL, '2021-09-07 10:15:33', '2021-09-07 10:15:33'),
(67, 39, 1, '01680950235', 'Mobile Bank Transaction', '2021-09-07', NULL, 1500, 0, '2', '1', '1', 'Super Admin', NULL, '2021-09-07 10:18:53', '2021-09-07 10:18:53'),
(68, 23, 1, '01680950235', 'Mobile Bank Transaction', '2021-09-07', NULL, 0, 1500, '2', '1', '1', 'Super Admin', NULL, '2021-09-07 10:18:53', '2021-09-07 10:18:53'),
(69, 28, 1, 'THKZCB4VY3', 'Advance', '2021-09-07', 'Supplier Advance For Md. Arman', 5000, 0, '2', '1', '1', 'Super Admin', 'Super Admin', '2021-09-07 10:20:03', '2021-09-07 10:20:13'),
(70, 23, 1, 'THKZCB4VY3', 'Advance', '2021-09-07', 'Cash in Hand For Md. Arman', 5000, 0, '2', '1', '1', 'Super Admin', 'Super Admin', '2021-09-07 10:20:03', '2021-09-07 10:20:13');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `production_id` bigint(20) UNSIGNED NOT NULL,
  `chalan_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `item` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_unit_qty` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_base_unit_qty` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_tax` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `labor_cost` double DEFAULT NULL,
  `grand_total` double DEFAULT NULL,
  `received_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `carried_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transfer_date` date DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transfers`
--

INSERT INTO `transfers` (`id`, `production_id`, `chalan_no`, `warehouse_id`, `item`, `total_unit_qty`, `total_base_unit_qty`, `total_tax`, `total`, `shipping_cost`, `labor_cost`, `grand_total`, `received_by`, `carried_by`, `transfer_date`, `remarks`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 1, 'KEAPLTR-1', 2, '2', '2', '360', 0, 9360, 1000, 500, 10860, 'Arman', 'Shahed', '2021-08-12', 'Lorem Ipsum Dollar', 'Super Admin', '2021-08-12 11:04:29', '2021-08-12 11:04:29');

-- --------------------------------------------------------

--
-- Table structure for table `transfer_products`
--

CREATE TABLE `transfer_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transfer_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `unit_qty` double DEFAULT NULL,
  `base_unit_qty` double DEFAULT NULL,
  `net_unit_price` double DEFAULT NULL,
  `base_unit_price` double DEFAULT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transfer_products`
--

INSERT INTO `transfer_products` (`id`, `transfer_id`, `product_id`, `unit_qty`, `base_unit_qty`, `net_unit_price`, `base_unit_price`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 2, 2, 1, 240, 4800, 20, 0, 0, 4800, '2021-08-11 18:00:00', NULL),
(2, 2, 3, 1, 120, 4560, 38, 0, 0, 4560, '2021-08-11 18:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unit_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_unit` int(10) UNSIGNED DEFAULT NULL,
  `operator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '*',
  `operation_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=active,2=inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_name`, `unit_code`, `base_unit`, `operator`, `operation_value`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Piece', 'Pc', NULL, '*', '1', '1', 'Super Admin', NULL, '2021-07-13 19:14:39', '2021-07-13 19:14:39'),
(2, 'Kilogram', 'Kg', NULL, '*', '1', '1', 'Super Admin', NULL, '2021-07-13 19:14:57', '2021-07-13 19:14:57'),
(3, 'Gram', 'gm', 2, '/', '1000', '1', 'Super Admin', NULL, '2021-07-13 19:15:24', '2021-07-13 19:15:24'),
(4, 'CTN900', 'CTN900', 1, '*', '12', '1', 'Super Admin', 'Super Admin', '2021-07-26 09:27:33', '2021-09-07 05:18:35'),
(5, 'MBAG20', 'MBAG20', 1, '*', '324', '1', 'Super Admin', 'Super Admin', '2021-07-26 09:28:57', '2021-09-07 05:17:41'),
(6, 'MBAG50', 'MBAG50', 1, '*', '240', '1', 'Super Admin', 'Super Admin', '2021-07-26 09:29:28', '2021-09-07 05:17:54'),
(7, 'MBAG100', 'MBAG100', 1, '*', '120', '1', 'Super Admin', 'Super Admin', '2021-07-26 09:30:13', '2021-09-07 05:18:08'),
(8, 'MBAG200', 'MBAG200', 1, '*', '60', '1', 'Super Admin', 'Super Admin', '2021-07-26 09:30:38', '2021-09-07 05:18:19'),
(9, 'Drum', 'drum', NULL, '*', '1', '1', 'Super Admin', NULL, '2021-07-31 09:26:42', '2021-07-31 09:26:42'),
(10, 'Liter', 'Ltr', NULL, '*', '1', '1', 'Super Admin', NULL, '2021-07-31 09:27:05', '2021-07-31 09:27:05'),
(11, 'Carton', 'Ctn', NULL, '*', '1', '1', 'Super Admin', NULL, '2021-07-31 09:27:18', '2021-07-31 09:27:18');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Male,2=Female,3=Other',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `deletable` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=No, 2=Yes',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `username`, `email`, `phone`, `avatar`, `gender`, `password`, `status`, `deletable`, `created_by`, `modified_by`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 1, 'Super Admin', 'SuperAdmin', 'superadmin@mail.com', '01521225987', NULL, '1', '$2y$10$oyBQnkvC8WZEQffhpEEsyeZPPqXEHmpaErfi62fsfyAw.UMwIzS/m', '1', '1', NULL, NULL, NULL, '2021-03-26 17:49:24', '2021-03-26 17:49:24'),
(2, 2, 'Admin', 'Admin', 'admin@mail.com', '01711154960', NULL, '1', '$2y$10$KF7BIkSLDeOwTMgh6KtAVOrUOGfKQjWxDqXOO7UmR2Lpdrh1C9IKC', '1', '1', 'Admin', NULL, '3eyYUefuGJIxPgBSrnabkJk2nA2lG3ASic8s3cwWQ23pYLolX9k0Ni45CHD8', '2021-03-26 17:49:24', '2021-05-04 11:10:35');

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `asm_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `deletable` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=No, 2=Yes',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `phone`, `email`, `address`, `district_id`, `asm_id`, `status`, `deletable`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Jamalpur Warehouse', '01626939219', 'keapl.jamalpur@gmail.com', 'Lorem Ipsum Dollar', 5, 2, '1', '1', 'Super Admin', 'Super Admin', '2021-07-16 19:02:43', '2021-07-16 19:03:42'),
(2, 'Feni Warehouse', '01521225987', 'keapl.feni@gmail.com', 'Feni Sadar', 46, 1, '1', '2', 'Super Admin', NULL, '2021-07-16 19:04:37', '2021-07-16 19:04:37');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_material`
--

CREATE TABLE `warehouse_material` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `material_id` bigint(20) UNSIGNED NOT NULL,
  `qty` double(8,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouse_material`
--

INSERT INTO `warehouse_material` (`id`, `warehouse_id`, `material_id`, `qty`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 40.00, '2021-07-31 09:35:04', '2021-09-06 18:33:45'),
(2, 1, 2, 25.00, '2021-07-31 09:38:59', '2021-07-31 09:38:59'),
(3, 1, 3, 1661.00, '2021-07-31 09:42:39', '2021-08-29 03:50:06'),
(4, 1, 4, 419.00, '2021-07-31 10:04:07', '2021-08-28 13:12:49'),
(5, 1, 5, 277.00, '2021-07-31 10:08:29', '2021-08-29 03:50:06'),
(6, 1, 6, 325.00, '2021-07-31 10:09:29', '2021-07-31 10:09:29'),
(7, 1, 7, 280.00, '2021-07-31 10:11:55', '2021-07-31 10:11:55'),
(8, 1, 8, 230.00, '2021-07-31 10:12:57', '2021-07-31 10:12:57'),
(9, 1, 9, 137.00, '2021-07-31 10:18:03', '2021-08-11 17:45:01'),
(10, 1, 10, 100.00, '2021-07-31 10:18:58', '2021-08-29 03:50:06'),
(11, 1, 11, 132.00, '2021-07-31 10:21:13', '2021-07-31 10:21:13'),
(12, 1, 12, 229.00, '2021-07-31 10:22:22', '2021-07-31 10:22:22'),
(13, 1, 13, 1200.00, '2021-07-31 10:23:37', '2021-08-29 03:50:06');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_product`
--

CREATE TABLE `warehouse_product` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `batch_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouse_product`
--

INSERT INTO `warehouse_product` (`id`, `batch_no`, `warehouse_id`, `product_id`, `qty`, `created_at`, `updated_at`) VALUES
(1, '1006', 2, 2, 235, '2021-08-10 13:45:52', '2021-08-22 13:39:12'),
(2, '1006', 2, 3, 110, '2021-08-10 13:45:52', '2021-09-05 01:28:53'),
(5, '1001', 2, 2, 225, '2021-08-12 11:04:29', '2021-09-04 05:47:26'),
(6, '1001', 2, 3, 80, '2021-08-12 11:04:29', '2021-09-05 01:29:49');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `adjustments_adjustment_no_unique` (`adjustment_no`),
  ADD KEY `adjustments_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `adjustment_products`
--
ALTER TABLE `adjustment_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adjustment_products_adjustment_id_foreign` (`adjustment_id`),
  ADD KEY `adjustment_products_product_id_foreign` (`product_id`),
  ADD KEY `adjustment_products_base_unit_id_foreign` (`base_unit_id`);

--
-- Indexes for table `asms`
--
ALTER TABLE `asms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `asms_username_unique` (`username`),
  ADD UNIQUE KEY `asms_phone_unique` (`phone`),
  ADD KEY `asms_district_id_foreign` (`district_id`);

--
-- Indexes for table `asm_module`
--
ALTER TABLE `asm_module`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asm_module_module_id_foreign` (`module_id`),
  ADD KEY `asm_module_asm_id_foreign` (`asm_id`);

--
-- Indexes for table `asm_permission`
--
ALTER TABLE `asm_permission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asm_permission_permission_id_foreign` (`permission_id`),
  ADD KEY `asm_permission_asm_id_foreign` (`asm_id`);

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `banks_account_number_unique` (`account_number`),
  ADD KEY `banks_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD UNIQUE KEY `cache_key_unique` (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chart_of_accounts`
--
ALTER TABLE `chart_of_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `chart_of_accounts_code_unique` (`code`),
  ADD KEY `chart_of_accounts_customer_id_foreign` (`customer_id`),
  ADD KEY `chart_of_accounts_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customers_customer_group_id_foreign` (`customer_group_id`),
  ADD KEY `customers_district_id_foreign` (`district_id`),
  ADD KEY `customers_upazila_id_foreign` (`upazila_id`),
  ADD KEY `customers_route_id_foreign` (`route_id`),
  ADD KEY `customers_area_id_foreign` (`area_id`);

--
-- Indexes for table `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customer_groups_group_name_unique` (`group_name`);

--
-- Indexes for table `daily_closings`
--
ALTER TABLE `daily_closings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `daily_closings_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `expenses_voucher_no_unique` (`voucher_no`),
  ADD KEY `expenses_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `expenses_expense_item_id_foreign` (`expense_item_id`),
  ADD KEY `expenses_account_id_foreign` (`account_id`);

--
-- Indexes for table `expense_items`
--
ALTER TABLE `expense_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `expense_items_name_unique` (`name`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `materials_material_code_unique` (`material_code`),
  ADD KEY `materials_category_id_foreign` (`category_id`),
  ADD KEY `materials_unit_id_foreign` (`unit_id`),
  ADD KEY `materials_purchase_unit_id_foreign` (`purchase_unit_id`),
  ADD KEY `materials_tax_id_foreign` (`tax_id`),
  ADD KEY `materials_opening_warehouse_id_foreign` (`opening_warehouse_id`);

--
-- Indexes for table `material_purchase`
--
ALTER TABLE `material_purchase`
  ADD PRIMARY KEY (`id`),
  ADD KEY `material_purchase_purchase_id_foreign` (`purchase_id`),
  ADD KEY `material_purchase_material_id_foreign` (`material_id`),
  ADD KEY `material_purchase_purchase_unit_id_foreign` (`purchase_unit_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menus_menu_name_unique` (`menu_name`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mobile_banks`
--
ALTER TABLE `mobile_banks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mobile_banks_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `modules_menu_id_foreign` (`menu_id`);

--
-- Indexes for table `module_role`
--
ALTER TABLE `module_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `module_role_module_id_foreign` (`module_id`),
  ADD KEY `module_role_role_id_foreign` (`role_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permissions_module_id_foreign` (`module_id`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_role_permission_id_foreign` (`permission_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Indexes for table `productions`
--
ALTER TABLE `productions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `productions_batch_no_unique` (`batch_no`),
  ADD KEY `productions_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `production_coupons`
--
ALTER TABLE `production_coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `production_coupons_coupon_code_unique` (`coupon_code`),
  ADD KEY `production_coupons_production_product_id_foreign` (`production_product_id`);

--
-- Indexes for table `production_products`
--
ALTER TABLE `production_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `production_products_production_id_foreign` (`production_id`),
  ADD KEY `production_products_product_id_foreign` (`product_id`);

--
-- Indexes for table `production_product_materials`
--
ALTER TABLE `production_product_materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `production_product_materials_production_product_id_foreign` (`production_product_id`),
  ADD KEY `production_product_materials_material_id_foreign` (`material_id`),
  ADD KEY `production_product_materials_unit_id_foreign` (`unit_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_code_unique` (`code`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_base_unit_id_foreign` (`base_unit_id`),
  ADD KEY `products_unit_id_foreign` (`unit_id`),
  ADD KEY `products_tax_id_foreign` (`tax_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `product_material`
--
ALTER TABLE `product_material`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_material_product_id_foreign` (`product_id`),
  ADD KEY `product_material_material_id_foreign` (`material_id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `purchases_memo_no_unique` (`memo_no`),
  ADD KEY `purchases_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `purchases_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `purchase_payments`
--
ALTER TABLE `purchase_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_payments_purchase_id_foreign` (`purchase_id`),
  ADD KEY `purchase_payments_account_id_foreign` (`account_id`),
  ADD KEY `purchase_payments_transaction_id_foreign` (`transaction_id`),
  ADD KEY `purchase_payments_supplier_debit_transaction_id_foreign` (`supplier_debit_transaction_id`);

--
-- Indexes for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `purchase_returns_return_no_unique` (`return_no`),
  ADD KEY `purchase_returns_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `purchase_returns_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `purchase_return_materials`
--
ALTER TABLE `purchase_return_materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_return_materials_purchase_return_id_foreign` (`purchase_return_id`),
  ADD KEY `purchase_return_materials_material_id_foreign` (`material_id`),
  ADD KEY `purchase_return_materials_unit_id_foreign` (`unit_id`);

--
-- Indexes for table `received_coupons`
--
ALTER TABLE `received_coupons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `received_coupons_salesmen_id_foreign` (`salesmen_id`),
  ADD KEY `received_coupons_customer_id_foreign` (`customer_id`),
  ADD KEY `received_coupons_coupon_id_foreign` (`coupon_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_role_name_unique` (`role_name`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sales_memo_no_unique` (`memo_no`),
  ADD KEY `sales_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `sales_district_id_foreign` (`district_id`),
  ADD KEY `sales_upazila_id_foreign` (`upazila_id`),
  ADD KEY `sales_route_id_foreign` (`route_id`),
  ADD KEY `sales_area_id_foreign` (`area_id`),
  ADD KEY `sales_salesmen_id_foreign` (`salesmen_id`),
  ADD KEY `sales_customer_id_foreign` (`customer_id`),
  ADD KEY `sales_account_id_foreign` (`account_id`);

--
-- Indexes for table `salesmen`
--
ALTER TABLE `salesmen`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `salesmen_username_unique` (`username`),
  ADD UNIQUE KEY `salesmen_phone_unique` (`phone`),
  ADD KEY `salesmen_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `salesmen_district_id_foreign` (`district_id`),
  ADD KEY `salesmen_upazila_id_foreign` (`upazila_id`);

--
-- Indexes for table `sales_men_daily_routes`
--
ALTER TABLE `sales_men_daily_routes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_men_daily_routes_salesmen_id_foreign` (`salesmen_id`),
  ADD KEY `sales_men_daily_routes_route_id_foreign` (`route_id`);

--
-- Indexes for table `sale_products`
--
ALTER TABLE `sale_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_products_sale_id_foreign` (`sale_id`),
  ADD KEY `sale_products_product_id_foreign` (`product_id`),
  ADD KEY `sale_products_sale_unit_id_foreign` (`sale_unit_id`);

--
-- Indexes for table `sale_returns`
--
ALTER TABLE `sale_returns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sale_returns_return_no_unique` (`return_no`),
  ADD KEY `sale_returns_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `sale_returns_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `sale_return_products`
--
ALTER TABLE `sale_return_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_return_products_sale_return_id_foreign` (`sale_return_id`),
  ADD KEY `sale_return_products_product_id_foreign` (`product_id`),
  ADD KEY `sale_return_products_unit_id_foreign` (`unit_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_name_unique` (`name`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `taxes_name_unique` (`name`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_chart_of_account_id_foreign` (`chart_of_account_id`),
  ADD KEY `transactions_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transfers_chalan_no_unique` (`chalan_no`),
  ADD KEY `transfers_production_id_foreign` (`production_id`),
  ADD KEY `transfers_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `transfer_products`
--
ALTER TABLE `transfer_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transfer_products_transfer_id_foreign` (`transfer_id`),
  ADD KEY `transfer_products_product_id_foreign` (`product_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_phone_unique` (`phone`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `warehouses_name_unique` (`name`),
  ADD KEY `warehouses_district_id_foreign` (`district_id`),
  ADD KEY `warehouses_asm_id_foreign` (`asm_id`);

--
-- Indexes for table `warehouse_material`
--
ALTER TABLE `warehouse_material`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warehouse_material_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `warehouse_material_material_id_foreign` (`material_id`);

--
-- Indexes for table `warehouse_product`
--
ALTER TABLE `warehouse_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `batch_no` (`batch_no`),
  ADD KEY `warehouse_id` (`warehouse_id`),
  ADD KEY `product_id` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `adjustment_products`
--
ALTER TABLE `adjustment_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `asms`
--
ALTER TABLE `asms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `asm_module`
--
ALTER TABLE `asm_module`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `asm_permission`
--
ALTER TABLE `asm_permission`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `chart_of_accounts`
--
ALTER TABLE `chart_of_accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer_groups`
--
ALTER TABLE `customer_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `daily_closings`
--
ALTER TABLE `daily_closings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `expense_items`
--
ALTER TABLE `expense_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=583;

--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `material_purchase`
--
ALTER TABLE `material_purchase`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `mobile_banks`
--
ALTER TABLE `mobile_banks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=205;

--
-- AUTO_INCREMENT for table `module_role`
--
ALTER TABLE `module_role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=480;

--
-- AUTO_INCREMENT for table `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=146;

--
-- AUTO_INCREMENT for table `productions`
--
ALTER TABLE `productions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `production_coupons`
--
ALTER TABLE `production_coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `production_products`
--
ALTER TABLE `production_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `production_product_materials`
--
ALTER TABLE `production_product_materials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_material`
--
ALTER TABLE `product_material`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `purchase_payments`
--
ALTER TABLE `purchase_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `purchase_return_materials`
--
ALTER TABLE `purchase_return_materials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `received_coupons`
--
ALTER TABLE `received_coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `salesmen`
--
ALTER TABLE `salesmen`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sales_men_daily_routes`
--
ALTER TABLE `sales_men_daily_routes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sale_products`
--
ALTER TABLE `sale_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `sale_returns`
--
ALTER TABLE `sale_returns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sale_return_products`
--
ALTER TABLE `sale_return_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transfer_products`
--
ALTER TABLE `transfer_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `warehouse_material`
--
ALTER TABLE `warehouse_material`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `warehouse_product`
--
ALTER TABLE `warehouse_product`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD CONSTRAINT `adjustments_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `adjustment_products`
--
ALTER TABLE `adjustment_products`
  ADD CONSTRAINT `adjustment_products_adjustment_id_foreign` FOREIGN KEY (`adjustment_id`) REFERENCES `adjustments` (`id`),
  ADD CONSTRAINT `adjustment_products_base_unit_id_foreign` FOREIGN KEY (`base_unit_id`) REFERENCES `units` (`id`),
  ADD CONSTRAINT `adjustment_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `asms`
--
ALTER TABLE `asms`
  ADD CONSTRAINT `asms_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `asm_module`
--
ALTER TABLE `asm_module`
  ADD CONSTRAINT `asm_module_asm_id_foreign` FOREIGN KEY (`asm_id`) REFERENCES `asms` (`id`),
  ADD CONSTRAINT `asm_module_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`);

--
-- Constraints for table `asm_permission`
--
ALTER TABLE `asm_permission`
  ADD CONSTRAINT `asm_permission_asm_id_foreign` FOREIGN KEY (`asm_id`) REFERENCES `asms` (`id`),
  ADD CONSTRAINT `asm_permission_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`);

--
-- Constraints for table `banks`
--
ALTER TABLE `banks`
  ADD CONSTRAINT `banks_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `chart_of_accounts`
--
ALTER TABLE `chart_of_accounts`
  ADD CONSTRAINT `chart_of_accounts_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `chart_of_accounts_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`);

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `customers_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`),
  ADD CONSTRAINT `customers_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `customers_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `customers_upazila_id_foreign` FOREIGN KEY (`upazila_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `daily_closings`
--
ALTER TABLE `daily_closings`
  ADD CONSTRAINT `daily_closings_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `chart_of_accounts` (`id`),
  ADD CONSTRAINT `expenses_expense_item_id_foreign` FOREIGN KEY (`expense_item_id`) REFERENCES `expense_items` (`id`),
  ADD CONSTRAINT `expenses_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `materials`
--
ALTER TABLE `materials`
  ADD CONSTRAINT `materials_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `materials_opening_warehouse_id_foreign` FOREIGN KEY (`opening_warehouse_id`) REFERENCES `warehouses` (`id`),
  ADD CONSTRAINT `materials_purchase_unit_id_foreign` FOREIGN KEY (`purchase_unit_id`) REFERENCES `units` (`id`),
  ADD CONSTRAINT `materials_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`),
  ADD CONSTRAINT `materials_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `material_purchase`
--
ALTER TABLE `material_purchase`
  ADD CONSTRAINT `material_purchase_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`),
  ADD CONSTRAINT `material_purchase_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`),
  ADD CONSTRAINT `material_purchase_purchase_unit_id_foreign` FOREIGN KEY (`purchase_unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `mobile_banks`
--
ALTER TABLE `mobile_banks`
  ADD CONSTRAINT `mobile_banks_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `modules`
--
ALTER TABLE `modules`
  ADD CONSTRAINT `modules_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`);

--
-- Constraints for table `module_role`
--
ALTER TABLE `module_role`
  ADD CONSTRAINT `module_role_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`),
  ADD CONSTRAINT `module_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `permissions_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`);

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `productions`
--
ALTER TABLE `productions`
  ADD CONSTRAINT `productions_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `production_coupons`
--
ALTER TABLE `production_coupons`
  ADD CONSTRAINT `production_coupons_production_product_id_foreign` FOREIGN KEY (`production_product_id`) REFERENCES `production_products` (`id`);

--
-- Constraints for table `production_products`
--
ALTER TABLE `production_products`
  ADD CONSTRAINT `production_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `production_products_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`);

--
-- Constraints for table `production_product_materials`
--
ALTER TABLE `production_product_materials`
  ADD CONSTRAINT `production_product_materials_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`),
  ADD CONSTRAINT `production_product_materials_production_product_id_foreign` FOREIGN KEY (`production_product_id`) REFERENCES `production_products` (`id`),
  ADD CONSTRAINT `production_product_materials_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_base_unit_id_foreign` FOREIGN KEY (`base_unit_id`) REFERENCES `units` (`id`),
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `products_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`),
  ADD CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `product_material`
--
ALTER TABLE `product_material`
  ADD CONSTRAINT `product_material_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`),
  ADD CONSTRAINT `product_material_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`),
  ADD CONSTRAINT `purchases_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `purchase_payments`
--
ALTER TABLE `purchase_payments`
  ADD CONSTRAINT `purchase_payments_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `chart_of_accounts` (`id`),
  ADD CONSTRAINT `purchase_payments_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`),
  ADD CONSTRAINT `purchase_payments_supplier_debit_transaction_id_foreign` FOREIGN KEY (`supplier_debit_transaction_id`) REFERENCES `transactions` (`id`),
  ADD CONSTRAINT `purchase_payments_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`);

--
-- Constraints for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD CONSTRAINT `purchase_returns_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`),
  ADD CONSTRAINT `purchase_returns_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `purchase_return_materials`
--
ALTER TABLE `purchase_return_materials`
  ADD CONSTRAINT `purchase_return_materials_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`),
  ADD CONSTRAINT `purchase_return_materials_purchase_return_id_foreign` FOREIGN KEY (`purchase_return_id`) REFERENCES `purchase_returns` (`id`),
  ADD CONSTRAINT `purchase_return_materials_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `received_coupons`
--
ALTER TABLE `received_coupons`
  ADD CONSTRAINT `received_coupons_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `production_coupons` (`id`),
  ADD CONSTRAINT `received_coupons_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `received_coupons_salesmen_id_foreign` FOREIGN KEY (`salesmen_id`) REFERENCES `salesmen` (`id`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `chart_of_accounts` (`id`),
  ADD CONSTRAINT `sales_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `sales_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `sales_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `sales_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `sales_salesmen_id_foreign` FOREIGN KEY (`salesmen_id`) REFERENCES `salesmen` (`id`),
  ADD CONSTRAINT `sales_upazila_id_foreign` FOREIGN KEY (`upazila_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `sales_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `salesmen`
--
ALTER TABLE `salesmen`
  ADD CONSTRAINT `salesmen_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `salesmen_upazila_id_foreign` FOREIGN KEY (`upazila_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `salesmen_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `sales_men_daily_routes`
--
ALTER TABLE `sales_men_daily_routes`
  ADD CONSTRAINT `sales_men_daily_routes_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `sales_men_daily_routes_salesmen_id_foreign` FOREIGN KEY (`salesmen_id`) REFERENCES `salesmen` (`id`);

--
-- Constraints for table `sale_products`
--
ALTER TABLE `sale_products`
  ADD CONSTRAINT `sale_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `sale_products_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`),
  ADD CONSTRAINT `sale_products_sale_unit_id_foreign` FOREIGN KEY (`sale_unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `sale_returns`
--
ALTER TABLE `sale_returns`
  ADD CONSTRAINT `sale_returns_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `sale_returns_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `sale_return_products`
--
ALTER TABLE `sale_return_products`
  ADD CONSTRAINT `sale_return_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `sale_return_products_sale_return_id_foreign` FOREIGN KEY (`sale_return_id`) REFERENCES `sale_returns` (`id`),
  ADD CONSTRAINT `sale_return_products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_chart_of_account_id_foreign` FOREIGN KEY (`chart_of_account_id`) REFERENCES `chart_of_accounts` (`id`),
  ADD CONSTRAINT `transactions_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `transfers`
--
ALTER TABLE `transfers`
  ADD CONSTRAINT `transfers_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`),
  ADD CONSTRAINT `transfers_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `transfer_products`
--
ALTER TABLE `transfer_products`
  ADD CONSTRAINT `transfer_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `transfer_products_transfer_id_foreign` FOREIGN KEY (`transfer_id`) REFERENCES `transfers` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD CONSTRAINT `warehouses_asm_id_foreign` FOREIGN KEY (`asm_id`) REFERENCES `asms` (`id`),
  ADD CONSTRAINT `warehouses_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `warehouse_material`
--
ALTER TABLE `warehouse_material`
  ADD CONSTRAINT `warehouse_material_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`),
  ADD CONSTRAINT `warehouse_material_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `warehouse_product`
--
ALTER TABLE `warehouse_product`
  ADD CONSTRAINT `warehouse_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `warehouse_product_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
