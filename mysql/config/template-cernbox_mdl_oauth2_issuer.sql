-- MySQL dump 10.13  Distrib 5.5.59, for Linux (x86_64)
--
-- Host: localhost    Database: moodle
-- ------------------------------------------------------
-- Server version	5.5.59

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `mdl_oauth2_issuer`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `mdl_oauth2_issuer` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `image` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `baseurl` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `clientid` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `clientsecret` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `loginscopes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `loginscopesoffline` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `loginparams` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `loginparamsoffline` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `alloweddomains` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `scopessupported` longtext COLLATE utf8mb4_unicode_ci,
  `showonloginpage` tinyint(2) NOT NULL DEFAULT '1',
  `basicauth` tinyint(2) NOT NULL DEFAULT '0',
  `enabled` tinyint(2) NOT NULL DEFAULT '1',
  `sortorder` bigint(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_oauth2_issuer`
--


START TRANSACTION;
/*!40000 ALTER TABLE `mdl_oauth2_endpoint` DISABLE KEYS */;
DELETE FROM `mdl_oauth2_endpoint` WHERE issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.name='${CERNBOX_NAME}');
/*!40000 ALTER TABLE `mdl_oauth2_endpoint` ENABLE KEYS */;


/*!40000 ALTER TABLE `mdl_oauth2_user_field_mapping` DISABLE KEYS */;
DELETE FROM `mdl_oauth2_user_field_mapping` WHERE issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.name='${CERNBOX_NAME}');
/*!40000 ALTER TABLE `mdl_oauth2_user_field_mapping` ENABLE KEYS */;


/*!40000 ALTER TABLE `mdl_oauth2_issuer` DISABLE KEYS */;
DELETE FROM `mdl_oauth2_issuer` WHERE name='${CERNBOX_NAME}';
INSERT INTO `mdl_oauth2_issuer` (timecreated, timemodified, usermodified, name, image, baseurl, clientid, clientsecret, loginscopes, loginscopesoffline, loginparams, loginparamsoffline, alloweddomains, scopessupported, showonloginpage, basicauth, enabled, sortorder) VALUES (1516290702,1516711066,69,'${CERNBOX_NAME}','','${CERNBOX_URL}','${CERNBOX_CLIENT_ID}','${CERNBOX_CLIENT_SECRET}','openid profile email','openid profile email','','','',NULL,0,0,1,0);
/*!40000 ALTER TABLE `mdl_oauth2_issuer` ENABLE KEYS */;

COMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-26 18:06:34
