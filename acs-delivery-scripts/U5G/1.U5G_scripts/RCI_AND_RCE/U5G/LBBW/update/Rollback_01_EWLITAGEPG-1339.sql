USE U5G_ACS_BO;

SET @BankUB = 'LBBW';
SET @BankB = 'Landesbank Baden-Württemberg';

SET @activatedAuthMeans = '[ {
  "authentMeans" : "OTP_SMS",
  "validate" : true
}, {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP",
  "validate" : true
}, {
  "authentMeans" : "INFO",
  "validate" : true
} ]';

SET @availableAuthMeans = 'OTP_SMS|REFUSAL|MOBILE_APP|INFO';

SET @issuerCode = '19550';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);

update Issuer set availaibleAuthentMeans = @availableAuthMeans where id = @issuerId;

SET @subIssuerCode = '19550';
SET @subIssuerNameAndLabel = 'Landesbank Baden-Württemberg';
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

update SubIssuer set authentMeans = @activatedAuthMeans where id = @subIssuerID;

SET @customPageLayoutPassword = (select id from CustomPageLayout where description = 'Password OTP Form Page for Landesbank Baden-Württemberg');
SET @customPageLayoutSMS = (select id from CustomPageLayout where description = 'SMS OTP Form Page (PWD+SMS) for Landesbank Baden-Württemberg');

delete from CustomPageLayout_ProfileSet where customPageLayout_id = @customPageLayoutPassword;
delete from CustomPageLayout_ProfileSet where customPageLayout_id = @customPageLayoutSMS;

delete from CustomComponent where  fk_id_layout = @customPageLayoutPassword;
delete from CustomComponent where  fk_id_layout = @customPageLayoutSMS;

delete from CustomPageLayout where id = @customPageLayoutPassword;
delete from CustomPageLayout where id = @customPageLayoutSMS;

SET @ruleConditionPWD_OTP = (SELECT id FROM RuleCondition where name = 'C1_P_LBBW_01_PWD_OTP_UNIFIED');
SET @ruleConditionPassword = (SELECT id FROM RuleCondition where name = 'C1_P_LBBW_01_PASSWORD_UNIFIED');
SET @ruleConditionSMS = (SELECT id FROM RuleCondition where name = 'C1_P_LBBW_01_OTP_SMS_UNIFIED');

delete from Condition_TransactionStatuses where id_condition = @ruleConditionPWD_OTP or id_condition = @ruleConditionPassword or id_condition = @ruleConditionSMS;
delete from Condition_MeansProcessStatuses where id_condition = @ruleConditionPWD_OTP or id_condition = @ruleConditionPassword or id_condition = @ruleConditionSMS;

delete from Thresholds where fk_id_condition = @ruleConditionPWD_OTP;

delete from RuleCondition where id = @ruleConditionPWD_OTP or id = @ruleConditionPassword or id = @ruleConditionSMS;

SET @profilePasswordOTP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PWD_OTP'));
SET @profilePassword = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_UNIFIED_01'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_UNIFIED_01'));

SET @rulePassword = (SELECT id FROM Rule WHERE fk_id_profile = @profilePassword);
SET @rulePasswordOTP = (SELECT id FROM Rule WHERE fk_id_profile = @profilePasswordOTP);
SET @ruleSMS = (SELECT id FROM Rule WHERE fk_id_profile = @profileSMS);

delete from ProfileSet_Rule where id_rule in (@rulePassword, @rulePasswordOTP, @ruleSMS);

delete from Rule where id in (@rulePassword, @rulePasswordOTP, @ruleSMS);

delete from Profile where name = 'LBBW_PWD_OTP' or name = 'LBBW_PASSWORD_UNIFIED_01' or name = 'LBBW_SMS_UNIFIED_01';

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD_UNIFIED'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_OTP_SMS_UNIFIED'));

delete from CustomItem where fk_id_customItemSet = @customItemSetPassword;
delete from CustomItem where fk_id_customItemSet = @customItemSetSMS;

delete from CustomItemSet where id = @customItemSetPassword;
delete from CustomItemSet where id = @customItemSetSMS;






