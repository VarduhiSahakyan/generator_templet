
USE `U5G_ACS_BO`;

SET @issuerCode = '18500';
SET @createdBy ='A699391';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerCode = '18502';
SET @subIssuerID = (SELECT `id` FROM `SubIssuer` WHERE `code` = @subIssuerCode);
SET @BankB = 'Postbank FBK';
SET @BankUB = '18502_PB';
SET @Bank_B = '18502_';


    

SET @customItemSetInfoPWDRefusal = (SELECT `id` FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_3_REFUSAL'));

SET @authMeanRefusal = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanACCEPT = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authMeanUndefined = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');
SET @authMeanMobileApp = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP');
SET @authMeanOTPsms = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
SET @authMeanPassword = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'PASSWORD');
SET @authMeanINFO = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'INFO');

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

SET @ruleUndefinedPWDRefusal = (SELECT `id` FROM `Rule` WHERE `description`='REFUSAL_MISSING_PWD_AUTHENTMEANS' AND `fk_id_profile`=@profileUndefinedPWDRefusal);




UPDATE `Rule` SET `orderRule`=1 where `id` = @ruleRefusalFraud;
UPDATE `Rule` SET `orderRule`=2 where `id` = @ruleUndefinedRefusal;
UPDATE `Rule` SET `orderRule`=3 where `id` = @ruleRBAAccept;
UPDATE `Rule` SET `orderRule`=4 where `id` = @ruleRBADecline;
UPDATE `Rule` SET `orderRule`=5 where `id` = @ruleTAchoice;
UPDATE `Rule` SET `orderRule`=6 where `id` = @ruleSMSnormalchoice;
UPDATE `Rule` SET `orderRule`=7 where `id` = @ruleAuthentMeansChoice;
UPDATE `Rule` SET `orderRule`=8 where `id` = @rulePasswordnormal;
UPDATE `Rule` SET `orderRule`=9 where `id` = @ruleTAnormal;
UPDATE `Rule` SET `orderRule`=10 where `id` = @ruleSMSnormal;
UPDATE `Rule` SET `orderRule`=11 where `id` = @ruleRefusalDefault;
  

SET @ruleConditionUndefinedRefusal = (SELECT `id` FROM `RuleCondition` WHERE `name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_PWD_AUTHENTMEAN') AND `fk_id_rule`=@ruleUndefinedPWDRefusal);

DELETE FROM `Condition_MeansProcessStatuses` where `id_condition` = @ruleConditionUndefinedRefusal;

DELETE FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_',@BankUB,'_01_MISSING_PWD_AUTHENTMEAN') AND `fk_id_rule` = @ruleUndefinedPWDRefusal;

DELETE FROM `ProfileSet_Rule` WHERE `id_rule` IN ( @ruleUndefinedPWDRefusal);

DELETE FROM `Rule` WHERE `description` = 'REFUSAL_MISSING_PWD_AUTHENTMEANS' AND `name`= 'REFUSAL (MISSING PWD AUTHENTMEANS)' AND `fk_id_profile` = @profileUndefinedPWDRefusal;

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTMEAN')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);



/* Elements for the profile MISSING_AUTHENT_REFUSAL : */
SET @customItemSetInfoPWDRefusal = (SELECT `id` FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_3_REFUSAL'));

DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` = @customItemSetInfoPWDRefusal;

UPDATE `Profile` SET `fk_id_customItemSetCurrent` = NULL where `id` = @profileUndefinedPWDRefusal;

DELETE FROM `CustomItemSet` WHERE `description` = CONCAT('customitemset_', @BankUB, '_3_REFUSAL_Current') AND `name`= CONCAT('customitemset_', @BankUB, '_3_REFUSAL') AND `fk_id_subIssuer`=@subIssuerID;

DELETE FROM `Profile` WHERE `id` = @profileUndefinedPWDRefusal;
