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



INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
						`updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
						`fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
						`fk_id_subIssuer`) VALUES
(@createdBy, NOW(), 'UNDEFINED', NULL, NULL, CONCAT(@BankUB,'_UNDEFINED_01'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanUNDEFINED, NULL, NULL, NULL, @subIssuerID);



UPDATE `Rule` SET `orderRule` = 10 WHERE `description` = '16900_REFUSAL_DEFAULT';

SET @profileUNDEFINED = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_UNDEFINED_01'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					`updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), 'UNDEFINED', NULL, NULL, 'UNDEFINED', @updateState, 9, @profileUNDEFINED);


SET @ruleUNDEFINED = (SELECT id FROM `Rule` WHERE `description`='UNDEFINED' AND `fk_id_profile`=@profileUNDEFINED);


INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_PHOTO_TAN'), @updateState, @rulePhotoTan),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_UNDEFINED'), @updateState, @ruleUNDEFINED);

# -- PHOTO TAN 02 --

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_PHOTO_TAN')
AND mps.`fk_id_authentMean` = @authentMeansPhotoTan AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_PHOTO_TAN')
AND mps.`fk_id_authentMean` = @authentMeansPhotoTan AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PHOTO_TAN')
AND mps.`fk_id_authentMean`=@authentMeansPhotoTan AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PHOTO_TAN')
AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType` IN ('COMBINED_MEANS_REQUIRED') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_PHOTO_TAN')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_PHOTO_TAN')
AND mps.`fk_id_authentMean` = @authentMeansPhotoTan AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PHOTO_TAN')
AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_PHOTO_TAN')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = FALSE);

SET @ruleConditionPhotoTan = (SELECT `id` FROM `RuleCondition` WHERE `fk_id_rule` = @rulePhotoTan AND name = 'C1_P_16900_02_PHOTO_TAN');

INSERT INTO `TransactionValue` (`reversed`, `transactionValueType`, `value`, `fk_id_condition`) VALUES
	(b'1', 'DEVICE_CHANNEL', '01', @ruleConditionPhotoTan );



# -- PHOTO TAN 01 --

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PHOTO_TAN')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

# -- PASSWORD ---
SET @passwordRuleConditionId = (SELECT id FROM RuleCondition WHERE `name`= CONCAT('C1_P_', @BankUB, '_01_PASSWORD_NORMAL'));
SET @meansProcessStatusId = (SELECT id FROM MeansProcessStatuses WHERE fk_id_authentMean  = @authentMeansPhotoTan AND (meansProcessStatusType = 'COMBINED_MEANS_REQUIRED' AND reversed = TRUE));

DELETE FROM Condition_MeansProcessStatuses WHERE id_condition = @passwordRuleConditionId AND id_meansProcessStatuses = @meansProcessStatusId;

# ----- UNDEFINED --------

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authMeanUNDEFINED AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authentMeansMobileAppExt AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authentMeansMobileAppExt AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authentMeansMobileAppExt AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authentMeansPhotoTan AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authentMeansPhotoTan AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authentMeansPhotoTan AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);


SET @ruleUndefined = (SELECT id FROM `Rule` WHERE `description` = 'UNDEFINED' AND `fk_id_profile` = @profileUNDEFINED);
SET @RuleId = (SELECT  r.`id` FROM	`Rule` r WHERE	r.`id` = @ruleUndefined);
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_16900_01');
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`) VALUES
(@ProfileSet , @RuleId);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_MOBILE_APP_NORMAL')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_MOBILE_APP_NORMAL')
AND mps.`fk_id_authentMean`=@authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);
