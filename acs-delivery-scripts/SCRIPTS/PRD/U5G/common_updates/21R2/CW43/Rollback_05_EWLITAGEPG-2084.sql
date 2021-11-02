USE U5G_ACS_BO;

SET @createdBy = 'W100851';
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'MOBILE_APP');
SET @authentOTP_SMS = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'OTP_SMS');
SET @authentOTP_SMS_EXTERNAL = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authentMeansMobileAppExternal = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'MOBILE_APP_EXT');

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_12000_01_MOBILE_APP_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_16500_01_MOBILE_APP_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_COMDIRECT_OTP_APP_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_SPB_sharedBIN_01_OTP_APP_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_18501_PB_01_BESTSIGN_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_18502_PB_01_TA_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_COZ_01_MOBILE_APP_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_LBBW_01_MOBILE_APP_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_20000_01_MOBILE_APP_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_16500_01_SMS_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentOTP_SMS_EXTERNAL AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_COMDIRECT_MTAN')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentOTP_SMS_EXTERNAL AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_SPB_sharedBIN_01_MOBILE_APP_CHOICE_AVAILABLE')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_SPB_sharedBIN_02_MOBILE_APP_CHOICE_AVAILABLE')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_SPB_sharedBIN_01_OTP_SMS_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentOTP_SMS_EXTERNAL AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_SPB_sharedBIN_01_SMS_CHOICE_AVAILABLE')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentOTP_SMS_EXTERNAL AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_SPB_sharedBIN_02_SMS_CHOICE_AVAILABLE')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentOTP_SMS_EXTERNAL AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_18501_PB_01_BESTSIGN_CHOICE')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_18501_PB_02_BESTSIGN_CHOICE')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_18501_PB_01_OTP_SMS_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentOTP_SMS_EXTERNAL AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_18502_PB_01_TA_CHOICE')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_18502_PB_02_TA_CHOICE')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_COZ_01_OTP_SMS_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentOTP_SMS_EXTERNAL AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_LBBW_01_OTP_SMS_NORMAL')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentOTP_SMS AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C2_P_20000_05_MOBILE_APP_CHOICE')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C2_P_20000_08_MOBILE_APP_CHOICE')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentMeansMobileAppExternal AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` ='C1_P_16900_01_MTAN')
AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authentOTP_SMS_EXTERNAL AND (`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND `reversed`=TRUE));