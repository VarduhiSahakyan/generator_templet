/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

SET @createdBy = 'W100851';
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
  "authentMeans" : "MOBILE_APP",
  "validate" : true
}, {
  "authentMeans" : "INFO",
  "validate" : true
}, {
  "authentMeans" : "UNDEFINED",
  "validate" : false
}  ]';

SET @issuerCode = '41001';

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'Nidwalden Kantonalbank';
SET @BankUB = 'NIDWALDEN';
SET @subIssuerCode = '77900';
/* @backUpLanguage corresponds to a (comma separated) list of locales that should be displayed to the user,
   and @defaultLanguage a default locale which should be selected by default. */
SET @backUpLanguages = 'en,fr,it';
SET @defaultLanguage = 'de';
/* Provides option to call the authentication HUB at PA or VE step */
SET @HUBcallMode = 'PA_ONLY_MODE';
/* Correspond to URL to configure for the BinRanges extraction */
/*IAT*/
SET @acsURLVEMastercard = 'https://ssl-qlf-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
SET @acsURLVEVisa = 'https://ssl-qlf-u7g-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';

/*CAT*/
#SET @acsURLVEMastercard = 'https://ssl-liv-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
#SET @acsURLVEVisa = 'https://ssl-qlf-liv-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';

/*PRD*/
#SET @acsURLVEMastercard = 'https://ssl-prd-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
#SET @acsURLVEVisa = 'https://ssl-qlf-prd-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';


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
/* IAT/CAT */
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

/* PRD */
/*
SET @3DS2AdditionalInfo = '{
      "VISA": {
        "operatorId": "acsOperatorVisa",
        "dsKeyAlias": "dsvisa_call_alias_cert_01"
      },
      "MASTERCARD": {
        "operatorId": "ACS-V210-EQUENSWORLDLINE-34926",
        "dsKeyAlias": "1"
      }
}';
*/
/* IAT */
SET @paChallengeURL = '{ "Vendome" : "https://ssl-qlf-u7g-fo-acs-pa.wlp-acs.com/", "Seclin" : "https://ssl-qlf-u7g-fo-acs-pa.wlp-acs.com/", "Unknown" : "https://ssl-qlf-u7g-fo-acs-pa.wlp-acs.com/" }';

/* CAT */
#SET @paChallengeURL = '{ "Vendome" : "https://ssl-liv-u7g-fo-acs-pa.wlp-acs.com/", "Seclin" : "https://ssl-liv-u7g-fo-acs-pa.wlp-acs.com/", "Unknown" : "https://ssl-liv-u7g-fo-acs-pa.wlp-acs.com/" }';

/* PRD */
#SET @paChallengeURL = '{ "Vendome" : "https://authentication1.six-group.com/", "Brussels" : "https://authentication2.six-group.com/", "Unknown" : "https://secure.six-group.com/" }';

SET @cryptoConfigIDNAB = (SELECT fk_id_cryptoConfig FROM SubIssuer where code = 58810 AND name = 'Neue Aargauer Bank');
INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`,`paChallengePublicUrl`,
                         `verifyCardStatus`,`3DS2AdditionalInfo`,`resendOTPThreshold`, `resendSameOTP`,`combinedAuthenticationAllowed`,
                         `displayLanguageSelectPage`,`trustedBeneficiariesAllowed`,`authentMeans`, `fk_id_cryptoConfig`, `currencyFormat`) VALUES
('ACS_U7G', 120, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
 @updateState, @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
 @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
 @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, @paChallengeURL, '1', @3DS2AdditionalInfo,'3', TRUE, FALSE, b'0', b'0', @activatedAuthMeans, @cryptoConfigIDNAB, @currencyFormat);
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;

--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
--  /!\ SubIssuerCrypto                                                               /!\
--  /!\ This is a very specific configuration, in production environment only,        /!\
--  /!\ for internal and external acceptance, use the one given here                  /!\
--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
/*!40000 ALTER TABLE `SubIssuerCrypto` DISABLE KEYS */;
SET @subIssuerIDNAB = (SELECT id FROM SubIssuer where code = 58810 AND name = 'Neue Aargauer Bank');
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
INSERT INTO `SubIssuerCrypto` (`acsIdForCrypto`, `binKeyIdentifier`, `cavvKeyIndicator`, `cipherKeyIdentifier`,
                               `desCipherKeyIdentifier`, `desKeyId`, `hubAESKey`, `secondFactorAuthentication`, `fk_id_subIssuer`)
SELECT `acsIdForCrypto`, `binKeyIdentifier`, `cavvKeyIndicator`, `cipherKeyIdentifier`, `desCipherKeyIdentifier`, `desKeyId`, `hubAESKey`, `secondFactorAuthentication`,  @subIssuerID
FROM `SubIssuerCrypto` si WHERE si.fk_id_subIssuer = @subIssuerIDNAB ;


/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
	AND n.code = 'VISA';

/*!40000 ALTER TABLE `Network_SubIssuer` ENABLE KEYS */;

/*!40000 ALTER TABLE `SubIssuerNetworkCrypto` DISABLE KEYS */;
INSERT INTO `SubIssuerNetworkCrypto` (`authorityCertificate`, `authorityCertificateExpiryDate`, `cardNetworkAlgorithm`,
                                      `cardNetworkIdentifier`, `cardNetworkSeqGenerationMethod`, `cardNetworkSignatureKey`,
                                      `rootCertificate`, `rootCertificateExpiryDate`, `signingCertificate`, `signingCertificateExpiryDate`,
                                      `fk_id_network`, `fk_id_subIssuer`)
SELECT `authorityCertificate`, `authorityCertificateExpiryDate`, `cardNetworkAlgorithm`,
       `cardNetworkIdentifier`, `cardNetworkSeqGenerationMethod`, `cardNetworkSignatureKey`,
       `rootCertificate`, `rootCertificateExpiryDate`, `signingCertificate`, `signingCertificateExpiryDate`,
       `fk_id_network`, @subIssuerID
FROM SubIssuerNetworkCrypto where fk_id_subIssuer = @subIssuerIDNAB;

/* BinRange */
/* In this table, in the case of co-branding the primary network will be present as a foreign key (fk_id_network) and
   the 'alternative' network will be present through the field 'coBrandedCardNetwork' which contains a string that matches
   the field 'code' of the Network (it plays the same role as a foreign key, because the code is unique for each Network)
*/
SET @BankB = 'SWISSKEY';
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankB, '_01'));

SET @VisaMID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @VisaName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),  '4395903000', 16, FALSE, NULL, '4395903009', FALSE, @ProfileSet, @VisaMID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4395903000' AND b.upperBound='4395903009' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;


/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`, `relativePath`)
VALUES (@createdBy, NOW(), CONCAT(@BankUB,' Logo'), NULL, NULL, @BankUB, 'PUSHED_TO_CONFIG', 'iVBORw0KGgoAAAANSUhEUgAAAlEAAAB1CAIAAADhvCOAAAAACXBIWXMAADE2AAAxNgGa50IgAAAGc2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNi4wLWMwMDIgNzkuMTY0NDg4LCAyMDIwLzA3LzEwLTIyOjA2OjUzICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgMjIuMCAoV2luZG93cykiIHhtcDpDcmVhdGVEYXRlPSIyMDIwLTEyLTAzVDEwOjMxOjI5KzAxOjAwIiB4bXA6TWV0YWRhdGFEYXRlPSIyMDIwLTEyLTAzVDExOjEzOjM5KzAxOjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMC0xMi0wM1QxMToxMzozOSswMTowMCIgcGhvdG9zaG9wOkNvbG9yTW9kZT0iMyIgcGhvdG9zaG9wOklDQ1Byb2ZpbGU9InNSR0IgSUVDNjE5NjYtMi4xIiBkYzpmb3JtYXQ9ImltYWdlL3BuZyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDowYmIyOWI3ZS1mZmM5LTI1NGUtYWQxOS0xODQ0MWVkOTMzMzIiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6OTJjMDJlZDEtN2EwYS0zYzRiLTgyODctZGFhNmM1NGI1NmU0IiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6OTJjMDJlZDEtN2EwYS0zYzRiLTgyODctZGFhNmM1NGI1NmU0Ij4gPHBob3Rvc2hvcDpEb2N1bWVudEFuY2VzdG9ycz4gPHJkZjpCYWc+IDxyZGY6bGk+eG1wLmRpZDo5OGJlYjY0Mi1hZDAyLTM3NGMtOWI1OC05MmNjNTQ1NGI0OTc8L3JkZjpsaT4gPC9yZGY6QmFnPiA8L3Bob3Rvc2hvcDpEb2N1bWVudEFuY2VzdG9ycz4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo5MmMwMmVkMS03YTBhLTNjNGItODI4Ny1kYWE2YzU0YjU2ZTQiIHN0RXZ0OndoZW49IjIwMjAtMTItMDNUMTA6MzE6MjkrMDE6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMi4wIChXaW5kb3dzKSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6MGJiMjliN2UtZmZjOS0yNTRlLWFkMTktMTg0NDFlZDkzMzMyIiBzdEV2dDp3aGVuPSIyMDIwLTEyLTAzVDExOjEzOjM5KzAxOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgMjIuMCAoV2luZG93cykiIHN0RXZ0OmNoYW5nZWQ9Ii8iLz4gPC9yZGY6U2VxPiA8L3htcE1NOkhpc3Rvcnk+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+5FtzlgAAUsJJREFUeJztnXdcE1n38O+kA0noXRAURUQpitgVRQE7uru6uva21lUXXexl195d7KJrQUUf14LiylpAwQ42QJoivXdIQtrc9495fnnzZCYh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',
		'/');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;


/* CustomItem */
SET @customItemSetREFUSALFraudSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_REFUSAL_FRAUD'));
SET @customItemSetREFUSALSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusalMissingSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankB, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetSMSSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_SMS'));
SET @customItemSetMobileAppSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_MOBILE_APP'));



-- INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
--   SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusalMissing FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusal;
SET @locale = 'de';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetREFUSALFraudSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetREFUSALSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetRefusalMissingSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetSMSSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetMobileAppSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');


SET @locale = 'en';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetREFUSALFraudSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetREFUSALSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetRefusalMissingSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetSMSSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetMobileAppSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');


SET @locale = 'fr';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetREFUSALFraudSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetREFUSALSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetRefusalMissingSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetSMSSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetMobileAppSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

SET @locale = 'it';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetREFUSALFraudSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetREFUSALSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetRefusalMissingSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetSMSSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @VisaMID, im.id, @customItemSetMobileAppSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');