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
-- Table structure for table `mdl_oauth2_endpoint`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `mdl_oauth2_endpoint` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `url` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `issuerid` bigint(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_oautendp_iss_ix` (`issuerid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_oauth2_endpoint`
--


/*!40000 ALTER TABLE `mdl_oauth2_endpoint` DISABLE KEYS */;
START TRANSACTION;
DELETE FROM `mdl_oauth2_endpoint` WHERE name='token_endpoint' AND
  issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.name='${OWNCLOUD_NAME}' LIMIT 1);
DELETE FROM `mdl_oauth2_endpoint` WHERE name='authorization_endpoint' AND
  issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.name='${OWNCLOUD_NAME}' LIMIT 1);
DELETE FROM `mdl_oauth2_endpoint` WHERE name='webdav_endpoint' AND
  issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.name='${OWNCLOUD_NAME}' LIMIT 1);
DELETE FROM `mdl_oauth2_endpoint` WHERE name='ocs_endpoint' AND
  issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.name='${OWNCLOUD_NAME}' LIMIT 1);
INSERT INTO `mdl_oauth2_endpoint` (timecreated, timemodified, usermodified, name, url, issuerid) VALUES (1516290735,1516710552,69,'token_endpoint','${OWNCLOUD_TOKEN_ENDPOINT}',(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.name='${OWNCLOUD_NAME}' LIMIT 1)),(1516290755,1516710561,69,'authorization_endpoint','${OWNCLOUD_AUTHORIZE_ENDPOINT}',(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.name='${OWNCLOUD_NAME}' LIMIT 1)),(1516290774,1516710570,69,'webdav_endpoint','${OWNCLOUD_WEBDAV_ENDPOINT}',(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.name='${OWNCLOUD_NAME}' LIMIT 1)),(1516290794,1516711057,69,'ocs_endpoint','${OWNCLOUD_OCS_ENDPOINT}',(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.name='${OWNCLOUD_NAME}' LIMIT 1));
COMMIT;
/*!40000 ALTER TABLE `mdl_oauth2_endpoint` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-26 18:06:34
