ALTER TABLE `Network` ADD COLUMN `eciAuthSuccess` VARCHAR(255) NOT NULL AFTER `solution`;
ALTER TABLE `Network` ADD COLUMN `eciNoAuth` VARCHAR(255) NOT NULL AFTER `eciAuthSuccess`;
ALTER TABLE `Network` ADD COLUMN `eciFailed` VARCHAR(255) AFTER `eciNoAuth`;
ALTER TABLE `Network` ADD COLUMN `eciNpaFailed` VARCHAR(255) AFTER `eciFailed`;
ALTER TABLE `Network` ADD COLUMN `eciNpaAuthSuccess` VARCHAR(255) AFTER `eciNpaFailed`;
ALTER TABLE `Network` ADD COLUMN `displayName` VARCHAR(255) NOT NULL AFTER `eciNpaAuthSuccess`;