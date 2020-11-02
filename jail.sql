-- --------------------------------------------------------
-- Verkkotietokone:              127.0.0.1
-- Palvelinversio:               10.4.13-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Versio:              11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for essentialmode
CREATE DATABASE IF NOT EXISTS `essentialmode` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `essentialmode`;

-- Dumping structure for taulu essentialmode.jail
CREATE TABLE IF NOT EXISTS `jail` (
  `identifier` varchar(100) NOT NULL,
  `isjailed` tinyint(1) DEFAULT NULL,
  `J_Time` int(11) NOT NULL DEFAULT 0,
  `J_Cell` varchar(20) NOT NULL,
  `Jailer_ID` varchar(100) DEFAULT NULL,
  `jail_time` int(10) NOT NULL,
  `Jailer` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table essentialmode.jail: ~0 rows (suunnilleen)
/*!40000 ALTER TABLE `jail` DISABLE KEYS */;
/*!40000 ALTER TABLE `jail` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
