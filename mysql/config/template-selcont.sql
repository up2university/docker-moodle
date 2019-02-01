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
-- Table structure for table `mdl_lti_types`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS`mdl_lti_types` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'basiclti Activity',
  `baseurl` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `tooldomain` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `state` tinyint(2) NOT NULL DEFAULT '2',
  `course` bigint(10) NOT NULL,
  `coursevisible` tinyint(1) NOT NULL DEFAULT '0',
  `toolproxyid` bigint(10) DEFAULT NULL,
  `enabledcapability` longtext COLLATE utf8mb4_unicode_ci,
  `parameter` longtext COLLATE utf8mb4_unicode_ci,
  `icon` longtext COLLATE utf8mb4_unicode_ci,
  `secureicon` longtext COLLATE utf8mb4_unicode_ci,
  `createdby` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `mdl_ltitype_cou_ix` (`course`),
  KEY `mdl_ltitype_too_ix` (`tooldomain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED COMMENT='Basic LTI pre-configured activities';
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP PROCEDURE IF EXISTS safe_update;

delimiter $$
CREATE PROCEDURE safe_update()
BEGIN
	IF EXISTS (SELECT * FROM `mdl_lti_types` WHERE tooldomain='${SELCONT_URL}') THEN
		UPDATE `mdl_lti_types` SET baseurl='${SELCONT_KEY_URL}' WHERE tooldomain='${SELCONT_URL}';
		UPDATE `mdl_lti_types` SET name='${SELCONT_TOOL_NAME}' WHERE tooldomain='${SELCONT_URL}';
	ELSE 
		INSERT INTO `mdl_lti_types` 
		(name, baseurl, tooldomain, state, course, coursevisible, toolproxyid, enabledcapability, parameter,icon, secureicon, createdby, timecreated, timemodified, description) 
		VALUES ('${SELCONT_TOOL_NAME}','${SELCONT_KEY_URL}','${SELCONT_URL}',1,1,2,NULL,NULL,NULL,'','',22,1498662767,1513846790,'LTI SeLCont Tool');
	END IF;	
	
	IF EXISTS (SELECT id from `mdl_lti_types_config` WHERE typeid=(
			SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1)) THEN
		
		UPDATE `mdl_lti_types_config` SET value='${SELCONT_PASSWORD}' WHERE name='password' AND typeid=
				(SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1); 
				
		UPDATE `mdl_lti_types_config` SET value='${SELCONT_SERVICE_SALT}' WHERE name='servicesalt' AND typeid=
				(SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1); 

		UPDATE `mdl_lti_types_config` SET value='${SELCONT_KEY}' WHERE name='resourcekey' AND typeid=
				(SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1); 
	ELSE 	
		INSERT INTO `mdl_lti_types_config` (typeid, name, value) VALUES
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'resourcekey','${SELCONT_KEY}'),
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'password','${SELCONT_PASSWORD}'),
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'customparameters',''),
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'coursevisible','2'),
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'launchcontainer','4'),
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'contentitem','0'),
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'sendname','2'),
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'sendemailaddr','2'),
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'acceptgrades','0'),
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'organizationid',''),
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'organizationurl',''),
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'forcessl','1'),
		((SELECT id FROM `mdl_lti_types` WHERE mdl_lti_types.tooldomain='${SELCONT_URL}' LIMIT 1),'servicesalt','${SELCONT_SERVICE_SALT}'); 
	END IF;
END $$
delimiter ;

START TRANSACTION;
CALL safe_update();
COMMIT;

START TRANSACTION;
DROP PROCEDURE IF EXISTS safe_update;
COMMIT;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-26 17:49:56
