/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

SET @createdBy = 'A758582';
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
  "validate" : true
}  ]';

SET @issuerCode = '41001';

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'Entris Banking';
SET @BankUB = 'ENTRIS';
SET @subIssuerCode = '69900';
/* @backUpLanguage corresponds to a (comma separated) list of locales that should be displayed to the user,
   and @defaultLanguage a default locale which should be selected by default. */
SET @backUpLanguages = 'en,de,it';
SET @defaultLanguage = 'fr';
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
                         `displayLanguageSelectPage`,`trustedBeneficiariesAllowed`,`authentMeans`, `fk_id_cryptoConfig`, `currencyFormat`, `npaEnabled`) VALUES
('ACS_U7G', 120, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
 @updateState, @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
 @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
 @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, @paChallengeURL, '1', @3DS2AdditionalInfo,'3', TRUE, FALSE, b'0', b'0', @activatedAuthMeans, @cryptoConfigIDNAB, @currencyFormat, TRUE);
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;


SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
	AND n.code = 'MASTERCARD';

/*!40000 ALTER TABLE `Network_SubIssuer` ENABLE KEYS */;

/* BinRange */
/* In this table, in the case of co-branding the primary network will be present as a foreign key (fk_id_network) and
   the 'alternative' network will be present through the field 'coBrandedCardNetwork' which contains a string that matches
   the field 'code' of the Network (it plays the same role as a foreign key, because the code is unique for each Network)
*/
SET @BankB = 'SWISSKEY';
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankB, '_01'));

SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5352220000', 16, FALSE, NULL, '5352220099', FALSE, @ProfileSet, @MaestroMID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5352220000' AND b.upperBound='5352220099' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;


/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`, `relativePath`)
VALUES (@createdBy, NOW(), CONCAT(@BankUB,' Logo'), NULL, NULL, @BankUB, 'PUSHED_TO_CONFIG', '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',
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
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSALFraudSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSALSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetRefusalMissingSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMSSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetMobileAppSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');


SET @locale = 'en';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSALFraudSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSALSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetRefusalMissingSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMSSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetMobileAppSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');


SET @locale = 'fr';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSALFraudSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSALSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetRefusalMissingSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMSSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetMobileAppSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

SET @locale = 'it';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSALFraudSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSALSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetRefusalMissingSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMSSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         @locale, @subIssuerCode, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetMobileAppSwisskey
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');