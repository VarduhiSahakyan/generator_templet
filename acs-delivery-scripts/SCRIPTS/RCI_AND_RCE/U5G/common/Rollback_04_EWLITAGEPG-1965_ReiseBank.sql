USE U5G_ACS_BO;

SET @createdBy = 'A757435';
SET @updateState =  'PUSHED_TO_CONFIG';
SET @status = 'DEPLOYED_IN_PRODUCTION';
SET @subIssuerID = (SELECT `id` FROM `SubIssuer` WHERE `code` = 12000);
SET @bank = '12000_REISEBANK';

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanMobileApp = (SELECT id FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP');

SET @profileBackupRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_BACKUP_REFUSAL'));
SET @profileMobileApp = (SELECT id FROM `Profile` WHERE `name` = '12000_REISEBANK_MOBILE_APP_01');
SET @profileOTPSms = (SELECT id FROM `Profile` WHERE `name` = '12000_REISEBANK_SMS_01');
SET @profileUndefined = (SELECT id FROM `Profile` WHERE `name` = '12000_UNDEFINED_01');
SET @profileDefaultRefusal = (SELECT id FROM `Profile` WHERE `name` = '12000_REISEBANK_DEFAULT_REFUSAL');

SET @ruleMobileApp = (SELECT `id` FROM `Rule` WHERE `name` = 'MOBILE_APP(NORMAL)' AND `fk_id_profile` = @profileMobileApp);
SET @ruleOTPSms = (SELECT `id` FROM `Rule` WHERE `name` = 'OTP_SMS (FALLBACK)' AND `fk_id_profile` = @profileOTPSms) ;
SET @ruleUndefined = (SELECT `id` FROM `Rule` WHERE `name` = 'UNDEFINED' AND `fk_id_profile` = @profileUndefined ) ;
SET @ruleDefaultRefusal = (SELECT `id` FROM `Rule` WHERE `name` = 'DEFAULT_REFUSAL' AND `fk_id_profile` = @profileDefaultRefusal) ;
SET @ruleBackupRefusal = (SELECT id FROM `Rule` WHERE `description` = 'BACKUP_REFUSAL' AND `fk_id_profile` = @profileBackupRefusal);

SET @ruleConditionBackupRefusal = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @bank, '_01_BACKUP_REFUSAL'));


SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM ProfileSet_Rule where `id_rule` in (@ruleBackupRefusal);

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` in (@ruleConditionBackupRefusal);

DELETE FROM `RuleCondition` WHERE `id` in (@ruleConditionBackupRefusal);

DELETE FROM `Rule` WHERE `id` in (@ruleBackupRefusal);


UPDATE `Rule` SET `orderRule` = 3 WHERE `id` = @ruleMobileApp;
UPDATE `Rule` SET `orderRule` = 4 WHERE `id` = @ruleOTPSms;
UPDATE `Rule` SET `orderRule` = 5 WHERE `id` = @ruleUndefined;
UPDATE `Rule` SET `orderRule` = 6 WHERE `id` = @ruleDefaultRefusal;

DELETE FROM `Profile` WHERE `id` = @profileBackupRefusal;


SET FOREIGN_KEY_CHECKS = 1;



