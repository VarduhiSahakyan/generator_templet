USE U5G_ACS_BO;
INSERT INTO AuthentMeans (createdBy, creationDate, description, lastUpdateBy, lastUpdateDate, name, updateState)
SELECT 'InitPhase', sysdate(), 'STRONG_PASSWORD', NULL, NULL, 'STRONG_PASSWORD', 'PUSHED_TO_CONFIG'
FROM dual
WHERE NOT EXISTS(SELECT id FROM AuthentMeans where name = 'STRONG_PASSWORD');

/* !40000 ALTER TABLE MeansProcessStatuses DISABLE KEYS ; */
-- create the missing entries in MeansProcessStatuses

INSERT INTO MeansProcessStatuses (meansProcessStatusType, reversed, fk_id_authentMean)
SELECT *
FROM (SELECT DISTINCT(meansProcessStatusType) as stat FROM MeansProcessStatuses) as mp,
	 (SELECT flag
	  from (SELECT 0 as flag UNION SELECT 1) as temp) as b,
	 (SELECT a.id as aid FROM AuthentMeans a where a.name in ('STRONG_PASSWORD')) as c
WHERE NOT EXISTS(SELECT id
				 FROM MeansProcessStatuses
				 WHERE meansProcessStatusType = mp.stat
				   AND b.flag = reversed
				   and aid = fk_id_authentMean);


SET @avalableAuthMean =
		'INFO|OTP_SMS|MOBILE_APP|STRONG_PASSWORD|REFUSAL|UNDEFINED|MOBILE_APP_EXT|OTP_SMS_EXT_MESSAGE|KBA';
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
	"validate" : true
}, {
	"authentMeans" : "REFUSAL",
	"validate" : true
}, {
	"authentMeans" : "UNDEFINED",
	"validate" : true
}, {
	"authentMeans" : "MOBILE_APP_EXT",
	"validate" : false
}, {
	"authentMeans" : "MOBILE_APP",
	"validate" : true
}, {
	"authentMeans" : "STRONG_PASSWORD",
	"validate" : true
}, {
	"authentMeans" : "OTP_SMS_EXT_MESSAGE",
	"validate" : false
}, {
	"authentMeans" : "INFO",
	"validate" : true
}, {
	"authentMeans" : "KBA",
	"validate" : false
} ]';
SET @subissuerCode = '18502';


UPDATE SubIssuer
SET authentMeans = @subissuerAuthMeans
WHERE code = @subissuerCode
  and fk_id_issuer = @issuerId;


SET @customItemName = 'customitemset_18502_PB_PASSWORD';
SET @customItemDescription = 'customitemset_18502_PB_PASSWORD_Current';
SET @subissuerId = (SELECT id
					FROM SubIssuer
					WHERE code = @subissuerCode
					  AND fk_id_issuer = @issuerId);


SET @profileName = '18502_PB_PASSWORD_01';
SET @profileDescription = '18502_PASSWORD (NORMAL)';
SET @autMean = (SELECT id FROM AuthentMeans WHERE name ='STRONG_PASSWORD');

UPDATE Profile
SET fk_id_AuthentMeans = @autMean
WHERE fk_id_subIssuer = @subissuerId
	AND name = '18502_PB_PASSWORD_01';

SET @customItemSet = (SELECT id
					  FROM CustomItemSet
					  WHERE fk_id_subIssuer = @subissuerId AND name = @customItemName);

SET @profileId = (SELECT id
				  FROM Profile
				  WHERE fk_id_subIssuer = @subissuerId AND name = @profileName);
SET @ruleName = 'PASSWORD (NORMAL)';
SET @ruleDescription = 'PASSWORD_AVAILABLE_NORMAL';

SET @ruleId = (SELECT id
			   FROM Rule
			   WHERE fk_id_profile = @profileId);

SET @ruleConditionName = 'C1_P_18502_PB_01_PASSWORD_NORMAL';
UPDATE RuleCondition
SET name = @ruleConditionName
WHERE fk_id_rule = @ruleId;

SET @authMeanPassword = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'PASSWORD');
SET @newAuthMeanPassword = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'STRONG_PASSWORD');
SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE fk_id_rule = @ruleId AND name = @ruleConditionName);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;


SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;

SET @ruleConditionName = 'C1_P_18502_PB_01_MISSING_AUTHENTMEAN';
SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE name = @ruleConditionName);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;

SET @ruleConditionName = 'C1_P_18502_PB_01_MISSING_PWD_AUTHENTMEAN';
SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE name = @ruleConditionName);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;

SET @ruleConditionName = 'C1_P_18502_PB_01_MEANS_CHOICE_NORMAL';
SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE name = @ruleConditionName);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;


SET @ruleConditionName = 'C1_P_18502_PB_01_TA_NORMAL';
SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE name = @ruleConditionName);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;

SET @ruleConditionName = 'C1_P_18502_PB_01_OTP_SMS_NORMAL';
SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE name = @ruleConditionName);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;

SET @profileSetId = (SELECT id
				FROM ProfileSet
				WHERE fk_id_subIssuer = @subissuerId);

UPDATE CustomPageLayout SET pageType = REPLACE(
		pageType,
		'PASSWORD',
		'STRONG_PASSWORD') WHERE id IN(SELECT customPageLayout_id FROM CustomPageLayout_ProfileSet WHERE profileSet_id = @profileSetId);