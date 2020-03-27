
DROP TABLE IF EXISTS `AuditMailingConfiguration`;
CREATE TABLE IF NOT EXISTS `AuditMailingConfiguration` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `periodicity` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `subIssuer_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_SubIssuer_id` (`subIssuer_id`),
  CONSTRAINT `FK_SubIssuer_id` FOREIGN KEY (`subIssuer_id`) REFERENCES `SubIssuer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=UTF8;
