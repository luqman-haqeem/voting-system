-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.24 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for voting
DROP DATABASE IF EXISTS `voting`;
CREATE DATABASE IF NOT EXISTS `voting` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `voting`;

-- Dumping structure for table voting.admin
DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_level` int(11) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`,`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.admin: ~1 rows (approximately)
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
REPLACE INTO `admin` (`id`, `user_level`, `username`, `password`) VALUES
	(1, 1, 'admin', '202cb962ac59075b964b07152d234b70');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;

-- Dumping structure for table voting.alreadyvote
DROP TABLE IF EXISTS `alreadyvote`;
CREATE TABLE IF NOT EXISTS `alreadyvote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_id` int(11) DEFAULT NULL,
  `voter_id` int(11) NOT NULL DEFAULT '0',
  `vote_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`voter_id`),
  KEY `FK_alreadyvote_voter` (`voter_id`),
  CONSTRAINT `FK_alreadyvote_voter` FOREIGN KEY (`voter_id`) REFERENCES `voter` (`voter_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.alreadyvote: ~0 rows (approximately)
/*!40000 ALTER TABLE `alreadyvote` DISABLE KEYS */;
REPLACE INTO `alreadyvote` (`id`, `election_id`, `voter_id`, `vote_time`) VALUES
	(11, 17, 31, '2021-03-28 10:07:25');
/*!40000 ALTER TABLE `alreadyvote` ENABLE KEYS */;

-- Dumping structure for table voting.candidate
DROP TABLE IF EXISTS `candidate`;
CREATE TABLE IF NOT EXISTS `candidate` (
  `candidate_id` int(11) NOT NULL AUTO_INCREMENT,
  `voter_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL DEFAULT '0',
  `election_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`voter_id`,`section_id`,`candidate_id`,`election_id`),
  KEY `FK_candidate_section` (`section_id`),
  KEY `candidate_id` (`candidate_id`),
  KEY `FK_candidate_election` (`election_id`),
  CONSTRAINT `FK_candidate_election` FOREIGN KEY (`election_id`) REFERENCES `election` (`election_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_candidate_voter` FOREIGN KEY (`voter_id`) REFERENCES `voter` (`voter_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.candidate: ~14 rows (approximately)
/*!40000 ALTER TABLE `candidate` DISABLE KEYS */;
REPLACE INTO `candidate` (`candidate_id`, `voter_id`, `section_id`, `election_id`) VALUES
	(23, 2, 0, 17),
	(44, 2, 0, 18),
	(24, 3, 0, 17),
	(25, 4, 0, 17),
	(42, 83, 1, 17),
	(43, 85, 1, 17),
	(40, 78, 2, 17),
	(41, 79, 2, 17),
	(35, 63, 3, 17),
	(38, 64, 3, 17),
	(34, 35, 4, 17),
	(39, 75, 4, 17),
	(36, 68, 5, 17),
	(37, 70, 5, 17);
/*!40000 ALTER TABLE `candidate` ENABLE KEYS */;

-- Dumping structure for table voting.count
DROP TABLE IF EXISTS `count`;
CREATE TABLE IF NOT EXISTS `count` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_id` int(11) DEFAULT '0',
  `section_id` int(11) DEFAULT NULL,
  `candidate_id` int(11) NOT NULL DEFAULT '0',
  `total_vote` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_count_candidate_2` (`section_id`),
  KEY `FK_count_candidate` (`candidate_id`),
  KEY `FK_count_election` (`election_id`),
  CONSTRAINT `FK_count_candidate` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`candidate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_count_candidate_2` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_count_election` FOREIGN KEY (`election_id`) REFERENCES `election` (`election_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.count: ~14 rows (approximately)
/*!40000 ALTER TABLE `count` DISABLE KEYS */;
REPLACE INTO `count` (`id`, `election_id`, `section_id`, `candidate_id`, `total_vote`) VALUES
	(23, 17, 0, 23, 6),
	(24, 17, 0, 24, 6),
	(25, 17, 0, 25, 1),
	(34, 17, 4, 34, 0),
	(35, 17, 3, 35, 10),
	(36, 17, 5, 36, 3),
	(37, 17, 5, 37, 3),
	(38, 17, 3, 38, 2),
	(39, 17, 4, 39, 2),
	(40, 17, 2, 40, 4),
	(41, 17, 2, 41, 5),
	(42, 17, 1, 42, 5),
	(43, 17, 1, 43, 5),
	(44, 18, 0, 44, 0);
/*!40000 ALTER TABLE `count` ENABLE KEYS */;

-- Dumping structure for table voting.election
DROP TABLE IF EXISTS `election`;
CREATE TABLE IF NOT EXISTS `election` (
  `election_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`election_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.election: ~1 rows (approximately)
/*!40000 ALTER TABLE `election` DISABLE KEYS */;
REPLACE INTO `election` (`election_id`, `owner_id`, `title`, `start`, `end`, `status`) VALUES
	(17, 1, 'MPP ELECTION', '2021-03-27 15:45:00', '2021-03-28 15:40:00', 'Running'),
	(18, 1, 'MPP ELECTION 2021', '2021-03-27 15:44:00', '2021-03-30 15:44:00', 'Paused');
/*!40000 ALTER TABLE `election` ENABLE KEYS */;

-- Dumping structure for table voting.faculty
DROP TABLE IF EXISTS `faculty`;
CREATE TABLE IF NOT EXISTS `faculty` (
  `faculty_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`faculty_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table voting.faculty: ~5 rows (approximately)
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
REPLACE INTO `faculty` (`faculty_id`, `name`) VALUES
	(1, 'FSTM'),
	(2, 'FSU'),
	(3, 'FPM'),
	(4, 'FPPI'),
	(5, 'FP');
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;

-- Dumping structure for table voting.requestlogin
DROP TABLE IF EXISTS `requestlogin`;
CREATE TABLE IF NOT EXISTS `requestlogin` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT,
  `matric_no` varchar(50) NOT NULL DEFAULT '0',
  `otp` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.requestlogin: ~0 rows (approximately)
/*!40000 ALTER TABLE `requestlogin` DISABLE KEYS */;
REPLACE INTO `requestlogin` (`request_id`, `matric_no`, `otp`) VALUES
	(107, '1839011', 'ae8bddcb177c34849249800dc684ac2c');
/*!40000 ALTER TABLE `requestlogin` ENABLE KEYS */;

-- Dumping structure for table voting.section
DROP TABLE IF EXISTS `section`;
CREATE TABLE IF NOT EXISTS `section` (
  `section_id` int(11) NOT NULL DEFAULT '0',
  `section_name` varchar(50) DEFAULT NULL,
  `max_vote` int(11) DEFAULT NULL,
  `section_instrution` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table voting.section: ~6 rows (approximately)
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
REPLACE INTO `section` (`section_id`, `section_name`, `max_vote`, `section_instrution`) VALUES
	(0, 'General', 2, 'Please Select'),
	(1, 'Fstm', 1, 'Please select  '),
	(2, 'Fsu', 1, 'Please select  '),
	(3, 'Fpm', 1, 'Please select  '),
	(4, 'Fppi', 1, 'Please select  '),
	(5, 'Fp', 1, 'Please select  ');
/*!40000 ALTER TABLE `section` ENABLE KEYS */;

-- Dumping structure for table voting.user_level
DROP TABLE IF EXISTS `user_level`;
CREATE TABLE IF NOT EXISTS `user_level` (
  `user_level` int(11) NOT NULL AUTO_INCREMENT,
  `level_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_level`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.user_level: ~2 rows (approximately)
/*!40000 ALTER TABLE `user_level` DISABLE KEYS */;
REPLACE INTO `user_level` (`user_level`, `level_name`) VALUES
	(1, 'admin'),
	(2, 'voter');
/*!40000 ALTER TABLE `user_level` ENABLE KEYS */;

-- Dumping structure for table voting.voter
DROP TABLE IF EXISTS `voter`;
CREATE TABLE IF NOT EXISTS `voter` (
  `voter_id` int(11) NOT NULL AUTO_INCREMENT,
  `voter_name` varchar(50) NOT NULL,
  `matric_no` varchar(50) NOT NULL DEFAULT '',
  `faculty` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`voter_id`,`faculty`,`matric_no`),
  KEY `FK_voter_faculty` (`faculty`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;

-- Dumping data for table voting.voter: ~36 rows (approximately)
/*!40000 ALTER TABLE `voter` DISABLE KEYS */;
REPLACE INTO `voter` (`voter_id`, `voter_name`, `matric_no`, `faculty`) VALUES
	(2, 'Alif Farhan', '123456', 2),
	(3, 'Farhan Husaini', '234567', 2),
	(4, 'Nurul Ain', '223344', 4),
	(5, 'Amir Muzakir', '12BT34004', 5),
	(31, 'Luqman Haqeem', '1839011', 3),
	(32, 'Ahmad Fadli', '1849014', 1),
	(33, 'Ahmad Zubair', '1875015', 2),
	(34, 'Muhammad', '1789023', 3),
	(35, 'Muhammad Fauzi', '1745199', 4),
	(36, 'Nur Syazwani ', '1956025', 5),
	(37, 'Ahmad Musaab', '1748012', 1),
	(63, 'Aalam', '1911001', 3),
	(64, 'Aali', '1911002', 3),
	(65, 'Aamir', '1911004', 3),
	(66, 'Aariz', '1911005', 3),
	(67, 'Aathif', '1911006', 3),
	(68, 'Aatik', '1911007', 5),
	(69, 'Aazad', '1911008', 5),
	(70, 'Abadi', '1911009', 5),
	(71, 'Aban', '1911010', 5),
	(72, 'Abbad', '1911011', 5),
	(73, 'Abbas', '1911012', 4),
	(74, 'Abbasy', '1911013', 4),
	(75, 'Abbud', '1911014', 4),
	(76, 'Abbudin', '1911015', 4),
	(77, 'Abdel', '1911016', 4),
	(78, 'Abduh', '1911017', 2),
	(79, 'Abdul', '1912002', 2),
	(80, 'Abdul Alim', '1912003', 2),
	(81, 'Abdul Aliyy', '1912004', 2),
	(82, 'Abdul Alyan', '1912005', 2),
	(83, 'Abdul Azim', '1912006', 1),
	(84, 'Abdul Aziz', '1912007', 1),
	(85, 'Abdul Bari', '1912008', 1),
	(86, 'Abdul Basit', '1912009', 1),
	(87, 'Izzuddin Muaz', '1834098', 2);
/*!40000 ALTER TABLE `voter` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
