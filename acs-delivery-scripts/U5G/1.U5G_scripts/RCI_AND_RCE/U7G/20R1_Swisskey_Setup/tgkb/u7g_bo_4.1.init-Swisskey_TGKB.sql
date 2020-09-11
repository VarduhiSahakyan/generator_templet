/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

SET @createdBy = 'A709391';
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
SET @subIssuerNameAndLabel = 'Thurgauer Kantonalbank';
SET @subIssuerCode = '78400';
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
						 `displayLanguageSelectPage`,`trustedBeneficiariesAllowed`,`authentMeans`, fk_id_cryptoConfig, `currencyFormat`) VALUES
('ACS_U7G', 120, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
 @updateState, @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
 @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, FALSE, TRUE, TRUE, @preferredAuthMean,
 @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, 'https://secure.six-group.com/', '1', @3DS2AdditionalInfo,'3', TRUE, FALSE, b'0', b'0', @activatedAuthMeans, @cryptoConfigIDNAB, @currencyFormat);
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
SELECT `acsIdForCrypto`, `binKeyIdentifier`, `cavvKeyIndicator`, `cipherKeyIdentifier`, `desCipherKeyIdentifier`, `desKeyId`, `hubAESKey`, `secondFactorAuthentication`,  @subIssuerID
FROM `SubIssuerCrypto` si WHERE si.fk_id_subIssuer = @subIssuerIDNAB ;
/*!40000 ALTER TABLE `SubIssuerCrypto` ENABLE KEYS */;

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'SWISSKEY';
SET @BankUB = 'TGKB';
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
VALUES (@createdBy, NOW(), CONCAT(@BankUB,' Logo'), NULL, NULL, @BankUB, 'PUSHED_TO_CONFIG', 'iVBORw0KGgoAAAANSUhEUgAAA7gAAAFQCAYAAACVsdKdAAAACXBIWXMAAC4jAAAuIwF4pT92AAAH32lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNi4wLWMwMDIgNzkuMTY0NDYwLCAyMDIwLzA1LzEyLTE2OjA0OjE3ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjIgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIwLTA3LTEwVDA4OjM3OjAzKzAyOjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMC0wNy0xMFQwODo0NTozNiswMjowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMC0wNy0xMFQwODo0NTozNiswMjowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpkODY2YTk2ZS1iOTU0LTRhYWMtYjdlYi1lYzNiN2JkOGI0NWUiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDo3ZWJlZWIzMS1kMTA4LTU2NGItYTQwYi00YmU3ZmQ4NjZlMGEiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo5ZTAyMDZiMC00MTlhLTRmYjgtYjhmYy04N2RkZTgyOGY4N2EiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjllMDIwNmIwLTQxOWEtNGZiOC1iOGZjLTg3ZGRlODI4Zjg3YSIgc3RFdnQ6d2hlbj0iMjAyMC0wNy0xMFQwODozNzowMyswMjowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIDIxLjIgKE1hY2ludG9zaCkiLz4gPHJkZjpsaSBzdEV2dDphY3Rpb249ImNvbnZlcnRlZCIgc3RFdnQ6cGFyYW1ldGVycz0iZnJvbSBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wIHRvIGltYWdlL3BuZyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6ZDg2NmE5NmUtYjk1NC00YWFjLWI3ZWItZWMzYjdiZDhiNDVlIiBzdEV2dDp3aGVuPSIyMDIwLTA3LTEwVDA4OjQ1OjM2KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgMjEuMiAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPHhtcE1NOkluZ3JlZGllbnRzPiA8cmRmOkJhZz4gPHJkZjpsaSBzdFJlZjpsaW5rRm9ybT0iUmVmZXJlbmNlU3RyZWFtIiBzdFJlZjpmaWxlUGF0aD0iY2xvdWQtYXNzZXQ6Ly9jYy1hcGkt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',
		'/');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
SET @status = 'DEPLOYED_IN_PRODUCTION';
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBADECLINE_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_RBADECLINE'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBAACCEPT_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_RBAACCEPT'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_MOBILE_APP_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_MOBILE_APP'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_SMS'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '__MISSING_AUTHENTICATION_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'));
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
  (@createdBy, NOW(), 'MOBILE_APP', NULL, NULL, CONCAT(@BankUB,'_TA_01'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authentMeansMobileApp, @customItemSetMOBILEAPP, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'OTP_SMS', NULL, NULL, CONCAT(@BankUB,'_SMS_01'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'REFUSAL (FRAUD)', NULL, NULL, CONCAT(@BankUB,'_REFUSAL_FRAUD'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusalFraud, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'INFO', NULL, NULL, CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanINFO, @customItemSetINFORefusal, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID);


/*!40000 ALTER TABLE `Profile` ENABLE KEYS */;

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));
SET @profileRefusalFraud = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REFUSAL_FRAUD'));
SET @profileRBAACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profileRBADECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profileMOBILEAPP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_TA_01'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @profileINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					`updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', @updateState, 1, @profileRefusalFraud),
  (@createdBy, NOW(), 'MISSING_AUTHENTICATION', NULL, NULL, 'REFUSAL(Missing Authentication)', @updateState,2, @profileINFO),
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, 'NONE (ACCEPT)', @updateState, 3, @profileRBAACCEPT),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, 'REFUSAL (DECLINE)', @updateState, 4, @profileRBADECLINE),
  (@createdBy, NOW(), 'OTP_APP (NORMAL)', NULL, NULL, 'APP (NORMAL)', @updateState, 5, @profileMOBILEAPP),
  (@createdBy, NOW(), 'OTP_SMS_EXT (FALLBACK)', NULL, NULL, 'OTP_SMS_EXT (FALLBACK)', @updateState, 6, @profileSMS),
  (@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', @updateState, 7, @profileRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FRAUD' AND `fk_id_profile` = @profileRefusalFraud);
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
