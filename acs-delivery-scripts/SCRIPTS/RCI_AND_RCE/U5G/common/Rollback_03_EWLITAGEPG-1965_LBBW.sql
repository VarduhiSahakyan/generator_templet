USE U5G_ACS_BO;

SET @createdBy = 'A757435';
SET @updateState =  'PUSHED_TO_CONFIG';
SET @status = 'DEPLOYED_IN_PRODUCTION';
SET @subIssuerID = (SELECT `id` FROM `SubIssuer` WHERE `code` = 19550);
SET @bank = 'LBBW';

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanMobileApp = (SELECT id FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP');
SET @authMeanPWD_OTP = (SELECT id FROM `AuthentMeans` WHERE `name` = 'PWD_OTP');


SET @profileBackupRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_BACKUP_REFUSAL'));
SET @profileAccept = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_ACCEPT'));
SET @profileDecline = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_DECLINE'));
SET @profileMobileApp = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_TA_01'));
SET @profilePWD_OTP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_PWD_OTP'));
SET @profilePWD_Unified = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_PASSWORD_UNIFIED_01'));
SET @profileOTP_Unified = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_SMS_UNIFIED_01'));
SET @profileOTPSmsNormal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_SMS_01'));
SET @profileDefaultRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_DEFAULT_REFUSAL'));

SET @ruleBackupRefusal = (SELECT `id` FROM `Rule` WHERE `name` = 'BACKUP_REFUSAL' AND `fk_id_profile` = @profileBackupRefusal);
SET @ruleAccept = (SELECT `id` FROM `Rule` WHERE `name` = 'NONE (ACCEPT)' AND `fk_id_profile` = @profileAccept);
SET @ruleDecline = (SELECT `id` FROM `Rule` WHERE `name` = 'REFUSAL (DECLINE)' AND `fk_id_profile` = @profileDecline);
SET @ruleMobileApp = (SELECT `id` FROM `Rule` WHERE `name` = 'MOBILE_APP(NORMAL)' AND `fk_id_profile` = @profileMobileApp);
SET @rulePWD_OTP = (SELECT `id` FROM `Rule` WHERE `name` = 'PWD_OTP (UNIFIED)' AND `fk_id_profile` = @profilePWD_OTP) ;
SET @rulePWD_Unified = (SELECT `id` FROM `Rule` WHERE `name` = 'PASSWORD (UNIFIED)' AND `fk_id_profile` = @profilePWD_Unified) ;
SET @ruleOTP_Unified = (SELECT `id` FROM `Rule` WHERE `name` = 'OTP_SMS (UNIFIED)' AND `fk_id_profile` = @profileOTP_Unified) ;
SET @ruleOTPSmsNormal = (SELECT `id` FROM `Rule` WHERE `name` = 'OTP_SMS (NORMAL)' AND `fk_id_profile` = @profileOTPSmsNormal ) ;
SET @ruleDefaultRefusal = (SELECT `id` FROM `Rule` WHERE `name` = 'DEFAULT_REFUSAL' AND `fk_id_profile` = @profileDefaultRefusal) ;

SET @ruleBackupRefusal = (SELECT id FROM `Rule` WHERE `description` = 'BACKUP_REFUSAL' AND `fk_id_profile` = @profileBackupRefusal);
SET @rulePWD_OTPBackup = (SELECT id FROM `Rule` WHERE `description` = 'PWD_OTP (BACKUP)' AND `fk_id_profile` = @profilePWD_OTP);

SET @ruleConditionBackupRefusal = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @bank, '_01_BACKUP_REFUSAL'));
SET @ruleConditionPWD_OTPBackup = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @bank, '_01_PWD_OTP_BACKUP'));
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM ProfileSet_Rule where `id_rule` in (@ruleBackupRefusal,@rulePWD_OTPBackup);

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` in (@ruleConditionBackupRefusal, @ruleConditionPWD_OTPBackup);

DELETE FROM `RuleCondition` WHERE `id` in (@ruleConditionBackupRefusal, @ruleConditionPWD_OTPBackup);

DELETE FROM `Rule` WHERE `id` in (@ruleBackupRefusal, @rulePWD_OTPBackup);

UPDATE `Rule` SET `orderRule` = 3 WHERE `id` = @ruleAccept;
UPDATE `Rule` SET `orderRule` = 4 WHERE `id` = @ruleDecline;
UPDATE `Rule` SET `orderRule` = 5 WHERE `id` = @ruleMobileApp;
UPDATE `Rule` SET `orderRule` = 6 WHERE `id` = @rulePWD_OTP;
UPDATE `Rule` SET `orderRule` = 7 WHERE `id` = @rulePWD_Unified;
UPDATE `Rule` SET `orderRule` = 8 WHERE `id` = @ruleOTP_Unified;
UPDATE `Rule` SET `orderRule` = 9 WHERE `id` = @ruleOTPSmsNormal;
UPDATE `Rule` SET `orderRule` = 10 WHERE `id` = @ruleDefaultRefusal;

DELETE FROM `Profile` WHERE `id` = @profileBackupRefusal;


SET FOREIGN_KEY_CHECKS = 1;




