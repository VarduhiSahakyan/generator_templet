USE U7G_ACS_BO;

SET @createdBy = 'A758582';
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'MOBILE_APP');

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_SWISSKEY_01_OTP_APP_NORMAL')
                                             AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

