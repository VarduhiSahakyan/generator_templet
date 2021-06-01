
USE `U5G_ACS_BO`;

SET @issuerCode = '18500';
SET @createdBy ='A699391';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerCode = '18502';
SET @subIssuerID = (SELECT `id` FROM `SubIssuer` WHERE `code` = @subIssuerCode);
SET @BankB = 'Postbank FBK';
SET @BankUB = '18502_PB';
SET @Bank_B = '18502_';


INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_3_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_3_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID);

SET @customItemSetInfoPWDRefusal = (SELECT `id` FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_3_REFUSAL'));

SET @authMeanRefusal = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanACCEPT = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authMeanUndefined = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');
SET @authMeanMobileApp = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP');
SET @authMeanOTPsms = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
SET @authMeanPassword = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'PASSWORD');
SET @authMeanINFO = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'INFO');

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, `dataEntryAllowedPattern`, `dataEntryFormat`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), CONCAT(@Bank_B,'REFUSAL (MISSING PWD AUTHENTMEANS)'), NULL, NULL, CONCAT(@BankUB,'_MISSING_PWD_AUTHENT_MEANS_REFUSAL'), 'PUSHED_TO_CONFIG', -1, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanINFO, @customItemSetInfoPWDRefusal, NULL, NULL, @subIssuerID);

SET @profileUndefinedPWDRefusal = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MISSING_PWD_AUTHENT_MEANS_REFUSAL'));


SET @profileRefusal = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL'));
SET @profileUndefinedRefusal = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MISSING_AUTHENT_MEANS_REFUSAL'));
SET @profileRBAACCEPT = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profileRBADECLINE = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profileTAChoice = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_TA_01'));
SET @profileSMSChoice = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @profileMEANSCHOICE = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_AUTHENT_MEANS_CHOICE_01'));
SET @profilePassword = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_01'));
SET @profileTA = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_TA_02'));
SET @profileSMS = (SELECT `id` FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_02'));


SET @ruleRefusalFraud = (SELECT `id` FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleUndefinedRefusal = (SELECT `id` FROM `Rule` WHERE `description`='REFUSAL_MISSING_AUTHENTMEANS' AND `fk_id_profile`=@profileUndefinedRefusal);
SET @ruleRBAAccept = (SELECT `id` FROM `Rule` WHERE `description`='RBA_ACCEPT' AND `fk_id_profile`=@profileRBAACCEPT);
SET @ruleRBADecline = (SELECT `id` FROM `Rule` WHERE `description`='RBA_DECLINE' AND `fk_id_profile`=@profileRBADECLINE);
SET @ruleTAchoice = (SELECT `id` FROM `Rule` WHERE `description`='TA_AVAILABLE_CHOICE' AND `fk_id_profile`=@profileTAChoice);
SET @ruleSMSnormalchoice = (SELECT `id` FROM `Rule` WHERE `description`='SMS_AVAILABLE_CHOICE' AND `fk_id_profile`=@profileSMSChoice);
SET @ruleAuthentMeansChoice = (SELECT `id` FROM `Rule` WHERE `description`='MEANS_CHOICE_NORMAL' AND `fk_id_profile`=@profileMEANSCHOICE);
SET @rulePasswordnormal = (SELECT `id` FROM `Rule` WHERE `description`='PASSWORD_AVAILABLE_NORMAL' AND `fk_id_profile`=@profilePassword);
SET @ruleTAnormal = (SELECT `id` FROM `Rule` WHERE `description`='TA_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileTA);
SET @ruleSMSnormal = (SELECT `id` FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleRefusalDefault = (SELECT `id` FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'REFUSAL_MISSING_PWD_AUTHENTMEANS', NULL, NULL, 'REFUSAL (MISSING PWD AUTHENTMEANS)', 'PUSHED_TO_CONFIG', 3, @profileUndefinedPWDRefusal);

SET @ruleUndefinedPWDRefusal = (SELECT `id` FROM `Rule` WHERE `description`='REFUSAL_MISSING_PWD_AUTHENTMEANS' AND `fk_id_profile`=@profileUndefinedPWDRefusal);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES 
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_MISSING_PWD_AUTHENTMEAN'), 'PUSHED_TO_CONFIG', @ruleUndefinedPWDRefusal);


UPDATE `Rule` SET `orderRule`=1 where `id` = @ruleRefusalFraud;
UPDATE `Rule` SET `orderRule`=2 where `id` = @ruleUndefinedRefusal;
UPDATE `Rule` SET `orderRule`=4 where `id` = @ruleRBAAccept;
UPDATE `Rule` SET `orderRule`=5 where `id` = @ruleRBADecline;
UPDATE `Rule` SET `orderRule`=6 where `id` = @ruleTAchoice;
UPDATE `Rule` SET `orderRule`=7 where `id` = @ruleSMSnormalchoice;
UPDATE `Rule` SET `orderRule`=8 where `id` = @ruleAuthentMeansChoice;
UPDATE `Rule` SET `orderRule`=9 where `id` = @rulePasswordnormal;
UPDATE `Rule` SET `orderRule`=10 where `id` = @ruleTAnormal;
UPDATE `Rule` SET `orderRule`=11 where `id` = @ruleSMSnormal;
UPDATE `Rule` SET `orderRule`=12 where `id` = @ruleRefusalDefault;
  

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_PWD_AUTHENTMEAN')
    AND mps.`fk_id_authentMean`=@authMeanINFO AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_PWD_AUTHENTMEAN')
    AND mps.`fk_id_authentMean`=@authMeanINFO
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_PWD_AUTHENTMEAN')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);


INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = CONCAT('PS_',@BankUB,'_01') AND r.`id` IN ( @ruleUndefinedPWDRefusal);

SET @ruleConditionUndefinedRefusal = (SELECT `id` FROM `RuleCondition` WHERE `name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTMEAN') AND `fk_id_rule`=@ruleUndefinedRefusal);

SET @mps = (SELECT `id` FROM `MeansProcessStatuses` mps WHERE `meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND `fk_id_authentMean` = @authMeanPassword AND `reversed` = TRUE);

DELETE FROM `Condition_MeansProcessStatuses` where `id_condition` = @ruleConditionUndefinedRefusal AND `id_meansProcessStatuses` = @mps;


/* Elements for the profile MISSING_AUTHENT_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT `id` FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_2_REFUSAL'));
SET @customItemSetInfoPWDRefusal = (SELECT `id` FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_3_REFUSAL'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetInfoPWDRefusal 
FROM `CustomItem` WHERE `fk_id_customItemSet` = @customItemSetREFUSAL;

UPDATE `CustomItem` SET `value` = 'Aus Sicherheitsgründen kann Ihr Einkauf nicht durchgeführt werden. Bitte aktualisieren Sie zunächst Ihr Passwort für den Kreditkarten Online-Service.' 
WHERE `DTYPE` ='T' AND `ordinal` = 1 AND `fk_id_customItemSet` = @customItemSetInfoPWDRefusal;

UPDATE `CustomItem` SET `value` = 'Loggen Sie sich dazu unter https://kreditkarten.postbank.de ein und ändern Sie Ihr Passwort unter "Zugangsdaten > Passwort ändern".' 
WHERE `DTYPE` ='T' AND `ordinal` = 2 AND `fk_id_customItemSet` = @customItemSetInfoPWDRefusal;

UPDATE `CustomItem` SET `value` = 'Weitere Informationen finden Sie hier: www.postbank.de/3d_secure' 
WHERE `DTYPE` ='T' AND `ordinal` = 3 AND `fk_id_customItemSet` = @customItemSetInfoPWDRefusal;