CREATE TABLE IF NOT EXISTS `ReportingConfiguration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `periodicity` INT(11) NOT NULL,
  `emails` VARCHAR (400) NOT NULL,
  `tool` VARCHAR (50) NOT NULL,
  `issuerEntity_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

ALTER TABLE `ReportingConfiguration`
ADD CONSTRAINT `fk_issuer_entity`
FOREIGN KEY (`issuerEntity_id`)
REFERENCES `Issuer` (`id`);

CREATE TABLE IF NOT EXISTS `ReportingConfigurationSpecificReports` (
	`reporting_configuration_id` BIGINT(20) NOT NULL,
	`specific_reports_id` BIGINT(20) NOT NULL,
	PRIMARY KEY (`reporting_configuration_id`, `specific_reports_id`) USING BTREE
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `ReportingConfigurationSpecificReports`
ADD CONSTRAINT `fk_reporting_configuration`
FOREIGN KEY (`reporting_configuration_id`)
REFERENCES `ReportingConfiguration` (`id`);

ALTER TABLE `ReportingConfigurationSpecificReports`
ADD CONSTRAINT `fk_specific_reports`
FOREIGN KEY (`specific_reports_id`)
REFERENCES `SpecificReports` (`id`);

