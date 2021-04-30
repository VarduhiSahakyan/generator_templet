
USE `U5G_ACS_BO`;

SET @issuerCode = '19550';
SET @reportName = 'TRANSACTIONS_STATUS_VE_PA';
SET @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
SET @id_specific_reports = (SELECT id FROM U5G_ACS_BO.SpecificReports where name = @reportName);
SET @emails = 'hansjoerg.fichtner@lbbw.de; sascha.deigner@lbbw.de; marco.schuele@lbbw.de; atos_report@bw-bank.de; 3dsecure@worldline.com';


SET @dateFilterDaily = 'TODAY';


INSERT INTO `ReportingConfiguration` (`periodicity`, `emails`, `tool`, `issuerEntity_id`,  `dateFilter`)
VALUES
(1, @emails, 'pivottable', @id_issuer, @dateFilterDaily);

SET @lastId=(SELECT `id` FROM `ReportingConfiguration` WHERE `emails`= @emails AND `issuerEntity_id`= @id_issuer AND `dateFilter` = @dateFilterDaily);

INSERT INTO `ReportingConfigurationSpecificReports` (`reporting_configuration_id`, `specific_reports_id`)
VALUES
(@lastId, @id_specific_reports);


SET @dateFilterWeekly = 'WEEKLY';

INSERT INTO `ReportingConfiguration` (`periodicity`, `emails`, `tool`, `issuerEntity_id`,  `dateFilter`)
VALUES
(7, @emails, 'pivottable', @id_issuer, @dateFilterWeekly);

SET @lastId=(SELECT `id` FROM `ReportingConfiguration` WHERE `emails`= @emails AND `issuerEntity_id`= @id_issuer AND `dateFilter` = @dateFilterWeekly);

INSERT INTO `ReportingConfigurationSpecificReports` (`reporting_configuration_id`, `specific_reports_id`)
VALUES
(@lastId, @id_specific_reports);


SET @dateFilterMonthly = 'REPORTING_30_DAYS';

INSERT INTO `ReportingConfiguration` (`periodicity`, `emails`, `tool`, `issuerEntity_id`,  `dateFilter`)
VALUES
(30, @emails, 'pivottable', @id_issuer, @dateFilterMonthly);

SET @lastId=(SELECT `id` FROM `ReportingConfiguration` WHERE `emails`= @emails AND `issuerEntity_id`= @id_issuer AND `dateFilter` = @dateFilterMonthly);

INSERT INTO `ReportingConfigurationSpecificReports` (`reporting_configuration_id`, `specific_reports_id`)
VALUES
(@lastId, @id_specific_reports);


SET @reportName = 'AUTHENT_MEANS_STATUS_TYPES';
SET @id_specific_reports = (SELECT id FROM U5G_ACS_BO.SpecificReports where name = @reportName);
SET @lastId=(SELECT `id` FROM `ReportingConfiguration` WHERE `emails`= @emails AND `issuerEntity_id`= @id_issuer AND `dateFilter` = @dateFilterWeekly);

INSERT INTO `ReportingConfigurationSpecificReports` (`reporting_configuration_id`, `specific_reports_id`)
VALUES
(@lastId, @id_specific_reports);