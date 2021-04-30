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
SET @subIssuerNameAndLabel = 'Neue Aargauer Bank';
SET @subIssuerCode = '58810';
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
SET @BankUB = 'NAB';
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
