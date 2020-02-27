
ALTER TABLE `SubIssuer` ADD COLUMN `verifyCardStatus` TINYINT(1) NULL DEFAULT 0 AFTER `paChallengePublicUrl`;