USE `U7G_ACS_BO`;

SET @BankB = 'SWISSKEY';
SET @BankUB = 'GRKB';
SET @subIssuerCode = '77400';
SET @subIssuerNameAndLabel = 'Graubündner Kantonalbank';

START TRANSACTION;
SET FOREIGN_KEY_CHECKS = 0;

-- delete from CustomItem
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @currentPageType = 'POLLING_PAGE';
SET @currentAuthentMean = 'MOBILE_APP';
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
DELETE FROM CustomItem WHERE  `name` = CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10')
						AND `fk_id_customItemSet` = @customItemSetMobileApp;

-- update SubIssuer
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
SET @activatedAuthMeans = '[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP",
  "validate" : true
}, {
  "authentMeans" : "INFO",
  "validate" : true
}, {
  "authentMeans" : "UNDEFINED",
  "validate" : false
} ]';
UPDATE `SubIssuer` SET `authentMeans` = @activatedAuthMeans, `userChoiceAllowed` = FALSE WHERE `id` = @subIssuerID;


SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'MOBILE_APP');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanUNDEFINED = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');

SET @profileMOBILEAPP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_APP_01'));
SET @profileUNDEFINED = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_UNDEFINED_01'));
SET @profileDefaultRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));

SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (FALLBACK)' AND `fk_id_profile` = @profileSMS);
SET @ruleUNDEFINED = (SELECT id FROM `Rule` WHERE `description`='UNDEFINED' AND `fk_id_profile`=@profileUNDEFINED);

SET @idConditionUndefined = (SELECT id FROM `RuleCondition` WHERE `name`= CONCAT('C1_P_',@BankUB,'_01_UNDEFINED'));
SET @idConditionOTPSMSEXT = (SELECT id FROM `RuleCondition` WHERE `name`= CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_FALLBACK'));
SET @idConditionOTPAPPNORMAL = (SELECT id FROM `RuleCondition` WHERE `name`= CONCAT('C1_P_', @BankUB, '_01_OTP_OTP_TA_NORMAL'));

SET @idMeansProcessStatuses1 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanUNDEFINED AND (`meansProcessStatusType`='MEANS_AVAILABLE' AND `reversed`=FALSE));
SET @idMeansProcessStatuses2 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_AVAILABLE' AND `reversed`=FALSE));
SET @idMeansProcessStatuses3 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_DISABLED' AND `reversed`=TRUE));
SET @idMeansProcessStatuses4 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authentMeansMobileApp AND (`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND `reversed`=FALSE));
SET @idMeansProcessStatuses5 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanOTPsms AND (`meansProcessStatusType`='MEANS_AVAILABLE' AND `reversed`=FALSE));
SET @idMeansProcessStatuses6 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanOTPsms AND (`meansProcessStatusType`='MEANS_DISABLED' AND `reversed`=TRUE));
SET @idMeansProcessStatuses7 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanOTPsms AND (`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND `reversed`=FALSE));

SET @idMeansProcessStatuses8 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanOTPsms AND (`meansProcessStatusType`='MEANS_AVAILABLE' AND `reversed` = FALSE));
SET @idMeansProcessStatuses9 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanOTPsms AND (`meansProcessStatusType`='MEANS_DISABLED' AND `reversed` = TRUE));
SET @idMeansProcessStatuses10 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanOTPsms AND (`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND `reversed` = FALSE));
SET @idMeansProcessStatuses11 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authentMeansMobileApp AND (`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND `reversed` = FALSE));

SET @idMeansProcessStatuses12 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authentMeansMobileApp AND (`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND `reversed` = TRUE));

-- delete from Condition_MeansProcessStatuses
DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = @idConditionUndefined
											 AND `id_meansProcessStatuses` in (@idMeansProcessStatuses1, @idMeansProcessStatuses2, @idMeansProcessStatuses3, @idMeansProcessStatuses4, @idMeansProcessStatuses5, @idMeansProcessStatuses6, @idMeansProcessStatuses7);
DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = @idConditionOTPSMSEXT
											 AND `id_meansProcessStatuses` in (@idMeansProcessStatuses8, @idMeansProcessStatuses9, @idMeansProcessStatuses10, @idMeansProcessStatuses11);
DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = @idConditionOTPAPPNORMAL
											 AND `id_meansProcessStatuses` in (@idMeansProcessStatuses12);

-- delete from RuleCondition
DELETE FROM `RuleCondition` WHERE (`name` = CONCAT('C1_P_', @BankUB, '_01_UNDEFINED') AND `fk_id_rule` = @ruleUNDEFINED)
							  or  (`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_FALLBACK') AND `fk_id_rule` = @ruleSMSnormal);

-- delete from ProfileSet_Rule
SET @idProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));
DELETE FROM `ProfileSet_Rule` WHERE `id_profileSet` = @idProfileSet
								AND `id_rule` = @ruleUNDEFINED;
-- delete and update Rule
DELETE FROM `Rule` WHERE `description` = 'UNDEFINED' AND `fk_id_profile` = @profileUNDEFINED;

UPDATE `Rule` SET `orderRule` = 7
WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileDefaultRefusal;

-- delete from Profile
DELETE FROM `Profile` WHERE `description` = 'UNDEFINED' AND `name` = CONCAT(@BankUB,'_UNDEFINED_01') AND `fk_id_subIssuer` =  @subIssuerID;


SET FOREIGN_KEY_CHECKS = 1;
COMMIT;