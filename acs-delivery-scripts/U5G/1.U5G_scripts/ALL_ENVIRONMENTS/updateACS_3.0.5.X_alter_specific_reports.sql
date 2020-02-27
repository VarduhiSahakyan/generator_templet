ALTER TABLE `SpecificReports`
	ALTER `weekonly` DROP DEFAULT;
ALTER TABLE `SpecificReports`
	CHANGE COLUMN `weekonly` `displayType` VARCHAR(50) NOT NULL AFTER `dateFormat`;

UPDATE SpecificReports SET displayType = 'MONTH_ONLY' WHERE displayType = '0';

UPDATE SpecificReports SET displayType = 'WEEK_ONLY' WHERE displayType = '1';