ALTER TABLE `Profile` ADD COLUMN `dataEntryAllowedPattern` VARCHAR(255) AFTER `maxAttempts`;
ALTER TABLE `Profile` ADD COLUMN `dataEntryFormat` VARCHAR(255) AFTER `maxAttempts`;

-- Copy old configuration from SubIssuer table on each Profile
UPDATE Profile
SET Profile.dataEntryFormat = (SELECT SubIssuer.otpAllowed
							FROM SubIssuer
                            WHERE SubIssuer.id = Profile.fk_id_subIssuer);

UPDATE Profile
SET Profile.dataEntryAllowedPattern = (SELECT SubIssuer.otpExcluded
							FROM SubIssuer
                            WHERE SubIssuer.id = Profile.fk_id_subIssuer);


ALTER TABLE `SubIssuer` DROP COLUMN `otpAllowed`;
ALTER TABLE `SubIssuer` DROP COLUMN `otpExcluded`;