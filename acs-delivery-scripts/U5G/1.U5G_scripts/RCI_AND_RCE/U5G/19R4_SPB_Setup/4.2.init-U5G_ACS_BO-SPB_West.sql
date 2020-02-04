/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

SET @issuerCode = '16950';
SET @createdBy = 'A707825';

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'SBK_West';
SET @subIssuerCode = '13606';
/* @backUpLanguage corresponds to a (comma separated) list of locales that should be displayed to the user,
   and @defaultLanguage a default locale which should be selected by default. */
SET @backUpLanguages = '';
SET @defaultLanguage = 'de';
/* Provides option to call the authentication HUB at PA or VE step */
SET @HUBcallMode = 'PA_ONLY_MODE';
/* Correspond to URL to configure for the BinRanges extraction */
SET @acsURLVEMastercard = 'https://ssl-qlf-u5g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
SET @acsURLVEVisa = 'https://ssl-qlf-u5g-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';
/* Corresponds to the authentication mean to use primarily */
SET @preferredAuthMean = 'EXT_PASSWORD';
/* See en_countrycode.json, 250 is France's country code. It is important in order to know if the transaction
   was initiated from an IP from the same location as the ACS (local purchase) */
SET @issuerCountryCode = '250';
SET @maskParam = '*,6,4';
SET @dateFormat = 'DD.MM.YYYY HH:mm';

SET @activatedAuthMeans = '[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "EXT_PASSWORD",
  "validate" : true
}, {
  "authentMeans" : "UNDEFINED",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
}, {
  "authentMeans" : "CHIP_TAN",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP_EXT",
  "validate" : true
} ]';

INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`, `resendSameOTP`,`combinedAuthenticationAllowed`,
                         authentMeans) VALUES
  ('ACS_U5G', 120, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
   'PUSHED_TO_CONFIG', @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
   @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
   @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, TRUE, TRUE, @activatedAuthMeans);
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;

SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
--  /!\ SubIssuerCrypto                                                               /!\
--  /!\ This is a very specific configuration, in production environment only,        /!\
--  /!\ for internal and external acceptance, use the one given here                  /!\
--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
/*!40000 ALTER TABLE `SubIssuerCrypto` DISABLE KEYS */;
INSERT INTO `SubIssuerCrypto` (`acsIdForCrypto`, `binKeyIdentifier`, `cavvKeyIndicator`, `cipherKeyIdentifier`,
                               `desCipherKeyIdentifier`, `desKeyId`, `hubAESKey`, `secondFactorAuthentication`, `fk_id_subIssuer`)
    SELECT '0A', '1', '03', 'EC11223344554B544F4B5F4D5554555F414301', 'EC11223344554B544F4B5F4D5554555F414300', '1', '01', 'NO_SECOND_FACTOR', si.id
    FROM `SubIssuer` si WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID;
/*!40000 ALTER TABLE `SubIssuerCrypto` ENABLE KEYS */;

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'SBK_West';
SET @BankUB = 'SBK_West';
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT @createdBy, NOW(), CONCAT(@BankB, ' profile set'), NULL, NULL, CONCAT('PS_', @BankUB, '_01'), 'PUSHED_TO_CONFIG', si.id
    FROM `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID;
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;

/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.
  Or, rather, use the tool in the Back-Office (Custom items creator) and then extract the information from the database */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, relativePath, `binaryData`)
VALUES (@createdBy, NOW(), CONCAT(@BankB,' Logo'), NULL, NULL, @BankB, 'PUSHED_TO_CONFIG', '<placeholder>', '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');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_TE_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_TE_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_FE_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_FE_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBADECLINE_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_RBADECLINE'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBAACCEPT_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_RBAACCEPT'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_PASSWORD_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_PASSWORD'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_UNDEFINED_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_UNDEFINED'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_CHOICE_ALL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_CHOICE_ALL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_CHIP_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_SMS_CHIP'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_CHIP_APP_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_CHIP_APP'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_APP_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_SMS_APP'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_SMS'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_CHIP_TAN'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_CHIP_TAN'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_DEFAULT_REFUSAL'));
SET @customItemSetRefusalTE = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_TE_REFUSAL'));
SET @customItemSetRefusalFE = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_FE_REFUSAL'));
SET @customItemSetRBADECLINE = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_RBADECLINE'));
SET @customItemSetRBAACCEPT = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_RBAACCEPT'));
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_PASSWORD'));
SET @customItemSetUndefined = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_UNDEFINED'));
SET @customItemSetChoiceAll = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_CHOICE_ALL'));
SET @customItemSetChoiceSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_SMS_CHIP'));
SET @customItemSetChoiceChipApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_CHIP_APP'));
SET @customItemSetChoiceSMSApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_SMS_APP'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_SMS'));
SET @customItemSetCHIPTAN = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_CHIP_TAN'));
SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanACCEPT = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authMeanPassword = (SELECT id FROM `AuthentMeans` WHERE `name` = 'EXT_PASSWORD');
SET @authMeanUndefined = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanOTPchiptan = (SELECT id FROM `AuthentMeans` WHERE `name` = 'CHIP_TAN');
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'MOBILE_APP_EXT');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, dataEntryFormat, dataEntryAllowedPattern, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), 'TECHNICAL ERROR', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL_TE'), 'PUSHED_TO_CONFIG', -1, '^[^OIi]*$', '7:(:DIGIT:1)', @authMeanRefusal, @customItemSetRefusalTE, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'FUNCTIONAL ERROR', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL_FE'), 'PUSHED_TO_CONFIG', -1, '^[^OIi]*$', '7:(:DIGIT:1)', @authMeanRefusal, @customItemSetRefusalFE, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, CONCAT(@BankUB,'_DECLINE'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '7:(:DIGIT:1)', @authMeanACCEPT, @customItemSetRBADECLINE, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, CONCAT(@BankUB,'_ACCEPT'), 'PUSHED_TO_CONFIG', 3,'^[^OIi]*$', '7:(:DIGIT:1)' , @authMeanACCEPT, @customItemSetRBAACCEPT, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'EXT PASSWORD (NORMAL)', NULL, NULL, CONCAT(@BankUB,'_PASSWORD_01'), 'PUSHED_TO_CONFIG', 3,'^[^OIi]*$', '7:(:DIGIT:1)' , @authMeanPassword, @customItemSetPassword, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'UNDEFINED', NULL, NULL, CONCAT(@BankUB,'_UNDEFINED_01'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '7:(:DIGIT:1)', @authMeanUndefined, @customItemSetUndefined, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'CHOICE_ALL', NULL, NULL, CONCAT(@BankUB,'_AUTHENT_MEANS_CHOICE_ALL'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '7:(:DIGIT:1)', @authMeanUndefined, @customItemSetChoiceAll, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'CHOICE_SMS_CHIP', NULL, NULL, CONCAT(@BankUB,'_AUTHENT_MEANS_CHOICE_SMS_CHIP'), 'PUSHED_TO_CONFIG', 3,'^[^OIi]*$', '7:(:DIGIT:1)' , @authMeanUndefined, @customItemSetChoiceSMS, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'CHOICE_CHIP_APP', NULL, NULL, CONCAT(@BankUB,'_AUTHENT_MEANS_CHOICE_CHIP_APP'), 'PUSHED_TO_CONFIG', 3,'^[^OIi]*$', '7:(:DIGIT:1)' , @authMeanUndefined, @customItemSetChoiceChipApp, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'CHOICE_SMS_APP', NULL, NULL, CONCAT(@BankUB,'_AUTHENT_MEANS_CHOICE_SMS_APP'), 'PUSHED_TO_CONFIG', 3,'^[^OIi]*$', '7:(:DIGIT:1)' , @authMeanUndefined, @customItemSetChoiceSMSApp, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'OTP_SMS', NULL, NULL, CONCAT(@BankUB,'_SMS_01'), 'PUSHED_TO_CONFIG', 3,'^[^OIi]*$', '7:(:DIGIT:1)' , @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'CHIPTAN', NULL, NULL, CONCAT(@BankUB,'_CHIPTAN_01'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '7:(:DIGIT:1)', @authMeanOTPchiptan, @customItemSetCHIPTAN, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'MOBILE_APP', NULL, NULL, CONCAT(@BankUB,'_APP_01'), 'PUSHED_TO_CONFIG', 3,'^[^OIi]*$', '7:(:DIGIT:1)' , @authentMeansMobileApp, @customItemSetMOBILEAPP, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', -1,'^[^OIi]*$', '7:(:DIGIT:1)',  @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `Profile` ENABLE KEYS */;

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));
SET @profileRefusalTE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL_TE'));
SET @profileRefusalFE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL_FE'));
SET @profileRBADECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profileRBAACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profilePassword = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_01'));
SET @profileUndefined = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_UNDEFINED_01'));
SET @profileCHOICE_ALL = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_AUTHENT_MEANS_CHOICE_ALL'));
SET @profileSMS_CHIP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_AUTHENT_MEANS_CHOICE_SMS_CHIP'));
SET @profileCHIP_APP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_AUTHENT_MEANS_CHOICE_CHIP_APP'));
SET @profileSMS_APP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_AUTHENT_MEANS_CHOICE_SMS_APP'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @profileCHIPTAN = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_CHIPTAN_01'));
SET @profileMOBILEAPP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_APP_01'));

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'REFUSAL_TECHNICAL_ERROR', NULL, NULL, 'TECHNICAL_ERROR', 'PUSHED_TO_CONFIG', 1, @profileRefusalTE),
  (@createdBy, NOW(), 'REFUSAL_FUNCTIONAL_ERROR', NULL, NULL, 'FUNCTIONAL_ERROR', 'PUSHED_TO_CONFIG', 2, @profileRefusalFE),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, 'REFUSAL (DECLINE)', 'PUSHED_TO_CONFIG', 3, @profileRBADECLINE),
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, 'NONE (ACCEPT)', 'PUSHED_TO_CONFIG', 4, @profileRBAACCEPT),
  (@createdBy, NOW(), 'PASSWORD_AVAILABLE_NORMAL', NULL, NULL, 'EXT_PASSWORD (NORMAL)', 'PUSHED_TO_CONFIG', 5, @profilePassword),
  (@createdBy, NOW(), 'UNDEFINED_NORMAL', NULL, NULL, 'UNDEFINED (NORMAL)', 'PUSHED_TO_CONFIG', 6, @profileUndefined),
  (@createdBy, NOW(), 'ALL METHODS AVAILABLE', NULL, NULL, 'ALL METHODS AVAILABLE', 'PUSHED_TO_CONFIG', 7, @profileCHOICE_ALL),
  (@createdBy, NOW(), 'SMS & CHIPTAN AVAILABLE', NULL, NULL, 'SMS & CHIPTAN AVAILABLE', 'PUSHED_TO_CONFIG', 8, @profileSMS_CHIP),
  (@createdBy, NOW(), 'CHIPTAN & APP AVAILABLE', NULL, NULL, 'CHIPTAN & APP AVAILABLE', 'PUSHED_TO_CONFIG', 9, @profileCHIP_APP),
  (@createdBy, NOW(), 'SMS & APP AVAILABLE', NULL, NULL, 'SMS & APP AVAILABLE', 'PUSHED_TO_CONFIG', 10, @profileSMS_APP),
  (@createdBy, NOW(), 'SMS_AVAILABLE_NORMAL', NULL, NULL, 'OTP_SMS (NORMAL)', 'PUSHED_TO_CONFIG', 11, @profileSMS),
  (@createdBy, NOW(), 'CHIP_TAN (NORMAL)', NULL, NULL, 'CHIP_TAN (NORMAL)', 'PUSHED_TO_CONFIG', 12, @profileCHIPTAN),
  (@createdBy, NOW(), 'OTP_APP (NORMAL)', NULL, NULL, 'APP (NORMAL)', 'PUSHED_TO_CONFIG', 13, @profileMOBILEAPP),
  (@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 14, @profileRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalTE = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_TECHNICAL_ERROR' AND `fk_id_profile` = @profileRefusalTE);
SET @ruleRefusalFE = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FUNCTIONAL_ERROR' AND `fk_id_profile` = @profileRefusalFE);
SET @ruleRBADecline = (SELECT id FROM `Rule` WHERE `description` = 'RBA_DECLINE' AND `fk_id_profile` = @profileRBADECLINE);
SET @ruleRBAAccept = (SELECT id FROM `Rule` WHERE `description` = 'RBA_ACCEPT' AND `fk_id_profile` = @profileRBAACCEPT);
SET @rulePasswordnormal = (SELECT id FROM `Rule` WHERE `description` = 'PASSWORD_AVAILABLE_NORMAL' AND `fk_id_profile` = @profilePassword);
SET @ruleUndefinednormal = (SELECT id FROM `Rule` WHERE `description` = 'UNDEFINED_NORMAL' AND `fk_id_profile` = @profileUndefined);
SET @ruleCHOICE_ALL = (SELECT id FROM `Rule` WHERE `description` = 'ALL METHODS AVAILABLE' AND `fk_id_profile` = @profileCHOICE_ALL);
SET @ruleSMS_CHIP = (SELECT id FROM `Rule` WHERE `description` = 'SMS & CHIPTAN AVAILABLE' AND `fk_id_profile` = @profileSMS_CHIP);
SET @ruleCHIP_APP = (SELECT id FROM `Rule` WHERE `description` = 'CHIPTAN & APP AVAILABLE' AND `fk_id_profile` = @profileCHIP_APP);
SET @ruleSMS_APP = (SELECT id FROM `Rule` WHERE `description` = 'SMS & APP AVAILABLE' AND `fk_id_profile` = @profileSMS_APP);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description` = 'SMS_AVAILABLE_NORMAL' AND `fk_id_profile` = @profileSMS);
SET @ruleChipTannormal = (SELECT id FROM `Rule` WHERE `description` = 'CHIP_TAN (NORMAL)' AND `fk_id_profile` = @profileCHIPTAN);
SET @ruleMobileAppnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_APP (NORMAL)' AND `fk_id_profile` = @profileMOBILEAPP);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileRefusal);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_TECHNICAL_ERROR'), 'PUSHED_TO_CONFIG', @ruleRefusalTE),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_TECHNICAL_ERROR'), 'PUSHED_TO_CONFIG', @ruleRefusalTE),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_03_TECHNICAL_ERROR'), 'PUSHED_TO_CONFIG', @ruleRefusalTE),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_04_TECHNICAL_ERROR'), 'PUSHED_TO_CONFIG', @ruleRefusalTE),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_FUNCTIONAL_ERROR'), 'PUSHED_TO_CONFIG', @ruleRefusalFE),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_FUNCTIONAL_ERROR'), 'PUSHED_TO_CONFIG', @ruleRefusalFE),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_RBA_DECLINE'), 'PUSHED_TO_CONFIG', @ruleRBADecline),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_RBA_ACCEPT'), 'PUSHED_TO_CONFIG', @ruleRBAAccept),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_PASSWORD_NORMAL'), 'PUSHED_TO_CONFIG', @rulePasswordnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_UNDEFINED_NORMAL'), 'PUSHED_TO_CONFIG', @ruleUndefinednormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL'), 'PUSHED_TO_CONFIG', @ruleCHOICE_ALL),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_CHIP'), 'PUSHED_TO_CONFIG', @ruleSMS_CHIP),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_CHOICE_CHIP_APP'), 'PUSHED_TO_CONFIG', @ruleCHIP_APP),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_APP'), 'PUSHED_TO_CONFIG', @ruleSMS_APP),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_NORMAL'), 'PUSHED_TO_CONFIG', @ruleSMSnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_CHIP_TAN_NORMAL'), 'PUSHED_TO_CONFIG', @ruleChipTannormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL'), 'PUSHED_TO_CONFIG', @ruleMobileAppnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_DEFAULT'), 'PUSHED_TO_CONFIG', @ruleRefusalDefault);
/*!40000 ALTER TABLE `RuleCondition` ENABLE KEYS */;

/* Condition_TransactionStatuses */
/*!40000 ALTER TABLE `Condition_TransactionStatuses` DISABLE KEYS */;

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_TECHNICAL_ERROR') AND (ts.`transactionStatusType` = 'PAYMENT_MEANS_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_TECHNICAL_ERROR') AND (ts.`transactionStatusType` = 'CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_03_TECHNICAL_ERROR') AND (ts.`transactionStatusType` = 'CARD_HOLDER_COUNTRY_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_04_TECHNICAL_ERROR') AND (ts.`transactionStatusType` = 'MERCHANT_URL_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_FUNCTIONAL_ERROR') AND (ts.`transactionStatusType` = 'CARD_HOLDER_BLOCKED' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_FUNCTIONAL_ERROR') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_RBA_DECLINE') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_RBA_DECLINE') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_RBA_ACCEPT') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_RBA_ACCEPT') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PASSWORD_NORMAL') AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PASSWORD_NORMAL') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PASSWORD_NORMAL') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_UNDEFINED_NORMAL') AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_CHIP') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_CHIP') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_CHIP_APP') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_CHIP_APP') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_APP') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_APP') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_NORMAL') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_NORMAL') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_NORMAL') AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHIP_TAN_NORMAL') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHIP_TAN_NORMAL') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHIP_TAN_NORMAL') AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED ' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL') AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED ' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_DEFAULT') AND (ts.`transactionStatusType` = 'DEFAULT' AND ts.`reversed` = FALSE);
/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;

/* Condition_MeansProcessStatuses */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;

# INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
#   SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
#   WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_TECHNICAL_ERROR')
#     AND mps.`fk_id_authentMean` = @authMeanRefusal
#     AND (mps.`meansProcessStatusType` IN ('PAYMENT_MEANS_IN_NEGATIVE_LIST') AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanPassword
    AND (mps.`meansProcessStatusType` IN ('COMBINED_MEANS_REQUIRED') AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanPassword
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanPassword
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanPassword
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_UNDEFINED_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanUndefined
    AND (mps.`meansProcessStatusType` = 'FORCED_MEANS_USAGE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_UNDEFINED_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanPassword
    AND (mps.`meansProcessStatusType` IN ('COMBINED_MEANS_REQUIRED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_UNDEFINED_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_UNDEFINED_NORMAL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_UNDEFINED_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL')
    AND mps.`fk_id_authentMean` = @authMeanUndefined
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_ALL')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_CHIP')
    AND mps.`fk_id_authentMean` = @authMeanUndefined
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_CHIP')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_CHIP')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_CHIP')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_CHIP')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_CHIP')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_CHIP')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_CHIP_APP')
    AND mps.`fk_id_authentMean` = @authMeanUndefined
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_CHIP_APP')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_CHIP_APP')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_CHIP_APP')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_CHIP_APP')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_CHIP_APP')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_CHIP_APP')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_APP')
    AND mps.`fk_id_authentMean` = @authMeanUndefined
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_APP')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_APP')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_APP')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_APP')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_APP')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHOICE_SMS_APP')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

SET @authMeanOTPchiptan = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'CHIP_TAN');
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHIP_TAN_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHIP_TAN_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_CHIP_TAN_NORMAL')
    AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
    AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@ruleRefusalTE, @ruleRefusalFE, @ruleRBADecline, @ruleRBAAccept, @rulePasswordnormal, @ruleUndefinednormal,
                                                                   @ruleSMSnormal, @ruleMobileAppnormal, @ruleChipTannormal, @ruleSMS_APP, @ruleCHIP_APP, @ruleSMS_CHIP, @ruleCHOICE_ALL, @ruleRefusalDefault);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`, forceAuthent, expertMode, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES ('ISSUER', 'TestMerchant', 'NAME', 0, 0, 0, 0, @issuerId, @subIssuerID);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE = IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS = IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
