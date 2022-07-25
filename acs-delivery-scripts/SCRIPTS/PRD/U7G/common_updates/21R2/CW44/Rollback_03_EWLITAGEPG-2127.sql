USE `U7G_ACS_BO`;

SET @createdBy = 'W100851';
SET @authentMeansMobileAppExternal = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'MOBILE_APP_EXT');
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'MOBILE_APP');

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_UBS_01_OTP_SMS_EXT_FALLBACK')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_SWISSKEY_01_OTP_SMS_EXT_FALLBACK')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_ZKB_01_OTP_SMS_EXT')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_BCV_01_OTP_SMS_EXT')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_RCH_01_OTP_SMS_EXT')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_RCH_01_OTP_SMS_EXT')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));