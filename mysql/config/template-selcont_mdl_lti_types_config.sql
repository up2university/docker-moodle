-- MySQL dump 10.13  Distrib 5.5.57, for Linux (x86_64)
--
-- Host: localhost    Database: moodle
-- ------------------------------------------------------
-- Server version	5.5.57

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
-- Table structure for table `mdl_lti_types_config`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `mdl_lti_types_config` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `typeid` bigint(10) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_ltitypeconf_typ_ix` (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED COMMENT='Basic LTI types configuration';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_lti_types_config`
--

/*!40000 ALTER TABLE `mdl_lti_types_config` DISABLE KEYS */;
INSERT INTO `mdl_lti_types_config` (typeid, name, value) VALUES
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'resourcekey','selcont-key'),
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'password','${SELCONT_PASSWORD}'),
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'customparameters',''),
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'coursevisible','2'),
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'launchcontainer','4'),
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'contentitem','0'),
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'sendname','2'),
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'sendemailaddr','2'),
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'acceptgrades','0'),
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'organizationid',''),
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'organizationurl',''),
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'forcessl','1'),
((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.name='${SELCONT_TOOL_NAME}' LIMIT 1),'servicesalt','${SELCONT_SERVICE_SALT}'); 
/*!40000 ALTER TABLE `mdl_lti_types_config` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-26 17:49:48
