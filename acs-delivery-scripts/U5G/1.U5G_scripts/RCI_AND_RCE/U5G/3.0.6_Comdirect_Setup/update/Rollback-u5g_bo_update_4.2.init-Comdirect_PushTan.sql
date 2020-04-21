USE `U5G_ACS_BO`;
START TRANSACTION;

SET @issuerCode = '16600';
SET @subIssuerCode = '16600';
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);
SET @currentAuthentMean = 'MOBILE_APP_EXT';
SET @pollingPageCustomPageLayoutDesc = 'Polling Page (Comdirect)';
SET @customItemSetID = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_APP_1'));
SET @profileNameApp = 'COMDIRECT_APP_01';
SET @profileID = (SELECT id FROM `Profile` WHERE `name` = @profileNameApp and fk_id_subIssuer = @subIssuerID);
SET @profileSetID = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_Comdirect_01');
SET @ruleID = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT OTP_APP (NORMAL)' AND fk_id_profile = @profileID);
SET @ruleConditionName = 'C1_COMDIRECT_OTP_APP_NORMAL';
SET @ruleConditionID = (SELECT id FROM  `RuleCondition` WHERE name = @ruleConditionName AND fk_id_rule =  @ruleID);
SET @profileIDs = (SELECT group_concat(id)
					 FROM `Profile`
					 WHERE name IN ('16600_COMDIRECT_FRAUD_REFUSAL', '16600_COMDIRECT_RBA_ACCEPT',
									'16600_COMDIRECT_RBA_REFUSAL', '16600_COMDIRECT_PHOTOTAN_01',
									'16600_COMDIRECT_SMS_01', @profileNameApp,
									'16600_COMDIRECT_ITAN_01', '16600_COMDIRECT_PHOTOTAN_02',
									'16600_COMDIRECT_SMS_02', '16600_COMDIRECT_ITAN_02',
									'16600_COMDIRECT_DEFAULT_REFUSAL'));
SET @shiftOrder = 6;
SET @customPageLayoutID = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'POLLING_PAGE' AND description = @pollingPageCustomPageLayoutDesc) ;
SET @issuerID = (SELECT id FROM `Issuer` WHERE `code` = @issuerCode);
SET @availableAuthMeans = 'OTP_SMS_EXT_MESSAGE|PHOTO_TAN|I_TAN|REFUSAL';
SET @activatedAuthMeans =
'[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
}, {
  "authentMeans" : "PHOTO_TAN",
  "validate" : true
}, {
  "authentMeans" : "I_TAN",
  "validate" : true
} ]';

DELETE FROM CustomItem WHERE fk_id_customItemSet  = @customItemSetID;
DELETE FROM `ProfileSet_Rule` WHERE id_profileSet = @profileSetID AND id_rule = @ruleID;
DELETE FROM `Condition_TransactionStatuses` WHERE id_condition = @ruleConditionID;
DELETE FROM `Condition_MeansProcessStatuses` WHERE id_condition = @ruleConditionID;
DELETE FROM  `RuleCondition` WHERE id = @ruleConditionID;
DELETE FROM `Rule` WHERE id = @ruleID;

UPDATE `Rule` SET orderRule = orderRule - 1 WHERE orderRule >= @shiftOrder AND find_in_set(fk_id_profile, @profileIDs) ORDER BY orderRule;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `Profile` WHERE id = @profileID;
SET FOREIGN_KEY_CHECKS = 1;

DELETE FROM `CustomItemSet` WHERE id = @customItemSetID;
DELETE FROM `CustomComponent` WHERE `fk_id_layout` = @customPageLayoutID;
DELETE FROM `CustomPageLayout_ProfileSet` WHERE customPageLayout_id = @customPageLayoutID AND profileSet_id= @profileSetID;
DELETE FROM `CustomPageLayout` WHERE id = @customPageLayoutID;

UPDATE `Issuer` SET `availaibleAuthentMeans`=  @availableAuthMeans WHERE id = @issuerID;
UPDATE `SubIssuer` SET `authentMeans` = @activatedAuthMeans WHERE code = @subIssuerCode AND fk_id_issuer  = @issuerID;

COMMIT;
