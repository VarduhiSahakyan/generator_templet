USE U5G_ACS_BO;

SET @avalableAuthMean =
		'INFO|OTP_SMS|MOBILE_APP|PASSWORD|REFUSAL|UNDEFINED|MOBILE_APP_EXT|OTP_SMS_EXT_MESSAGE|KBA';
SET @issuerCode = '18500';
SET @isuerName = 'Postbank';

UPDATE Issuer
SET availaibleAuthentMeans = @avalableAuthMean
where code = @issuerCode
	AND name = @isuerName;


SET @issuerId = (SELECT `id`
				 FROM `Issuer`
				 WHERE `code` = @issuerCode);

SET @subissuerAuthMeans = '[ {
	"authentMeans" : "OTP_SMS",
	"validate" : false
}, {
	"authentMeans" : "REFUSAL",
	"validate" : true
}, {
	"authentMeans" : "UNDEFINED",
	"validate" : true
}, {
	"authentMeans" : "MOBILE_APP_EXT",
	"validate" : true
}, {
	"authentMeans" : "INFO",
	"validate" : true
}, {
	"authentMeans" : "MOBILE_APP",
	"validate" : false
}, {
	"authentMeans" : "OTP_SMS_EXT_MESSAGE",
	"validate" : true
}, {
	"authentMeans" : "STRONG_PASSWORD",
	"validate" : false
}, {
	"authentMeans" : "KBA",
	"validate" : true
} ]';
SET @subissuerCode = '18501';

SET @subissuerId = (SELECT `id`
					FROM SubIssuer
					WHERE `code` = @subissuerCode
					  AND `fk_id_issuer` = @issuerId);

UPDATE SubIssuer
	SET `authentMeans` = @subissuerAuthMeans
	WHERE `id` = @subissuerId;

SET @autMeanKBA = (SELECT id FROM AuthentMeans WHERE name ='KBA');

SET @profileId = (SELECT `id` FROM Profile WHERE `name` = '18501_PB_LOGIN_01' AND `description` = '18501_EXT LOGIN (NORMAL)');

UPDATE Profile SET `fk_id_AuthentMeans` = @autMeanKBA WHERE `id` = @profileId;


SET @ruleConditionIdMeansChoice = (SELECT `id` FROM RuleCondition WHERE `name` = 'C1_P_18501_PB_01_MEANS_CHOICE_NORMAL');
SET @ruleConditionIdStrongKBA = (SELECT `id` FROM RuleCondition WHERE `name` = 'C1_P_18501_PB_01_LOGIN_NORMAL');
SET @ruleConditionIdBestSign = (SELECT `id` FROM RuleCondition WHERE `name` = 'C1_P_18501_PB_01_BESTSIGN_NORMAL');
SET @ruleConditionIdOTPSMS = (SELECT `id` FROM RuleCondition WHERE `name` = 'C1_P_18501_PB_01_OTP_SMS_NORMAL');
SET @ruleConditionIdMissingAuthent = (SELECT `id` FROM RuleCondition WHERE `name` = 'C1_P_18501_PB_01_MISSING_AUTHENTMEAN');

SET @authMeanPassword = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'STRONG_KBA');
SET @newAuthMeanPassword = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'KBA');

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);
UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionIdMeansChoice ;


SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);
UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionIdStrongKBA ;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);
UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionIdStrongKBA ;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);
UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionIdStrongKBA ;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionIdStrongKBA ;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=TRUE);
UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionIdStrongKBA;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND mps.`reversed`=TRUE);
UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionIdStrongKBA;


SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);
UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionIdBestSign ;


SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);
UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionIdOTPSMS ;


SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);
UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionIdMissingAuthent ;

SET @profileSetId = (SELECT id
				FROM ProfileSet
				WHERE fk_id_subIssuer = @subissuerId);

UPDATE CustomPageLayout SET pageType = REPLACE(
		pageType,
		'STRONG_KBA_OTP_FORM_PAGE',
		'KBA_OTP_FORM_PAGE') WHERE id IN(SELECT customPageLayout_id FROM CustomPageLayout_ProfileSet WHERE profileSet_id = @profileSetId);


SET @authMeanId = (SELECT id FROM AuthentMeans WHERE name = 'STRONG_KBA');
DELETE FROM MeansProcessStatuses WHERE fk_id_authentMean = @authMeanId;
DELETE FROM AuthentMeans WHERE name = 'STRONG_KBA';