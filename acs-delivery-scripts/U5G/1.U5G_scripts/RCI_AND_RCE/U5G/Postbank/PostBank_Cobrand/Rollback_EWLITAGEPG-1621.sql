USE `U5G_ACS_BO`;

SET @issuerCode = '18500';
SET @createdBy ='A758582';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerCode = '18502';
SET @subIssuerID = (SELECT `id` FROM `SubIssuer` WHERE `code` = @subIssuerCode);
SET @BankB = 'Postbank FBK';
SET @BankUB = '18502_PB';
SET @Bank_B = '18502_';

/* ProfileSet_Rule */
SET @profilePWDChoice = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_01'));
SET @profileSMSChoice = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @rulePWDchoice = (SELECT id FROM `Rule` WHERE `description`='PASSWORD_AVAILABLE_CHOICE' AND `fk_id_profile`=@profilePWDChoice);
SET @ruleSMSnormalchoice = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_CHOICE' AND `fk_id_profile`=@profileSMSChoice);

delete from ProfileSet_Rule where `id_rule` = @rulePWDchoice;

/* RuleCondition */
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE'), 'PUSHED_TO_CONFIG', @ruleSMSnormalchoice);



/* Condition_MeansProcessStatuses */
SET @authMeanPassword = (SELECT id FROM `AuthentMeans` WHERE `name` = 'PASSWORD');
SET @authMeanUndefined = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');
SET @authMeanMobileApp = (SELECT id FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE'));
DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE'));
DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_03_PASSWORD_CHOICE'));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE'))
                                             AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanUndefined AND (`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE'))
                                             AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanOTPsms AND (`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE'))
                                             AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanMobileApp AND (`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE'))
                                             AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanPassword AND (`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND `reversed`=FALSE));



DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL'))
                                             AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanPassword AND (`meansProcessStatusType`='MEANS_AVAILABLE' AND `reversed`=FALSE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL'))
                                             AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanUndefined AND (`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND `reversed`=TRUE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL'))
                                             AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanUndefined AND (`meansProcessStatusType`='MEANS_AVAILABLE' AND `reversed`=FALSE));

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL'))
                                             AND `id_meansProcessStatuses` = (SELECT `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanPassword AND (`meansProcessStatusType`='MEANS_DISABLED' AND `reversed`=TRUE));


SET @conditionID = (SELECT `id` FROM `RuleCondition`   WHERE `name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL'));
SET @meansProcessStatusIDTRUE = (SELECT `id` FROM `MeansProcessStatuses` WHERE meansProcessStatusType = 'COMBINED_MEANS_REQUIRED' and fk_id_authentMean = @authMeanPassword AND reversed = TRUE);
SET @meansProcessStatusIDFALSE = (SELECT `id` FROM `MeansProcessStatuses` WHERE meansProcessStatusType = 'COMBINED_MEANS_REQUIRED' and fk_id_authentMean = @authMeanPassword AND reversed = FALSE);

UPDATE `Condition_MeansProcessStatuses` SET `id_meansProcessStatuses` = @meansProcessStatusIDFALSE
                                        WHERE `id_condition` = @conditionID
                                        AND `id_meansProcessStatuses` = @meansProcessStatusIDTRUE;

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTMEAN')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_TA_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanUndefined
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanUndefined
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanUndefined AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);



/* Condition_TransactionStatuses */
DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE'));
DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE'));
DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_03_PASSWORD_CHOICE'));

DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE'))
                                            AND `id_transactionStatuses` = (SELECT `id` FROM  `TransactionStatuses` WHERE `transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND `reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_TA_NORMAL') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE') AND (ts.`transactionStatusType`='USER_CHOICE_ALLOWED' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE') AND (ts.`transactionStatusType`='USER_CHOICE_ALLOWED' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE') AND (ts.`transactionStatusType`='PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE') AND (ts.`transactionStatusType`='KNOWN_PHONE_NUMBER' AND ts.`reversed`=FALSE);


/* RuleCondition */
DELETE FROM `RuleCondition` WHERE `fk_id_rule` = @rulePWDchoice AND `name` = CONCAT('C1_P_',@BankUB,'_01_PASSWORD_CHOICE');
DELETE FROM `RuleCondition` WHERE `fk_id_rule` = @rulePWDchoice AND `name` = CONCAT('C1_P_',@BankUB,'_02_PASSWORD_CHOICE');
DELETE FROM `RuleCondition` WHERE `fk_id_rule` = @rulePWDchoice AND `name` = CONCAT('C1_P_',@BankUB,'_03_PASSWORD_CHOICE');


/* Rule */
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


UPDATE Rule SET orderRule=3 where id = @ruleUndefinedPWDRefusal;
UPDATE Rule SET orderRule=2 where id = @ruleUndefinedRefusal;
UPDATE Rule SET orderRule=7 where id = @ruleSMSnormalchoice;
UPDATE Rule SET orderRule=8 where id = @ruleAuthentMeansChoice;
UPDATE Rule SET orderRule=9 where id = @ruleTAnormal;
UPDATE Rule SET orderRule=10 where id = @rulePasswordnormal;
UPDATE Rule SET orderRule=11 where id = @ruleSMSnormal;
UPDATE Rule SET orderRule=12 where id = @ruleRefusalDefault;

DELETE FROM Rule WHERE fk_id_profile = @profilePWDChoice AND description = 'PASSWORD_AVAILABLE_CHOICE';

/* Profile */
SET @customItemSetPWDChoice = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_PASSWORD_Choice'));
SET @customItemSetPassword = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_PASSWORD'));

DELETE FROM Profile WHERE  fk_id_customItemSetCurrent = @customItemSetPWDChoice AND description = CONCAT(@Bank_B,'PASSWORD (CHOICE)');

UPDATE Profile SET name = CONCAT(@BankUB,'_PASSWORD_01') WHERE fk_id_authentMeans = @authMeanPassword AND fk_id_customItemSetCurrent = @customItemSetPassword;

/* CustomItemSet */
DELETE FROM CustomItemSet WHERE fk_id_subIssuer = @subIssuerID AND description = CONCAT('customitemset_', @BankUB, '_PASSWORD_Choice');