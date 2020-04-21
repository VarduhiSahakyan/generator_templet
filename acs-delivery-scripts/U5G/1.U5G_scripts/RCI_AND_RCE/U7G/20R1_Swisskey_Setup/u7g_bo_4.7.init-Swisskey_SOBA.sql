/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

SET @createdBy = 'A757435';
SET @updateState =  'PUSHED_TO_CONFIG';
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
} ]';
SET @issuerCode = '41001';
/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'Baloise Bank SoBa AG';
SET @subIssuerCode = '83340';
/* @backUpLanguage corresponds to a (comma separated) list of locales that should be displayed to the user,
   and @defaultLanguage a default locale which should be selected by default. */
SET @backUpLanguages = 'en,fr,it';
SET @defaultLanguage = 'de';
/* Provides option to call the authentication HUB at PA or VE step */
SET @HUBcallMode = 'PA_ONLY_MODE';
/* Correspond to URL to configure for the BinRanges extraction */
SET @acsURLVEMastercard = 'https://ssl-qlf-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
SET @acsURLVEVisa = 'https://ssl-qlf-u7g-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';
/* Corresponds to the authentication mean to use primarily */
SET @preferredAuthMean = 'MOBILE_APP';
/* See en_countrycode.json, 250 is France's country code. It is important in order to know if the transaction
   was initiated from an IP from the same location as the ACS (local purchase) */
SET @issuerCountryCode = '250';
SET @maskParam = '*,6,4';
SET @dateFormat = 'DD.MM.YYYY HH:mm|CET';

INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`, `paChallengePublicUrl`,`verifyCardStatus`,`resendOTPThreshold`, `resendSameOTP`,`combinedAuthenticationAllowed`,
                         `displayLanguageSelectPage`,`trustedBeneficiariesAllowed`,`authentMeans`) VALUES
  ('ACS_U7G', 120, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
   @updateState, @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
   @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
   @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, 'https://secure.six-group.com', '1', '3', TRUE, FALSE, b'0', b'0', @activatedAuthMeans);
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
SET @BankB = 'SWISSKEY';
SET @BankUB = 'SOBA';
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT @createdBy, NOW(), CONCAT(@BankB, ' profile set'), NULL, NULL, CONCAT('PS_', @BankUB, '_01'), @updateState, si.id
    FROM `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID;
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;


SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

/* CustomPageLayout_ProfileSet - Link the predefined layouts to the profileSet (in order to see the templates) */
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` DISABLE KEYS */;
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
    SELECT cpl.id, p.id
    FROM `CustomPageLayout` cpl, `ProfileSet` p
    WHERE cpl.description like CONCAT('%(', @BankB, '%') and p.id = @ProfileSet;
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` ENABLE KEYS */;

/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.
  Or, rather, use the tool in the Back-Office (Custom items creator) and then extract the information from the database */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`, `relativePath`)
VALUES (@createdBy, NOW(), CONCAT(@BankUB,' Logo'), NULL, NULL, @BankUB, 'PUSHED_TO_CONFIG', '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',
        '/');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
SET @status = 'DEPLOYED_IN_PRODUCTION';
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBADECLINE_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_RBADECLINE'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBAACCEPT_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_RBAACCEPT'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_MOBILE_APP_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_MOBILE_APP'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_SMS'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '__MISSING_AUTHENTICATION_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @customItemSetRBAACCEPT = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_RBAACCEPT'));
SET @customItemSetRBADECLINE = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_RBADECLINE'));
SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetINFORefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanACCEPT = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'MOBILE_APP');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanINFO = (SELECT id FROM `AuthentMeans` WHERE `name` = 'INFO');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, CONCAT(@BankUB,'_ACCEPT'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanACCEPT, @customItemSetRBAACCEPT, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, CONCAT(@BankUB,'_DECLINE'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanACCEPT, @customItemSetRBADECLINE, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'MOBILE_APP', NULL, NULL, CONCAT(@BankUB,'_TA_01'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authentMeansMobileApp, @customItemSetMOBILEAPP, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'OTP_SMS', NULL, NULL, CONCAT(@BankUB,'_SMS_01'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'INFO', NULL, NULL, CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanINFO, @customItemSetINFORefusal, NULL, NULL, @subIssuerID);


/*!40000 ALTER TABLE `Profile` ENABLE KEYS */;

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));
SET @profileRBAACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profileRBADECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profileMOBILEAPP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_TA_01'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @profileINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', @updateState, 1, @profileRefusal),
  (@createdBy, NOW(), 'MISSING_AUTHENTICATION', NULL, NULL, 'REFUSAL(Missing Authentication)', @updateState,2, @profileINFO),
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, 'NONE (ACCEPT)', @updateState, 3, @profileRBAACCEPT),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, 'REFUSAL (DECLINE)', @updateState, 4, @profileRBADECLINE),
  (@createdBy, NOW(), 'OTP_APP (NORMAL)', NULL, NULL, 'APP (NORMAL)', @updateState, 5, @profileMOBILEAPP),
  (@createdBy, NOW(), 'OTP_SMS_EXT (FALLBACK)', NULL, NULL, 'OTP_SMS_EXT (FALLBACK)', @updateState, 6, @profileSMS),
  (@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', @updateState, 7, @profileRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FRAUD' AND `fk_id_profile` = @profileRefusal);
SET @ruleRBAAccept = (SELECT id FROM `Rule` WHERE `description` = 'RBA_ACCEPT' AND `fk_id_profile` = @profileRBAACCEPT);
SET @ruleRBADecline = (SELECT id FROM `Rule` WHERE `description` = 'RBA_DECLINE' AND `fk_id_profile` = @profileRBADECLINE);
SET @ruleMobileAppnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_APP (NORMAL)' AND `fk_id_profile` = @profileMOBILEAPP);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (FALLBACK)' AND `fk_id_profile` = @profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileRefusal);
SET @ruleINFOnormal = (SELECT id FROM `Rule` WHERE `description`='MISSING_AUTHENTICATION' AND `fk_id_profile`=@profileINFO);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_FRAUD'), @updateState, @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_FRAUD'), @updateState, @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_03_FRAUD'), @updateState, @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_04_FRAUD'), @updateState, @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_05_FRAUD'), @updateState, @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_RBA_ACCEPT'), @updateState, @ruleRBAAccept),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_RBA_DECLINE'), @updateState, @ruleRBADecline),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL'), @updateState, @ruleMobileAppnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_FALLBACK'), @updateState, @ruleSMSnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_DEFAULT'), @updateState, @ruleRefusalDefault),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @ruleINFOnormal);

/*!40000 ALTER TABLE `RuleCondition` ENABLE KEYS */;

/* Condition_TransactionStatuses */
/*!40000 ALTER TABLE `Condition_TransactionStatuses` DISABLE KEYS */;

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_FRAUD') AND (ts.`transactionStatusType` = 'PAYMENT_MEANS_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_FRAUD') AND (ts.`transactionStatusType` = 'CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_03_FRAUD') AND (ts.`transactionStatusType` = 'CARD_HOLDER_COUNTRY_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_04_FRAUD') AND (ts.`transactionStatusType` = 'MERCHANT_URL_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_05_FRAUD') AND (ts.`transactionStatusType` = 'PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_RBA_ACCEPT') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_RBA_ACCEPT') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_RBA_DECLINE') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_RBA_DECLINE') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = FALSE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_DEFAULT') AND (ts.`transactionStatusType` = 'DEFAULT' AND ts.`reversed` = FALSE);

/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;

/* Condition_MeansProcessStatuses */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_FALLBACK')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_FALLBACK')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_FALLBACK')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTICATION_REFUSAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTICATION_REFUSAL')
    AND mps.`fk_id_authentMean`=@authMeanINFO
    AND (mps.`meansProcessStatusType` IN ('MEANS_AVAILABLE') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTICATION_REFUSAL')
    AND mps.`fk_id_authentMean`=@authMeanINFO AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

SET @authMeanMobileApp =(SELECT id FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP');
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTICATION_REFUSAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@ruleRefusalFraud, @ruleRBAAccept, @ruleRBADecline, @ruleMobileAppnormal, @ruleSMSnormal, @ruleRefusalDefault, @ruleINFOnormal);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`,`forceAuthent`, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES ('ISSUER', 'TestMerchant', 'NAME', 0, 0, b'0', @issuerId, @subIssuerID);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE = IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS = IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
