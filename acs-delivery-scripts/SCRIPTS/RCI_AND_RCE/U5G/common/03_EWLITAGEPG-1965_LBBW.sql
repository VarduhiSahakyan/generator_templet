USE U5G_ACS_BO;

SET @createdBy = 'A757435';
SET @updateState =  'PUSHED_TO_CONFIG';
SET @status = 'DEPLOYED_IN_PRODUCTION';
SET @subIssuerID = (SELECT `id` FROM `SubIssuer` WHERE `code` = 19550);
SET @bank = 'LBBW';

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanMobileApp = (SELECT id FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP');
SET @authMeanPWD_OTP = (SELECT id FROM `AuthentMeans` WHERE `name` = 'PWD_OTP');

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
(@createdBy, NOW(), 'Backup Refusal', NULL, NULL, CONCAT(@bank,'_BACKUP_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, NULL, NULL, NULL, @subIssuerID);

SET @profileBackupRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_BACKUP_REFUSAL'));
SET @profileAccept = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_ACCEPT'));
SET @profileDecline = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_DECLINE'));
SET @profileMobileApp = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_TA_01'));
SET @profilePWD_OTP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_PWD_OTP'));
SET @profilePWD_Unified = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_PASSWORD_UNIFIED_01'));
SET @profileOTP_Unified = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_SMS_UNIFIED_01'));
SET @profileOTPSmsNormal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_SMS_01'));
SET @profileDefaultRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_DEFAULT_REFUSAL'));



INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), 'BACKUP_REFUSAL', NULL, NULL, 'BACKUP_REFUSAL', @updateState,3, @profileBackupRefusal),
(@createdBy, NOW(), 'PWD_OTP (BACKUP)', NULL, NULL, 'PWD_OTP (BACKUP)', @updateState, 10, @profilePWD_OTP);

SET @ruleBackupRefusal = (SELECT `id` FROM `Rule` WHERE `name` = 'BACKUP_REFUSAL' AND `fk_id_profile` = @profileBackupRefusal);
SET @ruleAccept = (SELECT `id` FROM `Rule` WHERE `name` = 'NONE (ACCEPT)' AND `fk_id_profile` = @profileAccept);
SET @ruleDecline = (SELECT `id` FROM `Rule` WHERE `name` = 'REFUSAL (DECLINE)' AND `fk_id_profile` = @profileDecline);
SET @ruleMobileApp = (SELECT `id` FROM `Rule` WHERE `name` = 'MOBILE_APP(NORMAL)' AND `fk_id_profile` = @profileMobileApp);
SET @rulePWD_OTP = (SELECT `id` FROM `Rule` WHERE `name` = 'PWD_OTP (UNIFIED)' AND `fk_id_profile` = @profilePWD_OTP) ;
SET @rulePWD_Unified = (SELECT `id` FROM `Rule` WHERE `name` = 'PASSWORD (UNIFIED)' AND `fk_id_profile` = @profilePWD_Unified) ;
SET @ruleOTP_Unified = (SELECT `id` FROM `Rule` WHERE `name` = 'OTP_SMS (UNIFIED)' AND `fk_id_profile` = @profileOTP_Unified) ;
SET @ruleOTPSmsNormal = (SELECT `id` FROM `Rule` WHERE `name` = 'OTP_SMS (NORMAL)' AND `fk_id_profile` = @profileOTPSmsNormal ) ;
SET @ruleDefaultRefusal = (SELECT `id` FROM `Rule` WHERE `name` = 'DEFAULT_REFUSAL' AND `fk_id_profile` = @profileDefaultRefusal) ;

UPDATE `Rule` SET `orderRule` = 4 WHERE `id` = @ruleAccept;
UPDATE `Rule` SET `orderRule` = 5 WHERE `id` = @ruleDecline;
UPDATE `Rule` SET `orderRule` = 6 WHERE `id` = @ruleMobileApp;
UPDATE `Rule` SET `orderRule` = 7 WHERE `id` = @rulePWD_OTP;
UPDATE `Rule` SET `orderRule` = 8 WHERE `id` = @rulePWD_Unified;
UPDATE `Rule` SET `orderRule` = 9 WHERE `id` = @ruleOTP_Unified;
UPDATE `Rule` SET `orderRule` = 11 WHERE `id` = @ruleOTPSmsNormal;
UPDATE `Rule` SET `orderRule` = 12 WHERE `id` = @ruleDefaultRefusal;

SET @ruleBackupRefusal = (SELECT id FROM `Rule` WHERE `description` = 'BACKUP_REFUSAL' AND `fk_id_profile` = @profileBackupRefusal);
SET @rulePWD_OTPBackup = (SELECT id FROM `Rule` WHERE `description` = 'PWD_OTP (BACKUP)' AND `fk_id_profile` = @profilePWD_OTP);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_01_BACKUP_REFUSAL'), @updateState, @ruleBackupRefusal),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_01_PWD_OTP_BACKUP'), @updateState, @rulePWD_OTPBackup);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_BACKUP_REFUSAL')
  AND mps.`fk_id_authentMean` = @authMeanPWD_OTP
  AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_PWD_OTP_BACKUP')
  AND mps.`fk_id_authentMean` = @authMeanPWD_OTP
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_PWD_OTP_BACKUP')
  AND mps.`fk_id_authentMean` = @authMeanPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@bank,'_01_PWD_OTP_BACKUP')
  AND mps.`fk_id_authentMean`=@authMeanPWD_OTP AND (mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@bank,'_01_PWD_OTP_BACKUP')
  AND mps.`fk_id_authentMean`=@authMeanPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@bank,'_01_PWD_OTP_BACKUP')
  AND mps.`fk_id_authentMean`=@authMeanPWD_OTP AND (mps.`meansProcessStatusType`='PARENT_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@bank,'_01_PWD_OTP_BACKUP')
  AND mps.`fk_id_authentMean`=@authMeanPWD_OTP AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);



INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@bank,'_01_PWD_OTP_BACKUP')
  AND mps.`fk_id_authentMean`=@authMeanMobileApp
  AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=FALSE);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
WHERE ps.`name` = CONCAT('PS_', @bank, '_01') AND r.`id` IN (@ruleBackupRefusal, @rulePWD_OTPBackup);


