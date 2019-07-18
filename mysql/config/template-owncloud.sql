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
-- Table structure for table `mdl_oauth2_user_field_mapping`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `mdl_oauth2_user_field_mapping` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `timemodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `issuerid` bigint(10) NOT NULL,
  `externalfield` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `internalfield` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_oautuserfielmapp_issin_uix` (`issuerid`,`internalfield`),
  KEY `mdl_oautuserfielmapp_iss_ix` (`issuerid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl_repository_instance_config`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `mdl_repository_instance_config` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `instanceid` bigint(10) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED COMMENT='The config for intances';
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP PROCEDURE IF EXISTS safe_update;

delimiter $$
CREATE PROCEDURE safe_update()
BEGIN
  IF EXISTS (SELECT * FROM `mdl_oauth2_issuer` WHERE baseurl='${OWNCLOUD_URL}') THEN
    UPDATE `mdl_oauth2_issuer` SET
      name='${OWNCLOUD_NAME}',
      clientid='${OWNCLOUD_CLIENT_ID}',
      clientsecret='${OWNCLOUD_CLIENT_SECRET}'
    WHERE baseurl='${OWNCLOUD_URL}';
  ELSE
     INSERT INTO `mdl_oauth2_issuer`
      (timecreated,
       timemodified,
       usermodified,
       name,
       image,
       baseurl,
       clientid,
       clientsecret,
       loginscopes,
       loginscopesoffline,
       loginparams,
       loginparamsoffline,
       alloweddomains,
       scopessupported,
       showonloginpage,
       basicauth,
       enabled,
       sortorder)
    VALUES
      (1516290702,
       1516711066,
       69,
       '${OWNCLOUD_NAME}',
       '',
       '${OWNCLOUD_URL}',
       '${OWNCLOUD_CLIENT_ID}',
       '${OWNCLOUD_CLIENT_SECRET}',
       'openid profile email',
       'openid profile email',
       '',
       '',
       '',
       NULL,
       0,
       0,
       1,
       0);
  END IF;

  IF EXISTS (SELECT issuerid from `mdl_oauth2_endpoint` 
  	where issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}'))
  	THEN
  	
  	UPDATE `mdl_oauth2_endpoint` set url='${OWNCLOUD_TOKEN_ENDPOINT}' where name='token_endpoint' 
  		AND issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}');

  	UPDATE `mdl_oauth2_endpoint` set url='${OWNCLOUD_AUTHORIZE_ENDPOINT}' where name='authorization_endpoint' 
  		AND issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}');

  	UPDATE `mdl_oauth2_endpoint` set url='${OWNCLOUD_WEBDAV_ENDPOINT}' where name='webdav_endpoint' 
  		AND issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}');

  	UPDATE `mdl_oauth2_endpoint` set url='${OWNCLOUD_OCS_ENDPOINT}' where name='ocs_endpoint' 
  		AND issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}');  		
	UPDATE `mdl_oauth2_endpoint` set url='${OWNCLOUD_USERINFO_ENDPOINT}' where name='userinfo_endpoint'
		AND issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}');

	INSERT IGNORE INTO `mdl_oauth2_endpoint` (timecreated, timemodified, usermodified, name, url, issuerid)
	VALUES
	  (1516290794,1516711057,69,'userinfo_endpoint','${OWNCLOUD_USERINFO_ENDPOINT}',
	    (SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}' LIMIT 1));
  ELSE 
  	INSERT INTO `mdl_oauth2_endpoint` (timecreated, timemodified, usermodified, name, url, issuerid)
  	VALUES
	  (1516290735,1516710552,69,'token_endpoint','${OWNCLOUD_TOKEN_ENDPOINT}',
	    (SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}' LIMIT 1)),
	  (1516290755,1516710561,69,'authorization_endpoint','${OWNCLOUD_AUTHORIZE_ENDPOINT}',
	    (SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}' LIMIT 1)),
	  (1516290774,1516710570,69,'webdav_endpoint','${OWNCLOUD_WEBDAV_ENDPOINT}',
	    (SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}' LIMIT 1)),
	  (1516290794,1516711057,69,'ocs_endpoint','${OWNCLOUD_OCS_ENDPOINT}',
	    (SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}' LIMIT 1)),
	  (1516290794,1516711057,69,'userinfo_endpoint','${OWNCLOUD_USERINFO_ENDPOINT}',
	    (SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}' LIMIT 1));
  END IF;

  IF NOT EXISTS (SELECT externalfield from `mdl_oauth2_user_field_mapping` 
  	where externalfield='ocs-data-email' AND issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}'))
  	THEN 

	INSERT INTO `mdl_oauth2_user_field_mapping` (timemodified,timecreated,usermodified,issuerid,externalfield,internalfield)
	VALUES (1516290823,1516290823,2,
        	(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}' LIMIT 1),
      		'ocs-data-email','email');
  END IF;

  IF NOT EXISTS (SELECT externalfield from `mdl_oauth2_user_field_mapping` 
  	where externalfield='ocs-data-id' AND issuerid=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}'))
  	THEN 

	INSERT INTO `mdl_oauth2_user_field_mapping` (timemodified,timecreated,usermodified,issuerid,externalfield,internalfield)
	VALUES (1516290838,1516290838,2,
        	(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}' LIMIT 1),
      		'ocs-data-id','username');
  END IF;
  
  INSERT INTO `mdl_repository` (type, visible, sortorder)
  	SELECT '${OWNCLOUD_REPOSITORY_TYPE}', 1, (SELECT max(sortorder) + 1 FROM `mdl_repository` LIMIT 1)
  	FROM `mdl_repository`
  WHERE NOT EXISTS (SELECT id FROM `mdl_repository`
  	WHERE mdl_repository.type = '${OWNCLOUD_REPOSITORY_TYPE}' LIMIT 1) LIMIT 1;

  IF EXISTS (SELECT instanceid FROM `mdl_repository_instance_config`
               WHERE name='issuerid' AND
               value=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}')) THEN
      UPDATE `mdl_repository_instances`
      SET name='${OWNCLOUD_REPO_NAME}'
      WHERE id=(SELECT instanceid FROM `mdl_repository_instance_config`
                 WHERE name='issuerid' AND
                 value=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}')) 
      AND
            typeid=(SELECT id FROM `mdl_repository` WHERE mdl_repository.type = '${OWNCLOUD_REPOSITORY_TYPE}' LIMIT 1);
  ELSE
      INSERT INTO `mdl_repository_instances` (name, typeid, userid, contextid, username, password, timecreated, timemodified,readonly)
      VALUES ('${OWNCLOUD_REPO_NAME}',
      		(SELECT id FROM `mdl_repository` WHERE mdl_repository.type = '${OWNCLOUD_REPOSITORY_TYPE}' LIMIT 1),
      		0,1,NULL,NULL,1516380035,1516380035,0);
  END IF;

  IF NOT EXISTS (SELECT id from `mdl_repository_instance_config` WHERE name='issuerid'
                 AND value=(SELECT id FROM `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}')) THEN
    INSERT INTO `mdl_repository_instance_config` (instanceid, name, value)
      SELECT
        (SELECT id FROM `mdl_repository_instances` WHERE mdl_repository_instances.baseurl='${OWNCLOUD_URL}' LIMIT 1),
        'issuerid',
        (SELECT id from `mdl_oauth2_issuer` WHERE mdl_oauth2_issuer.baseurl='${OWNCLOUD_URL}' LIMIT 1)
      FROM `mdl_repository_instances`
      WHERE EXISTS
        (SELECT id FROM `mdl_repository_instances` WHERE mdl_repository_instances.baseurl='${OWNCLOUD_URL}' LIMIT 1) LIMIT 1;
  END IF;
END $$
delimiter ;

START TRANSACTION;
CALL safe_update();
/*!40000 ALTER TABLE `mdl_oauth2_issuer` ENABLE KEYS */;

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
