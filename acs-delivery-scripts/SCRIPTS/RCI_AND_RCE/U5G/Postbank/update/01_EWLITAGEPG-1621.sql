USE `U5G_ACS_BO`;

SET @issuerCode = '18500';
SET @createdBy ='A758582';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerCode = '18502';
SET @subIssuerID = (SELECT `id` FROM `SubIssuer` WHERE `code` = @subIssuerCode);
SET @BankB = 'Postbank FBK';
SET @BankUB = '18502_PB';
SET @Bank_B = '18502_';


/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_PASSWORD_Choice'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_PASSWORD_Choice'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;


/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;
SET @customItemSetPWDChoice = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_PASSWORD_Choice'));
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_PASSWORD'));

SET @authMeanPassword = (SELECT id FROM `AuthentMeans` WHERE `name` = 'PASSWORD');
SET @authMeanUndefined = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');
SET @authMeanMobileApp = (SELECT id FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
SET @authMeanINFO = (SELECT id FROM `AuthentMeans` WHERE `name` = 'INFO');

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_PASSWORD_02') WHERE `fk_id_authentMeans` = @authMeanPassword AND `fk_id_customItemSetCurrent` = @customItemSetPassword;

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, `dataEntryAllowedPattern`, `dataEntryFormat`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), CONCAT(@Bank_B,'PASSWORD (CHOICE)'), NULL, NULL, CONCAT(@BankUB,'_PASSWORD_01'), 'PUSHED_TO_CONFIG', 2, '^[^OIi]*$', '10:(:ALPHA_MAJ:1)&(:ALPHA_MIN:1)&(:DIGIT:1)', @authMeanPassword, @customItemSetPWDChoice, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `Profile` ENABLE KEYS */;


/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileSMSChoice = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @profileRefusal = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL'));
SET @profileUndefinedRefusal = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MISSING_AUTHENT_MEANS_REFUSAL'));
SET @profileUndefinedPWDRefusal = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MISSING_PWD_AUTHENT_MEANS_REFUSAL'));
SET @profileMEANSCHOICE = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_AUTHENT_MEANS_CHOICE_01'));
SET @profilePassword = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_02'));
SET @profileTA = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_TA_02'));
SET @profileSMS = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_02'));
SET @profilePWDChoice = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_01'));

SET @ruleSMSnormalchoice = (SELECT `id` FROM `Rule` WHERE `description`='SMS_AVAILABLE_CHOICE' AND `fk_id_profile`=@profileSMSChoice);
SET @ruleUndefinedRefusal = (SELECT `id` FROM `Rule` WHERE `description`='REFUSAL_MISSING_AUTHENTMEANS' AND `fk_id_profile`=@profileUndefinedRefusal);
SET @ruleUndefinedPWDRefusal = (SELECT `id` FROM `Rule` WHERE `description`='REFUSAL_MISSING_PWD_AUTHENTMEANS' AND `fk_id_profile`=@profileUndefinedPWDRefusal);
SET @ruleAuthentMeansChoice = (SELECT `id` FROM `Rule` WHERE `description`='MEANS_CHOICE_NORMAL' AND `fk_id_profile`=@profileMEANSCHOICE);
SET @rulePasswordnormal = (SELECT `id` FROM `Rule` WHERE `description`='PASSWORD_AVAILABLE_NORMAL' AND `fk_id_profile`=@profilePassword);
SET @ruleTAnormal = (SELECT `id` FROM `Rule` WHERE `description`='TA_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileTA);
SET @ruleSMSnormal = (SELECT `id` FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleRefusalDefault = (SELECT `id` FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);

UPDATE `Rule` SET `orderRule`=2 where `id` = @ruleUndefinedPWDRefusal;
UPDATE `Rule` SET `orderRule`=3 where `id` = @ruleUndefinedRefusal;
UPDATE `Rule` SET `orderRule`=8 where `id` = @ruleSMSnormalchoice;
UPDATE `Rule` SET `orderRule`=9 where `id` = @ruleAuthentMeansChoice;
UPDATE `Rule` SET `orderRule`=10 where `id` = @ruleTAnormal;
UPDATE `Rule` SET `orderRule`=11 where `id` = @rulePasswordnormal;
UPDATE `Rule` SET `orderRule`=12 where `id` = @ruleSMSnormal;
UPDATE `Rule` SET `orderRule`=13 where `id` = @ruleRefusalDefault;

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'PASSWORD_AVAILABLE_CHOICE', NULL, NULL, 'PASSWORD (CHOICE)', 'PUSHED_TO_CONFIG', 7, @profilePWDChoice);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @rulePWDchoice = (SELECT id FROM `Rule` WHERE `description`='PASSWORD_AVAILABLE_CHOICE' AND `fk_id_profile`=@profilePWDChoice);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE'), 'PUSHED_TO_CONFIG', @rulePWDchoice),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE'), 'PUSHED_TO_CONFIG', @rulePWDchoice),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_02_MISSING_AUTHENTMEAN'), 'PUSHED_TO_CONFIG', @ruleUndefinedRefusal);
/*!40000 ALTER TABLE `RuleCondition` ENABLE KEYS */;


/* Condition_TransactionStatuses */
/*!40000 ALTER TABLE `Condition_TransactionStatuses` DISABLE KEYS */;
DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_TA_NORMAL'))
                                            AND `id_transactionStatuses` = (SELECT `id` FROM  `TransactionStatuses` WHERE `transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND `reversed`=FALSE);

DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE'))
                                            AND `id_transactionStatuses` = (SELECT `id` FROM  `TransactionStatuses` WHERE `transactionStatusType`='USER_CHOICE_ALLOWED' AND `reversed`=FALSE);

DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE'));


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
    SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
    WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_PWD_AUTHENTMEAN') AND (ts.`transactionStatusType`='KNOWN_PHONE_NUMBER' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
    SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
    WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_MISSING_AUTHENTMEAN') AND (ts.`transactionStatusType`='KNOWN_PHONE_NUMBER' AND ts.`reversed`=TRUE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE') AND (ts.`transactionStatusType`='USER_CHOICE_ALLOWED' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE') AND (ts.`transactionStatusType`='USER_CHOICE_ALLOWED' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);
/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;


/* Condition_MeansProcessStatuses */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_TA_NORMAL'))
                                             AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanPassword AND (`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND `reversed`=FALSE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE'))
                                             AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanUndefined AND (`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND `reversed`=FALSE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE'));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL'))
                                             AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanUndefined AND (`meansProcessStatusType`='MEANS_AVAILABLE' AND `reversed`=FALSE));

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_MISSING_AUTHENTMEAN')
  AND mps.`fk_id_authentMean`=@authMeanINFO AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_MISSING_AUTHENTMEAN')
  AND mps.`fk_id_authentMean`=@authMeanINFO
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_MISSING_AUTHENTMEAN')
  AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_MISSING_AUTHENTMEAN')
  AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);



INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanUndefined
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanPassword
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE')
  AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanPassword
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanPassword
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE')
  AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanUndefined AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanUndefined AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanUndefined AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
  AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);


SET @conditionID = (SELECT `id` FROM `RuleCondition`   WHERE `name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL'));
SET @meansProcessStatusIDTRUE = (SELECT `id` FROM `MeansProcessStatuses` WHERE meansProcessStatusType = 'COMBINED_MEANS_REQUIRED' and fk_id_authentMean = @authMeanPassword AND reversed = TRUE);
SET @meansProcessStatusIDFALSE = (SELECT `id` FROM `MeansProcessStatuses` WHERE meansProcessStatusType = 'COMBINED_MEANS_REQUIRED' and fk_id_authentMean = @authMeanPassword AND reversed = FALSE);

UPDATE `Condition_MeansProcessStatuses` SET `id_meansProcessStatuses` = @meansProcessStatusIDTRUE
                                        WHERE `id_condition` = @conditionID
                                        AND `id_meansProcessStatuses` = @meansProcessStatusIDFALSE;
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* RuleCondition */
DELETE FROM `RuleCondition` WHERE `fk_id_rule` = @ruleSMSnormalchoice AND `name` = CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE');

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = CONCAT('PS_',@BankUB,'_01') AND r.`id` IN (@rulePWDchoice);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;


/* CustomItem */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;
SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @currentAuthentMean = 'PASSWORD';
SET @currentPageType = 'MEANS_PAGE';
SET @Imageid = (SELECT `id` FROM `Image` im WHERE im.name = 'OTP_SMS_Logo' );

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, 'mobileTAN', @MaestroVID, NULL, @customItemSetPassword),

  ('I', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), @MaestroVID, @Imageid, @customItemSetPassword);
/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;