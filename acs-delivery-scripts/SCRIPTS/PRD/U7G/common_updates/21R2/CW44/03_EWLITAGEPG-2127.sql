USE `U7G_ACS_BO`;

SET @createdBy = 'W100851';
SET @authentMeansMobileAppExternal = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'MOBILE_APP_EXT');
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'MOBILE_APP');


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = 'C1_P_UBS_01_OTP_SMS_EXT_FALLBACK'
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExternal
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = 'C1_P_SWISSKEY_01_OTP_SMS_EXT_FALLBACK'
AND mps.`fk_id_authentMean` = @authentMeansMobileApp
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = 'C1_P_ZKB_01_OTP_SMS_EXT'
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExternal
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = 'C1_P_BCV_01_OTP_SMS_EXT'
AND mps.`fk_id_authentMean` = @authentMeansMobileApp
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = 'C1_P_RCH_01_OTP_SMS_EXT'
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExternal
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = 'C1_P_RCH_01_OTP_SMS_EXT'
AND mps.`fk_id_authentMean` = @authentMeansMobileApp
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = TRUE);