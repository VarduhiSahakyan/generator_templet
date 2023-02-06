USE U5G_ACS_BO;

SET @BankUB = '16900';
SET @createdBy = 'W100851';
SET @updateState = 'PUSHED_TO_CONFIG';
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = '16900' AND `name` = 'Consorsbank');
SET @authMeanUNDEFINED = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');
SET @authentMeansMobileAppExt = (SELECT id FROM `AuthentMeans`	WHERE `name` = 'MOBILE_APP_EXT');
SET @authentMeansPhotoTan = (SELECT id FROM `AuthentMeans`	WHERE `name` = 'PHOTO_TAN');
SET @profilePhotoTan = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_PHOTO_TAN_01'));
SET @rulePhotoTan = (SELECT id FROM `Rule` WHERE `description` = CONCAT(@BankUB, '_PHOTO_TAN_AVAILABLE_NORMAL') AND `fk_id_profile` = @profilePhotoTan);
SET @authMeanPassword = (SELECT id FROM `AuthentMeans`	WHERE `name` = 'EXT_PASSWORD');
SET @undefinedRuleConditionId = (SELECT id FROM RuleCondition WHERE `name`= CONCAT('C1_P_',@BankUB,'_01_UNDEFINED'));
SET @photoTanRuleConditionId = (SELECT id FROM RuleCondition WHERE `name`= CONCAT('C1_P_', @BankUB, '_02_PHOTO_TAN'));

SET @profileUNDEFINED = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_UNDEFINED_01'));
SET @ruleUndefined = (SELECT id FROM `Rule` WHERE `description` = 'UNDEFINED' AND `fk_id_profile` = @profileUNDEFINED);
SET @RuleId = (SELECT  r.`id` FROM	`Rule` r WHERE	r.`id` = @ruleUndefined);
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_16900_01');


SET @ruleConditionId = (SELECT id FROM RuleCondition WHERE name = CONCAT('C1_P_',@BankUB,'_01_MOBILE_APP_NORMAL'));
SET @errorMeansProcessStartsId = (SELECT id FROM MeansProcessStatuses WHERE fk_id_authentMean = @authentMeansMobileAppExt AND (`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND `reversed` = TRUE));
SET @userChoiceMeansProcessStartsId = (SELECT id FROM MeansProcessStatuses WHERE fk_id_authentMean = @authentMeansMobileAppExt AND (`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND `reversed` = FALSE));



SET @01photoTanRuleConditionId = (SELECT id FROM RuleCondition WHERE `name`= CONCAT('C1_P_', @BankUB, '_01_PHOTO_TAN'));
SET @meansProcessStatusId = (SELECT id FROM MeansProcessStatuses WHERE fk_id_authentMean  = @authentMeansMobileAppExt AND (meansProcessStatusType = 'COMBINED_MEANS_REQUIRED' AND reversed = TRUE));


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PASSWORD_NORMAL')
AND mps.`fk_id_authentMean` = @authentMeansPhotoTan AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

START TRANSACTION;
DELETE FROM Condition_MeansProcessStatuses WHERE id_condition = @01photoTanRuleConditionId AND id_meansProcessStatuses = @meansProcessStatusId;
DELETE FROM ProfileSet_Rule WHERE id_profileSet = @ProfileSet AND id_rule = @RuleId;
DELETE FROM Condition_MeansProcessStatuses WHERE id_condition = @undefinedRuleConditionId;
DELETE FROM Condition_MeansProcessStatuses WHERE id_condition = @photoTanRuleConditionId ;
DELETE FROM Condition_TransactionStatuses WHERE id_condition = @photoTanRuleConditionId ;
DELETE FROM Condition_MeansProcessStatuses WHERE id_condition = @ruleConditionId AND id_meansProcessStatuses = @errorMeansProcessStartsId;
DELETE FROM Condition_MeansProcessStatuses WHERE id_condition = @ruleConditionId AND id_meansProcessStatuses = @userChoiceMeansProcessStartsId;
DELETE FROM RuleCondition WHERE fk_id_rule = @rulePhotoTan AND name = CONCAT('C1_P_', @BankUB, '_02_PHOTO_TAN');
DELETE FROM RuleCondition WHERE fk_id_rule = @ruleUndefined AND name = CONCAT('C1_P_', @BankUB, '_01_UNDEFINED');
DELETE FROM Rule WHERE id = @RuleId;
DELETE FROM Profile WHERE fk_id_subIssuer = @subIssuerID AND name = CONCAT(@BankUB,'_UNDEFINED_01');


COMMIT;


