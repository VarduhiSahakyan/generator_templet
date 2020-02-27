DROP TABLE IF EXISTS `SpecificReports`;
CREATE TABLE `SpecificReports` (
	`id` bigint(20) NOT NULL AUTO_INCREMENT,
	`name` varchar(255) DEFAULT NULL,
	`dateFormat` varchar(255) DEFAULT NULL,
	`weekonly` bool DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `SpecificReports` (`name`, `dateFormat`, `weekOnly`)
VALUES
('SMS_NOTIFICATIONS', 'MMMM YYYY', 0),
('REFUSALCAUSES_PA_BY_PROFILEMEANS', 'MMMM YYYY', 0),
('STATUS_PA_BY_PROFILEMEANS', 'MMMM YYYY', 0),
('SVI', 'MMMM YYYY', 0),
('GIE', 'MMMM YYYY', 0),
('BDF_MONTHLY', 'MMMM YYYY', 0),
('BDF_DAILY', 'DD MMMM YYYY', 0),
('TOP50', 'DD MMMM YYYY', 1);

DROP TABLE IF EXISTS `SpecificReports_Issuer`;
CREATE TABLE `SpecificReports_Issuer` (
	`id_specificReport` bigint(20) NOT NULL,
	`id_issuer` bigint(20) NOT NULL,
	PRIMARY KEY (`id_specificReport`, `id_issuer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

