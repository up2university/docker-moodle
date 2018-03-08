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
-- Table structure for table `mdl_repository_instances`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `mdl_repository_instances` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `typeid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT '0',
  `contextid` bigint(10) NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timecreated` bigint(10) DEFAULT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `readonly` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED COMMENT='This table contains one entry for every configured external ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_repository_instances`
--

/*!40000 ALTER TABLE `mdl_repository_instances` DISABLE KEYS */;
/*INSERT INTO `mdl_repository_instances` (name, typeid, userid, contextid, username, password, timecreated, timemodified,readonly) VALUES
('${CERNBOX_REPO_NAME}', (SELECT id FROM `mdl_repository` WHERE mdl_repository.type = '${CERNBOX_REPOSITORY_TYPE}'),0,1,NULL,NULL,1516380035,1516380035,0)
WHERE EXISTS (SELECT id FROM `mdl_repository` WHERE mdl_repository.type = '${CERNBOX_REPOSITORY_TYPE}');*/
/*INSERT INTO `mdl_repository` (type, visible, sortorder) SELECT '${CERNBOX_REPOSITORY_TYPE}', 1, (SELECT max(sortorder) + 1 FROM `mdl_repository`) FROM `mdl_repository`
WHERE NOT EXISTS (SELECT id FROM `mdl_repository` WHERE mdl_repository.type = '${CERNBOX_REPOSITORY_TYPE}');*/
START TRANSACTION;
INSERT INTO `mdl_repository` (type, visible, sortorder)
SELECT '${CERNBOX_REPOSITORY_TYPE}', 1, (SELECT max(sortorder) + 1 FROM `mdl_repository` LIMIT 1)
FROM `mdl_repository`
WHERE NOT EXISTS (SELECT id FROM `mdl_repository`
  WHERE mdl_repository.type = '${CERNBOX_REPOSITORY_TYPE}' LIMIT 1) LIMIT 1;
COMMIT;

START TRANSACTION;
DELETE FROM `mdl_repository_instances` WHERE name='${CERNBOX_REPO_NAME}' AND
  typeid=(SELECT id FROM `mdl_repository` WHERE mdl_repository.type = '${CERNBOX_REPOSITORY_TYPE}' LIMIT 1);
INSERT INTO `mdl_repository_instances` (name, typeid, userid, contextid, username, password, timecreated, timemodified,readonly)
SELECT '${CERNBOX_REPO_NAME}',
(SELECT id FROM `mdl_repository` WHERE mdl_repository.type = '${CERNBOX_REPOSITORY_TYPE}' LIMIT 1),
0,1,NULL,NULL,1516380035,1516380035,0
FROM `mdl_repository`
WHERE EXISTS (SELECT id FROM `mdl_repository` WHERE mdl_repository.type = '${CERNBOX_REPOSITORY_TYPE}' LIMIT 1) LIMIT 1;
COMMIT;
/*!40000 ALTER TABLE `mdl_repository_instances` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-07 15:22:49
