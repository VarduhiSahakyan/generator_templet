ALTER TABLE `CustomItem` ADD `fk_id_font` BIGINT(20) NULL AFTER `fk_id_image`;

CREATE TABLE IF NOT EXISTS `Font` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `createdBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `mimeType` varchar(255) DEFAULT NULL,
  `lastUpdateBy` varchar(255) DEFAULT NULL,
  `lastUpdateDate` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `updateState` varchar(255) NOT NULL,
  `binaryData` longblob,
  PRIMARY KEY (`id`,`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

