USE U5G_ACS_BO;

SET @createdBy = 'A757435';
SET @updateState =  'PUSHED_TO_CONFIG';
SET @status = 'DEPLOYED_IN_PRODUCTION';
SET @subIssuerID = (SELECT `id` FROM `SubIssuer` WHERE `code` = 12000);
SET @bank = '12000_REISEBANK';

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanMobileApp = (SELECT id FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP');

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
(@createdBy, NOW(), 'Backup Refusal', NULL, NULL, CONCAT(@bank,'_BACKUP_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, NULL, NULL, NULL, @subIssuerID);

SET @profileBackupRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_BACKUP_REFUSAL'));
SET @profileMobileApp = (SELECT id FROM `Profile` WHERE `name` = '12000_REISEBANK_MOBILE_APP_01');
SET @profileOTPSms = (SELECT id FROM `Profile` WHERE `name` = '12000_REISEBANK_SMS_01');
SET @profileUndefined = (SELECT id FROM `Profile` WHERE `name` = '12000_UNDEFINED_01');
SET @profileDefaultRefusal = (SELECT id FROM `Profile` WHERE `name` = '12000_REISEBANK_DEFAULT_REFUSAL');



INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), 'BACKUP_REFUSAL', NULL, NULL, 'BACKUP_REFUSAL', @updateState,3, @profileBackupRefusal);

SET @ruleMobileApp = (SELECT `id` FROM `Rule` WHERE `name` = 'MOBILE_APP(NORMAL)' AND `fk_id_profile` = @profileMobileApp);
SET @ruleOTPSms = (SELECT `id` FROM `Rule` WHERE `name` = 'OTP_SMS (FALLBACK)' AND `fk_id_profile` = @profileOTPSms) ;
SET @ruleUndefined = (SELECT `id` FROM `Rule` WHERE `name` = 'UNDEFINED' AND `fk_id_profile` = @profileUndefined ) ;
SET @ruleDefaultRefusal = (SELECT `id` FROM `Rule` WHERE `name` = 'DEFAULT_REFUSAL' AND `fk_id_profile` = @profileDefaultRefusal) ;

UPDATE `Rule` SET `orderRule` = 4 WHERE `id` = @ruleMobileApp;
UPDATE `Rule` SET `orderRule` = 5 WHERE `id` = @ruleOTPSms;
UPDATE `Rule` SET `orderRule` = 6 WHERE `id` = @ruleUndefined;
UPDATE `Rule` SET `orderRule` = 7 WHERE `id` = @ruleDefaultRefusal;

SET @ruleBackupRefusal = (SELECT id FROM `Rule` WHERE `description` = 'BACKUP_REFUSAL' AND `fk_id_profile` = @profileBackupRefusal);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_01_BACKUP_REFUSAL'), @updateState, @ruleBackupRefusal);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_BACKUP_REFUSAL')
  AND mps.`fk_id_authentMean` = @authMeanMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = FALSE);



INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
WHERE ps.`name` = 'PS_12232_REISEBANK_01' AND r.`id` IN (@ruleBackupRefusal);


