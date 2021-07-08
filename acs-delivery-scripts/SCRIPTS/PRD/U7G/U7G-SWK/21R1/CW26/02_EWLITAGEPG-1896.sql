USE `U7G_ACS_BO`;

SET @createdBy = 'W100851';
SET @updateState =	'PUSHED_TO_CONFIG';
SET @issuerCode = '41001';
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanREFUSAL = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`	WHERE `name` = 'MOBILE_APP');

SET @subIssuerNameAndLabel = 'Swisskey AG';
SET @subIssuerCode = '41001';
SET @BankUB = 'SWISSKEY';


SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);


SET @status = 'DEPLOYED_IN_PRODUCTION';

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
						`updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
						`fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
						`fk_id_subIssuer`) VALUES
(@createdBy, NOW(), 'REFUSAL', NULL, NULL, CONCAT(@BankUB,'_BACKUP_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$',@authMeanREFUSAL, NULL, NULL, NULL, @subIssuerID);

SET @profileBackupINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_BACKUP_REFUSAL'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					`updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), 'OTP_SMS_EXT (BACKUP)', NULL, NULL, 'OTP_SMS_EXT (BACKUP)', @updateState, 11, @profileSMS),
(@createdBy, NOW(), 'BACKUP_REFUSAL', NULL, NULL, 'BACKUP_REFUSAL', @updateState,3, @profileBackupINFO);

SET @profileACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profileDECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profileTA_01 = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_TA_01'));
SET @profilePASSWORD = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_Override'));
SET @profileOTP_PWD = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_OTP_PWD'));
SET @profileSMSOVER = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_Override'));
SET @profileSMS_01 = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @profileUNDEFINED = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_UNDEFINED_01'));
SET @profileDEFAULT_REFUSAL = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL'));



UPDATE Rule SET orderRule = 4 WHERE fk_id_profile = @profileACCEPT;
UPDATE Rule SET orderRule = 5 WHERE fk_id_profile = @profileDECLINE;
UPDATE Rule SET orderRule = 6 WHERE fk_id_profile = @profileTA_01;
UPDATE Rule SET orderRule = 7 WHERE fk_id_profile = @profilePASSWORD;
UPDATE Rule SET orderRule = 8 WHERE fk_id_profile = @profileOTP_PWD;
UPDATE Rule SET orderRule = 9 WHERE fk_id_profile = @profileSMSOVER;
UPDATE Rule SET orderRule = 10 WHERE fk_id_profile = @profileSMS_01 and `name` = 'OTP_SMS_EXT (FALLBACK)';
UPDATE Rule SET orderRule = 12 WHERE fk_id_profile = @profileUNDEFINED;
UPDATE Rule SET orderRule = 13 WHERE fk_id_profile = @profileDEFAULT_REFUSAL;


SET @ruleBackupInfo = (SELECT id FROM `Rule` WHERE `description` = 'BACKUP_REFUSAL' AND `fk_id_profile` = @profileBackupINFO);
SET @ruleSMSBackUP = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (BACKUP)' AND `fk_id_profile` = @profileSMS);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_BACKUP'), @updateState, @ruleSMSBackUP),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP'), @updateState, @ruleSMSBackUP),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_BACKUP_REFUSAL'), @updateState, @ruleBackupInfo);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_BACKUP_REFUSAL')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = FALSE);




-- BACKUP --

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authentMeansMobileApp
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authentMeansMobileApp
AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authentMeansMobileApp
AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authentMeansMobileApp
AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authentMeansMobileApp
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed` = FALSE);



INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@ruleSMSBackUP,@ruleBackupInfo);