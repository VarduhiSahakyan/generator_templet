USE `U7G_ACS_BO`;
SET @issuerCode = '41001';

SET @createdBy = 'W100851';
SET @updateState =	'PUSHED_TO_CONFIG';
SET @BankUB = 'SWISSKEY';

SET @subIssuerNameAndLabel = 'Swisskey AG';
SET @subIssuerCode = '41001';

SET @profileBackupINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_BACKUP_REFUSAL'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @ruleBackupInfo = (SELECT id FROM `Rule` WHERE `description` = 'BACKUP_REFUSAL' AND `fk_id_profile` = @profileBackupINFO);
SET @ruleSMSBackUP = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (BACKUP)' AND `fk_id_profile` = @profileSMS);

SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

DELETE FROM ProfileSet_Rule WHERE `id_rule` in (@ruleBackupInfo,@ruleSMSBackUP);


DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @BankUB, '_01_BACKUP_REFUSAL'));
DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_BACKUP'));
DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP'));

DELETE FROM RuleCondition WHERE	 name = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_BACKUP') AND fk_id_rule = @ruleSMSBackUP;
DELETE FROM RuleCondition WHERE	 name = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP') AND fk_id_rule = @ruleSMSBackUP;
DELETE FROM RuleCondition WHERE	 name = CONCAT('C1_P_', @BankUB, '_01_BACKUP_REFUSAL') AND fk_id_rule = @ruleBackupInfo;

DELETE FROM Rule WHERE id in (@ruleBackupInfo,@ruleSMSBackUP);

DELETE FROM Profile WHERE fk_id_subIssuer = @subIssuerID AND name =	 CONCAT(@BankUB,'_BACKUP_REFUSAL');


SET @profileACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profileDECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profileTA_01 = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_TA_01'));
SET @profileOTP_PWD = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_OTP_PWD'));
SET @profilePASSWORD = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_Override'));
SET @profileSMSOVER = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_Override'));
SET @profileSMS_01 = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @profileUNDEFINED = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_UNDEFINED_01'));
SET @profileDEFAULT_REFUSAL = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL'));



UPDATE Rule SET orderRule = 3 WHERE fk_id_profile = @profileACCEPT;
UPDATE Rule SET orderRule = 4 WHERE fk_id_profile = @profileDECLINE;
UPDATE Rule SET orderRule = 5 WHERE fk_id_profile = @profileTA_01;
UPDATE Rule SET orderRule = 6 WHERE fk_id_profile = @profileOTP_PWD;
UPDATE Rule SET orderRule = 7 WHERE fk_id_profile = @profilePASSWORD;
UPDATE Rule SET orderRule = 8 WHERE fk_id_profile = @profileSMSOVER;
UPDATE Rule SET orderRule = 9 WHERE fk_id_profile = @profileSMS_01;
UPDATE Rule SET orderRule =10 WHERE fk_id_profile = @profileUNDEFINED;
UPDATE Rule SET orderRule = 11 WHERE fk_id_profile = @profileDEFAULT_REFUSAL;



