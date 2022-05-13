USE U5G_ACS_BO;

SET @BankUB = '16500';
SET @subIssuerID = (SELECT id FROM SubIssuer WHERE name = 'ING' AND code = 16500);
SET @defaultRefusal = (SELECT id FROM Profile WHERE name = '16500_REFUSAL_01' AND fk_id_subIssuer = @subIssuerID);
SET @profileACCEPTMAINT = (SELECT id FROM `Profile` WHERE `name` = CONCAT('16500_ACCEPT'));
SET @ruleAcceptMaint = (SELECT id FROM `Rule` WHERE `name` = 'ACCEPT MAINT' AND `fk_id_profile` = @profileACCEPTMAINT);
SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE name = CONCAT('C1_P_', @BankUB, '_01_ACCEPT') AND fk_id_rule = @ruleAcceptMaint);
SET @issuerID = (SELECT id FROM Issuer WHERE name = 'ING' AND code = 16500);


DELETE FROM ProfileSet_Rule WHERE id_rule = @ruleAcceptMaint;
DELETE FROM Condition_MeansProcessStatuses WHERE id_condition = @ruleConditionId;
DELETE FROM  RuleCondition WHERE name = CONCAT('C1_P_', @BankUB, '_01_ACCEPT') AND fk_id_rule = @ruleAcceptMaint;
DELETE FROM Rule WHERE description = '16500_ACCEPT_MAINTANCE_NORMAL' AND fk_id_profile = @profileACCEPTMAINT;

UPDATE Rule SET orderRule = 9 WHERE name = 'REFUSAL (DEFAULT)' and fk_id_profile = @defaultRefusal;


SET @availableAuthMean = 'MOBILE_APP_EXT|PHOTO_TAN|OTP_SMS_EXT_MESSAGE|I_TAN|REFUSAL|UNDEFINED|EXT_PASSWORD';

UPDATE Issuer SET availaibleAuthentMeans = @availableAuthMean WHERE id = @issuerID;

SET @subissuerAuthMean = '[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "UNDEFINED",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP_EXT",
  "validate" : true
}, {
  "authentMeans" : "PHOTO_TAN",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
}, {
  "authentMeans" : "I_TAN",
  "validate" : true
}, {
  "authentMeans" : "EXT_PASSWORD",
  "validate" : true
} ]';

UPDATE SubIssuer SET authentMeans = @subissuerAuthMean WHERE fk_id_issuer = @subIssuerID;