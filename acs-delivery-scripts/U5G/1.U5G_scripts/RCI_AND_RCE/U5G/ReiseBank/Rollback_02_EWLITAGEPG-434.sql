USE `U5G_ACS_BO`;


SET @activatedAuthMeans = '[ {
	"authentMeans" : "OTP_SMS",
	"validate" : true
}, {
	"authentMeans" : "REFUSAL",
	"validate" : true
} ,{
	"authentMeans" : "INFO",
	"validate" : true
}]';
SET @BankUB = '12000';
SET @issuerName = '10300';
SET @issuerCode = '10300';
SET @subIssuerCode = '12000';
SET @createdBy = 'W100851';
SET @subIssuerName = 'ReiseBank';
SET @updateState =	'PUSHED_TO_CONFIG';
SET @BankName = 'ReiseBank_LOGO';

START TRANSACTION;

UPDATE Issuer
SET availaibleAuthentMeans = 'OTP_SMS|REFUSAL|INFO'
WHERE code = @issuerCode
AND name = @issuerName;

SET @issuerId = (SELECT `id`
				 FROM `Issuer`
				 WHERE `code` = @issuerCode);


UPDATE SubIssuer
SET authentMeans = @activatedAuthMeans
WHERE fk_id_issuer = @issuerId
AND name = @subIssuerName;

SET @profileMobileApp = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_REISEBANK_MOBILE_APP_01'));
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @ruleMobileApp = (SELECT id FROM `Rule` WHERE `description` = 'MOBILE_APP_AVAILABLE_NORMAL' AND `fk_id_profile` = @profileMobileApp);
SET @RuleId = (SELECT  r.`id` FROM	`Rule` r WHERE	r.`id` = @ruleMobileApp);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerName);
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_12232_REISEBANK_SMS_01');
SET @authMeanMobileApp = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'MOBILE_APP');
SET @ruleConditionId = (SELECT id FROM `RuleCondition`	WHERE `name`= CONCAT('C1_P_',@BankUB,'_01_MOBILE_APP_NORMAL'));


DELETE FROM CustomItem WHERE fk_id_customItemSet = @customItemSetMobileApp;





DELETE FROM ProfileSet_Rule WHERE id_profileSet = @ProfileSet and id_rule = @RuleId;
DELETE FROM Condition_MeansProcessStatuses WHERE id_condition = @ruleConditionId;
DELETE FROM RuleCondition WHERE fk_id_rule = @RuleId;
DELETE FROM Rule WHERE fk_id_profile = @profileMobileApp;
DELETE FROM Profile WHERE name = CONCAT(@BankUB,'_REISEBANK_MOBILE_APP_01') AND fk_id_subIssuer = @subIssuerID AND fk_id_customItemSetCurrent = @customItemSetMobileApp;


DELETE FROM CustomItemSet WHERE name = CONCAT('customitemset_', @BankUB, '_MOBILE_APP') AND fk_id_subIssuer = @subIssuerID;

SET @pollingLayoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankUB, ')%') );
DELETE FROM CustomPageLayout WHERE id = @pollingLayoutId;
DELETE FROM CustomComponent WHERE fk_id_layout = @pollingLayoutId;

SET @idAppViewPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_APP_VIEW' and DESCRIPTION = 'TA_App_View (REISEBANK)') ;

DELETE FROM CustomComponent WHERE fk_id_layout = @idAppViewPage;
DELETE FROM CustomPageLayout WHERE description = 'TA_App_View (REISEBANK)';
DELETE FROM CustomPageLayout_ProfileSet WHERE customPageLayout_id = @idAppViewPage;
COMMIT ;