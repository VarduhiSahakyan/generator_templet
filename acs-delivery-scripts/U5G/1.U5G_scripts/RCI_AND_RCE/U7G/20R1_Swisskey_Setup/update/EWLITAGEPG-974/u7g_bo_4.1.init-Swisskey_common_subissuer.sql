/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

SET @createdBy = 'A757435';
SET @updateState =  'PUSHED_TO_CONFIG';
/* Issuer
   At first, the different authentication means need to be activated, so 'validate' is set to 'true'.
*/
SET @activatedAuthMeans = '[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
}, {
  "authentMeans" : "PWD_OTP",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP",
  "validate" : true
}, {
  "authentMeans" : "PASSWORD",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS",
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
SET @subIssuerNameAndLabel = 'Swisskey AG';
SET @subIssuerCode = '41001';
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
SET @currencyFormat = '{
                            "useAlphaCurrencySymbol":true,
                            "currencySymbolPosition":"LEFT",
                            "decimalDelimiter":".",
                            "thousandDelimiter":"''"
                        }';

SET @3DS2AdditionalInfo = '{
      "VISA": {
        "operatorId": "acsOperatorVisa",
        "dsKeyAlias": "3DS2-VISA-CERTIFICATION"
      },
      "MASTERCARD": {
        "operatorId": "acsOperatorMasterCard",
        "dsKeyAlias": "key-masterCard"
      }
}';

SET @subIssuerIDNAB = (SELECT id FROM SubIssuer where code = 58810 AND name = 'Neue Aargauer Bank');
SET @cryptoConfigIDNAB = (SELECT fk_id_cryptoConfig FROM SubIssuer where code = 58810 AND name = 'Neue Aargauer Bank');
INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`,`paChallengePublicUrl`,
                         `verifyCardStatus`,`3DS2AdditionalInfo`,`resendOTPThreshold`, `resendSameOTP`,`combinedAuthenticationAllowed`,
                         `displayLanguageSelectPage`,`trustedBeneficiariesAllowed`,`authentMeans`, `fk_id_cryptoConfig`, `npaEnabled`) VALUES
('ACS_U7G', 120, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
 @updateState, @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
 @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
 @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, NULL, '1', @3DS2AdditionalInfo,'3', TRUE, FALSE, b'0', b'0', @activatedAuthMeans, @cryptoConfigIDNAB, TRUE);
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;

SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

SET @BankB = 'SWISSKEY';
SET @BankUB = 'SWISSKEY';
SET @BankUBSGKB = 'SGKB';
SET @BankUBLLB = 'LLB';
SET @subIssuerCodeSGKB = '78100';
SET @subIssuerCodeLLB = '88000';
set @subIssuerIDSGKB = (SELECT `id` from SubIssuer where `fk_id_issuer` = @issuerId and `code` = @subIssuerCodeSGKB);
set @subIssuerIDLLB = (SELECT `id` from SubIssuer where `fk_id_issuer` = @issuerId and `code` = @subIssuerCodeLLB);

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;

UPDATE `ProfileSet` SET `name` = CONCAT('PS_', @BankB, '_01'),
                        `fk_id_subIssuer` = @subIssuerID
                    WHERE `fk_id_subIssuer` = @subIssuerIDSGKB;
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;


/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
SET @status = 'DEPLOYED_IN_PRODUCTION';

UPDATE `CustomItemSet` SET `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'),
                           `description` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'),
                           `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT('customitemset_', @BankUBSGKB, '_DEFAULT_REFUSAL');

UPDATE `CustomItemSet` SET `name` = CONCAT('customitemset_', @BankUB, '_RBADECLINE'),
                           `description` = CONCAT('customitemset_', @BankUB, '_RBADECLINE_Current'),
                           `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT('customitemset_', @BankUBSGKB, '_RBADECLINE');

UPDATE `CustomItemSet` SET `name` = CONCAT('customitemset_', @BankUB, '_RBAACCEPT'),
                           `description` = CONCAT('customitemset_', @BankUB, '_RBAACCEPT_Current'),
                           `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT('customitemset_', @BankUBSGKB, '_RBAACCEPT');

UPDATE `CustomItemSet` SET `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'),
                           `description` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_Current'),
                           `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT('customitemset_', @BankUBSGKB, '_MOBILE_APP');

UPDATE `CustomItemSet` SET `name` = CONCAT('customitemset_', @BankUB, '_SMS'),
                           `description` = CONCAT('customitemset_', @BankUB, '_SMS_Current'),
                           `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT('customitemset_', @BankUBSGKB, '_SMS');

UPDATE `CustomItemSet` SET `name` = CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'),
                           `description` = CONCAT('customitemset_', @BankUB, '__MISSING_AUTHENTICATION_REFUSAL_Current'),
                           `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT('customitemset_', @BankUBSGKB, '_MISSING_AUTHENTICATION_REFUSAL');

UPDATE `CustomItemSet` SET `name` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'),
                           `description` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD_Current'),
                           `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT('customitemset_', @BankUBSGKB, '_REFUSAL_FRAUD');

UPDATE `CustomItemSet` SET `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'),
                           `description` = CONCAT('customitemset_', @BankUB, '_PASSWORD_Current'),
                           `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT('customitemset_', @BankUBLLB, '_PASSWORD');

UPDATE `CustomItemSet` SET `name` = CONCAT('customitemset_', @BankUB, '_SMS_OVERRIDE'),
                           `description` = CONCAT('customitemset_', @BankUB, '_SMS_OVERRIDE_Current'),
                           `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT('customitemset_', @BankUBLLB, '_SMS');

/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

SET @profileRefusalSGKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUBSGKB, '_DEFAULT_REFUSAL'));
SET @profileRBAACCEPTSGKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUBSGKB,'_ACCEPT'));
SET @profileRBADECLINESGKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUBSGKB,'_DECLINE'));
SET @profileMOBILEAPPSGKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUBSGKB,'_TA_01'));
SET @profileSMSSGKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUBSGKB,'_SMS_01'));
SET @profileINFOSGKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUBSGKB,'_MISSING_AUTHENTICATION_REFUSAL'));
SET @profileUNDEFINEDSGKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUBSGKB,'_UNDEFINED_01'));
SET @profileRefusalFraud_SGKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUBSGKB, '_REFUSAL_FRAUD'));
SET @profilePasswordOTP_LLB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUBLLB,'_OTP_PWD'));
SET @profilePassword_LLB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUBLLB,'_PASSWORD_Override'));
SET @profileSMS_LLB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUBLLB,'_SMS_Override'));


SET @ruleRefusalFraudSGKB = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FRAUD' AND `fk_id_profile` = @profileRefusalFraud_SGKB);
SET @ruleRBAAcceptSGKB = (SELECT id FROM `Rule` WHERE `description` = 'RBA_ACCEPT' AND `fk_id_profile` = @profileRBAACCEPTSGKB);
SET @ruleRBADeclineSGKB = (SELECT id FROM `Rule` WHERE `description` = 'RBA_DECLINE' AND `fk_id_profile` = @profileRBADECLINESGKB);
SET @ruleMobileAppnormalSGKB = (SELECT id FROM `Rule` WHERE `description` = 'OTP_APP (NORMAL)' AND `fk_id_profile` = @profileMOBILEAPPSGKB);
SET @ruleSMSnormalSGKB = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (FALLBACK)' AND `fk_id_profile` = @profileSMSSGKB);
SET @ruleRefusalDefaultSGKB = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileRefusalSGKB);
SET @ruleINFOnormalSGKB = (SELECT id FROM `Rule` WHERE `description`='MISSING_AUTHENTICATION' AND `fk_id_profile`=@profileINFOSGKB);
SET @ruleUNDEFINEDSGKB = (SELECT id FROM `Rule` WHERE `description`='UNDEFINED' AND `fk_id_profile`=@profileUNDEFINEDSGKB);
SET @rulePasswordOTP_LLB = (SELECT id FROM `Rule` WHERE `description`='PWD_OTP_NORMAL' AND `fk_id_profile`=@profilePasswordOTP_LLB);
SET @rulePasswordOverride_LLB = (SELECT id FROM `Rule` WHERE `description` = 'PASSWORD_OVERRIDE' AND `fk_id_profile` = @profilePassword_LLB);
SET @ruleSMSnormalOverride_LLB = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_OVERRIDE' AND `fk_id_profile` = @profileSMS_LLB);



/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @customItemSetRBAACCEPT = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_RBAACCEPT'));
SET @customItemSetRBADECLINE = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_RBADECLINE'));
SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetSMS_OVERRIDE = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS_OVERRIDE'));
SET @customItemSetINFORefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'));
SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'));

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_ACCEPT'),
                     `fk_id_customItemSetCurrent` = @customItemSetRBAACCEPT,
                     `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT(@BankUBSGKB,'_ACCEPT');

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_DECLINE'),
                     `fk_id_customItemSetCurrent` = @customItemSetRBADECLINE,
                     `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT(@BankUBSGKB,'_DECLINE');

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_TA_01'),
                     `fk_id_customItemSetCurrent` = @customItemSetMOBILEAPP,
                     `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT(@BankUBSGKB,'_TA_01');

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_SMS_01'),
                     `fk_id_customItemSetCurrent` = @customItemSetSMS,
                     `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT(@BankUBSGKB,'_SMS_01');

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL'),
                     `fk_id_customItemSetCurrent` = @customItemSetRefusal,
                     `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT(@BankUBSGKB,'_DEFAULT_REFUSAL');

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'),
                     `fk_id_customItemSetCurrent` = @customItemSetINFORefusal,
                     `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT(@BankUBSGKB,'_MISSING_AUTHENTICATION_REFUSAL');

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_UNDEFINED_01'),
                     `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT(@BankUBSGKB,'_UNDEFINED_01');

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_REFUSAL_FRAUD'),
                     `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud,
                     `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT(@BankUBSGKB,'_REFUSAL_FRAUD');

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_PASSWORD_Override'),
                     `fk_id_customItemSetCurrent` = @customItemSetPassword,
                     `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT(@BankUBLLB,'_PASSWORD_Override');

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_SMS_Override'),
                     `fk_id_customItemSetCurrent` = @customItemSetSMS_OVERRIDE,
                     `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT(@BankUBLLB,'_SMS_Override');

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_OTP_PWD'),
                     `fk_id_subIssuer` = @subIssuerID WHERE `name` = CONCAT(@BankUBLLB,'_OTP_PWD');


/* CustomPageLayout_ProfileSet */
SET @id_subissuer_SWISSKEY = (SELECT ID FROM SubIssuer WHERE code = @issuerCode);
SET @id_profile_set_SWISSKEY = (SELECT ID FROM ProfileSet WHERE FK_ID_SUBISSUER = @id_subissuer_SWISSKEY);
SET @id_profile_set_LLB = (SELECT ID FROM ProfileSet WHERE FK_ID_SUBISSUER = @subIssuerIDLLB);
SET @id_customPageLayout_PWD_OTP = (SELECT ID FROM CustomPageLayout WHERE description LIKE CONCAT('Password OTP Form Page (', @BankB, ')%'));

Update `CustomPageLayout_ProfileSet` SET `profileSet_id` =@id_profile_set_SWISSKEY  WHERE customPageLayout_id = @id_customPageLayout_PWD_OTP AND `profileSet_id` =@id_profile_set_LLB;

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
SET @profilePasswordOTP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_OTP_PWD'));
SET @profilePasswordOverride = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_Override'));
SET @profileSMSOverride = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_Override'));
SET @profileRefusalFraud = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REFUSAL_FRAUD'));

UPDATE `Rule` SET `fk_id_profile` = @profileRefusal, `orderRule` = 11 WHERE `fk_id_profile` = @profileRefusalSGKB;
UPDATE `Rule` SET `fk_id_profile` = @profileRBAACCEPT WHERE `fk_id_profile` = @profileRBAACCEPTSGKB;
UPDATE `Rule` SET `fk_id_profile` = @profileRBADECLINE WHERE `fk_id_profile` = @profileRBADECLINESGKB;
UPDATE `Rule` SET `fk_id_profile` = @profileMOBILEAPP WHERE `fk_id_profile` = @profileMOBILEAPPSGKB;
UPDATE `Rule` SET `fk_id_profile` = @profileSMS, `orderRule` = 9 WHERE `fk_id_profile` = @profileSMSSGKB;
UPDATE `Rule` SET `fk_id_profile` = @profileINFO WHERE `fk_id_profile` = @profileINFOSGKB;
UPDATE `Rule` SET `fk_id_profile` = @profileUNDEFINED, `orderRule` = 10 WHERE `fk_id_profile` = @profileUNDEFINEDSGKB;
UPDATE `Rule` SET `fk_id_profile` = @profilePasswordOTP, `orderRule` = 6 WHERE `fk_id_profile` = @profilePasswordOTP_LLB;
UPDATE `Rule` SET `fk_id_profile` = @profilePasswordOverride, `orderRule` = 7 WHERE `fk_id_profile` = @profilePassword_LLB;
UPDATE `Rule` SET `fk_id_profile` = @profileSMSOverride, `orderRule` = 8 WHERE `fk_id_profile` = @profileSMS_LLB;

/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;



SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FRAUD' AND `fk_id_profile` = @profileRefusalFraud);
SET @ruleRBAAccept = (SELECT id FROM `Rule` WHERE `description` = 'RBA_ACCEPT' AND `fk_id_profile` = @profileRBAACCEPT);
SET @ruleRBADecline = (SELECT id FROM `Rule` WHERE `description` = 'RBA_DECLINE' AND `fk_id_profile` = @profileRBADECLINE);
SET @ruleMobileAppnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_APP (NORMAL)' AND `fk_id_profile` = @profileMOBILEAPP);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (FALLBACK)' AND `fk_id_profile` = @profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileRefusal);
SET @ruleINFOnormal = (SELECT id FROM `Rule` WHERE `description`='MISSING_AUTHENTICATION' AND `fk_id_profile`=@profileINFO);
SET @ruleUNDEFINED = (SELECT id FROM `Rule` WHERE `description`='UNDEFINED' AND `fk_id_profile`=@profileUNDEFINED);
SET @rulePasswordOTP = (SELECT id FROM `Rule` WHERE `description` = 'PWD_OTP_NORMAL' AND `fk_id_profile` = @profilePasswordOTP);
SET @rulePasswordOverride = (SELECT id FROM `Rule` WHERE `description` = 'PASSWORD_OVERRIDE' AND `fk_id_profile` = @profilePasswordOverride);
SET @ruleSMSnormalOverride = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_OVERRIDE' AND `fk_id_profile` = @profileSMSOverride);

/* ProfileSet_Rule */
Update `ProfileSet_Rule` SET `id_profileSet` =@id_profile_set_SWISSKEY  WHERE `id_rule` IN (@rulePasswordOTP,
                                                                                            @rulePasswordOverride,
                                                                                            @ruleSMSnormalOverride)
                                                                          AND `id_profileSet` =@id_profile_set_LLB;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleRefusalFraud, `name` = CONCAT('C1_P_', @BankUB, '_01_FRAUD')
                        WHERE `fk_id_rule` = @ruleRefusalFraudSGKB;
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleRefusalFraud, `name` = CONCAT('C1_P_', @BankUB, '_02_FRAUD')
                        WHERE `fk_id_rule` = @ruleRefusalFraudSGKB;
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleRefusalFraud, `name` = CONCAT('C1_P_', @BankUB, '_03_FRAUD')
                        WHERE `fk_id_rule` = @ruleRefusalFraudSGKB;
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleRefusalFraud, `name` = CONCAT('C1_P_', @BankUB, '_04_FRAUD')
                        WHERE `fk_id_rule` = @ruleRefusalFraudSGKB;
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleRefusalFraud, `name` = CONCAT('C1_P_', @BankUB, '_05_FRAUD')
                        WHERE `fk_id_rule` = @ruleRefusalFraudSGKB;
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleINFOnormal, `name` = CONCAT('C1_P_', @BankUB, '_01_MISSING_AUTHENTICATION_REFUSAL')
                        WHERE `fk_id_rule` = @ruleINFOnormalSGKB;
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleRBAAccept, `name` = CONCAT('C1_P_', @BankUB, '_01_RBA_ACCEPT')
                        WHERE `fk_id_rule` = @ruleRBAAcceptSGKB;
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleRBADecline, `name` = CONCAT('C1_P_', @BankUB, '_01_RBA_DECLINE')
                        WHERE `fk_id_rule` = @ruleRBADeclineSGKB;
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleMobileAppnormal, `name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL')
                        WHERE `fk_id_rule` = @ruleMobileAppnormalSGKB;
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleSMSnormal, `name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_FALLBACK')
                        WHERE `fk_id_rule` = @ruleSMSnormalSGKB
                        AND `name` = CONCAT('C1_P_', @BankUBSGKB, '_01_OTP_SMS_EXT_FALLBACK');
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleSMSnormal, `name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_FALLBACK')
                        WHERE `fk_id_rule` = @ruleSMSnormalSGKB
                        AND `name` = CONCAT('C1_P_', @BankUBSGKB, '_02_OTP_SMS_EXT_FALLBACK');
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleUNDEFINED, `name` = CONCAT('C1_P_', @BankUB, '_01_UNDEFINED')
                        WHERE `fk_id_rule` = @ruleUNDEFINEDSGKB;
UPDATE `RuleCondition` SET `fk_id_rule` = @rulePasswordOTP, `name` = CONCAT('C1_P_', @BankUB, '_01_PWD_OTP_NORMAL')
                        WHERE `fk_id_rule` = @rulePasswordOTP_LLB;
UPDATE `RuleCondition` SET `fk_id_rule` = @rulePasswordOverride, `name` = CONCAT('C1_P_', @BankUB, '01_PASSWORD_OVERRIDE')
                        WHERE `fk_id_rule` = @rulePasswordOverride_LLB;
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleSMSnormalOverride, `name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_OVERRIDE')
                        WHERE `fk_id_rule` = @ruleSMSnormalOverride_LLB;
UPDATE `RuleCondition` SET `fk_id_rule` = @ruleRefusalDefault, `name` = CONCAT('C1_P_', @BankUB, '_01_DEFAULT')
                        WHERE `fk_id_rule` = @ruleRefusalDefaultSGKB;
/*!40000 ALTER TABLE `RuleCondition` ENABLE KEYS */;


/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
UPDATE `MerchantPivotList` SET `fk_id_subIssuer` = @subIssuerID WHERE `fk_id_subIssuer` = @subIssuerIDSGKB;
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;


/*!40101 SET SQL_MODE = IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS = IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
