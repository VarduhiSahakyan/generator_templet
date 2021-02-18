use U5G_ACS_BO;

SET @createdBy ='A758582';
SET @BankUB = 'ReiseBank';
SET @issuerCode = '10300';
SET @subIssuerCode = '12000';

SET @updateState =  'PUSHED_TO_CONFIG';
SET @status = 'DEPLOYED_IN_PRODUCTION';
SET @activatedAuthMeans = '
[ {
  "authentMeans" : "OTP_SMS",
  "validate" : true
}, {
  "authentMeans" : "REFUSAL",
  "validate" : true
} ]';


SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @BankUB);

/* SubIssuer */
UPDATE `SubIssuer` SET `authentMeans` = @activatedAuthMeans WHERE `fk_id_issuer` = @issuerId AND `code` = @subIssuerCode;

/* CustomPageLayout_ProfileSet */
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_12232_REISEBANK_SMS_01');
SET @CustomPageLayoutID = (SELECT id FROM `CustomPageLayout` WHERE description = CONCAT('INFO Refusal Page (', @BankUB, ')'));
DELETE FROM `CustomPageLayout_ProfileSet` WHERE `profileSet_id`= @ProfileSet AND `customPageLayout_id` = @CustomPageLayoutID;

/* CustomComponent */
DELETE FROM `CustomComponent` WHERE `fk_id_layout` = @CustomPageLayoutID;

/* CustomPageLayout */
DELETE FROM `CustomPageLayout` WHERE `description` = CONCAT('INFO Refusal Page (', @BankUB, ')');

/* Condition_TransactionStatuses */
DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition` IN (SELECT c.id from RuleCondition c WHERE c.`name`=CONCAT('C1_P_', @subIssuerCode, '_01_MISSING_AUTHENTICATION_REFUSAL_', @BankUB));

/* Condition_MeansProcessStatuses */
DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` IN (SELECT c.id from RuleCondition c WHERE c.`name`=CONCAT('C1_P_', @subIssuerCode, '_01_MISSING_AUTHENTICATION_REFUSAL_', @BankUB));

/* RuleCondition */
SET @profileINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@subIssuerCode, '_', @BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));
SET @ruleINFOnormal = (SELECT id FROM `Rule` WHERE `description`='MISSING_AUTHENTICATION' AND `fk_id_profile`=@profileINFO);
DELETE FROM `RuleCondition` WHERE `fk_id_rule` = @ruleINFOnormal AND `name` = CONCAT('C1_P_', @subIssuerCode, '_01_MISSING_AUTHENTICATION_REFUSAL_', @BankUB);

/* ProfileSet_Rule */
DELETE FROM `ProfileSet_Rule` WHERE `id_rule` = @ruleINFOnormal;

/* Rule */
DELETE FROM `Rule` WHERE `fk_id_profile` = @profileINFO AND `description` = 'MISSING_AUTHENTICATION';

UPDATE   `Rule` SET `orderRule` = 40 WHERE `name` = 'OTP_SMS (NORMAL)' AND `description` = '12000_BASEPS_OTP_SMS_NORMAL_REISEBANK';
UPDATE   `Rule` SET `orderRule` = 99 WHERE `name` = 'REFUSAL (DEFAULT)' AND `description` = '12000_BASEPS_REFUSAL_DEFAULT_REISEBANK';

/* Profile */
SET @customItemSetINFORefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));
DELETE FROM `Profile` WHERE `fk_id_customItemSetCurrent` = @customItemSetINFORefusal AND `description` = 'INFO';

/* CustomItem */
DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` = @customItemSetINFORefusal;

/* CustomItemSet */
DELETE FROM `CustomItemSet` WHERE `fk_id_subIssuer` = @subIssuerID AND `name` = CONCAT('customitemset_', @subIssuerCode, '_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL');
