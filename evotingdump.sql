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
CREATE DATABASE IF NOT EXISTS `voting` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `voting`;

-- Dumping structure for table voting.admin
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_level` int(11) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`,`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table voting.alreadyvote
CREATE TABLE IF NOT EXISTS `alreadyvote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_id` int(11) DEFAULT NULL,
  `voter_id` int(11) NOT NULL DEFAULT '0',
  `vote_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`voter_id`),
  KEY `FK_alreadyvote_voter` (`voter_id`),
  CONSTRAINT `FK_alreadyvote_voter` FOREIGN KEY (`voter_id`) REFERENCES `voter` (`voter_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table voting.candidate
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

-- Data exporting was unselected.

-- Dumping structure for table voting.count
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

-- Data exporting was unselected.

-- Dumping structure for table voting.election
CREATE TABLE IF NOT EXISTS `election` (
  `election_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`election_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table voting.faculty
CREATE TABLE IF NOT EXISTS `faculty` (
  `faculty_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`faculty_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table voting.requestlogin
CREATE TABLE IF NOT EXISTS `requestlogin` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT,
  `matric_no` varchar(50) NOT NULL DEFAULT '0',
  `otp` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table voting.section
CREATE TABLE IF NOT EXISTS `section` (
  `section_id` int(11) NOT NULL DEFAULT '0',
  `section_name` varchar(50) DEFAULT NULL,
  `max_vote` int(11) DEFAULT NULL,
  `section_instrution` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table voting.user_level
CREATE TABLE IF NOT EXISTS `user_level` (
  `user_level` int(11) NOT NULL AUTO_INCREMENT,
  `level_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_level`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table voting.voter
CREATE TABLE IF NOT EXISTS `voter` (
  `voter_id` int(11) NOT NULL AUTO_INCREMENT,
  `voter_name` varchar(50) NOT NULL,
  `matric_no` varchar(50) NOT NULL DEFAULT '',
  `faculty` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`voter_id`,`faculty`,`matric_no`),
  KEY `FK_voter_faculty` (`faculty`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
