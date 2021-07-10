-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 02, 2021 at 09:13 AM
-- Server version: 5.7.24
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `erp`
--

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
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
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

INSERT INTO `asms` (`id`, `name`, `username`, `phone`, `email`, `avatar`, `password`, `warehouse_id`, `district_id`, `address`, `status`, `created_by`, `modified_by`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Mohammad Arman', 'arman', '01521225987', 'arman@gmail.com', NULL, '$2y$10$qkZHOYz2LYiX5XEBQqC3luMiNM3hT.Flkeku4OiltdqK5VN26HUsG', 2, 46, 'lorem ipsum dollar', '1', 'arman', NULL, NULL, '2021-01-30 02:49:52', '2021-02-24 04:38:20'),
(2, 'Mr. XYZ', 'xyz', '01521225988', '', '899048ab0cc455154006fdb9676964b3-692982.jpg', '$2y$10$i3UJfvC8rJiSrxWW4FhDKeaxTHlhAosA0BL5zzYT.0G7qL1OPBZF.', 3, 1, '', '1', 'Super Admin', 'Super Admin', NULL, '2021-01-30 03:12:14', '2021-01-30 03:26:28');

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banks`
--

INSERT INTO `banks` (`id`, `bank_name`, `account_name`, `account_number`, `branch`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Dutch Bangla Bank Ltd.', 'Kohinoor', '546545565', 'Jamalpur', '1', 'Super Admin', NULL, '2021-01-26 23:55:38', '2021-01-26 23:55:38'),
(2, 'Standard Chartard Bank Ltd.', 'Kohinoor', '489456454564', 'Jamalpur', '1', 'Super Admin', NULL, '2021-01-26 23:56:01', '2021-01-26 23:56:01');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `deletable` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=No, 2=Yes',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `phone`, `email`, `address`, `status`, `deletable`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Head Office', '', '', '', '1', '1', 'Super Admin', NULL, '2021-03-07 00:30:07', '2021-03-07 00:30:07'),
(2, 'Chittagong', '', '', '', '1', '2', 'Super Admin', NULL, '2021-03-07 00:30:36', '2021-03-07 00:30:36'),
(3, 'Feni', '', '', '', '1', '2', 'Super Admin', NULL, '2021-03-07 00:30:46', '2021-03-07 00:30:46');

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
('kohinoor_cache_active_departments', 'O:29:\"Illuminate\\Support\\Collection\":1:{s:8:\"\0*\0items\";a:5:{i:0;O:8:\"stdClass\":8:{s:2:\"id\";i:1;s:4:\"name\";s:2:\"HR\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 08:43:42\";s:10:\"updated_at\";s:19:\"2021-03-07 08:43:42\";}i:1;O:8:\"stdClass\":8:{s:2:\"id\";i:2;s:4:\"name\";s:8:\"Accounts\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 08:43:53\";s:10:\"updated_at\";s:19:\"2021-03-07 08:43:53\";}i:2;O:8:\"stdClass\":8:{s:2:\"id\";i:3;s:4:\"name\";s:5:\"Sales\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 08:44:03\";s:10:\"updated_at\";s:19:\"2021-03-07 08:44:03\";}i:3;O:8:\"stdClass\":8:{s:2:\"id\";i:4;s:4:\"name\";s:2:\"IT\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";s:11:\"Super Admin\";s:10:\"created_at\";s:19:\"2021-03-07 08:44:11\";s:10:\"updated_at\";s:19:\"2021-03-07 08:44:25\";}i:4;O:8:\"stdClass\":8:{s:2:\"id\";i:5;s:4:\"name\";s:10:\"Production\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 08:57:53\";s:10:\"updated_at\";s:19:\"2021-03-07 08:57:53\";}}}', 1932872212),
('kohinoor_cache_active_designations', 'O:29:\"Illuminate\\Support\\Collection\":1:{s:8:\"\0*\0items\";a:9:{i:0;O:8:\"stdClass\":8:{s:2:\"id\";i:1;s:4:\"name\";s:3:\"CEO\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 08:58:45\";s:10:\"updated_at\";s:19:\"2021-03-07 08:58:45\";}i:1;O:8:\"stdClass\":8:{s:2:\"id\";i:2;s:4:\"name\";s:14:\"General Manage\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 08:59:21\";s:10:\"updated_at\";s:19:\"2021-03-07 08:59:21\";}i:2;O:8:\"stdClass\":8:{s:2:\"id\";i:3;s:4:\"name\";s:25:\"Assistant General Manager\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 08:59:42\";s:10:\"updated_at\";s:19:\"2021-03-07 08:59:42\";}i:3;O:8:\"stdClass\":8:{s:2:\"id\";i:4;s:4:\"name\";s:7:\"Manager\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 09:00:02\";s:10:\"updated_at\";s:19:\"2021-03-07 09:00:02\";}i:4;O:8:\"stdClass\":8:{s:2:\"id\";i:5;s:4:\"name\";s:13:\"Sr. Executive\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 09:00:14\";s:10:\"updated_at\";s:19:\"2021-03-07 09:00:14\";}i:5;O:8:\"stdClass\":8:{s:2:\"id\";i:6;s:4:\"name\";s:9:\"Executive\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 09:00:22\";s:10:\"updated_at\";s:19:\"2021-03-07 09:00:22\";}i:6;O:8:\"stdClass\":8:{s:2:\"id\";i:7;s:4:\"name\";s:13:\"Jr. Executive\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 09:00:31\";s:10:\"updated_at\";s:19:\"2021-03-07 09:00:31\";}i:7;O:8:\"stdClass\":8:{s:2:\"id\";i:8;s:4:\"name\";s:5:\"Staff\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 09:00:41\";s:10:\"updated_at\";s:19:\"2021-03-07 09:00:41\";}i:8;O:8:\"stdClass\":8:{s:2:\"id\";i:9;s:4:\"name\";s:6:\"Worker\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 09:00:48\";s:10:\"updated_at\";s:19:\"2021-03-07 09:00:48\";}}}', 1932872212),
('kohinoor_cache_active_divisions', 'O:29:\"Illuminate\\Support\\Collection\":1:{s:8:\"\0*\0items\";a:4:{i:0;O:8:\"stdClass\":9:{s:2:\"id\";i:1;s:4:\"name\";s:5:\"Admin\";s:13:\"department_id\";i:1;s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 08:56:23\";s:10:\"updated_at\";s:19:\"2021-03-07 08:56:23\";}i:1;O:8:\"stdClass\":9:{s:2:\"id\";i:2;s:4:\"name\";s:10:\"Networking\";s:13:\"department_id\";i:4;s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 08:56:42\";s:10:\"updated_at\";s:19:\"2021-03-07 08:56:42\";}i:2;O:8:\"stdClass\":9:{s:2:\"id\";i:3;s:4:\"name\";s:8:\"Software\";s:13:\"department_id\";i:4;s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 08:56:52\";s:10:\"updated_at\";s:19:\"2021-03-07 08:56:52\";}i:3;O:8:\"stdClass\":9:{s:2:\"id\";i:4;s:4:\"name\";s:9:\"Packaging\";s:13:\"department_id\";i:5;s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-03-07 08:58:31\";s:10:\"updated_at\";s:19:\"2021-03-07 08:58:31\";}}}', 1932872212),
('kohinoor_cache_active_suppliers', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":1:{s:8:\"\0*\0items\";a:3:{i:0;O:34:\"Modules\\Supplier\\Entities\\Supplier\":37:{s:11:\"\0*\0fillable\";a:14:{i:0;s:4:\"name\";i:1;s:12:\"company_name\";i:2;s:6:\"mobile\";i:3;s:5:\"email\";i:4;s:5:\"phone\";i:5;s:4:\"city\";i:6;s:5:\"state\";i:7;s:3:\"zip\";i:8;s:7:\"country\";i:9;s:7:\"address\";i:10;s:7:\"details\";i:11;s:6:\"status\";i:12;s:10:\"created_by\";i:13;s:11:\"modified_by\";}s:7:\"\0*\0name\";N;s:9:\"\0*\0mobile\";N;s:8:\"\0*\0email\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"suppliers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:16:{s:2:\"id\";i:1;s:4:\"name\";s:7:\"Mr. AAA\";s:12:\"company_name\";s:3:\"AAA\";s:6:\"mobile\";s:11:\"01521225987\";s:5:\"email\";s:0:\"\";s:5:\"phone\";s:0:\"\";s:4:\"city\";s:0:\"\";s:5:\"state\";s:0:\"\";s:3:\"zip\";s:0:\"\";s:7:\"country\";s:0:\"\";s:7:\"address\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-27 09:58:54\";s:10:\"updated_at\";s:19:\"2021-01-27 09:58:54\";}s:11:\"\0*\0original\";a:16:{s:2:\"id\";i:1;s:4:\"name\";s:7:\"Mr. AAA\";s:12:\"company_name\";s:3:\"AAA\";s:6:\"mobile\";s:11:\"01521225987\";s:5:\"email\";s:0:\"\";s:5:\"phone\";s:0:\"\";s:4:\"city\";s:0:\"\";s:5:\"state\";s:0:\"\";s:3:\"zip\";s:0:\"\";s:7:\"country\";s:0:\"\";s:7:\"address\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-27 09:58:54\";s:10:\"updated_at\";s:19:\"2021-01-27 09:58:54\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:34:\"Modules\\Supplier\\Entities\\Supplier\":37:{s:11:\"\0*\0fillable\";a:14:{i:0;s:4:\"name\";i:1;s:12:\"company_name\";i:2;s:6:\"mobile\";i:3;s:5:\"email\";i:4;s:5:\"phone\";i:5;s:4:\"city\";i:6;s:5:\"state\";i:7;s:3:\"zip\";i:8;s:7:\"country\";i:9;s:7:\"address\";i:10;s:7:\"details\";i:11;s:6:\"status\";i:12;s:10:\"created_by\";i:13;s:11:\"modified_by\";}s:7:\"\0*\0name\";N;s:9:\"\0*\0mobile\";N;s:8:\"\0*\0email\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"suppliers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:16:{s:2:\"id\";i:2;s:4:\"name\";s:7:\"Mr. BBB\";s:12:\"company_name\";s:3:\"BBB\";s:6:\"mobile\";s:11:\"01521225988\";s:5:\"email\";s:0:\"\";s:5:\"phone\";s:0:\"\";s:4:\"city\";s:0:\"\";s:5:\"state\";s:0:\"\";s:3:\"zip\";s:0:\"\";s:7:\"country\";s:0:\"\";s:7:\"address\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-27 09:59:07\";s:10:\"updated_at\";s:19:\"2021-01-27 09:59:07\";}s:11:\"\0*\0original\";a:16:{s:2:\"id\";i:2;s:4:\"name\";s:7:\"Mr. BBB\";s:12:\"company_name\";s:3:\"BBB\";s:6:\"mobile\";s:11:\"01521225988\";s:5:\"email\";s:0:\"\";s:5:\"phone\";s:0:\"\";s:4:\"city\";s:0:\"\";s:5:\"state\";s:0:\"\";s:3:\"zip\";s:0:\"\";s:7:\"country\";s:0:\"\";s:7:\"address\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-27 09:59:07\";s:10:\"updated_at\";s:19:\"2021-01-27 09:59:07\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:34:\"Modules\\Supplier\\Entities\\Supplier\":37:{s:11:\"\0*\0fillable\";a:14:{i:0;s:4:\"name\";i:1;s:12:\"company_name\";i:2;s:6:\"mobile\";i:3;s:5:\"email\";i:4;s:5:\"phone\";i:5;s:4:\"city\";i:6;s:5:\"state\";i:7;s:3:\"zip\";i:8;s:7:\"country\";i:9;s:7:\"address\";i:10;s:7:\"details\";i:11;s:6:\"status\";i:12;s:10:\"created_by\";i:13;s:11:\"modified_by\";}s:7:\"\0*\0name\";N;s:9:\"\0*\0mobile\";N;s:8:\"\0*\0email\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"suppliers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:16:{s:2:\"id\";i:3;s:4:\"name\";s:7:\"Mr. CCC\";s:12:\"company_name\";s:3:\"CCC\";s:6:\"mobile\";s:11:\"01521225986\";s:5:\"email\";s:0:\"\";s:5:\"phone\";s:0:\"\";s:4:\"city\";s:0:\"\";s:5:\"state\";s:0:\"\";s:3:\"zip\";s:0:\"\";s:7:\"country\";s:0:\"\";s:7:\"address\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-28 06:03:27\";s:10:\"updated_at\";s:19:\"2021-01-28 06:03:27\";}s:11:\"\0*\0original\";a:16:{s:2:\"id\";i:3;s:4:\"name\";s:7:\"Mr. CCC\";s:12:\"company_name\";s:3:\"CCC\";s:6:\"mobile\";s:11:\"01521225986\";s:5:\"email\";s:0:\"\";s:5:\"phone\";s:0:\"\";s:4:\"city\";s:0:\"\";s:5:\"state\";s:0:\"\";s:3:\"zip\";s:0:\"\";s:7:\"country\";s:0:\"\";s:7:\"address\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-28 06:03:27\";s:10:\"updated_at\";s:19:\"2021-01-28 06:03:27\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}}', 1932275546),
('kohinoor_cache_active_taxes', 'O:29:\"Illuminate\\Support\\Collection\":1:{s:8:\"\0*\0items\";a:3:{i:0;O:8:\"stdClass\":8:{s:2:\"id\";i:1;s:4:\"name\";s:2:\"5%\";s:4:\"rate\";s:1:\"5\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 07:03:28\";s:10:\"updated_at\";s:19:\"2021-01-20 07:03:28\";}i:1;O:8:\"stdClass\":8:{s:2:\"id\";i:2;s:4:\"name\";s:3:\"10%\";s:4:\"rate\";s:2:\"10\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 07:03:41\";s:10:\"updated_at\";s:19:\"2021-01-20 07:03:41\";}i:2;O:8:\"stdClass\":8:{s:2:\"id\";i:3;s:4:\"name\";s:3:\"15%\";s:4:\"rate\";s:2:\"15\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 07:03:52\";s:10:\"updated_at\";s:19:\"2021-01-20 07:03:52\";}}}', 1932275546),
('kohinoor_cache_active_warehouses', 'O:29:\"Illuminate\\Support\\Collection\":1:{s:8:\"\0*\0items\";a:3:{i:0;O:8:\"stdClass\":11:{s:2:\"id\";i:1;s:4:\"name\";s:14:\"Main Warehouse\";s:5:\"phone\";s:0:\"\";s:5:\"email\";s:0:\"\";s:7:\"address\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 07:04:24\";s:10:\"updated_at\";s:19:\"2021-01-20 07:04:24\";}i:1;O:8:\"stdClass\":11:{s:2:\"id\";i:2;s:4:\"name\";s:14:\"Feni Warehouse\";s:5:\"phone\";s:0:\"\";s:5:\"email\";s:0:\"\";s:7:\"address\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 07:04:41\";s:10:\"updated_at\";s:19:\"2021-01-20 07:04:41\";}i:2;O:8:\"stdClass\":11:{s:2:\"id\";i:3;s:4:\"name\";s:15:\"Dhaka Warehouse\";s:5:\"phone\";s:0:\"\";s:5:\"email\";s:0:\"\";s:7:\"address\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"deletable\";s:1:\"2\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 07:04:57\";s:10:\"updated_at\";s:19:\"2021-01-20 07:04:57\";}}}', 1932275546),
('kohinoor_cache_material_categories', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":1:{s:8:\"\0*\0items\";a:5:{i:0;O:19:\"App\\Models\\Category\":36:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:4;s:4:\"name\";s:3:\"Can\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 03:15:23\";s:10:\"updated_at\";s:19:\"2021-01-20 03:15:23\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:4;s:4:\"name\";s:3:\"Can\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 03:15:23\";s:10:\"updated_at\";s:19:\"2021-01-20 03:15:23\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:19:\"App\\Models\\Category\":36:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:5;s:4:\"name\";s:7:\"Element\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 03:18:13\";s:10:\"updated_at\";s:19:\"2021-01-20 03:18:13\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:5;s:4:\"name\";s:7:\"Element\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 03:18:13\";s:10:\"updated_at\";s:19:\"2021-01-20 03:18:13\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:19:\"App\\Models\\Category\":36:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:2;s:4:\"name\";s:6:\"Liquid\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 02:47:57\";s:10:\"updated_at\";s:19:\"2021-01-20 02:47:57\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:2;s:4:\"name\";s:6:\"Liquid\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 02:47:57\";s:10:\"updated_at\";s:19:\"2021-01-20 02:47:57\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:19:\"App\\Models\\Category\":36:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:3;s:4:\"name\";s:5:\"Paper\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 03:15:08\";s:10:\"updated_at\";s:19:\"2021-01-20 03:15:08\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:3;s:4:\"name\";s:5:\"Paper\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 03:15:08\";s:10:\"updated_at\";s:19:\"2021-01-20 03:15:08\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:19:\"App\\Models\\Category\":36:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:1;s:4:\"name\";s:6:\"Powder\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 02:47:50\";s:10:\"updated_at\";s:19:\"2021-01-20 02:47:50\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:1;s:4:\"name\";s:6:\"Powder\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 02:47:50\";s:10:\"updated_at\";s:19:\"2021-01-20 02:47:50\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}}', 1937881497),
('kohinoor_cache_product_categories', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":1:{s:8:\"\0*\0items\";a:7:{i:0;O:19:\"App\\Models\\Category\":36:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:9;s:4:\"name\";s:4:\"Baja\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:16:52\";s:10:\"updated_at\";s:19:\"2021-01-20 04:16:52\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:9;s:4:\"name\";s:4:\"Baja\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:16:52\";s:10:\"updated_at\";s:19:\"2021-01-20 04:16:52\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:19:\"App\\Models\\Category\":36:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:8;s:4:\"name\";s:8:\"Chanchur\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:16:38\";s:10:\"updated_at\";s:19:\"2021-01-20 04:16:38\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:8;s:4:\"name\";s:8:\"Chanchur\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:16:38\";s:10:\"updated_at\";s:19:\"2021-01-20 04:16:38\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:19:\"App\\Models\\Category\":36:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:11;s:4:\"name\";s:5:\"Chips\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:17:08\";s:10:\"updated_at\";s:19:\"2021-01-20 04:17:08\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:11;s:4:\"name\";s:5:\"Chips\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:17:08\";s:10:\"updated_at\";s:19:\"2021-01-20 04:17:08\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:19:\"App\\Models\\Category\":36:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:7;s:4:\"name\";s:5:\"Foron\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:16:14\";s:10:\"updated_at\";s:19:\"2021-01-20 04:16:14\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:7;s:4:\"name\";s:5:\"Foron\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:16:14\";s:10:\"updated_at\";s:19:\"2021-01-20 04:16:14\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:19:\"App\\Models\\Category\":36:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:12;s:4:\"name\";s:4:\"Ghee\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:17:20\";s:10:\"updated_at\";s:19:\"2021-01-20 04:17:20\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:12;s:4:\"name\";s:4:\"Ghee\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:17:20\";s:10:\"updated_at\";s:19:\"2021-01-20 04:17:20\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:19:\"App\\Models\\Category\":36:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:6;s:4:\"name\";s:6:\"Powder\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:16:07\";s:10:\"updated_at\";s:19:\"2021-01-20 04:16:07\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:6;s:4:\"name\";s:6:\"Powder\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:16:07\";s:10:\"updated_at\";s:19:\"2021-01-20 04:16:07\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:6;O:19:\"App\\Models\\Category\":36:{s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:4:\"type\";i:2;s:6:\"status\";i:3;s:10:\"created_by\";i:4;s:11:\"modified_by\";}s:7:\"\0*\0type\";N;s:7:\"\0*\0name\";N;s:9:\"\0*\0status\";N;s:8:\"\0*\0order\";a:1:{s:2:\"id\";s:4:\"desc\";}s:15:\"\0*\0column_order\";N;s:13:\"\0*\0orderValue\";N;s:11:\"\0*\0dirValue\";N;s:13:\"\0*\0startVlaue\";N;s:14:\"\0*\0lengthVlaue\";N;s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:10;s:4:\"name\";s:5:\"Semai\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:16:58\";s:10:\"updated_at\";s:19:\"2021-01-20 04:16:58\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:10;s:4:\"name\";s:5:\"Semai\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:10:\"created_by\";s:11:\"Super Admin\";s:11:\"modified_by\";N;s:10:\"created_at\";s:19:\"2021-01-20 04:16:58\";s:10:\"updated_at\";s:19:\"2021-01-20 04:16:58\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:8:\"\0*\0dates\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}}', 1932460767);

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
(1, 'Powder', '1', '1', 'Super Admin', NULL, '2021-01-19 20:47:50', '2021-01-19 20:47:50'),
(2, 'Liquid', '1', '1', 'Super Admin', NULL, '2021-01-19 20:47:57', '2021-01-19 20:47:57'),
(3, 'Paper', '1', '1', 'Super Admin', NULL, '2021-01-19 21:15:08', '2021-01-19 21:15:08'),
(4, 'Can', '1', '1', 'Super Admin', NULL, '2021-01-19 21:15:23', '2021-01-19 21:15:23'),
(5, 'Element', '1', '1', 'Super Admin', NULL, '2021-01-19 21:18:13', '2021-01-19 21:18:13'),
(6, 'Powder', '2', '1', 'Super Admin', NULL, '2021-01-19 22:16:07', '2021-01-19 22:16:07'),
(7, 'Foron', '2', '1', 'Super Admin', NULL, '2021-01-19 22:16:14', '2021-01-19 22:16:14'),
(8, 'Chanchur', '2', '1', 'Super Admin', NULL, '2021-01-19 22:16:38', '2021-01-19 22:16:38'),
(9, 'Baja', '2', '1', 'Super Admin', NULL, '2021-01-19 22:16:52', '2021-01-19 22:16:52'),
(10, 'Semai', '2', '1', 'Super Admin', NULL, '2021-01-19 22:16:58', '2021-01-19 22:16:58'),
(11, 'Chips', '2', '1', 'Super Admin', NULL, '2021-01-19 22:17:08', '2021-01-19 22:17:08'),
(12, 'Ghee', '2', '1', 'Super Admin', NULL, '2021-01-19 22:17:20', '2021-01-19 22:17:20');

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
(1, '1', 'Assets', 'COA', 0, 'A', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(2, '2', 'Equity', 'COA', 0, 'L', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(3, '3', 'Income', 'COA', 0, 'I', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(4, '4', 'Expense', 'COA', 0, 'E', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(5, '5', 'Liabilities', 'COA', 0, 'L', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(6, '101', 'Non Current Asset', 'Assets', 1, 'A', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(7, '102', 'Current Asset', 'Assets', 1, 'A', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(8, '301', 'Product Sale', 'Income', 1, 'I', '1', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(9, '302', 'Service Income', 'Income', 1, 'I', '1', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(10, '401', 'Default Expense', 'Expense', 1, 'E', '1', '2', NULL, NULL, '1', '1', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(11, '402', 'Material Purchase', 'Expense', 1, 'E', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(12, '403', 'Employee Salary', 'Expense', 1, 'E', '1', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(13, '501', 'Non Current Liabilities', 'Liabilities', 1, 'L', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(14, '502', 'Current Liabilities', 'Liabilities', 1, 'L', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(15, '10101', 'Inventory', 'Non Current Asset', 1, 'A', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(16, '10201', 'Cash & Cash Equivalent', 'Current Asset', 2, 'A', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(17, '10202', 'Account Receivable', 'Current Asset', 2, 'A', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(18, '50201', 'Account Payable', 'Current Liabilities', 2, 'L', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(19, '50202', 'Employee Ledger', 'Current Liabilities', 2, 'L', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(20, '1020101', 'Cash In Hand', 'Cash & Cash Equivalent', 3, 'A', '1', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(21, '1020102', 'Cash At Bank', 'Cash & Cash Equivalent', 3, 'A', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(22, '1020103', 'Cash At Mobile Bank', 'Cash & Cash Equivalent', 3, 'A', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(23, '1020201', 'Customer Receivable', 'Account Receivable', 3, 'A', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(24, '1020202', 'Loan Receivable', 'Account Receivable', 3, 'A', '2', '1', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(25, '10202010001', '1-Walking Customer', 'Customer Receivable', 4, 'A', '1', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-01-26 23:00:44', '2021-01-26 23:00:44'),
(26, '102010201', 'Dutch Bangla Bank Ltd.', 'Cash At Bank', 4, 'A', '1', '2', NULL, NULL, '2', '2', 0, '1', 'Super Admin', NULL, '2021-01-26 23:55:38', '2021-01-26 23:55:38'),
(27, '102010202', 'Standard Chartard Bank Ltd.', 'Cash At Bank', 4, 'A', '1', '2', NULL, NULL, '2', '2', 0, '1', 'Super Admin', NULL, '2021-01-26 23:56:01', '2021-01-26 23:56:01'),
(30, '102010302', 'Rocket', 'Cash At Mobile Bank', 4, 'A', '1', '2', NULL, NULL, '2', '2', 0, '1', 'Super Admin', 'Super Admin', '2021-01-27 00:24:08', '2021-01-27 00:28:26'),
(31, '5020101', '1-Mr. AAA', 'Account Payable', 3, 'L', '1', '2', NULL, 1, '2', '2', 0, '1', 'Super Admin', NULL, '2021-01-27 03:58:54', '2021-01-27 03:58:54'),
(32, '5020102', '2-Mr. BBB', 'Account Payable', 3, 'L', '1', '2', NULL, 2, '2', '2', 0, '1', 'Super Admin', NULL, '2021-01-27 03:59:07', '2021-01-27 03:59:07'),
(33, '5020103', '3-Mr. CCC', 'Account Payable', 3, 'L', '1', '2', NULL, 3, '2', '2', 0, '1', 'Super Admin', NULL, '2021-01-28 00:03:27', '2021-01-28 00:03:27'),
(35, '10202010002', '7-Mr. Arman', 'Customer Receivable', 4, 'A', '1', '2', 7, NULL, '2', '2', 0, '1', 'Mohammad Arman', NULL, '2021-02-07 02:03:54', '2021-02-07 02:03:54'),
(36, '50203', 'Tax', 'Current Liabilities', 2, 'L', '2', '2', NULL, NULL, '2', '2', 0, '1', 'SuperAdmin', NULL, '2021-02-09 06:48:05', NULL),
(37, '10202010003', '8-Mr. Rahman', 'Customer Receivable', 4, 'A', '1', '2', 8, NULL, '2', '2', 0, '1', 'Mr. XYZ', NULL, '2021-02-09 23:19:17', '2021-02-09 23:19:17'),
(38, '10202010004', '9-Mr. Abul', 'Customer Receivable', 4, 'A', '1', '2', 9, NULL, '2', '2', 0, '1', 'Mr. XYZ', NULL, '2021-02-09 23:19:59', '2021-02-09 23:19:59'),
(39, '10202010005', '10-Mr. Rabiul', 'Customer Receivable', 4, 'A', '1', '2', 10, NULL, '2', '2', 0, '1', 'Mohammad Arman', NULL, '2021-02-09 23:35:54', '2021-02-09 23:35:54'),
(40, '4000001', '3-Utility Bill', 'Expense', 1, 'E', '1', '2', NULL, NULL, '1', '1', 1, '1', 'Super Admin', NULL, '2021-03-07 23:05:01', '2021-03-07 23:07:56'),
(41, '4000002', '4-Maintainance BIll', 'Expense', 1, 'E', '1', '2', NULL, NULL, '1', '1', 1, '1', 'Super Admin', NULL, '2021-03-07 23:05:16', '2021-03-07 23:07:49'),
(42, '502020001', '1-Mohmmad Arman', 'Employee Ledger', 3, 'L', '1', '2', NULL, NULL, '2', '2', 0, '1', 'Super Admin', NULL, '2021-03-20 23:33:23', '2021-03-20 23:33:23'),
(43, '502020002', '2-Md. Shahed', 'Employee Ledger', 3, 'L', '1', '2', NULL, NULL, '2', '2', 0, '1', 'Super Admin', NULL, '2021-03-21 05:57:42', '2021-03-21 05:57:42'),
(44, '10202010006', '11-Mr. XYZ', 'Customer Receivable', 4, 'A', '1', '2', 11, NULL, '2', '2', 0, '1', 'Super Admin', NULL, '2021-05-31 05:31:50', '2021-05-31 05:31:50');

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
  `customer_group_id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `upazila_id` bigint(20) UNSIGNED NOT NULL,
  `route_id` bigint(20) UNSIGNED NOT NULL,
  `postal_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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

INSERT INTO `customers` (`id`, `name`, `shop_name`, `mobile`, `email`, `customer_group_id`, `district_id`, `upazila_id`, `route_id`, `postal_code`, `address`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(7, 'Mr. Arman', 'AR', '0152122552', '', 2, 46, 425, 566, '', 'abshdbsdfjsbd', '1', 'Mohammad Arman', NULL, '2021-02-07 02:03:54', '2021-02-07 02:03:54'),
(8, 'Mr. Rahman', 'Rahman Store', '01521223698', '', 2, 1, 70, 573, '1122', 'Lorem ipsum dollar demura', '1', 'Mr. XYZ', NULL, '2021-02-09 23:19:17', '2021-02-09 23:19:17'),
(9, 'Mr. Abul', 'Abul Store', '015212256984', '', 2, 1, 70, 574, '1123', 'Lorem ipsum dollar serup dollar', '1', 'Mr. XYZ', NULL, '2021-02-09 23:19:59', '2021-02-09 23:19:59'),
(10, 'Mr. Rabiul', 'rabiul', '01521225689', '', 2, 46, 421, 567, '', 'Lorem ipsum dollar', '1', 'Mohammad Arman', NULL, '2021-02-09 23:35:54', '2021-02-23 00:00:54'),
(11, 'Mr. XYZ', 'XYZ', '01585986520', '', 2, 46, 425, 566, '1212', 'lorem ipsum dollar', '1', 'Super Admin', NULL, '2021-05-31 05:31:50', '2021-05-31 05:31:50');

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
  `updated_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_groups`
--

INSERT INTO `customer_groups` (`id`, `group_name`, `percentage`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(2, 'Regular', 0.00, '1', 'Super Admin', NULL, '2021-02-02 05:20:01', '2021-02-02 05:20:01'),
(3, 'Dealer', 0.50, '1', 'Super Admin', NULL, '2021-02-02 05:20:55', '2021-02-02 05:20:55'),
(4, 'Retailer', 0.80, '1', 'Super Admin', NULL, '2021-02-02 05:21:17', '2021-02-02 05:21:17');

-- --------------------------------------------------------

--
-- Table structure for table `daily_bankings`
--

CREATE TABLE `daily_bankings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bank_id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `deposit_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `daily_closings`
--

CREATE TABLE `daily_closings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `last_day_closing` double DEFAULT NULL,
  `cash_in` double DEFAULT NULL,
  `cash_out` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
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

INSERT INTO `daily_closings` (`id`, `warehouse_id`, `last_day_closing`, `cash_in`, `cash_out`, `amount`, `adjustment`, `date`, `thousands`, `five_hundred`, `hundred`, `fifty`, `twenty`, `ten`, `five`, `two`, `one`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(2, 2, 0, 10450, 0, 10450, NULL, '2021-02-11', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Mohammad Arman', '0', '2021-02-11 03:25:08', '2021-02-11 03:25:08'),
(4, 2, 10450, 0, 0, 10450, NULL, '2021-02-24', '10', '0', '0', '1', '0', '0', '0', '0', '0', 'Super Admin', '0', '2021-02-23 23:13:02', '2021-02-23 23:13:02'),
(5, 3, 0, 0, 0, 0, NULL, '2021-02-24', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Super Admin', '0', '2021-02-23 23:13:51', '2021-02-23 23:13:51');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `deletable` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=No, 2=Yes',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `status`, `deletable`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'HR', '1', '1', 'Super Admin', NULL, '2021-03-07 02:43:42', '2021-03-07 02:43:42'),
(2, 'Accounts', '1', '1', 'Super Admin', NULL, '2021-03-07 02:43:53', '2021-03-07 02:43:53'),
(3, 'Sales', '1', '2', 'Super Admin', NULL, '2021-03-07 02:44:03', '2021-03-07 02:44:03'),
(4, 'IT', '1', '1', 'Super Admin', 'Super Admin', '2021-03-07 02:44:11', '2021-03-07 02:44:25'),
(5, 'Production', '1', '2', 'Super Admin', NULL, '2021-03-07 02:57:53', '2021-03-07 02:57:53');

-- --------------------------------------------------------

--
-- Table structure for table `designations`
--

CREATE TABLE `designations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `deletable` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=No, 2=Yes',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `designations`
--

INSERT INTO `designations` (`id`, `name`, `status`, `deletable`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'CEO', '1', '1', 'Super Admin', NULL, '2021-03-07 02:58:45', '2021-03-07 02:58:45'),
(2, 'General Manage', '1', '1', 'Super Admin', NULL, '2021-03-07 02:59:21', '2021-03-07 02:59:21'),
(3, 'Assistant General Manager', '1', '1', 'Super Admin', NULL, '2021-03-07 02:59:42', '2021-03-07 02:59:42'),
(4, 'Manager', '1', '2', 'Super Admin', NULL, '2021-03-07 03:00:02', '2021-03-07 03:00:02'),
(5, 'Sr. Executive', '1', '2', 'Super Admin', NULL, '2021-03-07 03:00:14', '2021-03-07 03:00:14'),
(6, 'Executive', '1', '2', 'Super Admin', NULL, '2021-03-07 03:00:22', '2021-03-07 03:00:22'),
(7, 'Jr. Executive', '1', '2', 'Super Admin', NULL, '2021-03-07 03:00:31', '2021-03-07 03:00:31'),
(8, 'Staff', '1', '2', 'Super Admin', NULL, '2021-03-07 03:00:41', '2021-03-07 03:00:41'),
(9, 'Worker', '1', '2', 'Super Admin', NULL, '2021-03-07 03:00:48', '2021-03-07 03:00:48');

-- --------------------------------------------------------

--
-- Table structure for table `divisions`
--

CREATE TABLE `divisions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `deletable` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=No, 2=Yes',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `divisions`
--

INSERT INTO `divisions` (`id`, `name`, `department_id`, `status`, `deletable`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 1, '1', '1', 'Super Admin', NULL, '2021-03-07 02:56:23', '2021-03-07 02:56:23'),
(2, 'Networking', 4, '1', '2', 'Super Admin', NULL, '2021-03-07 02:56:42', '2021-03-07 02:56:42'),
(3, 'Software', 4, '1', '1', 'Super Admin', NULL, '2021-03-07 02:56:52', '2021-03-07 02:56:52'),
(4, 'Packaging', 5, '1', '2', 'Super Admin', NULL, '2021-03-07 02:58:31', '2021-03-07 02:58:31');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photograph` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternative_phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `upazila_id` bigint(20) UNSIGNED NOT NULL,
  `zipcode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `division_id` bigint(20) UNSIGNED NOT NULL,
  `job_status` enum('1','2','3','4') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Permanent,2=Probation,3=Resigned,4=Suspended',
  `duty_type` enum('1','2','3','4') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Full Time,2=Part Time,3=Contractual,4=Other',
  `joining_designation_id` bigint(20) UNSIGNED NOT NULL,
  `current_designation_id` bigint(20) UNSIGNED NOT NULL,
  `joining_date` date DEFAULT NULL,
  `probation_start` date DEFAULT NULL,
  `probation_end` date DEFAULT NULL,
  `contract_start` date DEFAULT NULL,
  `contract_end` date DEFAULT NULL,
  `confirmation_date` date DEFAULT NULL,
  `termination_date` date DEFAULT NULL,
  `termination_reason` text COLLATE utf8mb4_unicode_ci,
  `rate_type` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Hourly,2=Salary',
  `rate` double NOT NULL,
  `joining_rate` double DEFAULT NULL,
  `overtime` enum('1','2') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1=Allowed,2=Not Allowed',
  `pay_freequency` enum('1','2','3','4') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Weekly,2=Biweekly,3=Monthly,4=Annual',
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supervisor_id` int(10) UNSIGNED DEFAULT NULL,
  `is_supervisor` enum('1','2') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1=Yes,2=No',
  `father_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Male,2=Female,3=Other',
  `marital_status` enum('1','2','3','4','5') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Single,2=Married,3=Divorced,4=Widowed,5=Other',
  `blood_group` enum('1','2','3','4','5','6','7','8') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=A+,2=B+,3=A-,4=B-,5=AB+,6=AB-,7=O+,8=O-',
  `religion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nid_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nid_photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `residential_status` enum('1','2') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1=Resident,2=Non-Resident',
  `emergency_contact_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_contact_relation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_contact_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternative_emergency_contact_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternative_emergency_contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternative_emergency_contact_relation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternative_emergency_contact_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `warehouse_id`, `name`, `email`, `phone`, `photograph`, `alternative_phone`, `district_id`, `upazila_id`, `zipcode`, `address`, `employee_id`, `department_id`, `division_id`, `job_status`, `duty_type`, `joining_designation_id`, `current_designation_id`, `joining_date`, `probation_start`, `probation_end`, `contract_start`, `contract_end`, `confirmation_date`, `termination_date`, `termination_reason`, `rate_type`, `rate`, `joining_rate`, `overtime`, `pay_freequency`, `bank_name`, `account_no`, `supervisor_id`, `is_supervisor`, `father_name`, `mother_name`, `dob`, `gender`, `marital_status`, `blood_group`, `religion`, `nid_no`, `nid_photo`, `residential_status`, `emergency_contact_name`, `emergency_contact_phone`, `emergency_contact_relation`, `emergency_contact_address`, `alternative_emergency_contact_name`, `alternative_emergency_contact_phone`, `alternative_emergency_contact_relation`, `alternative_emergency_contact_address`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 2, 'Mohmmad Arman', 'mohammadarman.iiuc.cse@gmail.com', '01521225987', 'arman-443911.jpg', '01680950265', 46, 425, '3850', 'Ana Miar Bari, Mohorbag - Uttar Kushulla, Feni-3850', '20200321001', 4, 3, '1', '1', 6, 6, '2020-10-03', '2020-10-03', '2020-10-03', '0000-00-00', '0000-00-00', '2020-10-03', '0000-00-00', '', '2', 35000, 2020, '2', '3', 'DBBL', '546484456456', 0, '1', 'Md. Giaus Uddin', 'Aliya Begum', '1994-11-27', '1', '1', '7', 'Islam', '546485646', 'smartcard-wb-833569.jpg', '2', 'Nazmul Hyder Nishat', '01830055496', 'Friend', 'Lorem ipsum dollar', 'Mohammad Shahed', '01626969219', 'Friend', 'Lorem ipsum dollar', '1', 'Super Admin', 'Super Admin', '2021-03-20 23:33:23', '2021-03-21 05:09:32'),
(2, 1, 'Md. Shahed', 'shahed@gmail.com', '01626939219', NULL, '', 43, 381, '', 'Lorem ipsum dopllar', '202003210002', 4, 2, '1', '1', 6, 6, '2021-02-01', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '', '2', 32000, 32000, '2', '3', 'DBBL', '456456454564', 1, '2', 'Mr. XYZ', 'Mrs. XYZ', '1994-11-01', '1', '1', '2', 'Islam', '546446554', 'smartcard-wb-284063.jpg', '1', 'Mohammad Arman', '`01521225987', 'Friend', 'lorem ipsu d ollar', '', '', '', '', '1', 'Super Admin', NULL, '2021-03-21 05:57:42', '2021-03-21 05:57:42');

-- --------------------------------------------------------

--
-- Table structure for table `employee_education`
--

CREATE TABLE `employee_education` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `degree` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `major` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `institute` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `passing_year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `result` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_education`
--

INSERT INTO `employee_education` (`id`, `employee_id`, `degree`, `major`, `institute`, `passing_year`, `result`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(4, 1, 'Bachelor of Science', 'Computer Science & Engineering', 'IIUC', '2018', '3.33', 'Super Admin', NULL, '2021-03-21 05:09:32', NULL),
(5, 2, 'B.Sc.', 'CSE', 'IIUC', '2017', '3.48', 'Super Admin', NULL, '2021-03-21 05:57:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee_professional_information`
--

CREATE TABLE `employee_professional_information` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `designation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `responsibility` text COLLATE utf8mb4_unicode_ci,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_professional_information`
--

INSERT INTO `employee_professional_information` (`id`, `employee_id`, `designation`, `company`, `from_date`, `to_date`, `responsibility`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(7, 1, 'Asst. Software Engineer', 'Ky Steel', '2018-08-28', '2020-09-30', 'Developed CRM, POS', 'Super Admin', NULL, '2021-03-21 05:09:32', NULL),
(8, 1, 'Junior Software Engineer', 'CHTL', '2018-01-01', '2018-03-06', 'Developed CRM, POS', 'Super Admin', NULL, '2021-03-21 05:09:32', NULL),
(9, 2, 'Software Engineer', 'Cursor IT', '2018-01-01', '2021-01-30', 'Developed Software', 'Super Admin', NULL, '2021-03-21 05:57:42', NULL);

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
(2, 1, 3, 'EXP-20210308090602991', 5000, '2021-03-08', '1', 20, 'Gas and Electricity bill', 'Super Admin', NULL, '2021-03-08 03:06:02', '2021-03-08 03:06:02'),
(3, 2, 4, 'EXP-20210308090657519', 3000, '2021-03-08', '3', 30, 'Electricity and gas bill', 'Super Admin', 'Super Admin', '2021-03-08 03:06:57', '2021-03-08 03:18:10'),
(4, 3, 3, 'EXP-20210308092435849', 3500, '2021-03-08', '2', 26, 'Gas and Electricity Bill', 'Super Admin', NULL, '2021-03-08 03:24:35', '2021-03-08 03:24:35'),
(5, 1, 4, 'EXP-20210308092500798', 4500, '2021-03-08', '2', 27, 'Maintainance cost', 'Super Admin', NULL, '2021-03-08 03:25:00', '2021-03-08 03:25:00');

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
(3, 'Utility Bill', '1', 'Super Admin', 'Super Admin', '2021-03-07 23:05:01', '2021-03-07 23:07:56'),
(4, 'Maintainance BIll', '1', 'Super Admin', 'Super Admin', '2021-03-07 23:05:16', '2021-03-07 23:07:49');

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
-- Table structure for table `finished_goods_materials`
--

CREATE TABLE `finished_goods_materials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `production_id` bigint(20) UNSIGNED NOT NULL,
  `production_finished_good_id` bigint(20) UNSIGNED NOT NULL,
  `material_id` bigint(20) UNSIGNED NOT NULL,
  `total_qty` double DEFAULT NULL,
  `used_qty` double(8,2) DEFAULT NULL,
  `damaged_qty` double(8,2) DEFAULT NULL,
  `odd_qty` double(8,2) DEFAULT NULL,
  `direct_cost` double DEFAULT NULL,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `finished_goods_materials`
--

INSERT INTO `finished_goods_materials` (`id`, `production_id`, `production_finished_good_id`, `material_id`, `total_qty`, `used_qty`, `damaged_qty`, `odd_qty`, `direct_cost`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(19, 7, 1, 1, 1000, 900.00, 100.00, NULL, 200, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-26 04:06:50'),
(20, 7, 1, 11, 2, 2.00, NULL, NULL, 40, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-26 04:06:50'),
(21, 7, 1, 13, 5, 3.00, 1.00, 1.00, 8, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-26 04:06:50'),
(22, 7, 2, 1, 100, 50.00, 10.00, 40.00, 12, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-02-27 21:47:16'),
(23, 7, 2, 11, 2, 1.00, NULL, 1.00, 20, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-02-27 21:47:16'),
(24, 7, 2, 13, 10, 10.00, NULL, NULL, 20, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-02-27 21:47:16'),
(25, 7, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-24 06:33:52'),
(26, 7, 3, 11, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-24 06:33:52'),
(27, 7, 3, 13, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-24 06:33:52'),
(28, 7, 4, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-24 06:33:52'),
(29, 7, 4, 11, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-24 06:33:52'),
(30, 7, 4, 13, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-24 06:33:52'),
(31, 7, 5, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-24 06:33:52'),
(32, 7, 5, 11, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-24 06:33:52'),
(33, 7, 5, 13, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-24 06:33:52'),
(34, 7, 6, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-24 06:33:52'),
(35, 7, 6, 11, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-24 06:33:52'),
(36, 7, 6, 13, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-01-24 06:33:52', '2021-01-24 06:33:52'),
(37, 18, 7, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(38, 18, 7, 11, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(39, 18, 8, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(40, 18, 8, 11, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(41, 18, 9, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(42, 18, 9, 11, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(43, 18, 10, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(44, 18, 10, 11, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(45, 18, 11, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(46, 18, 11, 11, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(47, 18, 12, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(48, 18, 12, 11, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(49, 19, 13, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(50, 19, 13, 12, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(51, 19, 13, 13, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(52, 19, 14, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(53, 19, 14, 12, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(54, 19, 14, 13, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(55, 19, 15, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(56, 19, 15, 12, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(57, 19, 15, 13, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(58, 19, 16, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(59, 19, 16, 12, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(60, 19, 16, 13, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(61, 19, 17, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(62, 19, 17, 12, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(63, 19, 17, 13, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(64, 19, 18, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(65, 19, 18, 12, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(66, 19, 18, 13, NULL, NULL, NULL, NULL, NULL, NULL, 'Super Admin', '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(67, 20, 19, 1, 10000, 8000.00, NULL, 2000.00, 800, 'Super Admin', 'Super Admin', '2021-06-02 00:43:55', '2021-06-02 00:48:01'),
(68, 20, 19, 12, 10, 10.00, NULL, NULL, 100, 'Super Admin', 'Super Admin', '2021-06-02 00:43:55', '2021-06-02 00:48:01'),
(69, 20, 19, 13, 15, 10.00, NULL, 5.00, 100, 'Super Admin', 'Super Admin', '2021-06-02 00:43:55', '2021-06-02 00:48:01'),
(70, 20, 20, 1, 10000, 10000.00, NULL, NULL, 1000, 'Super Admin', 'Super Admin', '2021-06-02 00:43:55', '2021-06-02 00:49:52'),
(71, 20, 20, 12, 10, 10.00, NULL, NULL, 100, 'Super Admin', 'Super Admin', '2021-06-02 00:43:55', '2021-06-02 00:49:52'),
(72, 20, 20, 13, 10, 10.00, NULL, NULL, 100, 'Super Admin', 'Super Admin', '2021-06-02 00:43:55', '2021-06-02 00:49:52'),
(73, 20, 21, 1, 32000, 30000.00, NULL, 2000.00, 3000, 'Super Admin', 'Super Admin', '2021-06-02 00:43:55', '2021-06-02 00:51:12'),
(74, 20, 21, 12, 30, 20.00, NULL, 10.00, 200, 'Super Admin', 'Super Admin', '2021-06-02 00:43:55', '2021-06-02 00:51:12'),
(75, 20, 21, 13, 30, 20.00, NULL, 10.00, 200, 'Super Admin', 'Super Admin', '2021-06-02 00:43:55', '2021-06-02 00:51:12');

-- --------------------------------------------------------

--
-- Table structure for table `finish_goods`
--

CREATE TABLE `finish_goods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `size_id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_id` bigint(20) UNSIGNED NOT NULL,
  `sale_unit_id` bigint(20) UNSIGNED NOT NULL,
  `cost` double(8,2) DEFAULT NULL,
  `price` double(8,2) DEFAULT NULL,
  `qty` double(8,2) DEFAULT NULL,
  `opening_stock_qty` double(8,2) DEFAULT NULL,
  `alert_qty` double(8,2) DEFAULT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `finish_goods`
--

INSERT INTO `finish_goods` (`id`, `product_id`, `size_id`, `code`, `unit_id`, `sale_unit_id`, `cost`, `price`, `qty`, `opening_stock_qty`, `alert_qty`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(12, 2, 2, '9780000000001', 8, 8, 2.50, 18.00, 427.00, 100.00, 20.00, '1', 'Super Admin', NULL, '2021-01-23 01:17:15', '2021-06-02 02:14:07'),
(13, 2, 5, '9780000000002', 8, 8, 6.00, 35.00, 315.00, 100.00, 20.00, '1', 'Super Admin', NULL, '2021-01-23 01:17:15', '2021-06-02 00:49:52'),
(14, 2, 6, '9780000000003', 8, 8, 11.33, 55.00, 400.00, 100.00, 20.00, '1', 'Super Admin', NULL, '2021-01-23 01:17:15', '2021-06-02 00:51:12'),
(15, 2, 8, '9780000000004', 8, 8, 100.00, 110.00, 95.00, 100.00, 20.00, '1', 'Super Admin', NULL, '2021-01-23 01:17:15', '2021-02-14 01:28:17'),
(16, 2, 14, '9780000000005', 8, 8, 180.00, 190.00, 100.00, 100.00, 20.00, '1', 'Super Admin', NULL, '2021-01-23 01:17:15', '2021-02-14 02:28:41'),
(17, 2, 16, '9780000000006', 8, 8, 300.00, 320.00, 100.00, 100.00, 20.00, '1', 'Super Admin', 'Super Admin', '2021-01-23 01:17:15', '2021-02-14 02:28:41'),
(18, 7, 2, '9347001000013', 8, 8, 3.00, 15.00, 100.00, 100.00, 10.00, '1', 'Super Admin', NULL, '2021-03-01 21:33:26', '2021-03-01 21:33:26'),
(19, 7, 5, '9347001000014', 8, 8, 5.00, 25.00, 100.00, 100.00, 10.00, '1', 'Super Admin', NULL, '2021-03-01 21:33:26', '2021-03-01 21:33:26'),
(20, 7, 6, '9347001000015', 8, 8, 15.00, 40.00, 100.00, 100.00, 10.00, '1', 'Super Admin', NULL, '2021-03-01 21:33:26', '2021-03-01 21:33:26'),
(24, 7, 14, '9347001000016', 8, 8, 50.00, 75.00, 100.00, 100.00, NULL, '1', 'Super Admin', NULL, '2021-03-01 21:42:12', '2021-03-01 21:42:12'),
(25, 8, 6, '9347001000017', 8, 8, 50.00, 70.00, 10.00, 50.00, NULL, '1', 'Super Admin', NULL, '2021-03-01 21:44:05', '2021-06-01 22:53:19');

-- --------------------------------------------------------

--
-- Table structure for table `finish_goods_sales`
--

CREATE TABLE `finish_goods_sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` bigint(20) UNSIGNED NOT NULL,
  `finish_goods_id` bigint(20) UNSIGNED NOT NULL,
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
-- Dumping data for table `finish_goods_sales`
--

INSERT INTO `finish_goods_sales` (`id`, `sale_id`, `finish_goods_id`, `qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 25, 10, 8, 70, 0, 0, 0, 700, '2021-06-01 23:22:16', '2021-06-01 23:22:16'),
(2, 2, 25, 1, 9, 840, 0, 0, 0, 840, '2021-06-02 01:20:07', '2021-06-02 01:20:07');

-- --------------------------------------------------------

--
-- Table structure for table `finish_goods_transfers`
--

CREATE TABLE `finish_goods_transfers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transfer_id` bigint(20) UNSIGNED NOT NULL,
  `finish_goods_id` bigint(20) UNSIGNED NOT NULL,
  `qty` double NOT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `net_unit_cost` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `finish_goods_transfers`
--

INSERT INTO `finish_goods_transfers` (`id`, `transfer_id`, `finish_goods_id`, `qty`, `unit_id`, `net_unit_cost`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(3, 3, 12, 3, 8, 14.29, 5, 2.14, 45, '2021-02-13 23:39:27', '2021-02-14 01:28:17'),
(4, 3, 13, 5, 8, 28.57, 5, 7.14, 150, '2021-02-13 23:39:27', '2021-02-14 01:28:17'),
(5, 3, 15, 5, 8, 95.24, 5, 23.81, 500, '2021-02-13 23:39:27', '2021-02-14 01:28:17'),
(6, 4, 25, 40, 8, 50, 0, 0, 2000, '2021-06-01 22:53:19', '2021-06-01 22:53:19'),
(7, 5, 12, 10, 9, 28.57, 5, 14.29, 300, '2021-06-02 02:14:08', '2021-06-02 02:14:08');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `grand_parent_id` int(10) UNSIGNED DEFAULT NULL,
  `type` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=District, 2=Upazila, 3=Route',
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `parent_id`, `grand_parent_id`, `type`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Dhaka', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(2, 'Faridpur', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(3, 'Gazipur', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(4, 'Gopalganj', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(5, 'Jamalpur', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(6, 'Kishoreganj', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(7, 'Madaripur', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(8, 'Manikganj', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(9, 'Munshiganj', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(10, 'Mymensingh', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(11, 'Narayanganj', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(12, 'Narsingdi', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(13, 'Netrokona', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(14, 'Rajbari', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(15, 'Shariatpur', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(16, 'Sherpur', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(17, 'Tangail', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(18, 'Bogra', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(19, 'Joypurhat', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(20, 'Naogaon', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(21, 'Natore', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(22, 'Nawabganj', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(23, 'Pabna', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(24, 'Rajshahi', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(25, 'Sirajgonj', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(26, 'Dinajpur', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(27, 'Gaibandha', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(28, 'Kurigram', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(29, 'Lalmonirhat', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(30, 'Nilphamari', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(31, 'Panchagarh', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(32, 'Rangpur', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(33, 'Thakurgaon', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(34, 'Barguna', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(35, 'Barisal', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(36, 'Bhola', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(37, 'Jhalokati', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(38, 'Patuakhali', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(39, 'Pirojpur', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(40, 'Bandarban', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(41, 'Brahmanbaria', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(42, 'Chandpur', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(43, 'Chittagong', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(44, 'Comilla', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(45, 'Cox\'s Bazar', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(46, 'Feni', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(47, 'Khagrachari', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(48, 'Lakshmipur', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(49, 'Noakhali', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(50, 'Rangamati', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(51, 'Habiganj', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(52, 'Maulvibazar', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(53, 'Sunamganj', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(54, 'Sylhet', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(55, 'Bagerhat', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(56, 'Chuadanga', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(57, 'Jessore', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(58, 'Jhenaidah', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(59, 'Khulna', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(60, 'Kushtia', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(61, 'Magura', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(62, 'Meherpur', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(63, 'Narail', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(64, 'Satkhira', 0, NULL, '1', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(65, 'Gulsan 1', 1, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(66, 'Dhamrai Upazila', 1, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(67, 'Dohar Upazila', 1, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(68, 'Keraniganj Upazila', 1, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(69, 'Nawabganj Upazila', 1, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(70, 'Savar Upazila', 1, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(71, 'Charbhadrasan Upazila', 2, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(72, 'Sadarpur Upazila', 2, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(73, 'Shaltha Upazila', 2, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(74, 'Nagarkanda Upazila', 2, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(75, 'Bhanga Upazila', 2, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(76, 'Madhukhali Upazila', 2, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(77, 'Alfadanga Upazila', 2, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(78, 'Boalmari Upazila', 2, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(79, 'Faridpur Sadar Upazila', 2, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(80, 'Tongi', 3, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(81, 'Kaliganj', 3, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(82, 'Sripur', 3, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(83, 'Kapasia', 3, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(84, 'Kaliakior', 3, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(85, 'Gazipur Sadar-Joydebpur', 3, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(86, 'Kotalipara Upazila', 4, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(87, 'Tungipara Upazila', 4, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(88, 'Muksudpur Upazila', 4, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(89, 'Kashiani Upazila', 4, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(90, 'Gopalganj Sadar Upazila', 4, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(91, 'Sarishabari Upazila', 5, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(92, 'Melandaha Upazila', 5, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(93, 'Narundi Police I.C', 5, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(94, 'Madarganj Upazila', 5, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(95, 'Jamalpur Sadar Upazila', 5, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(96, 'Islampur Upazila', 5, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(97, 'Baksiganj Upazila', 5, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(98, 'Dewanganj Upazila', 5, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(99, 'Tarail Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(100, 'Pakundia Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(101, 'Nikli Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(102, 'Mithamain Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(103, 'Kuliarchar Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(104, 'Kishoreganj Sadar Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(105, 'Karimganj Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(106, 'Itna Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(107, 'Astagram Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(108, 'Bajitpur Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(109, 'Hossainpur Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(110, 'Bhairab Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(111, 'Katiadi Upazila', 6, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(112, 'Kalkini', 7, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(113, 'Rajoir', 7, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(114, 'Madaripur Sadar', 7, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(115, 'Shibchar', 7, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(116, 'Harirampur Upazila', 8, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(117, 'Manikganj Sadar Upazila', 8, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(118, 'Daulatpur Upazila', 8, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(119, 'Ghior Upazila', 8, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(120, 'Singair Upazila', 8, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(121, 'Shibalaya Upazila', 8, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(122, 'Saturia Upazila', 8, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(123, 'Tongibari Upazila', 9, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(124, 'Sirajdikhan Upazila', 9, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(125, 'Munshiganj Sadar Upazila', 9, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(126, 'Sreenagar Upazila', 9, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(127, 'Gazaria Upazila', 9, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(128, 'Lohajang Upazila', 9, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(129, 'Nandail', 10, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(130, 'Phulpur', 10, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(131, 'Mymensingh Sadar', 10, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(132, 'Ishwarganj', 10, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(133, 'Gauripur', 10, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(134, 'Gaffargaon', 10, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(135, 'Fulbaria', 10, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(136, 'Dhobaura', 10, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(137, 'Trishal', 10, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(138, 'Haluaghat', 10, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(139, 'Bhaluka', 10, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(140, 'Muktagachha', 10, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(141, 'Rupganj Upazila', 11, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(142, 'Naryanganj Sadar Upazila', 11, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(143, 'Bandar', 11, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(144, 'Sonargaon Upazila', 11, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(145, 'Araihazar Upazila', 11, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(146, 'Siddirgonj Upazila', 11, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(147, 'Shibpur Upazila', 12, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(148, 'Raipura Upazila, Narsingdi', 12, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(149, 'Palash Upazila', 12, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(150, 'Narsingdi Sadar Upazila', 12, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(151, 'Monohardi Upazila', 12, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(152, 'Belabo Upazila', 12, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(153, 'Khaliajuri Upazilla', 13, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(154, 'Purbadhala Upazilla', 13, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(155, 'Netrakona-S Upazilla', 13, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(156, 'Mohanganj Upazilla', 13, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(157, 'Madan Upazilla', 13, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(158, 'Kalmakanda Upazilla', 13, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(159, 'Durgapur Upazilla', 13, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(160, 'Barhatta Upazilla', 13, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(161, 'Atpara Upazilla', 13, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(162, 'Kendua Upazilla', 13, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(163, 'Rajbari Sadar Upazila', 14, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(164, 'Kalukhali Upazila', 14, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(165, 'Pangsha Upazila', 14, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(166, 'Goalandaghat Upazila', 14, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(167, 'Baliakandi Upazila', 14, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(168, 'Gosairhat Upazila', 15, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(169, 'Bhedarganj Upazila', 15, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(170, 'Jajira Upazila', 15, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(171, 'Damudya Upazila', 15, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(172, 'Shariatpur Sadar -Palong', 15, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(173, 'Naria Upazila', 15, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(174, 'Sreebardi Upazila', 16, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(175, 'Sherpur Sadar Upazila', 16, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(176, 'Nalitabari Upazila', 16, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(177, 'Nakla Upazila', 16, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(178, 'Jhenaigati Upazila', 16, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(179, 'Tangail Sadar Upazila', 17, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(180, 'Sakhipur Upazila', 17, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(181, 'Basail Upazila', 17, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(182, 'Madhupur Upazila', 17, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(183, 'Ghatail Upazila', 17, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(184, 'Kalihati Upazila', 17, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(185, 'Dhanbari Upazila', 17, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(186, 'Bhuapur Upazila', 17, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(187, 'Delduar Upazila', 17, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(188, 'Gopalpur Upazila', 17, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(189, 'Mirzapur Upazila', 17, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(190, 'Nagarpur Upazila', 17, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(191, 'Sonatala', 18, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(192, 'Shibganj', 18, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(193, 'Sariakandi', 18, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(194, 'Sahajanpur', 18, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(195, 'Nandigram', 18, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(196, 'Kahaloo', 18, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(197, 'Adamdighi', 18, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(198, 'Gabtali', 18, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(199, 'Dhupchanchia', 18, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(200, 'Dhunat', 18, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(201, 'Bogra Sadar', 18, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(202, 'Panchbibi', 19, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(203, 'Khetlal', 19, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(204, 'Kalai', 19, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(205, 'Joypurhat S', 19, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(206, 'Akkelpur', 19, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(207, 'Patnitala Upazila', 20, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(208, 'Dhamoirhat Upazila', 20, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(209, 'Sapahar Upazila', 20, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(210, 'Porsha Upazila', 20, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(211, 'Badalgachhi Upazila', 20, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(212, 'Atrai Upazila', 20, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(213, 'Niamatpur Upazila', 20, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(214, 'Raninagar Upazila', 20, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(215, 'Manda Upazila', 20, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(216, 'Mohadevpur Upazila', 20, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(217, 'Naogaon Sadar Upazila', 20, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(218, 'Baraigram Upazila', 21, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(219, 'Natore Sadar Upazila', 21, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(220, 'Lalpur Upazila', 21, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(221, 'Bagatipara Upazila', 21, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(222, 'Shibganj Upazila', 22, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(223, 'Nawabganj Sadar Upazila', 22, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(224, 'Nachole Upazila', 22, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(225, 'Gomastapur Upazila', 22, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(226, 'Bholahat Upazila', 22, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(227, 'Sujanagar Upazila', 23, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(228, 'Santhia Upazila', 23, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(229, 'Pabna Sadar Upazila', 23, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(230, 'Ishwardi Upazila', 23, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(231, 'Faridpur Upazila', 23, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(232, 'Chatmohar Upazila', 23, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(233, 'Bhangura Upazila', 23, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(234, 'Bera Upazila', 23, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(235, 'Atgharia Upazila', 23, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(236, 'Godagari', 24, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(237, 'Tanore', 24, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(238, 'Puthia', 24, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(239, 'Paba', 24, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(240, 'Mohanpur', 24, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(241, 'Durgapur', 24, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(242, 'Charghat', 24, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(243, 'Bagmara', 24, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(244, 'Bagha', 24, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(245, 'Chauhali Upazila', 25, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(246, 'Ullahpara Upazila', 25, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(247, 'Tarash Upazila', 25, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(248, 'Shahjadpur Upazila', 25, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(249, 'Raiganj Upazila', 25, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(250, 'Kazipur Upazila', 25, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(251, 'Kamarkhanda Upazila', 25, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(252, 'Belkuchi Upazila', 25, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(253, 'Sirajganj Sadar Upazila', 25, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(254, 'Hakimpur Upazila', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(255, 'Kaharole Upazila', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(256, 'Khansama Upazila', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(257, 'Dinajpur Sadar Upazila', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(258, 'Nawabganj', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(259, 'Parbatipur Upazila', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(260, 'Ghoraghat Upazila', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(261, 'Phulbari Upazila', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(262, 'Chirirbandar Upazila', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(263, 'Bochaganj Upazila', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(264, 'Biral Upazila', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(265, 'Birganj', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(266, 'Birampur Upazila', 26, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(267, 'Sadullapur', 27, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(268, 'Saghata', 27, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(269, 'Sundarganj', 27, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(270, 'Palashbari', 27, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(271, 'Gaibandha sadar', 27, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(272, 'Fulchhari', 27, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(273, 'Gobindaganj', 27, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(274, 'Char Rajibpur', 28, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(275, 'Rowmari', 28, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(276, 'Chilmari', 28, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(277, 'Ulipur', 28, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(278, 'Rajarhat', 28, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(279, 'Phulbari', 28, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(280, 'Bhurungamari', 28, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(281, 'Nageshwari', 28, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(282, 'Kurigram Sadar', 28, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(283, 'Patgram', 29, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(284, 'Hatibandha', 29, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(285, 'Kaliganj', 29, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(286, 'Aditmari', 29, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(287, 'Lalmanirhat Sadar', 29, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(288, 'Dimla', 30, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(289, 'Domar', 30, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(290, 'Kishoreganj', 30, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(291, 'Jaldhaka', 30, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(292, 'Saidpur', 30, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(293, 'Nilphamari Sadar', 30, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(294, 'Panchagarh Sadar', 31, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(295, 'Debiganj', 31, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(296, 'Boda', 31, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(297, 'Atwari', 31, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(298, 'Tetulia', 31, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(299, 'Kaunia', 32, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(300, 'Badarganj', 32, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(301, 'Mithapukur', 32, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(302, 'Gangachara', 32, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(303, 'Rangpur Sadar', 32, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(304, 'Pirgachha', 32, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(305, 'Pirganj', 32, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(306, 'Taraganj', 32, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(307, 'Baliadangi Upazila', 33, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(308, 'Thakurgaon Sadar Upazila', 33, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(309, 'Pirganj Upazila', 33, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(310, 'Haripur Upazila', 33, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(311, 'Ranisankail Upazila', 33, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(312, 'Patharghata Upazila', 34, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(313, 'Betagi Upazila', 34, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(314, 'Barguna Sadar Upazila', 34, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(315, 'Bamna Upazila', 34, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(316, 'Taltali Upazila', 34, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(317, 'Amtali Upazila', 34, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(318, 'Gaurnadi Upazila', 35, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(319, 'Banaripara Upazila', 35, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(320, 'Hizla Upazila', 35, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(321, 'Mehendiganj Upazila', 35, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(322, 'Wazirpur Upazila', 35, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(323, 'Bakerganj Upazila', 35, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(324, 'Barisal Sadar Upazila', 35, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(325, 'Babuganj Upazila', 35, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(326, 'Muladi Upazila', 35, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(327, 'Agailjhara Upazila', 35, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(328, 'Daulatkhan Upazila', 36, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(329, 'Tazumuddin Upazila', 36, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(330, 'Manpura Upazila', 36, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(331, 'Lalmohan Upazila', 36, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(332, 'Char Fasson Upazila', 36, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(333, 'Burhanuddin Upazila', 36, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(334, 'Bhola Sadar Upazila', 36, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(335, 'Nalchity Upazila', 37, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(336, 'Rajapur Upazila', 37, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(337, 'Jhalokati Sadar Upazila', 37, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(338, 'Kathalia Upazila', 37, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(339, 'Mirzaganj Upazila', 38, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(340, 'Patuakhali Sadar Upazila', 38, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(341, 'Rangabali Upazila', 38, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(342, 'Dumki Upazila', 38, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(343, 'Kalapara Upazila', 38, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(344, 'Galachipa Upazila', 38, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(345, 'Dashmina Upazila', 38, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(346, 'Bauphal Upazila', 38, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(347, 'Zianagar', 39, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(348, 'Pirojpur Sadar', 39, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(349, 'Nazirpur', 39, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(350, 'Mathbaria', 39, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(351, 'Kaukhali', 39, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(352, 'Bhandaria', 39, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(353, 'Nesarabad', 39, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(354, 'Rowangchhari', 40, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(355, 'Ruma', 40, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(356, 'Ali kadam', 40, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(357, 'Naikhongchhari', 40, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(358, 'Lama', 40, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(359, 'Thanchi', 40, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(360, 'Bandarban Sadar', 40, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(361, 'Bancharampur Upazila', 41, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(362, 'Bijoynagar Upazila', 41, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(363, 'Ashuganj Upazila', 41, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(364, 'Akhaura Upazila', 41, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(365, 'Kasba Upazila', 41, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(366, 'Shahbazpur Town', 41, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(367, 'Sarail Upazila', 41, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(368, 'Nabinagar Upazila', 41, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(369, 'Nasirnagar Upazila', 41, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(370, 'Brahmanbaria Sadar Upazila', 41, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(371, 'Shahrasti', 42, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(372, 'Matlab Dakkhin', 42, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(373, 'Matlab Uttar', 42, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(374, 'Kachua', 42, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(375, 'Haziganj', 42, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(376, 'Faridganj', 42, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(377, 'Chandpur Sadar', 42, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(378, 'Haimchar', 42, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(379, 'Patiya Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(380, 'Rangunia Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(381, 'Raozan Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(382, 'Sandwip Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(383, 'Satkania Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(384, 'Sitakunda Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(385, 'Mirsharai Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(386, 'Lohagara Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(387, 'Hathazari Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(388, 'Fatikchhari Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(389, 'Chandanaish Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(390, 'Khulshi', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(391, 'Banshkhali Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(392, 'Anwara Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(393, 'Panchlaish', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(394, 'Boalkhali Upazila', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(395, 'Chittagong Port', 43, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(396, 'Chauddagram Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(397, 'Monohorgonj Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(398, 'Laksam Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(399, 'Comilla Sadar Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(400, 'Homna Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(401, 'Debidwar Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(402, 'Daudkandi Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(403, 'Chandina Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(404, 'Burichong Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(405, 'Brahmanpara Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(406, 'Barura Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(407, 'Meghna Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(408, 'Nangalkot Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(409, 'Comilla Sadar South Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(410, 'Titas Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(411, 'Muradnagar Upazila', 44, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(412, 'Kutubdia Upazila', 45, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(413, 'Pekua Upazila', 45, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(414, 'Ukhia Upazila', 45, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(415, 'Teknaf Upazila', 45, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(416, 'Ramu Upazila', 45, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(417, 'Maheshkhali Upazila', 45, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(418, 'Cox\'s Bazar Sadar Upazila', 45, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(419, 'Chakaria Upazila', 45, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(420, 'Sonagazi', 46, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(421, 'Fhulgazi', 46, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(422, 'Parshuram', 46, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(423, 'Chagalnaiya', 46, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(424, 'Feni Sadar', 46, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(425, 'Daganbhuiyan', 46, NULL, '2', '1', 'Super Admin', 'Super Admin', '2021-01-28 03:58:52', '2021-01-29 22:55:24'),
(426, 'Dighinala Upazila', 47, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(427, 'Ramgarh Upazila', 47, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(428, 'Panchhari Upazila', 47, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(429, 'Matiranga Upazila', 47, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(430, 'Mahalchhari Upazila', 47, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(431, 'Lakshmichhari Upazila', 47, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(432, 'Khagrachhari Upazila', 47, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(433, 'Manikchhari Upazila', 47, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(434, 'Lakshmipur Sadar Upazila', 48, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(435, 'Komol Nagar Upazila', 48, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(436, 'Ramgati Upazila', 48, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(437, 'Raipur Upazila', 48, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(438, 'Ramganj Upazila', 48, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(439, 'Chatkhil Upazila', 49, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(440, 'Begumganj Upazila', 49, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(441, 'Noakhali Sadar Upazila', 49, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(442, 'Shenbag Upazila', 49, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(443, 'Hatia Upazila', 49, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(444, 'Kobirhat Upazila', 49, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(445, 'Sonaimuri Upazila', 49, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(446, 'Suborno Char Upazila', 49, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(447, 'Companyganj Upazila', 49, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(448, 'Bagaichhari Upazila', 50, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(449, 'Kaptai Upazila', 50, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(450, 'Langadu Upazila', 50, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(451, 'Nannerchar Upazila', 50, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(452, 'Kaukhali Upazila', 50, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(453, 'Rajasthali Upazila', 50, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(454, 'Juraichhari Upazila', 50, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(455, 'Barkal Upazila', 50, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(456, 'Rangamati Sadar Upazila', 50, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(457, 'Belaichhari Upazila', 50, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(458, 'Nabiganj', 51, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(459, 'Madhabpur', 51, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(460, 'Lakhai', 51, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(461, 'Habiganj Sadar', 51, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(462, 'Chunarughat', 51, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(463, 'Shaistagonj Upazila', 51, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(464, 'Bahubal', 51, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(465, 'Ajmiriganj', 51, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(466, 'Baniachang', 51, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(467, 'Sreemangal', 52, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(468, 'Rajnagar', 52, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(469, 'Kulaura', 52, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(470, 'Kamalganj', 52, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(471, 'Barlekha', 52, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(472, 'Moulvibazar Sadar', 52, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(473, 'Juri', 52, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(474, 'Sulla', 53, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(475, 'Jamalganj', 53, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(476, 'Tahirpur', 53, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(477, 'Jagannathpur', 53, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(478, 'Dowarabazar', 53, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(479, 'Dharampasha', 53, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(480, 'Derai', 53, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(481, 'Chhatak', 53, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(482, 'Bishwamvarpur', 53, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(483, 'Shanthiganj', 53, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(484, 'Sunamganj Sadar', 53, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(485, 'Sylhet Sadar', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(486, 'Beanibazar', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(487, 'Bishwanath', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(488, 'Balaganj', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(489, 'Companiganj', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(490, 'Golapganj', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(491, 'Gowainghat', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(492, 'Jaintiapur', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(493, 'Kanaighat', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(494, 'Fenchuganj', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(495, 'Zakiganj', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(496, 'Nobigonj', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(497, 'Dakshin Surma Upazila', 54, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(498, 'Chitalmari Upazila', 55, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(499, 'Bagerhat Sadar Upazila', 55, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(500, 'Fakirhat Upazila', 55, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(501, 'Kachua Upazila', 55, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(502, 'Mollahat Upazila', 55, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(503, 'Mongla Upazila', 55, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(504, 'Morrelganj Upazila', 55, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(505, 'Rampal Upazila', 55, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(506, 'Sarankhola Upazila', 55, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(507, 'Chuadanga-S Upazila', 56, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(508, 'Jibannagar Upazila', 56, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(509, 'Alamdanga Upazila', 56, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(510, 'Damurhuda Upazila', 56, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(511, 'Manirampur Upazila', 57, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(512, 'Sharsha Upazila', 57, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(513, 'Jhikargachha Upazila', 57, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(514, 'Chaugachha Upazila', 57, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(515, 'Abhaynagar Upazila', 57, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(516, 'Jessore Sadar Upazila', 57, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(517, 'Bagherpara Upazila', 57, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(518, 'Keshabpur Upazila', 57, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(519, 'Harinakunda Upazila', 58, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(520, 'Shailkupa Upazila', 58, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(521, 'Kotchandpur Upazila', 58, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(522, 'Kaliganj Upazila', 58, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(523, 'Maheshpur Upazila', 58, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(524, 'Jhenaidah Sadar Upazila', 58, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(525, 'Batiaghata Upazila', 59, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(526, 'Dacope Upazila', 59, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(527, 'Dumuria Upazila', 59, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(528, 'Dighalia Upazila', 59, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(529, 'Koyra Upazila', 59, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(530, 'Paikgachha Upazila', 59, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(531, 'Rupsa Upazila', 59, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(532, 'Phultala Upazila', 59, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(533, 'Terokhada Upazila', 59, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(534, 'Mirpur', 60, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(535, 'Daulatpur', 60, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(536, 'Bheramara', 60, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(537, 'Khoksa', 60, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(538, 'Kumarkhali', 60, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(539, 'Kushtia Sadar', 60, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(540, 'Sreepur Upazila', 61, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL);
INSERT INTO `locations` (`id`, `name`, `parent_id`, `grand_parent_id`, `type`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(541, 'Magura Sadar Upazila', 61, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(542, 'Mohammadpur Upazila', 61, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(543, 'Shalikha Upazila', 61, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(544, 'Meherpur-S Upazila', 62, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(545, 'angni Upazila', 62, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(546, 'Mujib Nagar Upazila', 62, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(547, 'Kalia Upazilla', 63, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(548, 'Narail-S Upazilla', 63, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(549, 'Lohagara Upazilla', 63, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(550, 'Shyamnagar Upazila', 64, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(551, 'Kaliganj Upazila', 64, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(552, 'Kalaroa Upazila', 64, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(553, 'Tala Upazila', 64, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(554, 'Debhata Upazila', 64, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(555, 'Satkhira Sadar Upazila', 64, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(556, 'Assasuni Upazila', 64, NULL, '2', '1', 'Super Admin', NULL, '2021-01-28 03:58:52', NULL),
(560, 'Yakubpur', 425, 46, '3', '1', 'Super Admin', NULL, '2021-01-29 22:51:02', '2021-01-29 22:51:02'),
(561, 'Jailashkara', 425, 46, '3', '1', 'Super Admin', NULL, '2021-01-29 22:51:35', '2021-01-29 22:51:35'),
(562, 'Daganbhuiyan', 425, 46, '3', '1', 'Super Admin', NULL, '2021-01-29 22:51:58', '2021-01-29 22:51:58'),
(564, 'Mathu Bhuiyan', 425, 46, '3', '1', 'Super Admin', NULL, '2021-01-29 22:52:54', '2021-01-29 22:52:54'),
(565, 'Rajapur', 425, 46, '3', '1', 'Super Admin', NULL, '2021-01-29 22:53:19', '2021-01-29 22:53:19'),
(566, 'Sindurpur', 425, 46, '3', '1', 'Super Admin', NULL, '2021-01-29 22:53:39', '2021-01-29 22:53:39'),
(567, 'Amjadhat', 421, 46, '3', '1', 'Super Admin', NULL, '2021-01-29 23:04:37', '2021-01-29 23:04:37'),
(568, 'Anandapur', 421, 46, '3', '1', 'Super Admin', NULL, '2021-01-29 23:04:54', '2021-01-29 23:04:54'),
(569, 'Darbarpur', 421, 46, '3', '1', 'Super Admin', NULL, '2021-01-29 23:05:09', '2021-01-29 23:05:09'),
(570, 'Fulgazi', 421, 46, '3', '1', 'Super Admin', NULL, '2021-01-29 23:05:23', '2021-01-29 23:05:23'),
(571, 'G.M. Hat', 421, 46, '3', '1', 'Super Admin', NULL, '2021-01-29 23:05:37', '2021-01-29 23:05:37'),
(572, 'Munshirhat', 421, 46, '3', '1', 'Super Admin', NULL, '2021-01-29 23:05:54', '2021-02-02 04:11:59'),
(573, 'Shimuliya', 70, 1, '3', '1', 'Mr. XYZ', NULL, '2021-02-09 23:13:50', '2021-02-09 23:13:50'),
(574, 'Dhamshona', 70, 1, '3', '1', 'Mr. XYZ', NULL, '2021-02-09 23:14:07', '2021-02-09 23:14:07'),
(575, 'Pataliya', 70, 1, '3', '1', 'Mr. XYZ', NULL, '2021-02-09 23:14:22', '2021-02-09 23:14:22'),
(576, 'Biruliya', 70, 1, '3', '1', 'Mr. XYZ', NULL, '2021-02-09 23:14:36', '2021-02-09 23:14:36'),
(577, 'Savar', 70, 1, '3', '1', 'Mr. XYZ', NULL, '2021-02-09 23:14:50', '2021-02-09 23:14:50'),
(578, 'Tetulzhora', 70, 1, '3', '1', 'Mr. XYZ', NULL, '2021-02-09 23:15:09', '2021-02-09 23:15:09');

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `material_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `material_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_unit_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_price` double NOT NULL,
  `qty` double(8,2) DEFAULT NULL,
  `alert_qty` double(8,2) DEFAULT NULL,
  `type` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Raw, 2=Packaging',
  `tax_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_method` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Exclusive,2=Inclusive',
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`id`, `category_id`, `material_image`, `material_name`, `material_code`, `unit_id`, `purchase_unit_id`, `purchase_price`, `qty`, `alert_qty`, `type`, `tax_id`, `tax_method`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'turmeric-powder-846989.jpg', 'Turmeric Powder', '920631', 5, 3, 0.1, 52000.00, 0.00, '1', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 20:50:54', '2021-06-02 01:06:08'),
(2, 1, 'kashmiri-chilli-powder-10-500x500-701818.jpg', 'Chilli Powder', '332001', 5, 3, 0, 0.00, 0.00, '1', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 20:52:35', '2021-02-27 21:39:55'),
(3, 1, 'moyda-812357.jpg', 'Maida', '829849', 5, 3, 0, 0.00, 0.00, '1', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 21:16:22', '2021-01-23 03:07:40'),
(4, 5, 'sugar.2-810x476-745820.jpg', 'Sugar', '139081', 5, 3, 0, 0.00, 0.00, '1', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 21:16:55', '2021-01-23 03:07:27'),
(5, 5, 'salt-799657.jpg', 'Salt', '359071', 5, 3, 0, 0.00, 0.00, '1', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 21:18:53', '2021-01-23 03:07:16'),
(6, 5, 'peanut-458594.jpg', 'Peanut', '701608', 5, 3, 0, 0.00, 0.00, '1', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 21:19:23', '2021-01-23 03:07:04'),
(7, 2, '70545718-603085.jpg', 'Milk', '621348', 6, 6, 0, 0.00, 0.00, '1', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 21:19:55', '2021-02-27 21:39:55'),
(8, 2, '260px-Butterschmalz-3-811423.jpg', 'Ghee', '790130', 5, 3, 0, 0.00, 0.00, '1', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 21:39:12', '2021-01-23 03:06:28'),
(9, 1, 'Rakesh-coriander-powder-dhaniya-1-1-957741.jpg', 'Coriander', '285033', 5, 3, 0, 0.00, 0.00, '1', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 21:39:38', '2021-01-23 03:06:04'),
(10, 2, 'butter-oil-500x500-585606.jpg', 'Butter Oil', '631912', 6, 6, 0, 0.00, 0.00, '1', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 21:40:03', '2021-02-06 03:05:08'),
(11, 3, '4c78ff8a4bb624b91ae3e01a2a99538c-749353.jpg', 'Foil Paper', '183204', 7, 7, 0, 0.00, 0.00, '2', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 21:42:08', '2021-01-26 02:42:37'),
(12, 3, 'laminating-sheet-transparent-500x500-576754.jpg', 'Lamination Paper', '768074', 7, 7, 10, 60.00, 0.00, '2', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 21:42:31', '2021-06-02 01:06:08'),
(13, 3, 'corrugated_box-233495.jpg', 'Corrugated Box', '640590', 8, 8, 10, 60.00, 0.00, '2', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 21:43:16', '2021-06-02 01:06:08'),
(14, 5, 'potato-487718.jpg', 'Potato', '013231', 5, 3, 0, 0.00, 0.00, '1', NULL, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 22:18:49', '2021-01-23 03:04:42'),
(15, 2, '324844_2200-732x549-673160.jpg', 'Oil', '791045', 6, 6, 0, 0.00, 0.00, '1', 1, '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 22:36:26', '2021-06-01 22:43:09');

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
(8, 8, 1, 100, 100, 3, 100, 0, 0, 0, 0, 0, 10000, '2021-06-02 00:19:22', '2021-06-02 00:19:22'),
(9, 9, 12, 100, 100, 7, 10, 0, 0, 0, 0, 0, 1000, '2021-06-02 00:22:57', '2021-06-02 00:22:57'),
(10, 9, 13, 100, 100, 8, 10, 0, 0, 0, 0, 0, 1000, '2021-06-02 00:22:57', '2021-06-02 00:22:57');

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
(1, 'Backend', '1', '2021-01-19 03:57:44', '2021-01-19 03:57:44');

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
(15, '2020_11_15_102900_create_suppliers_table', 1),
(16, '2020_11_16_061813_create_warehouses_table', 1),
(17, '2020_11_16_112644_create_taxes_table', 1),
(18, '2020_11_17_084204_create_materials_table', 1),
(19, '2020_11_18_000001_create_banks_table', 1),
(21, '2020_11_18_082707_create_chart_of_accounts_table', 1),
(22, '2020_11_18_082750_create_transactions_table', 1),
(23, '2020_11_18_131359_create_purchases_table', 1),
(24, '2020_11_19_054144_create_material_purchase_table', 1),
(25, '2020_11_19_084433_create_warehouse_materials_table', 1),
(26, '2020_11_19_094509_create_daily_bankings_table', 1),
(27, '2020_12_14_110555_create_products_table', 1),
(28, '2020_12_14_110652_create_product_material_table', 1),
(30, '2020_12_22_103403_create_finish_goods_table', 1),
(31, '2020_12_26_104417_create_productions_table', 1),
(33, '2020_12_26_104805_create_production_finished_goods_table', 1),
(36, '2020_12_22_102736_create_sizes_table', 2),
(38, '2021_01_23_050808_create_warehouse_finish_goods_table', 3),
(39, '2021_01_19_093907_create_production_coupons_table', 4),
(40, '2020_12_26_104741_create_production_materials_table', 5),
(41, '2021_01_24_040429_create_finished_goods_materials_table', 6),
(44, '2021_01_27_052106_create_mobile_banks_table', 8),
(48, '2020_11_10_042545_create_locations_table', 9),
(49, '2020_11_17_061542_create_asms_table', 9),
(50, '2020_11_18_040522_create_customer_groups_table', 9),
(51, '2020_11_18_063920_create_customers_table', 9),
(52, '2020_12_27_043903_create_salesmen_table', 9),
(53, '2021_01_28_090833_create_sales_men_daily_routes_table', 9),
(55, '2021_02_03_094656_create_received_coupons_table', 10),
(61, '2021_02_06_081548_create_purchase_payments_table', 12),
(62, '2021_02_04_181445_create_sales_table', 13),
(63, '2021_02_04_185437_create_finish_goods_sales_table', 13),
(65, '2021_02_11_052741_create_daily_closings_table', 14),
(70, '2021_02_13_081403_create_transfers_table', 15),
(71, '2021_02_13_081433_create_finish_goods_transfers_table', 15),
(72, '2021_03_06_114806_create_branches_table', 16),
(73, '2021_03_06_114840_create_departments_table', 16),
(74, '2021_03_06_114850_create_divisions_table', 16),
(75, '2021_03_06_115124_create_designations_table', 16),
(76, '2021_03_07_112540_create_expense_items_table', 17),
(80, '2021_03_07_112555_create_expenses_table', 18),
(89, '2021_03_13_055959_create_employees_table', 19),
(91, '2021_03_13_072925_create_employee_education_table', 19),
(92, '2021_03_13_073038_create_employee_professional_information_table', 19);

-- --------------------------------------------------------

--
-- Table structure for table `mobile_banks`
--

CREATE TABLE `mobile_banks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mobile_banks`
--

INSERT INTO `mobile_banks` (`id`, `bank_name`, `account_name`, `account_number`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(2, 'Rocket', 'Kohinoor', '01521225987', '1', 'Super Admin', 'Super Admin', '2021-01-27 00:24:08', '2021-01-27 00:28:26');

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
(1, 1, '2', 'Dashboard', NULL, 'fas fa-tachometer-alt', '/', 1, NULL, '_self', NULL, '2021-03-22 00:37:56'),
(2, 1, '1', NULL, 'Menus', NULL, NULL, 2, NULL, NULL, NULL, '2021-03-22 00:37:56'),
(3, 1, '2', 'Material', NULL, 'fas fa-toolbox', '', 3, NULL, NULL, NULL, '2021-03-22 00:37:56'),
(4, 1, '1', NULL, 'System', NULL, NULL, 24, NULL, NULL, NULL, '2021-03-22 00:37:56'),
(5, 1, '2', 'Menu', NULL, 'fas fa-th-list', 'menu', 26, NULL, NULL, NULL, '2021-03-22 00:37:56'),
(6, 1, '2', 'General Setting', NULL, 'fas fa-cogs', 'setting', 1, 23, NULL, NULL, '2020-11-16 01:24:34'),
(7, 1, '1', NULL, 'Access Control', NULL, NULL, 19, NULL, NULL, '2020-11-10 01:19:40', '2021-03-22 00:37:56'),
(8, 1, '2', 'User', NULL, 'fas fa-users', 'user', 20, NULL, '_self', '2020-11-10 01:21:58', '2021-03-22 00:37:56'),
(9, 1, '2', 'Category', NULL, '', 'material/category', 1, 3, '_self', '2020-11-10 01:24:28', '2020-11-10 02:30:33'),
(11, 1, '2', 'Material Manage', NULL, '', 'material', 2, 3, '_self', '2020-11-10 02:27:18', '2020-12-31 20:59:17'),
(12, 1, '2', 'Permission', NULL, 'fas fa-tasks', 'menu/module/permission', 27, NULL, '_self', '2020-11-10 02:37:14', '2021-03-22 00:37:56'),
(13, 1, '2', 'Role', NULL, 'fas fa-user-tag', 'role', 21, NULL, '_self', '2020-11-11 02:45:47', '2021-03-22 00:37:56'),
(14, 1, '2', 'Unit', NULL, 'fas fa-balance-scale', 'unit', 5, 23, '_self', '2020-11-14 19:28:28', '2021-02-02 04:27:33'),
(15, 1, '2', 'Supplier', NULL, 'fas fa-user-tie', '', 12, NULL, NULL, '2020-11-14 20:00:52', '2021-03-22 00:37:56'),
(16, 1, '2', 'Manage Supplier', NULL, '', 'supplier', 1, 15, '_self', '2020-11-14 20:02:35', '2021-01-26 22:15:48'),
(17, 1, '2', 'Supplier Ledger', NULL, '', 'supplier-ledger', 2, 15, '_self', '2020-11-14 20:03:31', '2021-01-28 04:29:12'),
(18, 1, '2', 'Purchase', NULL, 'fas fa-cart-arrow-down', '', 4, NULL, NULL, '2020-11-14 20:04:49', '2021-03-22 00:37:56'),
(19, 1, '2', 'Manage Purchase', NULL, '', 'purchase', 2, 18, '_self', '2020-11-14 20:06:43', '2021-01-26 22:15:48'),
(20, 1, '2', 'Add Purchase', NULL, '', 'purchase/create', 1, 18, '_self', '2020-11-14 20:08:51', '2021-01-26 22:15:48'),
(21, 1, '2', 'Warehouse', NULL, 'fas fa-warehouse', 'warehouse', 2, 23, '_self', '2020-11-15 18:25:25', '2020-11-16 01:21:49'),
(22, 1, '2', 'Tax', NULL, 'fas fa-hand-holding-usd', 'tax', 4, 23, '_self', '2020-11-16 00:05:50', '2021-02-02 04:27:33'),
(23, 1, '2', 'Settings', NULL, 'fas fa-cogs', '', 25, NULL, NULL, '2020-11-16 01:21:05', '2021-03-22 00:37:56'),
(24, 1, '2', 'Customer', NULL, 'far fa-handshake', '', 11, NULL, NULL, '2020-11-17 18:47:27', '2021-03-22 00:37:56'),
(25, 1, '2', 'Manage Customer', NULL, '', 'customer', 1, 24, '_self', '2020-11-17 18:48:01', '2020-11-17 18:48:19'),
(26, 1, '2', 'Customer Ledger', NULL, '', 'customer-ledger', 2, 24, '_self', '2020-11-17 18:49:09', '2020-11-17 18:49:12'),
(27, 1, '2', 'Credit Customer', NULL, '', 'credit-customer', 3, 24, '_self', '2020-11-17 18:49:43', '2020-11-17 18:50:13'),
(28, 1, '2', 'Paid Customer', NULL, '', 'paid-customer', 4, 24, '_self', '2020-11-17 18:50:05', '2020-11-17 18:50:16'),
(29, 1, '2', 'Customer Advance', NULL, '', 'customer-advance', 5, 24, '_self', '2020-11-17 18:50:49', '2020-12-31 20:59:26'),
(30, 1, '2', 'Supplier Advance', NULL, '', 'supplier-advance', 3, 15, '_self', '2020-11-20 16:48:28', '2021-01-28 04:29:12'),
(32, 1, '2', 'Bank', NULL, 'fas fa-university', '', 15, NULL, NULL, '2020-12-05 21:39:41', '2021-03-22 00:37:56'),
(33, 1, '2', 'Manage Bank', NULL, '', 'bank', 1, 32, '_self', '2020-12-05 21:40:15', '2020-12-05 21:40:24'),
(34, 1, '2', 'Bank Transaction', NULL, '', 'bank-transaction', 2, 32, '_self', '2020-12-05 21:44:13', '2020-12-05 21:44:29'),
(35, 1, '2', 'Bank Ledger', NULL, '', 'bank-ledger', 3, 32, '_self', '2020-12-05 21:45:17', '2020-12-05 21:45:29'),
(36, 1, '2', 'Product', NULL, 'fab fa-product-hunt', '', 5, NULL, NULL, '2020-12-13 18:58:18', '2021-03-22 00:37:56'),
(37, 1, '2', 'Category', NULL, '', 'product/category', 1, 36, '_self', '2020-12-13 18:59:31', '2020-12-13 18:59:35'),
(38, 1, '2', 'Add Product', NULL, '', 'product/add', 3, 36, '_self', '2020-12-13 19:04:01', '2020-12-22 17:01:25'),
(39, 1, '2', 'Product Manage', NULL, '', 'product', 4, 36, '_self', '2020-12-13 19:04:45', '2020-12-22 17:01:25'),
(40, 1, '2', 'Production', NULL, 'fas fa-industry', '', 6, NULL, NULL, '2020-12-20 20:30:14', '2021-03-22 00:37:56'),
(41, 1, '2', 'Add Production', NULL, '', 'production/add', 1, 40, '_self', '2020-12-20 20:31:07', '2020-12-20 20:31:13'),
(42, 1, '2', 'Production Manage', NULL, '', 'production', 2, 40, '_self', '2020-12-20 20:32:15', '2020-12-21 16:23:44'),
(43, 1, '2', 'Print Barcode', NULL, 'fas fa-barcode', 'print-barcode', 5, 36, '_self', '2020-12-21 16:22:02', '2020-12-22 17:01:25'),
(45, 1, '2', 'Size', NULL, '', 'size', 2, 36, '_self', '2020-12-22 17:01:20', '2020-12-22 17:01:25'),
(46, 1, '2', 'Inventory', NULL, 'fas fa-boxes', 'finished-goods', 7, NULL, '_self', '2020-12-22 21:24:00', '2021-03-22 00:37:56'),
(47, 1, '2', 'Sales Representative', NULL, 'fas fa-user-secret', 'sales-representative', 23, NULL, '_self', '2020-12-31 20:58:49', '2021-03-22 00:37:56'),
(48, 1, '2', 'Production Finished', NULL, '', 'production-finished', 3, 40, '_self', '2021-01-08 15:56:03', '2021-01-08 15:56:16'),
(49, 1, '2', 'Mobile Bank', NULL, 'fas fa-mobile-alt', '', 16, NULL, NULL, '2021-01-26 22:13:21', '2021-03-22 00:37:56'),
(50, 1, '2', 'Manage Mobile Bank', NULL, '', 'mobile-bank', 1, 49, '_self', '2021-01-26 22:13:57', '2021-01-26 23:05:37'),
(51, 1, '2', 'Mobile Bank Transaction', NULL, '', 'mobile-bank-transaction', 2, 49, '_self', '2021-01-26 22:14:36', '2021-01-26 23:05:49'),
(52, 1, '2', 'Mobile Bank Ledger', NULL, '', 'mobile-bank-ledger', 3, 49, '_self', '2021-01-26 22:15:01', '2021-01-26 23:06:00'),
(53, 1, '2', 'ASM', NULL, 'fas fa-user-shield', 'asm', 22, NULL, '_self', '2021-01-28 04:10:49', '2021-03-22 00:37:56'),
(54, 1, '2', 'Location', NULL, 'fas fa-map-marker-alt', '', 18, NULL, NULL, '2021-01-28 04:26:39', '2021-03-22 00:37:56'),
(55, 1, '2', 'District', NULL, '', 'district', 1, 54, '_self', '2021-01-28 04:27:11', '2021-01-28 04:28:04'),
(56, 1, '2', 'Upazila', NULL, '', 'upazila', 2, 54, '_self', '2021-01-28 04:27:28', '2021-01-28 04:28:32'),
(57, 1, '2', 'Route', NULL, '', 'route', 3, 54, '_self', '2021-01-28 04:28:00', '2021-01-28 04:28:34'),
(58, 1, '2', 'Customer Group', NULL, 'fas fa-users', 'customer-group', 3, 23, '_self', '2021-02-02 04:27:14', '2021-02-02 04:28:57'),
(59, 1, '2', 'Report', NULL, 'fas fa-file-signature', '', 17, NULL, NULL, '2021-02-10 22:01:52', '2021-03-22 00:37:56'),
(60, 1, '2', 'Transfer', NULL, 'fas fa-share-square', '', 10, NULL, NULL, '2021-02-13 02:01:24', '2021-03-22 00:37:56'),
(61, 1, '2', 'Add Transfer', NULL, '', 'transfer/add', 1, 60, '_self', '2021-02-13 02:02:06', '2021-02-13 02:02:08'),
(62, 1, '2', 'Transfer Manage', NULL, '', 'transfer', 2, 60, '_self', '2021-02-13 02:02:52', '2021-02-13 03:59:28'),
(63, 1, '2', 'Accounts', NULL, 'far fa-money-bill-alt', '', 13, NULL, '_self', '2021-02-14 03:37:20', '2021-03-22 00:37:56'),
(64, 1, '2', 'Chart of Account', NULL, '', 'coa', 1, 63, '_self', '2021-02-14 03:40:35', '2021-02-14 03:40:38'),
(65, 1, '2', 'Opening Balance', NULL, '', 'opening-balance', 2, 63, '_self', '2021-02-14 03:41:47', '2021-02-14 03:41:51'),
(66, 1, '2', 'Supplier Payment', NULL, '', 'supplier-payment', 3, 63, '_self', '2021-02-14 03:42:45', '2021-02-16 00:37:50'),
(67, 1, '2', 'Customer Receive', NULL, '', 'customer-receive', 4, 63, '_self', '2021-02-14 03:44:04', '2021-02-14 03:44:10'),
(68, 1, '2', 'Cash Adjustment', NULL, '', 'cash-adjustment', 5, 63, '_self', '2021-02-14 03:44:50', '2021-02-14 03:44:54'),
(69, 1, '2', 'Debit Voucher', NULL, '', 'debit-voucher', 6, 63, '_self', '2021-02-14 03:45:19', '2021-02-14 04:27:56'),
(70, 1, '2', 'Credit Voucher', NULL, '', 'credit-voucher', 7, 63, '_self', '2021-02-14 03:45:43', '2021-02-14 04:27:56'),
(71, 1, '2', 'Contra Voucher', NULL, '', 'contra-voucher', 8, 63, '_self', '2021-02-14 03:46:29', '2021-02-14 04:27:56'),
(72, 1, '2', 'Journal Voucher', NULL, '', 'journal-voucher', 9, 63, '_self', '2021-02-14 03:46:56', '2021-02-14 04:27:56'),
(73, 1, '2', 'Voucher Approval', NULL, '', 'voucher-approval', 10, 63, '_self', '2021-02-14 03:47:37', '2021-02-14 04:27:56'),
(74, 1, '2', 'Report', NULL, '', '', 11, 63, '_self', '2021-02-14 03:48:27', '2021-02-14 04:28:02'),
(75, 1, '2', 'Cash Book', NULL, '', 'cash-book', 1, 74, '_self', '2021-02-14 03:49:04', '2021-02-14 03:49:47'),
(76, 1, '2', 'Inventory Ledger', NULL, '', 'inventory-ledger', 2, 74, '_self', '2021-02-14 04:21:31', '2021-02-14 04:21:40'),
(77, 1, '2', 'Bank Book', NULL, '', 'bank-book', 3, 74, '_self', '2021-02-14 04:23:23', '2021-02-14 04:30:50'),
(78, 1, '2', 'Mobile Bank Book', NULL, '', 'mobile-bank-book', 4, 74, '_self', '2021-02-14 04:23:46', '2021-02-21 22:12:20'),
(79, 1, '2', 'General Ledger', NULL, '', 'general-ledger', 5, 74, '_self', '2021-02-14 04:24:19', '2021-02-14 04:31:04'),
(80, 1, '2', 'Trial Balance', NULL, '', 'trial-balance', 6, 74, '_self', '2021-02-14 04:24:47', '2021-02-14 04:31:07'),
(81, 1, '2', 'Profit Loss', NULL, '', 'profit-loss', 7, 74, '_self', '2021-02-14 04:25:14', '2021-02-14 04:31:43'),
(82, 1, '2', 'Cash Flow', NULL, '', 'cash-flow', 8, 74, '_self', '2021-02-14 04:25:42', '2021-02-14 04:31:50'),
(84, 1, '2', 'Coupon Received', NULL, 'fas fa-qrcode', 'coupon-received', 9, NULL, '_self', '2021-02-22 21:39:31', '2021-03-22 00:37:56'),
(85, 1, '2', 'Closing', NULL, '', 'closing', 1, 59, '_self', '2021-02-23 05:02:45', '2021-02-23 05:02:51'),
(86, 1, '2', 'Closing Report', NULL, '', 'closing-report', 2, 59, '_self', '2021-02-23 05:03:29', '2021-02-23 05:03:33'),
(87, 1, '2', 'Todays Sales Report', NULL, '', 'todays-sales-report', 3, 59, NULL, '2021-02-23 05:04:05', '2021-02-23 05:04:08'),
(88, 1, '2', 'Todays Customer Receipt', NULL, '', 'todays-customer-receipt', 4, 59, NULL, '2021-02-23 05:04:40', '2021-02-23 05:04:43'),
(89, 1, '2', 'Salesmen Wise Sales Report', NULL, '', 'salesmen-wise-sales-report', 5, 59, NULL, '2021-02-23 05:05:15', '2021-02-23 05:06:36'),
(90, 1, '2', 'Due Report', NULL, '', 'due-report', 6, 59, NULL, '2021-02-23 05:05:42', '2021-02-23 05:06:42'),
(91, 1, '2', 'Shipping Cost Report', NULL, '', 'shipping-cost-report', 7, 59, NULL, '2021-02-23 05:06:14', '2021-02-23 05:06:45'),
(92, 1, '2', 'Product Wise Sales Report', NULL, '', 'product-wise-sales-report', 9, 59, NULL, '2021-02-23 05:07:16', '2021-02-27 20:47:43'),
(94, 1, '2', 'Sale', NULL, 'fab fa-opencart', '', 8, NULL, '_self', '2021-02-24 02:33:49', '2021-03-22 00:37:56'),
(95, 1, '2', 'Add Sale', NULL, '', 'sale/add', 1, 94, '_self', '2021-02-24 02:34:14', '2021-02-24 02:35:07'),
(96, 1, '2', 'Manage Sale', NULL, '', 'sale', 2, 94, NULL, '2021-02-24 02:35:03', '2021-02-24 02:35:27'),
(97, 1, '2', 'Production Report', NULL, '', 'production-report', 8, 59, '_self', '2021-02-27 20:47:28', '2021-02-27 20:47:43'),
(98, 1, '2', 'Warehouse Report', NULL, '', 'warehouse-report', 12, 59, '_self', '2021-02-27 23:55:18', '2021-03-22 00:36:14'),
(99, 1, '2', 'Human Resource', NULL, 'fas fa-users', '', 14, NULL, NULL, '2021-03-06 04:29:08', '2021-03-22 00:37:56'),
(100, 1, '2', 'HRM', NULL, 'fas fa-users', 'hrm', 1, 99, '_self', '2021-03-06 04:30:29', '2021-03-06 04:30:32'),
(102, 1, '2', 'Manage Department', NULL, '', 'department', 1, 100, '_self', '2021-03-06 04:31:30', '2021-03-13 23:04:03'),
(103, 1, '2', 'Manage Designation', NULL, '', 'designation', 3, 100, '_self', '2021-03-06 04:31:59', '2021-03-13 23:04:03'),
(104, 1, '2', 'Manage Employee', NULL, '', 'employee', 4, 100, '_self', '2021-03-06 04:32:29', '2021-03-13 23:04:03'),
(105, 1, '2', 'Manage Division', NULL, '', 'division', 2, 100, '_self', '2021-03-06 05:34:52', '2021-03-13 23:04:03'),
(106, 1, '2', 'Epense', NULL, 'fas fa-money-check-alt', '', 3, 99, NULL, '2021-03-07 03:51:46', '2021-03-22 00:37:56'),
(107, 1, '2', 'Manage Expense Item', NULL, '', 'expense-item', 1, 106, '_self', '2021-03-07 04:08:52', '2021-03-07 05:41:08'),
(108, 1, '2', 'Manage Expense', NULL, '', 'expense', 2, 106, '_self', '2021-03-07 04:09:13', '2021-03-07 04:09:50'),
(109, 1, '2', 'Expense Statement', NULL, '', 'expense-statement', 3, 106, '_self', '2021-03-07 04:09:46', '2021-03-07 04:09:53'),
(110, 1, '2', 'Product Coupon Report', NULL, '', 'product-coupon-report', 10, 59, '_self', '2021-03-14 02:19:25', '2021-03-14 02:59:57'),
(111, 1, '2', 'Warehouse Coupon Report', NULL, '', 'warehouse-coupon-report', 11, 59, '_self', '2021-03-14 02:58:37', '2021-03-22 00:36:14'),
(112, 1, '2', 'Attendance', NULL, '', '', 2, 99, NULL, '2021-03-22 00:35:40', '2021-03-22 00:37:56'),
(113, 1, '2', 'Add Attendance', NULL, '', 'attendance/add', 1, 112, '_self', '2021-03-22 00:36:09', '2021-03-22 00:36:14'),
(114, 1, '2', 'Manage Attendance', NULL, '', 'attendance', 2, 112, '_self', '2021-03-22 00:36:37', '2021-03-22 00:36:41'),
(115, 1, '2', 'Attendance Report', NULL, '', 'attendance/report', 3, 112, '_self', '2021-03-22 00:37:11', '2021-03-22 00:37:15');

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
(1, 1, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(2, 2, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(3, 36, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(4, 37, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(5, 45, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(6, 38, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(7, 39, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(8, 43, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(9, 40, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(10, 41, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(11, 42, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(12, 48, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(13, 46, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(14, 3, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(15, 9, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(16, 11, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(17, 18, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(18, 20, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(19, 19, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(26, 15, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(27, 16, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(28, 17, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(29, 30, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(30, 32, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(31, 33, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(32, 34, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(33, 35, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(34, 49, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(35, 50, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(36, 51, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(37, 52, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(38, 54, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(39, 55, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(40, 56, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(41, 57, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(42, 7, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(43, 8, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(44, 13, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(45, 53, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(46, 47, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(47, 4, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(48, 23, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(49, 6, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(50, 21, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(51, 22, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(52, 14, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(53, 94, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(54, 95, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(55, 96, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(56, 84, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(57, 24, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(58, 25, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(59, 26, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(60, 27, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(61, 28, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(62, 29, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(63, 60, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(64, 61, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(65, 62, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(66, 63, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(67, 64, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(68, 65, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(69, 66, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(70, 67, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(71, 68, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(72, 69, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(73, 70, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(74, 71, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(75, 72, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(76, 73, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(77, 74, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(78, 75, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(79, 76, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(80, 77, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(81, 78, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(82, 79, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(83, 80, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(84, 81, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(85, 82, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(86, 59, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(87, 85, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(88, 86, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(89, 87, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(90, 88, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(91, 89, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(92, 90, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(93, 91, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(94, 92, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(96, 97, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(97, 98, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(98, 58, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25');

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
(1, 1, 'Dashboard Access', 'dashboard-access', '2020-11-10 17:03:24', NULL),
(2, 9, 'Category Access', 'material-category-access', '2020-11-10 17:04:27', NULL),
(3, 9, 'Category Add', 'material-category-add', '2020-11-10 17:04:27', NULL),
(4, 9, 'Category Edit', 'material-category-edit', '2020-11-10 17:04:27', NULL),
(5, 9, 'Category Delete', 'material-category-delete', '2020-11-10 17:04:27', NULL),
(6, 9, 'Category Bulk Delete', 'material-category-bulk-delete', '2020-11-10 17:04:27', NULL),
(7, 9, 'Category Report', 'material-category-report', '2020-11-10 17:04:27', NULL),
(8, 11, 'Material Access', 'material-access', '2020-11-10 17:05:20', NULL),
(9, 11, 'Material Add', 'material-add', '2020-11-10 17:05:20', NULL),
(10, 11, 'Material Edit', 'material-edit', '2020-11-10 17:05:20', NULL),
(11, 11, 'Material View', 'material-view', '2020-11-10 17:05:20', NULL),
(12, 11, 'Material Delete', 'material-delete', '2020-11-10 17:05:20', NULL),
(13, 11, 'Material Bulk Delete', 'material-bulk-delete', '2020-11-10 17:05:20', NULL),
(14, 11, 'Material Report', 'material-report', '2020-11-10 17:05:20', NULL),
(15, 8, 'User Access', 'user-access', '2020-11-10 17:06:37', NULL),
(16, 8, 'User Add', 'user-add', '2020-11-10 17:06:37', NULL),
(17, 8, 'User Edit', 'user-edit', '2020-11-10 17:06:37', NULL),
(18, 8, 'User View', 'user-view', '2020-11-10 17:06:37', NULL),
(19, 8, 'User Delete', 'user-delete', '2020-11-10 17:06:37', NULL),
(20, 8, 'User Bulk Delete', 'user-bulk-delete', '2020-11-10 17:06:37', NULL),
(21, 8, 'User Report', 'user-report', '2020-11-10 17:06:37', NULL),
(22, 6, 'Setting Access', 'setting-access', '2020-11-10 17:06:59', NULL),
(23, 5, 'Menu Access', 'menu-access', '2020-11-10 17:10:17', NULL),
(24, 5, 'Menu Add', 'menu-add', '2020-11-10 17:10:17', NULL),
(25, 5, 'Menu Edit', 'menu-edit', '2020-11-10 17:10:17', NULL),
(26, 5, 'Menu Delete', 'menu-delete', '2020-11-10 17:10:17', NULL),
(27, 5, 'Menu Bulk Delete', 'menu-bulk-delete', '2020-11-10 17:10:17', NULL),
(28, 5, 'Menu Report', 'menu-report', '2020-11-10 17:10:17', NULL),
(29, 5, 'Menu Builder Access', 'menu-builder-access', '2020-11-10 17:10:17', NULL),
(30, 5, 'Menu Module Add', 'menu-module-add', '2020-11-10 17:10:17', NULL),
(31, 5, 'Menu Module Edit', 'menu-module-edit', '2020-11-10 17:10:17', NULL),
(32, 5, 'Menu Module Delete', 'menu-module-delete', '2020-11-10 17:10:17', NULL),
(33, 12, 'Permission Access', 'permission-access', '2020-11-10 17:11:24', NULL),
(34, 12, 'Permission Add', 'permission-add', '2020-11-10 17:11:24', NULL),
(35, 12, 'Permission Edit', 'permission-edit', '2020-11-10 17:11:24', NULL),
(36, 12, 'Permission Delete', 'permission-delete', '2020-11-10 17:11:24', NULL),
(37, 12, 'Permission Bulk Delete', 'permission-bulk-delete', '2020-11-10 17:11:24', NULL),
(38, 12, 'Permission Report', 'permission-report', '2020-11-10 17:11:24', NULL),
(39, 13, 'Role Access', 'role-access', '2020-11-11 02:48:05', NULL),
(40, 13, 'Role Add', 'role-add', '2020-11-11 02:48:05', NULL),
(41, 13, 'Role Edit', 'role-edit', '2020-11-11 02:48:05', NULL),
(42, 13, 'Role View', 'role-view', '2020-11-11 02:48:05', NULL),
(43, 13, 'Role Delete', 'role-delete', '2020-11-11 02:48:05', NULL),
(44, 13, 'Role Bulk Delete', 'role-bulk-delete', '2020-11-11 02:48:05', NULL),
(45, 13, 'Role Report', 'role-report', '2020-11-11 02:48:05', NULL),
(46, 14, 'Unit Access', 'unit-access', '2020-11-14 20:38:10', NULL),
(47, 14, 'Unit Add', 'unit-add', '2020-11-14 20:38:10', NULL),
(48, 14, 'Unit Edit', 'unit-edit', '2020-11-14 20:38:10', NULL),
(49, 14, 'Unit Delete', 'unit-delete', '2020-11-14 20:38:10', NULL),
(50, 14, 'Unit Bulk Delete', 'unit-bulk-delete', '2020-11-14 20:38:10', NULL),
(51, 14, 'Unit Report', 'unit-report', '2020-11-14 20:38:10', NULL),
(52, 16, 'Supplier Access', 'supplier-access', '2020-11-14 20:44:26', NULL),
(53, 16, 'Supplier Add', 'supplier-add', '2020-11-14 20:44:26', NULL),
(54, 16, 'Supplier Edit', 'supplier-edit', '2020-11-14 20:44:26', NULL),
(55, 16, 'Supplier View', 'supplier-view', '2020-11-14 20:44:26', NULL),
(56, 16, 'Supplier Delete', 'supplier-delete', '2020-11-14 20:44:26', NULL),
(57, 16, 'Supplier Bulk Delete', 'supplier-bulk-delete', '2020-11-14 20:44:26', NULL),
(58, 16, 'Supplier Report', 'supplier-report', '2020-11-14 20:44:26', NULL),
(59, 19, 'Purchase Access', 'purchase-access', '2020-11-14 20:46:15', NULL),
(60, 19, 'Purchase Add', 'purchase-add', '2020-11-14 20:46:15', NULL),
(61, 19, 'Purchase Edit', 'purchase-edit', '2020-11-14 20:46:15', NULL),
(62, 19, 'Purchase View', 'purchase-view', '2020-11-14 20:46:15', NULL),
(63, 19, 'Purchase Delete', 'purchase-delete', '2020-11-14 20:46:15', NULL),
(64, 19, 'Purchase Bulk Delete', 'purchase-bulk-delete', '2020-11-14 20:46:15', NULL),
(65, 19, 'Purchase Report', 'purchase-report', '2020-11-14 20:46:15', NULL),
(66, 21, 'Warehouse Access', 'warehouse-access', '2020-11-15 18:32:27', NULL),
(67, 21, 'Warehouse Add', 'warehouse-add', '2020-11-15 18:32:27', NULL),
(68, 21, 'Warehouse Edit', 'warehouse-edit', '2020-11-15 18:32:27', NULL),
(69, 21, 'Warehouse View', 'warehouse-view', '2020-11-15 18:32:27', NULL),
(70, 21, 'Warehouse Delete', 'warehouse-delete', '2020-11-15 18:32:27', NULL),
(71, 21, 'Warehouse Bulk Delete', 'warehouse-bulk-delete', '2020-11-15 18:32:27', NULL),
(72, 21, 'Warehouse Report', 'warehouse-report', '2020-11-15 18:32:27', NULL),
(73, 22, 'Tax Access', 'tax-access', '2020-11-16 00:06:28', NULL),
(74, 22, 'Tax Add', 'tax-add', '2020-11-16 00:06:28', NULL),
(75, 22, 'Tax Edit', 'tax-edit', '2020-11-16 00:06:28', NULL),
(76, 22, 'Tax Delete', 'tax-delete', '2020-11-16 00:06:28', NULL),
(77, 22, 'Tax Bulk Delete', 'tax-bulk-delete', '2020-11-16 00:06:28', NULL),
(78, 22, 'Tax Report', 'tax-report', '2020-11-16 00:06:28', NULL),
(79, 25, 'Customer Access', 'customer-access', '2020-11-17 20:08:28', NULL),
(80, 25, 'Customer Add', 'customer-add', '2020-11-17 20:08:28', NULL),
(81, 25, 'Customer Edit', 'customer-edit', '2020-11-17 20:08:28', NULL),
(82, 25, 'Customer View', 'customer-view', '2020-11-17 20:08:28', NULL),
(83, 25, 'Customer Delete', 'customer-delete', '2020-11-17 20:08:28', NULL),
(84, 25, 'Customer Bulk Delete', 'customer-bulk-delete', '2020-11-17 20:08:28', NULL),
(85, 25, 'Customer Report', 'customer-report', '2020-11-17 20:08:28', NULL),
(86, 17, 'Supplier Ledger Access', 'supplier-ledger-access', '2020-11-20 16:45:41', NULL),
(87, 26, 'Customer Ledger Access', 'customer-ledger-access', '2020-11-20 16:46:11', NULL),
(88, 27, 'Credit Customer Access', 'credit-customer-access', '2020-11-20 16:46:28', NULL),
(89, 28, 'Paid Customer Access', 'paid-customer-access', '2020-11-20 16:46:43', NULL),
(90, 29, 'Customer Advance Access', 'customer-advance-access', '2020-11-20 16:47:21', '2021-02-23 02:58:46'),
(91, 30, 'Supplier Advance Access', 'supplier-advance-access', '2020-11-20 16:49:05', '2021-01-11 18:37:54'),
(92, 33, 'Bank Access', 'bank-access', '2020-12-05 21:47:38', NULL),
(93, 33, 'Bank Add', 'bank-add', '2020-12-05 21:47:38', NULL),
(94, 33, 'Bank Edit', 'bank-edit', '2020-12-05 21:47:38', NULL),
(95, 33, 'Bank Report', 'bank-report', '2020-12-05 21:47:38', NULL),
(96, 34, 'Bank Transaction Access', 'bank-transaction-access', '2020-12-05 21:48:12', NULL),
(97, 35, 'Bank Ledger Access', 'bank-ledger-access', '2020-12-05 21:48:26', NULL),
(98, 37, 'Category Access', 'product-category-access', '2020-12-13 19:13:55', '2020-12-13 19:14:35'),
(99, 37, 'Category Add', 'product-category-add', '2020-12-13 19:13:55', '2020-12-13 19:14:43'),
(100, 37, 'product-Category Edit', 'product-category-edit', '2020-12-13 19:13:55', '2020-12-13 19:14:50'),
(101, 37, 'Category Delete', 'product-category-delete', '2020-12-13 19:13:55', '2020-12-13 19:14:56'),
(102, 37, 'Category Bulk Delete', 'product-category-bulk-delete', '2020-12-13 19:13:55', '2020-12-13 19:15:05'),
(103, 37, 'Category Report', 'product-category-report', '2020-12-13 19:13:55', '2020-12-13 19:15:12'),
(104, 39, 'Product Access', 'product-access', '2020-12-13 19:17:17', NULL),
(105, 39, 'Product Add', 'product-add', '2020-12-13 19:17:17', NULL),
(106, 39, 'Product Edit', 'product-edit', '2020-12-13 19:17:17', NULL),
(107, 39, 'Product View', 'product-view', '2020-12-13 19:17:17', NULL),
(108, 39, 'Product Delete', 'product-delete', '2020-12-13 19:17:17', NULL),
(109, 39, 'Product Bulk Delete', 'product-bulk-delete', '2020-12-13 19:17:17', NULL),
(110, 39, 'Product Report', 'product-report', '2020-12-13 19:17:17', NULL),
(111, 42, 'Production Access', 'production-access', '2020-12-21 16:32:27', NULL),
(112, 42, 'Production Add', 'production-add', '2020-12-21 16:32:27', NULL),
(113, 42, 'Production Edit', 'production-edit', '2020-12-21 16:32:27', NULL),
(114, 42, 'Production View', 'production-view', '2020-12-21 16:32:27', NULL),
(115, 42, 'Production Delete', 'production-delete', '2020-12-21 16:32:27', NULL),
(116, 42, 'Production Report', 'production-report', '2020-12-21 16:32:27', NULL),
(117, 42, 'Production Material Deliver', 'production-material-deliver', '2020-12-21 16:32:27', NULL),
(118, 42, 'Production Material Receive', 'production-material-receive', '2020-12-21 16:32:27', NULL),
(119, 42, 'Production Packaging', 'production-packaging', '2020-12-21 16:32:27', NULL),
(120, 43, 'Print Barcode Access', 'print-barcode-access', '2020-12-21 16:32:52', NULL),
(122, 45, 'Size Access', 'size-access', '2020-12-22 17:13:37', NULL),
(123, 45, 'Size Add', 'size-add', '2020-12-22 17:13:37', NULL),
(124, 45, 'Size Edit', 'size-edit', '2020-12-22 17:13:37', NULL),
(125, 45, 'Size Delete', 'size-delete', '2020-12-22 17:13:37', NULL),
(126, 45, 'Size Bulk Delete', 'size-bulk-delete', '2020-12-22 17:13:37', NULL),
(127, 45, 'Size Report', 'size-report', '2020-12-22 17:13:37', NULL),
(128, 46, 'Inventory Access', 'inventory-access', '2020-12-22 21:37:21', '2021-01-23 02:14:01'),
(130, 46, 'Inventory Edit', 'inventory-edit', '2020-12-22 21:37:21', '2021-01-23 02:13:52'),
(131, 46, 'Inventory View', 'inventory-view', '2020-12-22 21:37:21', '2021-01-23 02:13:44'),
(132, 46, 'Inventory Delete', 'inventory-delete', '2020-12-22 22:49:59', '2021-01-23 02:13:37'),
(133, 46, 'Inventory Bulk Delete', 'inventory-bulk-delete', '2020-12-22 22:49:59', '2021-01-23 02:13:30'),
(134, 46, 'Inventory Report', 'inventory-report', '2020-12-22 22:49:59', '2021-01-23 02:13:21'),
(135, 42, 'Production QR Code Print', 'production-qrcode-print', '2020-12-31 01:26:45', '2020-12-31 08:23:23'),
(136, 47, 'Sales Representative Access', 'sales-representative-access', '2020-12-31 21:01:56', NULL),
(137, 47, 'Sales Representative Add', 'sales-representative-add', '2020-12-31 21:01:56', NULL),
(138, 47, 'Sales Representative Edit', 'sales-representative-edit', '2020-12-31 21:01:56', NULL),
(139, 47, 'Sales Representative View', 'sales-representative-view', '2020-12-31 21:01:56', NULL),
(140, 47, 'Sales Representative Delete', 'sales-representative-delete', '2020-12-31 21:01:56', NULL),
(141, 47, 'Sales Representative Bulk Delete', 'sales-representative-bulk-delete', '2020-12-31 21:01:56', NULL),
(142, 47, 'Sales Representative Report', 'sales-representative-report', '2020-12-31 21:01:56', NULL),
(143, 48, 'Production Finished Access', 'production-finished-access', '2021-01-08 15:56:55', NULL),
(144, 30, 'Supplier Advance Add', 'supplier-advance-add', '2021-01-11 18:38:50', NULL),
(145, 30, 'Supplier Advance Edit', 'supplier-advance-edit', '2021-01-11 18:38:50', NULL),
(146, 30, 'Supplier Advance View', 'supplier-advance-view', '2021-01-11 18:38:50', NULL),
(147, 30, 'Supplier Advance Delete', 'supplier-advance-delete', '2021-01-11 18:38:50', NULL),
(148, 30, 'Supplier Advance Bulk Delete', 'supplier-advance-bulk-delete', '2021-01-11 18:38:50', NULL),
(149, 30, 'Supplier Advance Report', 'supplier-advance-report', '2021-01-11 18:38:50', NULL),
(150, 48, 'Production Finished View', 'production-finished-view', '2021-01-24 05:01:29', NULL),
(155, 50, 'Mobile Bank Access', 'mobile-bank-access', '2021-01-26 23:07:04', NULL),
(156, 50, 'Mobile Bank Add', 'mobile-bank-add', '2021-01-26 23:07:04', NULL),
(157, 50, 'Mobile Bank Edit', 'mobile-bank-edit', '2021-01-26 23:07:04', NULL),
(158, 50, 'Mobile Bank Report', 'mobile-bank-report', '2021-01-26 23:07:04', NULL),
(159, 51, 'Mobile Bank Transaction Access', 'mobile-bank-transaction-access', '2021-01-26 23:07:28', NULL),
(160, 52, 'Mobile Bank Ledger Access', 'mobile-bank-ledger-access', '2021-01-26 23:07:46', NULL),
(161, 33, 'Bank Delete', 'bank-delete', '2021-01-27 03:04:51', NULL),
(162, 50, 'Mobile Bank Delete', 'mobile-bank-delete', '2021-01-27 03:05:06', NULL),
(163, 53, 'ASM Access', 'asm-access', '2021-01-28 04:32:16', NULL),
(164, 53, 'ASM Add', 'asm-add', '2021-01-28 04:32:16', NULL),
(165, 53, 'ASM Edit', 'asm-edit', '2021-01-28 04:32:16', NULL),
(166, 53, 'ASM View', 'asm-view', '2021-01-28 04:32:16', NULL),
(167, 53, 'ASM Delete', 'asm-delete', '2021-01-28 04:32:16', NULL),
(168, 53, 'ASM Bulk Delete', 'asm-bulk-delete', '2021-01-28 04:32:16', NULL),
(169, 53, 'ASM Report', 'asm-report', '2021-01-28 04:32:16', NULL),
(170, 55, 'District Access', 'district-access', '2021-01-28 04:33:39', NULL),
(171, 55, 'District Add', 'district-add', '2021-01-28 04:33:39', NULL),
(172, 55, 'District Edit', 'district-edit', '2021-01-28 04:33:39', NULL),
(173, 55, 'District Delete', 'district-delete', '2021-01-28 04:33:39', NULL),
(174, 55, 'District Bulk Delete', 'district-bulk-delete', '2021-01-28 04:33:39', NULL),
(175, 55, 'District Report', 'district-report', '2021-01-28 04:33:39', NULL),
(176, 56, 'Upazila Access', 'upazila-access', '2021-01-28 04:34:28', NULL),
(177, 56, 'Upazila Add', 'upazila-add', '2021-01-28 04:34:28', NULL),
(178, 56, 'Upazila Edit', 'upazila-edit', '2021-01-28 04:34:28', NULL),
(179, 56, 'Upazila Delete', 'upazila-delete', '2021-01-28 04:34:28', NULL),
(180, 56, 'Upazila Bulk Delete', 'upazila-bulk-delete', '2021-01-28 04:34:28', NULL),
(181, 56, 'Upazila Report', 'upazila-report', '2021-01-28 04:34:28', NULL),
(182, 57, 'Route Access', 'route-access', '2021-01-28 04:35:07', NULL),
(183, 57, 'Route Add', 'route-add', '2021-01-28 04:35:07', NULL),
(184, 57, 'Route Edit', 'route-edit', '2021-01-28 04:35:07', NULL),
(185, 57, 'Route Delete', 'route-delete', '2021-01-28 04:35:07', NULL),
(186, 57, 'Route Bulk Delete', 'route-bulk-delete', '2021-01-28 04:35:07', NULL),
(187, 57, 'Route Report', 'route-report', '2021-01-28 04:35:07', NULL),
(188, 58, 'Customer Group Access', 'customer-group-access', '2021-02-02 04:29:58', NULL),
(189, 58, 'Customer Group Add', 'customer-group-add', '2021-02-02 04:29:58', NULL),
(190, 58, 'Customer Group Edit', 'customer-group-edit', '2021-02-02 04:29:58', NULL),
(191, 58, 'Customer Group Delete', 'customer-group-delete', '2021-02-02 04:29:58', NULL),
(192, 58, 'Customer Group Bulk Delete', 'customer-group-bulk-delete', '2021-02-02 04:29:58', NULL),
(193, 58, 'Customer Group Report', 'customer-group-report', '2021-02-02 04:29:58', NULL),
(194, 19, 'Purchase Payment Add', 'purchase-payment-add', '2021-02-06 03:12:54', NULL),
(195, 19, 'Purchase Payment Edit', 'purchase-payment-edit', '2021-02-06 03:12:54', NULL),
(196, 19, 'Purchase Payment View', 'purchase-payment-view', '2021-02-06 03:12:54', NULL),
(197, 19, 'Purchase Payment Delete', 'purchase-payment-delete', '2021-02-06 03:12:54', NULL),
(198, 62, 'Transfer Access', 'transfer-access', '2021-02-13 02:05:02', NULL),
(199, 62, 'Transfer Add', 'transfer-add', '2021-02-13 02:05:02', NULL),
(200, 62, 'Transfer Edit', 'transfer-edit', '2021-02-13 02:05:02', NULL),
(201, 62, 'Transfer View', 'transfer-view', '2021-02-13 02:05:02', NULL),
(202, 62, 'Transfer Delete', 'transfer-delete', '2021-02-13 02:05:02', NULL),
(203, 62, 'Transfer Bulk Delete', 'transfer-bulk-delete', '2021-02-13 02:05:02', NULL),
(204, 62, 'Transfer Report', 'transfer-report', '2021-02-13 02:05:02', NULL),
(205, 64, 'COA Access', 'coa-access', '2021-02-14 05:13:17', '2021-02-14 05:14:56'),
(206, 64, 'COA Add', 'coa-add', '2021-02-14 05:13:17', '2021-02-14 05:14:47'),
(207, 64, 'COA Edit', 'coa-edit', '2021-02-14 05:13:17', '2021-02-14 05:14:36'),
(208, 64, 'COA Delete', 'coa-delete', '2021-02-14 05:13:17', '2021-02-14 05:14:27'),
(209, 64, 'COA Report', 'coa-report', '2021-02-14 05:13:17', '2021-02-14 05:14:18'),
(210, 65, 'Opening Balance Access', 'opening-balance-access', '2021-02-14 05:14:03', NULL),
(211, 66, 'Supplier Payment Access', 'supplier-payment-access', '2021-02-14 05:15:38', NULL),
(212, 67, 'Customer Receive Access', 'customer-receive-access', '2021-02-14 05:15:58', NULL),
(213, 69, 'Debit Voucher Access', 'debit-voucher-access', '2021-02-15 06:21:46', NULL),
(214, 70, 'Credit Voucher Access', 'credit-voucher-access', '2021-02-15 06:22:01', NULL),
(215, 71, 'Contra Voucher Access', 'contra-voucher-access', '2021-02-16 00:14:27', NULL),
(216, 72, 'Journal Voucher Access', 'journal-voucher-access', '2021-02-16 02:06:53', NULL),
(217, 73, 'Voucher Approval Access', 'voucher-approval-access', '2021-02-16 02:11:04', NULL),
(218, 73, 'Approve Voucher', 'approve-voucher', '2021-02-16 02:11:04', NULL),
(219, 73, 'Edit Voucher', 'edit-voucher', '2021-02-16 02:11:04', NULL),
(220, 73, 'Delete Voucher', 'delete-voucher', '2021-02-16 02:11:04', NULL),
(221, 73, 'Voucher Approval Report', 'voucher-approval-report', '2021-02-16 03:36:07', NULL),
(222, 68, 'Cash Adjustment Access', 'cash-adjustment-access', '2021-02-17 02:57:21', NULL),
(223, 75, 'Cash Book Access', 'cash-book-access', '2021-02-21 22:07:54', NULL),
(224, 76, 'Inventory Ledger Access', 'inventory-ledger-access', '2021-02-21 22:08:22', NULL),
(225, 77, 'Bank Book Access', 'bank-book-access', '2021-02-21 22:09:03', NULL),
(226, 78, 'Mobile Bank Book Access', 'mobile-bank-book-access', '2021-02-21 22:09:23', '2021-02-22 03:56:03'),
(227, 79, 'General Ledger Access', 'general-ledger-access', '2021-02-21 22:09:42', NULL),
(228, 80, 'Trial Balance Access', 'trial-balance-access', '2021-02-21 22:09:58', NULL),
(229, 81, 'Profit Loss Access', 'profit-loss-access', '2021-02-21 22:10:13', NULL),
(230, 82, 'Cash Flow Access', 'cash-flow-access', '2021-02-21 22:10:30', NULL),
(232, 84, 'Coupon Received Access', 'coupon-received-access', '2021-02-22 21:40:41', '2021-02-22 21:48:41'),
(233, 84, 'Coupon Received  Report', 'coupon-received-report', '2021-02-22 21:40:41', '2021-02-22 21:48:29'),
(234, 29, 'Customer Advance Add', 'customer-advance-add', '2021-02-23 02:59:23', NULL),
(235, 29, 'Customer Advance Edit', 'customer-advance-edit', '2021-02-23 02:59:23', NULL),
(236, 29, 'Customer Advance Delete', 'customer-advance-delete', '2021-02-23 02:59:23', NULL),
(237, 29, 'Customer Advance Bulk Delete', 'customer-advance-bulk-delete', '2021-02-23 02:59:23', NULL),
(238, 29, 'Customer Advance Report', 'customer-advance-report', '2021-02-23 02:59:23', NULL),
(239, 85, 'Closing Access', 'closing-access', '2021-02-23 05:47:08', NULL),
(240, 86, 'Closing Report Access', 'closing-report-access', '2021-02-23 05:47:36', NULL),
(241, 87, 'Todays Sales Report Access', 'todays-sales-report-access', '2021-02-23 05:48:13', NULL),
(242, 88, 'Todays Customer Receipt Access', 'todays-customer-receipt-access', '2021-02-23 05:48:47', NULL),
(243, 89, 'Salesmen Wise Sales Report Access', 'salesmen-wise-sales-report-access', '2021-02-23 05:49:42', NULL),
(244, 90, 'Due Report Access', 'due-report-access', '2021-02-23 05:49:59', NULL),
(245, 91, 'Shipping Cost Report Access', 'shipping-cost-report-access', '2021-02-23 05:50:22', NULL),
(246, 92, 'Product Wise Sales Report Access', 'product-wise-sales-report-access', '2021-02-23 05:50:55', NULL),
(248, 96, 'Sale Access', 'sale-access', '2021-02-24 02:39:28', NULL),
(249, 96, 'Sale Add', 'sale-add', '2021-02-24 02:39:28', NULL),
(250, 96, 'Sale Edit', 'sale-edit', '2021-02-24 02:39:28', NULL),
(251, 96, 'Sale View', 'sale-view', '2021-02-24 02:39:28', NULL),
(252, 96, 'Sale Delete', 'sale-delete', '2021-02-24 02:39:28', NULL),
(253, 96, 'Sale Bulk Delete', 'sale-bulk-delete', '2021-02-24 02:39:28', NULL),
(254, 96, 'Sale Report', 'sale-report', '2021-02-24 02:39:28', NULL),
(255, 97, 'Production Report Access', 'production-report-access', '2021-02-27 20:48:23', NULL),
(256, 98, 'Warehouse Report Access', 'warehouse-report-access', '2021-02-28 00:20:30', NULL),
(263, 102, 'Department Access', 'department-access', '2021-03-06 23:34:43', NULL),
(264, 102, 'Department Add', 'department-add', '2021-03-06 23:34:43', '2021-03-07 02:42:19'),
(265, 102, 'Department Edit', 'department-edit', '2021-03-06 23:34:43', '2021-03-07 02:42:30'),
(266, 102, 'Department Delete', 'department-delete', '2021-03-06 23:34:43', '2021-03-07 02:42:39'),
(267, 102, 'Department Bulk Delete', 'department-bulk-delete', '2021-03-06 23:34:43', '2021-03-07 02:42:52'),
(268, 105, 'Division Access', 'division-access', '2021-03-06 23:35:25', NULL),
(269, 105, 'Division Add', 'division-add', '2021-03-06 23:35:25', '2021-03-07 02:45:59'),
(270, 105, 'Division Edit', 'division-edit', '2021-03-06 23:35:25', '2021-03-07 02:46:06'),
(271, 105, 'Division Delete', 'division-delete', '2021-03-06 23:35:25', '2021-03-07 02:46:13'),
(272, 105, 'Division Bulk Delete', 'division-bulk-delete', '2021-03-06 23:35:25', '2021-03-07 02:46:24'),
(273, 103, 'Designation Access', 'designation-access', '2021-03-07 00:00:35', NULL),
(274, 103, 'Designation Add', 'designation-add', '2021-03-07 00:00:35', '2021-03-07 02:47:19'),
(275, 103, 'Designation Edit', 'designation-edit', '2021-03-07 00:00:35', '2021-03-07 02:47:28'),
(276, 103, 'Designation Delete', 'designation-delete', '2021-03-07 00:00:35', '2021-03-07 02:47:37'),
(277, 103, 'Designation Bulk Delete', 'designation-bulk-delete', '2021-03-07 00:00:35', '2021-03-07 02:47:48'),
(278, 104, 'Employee Access', 'employee-access', '2021-03-07 00:01:32', NULL),
(279, 104, 'Employee Add', 'employee-add', '2021-03-07 00:01:32', NULL),
(280, 104, 'Employee Edit', 'employee-edit', '2021-03-07 00:01:32', NULL),
(281, 104, 'Employee View', 'employee-view', '2021-03-07 00:01:32', NULL),
(282, 104, 'Employee Delete', 'employee-delete', '2021-03-07 00:01:32', NULL),
(283, 104, 'Employee Bulk Delete', 'employee-bulk-delete', '2021-03-07 00:01:32', NULL),
(284, 104, 'Employee Report', 'employee-report', '2021-03-07 00:01:32', NULL),
(285, 102, 'Department Report', 'department-report', '2021-03-07 02:43:25', NULL),
(286, 105, 'Division Report', 'division-report', '2021-03-07 02:46:36', NULL),
(287, 103, 'Designation Report', 'designation-report', '2021-03-07 02:48:06', NULL),
(288, 107, 'Expense Item Access', 'expense-item-access', '2021-03-07 04:29:20', NULL),
(289, 107, 'Expense Item Add', 'expense-item-add', '2021-03-07 04:29:20', NULL),
(290, 107, 'Expense Item Edit', 'expense-item-edit', '2021-03-07 04:29:20', NULL),
(291, 107, 'Expense Item Delete', 'expense-item-delete', '2021-03-07 04:29:20', NULL),
(292, 107, 'Expense Item Bulk Delete', 'expense-item-bulk-delete', '2021-03-07 04:29:20', NULL),
(293, 107, 'Expense Item Report', 'expense-item-report', '2021-03-07 04:29:20', NULL),
(294, 108, 'Expense Access', 'expense-access', '2021-03-07 04:30:13', NULL),
(295, 108, 'Expense Add', 'expense-add', '2021-03-07 04:30:13', NULL),
(296, 108, 'Expense Edit', 'expense-edit', '2021-03-07 04:30:13', NULL),
(297, 108, 'Expense Delete', 'expense-delete', '2021-03-07 04:30:13', NULL),
(298, 108, 'Expense Bulk Delete', 'expense-bulk-delete', '2021-03-07 04:30:13', NULL),
(299, 108, 'Expense Report', 'expense-report', '2021-03-07 04:30:13', NULL),
(300, 109, 'Expense Statement Access', 'expense-statement-access', '2021-03-07 05:22:02', NULL),
(301, 110, 'Product Coupon Report Access', 'product-coupon-report-access', '2021-03-14 03:22:44', NULL),
(302, 111, 'Warehouse Coupon Report Access', 'warehouse-coupon-report-access', '2021-03-14 03:23:06', '2021-03-14 22:17:43');

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
(1, 1, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(2, 98, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(3, 99, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(4, 100, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(5, 101, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(6, 102, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(7, 103, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(8, 122, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(9, 123, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(10, 124, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(11, 125, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(12, 126, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(13, 127, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(14, 104, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(15, 105, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(16, 106, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(17, 107, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(18, 108, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(19, 109, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(20, 110, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(21, 120, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(22, 111, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(23, 112, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(24, 113, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(25, 114, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(26, 115, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(27, 116, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(28, 117, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(29, 118, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(30, 119, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(31, 135, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(32, 143, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(33, 150, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(34, 128, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(35, 130, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(36, 131, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(37, 132, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(38, 133, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(39, 134, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(40, 2, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(41, 3, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(42, 4, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(43, 5, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(44, 6, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(45, 7, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(46, 8, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(47, 9, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(48, 10, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(49, 11, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(50, 12, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(51, 13, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(52, 14, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(53, 59, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(54, 60, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(55, 61, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(56, 62, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(57, 63, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(58, 64, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(59, 65, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(71, 52, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(72, 53, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(73, 54, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(74, 55, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(75, 56, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(76, 57, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(77, 58, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(78, 86, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(79, 91, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(80, 144, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(81, 145, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(82, 146, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(83, 147, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(84, 148, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(85, 149, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(86, 92, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(87, 93, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(88, 94, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(89, 95, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(90, 161, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(91, 96, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(92, 97, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(93, 155, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(94, 156, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(95, 157, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(96, 158, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(97, 162, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(98, 159, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(99, 160, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(100, 170, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(101, 171, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(102, 172, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(103, 173, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(104, 174, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(105, 175, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(106, 176, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(107, 177, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(108, 178, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(109, 179, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(110, 180, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(111, 181, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(112, 182, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(113, 183, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(114, 184, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(115, 185, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(116, 186, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(117, 187, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(118, 15, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(119, 16, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(120, 17, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(121, 18, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(122, 19, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(123, 20, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(124, 21, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(125, 39, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(126, 40, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(127, 41, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(128, 42, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(129, 43, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(130, 44, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(131, 45, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(132, 163, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(133, 164, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(134, 165, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(135, 166, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(136, 167, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(137, 168, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(138, 169, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(139, 136, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(140, 137, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(141, 138, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(142, 139, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(143, 140, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(144, 141, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(145, 142, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(146, 22, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(147, 66, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(148, 67, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(149, 68, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(150, 69, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(151, 70, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(152, 71, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(153, 72, 2, '2021-02-01 00:14:50', '2021-02-01 00:14:50'),
(154, 73, 2, '2021-02-01 00:14:51', '2021-02-01 00:14:51'),
(155, 74, 2, '2021-02-01 00:14:51', '2021-02-01 00:14:51'),
(156, 75, 2, '2021-02-01 00:14:51', '2021-02-01 00:14:51'),
(157, 76, 2, '2021-02-01 00:14:51', '2021-02-01 00:14:51'),
(158, 77, 2, '2021-02-01 00:14:51', '2021-02-01 00:14:51'),
(159, 78, 2, '2021-02-01 00:14:51', '2021-02-01 00:14:51'),
(160, 46, 2, '2021-02-01 00:14:51', '2021-02-01 00:14:51'),
(161, 47, 2, '2021-02-01 00:14:51', '2021-02-01 00:14:51'),
(162, 48, 2, '2021-02-01 00:14:51', '2021-02-01 00:14:51'),
(163, 49, 2, '2021-02-01 00:14:51', '2021-02-01 00:14:51'),
(164, 50, 2, '2021-02-01 00:14:51', '2021-02-01 00:14:51'),
(165, 51, 2, '2021-02-01 00:14:51', '2021-02-01 00:14:51'),
(166, 248, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(167, 249, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(168, 250, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(169, 251, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(170, 252, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(171, 253, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(172, 254, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(173, 232, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(174, 233, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(175, 79, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(176, 80, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(177, 81, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(178, 82, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(179, 83, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(180, 84, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(181, 85, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(182, 87, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(183, 88, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(184, 89, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(185, 90, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(186, 234, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(187, 235, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(188, 236, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(189, 237, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(190, 238, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(191, 198, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(192, 199, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(193, 200, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(194, 201, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(195, 202, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(196, 203, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(197, 204, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(198, 205, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(199, 206, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(200, 207, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(201, 208, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(202, 209, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(203, 210, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(204, 211, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(205, 212, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(206, 222, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(207, 213, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(208, 214, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(209, 215, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(210, 216, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(211, 217, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(212, 218, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(213, 219, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(214, 220, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(215, 221, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(216, 223, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(217, 224, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(218, 225, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(219, 226, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(220, 227, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(221, 228, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(222, 229, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(223, 230, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(224, 239, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(225, 240, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(226, 241, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(227, 242, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(228, 243, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(229, 244, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(230, 245, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(231, 246, 2, '2021-02-27 06:19:34', '2021-02-27 06:19:34'),
(233, 194, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(234, 195, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(235, 196, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(236, 197, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(237, 255, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(238, 256, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(239, 188, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(240, 189, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(241, 190, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(242, 191, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(243, 192, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25'),
(244, 193, 2, '2021-02-28 04:31:25', '2021-02-28 04:31:25');

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
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `mfg_date` date NOT NULL,
  `exp_date` date NOT NULL,
  `production_status` enum('1','2','3','4') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Pending, 2=Processing,3=Packaging,4=Finished',
  `material_delivered_status` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Pending, 2=Delivered,3=Partially Delivered',
  `material_received_status` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Pending, 2=Received,3=Partially Received',
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_delivered_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_delivered_datetime` datetime DEFAULT NULL,
  `material_received_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_received_datetime` datetime DEFAULT NULL,
  `material_returned` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=Returned,2=Not Returned',
  `material_returned_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_returned_datetime` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productions`
--

INSERT INTO `productions` (`id`, `batch_no`, `warehouse_id`, `start_date`, `end_date`, `product_id`, `mfg_date`, `exp_date`, `production_status`, `material_delivered_status`, `material_received_status`, `description`, `status`, `created_by`, `modified_by`, `material_delivered_by`, `material_delivered_datetime`, `material_received_by`, `material_received_datetime`, `material_returned`, `material_returned_by`, `material_returned_datetime`, `created_at`, `updated_at`) VALUES
(7, '1001', 1, '2021-01-23', '2021-03-14', 2, '2021-01-23', '2021-02-01', '4', '2', '2', '', '1', 'Super Admin', 'Super Admin', 'Super Admin', '2021-01-24 12:32:17', 'Super Admin', '2021-01-24 12:32:23', '2', NULL, NULL, '2021-01-23 05:11:56', '2021-03-14 01:03:02'),
(18, '1002', 1, '2021-02-28', NULL, 2, '2021-02-28', '2021-02-28', '1', '1', '1', '', '1', 'Super Admin', 'Super Admin', NULL, NULL, NULL, NULL, '2', NULL, NULL, '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(19, '1003', 1, '2021-03-14', NULL, 2, '2021-03-14', '2022-03-14', '1', '1', '1', 'Lorem Ipsum dollar', '1', 'Super Admin', 'Super Admin', NULL, NULL, NULL, NULL, '2', NULL, NULL, '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(20, '1004', 1, '2021-06-02', '2021-06-02', 2, '2021-06-02', '2022-07-01', '4', '2', '2', '', '1', 'Super Admin', NULL, 'Super Admin', '2021-06-02 06:44:33', 'Super Admin', '2021-06-02 06:45:20', '1', 'Super Admin', '2021-06-02 07:06:08', '2021-06-02 00:43:55', '2021-06-02 01:07:40');

-- --------------------------------------------------------

--
-- Table structure for table `production_coupons`
--

CREATE TABLE `production_coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `production_id` bigint(20) UNSIGNED NOT NULL,
  `production_finished_good_id` bigint(20) UNSIGNED NOT NULL,
  `batch_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '1=Used, 2=Not Used',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `production_coupons`
--

INSERT INTO `production_coupons` (`id`, `production_id`, `production_finished_good_id`, `batch_no`, `coupon_code`, `status`, `created_at`, `updated_at`) VALUES
(1, 7, 5, '1001', '4Z6L0E98DI', '2', '2021-01-23 05:11:56', NULL),
(2, 7, 5, '1001', 'XV9MYLLWMW', '2', '2021-01-23 05:11:56', NULL),
(3, 7, 5, '1001', 'NV14YSCUUR', '2', '2021-01-23 05:11:56', NULL),
(4, 7, 5, '1001', 'VZHNT437X7', '2', '2021-01-23 05:11:56', NULL),
(5, 7, 5, '1001', 'FZ7TL9J323', '2', '2021-01-23 05:11:56', NULL),
(6, 7, 5, '1001', '3Z6B1JKF0Q', '2', '2021-01-23 05:11:56', NULL),
(7, 7, 5, '1001', '54B6DZUQLV', '2', '2021-01-23 05:11:56', NULL),
(8, 7, 5, '1001', '2GQRQ5H1E6', '2', '2021-01-23 05:11:56', NULL),
(9, 7, 5, '1001', 'ZLQNFA5PWF', '2', '2021-01-23 05:11:56', NULL),
(10, 7, 5, '1001', '8U59F13THE', '2', '2021-01-23 05:11:56', NULL),
(11, 7, 5, '1001', 'KSASLU1REV', '2', '2021-01-23 05:11:56', NULL),
(12, 7, 5, '1001', 'B0XAYMSA64', '2', '2021-01-23 05:11:56', NULL),
(13, 7, 5, '1001', '5P4W1W2ZAB', '2', '2021-01-23 05:11:56', NULL),
(14, 7, 5, '1001', 'TR6HD9S34F', '2', '2021-01-23 05:11:56', NULL),
(15, 7, 5, '1001', 'L7Y94AT7B4', '2', '2021-01-23 05:11:56', NULL),
(16, 7, 5, '1001', 'U922Q27ASW', '2', '2021-01-23 05:11:56', NULL),
(17, 7, 5, '1001', '1VSA2UBV7L', '2', '2021-01-23 05:11:56', NULL),
(18, 7, 5, '1001', '6SO50CGWAZ', '2', '2021-01-23 05:11:56', NULL),
(19, 7, 5, '1001', 'D2ISNOL0V0', '2', '2021-01-23 05:11:56', NULL),
(20, 7, 5, '1001', 'Y1UCW6A2TS', '2', '2021-01-23 05:11:56', NULL),
(21, 7, 5, '1001', '0K9TFIYEJ4', '2', '2021-01-23 05:11:56', NULL),
(22, 7, 5, '1001', 'MHZDSQ1JR0', '2', '2021-01-23 05:11:56', NULL),
(23, 7, 5, '1001', 'LJFJWCYSPD', '2', '2021-01-23 05:11:56', NULL),
(24, 7, 5, '1001', 'ATEP1A3ZKP', '2', '2021-01-23 05:11:56', NULL),
(25, 7, 5, '1001', 'DFQLSO30Y4', '2', '2021-01-23 05:11:56', NULL),
(26, 7, 5, '1001', 'FD8FLMQ35E', '2', '2021-01-23 05:11:56', NULL),
(27, 7, 5, '1001', '8TR42F9Z3Y', '2', '2021-01-23 05:11:56', NULL),
(28, 7, 5, '1001', 'ZYETC6LW6Y', '2', '2021-01-23 05:11:56', NULL),
(29, 7, 5, '1001', 'IDQGF2ZLY7', '2', '2021-01-23 05:11:56', NULL),
(30, 7, 5, '1001', 'MVALZ2YZQ4', '2', '2021-01-23 05:11:56', NULL),
(31, 7, 5, '1001', 'J7AY9WL13A', '2', '2021-01-23 05:11:56', NULL),
(32, 7, 5, '1001', 'VJEXFZJ2PH', '2', '2021-01-23 05:11:56', NULL),
(33, 7, 5, '1001', 'D1YO8IXQA3', '2', '2021-01-23 05:11:56', NULL),
(34, 7, 5, '1001', '0U1MMSWTIW', '2', '2021-01-23 05:11:56', NULL),
(35, 7, 5, '1001', 'A1TXC8PA14', '2', '2021-01-23 05:11:56', NULL),
(36, 7, 5, '1001', 'ODXECE56IN', '2', '2021-01-23 05:11:56', NULL),
(37, 7, 5, '1001', '4DUMM3NG0P', '2', '2021-01-23 05:11:56', NULL),
(38, 7, 5, '1001', 'KV7Y24IEUX', '2', '2021-01-23 05:11:56', NULL),
(39, 7, 5, '1001', 'RCGHUWCXZD', '2', '2021-01-23 05:11:56', NULL),
(40, 7, 5, '1001', 'B3MLLKOHGD', '2', '2021-01-23 05:11:56', NULL),
(41, 7, 5, '1001', 'GA9Q6JVWIY', '2', '2021-01-23 05:11:56', NULL),
(42, 7, 5, '1001', 'MALCZNB1UZ', '2', '2021-01-23 05:11:56', NULL),
(43, 7, 5, '1001', 'HOG34A57JT', '2', '2021-01-23 05:11:56', NULL),
(44, 7, 5, '1001', 'HW2T978QAW', '2', '2021-01-23 05:11:56', NULL),
(45, 7, 5, '1001', '5JH5DDPBYV', '2', '2021-01-23 05:11:56', NULL),
(46, 7, 5, '1001', 'KULZFJKTZ4', '2', '2021-01-23 05:11:56', NULL),
(47, 7, 5, '1001', 'XN95518QFF', '2', '2021-01-23 05:11:56', NULL),
(48, 7, 5, '1001', '0ORDIGWLTY', '2', '2021-01-23 05:11:56', NULL),
(49, 7, 5, '1001', '6LM53HNSII', '2', '2021-01-23 05:11:56', NULL),
(50, 7, 5, '1001', 'U9R0C1CN3Y', '2', '2021-01-23 05:11:56', NULL),
(51, 7, 6, '1001', 'P8KO6M1C21', '2', '2021-01-23 05:11:56', NULL),
(52, 7, 6, '1001', '7NX3F7RGU7', '2', '2021-01-23 05:11:56', NULL),
(53, 7, 6, '1001', 'EPC83YBZJ1', '2', '2021-01-23 05:11:56', NULL),
(54, 7, 6, '1001', '7X9V50NDI7', '2', '2021-01-23 05:11:56', NULL),
(55, 7, 6, '1001', 'ZKQIX05BUU', '1', '2021-01-23 05:11:56', '2021-02-03 04:10:03'),
(56, 7, 6, '1001', '6YG9OFTVOM', '1', '2021-01-23 05:11:56', '2021-02-03 04:17:38'),
(57, 7, 6, '1001', 'UA9UA17EWS', '2', '2021-01-23 05:11:56', NULL),
(58, 7, 6, '1001', 'STRFVF9O7U', '2', '2021-01-23 05:11:56', NULL),
(59, 7, 6, '1001', 'UI85KOQMEP', '2', '2021-01-23 05:11:56', NULL),
(60, 7, 6, '1001', 'YTKBCD51I0', '2', '2021-01-23 05:11:56', NULL),
(61, 18, 7, '1002', 'HJZNEW3875', '2', '2021-02-27 22:42:10', NULL),
(62, 18, 7, '1002', 'ERVQ7BBZ4Z', '2', '2021-02-27 22:42:10', NULL),
(63, 18, 7, '1002', 'YSA4V8N83L', '2', '2021-02-27 22:42:10', NULL),
(64, 19, 17, '1003', 'MYRQUWE5MD', '2', '2021-03-14 00:28:25', NULL),
(65, 19, 17, '1003', 'DRY46OPC05', '2', '2021-03-14 00:28:25', NULL),
(66, 19, 17, '1003', 'CO728HSDJR', '2', '2021-03-14 00:28:25', NULL),
(67, 19, 17, '1003', '18TAEYCVJ0', '2', '2021-03-14 00:28:25', NULL),
(68, 19, 17, '1003', '2Q5DKLJ6PL', '2', '2021-03-14 00:28:25', NULL),
(69, 19, 17, '1003', 'SBFVJTLF6A', '2', '2021-03-14 00:28:25', NULL),
(70, 19, 17, '1003', 'VAM5MHIHRH', '2', '2021-03-14 00:28:25', NULL),
(71, 19, 17, '1003', 'RG2E3PYMA6', '2', '2021-03-14 00:28:25', NULL),
(72, 19, 17, '1003', '2PE5PL9PVX', '2', '2021-03-14 00:28:25', NULL),
(73, 19, 17, '1003', '31TLQDX1HU', '2', '2021-03-14 00:28:25', NULL),
(74, 19, 17, '1003', 'TALHLNXDKP', '2', '2021-03-14 00:28:25', NULL),
(75, 19, 17, '1003', 'RO5SRZ3QLR', '2', '2021-03-14 00:28:25', NULL),
(76, 19, 17, '1003', 'PQ7LM6DTLP', '2', '2021-03-14 00:28:25', NULL),
(77, 19, 17, '1003', '1WMCYV2W1O', '2', '2021-03-14 00:28:25', NULL),
(78, 19, 17, '1003', 'K00MM2B4XM', '2', '2021-03-14 00:28:25', NULL),
(79, 19, 17, '1003', 'CS6S0KA55J', '2', '2021-03-14 00:28:25', NULL),
(80, 19, 17, '1003', 'I5S5727IDT', '2', '2021-03-14 00:28:25', NULL),
(81, 19, 17, '1003', '45Z321CUYB', '2', '2021-03-14 00:28:25', NULL),
(82, 19, 17, '1003', 'OE8MC3SHQ8', '2', '2021-03-14 00:28:25', NULL),
(83, 19, 17, '1003', 'KTN7SCRVYF', '2', '2021-03-14 00:28:25', NULL),
(84, 19, 17, '1003', 'AATVVXVPDN', '2', '2021-03-14 00:28:25', NULL),
(85, 19, 17, '1003', 'KWP71SHA8I', '2', '2021-03-14 00:28:25', NULL),
(86, 19, 17, '1003', 'PLZHWXCTSU', '2', '2021-03-14 00:28:25', NULL),
(87, 19, 17, '1003', '6VPEH3N7WG', '2', '2021-03-14 00:28:25', NULL),
(88, 19, 17, '1003', 'X6T3AV3X3R', '2', '2021-03-14 00:28:25', NULL),
(89, 19, 17, '1003', '5FKOA0LF8S', '2', '2021-03-14 00:28:25', NULL),
(90, 19, 17, '1003', '3CW9HC8D70', '2', '2021-03-14 00:28:25', NULL),
(91, 19, 17, '1003', '9Y0BXY8FDQ', '2', '2021-03-14 00:28:25', NULL),
(92, 19, 17, '1003', 'N33SACDHE7', '2', '2021-03-14 00:28:25', NULL),
(93, 19, 17, '1003', '8B951O88PJ', '2', '2021-03-14 00:28:25', NULL),
(94, 19, 18, '1003', 'NVL8YTAO8E', '2', '2021-03-14 00:28:25', NULL),
(95, 19, 18, '1003', 'X26R81BA4S', '2', '2021-03-14 00:28:25', NULL),
(96, 19, 18, '1003', 'VU1K50DVJ8', '2', '2021-03-14 00:28:25', NULL),
(97, 19, 18, '1003', '94JLILW6HF', '2', '2021-03-14 00:28:25', NULL),
(98, 19, 18, '1003', 'TMINZ5NEBJ', '2', '2021-03-14 00:28:25', NULL),
(99, 19, 18, '1003', 'PXO7PZ0N1Y', '2', '2021-03-14 00:28:25', NULL),
(100, 19, 18, '1003', 'TOWZXQTN3K', '2', '2021-03-14 00:28:25', NULL),
(101, 19, 18, '1003', 'RDYEZ10NYC', '2', '2021-03-14 00:28:25', NULL),
(102, 19, 18, '1003', '84FWAGXCQF', '2', '2021-03-14 00:28:25', NULL),
(103, 19, 18, '1003', '3U9C11T27I', '2', '2021-03-14 00:28:25', NULL),
(104, 19, 18, '1003', 'CUB27XCWAD', '2', '2021-03-14 00:28:25', NULL),
(105, 19, 18, '1003', '3ZIS8SJ13G', '2', '2021-03-14 00:28:25', NULL),
(106, 19, 18, '1003', '8AZA812L3C', '2', '2021-03-14 00:28:25', NULL),
(107, 19, 18, '1003', 'NFFPLBLMOF', '2', '2021-03-14 00:28:25', NULL),
(108, 19, 18, '1003', 'MH22FITAYP', '2', '2021-03-14 00:28:25', NULL),
(109, 19, 18, '1003', 'Z2MP86IACR', '2', '2021-03-14 00:28:25', NULL),
(110, 19, 18, '1003', 'P0BZF6E99N', '2', '2021-03-14 00:28:25', NULL),
(111, 19, 18, '1003', '04QPOYTWHO', '2', '2021-03-14 00:28:25', NULL),
(112, 19, 18, '1003', 'WD311CFBZ5', '2', '2021-03-14 00:28:25', NULL),
(113, 19, 18, '1003', 'NG1P3A3O4E', '2', '2021-03-14 00:28:25', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `production_finished_goods`
--

CREATE TABLE `production_finished_goods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `production_id` bigint(20) UNSIGNED NOT NULL,
  `batch_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finish_goods_id` bigint(20) UNSIGNED NOT NULL,
  `qty` double DEFAULT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `direct_cost` double DEFAULT NULL,
  `total_coupon` double(8,2) DEFAULT NULL,
  `coupon_price` double(8,2) DEFAULT NULL,
  `coupon_exp_date` date DEFAULT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `production_finished_goods`
--

INSERT INTO `production_finished_goods` (`id`, `production_id`, `batch_no`, `finish_goods_id`, `qty`, `unit_id`, `direct_cost`, `total_coupon`, `coupon_price`, `coupon_exp_date`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 7, '1001', 12, 50, NULL, 248, NULL, NULL, NULL, '1', 'Super Admin', 'Super Admin', '2021-01-23 05:11:56', '2021-01-26 04:06:50'),
(2, 7, '1001', 13, 20, NULL, 52, NULL, NULL, NULL, '1', 'Super Admin', 'Super Admin', '2021-01-23 05:11:56', '2021-02-27 21:47:16'),
(3, 7, '1001', 14, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'Super Admin', NULL, '2021-01-23 05:11:56', '2021-01-23 05:11:56'),
(4, 7, '1001', 15, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'Super Admin', NULL, '2021-01-23 05:11:56', '2021-01-23 05:11:56'),
(5, 7, '1001', 16, NULL, NULL, NULL, 50.00, 20.00, '2021-01-23', '1', 'Super Admin', NULL, '2021-01-23 05:11:56', '2021-01-23 05:11:56'),
(6, 7, '1001', 17, NULL, NULL, NULL, 10.00, 50.00, NULL, '1', 'Super Admin', NULL, '2021-01-23 05:11:56', '2021-01-23 05:11:56'),
(7, 18, '1002', 12, NULL, NULL, NULL, 3.00, 20.00, '2021-02-28', '1', 'Super Admin', NULL, '2021-02-27 22:42:10', '2021-02-27 22:42:10'),
(8, 18, '1002', 13, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'Super Admin', NULL, '2021-02-27 22:42:10', '2021-02-27 22:42:10'),
(9, 18, '1002', 14, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'Super Admin', NULL, '2021-02-27 22:42:10', '2021-02-27 22:42:10'),
(10, 18, '1002', 15, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'Super Admin', NULL, '2021-02-27 22:42:10', '2021-02-27 22:42:10'),
(11, 18, '1002', 16, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'Super Admin', NULL, '2021-02-27 22:42:10', '2021-02-27 22:42:10'),
(12, 18, '1002', 17, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'Super Admin', NULL, '2021-02-27 22:42:10', '2021-02-27 22:42:10'),
(13, 19, '1003', 12, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'Super Admin', NULL, '2021-03-14 00:28:25', '2021-03-14 00:28:25'),
(14, 19, '1003', 13, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'Super Admin', NULL, '2021-03-14 00:28:25', '2021-03-14 00:28:25'),
(15, 19, '1003', 14, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'Super Admin', NULL, '2021-03-14 00:28:25', '2021-03-14 00:28:25'),
(16, 19, '1003', 15, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'Super Admin', NULL, '2021-03-14 00:28:25', '2021-03-14 00:28:25'),
(17, 19, '1003', 16, NULL, NULL, NULL, 30.00, 10.00, '2022-03-14', '1', 'Super Admin', NULL, '2021-03-14 00:28:25', '2021-03-14 00:28:25'),
(18, 19, '1003', 17, NULL, NULL, NULL, 20.00, 20.00, '2022-03-14', '1', 'Super Admin', NULL, '2021-03-14 00:28:25', '2021-03-14 00:28:25'),
(19, 20, '1004', 12, 400, NULL, 1000, NULL, NULL, NULL, '1', 'Super Admin', 'Super Admin', '2021-06-02 00:43:55', '2021-06-02 00:48:01'),
(20, 20, '1004', 13, 200, NULL, 1200, NULL, NULL, NULL, '1', 'Super Admin', 'Super Admin', '2021-06-02 00:43:55', '2021-06-02 00:49:52'),
(21, 20, '1004', 14, 300, NULL, 3400, NULL, NULL, NULL, '1', 'Super Admin', 'Super Admin', '2021-06-02 00:43:55', '2021-06-02 00:51:12');

-- --------------------------------------------------------

--
-- Table structure for table `production_materials`
--

CREATE TABLE `production_materials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `production_id` bigint(20) UNSIGNED NOT NULL,
  `batch_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `material_id` bigint(20) UNSIGNED NOT NULL,
  `required_qty` double(8,2) NOT NULL,
  `delivered_qty` double(8,2) DEFAULT NULL,
  `received_qty` double(8,2) DEFAULT NULL,
  `used_qty` double(8,2) DEFAULT NULL,
  `damaged_qty` double(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `production_materials`
--

INSERT INTO `production_materials` (`id`, `production_id`, `batch_no`, `material_id`, `required_qty`, `delivered_qty`, `received_qty`, `used_qty`, `damaged_qty`, `created_at`, `updated_at`) VALUES
(1, 7, '1001', 1, 10000.00, 10000.00, 10000.00, 950.00, 110.00, '2021-01-23 05:11:56', '2021-02-27 21:47:16'),
(2, 7, '1001', 11, 5.00, 5.00, 5.00, 3.00, 0.00, '2021-01-23 05:11:56', '2021-02-27 21:47:16'),
(3, 7, '1001', 13, 50.00, 50.00, 50.00, 13.00, 1.00, '2021-01-23 05:11:56', '2021-02-27 21:47:16'),
(20, 18, '1002', 1, 1000.00, NULL, NULL, NULL, NULL, '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(21, 18, '1002', 11, 10.00, NULL, NULL, NULL, NULL, '2021-02-27 22:42:10', '2021-02-27 22:42:47'),
(22, 19, '1003', 1, 9000.00, NULL, NULL, NULL, NULL, '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(23, 19, '1003', 12, 6.00, NULL, NULL, NULL, NULL, '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(24, 19, '1003', 13, 8.00, NULL, NULL, NULL, NULL, '2021-03-14 00:28:25', '2021-03-14 00:30:34'),
(25, 20, '1004', 1, 50000.00, 50000.00, 50000.00, 48000.00, 0.00, '2021-06-02 00:43:55', '2021-06-02 00:51:12'),
(26, 20, '1004', 12, 50.00, 50.00, 50.00, 40.00, 0.00, '2021-06-02 00:43:55', '2021-06-02 00:51:12'),
(27, 20, '1004', 13, 50.00, 50.00, 50.00, 40.00, 0.00, '2021-06-02 00:43:55', '2021-06-02 00:51:12');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `product_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tax_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_method` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Exclusive, 2=Inclusive',
  `type` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Foil, 2=Can',
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

INSERT INTO `products` (`id`, `category_id`, `product_image`, `product_name`, `tax_id`, `tax_method`, `type`, `status`, `description`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(2, 6, '61r8KeFPqvL._SL1000_-471388.jpg', 'Turmeric Powder', 1, '2', '1', '1', 'Lorem ipsum dollar', 'Super Admin', 'Super Admin', '2021-01-20 04:44:09', '2021-01-23 05:33:08'),
(7, 6, 'large-dhartigunturchillipdr200g-575857.jpg', 'Chilli Powder', NULL, '1', '1', '1', 'Lorem ipsum dollar', 'Super Admin', 'Super Admin', '2021-03-01 21:33:26', '2021-03-01 21:34:04'),
(8, 12, 'unnamed-363145.jpg', 'Ghee', NULL, '1', '2', '1', '', 'Super Admin', 'Super Admin', '2021-03-01 21:44:05', '2021-03-01 21:44:38');

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
(1, 2, 1, '2021-01-20 04:44:09', '2021-01-20 04:44:09'),
(2, 2, 12, '2021-01-20 04:44:09', '2021-01-20 04:44:09'),
(3, 2, 13, '2021-01-20 04:44:09', '2021-01-20 04:44:09'),
(12, 7, 2, '2021-03-01 21:33:26', '2021-03-01 21:33:26'),
(13, 7, 11, '2021-03-01 21:33:26', '2021-03-01 21:33:26'),
(14, 8, 8, '2021-03-01 21:44:05', '2021-03-01 21:44:05'),
(15, 8, 13, '2021-03-01 21:44:05', '2021-03-01 21:44:05');

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
  `total_labor_cost` double DEFAULT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `paid_amount` double NOT NULL,
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

INSERT INTO `purchases` (`id`, `memo_no`, `warehouse_id`, `supplier_id`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_labor_cost`, `total_cost`, `order_tax_rate`, `order_tax`, `order_discount`, `shipping_cost`, `grand_total`, `paid_amount`, `purchase_status`, `payment_status`, `payment_method`, `document`, `note`, `purchase_date`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(8, 'PINV-1001', 1, 1, 1.00, 100.00, 0, 0, 0, 10000, 0, 0, NULL, 500, 10500, 0, '1', '3', '1', NULL, '', '2021-06-02', 'Super Admin', NULL, '2021-06-02 00:19:22', '2021-06-02 00:19:22'),
(9, 'PINV-1002', 1, 1, 2.00, 200.00, 0, 0, 0, 2000, 0, 0, NULL, NULL, 2000, 2000, '1', '1', '1', NULL, '', '2021-06-02', 'Super Admin', NULL, '2021-06-02 00:22:57', '2021-06-02 00:22:57');

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
(1, 9, 20, 16, 15, 2000, '1', '', NULL, 'Super Admin', NULL, '2021-06-02 00:22:57', '2021-06-02 00:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `received_coupons`
--

CREATE TABLE `received_coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `asm_id` bigint(20) UNSIGNED NOT NULL,
  `salesmen_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `coupon_id` bigint(20) UNSIGNED NOT NULL,
  `coupon_price` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `received_coupons`
--

INSERT INTO `received_coupons` (`id`, `asm_id`, `salesmen_id`, `customer_id`, `coupon_id`, `coupon_price`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 7, 55, 50.00, '2021-02-03 04:10:03', '2021-02-03 04:10:03'),
(2, 1, 2, 10, 56, 50.00, '2021-02-03 04:17:38', '2021-02-03 04:17:38');

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
  `asm_id` bigint(20) UNSIGNED NOT NULL,
  `salesmen_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `item` double(8,2) NOT NULL,
  `total_qty` double(8,2) NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_labor_cost` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `paid_amount` double DEFAULT NULL,
  `due_amount` double DEFAULT NULL,
  `previous_due` double DEFAULT NULL,
  `payment_status` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Paid,2=Partial,3=Due',
  `payment_method` enum('1','2','3') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1=Cash,2=Bank Deposit,3=Mobile',
  `account_id` int(11) DEFAULT NULL,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `sale_date` date NOT NULL,
  `delivery_status` enum('1','2','3') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1=Packing,2=Delivering,3=Delivered',
  `delivery_date` date DEFAULT NULL,
  `received_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authorized_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `memo_no`, `warehouse_id`, `asm_id`, `salesmen_id`, `customer_id`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_labor_cost`, `total_price`, `order_tax_rate`, `order_tax`, `order_discount`, `shipping_cost`, `grand_total`, `paid_amount`, `due_amount`, `previous_due`, `payment_status`, `payment_method`, `account_id`, `document`, `note`, `sale_date`, `delivery_status`, `delivery_date`, `received_by`, `authorized_by`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'SINV-20210602052130332', 2, 1, 1, 7, 1.00, 10.00, 0, 0, 0, 700, 0, 0, 0, 0, 700, 700, 0, 0, '1', '1', 20, NULL, '', '2021-06-02', NULL, NULL, NULL, NULL, 'Super Admin', NULL, '2021-06-01 23:22:16', '2021-06-01 23:22:16'),
(2, 'SINV-2021060207145249', 2, 1, 1, 7, 1.00, 1.00, 0, 0, 0, 840, 0, 0, 0, 0, 840, 840, 0, 0, '1', '1', 20, NULL, '', '2021-06-02', NULL, NULL, NULL, NULL, 'Super Admin', NULL, '2021-06-02 01:20:07', '2021-06-02 01:20:07');

-- --------------------------------------------------------

--
-- Table structure for table `salesmen`
--

CREATE TABLE `salesmen` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `asm_id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `upazila_id` bigint(20) UNSIGNED NOT NULL,
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

INSERT INTO `salesmen` (`id`, `name`, `username`, `phone`, `email`, `avatar`, `password`, `asm_id`, `district_id`, `upazila_id`, `address`, `status`, `created_by`, `modified_by`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Mr. Hasan', 'hasan', '01521225988', '', NULL, '$2y$10$A5jIaFlREkxsXUAU5qpeTuQZahPT4FXMhoOKGMopXu6w85YFNijJ.', 1, 46, 425, 'Lorem ipsum dollar', '1', 'Admin', 'Mohammad Arman', NULL, '2021-02-01 08:12:41', '2021-02-03 04:37:14'),
(2, 'Md. Hamid', 'hamid', '01521225984', 'hamid@gmail.com', NULL, '$2y$10$81IUGONTbaXcsPToOvHOJu7dRrh/z1NYMFgTSUi7iU2gKpUjfPmee', 1, 46, 421, 'Lorem ipsum dollar', '1', 'Super Admin', 'Super Admin', NULL, '2021-02-01 04:08:18', '2021-02-01 21:58:53'),
(3, 'Mr. Rana', 'rana', '01680950236', 'rana@gmail.com', NULL, '12345678', 2, 1, 70, '', '1', 'Mr. XYZ', NULL, NULL, '2021-02-09 23:16:00', '2021-02-09 23:16:00');

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
(7, 2, '1', 567, '2021-02-01 06:18:51', '2021-02-01 21:59:03'),
(8, 2, '2', 568, '2021-02-01 06:18:51', '2021-02-01 21:59:03'),
(9, 2, '3', 569, '2021-02-01 06:18:51', '2021-02-01 21:59:03'),
(10, 2, '4', 570, '2021-02-01 06:18:51', '2021-02-01 21:59:03'),
(11, 2, '5', 571, '2021-02-01 06:18:51', '2021-02-01 21:59:03'),
(12, 2, '6', 572, '2021-02-01 06:18:51', '2021-02-01 21:59:03'),
(13, 1, '1', 560, '2021-02-03 01:49:12', '2021-02-03 02:40:59'),
(14, 1, '2', 561, '2021-02-03 01:49:12', '2021-02-03 02:40:59'),
(15, 1, '3', 562, '2021-02-03 01:49:12', '2021-02-03 02:40:59'),
(16, 1, '4', 564, '2021-02-03 01:49:12', '2021-02-03 02:40:59'),
(17, 1, '5', 565, '2021-02-03 01:49:12', '2021-02-03 02:40:59'),
(18, 1, '6', 566, '2021-02-03 01:49:12', '2021-02-03 02:40:59'),
(19, 3, '1', 573, '2021-02-09 23:16:00', '2021-02-09 23:16:00'),
(20, 3, '2', 574, '2021-02-09 23:16:00', '2021-02-09 23:16:00'),
(21, 3, '3', 575, '2021-02-09 23:16:00', '2021-02-09 23:16:00'),
(22, 3, '4', 576, '2021-02-09 23:16:00', '2021-02-09 23:16:00'),
(23, 3, '5', 577, '2021-02-09 23:16:00', '2021-02-09 23:16:00'),
(24, 3, '6', 578, '2021-02-09 23:16:00', '2021-02-09 23:16:00');

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
('F9jEP655RjRbEhTiXCmd9EqGKwYEDwIaPocIWiiC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM0xuOWNPR0ZkTm9TNnJxeTY5V3AzbEc1dW1lNjNEWG9EMVNYYUVyZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9lcnAudGVzdC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1622607793);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('jjti2NFDPsNCK7WBuLpdalKfUKXChUGurVWgQC3t', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0', '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MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6NDg7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE5OiJQcm9kdWN0aW9uIEZpbmlzaGVkIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO3M6MDoiIjtzOjM6InVybCI7czoxOToicHJvZHVjdGlvbi1maW5pc2hlZCI7czo1OiJvcmRlciI7aTozO3M6OToicGFyZW50X2lkIjtpOjQwO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTAxLTA4IDIxOjU2OjAzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTAxLTA4IDIxOjU2OjE2Ijt9czoxMToiACoAb3JpZ2luYWwiO2E6MTI6e3M6MjoiaWQiO2k6NDg7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE5OiJQcm9kdWN0aW9uIEZpbmlzaGVkIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO3M6MDoiIjtzOjM6InVybCI7czoxOToicHJvZHVjdGlvbi1maW5pc2hlZCI7czo1OiJvcmRlciI7aTozO3M6OToicGFyZW50X2lkIjtpOjQwO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTAxLTA4IDIxOjU2OjAzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTAxLTA4IDIxOjU2OjE2Ijt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czo4OiIA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AGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6NzM7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE2OiJWb3VjaGVyIEFwcHJvdmFsIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO3M6MDoiIjtzOjM6InVybCI7czoxNjoidm91Y2hlci1hcHByb3ZhbCI7czo1OiJvcmRlciI7aToxMDtzOjk6InBhcmVudF9pZCI7aTo2MztzOjY6InRhcmdldCI7czo1OiJfc2VsZiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMS0wMi0xNCAwOTo0NzozNyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMS0wMi0xNCAxMDoyNzo1NiI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjczO3M6NzoibWVudV9pZCI7aToxO3M6NDoidHlwZSI7czoxOiIyIjtzOjExOiJtb2R1bGVfbmFtZSI7czoxNjoiVm91Y2hlciBBcHByb3ZhbCI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtzOjA6IiI7czozOiJ1cmwiO3M6MTY6InZvdWNoZXItYXBwcm92YWwiO3M6NToib3JkZXIiO2k6MTA7czo5OiJwYXJlbnRfaWQiO2k6NjM7czo2OiJ0YXJnZXQiO3M6NToiX3NlbGYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjEtMDItMTQgMDk6NDc6MzciO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjEtMDItMTQgMTA6Mjc6NTYiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6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aW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6MzQ7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE2OiJCYW5rIFRyYW5zYWN0aW9uIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO3M6MDoiIjtzOjM6InVybCI7czoxNjoiYmFuay10cmFuc2FjdGlvbiI7czo1OiJvcmRlciI7aToyO3M6OToicGFyZW50X2lkIjtpOjMyO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIwLTEyLTA2IDAzOjQ0OjEzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIwLTEyLTA2IDAzOjQ0OjI5Ijt9czoxMToiACoAb3JpZ2luYWwiO2E6MTI6e3M6MjoiaWQiO2k6MzQ7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE2OiJCYW5rIFRyYW5zYWN0aW9uIjtzOjEzOiJkaXZpZGVyX3RpdGxlIjtOO3M6MTA6Imljb25fY2xhc3MiO3M6MDoiIjtzOjM6InVybCI7czoxNjoiYmFuay10cmFuc2FjdGlvbiI7czo1OiJvcmRlciI7aToyO3M6OToicGFyZW50X2lkIjtpOjMyO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIwLTEyLTA2IDAzOjQ0OjEzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIwLTEyLTA2IDAzOjQ0OjI5Ijt9czox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aW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6NTg7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE0OiJDdXN0b21lciBHcm91cCI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtzOjEyOiJmYXMgZmEtdXNlcnMiO3M6MzoidXJsIjtzOjE0OiJjdXN0b21lci1ncm91cCI7czo1OiJvcmRlciI7aTozO3M6OToicGFyZW50X2lkIjtpOjIzO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTAyLTAyIDEwOjI3OjE0IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTAyLTAyIDEwOjI4OjU3Ijt9czoxMToiACoAb3JpZ2luYWwiO2E6MTI6e3M6MjoiaWQiO2k6NTg7czo3OiJtZW51X2lkIjtpOjE7czo0OiJ0eXBlIjtzOjE6IjIiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE0OiJDdXN0b21lciBHcm91cCI7czoxMzoiZGl2aWRlcl90aXRsZSI7TjtzOjEwOiJpY29uX2NsYXNzIjtzOjEyOiJmYXMgZmEtdXNlcnMiO3M6MzoidXJsIjtzOjE0OiJjdXN0b21lci1ncm91cCI7czo1OiJvcmRlciI7aTozO3M6OToicGFyZW50X2lkIjtpOjIzO3M6NjoidGFyZ2V0IjtzOjU6Il9zZWxmIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDIxLTAyLTAyIDEwOjI3OjE0IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDIxLTAyLTAyIDEwOjI4OjU3Ijt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czo4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OjE7czoxMDoiYXNtLWFjY2VzcyI7aToyO3M6NzoiYXNtLWFkZCI7aTozO3M6MTU6ImFzbS1idWxrLWRlbGV0ZSI7aTo0O3M6MTA6ImFzbS1kZWxldGUiO2k6NTtzOjg6ImFzbS1lZGl0IjtpOjY7czoxMDoiYXNtLXJlcG9ydCI7aTo3O3M6ODoiYXNtLXZpZXciO2k6ODtzOjExOiJiYW5rLWFjY2VzcyI7aTo5O3M6ODoiYmFuay1hZGQiO2k6MTA7czoxNjoiYmFuay1ib29rLWFjY2VzcyI7aToxMTtzOjExOiJiYW5rLWRlbGV0ZSI7aToxMjtzOjk6ImJhbmstZWRpdCI7aToxMztzOjE4OiJiYW5rLWxlZGdlci1hY2Nlc3MiO2k6MTQ7czoxMToiYmFuay1yZXBvcnQiO2k6MTU7czoyMzoiYmFuay10cmFuc2FjdGlvbi1hY2Nlc3MiO2k6MTY7czoyMjoiY2FzaC1hZGp1c3RtZW50LWFjY2VzcyI7aToxNztzOjE2OiJjYXNoLWJvb2stYWNjZXNzIjtpOjE4O3M6MTY6ImNhc2gtZmxvdy1hY2Nlc3MiO2k6MTk7czoxNDoiY2xvc2luZy1hY2Nlc3MiO2k6MjA7czoyMToiY2xvc2luZy1yZXBvcnQtYWNjZXNzIjtpOjIxO3M6MTA6ImNvYS1hY2Nlc3MiO2k6MjI7czo3OiJjb2EtYWRkIjtpOjIzO3M6MTA6ImNvYS1kZWxldGUiO2k6MjQ7czo4OiJjb2EtZWRpdCI7aToyNTtzOjEwOiJjb2EtcmVwb3J0IjtpOjI2O3M6MjE6ImNvbnRyYS12b3VjaGVyLWFjY2VzcyI7aToyNztzOjIyOiJjb3Vwb24tcmVjZWl2ZWQtYWNjZXNzIjtpOjI4O3M6MjI6ImNvdXBvbi1yZWNlaXZlZC1yZXBvcnQiO2k6Mjk7czoyMjoiY3JlZGl0LWN1c3RvbWVyLWFjY2VzcyI7aTozMDtzOjIxOiJjcmVkaXQtdm91Y2hlci1hY2Nlc3MiO2k6MzE7czoxNToiY3VzdG9tZXItYWNjZXNzIjtpOjMyO3M6MTI6ImN1c3RvbWVyLWFkZCI7aTozMztzOjIzOiJjdXN0b21lci1hZHZhbmNlLWFjY2VzcyI7aTozNDtzOjIwOiJjdXN0b21lci1hZHZhbmNlLWFkZCI7aTozNTtzOjI4OiJjdXN0b21lci1hZHZhbmNlLWJ1bGstZGVsZXRlIjtpOjM2O3M6MjM6ImN1c3RvbWVyLWFkdmFuY2UtZGVsZXRlIjtpOjM3O3M6MjE6ImN1c3RvbWVyLWFkdmFuY2UtZWRpdCI7aTozODtzOjIzOiJjdXN0b21lci1hZHZhbmNlLXJlcG9ydCI7aTozOTtzOjIwOiJjdXN0b21lci1idWxrLWRlbGV0ZSI7aTo0MDtzOjE1OiJjdXN0b21lci1kZWxldGUiO2k6NDE7czoxMzoiY3VzdG9tZXItZWRpdCI7aTo0MjtzOjIxOiJjdXN0b21lci1ncm91cC1hY2Nlc3MiO2k6NDM7czoxODoiY3VzdG9tZXItZ3JvdXAtYWRkIjtpOjQ0O3M6MjY6ImN1c3RvbWVyLWdyb3VwLWJ1bGstZGVsZXRlIjtpOjQ1O3M6MjE6ImN1c3RvbWVyLWdyb3VwLWRlbGV0ZSI7aTo0NjtzOjE5OiJjdXN0b21lci1ncm91cC1lZGl0IjtpOjQ3O3M6MjE6ImN1c3RvbWVyLWdyb3VwLXJlcG9ydCI7aTo0ODtzOjIyOiJjdXN0b21lci1sZWRnZXItYWNjZXNzIjtpOjQ5O3M6MjM6ImN1c3RvbWVyLXJlY2VpdmUtYWNjZXNzIjtpOjUwO3M6MTU6ImN1c3RvbWVyLXJlcG9ydCI7aTo1MTtzOjEzOiJjdXN0b21lci12aWV3IjtpOjUyO3M6MTY6ImRhc2hib2FyZC1hY2Nlc3MiO2k6NTM7czoyMDoiZGViaXQtdm91Y2hlci1hY2Nlc3MiO2k6NTQ7czoxNDoiZGVsZXRlLXZvdWNoZXIiO2k6NTU7czoxNzoiZGVwYXJ0bWVudC1hY2Nlc3MiO2k6NTY7czoxNDoiZGVwYXJ0bWVudC1hZGQiO2k6NTc7czoyMjoiZGVwYXJ0bWVudC1idWxrLWRlbGV0ZSI7aTo1ODtzOjE3OiJkZXBhcnRtZW50LWRlbGV0ZSI7aTo1OTtzOjE1OiJkZXBhcnRtZW50LWVkaXQiO2k6NjA7czoxNzoiZGVwYXJ0bWVudC1yZXBvcnQiO2k6NjE7czoxODoiZGVzaWduYXRpb24tYWNjZXNzIjtpOjYyO3M6MTU6ImRlc2lnbmF0aW9uLWFkZCI7aTo2MztzOjIzOiJkZXNpZ25hdGlvbi1idWxrLWRlbGV0ZSI7aTo2NDtzOjE4OiJkZXNpZ25hdGlvbi1kZWxldGUiO2k6NjU7czoxNjoiZGVzaWduYXRpb24tZWRpdCI7aTo2NjtzOjE4OiJkZXNpZ25hdGlvbi1yZXBvcnQiO2k6Njc7czoxNToiZGlzdHJpY3QtYWNjZXNzIjtpOjY4O3M6MTI6ImRpc3RyaWN0LWFkZCI7aTo2OTtzOjIwOiJkaXN0cmljdC1idWxrLWRlbGV0ZSI7aTo3MDtzOjE1OiJkaXN0cmljdC1kZWxldGUiO2k6NzE7czoxMzoiZGlzdHJpY3QtZWRpdCI7aTo3MjtzOjE1OiJkaXN0cmljdC1yZXBvcnQiO2k6NzM7czoxNToiZGl2aXNpb24tYWNjZXNzIjtpOjc0O3M6MTI6ImRpdmlzaW9uLWFkZCI7aTo3NTtzOjIwOiJkaXZpc2lvbi1idWxrLWRlbGV0ZSI7aTo3NjtzOjE1OiJkaXZpc2lvbi1kZWxldGUiO2k6Nzc7czoxMzoiZGl2aXNpb24tZWRpdCI7aTo3ODtzOjE1OiJkaXZpc2lvbi1yZXBvcnQiO2k6Nzk7czoxNzoiZHVlLXJlcG9ydC1hY2Nlc3MiO2k6ODA7czoxMjoiZWRpdC12b3VjaGVyIjtpOjgxO3M6MTU6ImVtcGxveWVlLWFjY2VzcyI7aTo4MjtzOjEyOiJlbXBsb3llZS1hZGQiO2k6ODM7czoyMDoiZW1wbG95ZWUtYnVsay1kZWxldGUiO2k6ODQ7czoxNToiZW1wbG95ZWUtZGVsZXRlIjtpOjg1O3M6MTM6ImVtcGxveWVlLWVkaXQiO2k6ODY7czoxNToiZW1wbG95ZWUtcmVwb3J0IjtpOjg3O3M6MTM6ImVtcGxveWVlLXZpZXciO2k6ODg7czoxNDoiZXhwZW5zZS1hY2Nlc3MiO2k6ODk7czoxMToiZXhwZW5zZS1hZGQiO2k6OTA7czoxOToiZXhwZW5zZS1idWxrLWRlbGV0ZSI7aTo5MTtzOjE0OiJleHBlbnNlLWRlbGV0ZSI7aTo5MjtzOjEyOiJleHBlbnNlLWVkaXQiO2k6OTM7czoxOToiZXhwZW5zZS1pdGVtLWFjY2VzcyI7aTo5NDtzOjE2OiJleHBlbnNlLWl0ZW0tYWRkIjtpOjk1O3M6MjQ6ImV4cGVuc2UtaXRlbS1idWxrLWRlbGV0ZSI7aTo5NjtzOjE5OiJleHBlbnNlLWl0ZW0tZGVsZXRlIjtpOjk3O3M6MTc6ImV4cGVuc2UtaXRlbS1lZGl0IjtpOjk4O3M6MTk6ImV4cGVuc2UtaXRlbS1yZXBvcnQiO2k6OTk7czoxNDoiZXhwZW5zZS1yZXBvcnQiO2k6MTAwO3M6MjQ6ImV4cGVuc2Utc3RhdGVtZW50LWFjY2VzcyI7aToxMDE7czoyMToiZ2VuZXJhbC1sZWRnZXItYWNjZXNzIjtpOjEwMjtzOjE2OiJpbnZlbnRvcnktYWNjZXNzIjtpOjEwMztzOjIxOiJpbnZlbnRvcnktYnVsay1kZWxldGUiO2k6MTA0O3M6MTY6ImludmVudG9yeS1kZWxldGUiO2k6MTA1O3M6MTQ6ImludmVudG9yeS1lZGl0IjtpOjEwNjtzOjIzOiJpbnZlbnRvcnktbGVkZ2VyLWFjY2VzcyI7aToxMDc7czoxNjoiaW52ZW50b3J5LXJlcG9ydCI7aToxMDg7czoxNDoiaW52ZW50b3J5LXZpZXciO2k6MTA5O3M6MjI6ImpvdXJuYWwtdm91Y2hlci1hY2Nlc3MiO2k6MTEwO3M6MTU6Im1hdGVyaWFsLWFjY2VzcyI7aToxMTE7czoxMjoibWF0ZXJpYWwtYWRkIjtpOjExMjtzOjIwOiJtYXRlcmlhbC1idWxrLWRlbGV0ZSI7aToxMTM7czoyNDoibWF0ZXJpYWwtY2F0ZWdvcnktYWNjZXNzIjtpOjExNDtzOjIxOiJtYXRlcmlhbC1jYXRlZ29yeS1hZGQiO2k6MTE1O3M6Mjk6Im1hdGVyaWFsLWNhdGVnb3J5LWJ1bGstZGVsZXRlIjtpOjExNjtzOjI0OiJtYXRlcmlhbC1jYXRlZ29yeS1kZWxldGUiO2k6MTE3O3M6MjI6Im1hdGVyaWFsLWNhdGVnb3J5LWVkaXQiO2k6MTE4O3M6MjQ6Im1hdGVyaWFsLWNhdGVnb3J5LXJlcG9ydCI7aToxMTk7czoxNToibWF0ZXJpYWwtZGVsZXRlIjtpOjEyMDtzOjEzOiJtYXRlcmlhbC1lZGl0IjtpOjEyMTtzOjE1OiJtYXRlcmlhbC1yZXBvcnQiO2k6MTIyO3M6MTM6Im1hdGVyaWFsLXZpZXciO2k6MTIzO3M6MTE6Im1lbnUtYWNjZXNzIjtpOjEyNDtzOjg6Im1lbnUtYWRkIjtpOjEyNTtzOjE5OiJtZW51LWJ1aWxkZXItYWNjZXNzIjtpOjEyNjtzOjE2OiJtZW51LWJ1bGstZGVsZXRlIjtpOjEyNztzOjExOiJtZW51LWRlbGV0ZSI7aToxMjg7czo5OiJtZW51LWVkaXQiO2k6MTI5O3M6MTU6Im1lbnUtbW9kdWxlLWFkZCI7aToxMzA7czoxODoibWVudS1tb2R1bGUtZGVsZXRlIjtpOjEzMTtzOjE2OiJtZW51LW1vZHVsZS1lZGl0IjtpOjEzMjtzOjExOiJtZW51LXJlcG9ydCI7aToxMzM7czoxODoibW9iaWxlLWJhbmstYWNjZXNzIjtpOjEzNDtzOjE1OiJtb2JpbGUtYmFuay1hZGQiO2k6MTM1O3M6MjM6Im1vYmlsZS1iYW5rLWJvb2stYWNjZXNzIjtpOjEzNjtzOjE4OiJtb2JpbGUtYmFuay1kZWxldGUiO2k6MTM3O3M6MTY6Im1vYmlsZS1iYW5rLWVkaXQiO2k6MTM4O3M6MjU6Im1vYmlsZS1iYW5rLWxlZGdlci1hY2Nlc3MiO2k6MTM5O3M6MTg6Im1vYmlsZS1iYW5rLXJlcG9ydCI7aToxNDA7czozMDoibW9iaWxlLWJhbmstdHJhbnNhY3Rpb24tYWNjZXNzIjtpOjE0MTtzOjIyOiJvcGVuaW5nLWJhbGFuY2UtYWNjZXNzIjtpOjE0MjtzOjIwOiJwYWlkLWN1c3RvbWVyLWFjY2VzcyI7aToxNDM7czoxNzoicGVybWlzc2lvbi1hY2Nlc3MiO2k6MTQ0O3M6MTQ6InBlcm1pc3Npb24tYWRkIjtpOjE0NTtzOjIyOiJwZXJtaXNzaW9uLWJ1bGstZGVsZXRlIjtpOjE0NjtzOjE3OiJwZXJtaXNzaW9uLWRlbGV0ZSI7aToxNDc7czoxNToicGVybWlzc2lvbi1lZGl0IjtpOjE0ODtzOjE3OiJwZXJtaXNzaW9uLXJlcG9ydCI7aToxNDk7czoyMDoicHJpbnQtYmFyY29kZS1hY2Nlc3MiO2k6MTUwO3M6MTQ6InByb2R1Y3QtYWNjZXNzIjtpOjE1MTtzOjExOiJwcm9kdWN0LWFkZCI7aToxNTI7czoxOToicHJvZHVjdC1idWxrLWRlbGV0ZSI7aToxNTM7czoyMzoicHJvZHVjdC1jYXRlZ29yeS1hY2Nlc3MiO2k6MTU0O3M6MjA6InByb2R1Y3QtY2F0ZWdvcnktYWRkIjtpOjE1NTtzOjI4OiJwcm9kdWN0LWNhdGVnb3J5LWJ1bGstZGVsZXRlIjtpOjE1NjtzOjIzOiJwcm9kdWN0LWNhdGVnb3J5LWRlbGV0ZSI7aToxNTc7czoyMToicHJvZHVjdC1jYXRlZ29yeS1lZGl0IjtpOjE1ODtzOjIzOiJwcm9kdWN0LWNhdGVnb3J5LXJlcG9ydCI7aToxNTk7czoyODoicHJvZHVjdC1jb3Vwb24tcmVwb3J0LWFjY2VzcyI7aToxNjA7czoxNDoicHJvZHVjdC1kZWxldGUiO2k6MTYxO3M6MTI6InByb2R1Y3QtZWRpdCI7aToxNjI7czoxNDoicHJvZHVjdC1yZXBvcnQiO2k6MTYzO3M6MTI6InByb2R1Y3QtdmlldyI7aToxNjQ7czozMjoicHJvZHVjdC13aXNlLXNhbGVzLXJlcG9ydC1hY2Nlc3MiO2k6MTY1O3M6MTc6InByb2R1Y3Rpb24tYWNjZXNzIjtpOjE2NjtzOjE0OiJwcm9kdWN0aW9uLWFkZCI7aToxNjc7czoxNzoicHJvZHVjdGlvbi1kZWxldGUiO2k6MTY4O3M6MTU6InByb2R1Y3Rpb24tZWRpdCI7aToxNjk7czoyNjoicHJvZHVjdGlvbi1maW5pc2hlZC1hY2Nlc3MiO2k6MTcwO3M6MjQ6InByb2R1Y3Rpb24tZmluaXNoZWQtdmlldyI7aToxNzE7czoyNzoicHJvZHVjdGlvbi1tYXRlcmlhbC1kZWxpdmVyIjtpOjE3MjtzOjI3OiJwcm9kdWN0aW9uLW1hdGVyaWFsLXJlY2VpdmUiO2k6MTczO3M6MjA6InByb2R1Y3Rpb24tcGFja2FnaW5nIjtpOjE3NDtzOjIzOiJwcm9kdWN0aW9uLXFyY29kZS1wcmludCI7aToxNzU7czoxNzoicHJvZHVjdGlvbi1yZXBvcnQiO2k6MTc2O3M6MjQ6InByb2R1Y3Rpb24tcmVwb3J0LWFjY2VzcyI7aToxNzc7czoxNToicHJvZHVjdGlvbi12aWV3IjtpOjE3ODtzOjE4OiJwcm9maXQtbG9zcy1hY2Nlc3MiO2k6MTc5O3M6MTU6InB1cmNoYXNlLWFjY2VzcyI7aToxODA7czoxMjoicHVyY2hhc2UtYWRkIjtpOjE4MTtzOjIwOiJwdXJjaGFzZS1idWxrLWRlbGV0ZSI7aToxODI7czoxNToicHVyY2hhc2UtZGVsZXRlIjtpOjE4MztzOjEzOiJwdXJjaGFzZS1lZGl0IjtpOjE4NDtzOjIwOiJwdXJjaGFzZS1wYXltZW50LWFkZCI7aToxODU7czoyMzoicHVyY2hhc2UtcGF5bWVudC1kZWxldGUiO2k6MTg2O3M6MjE6InB1cmNoYXNlLXBheW1lbnQtZWRpdCI7aToxODc7czoyMToicHVyY2hhc2UtcGF5bWVudC12aWV3IjtpOjE4ODtzOjE1OiJwdXJjaGFzZS1yZXBvcnQiO2k6MTg5O3M6MTM6InB1cmNoYXNlLXZpZXciO2k6MTkwO3M6MTE6InJvbGUtYWNjZXNzIjtpOjE5MTtzOjg6InJvbGUtYWRkIjtpOjE5MjtzOjE2OiJyb2xlLWJ1bGstZGVsZXRlIjtpOjE5MztzOjExOiJyb2xlLWRlbGV0ZSI7aToxOTQ7czo5OiJyb2xlLWVkaXQiO2k6MTk1O3M6MTE6InJvbGUtcmVwb3J0IjtpOjE5NjtzOjk6InJvbGUtdmlldyI7aToxOTc7czoxMjoicm91dGUtYWNjZXNzIjtpOjE5ODtzOjk6InJvdXRlLWFkZCI7aToxOTk7czoxNzoicm91dGUtYnVsay1kZWxldGUiO2k6MjAwO3M6MTI6InJvdXRlLWRlbGV0ZSI7aToyMDE7czoxMDoicm91dGUtZWRpdCI7aToyMDI7czoxMjoicm91dGUtcmVwb3J0IjtpOjIwMztzOjExOiJzYWxlLWFjY2VzcyI7aToyMDQ7czo4OiJzYWxlLWFkZCI7aToyMDU7czoxNjoic2FsZS1idWxrLWRlbGV0ZSI7aToyMDY7czoxMToic2FsZS1kZWxldGUiO2k6MjA3O3M6OToic2FsZS1lZGl0IjtpOjIwODtzOjExOiJzYWxlLXJlcG9ydCI7aToyMDk7czo5OiJzYWxlLXZpZXciO2k6MjEwO3M6Mjc6InNhbGVzLXJlcHJlc2VudGF0aXZlLWFjY2VzcyI7aToyMTE7czoyNDoic2FsZXMtcmVwcmVzZW50YXRpdmUtYWRkIjtpOjIxMjtzOjMyOiJzYWxlcy1yZXByZXNlbnRhdGl2ZS1idWxrLWRlbGV0ZSI7aToyMTM7czoyNzoic2FsZXMtcmVwcmVzZW50YXRpdmUtZGVsZXRlIjtpOjIxNDtzOjI1OiJzYWxlcy1yZXByZXNlbnRhdGl2ZS1lZGl0IjtpOjIxNTtzOjI3OiJzYWxlcy1yZXByZXNlbnRhdGl2ZS1yZXBvcnQiO2k6MjE2O3M6MjU6InNhbGVzLXJlcHJlc2VudGF0aXZlLXZpZXciO2k6MjE3O3M6MzM6InNhbGVzbWVuLXdpc2Utc2FsZXMtcmVwb3J0LWFjY2VzcyI7aToyMTg7czoxNDoic2V0dGluZy1hY2Nlc3MiO2k6MjE5O3M6Mjc6InNoaXBwaW5nLWNvc3QtcmVwb3J0LWFjY2VzcyI7aToyMjA7czoxMToic2l6ZS1hY2Nlc3MiO2k6MjIxO3M6ODoic2l6ZS1hZGQiO2k6MjIyO3M6MTY6InNpemUtYnVsay1kZWxldGUiO2k6MjIzO3M6MTE6InNpemUtZGVsZXRlIjtpOjIyNDtzOjk6InNpemUtZWRpdCI7aToyMjU7czoxMToic2l6ZS1yZXBvcnQiO2k6MjI2O3M6MTU6InN1cHBsaWVyLWFjY2VzcyI7aToyMjc7czoxMjoic3VwcGxpZXItYWRkIjtpOjIyODtzOjIzOiJzdXBwbGllci1hZHZhbmNlLWFjY2VzcyI7aToyMjk7czoyMDoic3VwcGxpZXItYWR2YW5jZS1hZGQiO2k6MjMwO3M6Mjg6InN1cHBsaWVyLWFkdmFuY2UtYnVsay1kZWxldGUiO2k6MjMxO3M6MjM6InN1cHBsaWVyLWFkdmFuY2UtZGVsZXRlIjtpOjIzMjtzOjIxOiJzdXBwbGllci1hZHZhbmNlLWVkaXQiO2k6MjMzO3M6MjM6InN1cHBsaWVyLWFkdmFuY2UtcmVwb3J0IjtpOjIzNDtzOjIxOiJzdXBwbGllci1hZHZhbmNlLXZpZXciO2k6MjM1O3M6MjA6InN1cHBsaWVyLWJ1bGstZGVsZXRlIjtpOjIzNjtzOjE1OiJzdXBwbGllci1kZWxldGUiO2k6MjM3O3M6MTM6InN1cHBsaWVyLWVkaXQiO2k6MjM4O3M6MjI6InN1cHBsaWVyLWxlZGdlci1hY2Nlc3MiO2k6MjM5O3M6MjM6InN1cHBsaWVyLXBheW1lbnQtYWNjZXNzIjtpOjI0MDtzOjE1OiJzdXBwbGllci1yZXBvcnQiO2k6MjQxO3M6MTM6InN1cHBsaWVyLXZpZXciO2k6MjQyO3M6MTA6InRheC1hY2Nlc3MiO2k6MjQzO3M6NzoidGF4LWFkZCI7aToyNDQ7czoxNToidGF4LWJ1bGstZGVsZXRlIjtpOjI0NTtzOjEwOiJ0YXgtZGVsZXRlIjtpOjI0NjtzOjg6InRheC1lZGl0IjtpOjI0NztzOjEwOiJ0YXgtcmVwb3J0IjtpOjI0ODtzOjMwOiJ0b2RheXMtY3VzdG9tZXItcmVjZWlwdC1hY2Nlc3MiO2k6MjQ5O3M6MjY6InRvZGF5cy1zYWxlcy1yZXBvcnQtYWNjZXNzIjtpOjI1MDtzOjE1OiJ0cmFuc2Zlci1hY2Nlc3MiO2k6MjUxO3M6MTI6InRyYW5zZmVyLWFkZCI7aToyNTI7czoyMDoidHJhbnNmZXItYnVsay1kZWxldGUiO2k6MjUzO3M6MTU6InRyYW5zZmVyLWRlbGV0ZSI7aToyNTQ7czoxMzoidHJhbnNmZXItZWRpdCI7aToyNTU7czoxNToidHJhbnNmZXItcmVwb3J0IjtpOjI1NjtzOjEzOiJ0cmFuc2Zlci12aWV3IjtpOjI1NztzOjIwOiJ0cmlhbC1iYWxhbmNlLWFjY2VzcyI7aToyNTg7czoxMToidW5pdC1hY2Nlc3MiO2k6MjU5O3M6ODoidW5pdC1hZGQiO2k6MjYwO3M6MTY6InVuaXQtYnVsay1kZWxldGUiO2k6MjYxO3M6MTE6InVuaXQtZGVsZXRlIjtpOjI2MjtzOjk6InVuaXQtZWRpdCI7aToyNjM7czoxMToidW5pdC1yZXBvcnQiO2k6MjY0O3M6MTQ6InVwYXppbGEtYWNjZXNzIjtpOjI2NTtzOjExOiJ1cGF6aWxhLWFkZCI7aToyNjY7czoxOToidXBhemlsYS1idWxrLWRlbGV0ZSI7aToyNjc7czoxNDoidXBhemlsYS1kZWxldGUiO2k6MjY4O3M6MTI6InVwYXppbGEtZWRpdCI7aToyNjk7czoxNDoidXBhemlsYS1yZXBvcnQiO2k6MjcwO3M6MTE6InVzZXItYWNjZXNzIjtpOjI3MTtzOjg6InVzZXItYWRkIjtpOjI3MjtzOjE2OiJ1c2VyLWJ1bGstZGVsZXRlIjtpOjI3MztzOjExOiJ1c2VyLWRlbGV0ZSI7aToyNzQ7czo5OiJ1c2VyLWVkaXQiO2k6Mjc1O3M6MTE6InVzZXItcmVwb3J0IjtpOjI3NjtzOjk6InVzZXItdmlldyI7aToyNzc7czoyMzoidm91Y2hlci1hcHByb3ZhbC1hY2Nlc3MiO2k6Mjc4O3M6MjM6InZvdWNoZXItYXBwcm92YWwtcmVwb3J0IjtpOjI3OTtzOjE2OiJ3YXJlaG91c2UtYWNjZXNzIjtpOjI4MDtzOjEzOiJ3YXJlaG91c2UtYWRkIjtpOjI4MTtzOjIxOiJ3YXJlaG91c2UtYnVsay1kZWxldGUiO2k6MjgyO3M6MzA6IndhcmVob3VzZS1jb3Vwb24tcmVwb3J0LWFjY2VzcyI7aToyODM7czoxNjoid2FyZWhvdXNlLWRlbGV0ZSI7aToyODQ7czoxNDoid2FyZWhvdXNlLWVkaXQiO2k6Mjg1O3M6MTY6IndhcmVob3VzZS1yZXBvcnQiO2k6Mjg2O3M6MjM6IndhcmVob3VzZS1yZXBvcnQtYWNjZXNzIjtpOjI4NztzOjE0OiJ3YXJlaG91c2UtdmlldyI7fX0=', 1622624849);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('nPxzJjdErpCBCKt3l8tExMGz4mcorwNVGhu3tDW3', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidmoyYmtEU3VIam9Qc0R1eTJtRXNhUGdVZ2Z0OFRHNWRmR0t4c3NZUiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL2VycC50ZXN0L3B1cmNoYXNlL2VkaXQvMiI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vZXJwLnRlc3QvcHVyY2hhc2UvZWRpdC8yIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1622607793),
('t2PPyDgOpaYcuTiEqi975vhbCKR791TQk6kNeytv', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaHNONUNSaTdCQkZ0S2NLdjRPNTRXRjJwZEQycjRtQllYb2p6blc4cyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNDoiaHR0cDovL2VycC50ZXN0L3NhbGUvYWRkIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly9lcnAudGVzdC9zYWxlL2FkZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1622618368);

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
(2, 'email', 'kohinoor@gmail.com', NULL, NULL),
(3, 'contact_no', '01521225987', NULL, NULL),
(4, 'address', 'Lorem ipsum dollar', NULL, NULL),
(5, 'logo', 'Apk-LogoLow-Res-284262.png', NULL, NULL),
(6, 'favicon', 'Apk-LogoLow-Res-890333.png', NULL, NULL),
(7, 'currency_code', 'BDT', NULL, NULL),
(8, 'currency_symbol', 'Tk', NULL, NULL),
(9, 'currency_position', '2', NULL, NULL),
(10, 'invoice_prefix', 'INV-', NULL, NULL),
(11, 'invoice_number', '1001', NULL, NULL),
(12, 'timezone', 'Asia/Dhaka', NULL, NULL),
(13, 'date_format', 'd-M-Y', NULL, NULL),
(14, 'mail_mailer', 'smtp', NULL, NULL),
(15, 'mail_host', 'smtp.mailtrap.io', NULL, NULL),
(16, 'mail_port', '465', NULL, NULL),
(17, 'mail_username', 'armanarman456789@gmail.com', NULL, NULL),
(18, 'mail_password', '123', NULL, NULL),
(19, 'mail_encryption', 'tls', NULL, NULL),
(20, 'mail_from_name', 'Mohammad Arman', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sizes`
--

CREATE TABLE `sizes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active, 2=Inactive',
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sizes`
--

INSERT INTO `sizes` (`id`, `size`, `unit_id`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, '12', 5, '1', 'Super Admin', NULL, '2021-01-19 22:48:05', '2021-01-19 22:48:05'),
(2, '20', 5, '1', 'Super Admin', NULL, '2021-01-19 22:48:28', '2021-01-19 22:48:28'),
(3, '25', 5, '1', 'Super Admin', NULL, '2021-01-19 22:48:33', '2021-01-19 22:48:33'),
(4, '30', 5, '1', 'Super Admin', NULL, '2021-01-19 22:48:39', '2021-01-19 22:48:39'),
(5, '50', 5, '1', 'Super Admin', NULL, '2021-01-19 22:48:45', '2021-01-19 22:48:45'),
(6, '100', 5, '1', 'Super Admin', NULL, '2021-01-19 22:48:50', '2021-01-19 22:48:50'),
(7, '150', 5, '1', 'Super Admin', NULL, '2021-01-19 22:49:02', '2021-01-19 22:49:02'),
(8, '200', 5, '1', 'Super Admin', NULL, '2021-01-19 22:49:08', '2021-01-19 22:49:08'),
(9, '250', 5, '1', 'Super Admin', NULL, '2021-01-19 22:49:14', '2021-01-19 22:49:14'),
(10, '300', 5, '1', 'Super Admin', NULL, '2021-01-19 22:49:23', '2021-01-19 22:49:23'),
(11, '350', 5, '1', 'Super Admin', NULL, '2021-01-19 22:49:30', '2021-01-19 22:49:30'),
(12, '400', 5, '1', 'Super Admin', NULL, '2021-01-19 22:49:38', '2021-01-19 22:49:38'),
(13, '450', 5, '1', 'Super Admin', NULL, '2021-01-19 22:49:45', '2021-01-19 22:49:45'),
(14, '500', 5, '1', 'Super Admin', NULL, '2021-01-19 22:49:51', '2021-01-19 22:49:51'),
(15, '900', 5, '1', 'Super Admin', NULL, '2021-01-19 22:49:58', '2021-01-19 22:49:58'),
(16, '1', 3, '1', 'Super Admin', NULL, '2021-01-19 22:50:06', '2021-01-19 22:50:06'),
(17, '1', 6, '1', 'Super Admin', NULL, '2021-01-19 22:50:14', '2021-01-19 22:50:14'),
(18, '10', 3, '1', 'Super Admin', 'Super Admin', '2021-01-19 22:50:35', '2021-01-19 22:51:29');

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
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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

INSERT INTO `suppliers` (`id`, `name`, `company_name`, `mobile`, `email`, `phone`, `city`, `state`, `zip`, `country`, `address`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Mr. AAA', 'AAA', '01521225987', '', '', '', '', '', '', '', '1', 'Super Admin', NULL, '2021-01-27 03:58:54', '2021-01-27 03:58:54'),
(2, 'Mr. BBB', 'BBB', '01521225988', '', '', '', '', '', '', '', '1', 'Super Admin', NULL, '2021-01-27 03:59:07', '2021-01-27 03:59:07'),
(3, 'Mr. CCC', 'CCC', '01521225986', '', '', '', '', '', '', '', '1', 'Super Admin', NULL, '2021-01-28 00:03:27', '2021-01-28 00:03:27');

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
(1, '5%', '5', '1', 'Super Admin', NULL, '2021-01-20 01:03:28', '2021-01-20 01:03:28'),
(2, '10%', '10', '1', 'Super Admin', NULL, '2021-01-20 01:03:41', '2021-01-20 01:03:41'),
(3, '15%', '15', '1', 'Super Admin', NULL, '2021-01-20 01:03:52', '2021-01-20 01:03:52');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
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
(4, 15, 2, '1', 'INVOICE', '2021-06-02', 'Inventory Credit For Invoice No SINV-20210602052130332', 0, 500, '2', '1', '1', 'Super Admin', NULL, '2021-06-01 23:22:16', NULL),
(5, 35, 2, '1', 'INVOICE', '2021-06-02', 'Customer debit For Invoice No -  SINV-20210602052130332 Customer Mr. Arman', 700, 0, '2', '1', '1', 'Super Admin', NULL, '2021-06-01 23:22:16', NULL),
(6, 8, 2, '1', 'INVOICE', '2021-06-02', 'Sale Income For Invoice NO - SINV-20210602052130332 Customer Mr. Arman', 0, 200, '2', '1', '1', 'Super Admin', NULL, '2021-06-01 23:22:16', NULL),
(7, 35, 2, '1', 'INVOICE', '2021-06-02', 'Customer credit for Paid Amount For Customer Invoice NO- SINV-20210602052130332 Customer- Mr. Arman', 0, 700, '2', '1', '1', 'Super Admin', NULL, '2021-06-01 23:22:16', NULL),
(8, 20, 2, '1', 'INVOICE', '2021-06-02', 'Cash in Hand in Sale for Invoice No - SINV-20210602052130332 customer- Mr. Arman', 700, 0, '2', '1', '1', 'Super Admin', NULL, '2021-06-01 23:22:16', NULL),
(9, 31, 1, '8', 'Purchase', '2021-06-02', 'Supplier Mr. AAA', 0, 10500, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 00:19:22', NULL),
(10, 15, 1, '8', 'Purchase', '2021-06-02', 'Inventory Debit For Supplier Mr. AAA', 10500, 0, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 00:19:22', NULL),
(11, 11, 1, '8', 'Purchase', '2021-06-02', 'Company Credit For Supplier Mr. AAA', 10500, 0, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 00:19:22', NULL),
(12, 31, 1, '9', 'Purchase', '2021-06-02', 'Supplier Mr. AAA', 0, 2000, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 00:22:57', NULL),
(13, 15, 1, '9', 'Purchase', '2021-06-02', 'Inventory Debit For Supplier Mr. AAA', 2000, 0, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 00:22:57', NULL),
(14, 11, 1, '9', 'Purchase', '2021-06-02', 'Company Credit For Supplier Mr. AAA', 2000, 0, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 00:22:57', NULL),
(15, 31, 1, '9', 'Purchase', '2021-06-02', 'Supplier .Mr. AAA', 2000, 0, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 00:22:57', '2021-06-02 00:22:57'),
(16, 20, 1, '9', 'Purchase', '2021-06-02', 'Cash in Hand For Supplier Mr. AAA', 0, 2000, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 00:22:57', '2021-06-02 00:22:57'),
(17, 15, 2, '2', 'INVOICE', '2021-06-02', 'Inventory Credit For Invoice No SINV-2021060207145249', 0, 600, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 01:20:07', NULL),
(18, 35, 2, '2', 'INVOICE', '2021-06-02', 'Customer debit For Invoice No -  SINV-2021060207145249 Customer Mr. Arman', 840, 0, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 01:20:07', NULL),
(19, 8, 2, '2', 'INVOICE', '2021-06-02', 'Sale Income For Invoice NO - SINV-2021060207145249 Customer Mr. Arman', 0, 240, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 01:20:07', NULL),
(20, 35, 2, '2', 'INVOICE', '2021-06-02', 'Customer credit for Paid Amount For Customer Invoice NO- SINV-2021060207145249 Customer- Mr. Arman', 0, 840, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 01:20:07', NULL),
(21, 20, 2, '2', 'INVOICE', '2021-06-02', 'Cash in Hand in Sale for Invoice No - SINV-2021060207145249 customer- Mr. Arman', 840, 0, '2', '1', '1', 'Super Admin', NULL, '2021-06-02 01:20:07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `chalan_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `to_warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `item` double(8,2) NOT NULL,
  `total_qty` double(8,2) NOT NULL,
  `total_tax` double(8,2) NOT NULL,
  `total_cost` double NOT NULL,
  `total_labor_cost` double NOT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `transfer_date` date NOT NULL,
  `transfer_status` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1=Completed,2=Pending,3=Sent',
  `carried_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `received_by` bigint(20) UNSIGNED NOT NULL,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transfers`
--

INSERT INTO `transfers` (`id`, `chalan_no`, `from_warehouse_id`, `to_warehouse_id`, `item`, `total_qty`, `total_tax`, `total_cost`, `total_labor_cost`, `shipping_cost`, `grand_total`, `document`, `note`, `transfer_date`, `transfer_status`, `carried_by`, `received_by`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(3, 'TINV-1001', 1, 2, 3.00, 13.00, 33.09, 695, 50, 50, 795, NULL, '', '2021-02-13', '1', 'Arman', 1, 'Super Admin', NULL, '2021-02-13 23:39:27', '2021-02-14 01:28:17'),
(4, 'TINV-1002', 1, 2, 1.00, 40.00, 0.00, 2000, 0, 0, 2000, NULL, '', '2021-06-02', '1', 'Rahman', 1, 'Super Admin', NULL, '2021-06-01 22:53:19', '2021-06-01 22:53:19'),
(5, 'TINV-1003', 1, 2, 1.00, 10.00, 14.29, 300, 0, 0, 300, NULL, '', '2021-06-02', '1', 'Abdul', 1, 'Super Admin', NULL, '2021-06-02 02:14:08', '2021-06-02 02:14:08');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unit_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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

INSERT INTO `units` (`id`, `unit_code`, `unit_name`, `base_unit`, `operator`, `operation_value`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'MBAG', 'Master Bag', 5, '*', '6000', '1', 'Super Admin', 'Super Admin', '2021-01-19 05:12:06', '2021-01-25 03:40:24'),
(2, 'Ctn', 'Carton', NULL, '*', '1', '1', 'Super Admin', 'Super Admin', '2021-01-19 05:33:00', '2021-01-19 05:40:56'),
(3, 'Kg', 'Kilogram', 5, '*', '1000', '1', 'Super Admin', 'Super Admin', '2021-01-19 05:33:49', '2021-01-19 06:04:04'),
(4, 'Dm', 'Drum', 6, '*', '284', '1', 'Super Admin', 'Super Admin', '2021-01-19 05:41:56', '2021-01-19 06:04:56'),
(5, 'Gm', 'Gram', NULL, '*', '1', '1', 'Super Admin', NULL, '2021-01-19 06:03:43', '2021-01-19 06:03:43'),
(6, 'L', 'Liter', NULL, '*', '1', '1', 'Super Admin', NULL, '2021-01-19 06:04:40', '2021-01-19 06:04:40'),
(7, 'Rl', 'Roll', NULL, '*', '1', '1', 'Super Admin', NULL, '2021-01-19 21:41:01', '2021-01-19 21:41:01'),
(8, 'Pc', 'Piece', NULL, '*', '1', '1', 'Super Admin', NULL, '2021-01-19 21:41:14', '2021-01-19 21:41:14'),
(9, '12Pc Ctn', '12Pc Carton', 8, '*', '12', '1', 'Super Admin', NULL, '2021-06-02 01:14:34', '2021-06-02 01:14:34');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('Male','Female') COLLATE utf8mb4_unicode_ci NOT NULL,
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

INSERT INTO `users` (`id`, `role_id`, `name`, `username`, `phone`, `email`, `avatar`, `gender`, `password`, `status`, `deletable`, `created_by`, `modified_by`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 1, 'Super Admin', 'SuperAdmin', '01521225987', 'superadmin@mail.com', NULL, 'Male', '$2y$10$KHyykk.usy/btCkJkII/X.98NZPPCydnfracSLNSfvsv2/xh4UV46', '1', '1', NULL, NULL, NULL, '2021-01-19 03:57:43', '2021-01-19 03:57:43'),
(2, 2, 'Admin', 'Admin', '0123456789', 'admin@mail.com', NULL, 'Male', '$2y$10$huqGq2sBcHRfHKgIABN.oOiXPJvOZNI9rnpZiPzOOwivJ0eyttiCK', '1', '1', NULL, NULL, NULL, '2021-01-19 03:57:44', '2021-01-19 03:57:44');

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

INSERT INTO `warehouses` (`id`, `name`, `phone`, `email`, `address`, `status`, `deletable`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Main Warehouse', '', '', '', '1', '1', 'Super Admin', NULL, '2021-01-20 01:04:24', '2021-01-20 01:04:24'),
(2, 'Feni Warehouse', '', '', '', '1', '2', 'Super Admin', NULL, '2021-01-20 01:04:41', '2021-01-20 01:04:41'),
(3, 'Dhaka Warehouse', '', '', '', '1', '2', 'Super Admin', NULL, '2021-01-20 01:04:57', '2021-01-20 01:04:57');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_finish_goods`
--

CREATE TABLE `warehouse_finish_goods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `finish_goods_id` bigint(20) UNSIGNED NOT NULL,
  `qty` double(8,2) NOT NULL DEFAULT '0.00',
  `rack_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouse_finish_goods`
--

INSERT INTO `warehouse_finish_goods` (`id`, `warehouse_id`, `product_id`, `finish_goods_id`, `qty`, `rack_no`, `created_at`, `updated_at`) VALUES
(17, 1, 2, 12, 427.00, NULL, '2021-01-23 01:17:15', '2021-06-02 02:14:08'),
(18, 1, 2, 13, 315.00, NULL, '2021-01-23 01:17:15', '2021-06-02 00:49:52'),
(19, 1, 2, 14, 400.00, NULL, '2021-01-23 01:17:15', '2021-06-02 00:51:12'),
(20, 1, 2, 15, 95.00, NULL, '2021-01-23 01:17:15', '2021-02-14 01:28:17'),
(21, 1, 2, 16, 100.00, NULL, '2021-01-23 01:17:15', '2021-02-14 02:28:41'),
(22, 1, 2, 17, 100.00, NULL, '2021-01-23 01:17:15', '2021-02-14 02:28:41'),
(23, 2, 2, 12, 123.00, NULL, '2021-02-06 04:42:48', '2021-06-02 02:14:08'),
(24, 2, 2, 13, 21.00, NULL, '2021-02-06 04:42:48', '2021-05-31 05:40:13'),
(25, 2, 2, 14, 4.00, NULL, '2021-02-06 04:44:05', '2021-05-31 05:40:13'),
(26, 2, 2, 15, 0.00, NULL, '2021-02-13 23:39:27', '2021-05-31 05:35:12'),
(29, 2, 2, 16, 0.00, NULL, '2021-02-14 01:32:23', '2021-02-14 02:28:41'),
(30, 2, 2, 17, 0.00, NULL, '2021-02-14 01:32:23', '2021-02-14 02:28:41'),
(31, 1, 7, 18, 100.00, NULL, '2021-03-01 21:33:26', '2021-03-01 21:33:26'),
(32, 1, 7, 19, 100.00, NULL, '2021-03-01 21:33:26', '2021-03-01 21:33:26'),
(33, 1, 7, 20, 100.00, NULL, '2021-03-01 21:33:26', '2021-03-01 21:33:26'),
(37, 1, 7, 24, 100.00, NULL, '2021-03-01 21:42:12', '2021-03-01 21:42:12'),
(38, 1, 8, 25, 10.00, NULL, '2021-03-01 21:44:05', '2021-06-01 22:53:19'),
(39, 2, 8, 25, 18.00, NULL, '2021-06-01 22:53:19', '2021-06-02 01:20:07');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_materials`
--

CREATE TABLE `warehouse_materials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `material_id` bigint(20) UNSIGNED NOT NULL,
  `qty` double(8,2) NOT NULL DEFAULT '0.00',
  `rack_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouse_materials`
--

INSERT INTO `warehouse_materials` (`id`, `warehouse_id`, `material_id`, `qty`, `rack_no`, `created_at`, `updated_at`) VALUES
(5, 1, 1, 52000.00, NULL, '2021-01-25 05:20:12', '2021-06-02 01:06:08'),
(6, 1, 2, 0.00, NULL, '2021-01-25 05:20:12', '2021-02-27 21:39:55'),
(7, 1, 10, 0.00, NULL, '2021-01-26 02:41:55', '2021-02-06 03:05:08'),
(8, 1, 7, 0.00, NULL, '2021-01-26 02:41:55', '2021-02-27 21:39:55'),
(9, 1, 12, 60.00, NULL, '2021-01-26 02:41:55', '2021-06-02 01:06:08'),
(10, 1, 11, 0.00, NULL, '2021-01-26 02:41:55', '2021-01-26 02:42:37'),
(11, 1, 15, 100.00, NULL, '2021-01-27 04:03:56', '2021-06-01 22:43:09'),
(12, 1, 13, 60.00, NULL, '2021-06-02 00:22:57', '2021-06-02 01:06:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asms`
--
ALTER TABLE `asms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `asms_username_unique` (`username`),
  ADD UNIQUE KEY `asms_phone_unique` (`phone`),
  ADD KEY `asms_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `asms_district_id_foreign` (`district_id`);

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `banks_account_number_unique` (`account_number`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `branches_name_unique` (`name`);

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
  ADD UNIQUE KEY `chart_of_accounts_name_unique` (`name`),
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
  ADD KEY `customers_route_id_foreign` (`route_id`);

--
-- Indexes for table `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customer_groups_group_name_unique` (`group_name`);

--
-- Indexes for table `daily_bankings`
--
ALTER TABLE `daily_bankings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `daily_bankings_bank_id_foreign` (`bank_id`);

--
-- Indexes for table `daily_closings`
--
ALTER TABLE `daily_closings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `daily_closings_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `departments_name_unique` (`name`);

--
-- Indexes for table `designations`
--
ALTER TABLE `designations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `designations_name_unique` (`name`);

--
-- Indexes for table `divisions`
--
ALTER TABLE `divisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `divisions_name_unique` (`name`),
  ADD KEY `divisions_department_id_foreign` (`department_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employees_phone_unique` (`phone`),
  ADD UNIQUE KEY `employees_employee_id_unique` (`employee_id`),
  ADD KEY `employees_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `employees_district_id_foreign` (`district_id`),
  ADD KEY `employees_upazila_id_foreign` (`upazila_id`),
  ADD KEY `employees_department_id_foreign` (`department_id`),
  ADD KEY `employees_division_id_foreign` (`division_id`),
  ADD KEY `employees_joining_designation_id_foreign` (`joining_designation_id`),
  ADD KEY `employees_current_designation_id_foreign` (`current_designation_id`);

--
-- Indexes for table `employee_education`
--
ALTER TABLE `employee_education`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_education_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `employee_professional_information`
--
ALTER TABLE `employee_professional_information`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_professional_information_employee_id_foreign` (`employee_id`);

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
-- Indexes for table `finished_goods_materials`
--
ALTER TABLE `finished_goods_materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `finished_goods_materials_production_id_foreign` (`production_id`),
  ADD KEY `finished_goods_materials_production_finished_good_id_foreign` (`production_finished_good_id`),
  ADD KEY `finished_goods_materials_material_id_foreign` (`material_id`);

--
-- Indexes for table `finish_goods`
--
ALTER TABLE `finish_goods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `finish_goods_code_unique` (`code`),
  ADD KEY `finish_goods_product_id_foreign` (`product_id`),
  ADD KEY `finish_goods_size_id_foreign` (`size_id`),
  ADD KEY `finish_goods_unit_id_foreign` (`unit_id`),
  ADD KEY `finish_goods_sale_unit_id_foreign` (`sale_unit_id`);

--
-- Indexes for table `finish_goods_sales`
--
ALTER TABLE `finish_goods_sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `finish_goods_sales_sale_id_foreign` (`sale_id`),
  ADD KEY `finish_goods_sales_finish_goods_id_foreign` (`finish_goods_id`),
  ADD KEY `finish_goods_sales_sale_unit_id_foreign` (`sale_unit_id`);

--
-- Indexes for table `finish_goods_transfers`
--
ALTER TABLE `finish_goods_transfers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `finish_goods_transfers_transfer_id_foreign` (`transfer_id`),
  ADD KEY `finish_goods_transfers_finish_goods_id_foreign` (`finish_goods_id`),
  ADD KEY `finish_goods_transfers_unit_id_foreign` (`unit_id`);

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
  ADD KEY `materials_tax_id_foreign` (`tax_id`);

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
  ADD PRIMARY KEY (`id`);

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
  ADD UNIQUE KEY `permissions_slug_unique` (`slug`),
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
  ADD KEY `productions_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `productions_product_id_foreign` (`product_id`);

--
-- Indexes for table `production_coupons`
--
ALTER TABLE `production_coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `production_coupons_coupon_code_unique` (`coupon_code`),
  ADD KEY `production_coupons_production_id_foreign` (`production_id`),
  ADD KEY `production_coupons_production_finished_good_id_foreign` (`production_finished_good_id`);

--
-- Indexes for table `production_finished_goods`
--
ALTER TABLE `production_finished_goods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `production_finished_goods_production_id_foreign` (`production_id`),
  ADD KEY `production_finished_goods_finish_goods_id_foreign` (`finish_goods_id`),
  ADD KEY `production_finished_goods_unit_id_foreign` (`unit_id`);

--
-- Indexes for table `production_materials`
--
ALTER TABLE `production_materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `production_materials_production_id_foreign` (`production_id`),
  ADD KEY `production_materials_material_id_foreign` (`material_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_tax_id_foreign` (`tax_id`);

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
-- Indexes for table `received_coupons`
--
ALTER TABLE `received_coupons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `received_coupons_asm_id_foreign` (`asm_id`),
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
  ADD KEY `sales_asm_id_foreign` (`asm_id`),
  ADD KEY `sales_salesmen_id_foreign` (`salesmen_id`),
  ADD KEY `sales_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `salesmen`
--
ALTER TABLE `salesmen`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `salesmen_username_unique` (`username`),
  ADD UNIQUE KEY `salesmen_phone_unique` (`phone`),
  ADD KEY `salesmen_asm_id_foreign` (`asm_id`),
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
-- Indexes for table `sizes`
--
ALTER TABLE `sizes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sizes_unit_id_foreign` (`unit_id`);

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
  ADD KEY `transactions_chart_of_account_id_foreign` (`chart_of_account_id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transfers_chalan_no_unique` (`chalan_no`) USING BTREE,
  ADD KEY `transfers_from_warehouse_id_foreign` (`from_warehouse_id`),
  ADD KEY `transfers_to_warehouse_id_foreign` (`to_warehouse_id`),
  ADD KEY `transfers_received_by_foreign` (`received_by`);

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
  ADD UNIQUE KEY `warehouses_name_unique` (`name`);

--
-- Indexes for table `warehouse_finish_goods`
--
ALTER TABLE `warehouse_finish_goods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warehouse_finish_goods_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `warehouse_finish_goods_product_id_foreign` (`product_id`),
  ADD KEY `warehouse_finish_goods_finish_goods_id_foreign` (`finish_goods_id`);

--
-- Indexes for table `warehouse_materials`
--
ALTER TABLE `warehouse_materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warehouse_materials_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `warehouse_materials_material_id_foreign` (`material_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `asms`
--
ALTER TABLE `asms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `chart_of_accounts`
--
ALTER TABLE `chart_of_accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `customer_groups`
--
ALTER TABLE `customer_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `daily_bankings`
--
ALTER TABLE `daily_bankings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `daily_closings`
--
ALTER TABLE `daily_closings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `designations`
--
ALTER TABLE `designations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `divisions`
--
ALTER TABLE `divisions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `employee_education`
--
ALTER TABLE `employee_education`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `employee_professional_information`
--
ALTER TABLE `employee_professional_information`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `expense_items`
--
ALTER TABLE `expense_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `finished_goods_materials`
--
ALTER TABLE `finished_goods_materials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `finish_goods`
--
ALTER TABLE `finish_goods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `finish_goods_sales`
--
ALTER TABLE `finish_goods_sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `finish_goods_transfers`
--
ALTER TABLE `finish_goods_transfers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=579;

--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `material_purchase`
--
ALTER TABLE `material_purchase`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `mobile_banks`
--
ALTER TABLE `mobile_banks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT for table `module_role`
--
ALTER TABLE `module_role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=303;

--
-- AUTO_INCREMENT for table `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=245;

--
-- AUTO_INCREMENT for table `productions`
--
ALTER TABLE `productions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `production_coupons`
--
ALTER TABLE `production_coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `production_finished_goods`
--
ALTER TABLE `production_finished_goods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `production_materials`
--
ALTER TABLE `production_materials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product_material`
--
ALTER TABLE `product_material`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `purchase_payments`
--
ALTER TABLE `purchase_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `received_coupons`
--
ALTER TABLE `received_coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `salesmen`
--
ALTER TABLE `salesmen`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sales_men_daily_routes`
--
ALTER TABLE `sales_men_daily_routes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `sizes`
--
ALTER TABLE `sizes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `warehouse_finish_goods`
--
ALTER TABLE `warehouse_finish_goods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `warehouse_materials`
--
ALTER TABLE `warehouse_materials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `asms`
--
ALTER TABLE `asms`
  ADD CONSTRAINT `asms_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `asms_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

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
  ADD CONSTRAINT `customers_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`),
  ADD CONSTRAINT `customers_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `customers_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `customers_upazila_id_foreign` FOREIGN KEY (`upazila_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `daily_bankings`
--
ALTER TABLE `daily_bankings`
  ADD CONSTRAINT `daily_bankings_bank_id_foreign` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`);

--
-- Constraints for table `daily_closings`
--
ALTER TABLE `daily_closings`
  ADD CONSTRAINT `daily_closings_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `divisions`
--
ALTER TABLE `divisions`
  ADD CONSTRAINT `divisions_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_current_designation_id_foreign` FOREIGN KEY (`current_designation_id`) REFERENCES `designations` (`id`),
  ADD CONSTRAINT `employees_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `employees_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `employees_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `divisions` (`id`),
  ADD CONSTRAINT `employees_joining_designation_id_foreign` FOREIGN KEY (`joining_designation_id`) REFERENCES `designations` (`id`),
  ADD CONSTRAINT `employees_upazila_id_foreign` FOREIGN KEY (`upazila_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `employees_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `employee_education`
--
ALTER TABLE `employee_education`
  ADD CONSTRAINT `employee_education_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Constraints for table `employee_professional_information`
--
ALTER TABLE `employee_professional_information`
  ADD CONSTRAINT `employee_professional_information_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `chart_of_accounts` (`id`),
  ADD CONSTRAINT `expenses_expense_item_id_foreign` FOREIGN KEY (`expense_item_id`) REFERENCES `expense_items` (`id`),
  ADD CONSTRAINT `expenses_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `finished_goods_materials`
--
ALTER TABLE `finished_goods_materials`
  ADD CONSTRAINT `finished_goods_materials_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`),
  ADD CONSTRAINT `finished_goods_materials_production_finished_good_id_foreign` FOREIGN KEY (`production_finished_good_id`) REFERENCES `production_finished_goods` (`id`),
  ADD CONSTRAINT `finished_goods_materials_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`);

--
-- Constraints for table `finish_goods`
--
ALTER TABLE `finish_goods`
  ADD CONSTRAINT `finish_goods_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `finish_goods_sale_unit_id_foreign` FOREIGN KEY (`sale_unit_id`) REFERENCES `units` (`id`),
  ADD CONSTRAINT `finish_goods_size_id_foreign` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`),
  ADD CONSTRAINT `finish_goods_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `finish_goods_sales`
--
ALTER TABLE `finish_goods_sales`
  ADD CONSTRAINT `finish_goods_sales_finish_goods_id_foreign` FOREIGN KEY (`finish_goods_id`) REFERENCES `finish_goods` (`id`),
  ADD CONSTRAINT `finish_goods_sales_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`),
  ADD CONSTRAINT `finish_goods_sales_sale_unit_id_foreign` FOREIGN KEY (`sale_unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `finish_goods_transfers`
--
ALTER TABLE `finish_goods_transfers`
  ADD CONSTRAINT `finish_goods_transfers_finish_goods_id_foreign` FOREIGN KEY (`finish_goods_id`) REFERENCES `finish_goods` (`id`),
  ADD CONSTRAINT `finish_goods_transfers_transfer_id_foreign` FOREIGN KEY (`transfer_id`) REFERENCES `transfers` (`id`),
  ADD CONSTRAINT `finish_goods_transfers_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `materials`
--
ALTER TABLE `materials`
  ADD CONSTRAINT `materials_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
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
  ADD CONSTRAINT `productions_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `productions_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `production_coupons`
--
ALTER TABLE `production_coupons`
  ADD CONSTRAINT `production_coupons_production_finished_good_id_foreign` FOREIGN KEY (`production_finished_good_id`) REFERENCES `production_finished_goods` (`id`),
  ADD CONSTRAINT `production_coupons_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`);

--
-- Constraints for table `production_finished_goods`
--
ALTER TABLE `production_finished_goods`
  ADD CONSTRAINT `production_finished_goods_finish_goods_id_foreign` FOREIGN KEY (`finish_goods_id`) REFERENCES `finish_goods` (`id`),
  ADD CONSTRAINT `production_finished_goods_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`),
  ADD CONSTRAINT `production_finished_goods_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `production_materials`
--
ALTER TABLE `production_materials`
  ADD CONSTRAINT `production_materials_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`),
  ADD CONSTRAINT `production_materials_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `products_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`);

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
-- Constraints for table `received_coupons`
--
ALTER TABLE `received_coupons`
  ADD CONSTRAINT `received_coupons_asm_id_foreign` FOREIGN KEY (`asm_id`) REFERENCES `asms` (`id`),
  ADD CONSTRAINT `received_coupons_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `production_coupons` (`id`),
  ADD CONSTRAINT `received_coupons_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `received_coupons_salesmen_id_foreign` FOREIGN KEY (`salesmen_id`) REFERENCES `salesmen` (`id`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_asm_id_foreign` FOREIGN KEY (`asm_id`) REFERENCES `asms` (`id`),
  ADD CONSTRAINT `sales_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `sales_salesmen_id_foreign` FOREIGN KEY (`salesmen_id`) REFERENCES `salesmen` (`id`),
  ADD CONSTRAINT `sales_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `salesmen`
--
ALTER TABLE `salesmen`
  ADD CONSTRAINT `salesmen_asm_id_foreign` FOREIGN KEY (`asm_id`) REFERENCES `asms` (`id`),
  ADD CONSTRAINT `salesmen_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `salesmen_upazila_id_foreign` FOREIGN KEY (`upazila_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `sales_men_daily_routes`
--
ALTER TABLE `sales_men_daily_routes`
  ADD CONSTRAINT `sales_men_daily_routes_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `sales_men_daily_routes_salesmen_id_foreign` FOREIGN KEY (`salesmen_id`) REFERENCES `salesmen` (`id`);

--
-- Constraints for table `sizes`
--
ALTER TABLE `sizes`
  ADD CONSTRAINT `sizes_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_chart_of_account_id_foreign` FOREIGN KEY (`chart_of_account_id`) REFERENCES `chart_of_accounts` (`id`);

--
-- Constraints for table `transfers`
--
ALTER TABLE `transfers`
  ADD CONSTRAINT `transfers_from_warehouse_id_foreign` FOREIGN KEY (`from_warehouse_id`) REFERENCES `warehouses` (`id`),
  ADD CONSTRAINT `transfers_received_by_foreign` FOREIGN KEY (`received_by`) REFERENCES `asms` (`id`),
  ADD CONSTRAINT `transfers_to_warehouse_id_foreign` FOREIGN KEY (`to_warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `warehouse_finish_goods`
--
ALTER TABLE `warehouse_finish_goods`
  ADD CONSTRAINT `warehouse_finish_goods_finish_goods_id_foreign` FOREIGN KEY (`finish_goods_id`) REFERENCES `finish_goods` (`id`),
  ADD CONSTRAINT `warehouse_finish_goods_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `warehouse_finish_goods_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `warehouse_materials`
--
ALTER TABLE `warehouse_materials`
  ADD CONSTRAINT `warehouse_materials_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`),
  ADD CONSTRAINT `warehouse_materials_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
