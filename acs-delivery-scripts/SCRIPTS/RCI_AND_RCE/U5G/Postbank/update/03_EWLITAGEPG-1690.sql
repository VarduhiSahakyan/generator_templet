USE U5G_ACS_BO;
INSERT INTO AuthentMeans (createdBy, creationDate, description, lastUpdateBy, lastUpdateDate, name, updateState)
SELECT 'InitPhase', sysdate(), 'STRONG_KBA', NULL, NULL, 'STRONG_KBA', 'PUSHED_TO_CONFIG'
FROM dual
WHERE NOT EXISTS(SELECT id FROM AuthentMeans where name = 'STRONG_KBA');

/* !40000 ALTER TABLE MeansProcessStatuses DISABLE KEYS ; */
-- create the missing entries in MeansProcessStatuses

INSERT INTO MeansProcessStatuses (meansProcessStatusType, reversed, fk_id_authentMean)
SELECT *
FROM (SELECT DISTINCT(meansProcessStatusType) as stat FROM MeansProcessStatuses) as mp,
		(SELECT flag
		from (SELECT 0 as flag UNION SELECT 1) as temp) as b,
		(SELECT a.id as aid FROM AuthentMeans a where a.name in ('STRONG_KBA')) as c
WHERE NOT EXISTS(SELECT id
					FROM MeansProcessStatuses
					WHERE meansProcessStatusType = mp.stat
					AND b.flag = reversed
					and aid = fk_id_authentMean);


SET @avalableAuthMean =
		'INFO|OTP_SMS|MOBILE_APP|STRONG_PASSWORD|REFUSAL|UNDEFINED|MOBILE_APP_EXT|OTP_SMS_EXT_MESSAGE|STRONG_KBA';
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
  "authentMeans" : "STRONG_KBA",
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

SET @autMeanStrongKBA = (SELECT id FROM AuthentMeans WHERE name ='STRONG_KBA');

SET @profileId = (SELECT `id` FROM Profile WHERE `name` = '18501_PB_LOGIN_01' AND `description` = '18501_EXT LOGIN (NORMAL)');

UPDATE Profile SET `fk_id_AuthentMeans` = @autMeanStrongKBA WHERE `id` = @profileId;

SET @ruleConditionIdMeansChoice = (SELECT `id` FROM RuleCondition WHERE `name` = 'C1_P_18501_PB_01_MEANS_CHOICE_NORMAL');
SET @ruleConditionIdStrongKBA = (SELECT `id` FROM RuleCondition WHERE `name` = 'C1_P_18501_PB_01_LOGIN_NORMAL');
SET @ruleConditionIdBestSign = (SELECT `id` FROM RuleCondition WHERE `name` = 'C1_P_18501_PB_01_BESTSIGN_NORMAL');
SET @ruleConditionIdOTPSMS = (SELECT `id` FROM RuleCondition WHERE `name` = 'C1_P_18501_PB_01_OTP_SMS_NORMAL');
SET @ruleConditionIdMissingAuthent = (SELECT `id` FROM RuleCondition WHERE `name` = 'C1_P_18501_PB_01_MISSING_AUTHENTMEAN');

SET @authMeanPassword = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'KBA');
SET @newAuthMeanPassword = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'STRONG_KBA');

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
		'KBA_OTP_FORM_PAGE',
		'STRONG_KBA_OTP_FORM_PAGE') WHERE id IN(SELECT customPageLayout_id FROM CustomPageLayout_ProfileSet WHERE profileSet_id = @profileSetId);