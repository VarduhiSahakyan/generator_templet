USE U5G_ACS_BO;

SET @createdBy = 'W100851';
SET @BankUB = '16500';
SET @updateState =	'PUSHED_TO_CONFIG';
SET @authMeanSmsExt = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanPhotoTan = (SELECT id FROM `AuthentMeans` WHERE `name` = 'PHOTO_TAN');
SET @authMeanAttempt = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ATTEMPT');
SET @authMeanMobileApp = (SELECT id FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP');
SET @authMeanPassword = (SELECT id FROM `AuthentMeans` WHERE `name` = 'EXT_PASSWORD');
SET @subIssuerID = (SELECT id FROM SubIssuer WHERE name = 'ING' AND code = 16500);
SET @defaultRefusal = (SELECT id FROM Profile WHERE name = '16500_REFUSAL_01' AND fk_id_subIssuer = @subIssuerID);
SET @issuerID = (SELECT id FROM Issuer WHERE name = 'ING' AND code = 16500);


SET @profileACCEPTMAINT = (SELECT id FROM `Profile` WHERE `name` = CONCAT('16500_ACCEPT'));

SET @availableAuthMean = 'MOBILE_APP_EXT|PHOTO_TAN|OTP_SMS_EXT_MESSAGE|I_TAN|REFUSAL|UNDEFINED|EXT_PASSWORD|ATTEMPT';

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
}, {
  "authentMeans" : "ATTEMPT",
  "validate" : false
} ]';

UPDATE SubIssuer SET authentMeans = @subissuerAuthMean WHERE id = @subIssuerID;

UPDATE Rule SET orderRule = 10 WHERE name = 'REFUSAL (DEFAULT)' and fk_id_profile = @defaultRefusal;

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), '16500_ACCEPT_MAINTANCE_NORMAL', NULL, NULL, 'ACCEPT MAINT', @updateState, 9, @profileACCEPTMAINT);

SET @ruleAcceptMaint = (SELECT id FROM `Rule` WHERE `description` = '16500_ACCEPT_MAINTANCE_NORMAL' AND `fk_id_profile` = @profileACCEPTMAINT);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_ACCEPT'), @updateState, @ruleAcceptMaint);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_ACCEPT')
AND mps.`fk_id_authentMean` = @authMeanSmsExt
AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_ACCEPT')
AND mps.`fk_id_authentMean` = @authMeanPhotoTan
AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed` = FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_ACCEPT')
AND mps.`fk_id_authentMean` = @authMeanMobileApp
AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_ACCEPT')
AND mps.`fk_id_authentMean` = @authMeanPassword
AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_ACCEPT')
AND mps.`fk_id_authentMean` = @authMeanAttempt
AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed` = TRUE);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@ruleAcceptMaint);