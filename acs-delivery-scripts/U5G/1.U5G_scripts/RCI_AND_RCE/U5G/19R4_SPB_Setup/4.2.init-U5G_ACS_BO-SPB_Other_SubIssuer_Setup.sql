/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

SET @issuerCode = '16950';
SET @sharedSubIssuerCode = '16950';
SET @createdBy = 'A707825';

/* SubIssuer */

SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'SBK_Augsburg';

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

SET @subIssuerCodes = '13606,15519,17509,17609,17009,15009,12509,12069,16009,17209' ;

SET @idCryptoConfig = (SELECT fk_id_cryptoConfig FROM SubIssuer WHERE code = @sharedSubIssuerCode);

INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`, `resendSameOTP`,`combinedAuthenticationAllowed`,
                         authentMeans, fk_id_cryptoConfig)
VALUES
('ACS_U5G', 120, @backUpLanguages, '13606', '13606', '978', @createdBy, NOW(), NULL, NULL, NULL, 'SBK_West','PUSHED_TO_CONFIG', @defaultLanguage, 600, 'SBK_West', TRUE, TRUE, NULL, TRUE, TRUE, 300,@acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,@issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, TRUE, TRUE,  @activatedAuthMeans, @idCryptoConfig),
('ACS_U5G', 120, @backUpLanguages, '15519', '15519', '978', @createdBy, NOW(), NULL, NULL, NULL, 'SBK_Südwest','PUSHED_TO_CONFIG', @defaultLanguage, 600, 'SBK_Südwest', TRUE, TRUE, NULL, TRUE, TRUE, 300,@acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,@issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, TRUE, TRUE,  @activatedAuthMeans, @idCryptoConfig),
('ACS_U5G', 120, @backUpLanguages, '17509', '17509', '978', @createdBy, NOW(), NULL, NULL, NULL, 'SBK_Ostbayern','PUSHED_TO_CONFIG', @defaultLanguage, 600, 'SBK_Ostbayern', TRUE, TRUE, NULL, TRUE, TRUE, 300,@acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,@issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, TRUE, TRUE,  @activatedAuthMeans, @idCryptoConfig),
('ACS_U5G', 120, @backUpLanguages, '17609', '17609', '978', @createdBy, NOW(), NULL, NULL, NULL, 'SBK_Nürnberg','PUSHED_TO_CONFIG', @defaultLanguage, 600, 'SBK_Nürnberg', TRUE, TRUE, NULL, TRUE, TRUE, 300,@acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,@issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, TRUE, TRUE,  @activatedAuthMeans, @idCryptoConfig),
('ACS_U5G', 120, @backUpLanguages, '17009', '17009', '978', @createdBy, NOW(), NULL, NULL, NULL, 'SBK_München','PUSHED_TO_CONFIG', @defaultLanguage, 600, 'SBK_München', TRUE, TRUE, NULL, TRUE, TRUE, 300,@acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,@issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, TRUE, TRUE,  @activatedAuthMeans, @idCryptoConfig),
('ACS_U5G', 120, @backUpLanguages, '15009', '15009', '978', @createdBy, NOW(), NULL, NULL, NULL, 'SBK_Hessen','PUSHED_TO_CONFIG', @defaultLanguage, 600, 'SBK_Hessen', TRUE, TRUE, NULL, TRUE, TRUE, 300,@acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,@issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, TRUE, TRUE,  @activatedAuthMeans, @idCryptoConfig),
('ACS_U5G', 120, @backUpLanguages, '12509', '12509', '978', @createdBy, NOW(), NULL, NULL, NULL, 'SBK_Hannover','PUSHED_TO_CONFIG', @defaultLanguage, 600, 'SBK_Hannover', TRUE, TRUE, NULL, TRUE, TRUE, 300,@acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,@issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, TRUE, TRUE,  @activatedAuthMeans, @idCryptoConfig),
('ACS_U5G', 120, @backUpLanguages, '12069', '12069', '978', @createdBy, NOW(), NULL, NULL, NULL, 'SBK_Hamburg','PUSHED_TO_CONFIG', @defaultLanguage, 600, 'SBK_Hamburg', TRUE, TRUE, NULL, TRUE, TRUE, 300,@acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,@issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, TRUE, TRUE,  @activatedAuthMeans, @idCryptoConfig),
('ACS_U5G', 120, @backUpLanguages, '16009', '16009', '978', @createdBy, NOW(), NULL, NULL, NULL, 'SBK_Baden-Württemberg','PUSHED_TO_CONFIG', @defaultLanguage, 600, 'SBK_Baden-Württemberg', TRUE, TRUE, NULL, TRUE, TRUE, 300,@acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,@issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, TRUE, TRUE,  @activatedAuthMeans, @idCryptoConfig),
('ACS_U5G', 120, @backUpLanguages, '17209', '17209', '978', @createdBy, NOW(), NULL, NULL, NULL, 'SBK_Augsburg','PUSHED_TO_CONFIG', @defaultLanguage, 600, 'SBK_Augsburg', TRUE, TRUE, NULL, TRUE, TRUE, 300,@acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,@issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, TRUE, TRUE,  @activatedAuthMeans, @idCryptoConfig);


--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
--  /!\ SubIssuerCrypto                                                               /!\
--  /!\ This is a very specific configuration, in production environment only,        /!\
--  /!\ for internal and external acceptance, use the one given here                  /!\
--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\

INSERT INTO `SubIssuerCrypto` (`acsIdForCrypto`, `binKeyIdentifier`, `cavvKeyIndicator`, `cipherKeyIdentifier`,
                               `desCipherKeyIdentifier`, `desKeyId`, `hubAESKey`, `secondFactorAuthentication`, `fk_id_subIssuer`)
SELECT '0A', '1', '03', 'EC11223344554B544F4B5F4D5554555F414301', 'EC11223344554B544F4B5F4D5554555F414300', '1', '01', 'NO_SECOND_FACTOR', si.id
FROM `SubIssuer` si WHERE si.fk_id_issuer = @issuerId and find_in_set(si.code, @subIssuerCodes);

INSERT INTO SubIssuerNetworkCrypto ( authorityCertificate,  authorityCertificateExpiryDate,  cardNetworkAlgorithm,  cardNetworkIdentifier,  cardNetworkSeqGenerationMethod,
                                     cardNetworkSignatureKey,  rootCertificate,  rootCertificateExpiryDate,  signingCertificate,  signingCertificateExpiryDate,  fk_id_network,
                                     fk_id_subIssuer)
SELECT 'MIIFGzCCBAOgAwIBAgIRANh0YTBB/DxEoLzGXWw28RAwDQYJKoZIhvcNAQELBQAwazELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMRwwGgYDVQQDExNWaXNhIGVDb21tZXJjZSBSb290MB4XDTE1MDYyNDE1MjcwNloXDTIyMDYyMjAwMTYwN1owcTELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMSIwIAYDVQQDExlWaXNhIGVDb21tZXJjZSBJc3N1aW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArkmC50Q+GkmQyZ29kKxp1d+nJ43JwXhGZ7aFF1PiM5SlCESQ22qV/lBA3wHYYP8i17/GQQYNBiF3u4r6juXIHFwjwvKyFMF6kmBYXvcQa8Pd75FC1n3ffIrhEj+ldbmxidzK0hPfYyXEZqDpHhkunmvD7qz1BEWKE7NUYVFREfopViflKiVZcYrHi7CJAeBNY7dygvmIMnHUeH4NtDS5qf/n9DQQffVyn5hJWi5PeB87nTlty8zdji2tj7nA2+Y3PLKRJU3y1IbchqGlnXqxaaKfkTLNsiZq9PTwKaryH+um3tXf5u4mulzRGOWh2U+Uk4LntmMFCb/LqJkWnUVe+wIDAQABo4IBsjCCAa4wHwYDVR0jBBgwFoAUFTiDDz8sP3AzHs1G/geMIODXw7cwEgYDVR0TAQH/BAgwBgEB/wIBADA5BgNVHSAEMjAwMC4GBWeBAwEBMCUwIwYIKwYBBQUHAgEWF2h0dHA6Ly93d3cudmlzYS5jb20vcGtpMIIBCwYDVR0fBIIBAjCB/zA2oDSgMoYwaHR0cDovL0Vucm9sbC52aXNhY2EuY29tL1Zpc2FDQWVDb21tZXJjZVJvb3QuY3JsMDygOqA4hjZodHRwOi8vd3d3LmludGwudmlzYWNhLmNvbS9jcmwvVmlzYUNBZUNvbW1lcmNlUm9vdC5jcmwwgYaggYOggYCGfmxkYXA6Ly9FbnJvbGwudmlzYWNhLmNvbTozODkvY249VmlzYSBlQ29tbWVyY2UgUm9vdCxvPVZJU0Esb3U9VmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFN/DKlUuL0I6ekCdkqD3R3nXj4eKMA0GCSqGSIb3DQEBCwUAA4IBAQB9Y+F99thHAOhxZoQcT9CbConVCtbm3hWlf2nBJnuaQeoftdOKWtj0YOTj7PUaKOWfwcbZSHB63rMmLiVm7ZqIVndWxvBBRL1TcgbwagDnLgArQMKHnY2uGQfPjEMAkAnnWeYJfd+cRJVo6K3R4BbQGzFSHa2i2ar6/oXzINyaxAXdoG04Cz2P0Pm613hMCpjFyYilS/425he1Tk/vHsTnFwFlk9yY2L8VhBa6j40faaFu/6fin78Kopk96gHdAIN1tbA12NNmr7bQ1pUs0nKHhzQGoRXguYd7UYO9i2sNVC1C5A3F8dopwsv2QK2+33q05O2/4DgnF4m5us6RV94D',
       NULL, 'CVV_WITH_ATN', '241122334455434156565F4D5554555F414300', 'STRING_TIMESTAMP', 'ED11223344554B544F525F4D5554555F414311',
       'MIIDojCCAoqgAwIBAgIQE4Y1TR0/BvLB+WUF1ZAcYjANBgkqhkiG9w0BAQUFADBrMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xHDAaBgNVBAMTE1Zpc2EgZUNvbW1lcmNlIFJvb3QwHhcNMDIwNjI2MDIxODM2WhcNMjIwNjI0MDAxNjEyWjBrMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xHDAaBgNVBAMTE1Zpc2EgZUNvbW1lcmNlIFJvb3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvV95WHm6h2mCxlCfLF9sHP4CFT8icttD0b0/Pmdjh28JIXDqsOTPHH2qLJj0rNfVIsZHBAk4ElpF7sDPwsRROEW+1QK8bRaVK7362rPKgH1g/EkZgPI2h4H3PVz4zHvtH8aoVlwdVZqW1LS7YgFmypw23RuwhY/81q6UCzyr0TP579ZRdhE2o8mCP2w4lPJ9zcc+U30rq299yOIzzlr3xF7zSujtFWsan9sYXiwGd/BmoKoMWuDpI/k4+oKsGGelT84ATB+0tvz8KPFUgOSwsAGl0lUq8ILKpeeUYiZGo3BxN77t+Nwtd/jmliFKMAGzsGHxBvfaLdXe6YJ2E5/4tAgMBAAGjQjBAMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQVOIMPPyw/cDMezUb+B4wg4NfDtzANBgkqhkiG9w0BAQUFAAOCAQEAX/FBfXxcCLkr4NWSR/pnXKUTwwMhmytMiUbPWU3J/qVAtmPN3XEolWcRzCSs00Rsca4BIGsDoo8Ytyk6feUWYFN4PMCvFYP3j1IzJL1kk5fui/fbGKhtcbP3LBfQdCVp9/5rPJS+TUtBjE7ic9DjkCJzQ83z7+pzzkWKsKZJ/0x9nXGIxHYdkFsd7v3M9+79YKWxehZx0RbQfBI8bGmX265fOZpwLwU8GUYEmSA20GBuYQa7FkKMcPcw++DbZqMAAb3mLNqRX6BGi01qnD093QVG/na/oAo85ADmJ7f/hC3euiInlhBx6yLt398znM/jra6O1I7mT1GvFpLgXPYHDw==',
       NULL, 'MIIFUTCCBDmgAwIBAgIQNGkVAwj/6btPCxH1ZOokdjANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJVUzENMAsGA1', NULL, 1, si.id
FROM `SubIssuer` si WHERE si.fk_id_issuer = @issuerId and find_in_set(si.code, @subIssuerCodes);


-- ProfileSet

SET @BankB = 'SBK_Augsburg';
SET @BankUB = 'SBK_Augsburg';
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
SELECT @createdBy, NOW(), CONCAT(si.name, ' profile set'), NULL, NULL, CONCAT('PS_', si.name, '_01'), 'PUSHED_TO_CONFIG', si.id
FROM `SubIssuer` si
WHERE si.fk_id_issuer = @issuerId and find_in_set(si.code, @subIssuerCodes);

set @idProfileSets = ( SELECT group_concat(ps.id) FROM SubIssuer si INNER JOIN ProfileSet ps ON si.id = ps.fk_id_subIssuer
                       WHERE si.fk_id_issuer = @issuerId and find_in_set(si.code, @subIssuerCodes) );
/* CustomItemSet */

INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
SELECT @createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
       CONCAT('customitemset_', si.name, '_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, si.id
FROM SubIssuer si WHERE si.fk_id_issuer = @issuerId and find_in_set(si.code, @subIssuerCodes);

-- CustomItems
-- SET @idCustomItemSets = (SELECT group_concat(cis.id) FROM SubIssuer si INNER JOIN CustomItemSet cis on si.id = cis.fk_id_subIssuer
-- WHERE si.fk_id_issuer = @issuerId and find_in_set(si.code, @subIssuerCodes));

Set @idTemplateCustomItemSet = (SELECT id FROM CustomItemSet where name = 'customitemset_SPB_sharedBIN_DEFAULT_REFUSAL');

INSERT INTO CustomItem (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                        `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT DTYPE, createdBy, creationDate, description, lastUpdateBy, lastUpdateDate,
       name, updateState, locale, ordinal, pageTypes, value,
       fk_id_network, fk_id_image, cis.id FROM CustomItem ci, (SELECT id FROM (SELECT cis.id as id FROM SubIssuer si INNER JOIN CustomItemSet cis on si.id = cis.fk_id_subIssuer
                                                                               WHERE si.fk_id_issuer = @issuerId and find_in_set(si.code, @subIssuerCodes) ) as temp ) as cis
WHERE ci.fk_id_customItemSet = @idTemplateCustomItemSet;

/* Profile */

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, dataEntryFormat, dataEntryAllowedPattern, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`)
SELECT @createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(si.name,'_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', -1,  '^[^OIi]*$', '7:(:DIGIT:1)',@authMeanRefusal, cis.id, NULL, NULL, si.id
FROM SubIssuer si INNER JOIN CustomItemSet cis ON si.id = cis.fk_id_subIssuer
where si.fk_id_issuer = @issuerId and find_in_set(si.code, @subIssuerCodes);



/* Rule */

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`)
SELECT @createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 1, p.id
FROM Profile p INNER JOIN SubIssuer si ON p.fk_id_subIssuer = si.id WHERE find_in_set(si.code, @subIssuerCodes);

set @idRules = (SELECT GROUP_CONCAT(r.id) FROM Rule r
                                                   INNER JOIN Profile p ON r.fk_id_profile = p.id
                                                   INNER JOIN SubIssuer si ON p.fk_id_subIssuer = si.id
                WHERE find_in_set(si.code, @subIssuerCodes));

/* RuleCondition */

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`)
SELECT @createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', si.name, '_01_DEFAULT'), 'PUSHED_TO_CONFIG', r.id
FROM Rule r INNER JOIN Profile p ON r.fk_id_profile = p.id INNER JOIN SubIssuer si ON p.fk_id_subIssuer = si.id
WHERE find_in_set(si.code, @subIssuerCodes);

SET @idRuleConditions
    = (SELECT GROUP_CONCAT(rc.id) FROM RuleCondition rc INNER JOIN Rule r ON rc.fk_id_rule = r.id
                                                        INNER JOIN Profile p ON r.fk_id_profile = p.id
                                                        INNER JOIN SubIssuer si ON p.fk_id_subIssuer = si.id
       WHERE find_in_set(si.code, @subIssuerCodes));

/* Condition_TransactionStatuses */

select @idRuleConditions;
SELECT c.id as RuleCondition, ts.id as TransactionStatus  FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE (ts.`transactionStatusType` = 'DEFAULT' AND ts.`reversed` = FALSE) AND  find_in_set(c.id, @idRuleConditions);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE (ts.`transactionStatusType` = 'DEFAULT' AND ts.`reversed` = FALSE) AND  find_in_set(c.id, @idRuleConditions);

/* ProfileSet_Rule */

SELECT @idProfileSets, @idRules;

INSERT INTO ProfileSet_Rule (id_profileSet, id_rule)
SELECT ps.id, r.id FROM ProfileSet ps INNER JOIN SubIssuer si ON ps.fk_id_subIssuer = si.id INNER JOIN Profile p ON si.id = p.fk_id_subIssuer
INNER JOIN Rule r on p.id = r.fk_id_profile WHERE find_in_set(si.code, @subIssuerCodes);

/* MerchantPivotList */

INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`, forceAuthent, expertMode, `fk_id_issuer`, `fk_id_subIssuer`)
SELECT 'ISSUER', 'TestMerchant', 'NAME', 0, 0, 0, 0, @issuerId, si.code FROM SubIssuer si WHERE find_in_set(si.code, @subIssueCodes);


/*!40101 SET SQL_MODE = IFNULL(@OLD_SQL_MODE, '') */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
