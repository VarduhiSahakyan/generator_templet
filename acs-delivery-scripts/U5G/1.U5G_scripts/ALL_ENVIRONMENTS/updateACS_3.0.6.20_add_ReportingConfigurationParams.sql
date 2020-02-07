
CREATE TABLE IF NOT EXISTS `ReportingConfigurationParams` (
	`id` bigint(20) NOT NULL AUTO_INCREMENT,
  `paramLabel` VARCHAR(100) NOT NULL UNIQUE,
  `paramValue` VARCHAR (100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `ReportingConfigurationParams` (paramLabel,paramValue)
values("REPORTING_BY_MAIL_TEMP_DIRECTORY","/tmp/");
