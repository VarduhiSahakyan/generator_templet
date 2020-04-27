/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

SET @createdBy = 'A758582';
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
SET @subIssuerNameAndLabel = 'Luzerner KB AG';
SET @subIssuerCode = '77800';
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
SET @BankUB = 'LUKB';
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
