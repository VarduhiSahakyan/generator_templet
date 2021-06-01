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
SET @sharedSubissuerAuthMeans = '[ {
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
  "validate" : true
}, {
  "authentMeans" : "INFO",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
}, {
  "authentMeans" : "STRONG_PASSWORD",
  "validate" : true
}, {
  "authentMeans" : "STRONG_KBA",
  "validate" : true
} ]';
SET @subissuerCode = '18502';
SET @sharedSubissuerCode = '18500';


UPDATE SubIssuer
SET authentMeans = @subissuerAuthMeans
WHERE code = @subissuerCode
  and fk_id_issuer = @issuerId;

UPDATE SubIssuer
SET authentMeans = @sharedSubissuerAuthMeans
WHERE code = @sharedSubissuerCode
  and fk_id_issuer = @issuerId;


SET @customItemName = 'customitemset_18502_PB_PASSWORD';
SET @customItemDescription = 'customitemset_18502_PB_PASSWORD_Current';
SET @subissuerId = (SELECT id
					FROM SubIssuer
					WHERE code = @subissuerCode
					AND fk_id_issuer = @issuerId);


SET @profileName01 = '18502_PB_PASSWORD_01';
SET @profileName02 = '18502_PB_PASSWORD_02';
SET @profileDescription = '18502_PASSWORD (NORMAL)';
SET @autMean = (SELECT id FROM AuthentMeans WHERE name ='STRONG_PASSWORD');

UPDATE Profile
SET fk_id_AuthentMeans = @autMean
WHERE fk_id_subIssuer = @subissuerId
	AND name = @profileName01;

UPDATE Profile
SET fk_id_AuthentMeans = @autMean
WHERE fk_id_subIssuer = @subissuerId
	AND name = @profileName02;

SET @customItemSet = (SELECT id
						FROM CustomItemSet
						WHERE fk_id_subIssuer = @subissuerId AND name = @customItemName);

SET @profileId01 = (SELECT id
					FROM Profile
					WHERE fk_id_subIssuer = @subissuerId AND name = @profileName01);
SET @profileId02 = (SELECT id
					FROM Profile
					WHERE fk_id_subIssuer = @subissuerId AND name = @profileName02);
SET @ruleName = 'PASSWORD (NORMAL)';

SET @ruleId01 = (SELECT id
				FROM Rule
				WHERE fk_id_profile = @profileId01);

SET @ruleConditionNameNormal = 'C1_P_18502_PB_01_PASSWORD_NORMAL';
SET @ruleConditionNameChoice01 = 'C1_P_18502_PB_01_PASSWORD_CHOICE';
SET @ruleConditionNameChoice02 = 'C1_P_18502_PB_02_PASSWORD_CHOICE';

SET @ruleConditionNameNormal_ID = (SELECT id FROM RuleCondition WHERE name = @ruleConditionNameNormal);

SET @authMeanPassword = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'PASSWORD');
SET @newAuthMeanPassword = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'STRONG_PASSWORD');


SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameNormal_ID ;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameNormal_ID;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameNormal_ID;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameNormal_ID;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameNormal_ID;


SET @ruleConditionNameChoice01_ID = (SELECT id FROM RuleCondition WHERE name = @ruleConditionNameChoice01);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameChoice01_ID;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameChoice01_ID;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameChoice01_ID;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameChoice01_ID;


SET @ruleConditionNameChoice02_ID = (SELECT id FROM RuleCondition WHERE name = @ruleConditionNameChoice02);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameChoice02_ID;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameChoice02_ID;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameChoice02_ID;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameChoice02_ID;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionNameChoice02_ID;



SET @ruleConditionName = 'C1_P_18502_PB_01_OTP_SMS_CHOICE';
SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE name = @ruleConditionName);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;



SET @ruleConditionName = '18502_PB_AUTHENT_MEANS_CHOICE_01';
SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE name = @ruleConditionName);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

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

SET @ruleConditionName = 'C1_P_18502_PB_02_MISSING_AUTHENTMEAN';
SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE name = @ruleConditionName);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;


SET @ruleConditionName = 'C1_P_18502_PB_01_MISSING_PWD_AUTHENTMEAN';
SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE name = @ruleConditionName);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;

SET @ruleConditionName = 'C1_P_18502_PB_01_MEANS_CHOICE_NORMAL';
SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE name = @ruleConditionName);

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

UPDATE Condition_MeansProcessStatuses SET id_meansProcessStatuses = @newMeansProcessId WHERE id_meansProcessStatuses = @meansProcessId AND id_condition = @ruleConditionId;

SET @meansProcessId = (SELECT  id FROM	MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @authMeanPassword  AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);
SET @newMeansProcessId = (SELECT  id FROM  MeansProcessStatuses mps WHERE mps.fk_id_authentMean = @newAuthMeanPassword	AND mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

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