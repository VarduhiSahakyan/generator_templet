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
}, {
  "authentMeans" : "UNDEFINED",
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

SET @3DS2AdditionalInfo = '{
      "VISA": {
        "operatorId": "acsOperatorVisa",
        "dsKeyAlias": "3DS2-VISA-CERTIFICATION"
      }
}';
INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`,`paChallengePublicUrl`,
                         `verifyCardStatus`,`3DS2AdditionalInfo`,`resendOTPThreshold`, `resendSameOTP`,`combinedAuthenticationAllowed`,
                         `displayLanguageSelectPage`,`trustedBeneficiariesAllowed`,`authentMeans`) VALUES
('ACS_U7G', 120, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
 @updateState, @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
 @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
 @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, 'https://secure.six-group.com/', '1', @3DS2AdditionalInfo,'3', TRUE, FALSE, b'0', b'0', @activatedAuthMeans);
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
SET @authMeanUNDEFINED = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, CONCAT(@BankUB,'_ACCEPT'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanACCEPT, @customItemSetRBAACCEPT, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, CONCAT(@BankUB,'_DECLINE'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanACCEPT, @customItemSetRBADECLINE, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'MOBILE_APP', NULL, NULL, CONCAT(@BankUB,'_TA_01'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authentMeansMobileApp, @customItemSetMOBILEAPP, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'OTP_SMS', NULL, NULL, CONCAT(@BankUB,'_SMS_01'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'INFO', NULL, NULL, CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanINFO, @customItemSetINFORefusal, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'UNDEFINED', NULL, NULL, CONCAT(@BankUB,'_UNDEFINED_01'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanUNDEFINED, NULL, NULL, NULL, @subIssuerID);


/*!40000 ALTER TABLE `Profile` ENABLE KEYS */;

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));
SET @profileRBAACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profileRBADECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profileMOBILEAPP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_TA_01'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @profileINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));
SET @profileUNDEFINED = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_UNDEFINED_01'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', @updateState, 1, @profileRefusal),
  (@createdBy, NOW(), 'MISSING_AUTHENTICATION', NULL, NULL, 'REFUSAL(Missing Authentication)', @updateState,2, @profileINFO),
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, 'NONE (ACCEPT)', @updateState, 3, @profileRBAACCEPT),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, 'REFUSAL (DECLINE)', @updateState, 4, @profileRBADECLINE),
  (@createdBy, NOW(), 'OTP_APP (NORMAL)', NULL, NULL, 'APP (NORMAL)', @updateState, 5, @profileMOBILEAPP),
  (@createdBy, NOW(), 'OTP_SMS_EXT (FALLBACK)', NULL, NULL, 'OTP_SMS_EXT (FALLBACK)', @updateState, 6, @profileSMS),
  (@createdBy, NOW(), 'UNDEFINED', NULL, NULL, 'UNDEFINED', @updateState, 7, @profileUNDEFINED),
  (@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', @updateState, 8, @profileRefusal);
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
SET @ruleUNDEFINED = (SELECT id FROM `Rule` WHERE `description`='UNDEFINED' AND `fk_id_profile`=@profileUNDEFINED);
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
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_FALLBACK'), @updateState, @ruleSMSnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_DEFAULT'), @updateState, @ruleRefusalDefault),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @ruleINFOnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_UNDEFINED'), @updateState, @ruleUNDEFINED);

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
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

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

/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@ruleRefusalFraud, @ruleRBAAccept, @ruleRBADecline, @ruleMobileAppnormal, @ruleSMSnormal, @ruleRefusalDefault, @ruleINFOnormal, @ruleUNDEFINED);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`,`forceAuthent`, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES ('ISSUER', 'TestMerchant', 'NAME', 0, 0, b'0', @issuerId, @subIssuerID);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE = IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS = IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
