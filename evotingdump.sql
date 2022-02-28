-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.33 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for voting
CREATE DATABASE IF NOT EXISTS `voting` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `voting`;

-- Dumping structure for table voting.admin
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_level` int(11) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`,`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.admin: 1 rows
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` (`id`, `user_level`, `username`, `password`) VALUES
	(1, 1, 'admin', '202cb962ac59075b964b07152d234b70');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;

-- Dumping structure for table voting.alreadyvote
CREATE TABLE IF NOT EXISTS `alreadyvote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_id` int(11) DEFAULT NULL,
  `voter_id` int(11) NOT NULL DEFAULT '0',
  `vote_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`voter_id`),
  KEY `FK_alreadyvote_voter` (`voter_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.alreadyvote: 4 rows
/*!40000 ALTER TABLE `alreadyvote` DISABLE KEYS */;
INSERT INTO `alreadyvote` (`id`, `election_id`, `voter_id`, `vote_time`, `created_at`, `updated_at`, `active`) VALUES
	(5, 13, 98, '2022-02-11 16:48:09', '2022-02-11 16:48:09', NULL, 1),
	(4, 2, 9, '2022-01-23 09:55:49', '2022-01-23 09:55:49', NULL, 1),
	(6, 13, 100, '2022-02-14 21:53:46', '2022-02-14 21:53:46', NULL, 1),
	(7, 30, 101, '2022-02-17 11:45:29', '2022-02-17 11:45:29', NULL, 1);
/*!40000 ALTER TABLE `alreadyvote` ENABLE KEYS */;

-- Dumping structure for table voting.candidate
CREATE TABLE IF NOT EXISTS `candidate` (
  `candidate_id` int(11) NOT NULL AUTO_INCREMENT,
  `voter_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL DEFAULT '0',
  `election_id` int(11) NOT NULL DEFAULT '0',
  `candidate_motto` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`voter_id`,`section_id`,`candidate_id`,`election_id`),
  KEY `FK_candidate_section` (`section_id`),
  KEY `candidate_id` (`candidate_id`),
  KEY `FK_candidate_election` (`election_id`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.candidate: 57 rows
/*!40000 ALTER TABLE `candidate` DISABLE KEYS */;
INSERT INTO `candidate` (`candidate_id`, `voter_id`, `section_id`, `election_id`, `candidate_motto`, `created_at`, `updated_at`, `active`) VALUES
	(1, 1, 0, 1, 'candidate mottoCc', '2021-12-18 08:19:40', NULL, 1),
	(2, 2, 3, 1, 'AsAS', '2021-12-18 08:20:06', NULL, 1),
	(3, 3, 1, 1, 'fstm', '2021-12-18 08:23:02', NULL, 1),
	(4, 4, 4, 1, 'fppi', '2021-12-18 08:23:10', NULL, 1),
	(5, 5, 2, 1, 'fsu', '2021-12-18 08:23:16', NULL, 1),
	(6, 6, 5, 1, 'fp', '2021-12-18 08:24:24', NULL, 1),
	(7, 1, 0, 2, 'candidate motto', '2021-12-18 08:49:46', NULL, 1),
	(8, 7, 0, 2, 'candidate motto', '2022-01-23 09:33:59', NULL, 1),
	(9, 9, 1, 2, 'fstm candidate g', '2022-01-23 09:34:31', NULL, 1),
	(10, 11, 1, 2, 'fppi', '2022-01-23 09:37:42', NULL, 1),
	(11, 12, 2, 2, 'fsu', '2022-01-23 09:38:01', NULL, 1),
	(12, 14, 5, 2, 'fp', '2022-01-23 09:38:09', NULL, 1),
	(13, 8, 3, 2, 'fpm', '2022-01-23 09:38:23', NULL, 1),
	(14, 13, 4, 2, '', '2022-01-23 09:38:32', NULL, 1),
	(15, 10, 0, 2, 'general candidate 2', '2022-01-23 09:39:02', NULL, 1),
	(16, 79, 0, 13, 'Poweryo', '2022-02-11 16:33:56', NULL, 1),
	(17, 84, 0, 13, 'WomenPower', '2022-02-11 16:34:19', NULL, 1),
	(18, 83, 1, 13, 'sdsdf', '2022-02-11 16:34:57', NULL, 1),
	(19, 80, 3, 13, 'ff', '2022-02-11 16:35:10', NULL, 1),
	(20, 85, 4, 13, 'hhh', '2022-02-11 16:35:21', NULL, 1),
	(21, 90, 2, 13, 'ff', '2022-02-11 16:35:33', NULL, 1),
	(22, 94, 5, 13, 'jkljkkl', '2022-02-11 16:35:44', NULL, 1),
	(23, 79, 0, 25, 'e', '2022-02-14 21:05:37', NULL, 1),
	(24, 82, 0, 27, 'a', '2022-02-14 21:34:00', NULL, 1),
	(25, 83, 1, 27, '', '2022-02-14 21:34:19', NULL, 1),
	(26, 81, 3, 27, '', '2022-02-14 21:34:23', NULL, 1),
	(27, 86, 4, 27, '', '2022-02-14 21:34:27', NULL, 1),
	(28, 88, 2, 27, '', '2022-02-14 21:34:34', NULL, 1),
	(29, 91, 5, 27, '', '2022-02-14 21:34:38', NULL, 1),
	(30, 79, 0, 28, 'zadsa', '2022-02-14 21:36:12', NULL, 1),
	(31, 81, 3, 28, 'asdas', '2022-02-14 21:36:21', NULL, 1),
	(32, 83, 1, 28, 'asdadsa', '2022-02-14 21:36:25', NULL, 1),
	(33, 88, 2, 28, 'asdads', '2022-02-14 21:36:29', NULL, 1),
	(34, 91, 5, 28, 'asdads', '2022-02-14 21:36:34', NULL, 1),
	(35, 85, 4, 28, 'adsas', '2022-02-14 21:36:45', NULL, 1),
	(36, 101, 0, 4, 'BTM POWER', '2022-02-14 22:17:25', NULL, 1),
	(37, 119, 0, 4, 'REFORMASI', '2022-02-14 22:17:44', NULL, 1),
	(38, 123, 0, 4, 'FOOD HUNTER', '2022-02-14 22:18:02', NULL, 1),
	(39, 105, 0, 4, 'NOTHING HAPPEN', '2022-02-14 22:18:47', NULL, 1),
	(40, 102, 1, 4, 'YO', '2022-02-14 22:19:03', NULL, 1),
	(41, 103, 1, 4, 'ERM', '2022-02-14 22:19:10', NULL, 1),
	(42, 104, 3, 4, 'POWER BOSKUR', '2022-02-14 22:19:25', NULL, 1),
	(43, 108, 4, 4, 'SUARA EMAS', '2022-02-14 22:19:55', NULL, 1),
	(44, 112, 2, 4, 'MEOW', '2022-02-14 22:20:14', NULL, 1),
	(45, 110, 2, 4, 'HAHAHAHA', '2022-02-14 22:20:32', NULL, 1),
	(46, 113, 5, 4, 'POWERPUF GIRL', '2022-02-14 22:20:50', NULL, 1),
	(47, 114, 5, 4, 'TURKEYEEE', '2022-02-14 22:21:07', NULL, 1),
	(48, 101, 0, 30, 'btm power', '2022-02-17 11:24:18', NULL, 1),
	(49, 104, 0, 30, 'test', '2022-02-17 11:24:42', NULL, 1),
	(50, 106, 0, 30, 'try', '2022-02-17 11:25:19', NULL, 1),
	(51, 102, 1, 30, '', '2022-02-17 11:28:26', NULL, 1),
	(52, 103, 1, 30, '', '2022-02-17 11:28:36', NULL, 1),
	(53, 105, 3, 30, '', '2022-02-17 11:28:46', NULL, 1),
	(54, 108, 4, 30, '', '2022-02-17 11:28:58', NULL, 1),
	(55, 110, 2, 30, '', '2022-02-17 11:29:06', NULL, 1),
	(56, 111, 2, 30, '', '2022-02-17 11:29:15', NULL, 1),
	(57, 113, 5, 30, '', '2022-02-17 11:29:26', NULL, 1);
/*!40000 ALTER TABLE `candidate` ENABLE KEYS */;

-- Dumping structure for table voting.candidate_filename
CREATE TABLE IF NOT EXISTS `candidate_filename` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.candidate_filename: ~1 rows (approximately)
/*!40000 ALTER TABLE `candidate_filename` DISABLE KEYS */;
INSERT INTO `candidate_filename` (`id`, `file_name`, `created_at`, `updated_at`) VALUES
	(1, 'asd', '2022-02-27 22:36:24', '2022-02-27 22:36:25');
/*!40000 ALTER TABLE `candidate_filename` ENABLE KEYS */;

-- Dumping structure for table voting.count
CREATE TABLE IF NOT EXISTS `count` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_id` int(11) DEFAULT '0',
  `section_id` int(11) DEFAULT NULL,
  `candidate_id` int(11) NOT NULL DEFAULT '0',
  `total_vote` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_count_candidate_2` (`section_id`),
  KEY `FK_count_candidate` (`candidate_id`),
  KEY `FK_count_election` (`election_id`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.count: 57 rows
/*!40000 ALTER TABLE `count` DISABLE KEYS */;
INSERT INTO `count` (`id`, `election_id`, `section_id`, `candidate_id`, `total_vote`, `created_at`, `updated_at`, `active`) VALUES
	(1, 1, 0, 1, 2, '2021-12-18 08:19:40', NULL, 1),
	(2, 1, 3, 2, 0, '2021-12-18 08:20:06', NULL, 1),
	(3, 1, 1, 3, 2, '2021-12-18 08:23:02', NULL, 1),
	(4, 1, 4, 4, 0, '2021-12-18 08:23:10', NULL, 1),
	(5, 1, 2, 5, 0, '2021-12-18 08:23:16', NULL, 1),
	(6, 1, 5, 6, 0, '2021-12-18 08:24:24', NULL, 1),
	(7, 2, 0, 7, 0, '2021-12-18 08:49:46', NULL, 1),
	(8, 2, 0, 8, 2, '2022-01-23 09:33:59', NULL, 1),
	(9, 2, 1, 9, 1, '2022-01-23 09:34:31', NULL, 1),
	(10, 2, 1, 10, 1, '2022-01-23 09:37:42', NULL, 1),
	(11, 2, 2, 11, 1, '2022-01-23 09:38:01', NULL, 1),
	(12, 2, 5, 12, 0, '2022-01-23 09:38:09', NULL, 1),
	(13, 2, 3, 13, 0, '2022-01-23 09:38:23', NULL, 1),
	(14, 2, 4, 14, 0, '2022-01-23 09:38:32', NULL, 1),
	(15, 2, 0, 15, 0, '2022-01-23 09:39:02', NULL, 1),
	(16, 13, 0, 16, 2, '2022-02-11 16:33:56', NULL, 1),
	(17, 13, 0, 17, 0, '2022-02-11 16:34:19', NULL, 1),
	(18, 13, 1, 18, 1, '2022-02-11 16:34:57', NULL, 1),
	(19, 13, 3, 19, 0, '2022-02-11 16:35:10', NULL, 1),
	(20, 13, 4, 20, 0, '2022-02-11 16:35:21', NULL, 1),
	(21, 13, 2, 21, 0, '2022-02-11 16:35:33', NULL, 1),
	(22, 13, 5, 22, 0, '2022-02-11 16:35:44', NULL, 1),
	(23, 25, 0, 23, 0, '2022-02-14 21:05:37', NULL, 1),
	(24, 27, 0, 24, 0, '2022-02-14 21:34:00', NULL, 1),
	(25, 27, 1, 25, 1, '2022-02-14 21:34:19', NULL, 1),
	(26, 27, 3, 26, 0, '2022-02-14 21:34:23', NULL, 1),
	(27, 27, 4, 27, 0, '2022-02-14 21:34:27', NULL, 1),
	(28, 27, 2, 28, 0, '2022-02-14 21:34:34', NULL, 1),
	(29, 27, 5, 29, 0, '2022-02-14 21:34:38', NULL, 1),
	(30, 28, 0, 30, 0, '2022-02-14 21:36:12', NULL, 1),
	(31, 28, 3, 31, 0, '2022-02-14 21:36:21', NULL, 1),
	(32, 28, 1, 32, 0, '2022-02-14 21:36:25', NULL, 1),
	(33, 28, 2, 33, 0, '2022-02-14 21:36:29', NULL, 1),
	(34, 28, 5, 34, 0, '2022-02-14 21:36:34', NULL, 1),
	(35, 28, 4, 35, 0, '2022-02-14 21:36:45', NULL, 1),
	(36, 4, 0, 36, 1, '2022-02-14 22:17:25', NULL, 1),
	(37, 4, 0, 37, 0, '2022-02-14 22:17:44', NULL, 1),
	(38, 4, 0, 38, 0, '2022-02-14 22:18:02', NULL, 1),
	(39, 4, 0, 39, 0, '2022-02-14 22:18:47', NULL, 1),
	(40, 4, 1, 40, 0, '2022-02-14 22:19:03', NULL, 1),
	(41, 4, 1, 41, 1, '2022-02-14 22:19:10', NULL, 1),
	(42, 4, 3, 42, 0, '2022-02-14 22:19:25', NULL, 1),
	(43, 4, 4, 43, 0, '2022-02-14 22:19:55', NULL, 1),
	(44, 4, 2, 44, 0, '2022-02-14 22:20:14', NULL, 1),
	(45, 4, 2, 45, 0, '2022-02-14 22:20:32', NULL, 1),
	(46, 4, 5, 46, 0, '2022-02-14 22:20:50', NULL, 1),
	(47, 4, 5, 47, 0, '2022-02-14 22:21:07', NULL, 1),
	(48, 30, 0, 48, 0, '2022-02-17 11:24:18', NULL, 1),
	(49, 30, 0, 49, 0, '2022-02-17 11:24:42', NULL, 1),
	(50, 30, 0, 50, 0, '2022-02-17 11:25:19', NULL, 1),
	(51, 30, 1, 51, 0, '2022-02-17 11:28:26', NULL, 1),
	(52, 30, 1, 52, 0, '2022-02-17 11:28:36', NULL, 1),
	(53, 30, 3, 53, 0, '2022-02-17 11:28:46', NULL, 1),
	(54, 30, 4, 54, 0, '2022-02-17 11:28:58', NULL, 1),
	(55, 30, 2, 55, 0, '2022-02-17 11:29:06', NULL, 1),
	(56, 30, 2, 56, 0, '2022-02-17 11:29:15', NULL, 1),
	(57, 30, 5, 57, 0, '2022-02-17 11:29:26', NULL, 1);
/*!40000 ALTER TABLE `count` ENABLE KEYS */;

-- Dumping structure for table voting.election
CREATE TABLE IF NOT EXISTS `election` (
  `election_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`election_id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.election: 2 rows
/*!40000 ALTER TABLE `election` DISABLE KEYS */;
INSERT INTO `election` (`election_id`, `owner_id`, `title`, `start`, `end`, `status`, `created_at`, `update_at`, `active`) VALUES
	(4, 1, 'PILIHANRAYA BTM', '2022-02-14 08:30:00', '2022-03-31 17:30:00', 'Paused', '2022-01-25 16:16:33', NULL, 1),
	(31, 1, 'PRK KUIS ONLINE', '2022-03-02 16:34:00', '2022-03-02 16:35:00', 'Paused', '2022-02-28 16:35:17', NULL, 1);
/*!40000 ALTER TABLE `election` ENABLE KEYS */;

-- Dumping structure for table voting.faculty
CREATE TABLE IF NOT EXISTS `faculty` (
  `faculty_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`faculty_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table voting.faculty: 5 rows
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` (`faculty_id`, `name`, `created_at`, `updated_at`, `active`) VALUES
	(1, 'FSTM', '2021-12-09 21:34:22', NULL, 1),
	(2, 'FSU', '2021-12-09 21:34:22', NULL, 1),
	(3, 'FPM', '2021-12-09 21:34:22', NULL, 1),
	(4, 'FPPI', '2021-12-09 21:34:22', NULL, 1),
	(5, 'FP', '2021-12-09 21:34:22', NULL, 1);
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;

-- Dumping structure for table voting.requestlogin
CREATE TABLE IF NOT EXISTS `requestlogin` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT,
  `matric_no` varchar(50) NOT NULL DEFAULT '0',
  `otp` varchar(50) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`request_id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.requestlogin: 4 rows
/*!40000 ALTER TABLE `requestlogin` DISABLE KEYS */;
INSERT INTO `requestlogin` (`request_id`, `matric_no`, `otp`, `created_at`, `updated_at`, `active`) VALUES
	(9, '19bt02100', '40b5c8b6d8b88afbe7ab4a75ba11f9f2', '2022-02-11 16:47:02', NULL, 1),
	(26, '002', '3b87a374bf05212831dde204637f56cb', '2022-02-17 12:33:16', NULL, 1),
	(24, '001', '6dd3e48a8c411fad22210d8cb69168d1', '2022-02-17 11:45:44', NULL, 1),
	(22, '1839011', '2551f901c615b9e8c58d169fc1a560db', '2022-02-14 21:52:59', NULL, 1);
/*!40000 ALTER TABLE `requestlogin` ENABLE KEYS */;

-- Dumping structure for table voting.section
CREATE TABLE IF NOT EXISTS `section` (
  `section_id` int(11) NOT NULL DEFAULT '0',
  `section_name` varchar(50) DEFAULT NULL,
  `max_vote` int(11) DEFAULT NULL,
  `section_instrution` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`section_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table voting.section: 6 rows
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` (`section_id`, `section_name`, `max_vote`, `section_instrution`, `created_at`, `updated_at`, `active`) VALUES
	(0, 'General', 2, 'Please Select', '2021-12-09 22:28:38', NULL, 1),
	(1, 'Fstm', 1, 'Please select  ', '2021-12-09 22:28:38', NULL, 1),
	(2, 'Fsu', 2, 'Please select  ', '2021-12-09 22:28:38', NULL, 1),
	(3, 'Fpm', 1, 'Please select  ', '2021-12-09 22:28:38', NULL, 1),
	(4, 'Fppi', 1, 'Please select  ', '2021-12-09 22:28:38', NULL, 1),
	(5, 'Fp', 1, 'Please select  ', '2021-12-09 22:28:38', NULL, 1);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;

-- Dumping structure for table voting.user_level
CREATE TABLE IF NOT EXISTS `user_level` (
  `user_level` int(11) NOT NULL AUTO_INCREMENT,
  `level_name` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_level`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.user_level: 2 rows
/*!40000 ALTER TABLE `user_level` DISABLE KEYS */;
INSERT INTO `user_level` (`user_level`, `level_name`, `created_at`, `updated_at`, `active`) VALUES
	(1, 'admin', '2021-12-09 20:53:07', NULL, 1),
	(2, 'voter', '2021-12-09 20:53:07', NULL, 1);
/*!40000 ALTER TABLE `user_level` ENABLE KEYS */;

-- Dumping structure for table voting.voter
CREATE TABLE IF NOT EXISTS `voter` (
  `voter_id` int(11) NOT NULL AUTO_INCREMENT,
  `voter_name` varchar(50) NOT NULL,
  `matric_no` varchar(50) NOT NULL DEFAULT '',
  `faculty` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`voter_id`,`faculty`,`matric_no`),
  KEY `FK_voter_faculty` (`faculty`)
) ENGINE=MyISAM AUTO_INCREMENT=124 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.voter: 23 rows
/*!40000 ALTER TABLE `voter` DISABLE KEYS */;
INSERT INTO `voter` (`voter_id`, `voter_name`, `matric_no`, `faculty`, `created_at`, `updated_at`, `active`) VALUES
	(101, 'Asyraf', '001', 1, '2022-02-14 22:16:49', NULL, 1),
	(102, 'Azrul', '002', 1, '2022-02-14 22:16:49', NULL, 1),
	(103, 'Azlan', '003', 1, '2022-02-14 22:16:49', NULL, 1),
	(104, 'Shahrul', '004', 3, '2022-02-14 22:16:49', NULL, 1),
	(105, 'Nazrul', '005', 3, '2022-02-14 22:16:49', NULL, 1),
	(106, 'Najmi', '006', 3, '2022-02-14 22:16:49', NULL, 1),
	(107, 'Shafiq', '007', 4, '2022-02-14 22:16:49', NULL, 1),
	(108, 'Zairi', '008', 4, '2022-02-14 22:16:49', NULL, 1),
	(109, 'Radzi', '009', 4, '2022-02-14 22:16:49', NULL, 1),
	(110, 'Hisyam', '010', 2, '2022-02-14 22:16:49', NULL, 1),
	(111, 'Fadzilah', '011', 2, '2022-02-14 22:16:49', NULL, 1),
	(112, 'Munirah', '012', 2, '2022-02-14 22:16:49', NULL, 1),
	(113, 'Atira', '013', 5, '2022-02-14 22:16:49', NULL, 1),
	(114, 'Azrina', '014', 5, '2022-02-14 22:16:49', NULL, 1),
	(115, 'Mastura', '015', 5, '2022-02-14 22:16:49', NULL, 1),
	(116, 'Rusmiha', '016', 1, '2022-02-14 22:16:49', NULL, 1),
	(117, 'Baihaqi', '017', 3, '2022-02-14 22:16:49', NULL, 1),
	(118, 'Muiz', '018', 4, '2022-02-14 22:16:49', NULL, 1),
	(119, 'Syarbaini', '019', 2, '2022-02-14 22:16:49', NULL, 1),
	(120, 'Che wan', '020', 5, '2022-02-14 22:16:49', NULL, 1),
	(121, 'Juzlinda', '021', 1, '2022-02-14 22:16:49', NULL, 1),
	(122, 'Khirulnizam', '022', 3, '2022-02-14 22:16:49', NULL, 1),
	(123, 'Hafiz', '023', 4, '2022-02-14 22:16:49', NULL, 1);
/*!40000 ALTER TABLE `voter` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
