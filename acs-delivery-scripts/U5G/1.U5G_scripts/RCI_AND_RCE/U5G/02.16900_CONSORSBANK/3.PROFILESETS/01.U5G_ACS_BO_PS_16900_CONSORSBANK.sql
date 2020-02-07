USE `U5G_ACS_BO`;

SET @username = 'InitPhase';
SET @codeSubIssuer = '16900';



SET @idSubIssuer = (SELECT id FROM `SubIssuer` WHERE `code` = @codeSubIssuer);

SET @idSMSAuthMeans = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @idRefusalAuthMeans = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @idPhotoTanAuthMeans = (SELECT id FROM `AuthentMeans` WHERE `name` = 'PHOTO_TAN');
SET @idMobileAppExtAuthMeans = (SELECT id FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP_EXT');
SET @idAttemptAuthMeans = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ATTEMPT');
SET @idAcceptAuthMeans = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');

SET @idCustomItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_1_REFUSAL');
SET @idCustomItemSetSms = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_SMS');
SET @idCustomItemSetMobileAppExt = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_MOBILE_APP_EXT');
SET @idCustomItemSetPhotoTan = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_PHOTO_TAN');
SET @idCustomItemSetAccept = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_ACCEPT_MAINT');

--  13. Profile

SET @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` = @profileSetName);

SET @layoutSmsOtp = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_FORM_PAGE'  and `description`='OTP Form Page (Consorsbank)' ORDER BY id DESC LIMIT 1);
SET @layoutMessageBanner = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MESSAGE_BANNER' and `description`='Message Banner (Consorsbank)' ORDER BY id DESC LIMIT 1);
SET @layoutHelp = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'HELP_PAGE'  and `description`='Help Page (Consorsbank)' ORDER BY id DESC LIMIT 1);
SET @layoutRefusal = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'REFUSAL_PAGE' and `description`='Refusal Page (Consorsbank)' ORDER BY id DESC LIMIT 1);
SET @layoutFailure = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'FAILURE_PAGE'  and `description`='Failure Page (Consorsbank)' ORDER BY id DESC LIMIT 1);
SET @layoutPhotoTan = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'PHOTO_TAN_OTP_FORM_PAGE' and `description`='Photo Tan Page (Consorsbank)' ORDER BY id DESC LIMIT 1);
SET @layoutMobileApp = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'POLLING_PAGE' and `description`='Polling Page (Consorsbank)' ORDER BY id DESC LIMIT 1);


INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES (@layoutSmsOtp, @profileSetId);
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES (@layoutMessageBanner, @profileSetId);
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES (@layoutHelp, @profileSetId);
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES (@layoutRefusal, @profileSetId);
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES (@layoutFailure, @profileSetId);
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES (@layoutPhotoTan, @profileSetId);
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES (@layoutMobileApp, @profileSetId);

-- REFUSAL FRAUD

SET @profileId = (SELECT id FROM `Profile` WHERE `name` = '16900_REFUSAL_01');

-- Rule
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `orderRule`, `fk_id_profile`) VALUES
	(@username, NOW(), '16900_REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', 'PUSHED_TO_CONFIG', 1, @profileId);

SET @ruleId = (SELECT id FROM `Rule` WHERE `description`='16900_REFUSAL_FRAUD' AND `fk_id_profile` = @profileId);

/* ProfileSet_Rule */
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`) VALUES (@profileSetId, @ruleId);

/* RuleCondition */
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_rule`) VALUES
  ('A513048', NOW(), NULL, NULL, NULL,'C1_P_16900_01_FRAUD', 'PUSHED_TO_CONFIG',@ruleId),
  ('A513048', NOW(), NULL, NULL, NULL,'C2_P_16900_01_FRAUD', 'PUSHED_TO_CONFIG',@ruleId),
  ('A513048', NOW(), NULL, NULL, NULL,'C3_P_16900_01_FRAUD', 'PUSHED_TO_CONFIG',@ruleId),
  ('A513048', NOW(), NULL, NULL, NULL,'C4_P_16900_01_FRAUD', 'PUSHED_TO_CONFIG',@ruleId);

-- Insert Transaction statuses
SET @conditionId = (SELECT id from RuleCondition where name = 'C1_P_16900_01_FRAUD');
SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='PAYMENT_MEANS_IN_NEGATIVE_LIST' AND reversed=FALSE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

SET @conditionId = (SELECT id from RuleCondition where name = 'C2_P_16900_01_FRAUD');
SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND reversed=FALSE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

SET @conditionId = (SELECT id from RuleCondition where name = 'C3_P_16900_01_FRAUD');
SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='CARD_HOLDER_COUNTRY_IN_NEGATIVE_LIST' AND reversed=FALSE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

SET @conditionId = (SELECT id from RuleCondition where name = 'C4_P_16900_01_FRAUD');
SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='MERCHANT_URL_IN_NEGATIVE_LIST' AND reversed=FALSE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

-- RBA ALWAYS ACCEPT

SET @profileId = (SELECT id FROM `Profile` WHERE `name` = '16900_ACCEPT_01');

-- Rule
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `orderRule`, `fk_id_profile`) VALUES
(@username, NOW(), '16900_ACCEPT_RBA', NULL, NULL, 'ACCEPT (RBA)', 'PUSHED_TO_CONFIG', 2, @profileId);

SET @ruleId = (SELECT id FROM `Rule` WHERE `description`='16900_ACCEPT_RBA' AND `fk_id_profile`=@profileId);

/* ProfileSet_Rule */
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`) VALUES (@profileSetId, @ruleId);

/* RuleCondition */
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_rule`) VALUES
('A513048', NOW(), NULL, NULL, NULL,'C1_P_16900_ACCEPT_RBA', 'PUSHED_TO_CONFIG',@ruleId);

-- Insert Transaction statuses
SET @conditionId = (SELECT id from RuleCondition where name = 'C1_P_16900_ACCEPT_RBA');

SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='ALWAYS_ACCEPT' AND reversed=FALSE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='ALWAYS_DECLINE' AND reversed=TRUE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

-- RBA ALWAYS DECLINE

SET @profileId = (SELECT id FROM `Profile` WHERE `name` = '16900_REFUSAL_01');

-- Rule
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `orderRule`, `fk_id_profile`) VALUES
(@username, NOW(), '16900_DECLINE_RBA', NULL, NULL, 'DECLINE (RBA)', 'PUSHED_TO_CONFIG', 3, @profileId);

SET @ruleId = (SELECT id FROM `Rule` WHERE `description`='16900_DECLINE_RBA' AND `fk_id_profile`=@profileId);

/* ProfileSet_Rule */
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`) VALUES (@profileSetId, @ruleId);

/* RuleCondition */
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_rule`) VALUES
('A513048', NOW(), NULL, NULL, NULL,'C1_P_16900_DECLINE_RBA', 'PUSHED_TO_CONFIG',@ruleId);

-- Insert Transaction statuses
SET @conditionId = (SELECT id from RuleCondition where name = 'C1_P_16900_DECLINE_RBA');

SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='ALWAYS_ACCEPT' AND reversed=TRUE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='ALWAYS_DECLINE' AND reversed=FALSE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

-- Rules Photo TAN
SET @profileId = (SELECT id FROM `Profile` WHERE `name` = '16900_PHOTO_TAN_01');

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `orderRule`, `fk_id_profile`) VALUES
	(@username, NOW(), '16900_PHOTO_TAN_AVAILABLE_NORMAL', NULL, NULL, 'PHOTO_TAN (NORMAL)', 'PUSHED_TO_CONFIG', 4, @profileId);

SET @ruleId = (SELECT id FROM `Rule` WHERE `description`='16900_PHOTO_TAN_AVAILABLE_NORMAL' AND `fk_id_profile`= @profileId);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`) VALUES (@profileSetId, @ruleId);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_rule`) VALUES
  (@username, NOW(), NULL, NULL, NULL, 'C1_P_16900_01_PHOTO_TAN', 'PUSHED_TO_CONFIG', @ruleId);

SET @conditionId = (SELECT c.id FROM `RuleCondition` c WHERE c.`name`='C1_P_16900_01_PHOTO_TAN');

-- SET @lastMeansId=(SELECT id FROM `MeansProcessStatuses` WHERE meansProcessStatusType='FORCED_MEANS_USAGE' AND reversed=FALSE AND fk_id_authentMean = @idPhotoTanAuthMeans);
-- INSERT INTO `Condition_MeansProcessStatuses`  (id_condition, ID_MEANSPROCESSSTATUSES) VALUES (@conditionId, @lastMeansId);

SET @lastMeansId=(SELECT id FROM `MeansProcessStatuses` WHERE meansProcessStatusType='MEANS_DISABLED' AND reversed=TRUE AND fk_id_authentMean = @idPhotoTanAuthMeans);
INSERT INTO `Condition_MeansProcessStatuses`  (id_condition, ID_MEANSPROCESSSTATUSES) VALUES (@conditionId, @lastMeansId);

SET @lastMeansId=(SELECT id FROM `MeansProcessStatuses` WHERE meansProcessStatusType='MEANS_AVAILABLE' AND reversed=FALSE AND fk_id_authentMean = @idPhotoTanAuthMeans);
INSERT INTO `Condition_MeansProcessStatuses`  (id_condition, ID_MEANSPROCESSSTATUSES) VALUES (@conditionId, @lastMeansId);

SET @lastMeansId=(SELECT id FROM `MeansProcessStatuses` WHERE meansProcessStatusType='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND reversed=FALSE AND fk_id_authentMean = @idPhotoTanAuthMeans);
INSERT INTO `Condition_MeansProcessStatuses`  (id_condition, ID_MEANSPROCESSSTATUSES) VALUES (@conditionId, @lastMeansId);

SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='ALWAYS_ACCEPT' AND reversed=TRUE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='ALWAYS_DECLINE' AND reversed=TRUE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

-- Rules SMS
SET @profileId = (SELECT id FROM `Profile` WHERE `name` = '16900_SMS_01');

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `orderRule`, `fk_id_profile`) VALUES
(@username, NOW(), '16900_MTAN_AVAILABLE_NORMAL', NULL, NULL, 'MTAN (NORMAL)', 'PUSHED_TO_CONFIG', 5, @profileId);

SET @ruleId = (SELECT id FROM `Rule` WHERE `description`='16900_MTAN_AVAILABLE_NORMAL' AND `fk_id_profile`= @profileId);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`) VALUES (@profileSetId, @ruleId);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_rule`) VALUES
(@username, NOW(), NULL, NULL, NULL, 'C1_P_16900_01_MTAN', 'PUSHED_TO_CONFIG', @ruleId);

SET @conditionId = (SELECT c.id FROM `RuleCondition` c WHERE c.`name`='C1_P_16900_01_MTAN');

-- SET @lastMeansId=(SELECT id FROM `MeansProcessStatuses` WHERE meansProcessStatusType='FORCED_MEANS_USAGE' AND reversed=FALSE AND fk_id_authentMean = @idSMSAuthMeans);
-- INSERT INTO `Condition_MeansProcessStatuses`  (id_condition, ID_MEANSPROCESSSTATUSES) VALUES (@conditionId, @lastMeansId);

SET @lastMeansId=(SELECT id FROM `MeansProcessStatuses` WHERE meansProcessStatusType='MEANS_DISABLED' AND reversed=TRUE AND fk_id_authentMean = @idSMSAuthMeans);
INSERT INTO `Condition_MeansProcessStatuses`  (id_condition, ID_MEANSPROCESSSTATUSES) VALUES (@conditionId, @lastMeansId);

SET @lastMeansId=(SELECT id FROM `MeansProcessStatuses` WHERE meansProcessStatusType='MEANS_AVAILABLE' AND reversed=FALSE AND fk_id_authentMean = @idSMSAuthMeans);
INSERT INTO `Condition_MeansProcessStatuses`  (id_condition, ID_MEANSPROCESSSTATUSES) VALUES (@conditionId, @lastMeansId);

SET @lastMeansId=(SELECT id FROM `MeansProcessStatuses` WHERE meansProcessStatusType='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND reversed=FALSE AND fk_id_authentMean = @idSMSAuthMeans);
INSERT INTO `Condition_MeansProcessStatuses`  (id_condition, ID_MEANSPROCESSSTATUSES) VALUES (@conditionId, @lastMeansId);

SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='ALWAYS_ACCEPT' AND reversed=TRUE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='ALWAYS_DECLINE' AND reversed=TRUE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

-- Maintenance Attempt

SET @profileId = (SELECT id FROM `Profile` WHERE `name` = '16900_ACCEPT_01');

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `orderRule`, `fk_id_profile`) VALUES
(@username, NOW(), '16900_ACCEPT_MAINTANCE_NORMAL', NULL, NULL, 'ACCEPT MAINT', 'PUSHED_TO_CONFIG', 6, @profileId);

SET @ruleId = (SELECT id FROM `Rule` WHERE `description`='16900_ACCEPT_MAINTANCE_NORMAL' AND `fk_id_profile`= @profileId);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`) VALUES (@profileSetId, @ruleId);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_rule`) VALUES
(@username, NOW(), NULL, NULL, NULL, 'C1_P_16900_01_ACCEPT', 'PUSHED_TO_CONFIG', @ruleId);

SET @conditionId = (SELECT c.id FROM `RuleCondition` c WHERE c.`name`='C1_P_16900_01_ACCEPT');

SET @lastMeansId=(SELECT id FROM `MeansProcessStatuses` WHERE meansProcessStatusType='MEANS_DISABLED' AND reversed = FALSE AND fk_id_authentMean = @idSMSAuthMeans);
INSERT INTO `Condition_MeansProcessStatuses`  (id_condition, ID_MEANSPROCESSSTATUSES) VALUES (@conditionId, @lastMeansId);

SET @lastMeansId=(SELECT id FROM `MeansProcessStatuses` WHERE meansProcessStatusType='MEANS_DISABLED' AND reversed = FALSE AND fk_id_authentMean = @idPhotoTanAuthMeans);
INSERT INTO `Condition_MeansProcessStatuses`  (id_condition, ID_MEANSPROCESSSTATUSES) VALUES (@conditionId, @lastMeansId);

SET @lastMeansId=(SELECT id FROM `MeansProcessStatuses` WHERE meansProcessStatusType='MEANS_DISABLED' AND reversed=TRUE AND fk_id_authentMean = @idAttemptAuthMeans);
INSERT INTO `Condition_MeansProcessStatuses`  (id_condition, ID_MEANSPROCESSSTATUSES) VALUES (@conditionId, @lastMeansId);

-- Rules Refusal
SET @profileId = (SELECT id FROM `Profile` WHERE `name` = '16900_REFUSAL_01');

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `orderRule`, `fk_id_profile`) VALUES
(@username, NOW(), '16900_REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 7, @profileId);

SET @ruleId = (SELECT id FROM `Rule` WHERE `description`='16900_REFUSAL_DEFAULT' AND `fk_id_profile`= @profileId);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`) VALUES (@profileSetId, @ruleId);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_rule`) VALUES
(@username, NOW(), NULL, NULL, NULL, 'C1_P_16900_01_DEFAULT', 'PUSHED_TO_CONFIG', @ruleId);

SET @conditionId = (SELECT c.id FROM `RuleCondition` c WHERE c.`name`='C1_P_16900_01_DEFAULT');

SET @lastTsId=(SELECT id FROM `TransactionStatuses` WHERE transactionStatusType='DEFAULT' AND reversed=FALSE);
INSERT INTO `Condition_TransactionStatuses`  (id_condition, id_transactionStatuses) VALUES (@conditionId, @lastTsId);

