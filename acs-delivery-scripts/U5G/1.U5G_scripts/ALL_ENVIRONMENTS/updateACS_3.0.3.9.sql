-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: u6f_acs_bo_nps
-- ------------------------------------------------------
-- Server version	5.6.20-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CustomComponent`
--

DROP TABLE IF EXISTS `CustomComponent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomComponent` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `controller` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `fk_id_layout` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_67yirvb0jf1r4eicm3wkiy7mb` (`fk_id_layout`),
  KEY `FK_im47bdmuj3wwr6ad68b5i8ea4` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=120 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CustomComponentParams`
--

DROP TABLE IF EXISTS `CustomComponentParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomComponentParams` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `keyParam` varchar(255) DEFAULT NULL,
  `valueParam` varchar(255) DEFAULT NULL,
  `fk_id_component` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_rpl7258qu4hwmkx4ny35wrtck` (`fk_id_component`)
) ENGINE=MyISAM AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custompagelayout`
--

DROP TABLE IF EXISTS `CustomPageLayout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomPageLayout` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `controller` varchar(255) DEFAULT NULL,
  `pageType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CustompageLayout_ProfileSet`
--

DROP TABLE IF EXISTS `CustomPageLayout_ProfileSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomPageLayout_ProfileSet` (
  `customPageLayout_id` bigint(20) NOT NULL,
  `profileSet_id` bigint(20) NOT NULL,
  KEY `FK_lh1xu5mvfq3o61clcvgewaiuu` (`profileSet_id`),
  KEY `FK_hvjjd6pbndio9tx739vig3jgy` (`customPageLayout_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customstyle`
--

DROP TABLE IF EXISTS `CustomStyle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomStyle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customMediaQuery` varchar(255) DEFAULT NULL,
  `maxDeviceHeight` int(11) DEFAULT NULL,
  `maxDeviceWidth` int(11) DEFAULT NULL,
  `minDeviceHeigh` int(11) DEFAULT NULL,
  `minDeviceWidth` int(11) DEFAULT NULL,
  `selector` varchar(255) DEFAULT NULL,
  `selectorState` varchar(255) DEFAULT NULL,
  `fk_id_component` bigint(20) DEFAULT NULL,
  `fk_id_element_component` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_q1d4kguapofiuw2ggkhknq9lb` (`fk_id_component`),
  KEY `FK_mg938ndfh068s6jtl7q0kyy4e` (`fk_id_element_component`)
) ENGINE=MyISAM AUTO_INCREMENT=187 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CustomStyleParams`
--

DROP TABLE IF EXISTS `CustomStyleParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomStyleParams` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `paramKey` varchar(255) DEFAULT NULL,
  `paramValue` varchar(255) DEFAULT NULL,
  `fk_id_style` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_1p3fuy1j77ktevu17tbhnrmm6` (`fk_id_style`)
) ENGINE=MyISAM AUTO_INCREMENT=347 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-11  9:53:48
