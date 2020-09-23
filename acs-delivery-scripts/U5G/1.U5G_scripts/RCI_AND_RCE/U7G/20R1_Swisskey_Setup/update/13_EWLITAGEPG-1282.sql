USE U7G_ACS_BO;

SET @createdBy = 'A758582';
SET @BankB = 'SWISSKEY';
SET @BankUB = 'GRKB';
SET @subIssuerCode = '77400';
SET @subIssuerNameAndLabel = 'Graubündner Kantonalbank';


SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @currentPageType = 'POLLING_PAGE';
SET @currentAuthentMean = 'MOBILE_APP';
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @updateState = 'PUSHED_TO_CONFIG';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
		 'de', 10, @currentPageType, 'Stattdessen Freigabe durch SMS anfordern', @MaestroMID, NULL, @customItemSetMobileApp),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
		 'en', 10, @currentPageType, 'Request approval via SMS instead', @MaestroMID, NULL, @customItemSetMobileApp),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
		 'fr', 10, @currentPageType, 'À la place, demander l''activation pas SMS', @MaestroMID, NULL, @customItemSetMobileApp),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
		 'it', 10, @currentPageType, 'Al posto di questo, richiedere l’autorizzazione tramite SMS', @MaestroMID, NULL, @customItemSetMobileApp);


SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
SET @activatedAuthMeans = '[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP",
  "validate" : true
}, {
  "authentMeans" : "INFO",
  "validate" : true
}, {
  "authentMeans" : "UNDEFINED",
  "validate" : true
} ]';

UPDATE `SubIssuer` SET `authentMeans` = @activatedAuthMeans, `userChoiceAllowed` = TRUE WHERE `id` = @subIssuerID;

/* Profile */
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'MOBILE_APP');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanUNDEFINED = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					   `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
					   `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
					   `fk_id_subIssuer`) VALUES
(@createdBy, NOW(), 'UNDEFINED', NULL, NULL, CONCAT(@BankUB,'_UNDEFINED_01'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanUNDEFINED, NULL, NULL, NULL, @subIssuerID);


/* Rule */
SET @profileDefaultRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));
UPDATE `Rule` SET `orderRule` = 8
WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileDefaultRefusal;

SET @profileUNDEFINED = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_UNDEFINED_01'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					`updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), 'UNDEFINED', NULL, NULL, 'UNDEFINED', @updateState, 7, @profileUNDEFINED);

/* RuleCondition */
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (FALLBACK)' AND `fk_id_profile` = @profileSMS);
SET @ruleUNDEFINED = (SELECT id FROM `Rule` WHERE `description`='UNDEFINED' AND `fk_id_profile`=@profileUNDEFINED);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_UNDEFINED'), @updateState, @ruleUNDEFINED),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_FALLBACK'), @updateState, @ruleSMSnormal);

/* ProfileSet_Rule */
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
	SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
	WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@ruleUNDEFINED);

/* Condition_MeansProcessStatuses */
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
	AND mps.`fk_id_authentMean`=@authMeanUNDEFINED AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
	AND mps.`fk_id_authentMean`=@authentMeansMobileApp AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
	AND mps.`fk_id_authentMean`=@authentMeansMobileApp AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
	AND mps.`fk_id_authentMean`=@authentMeansMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
	AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
	AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
	AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_FALLBACK')
	AND mps.`fk_id_authentMean` = @authMeanOTPsms
	AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_FALLBACK')
	AND mps.`fk_id_authentMean` = @authMeanOTPsms
	AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_FALLBACK')
	AND mps.`fk_id_authentMean` = @authMeanOTPsms
	AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_FALLBACK')
	AND mps.`fk_id_authentMean` = @authentMeansMobileApp
	AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_OTP_TA_NORMAL')
	AND mps.`fk_id_authentMean` = @authentMeansMobileApp
	AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);