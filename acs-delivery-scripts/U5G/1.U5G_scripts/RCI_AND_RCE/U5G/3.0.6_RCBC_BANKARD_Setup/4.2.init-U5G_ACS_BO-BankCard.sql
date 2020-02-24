/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

/* Issuer
   At first, the different authentication means need to be activated, so 'validate' is set to 'true'.
*/
/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
SET @activatedAuthMeans = '[{"authentMeans" : "OTP_SMS","validate" : true}, {"authentMeans":"REFUSAL", "validate":true}]';
SET @availableAuthMeans = 'OTP_SMS|REFUSAL';
SET @issuerNameAndLabel = 'RCBC Bankard';
SET @issuerCode = '00006';
SET @createdBy ='A699391';


INSERT INTO `Issuer` (`code`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                      `updateState`, `label`, `authentMeans`, `availaibleAuthentMeans`) VALUES
  (@issuerCode, @createdBy, NOW(), NULL, NULL, NULL, @issuerNameAndLabel, 'PUSHED_TO_CONFIG', @issuerNameAndLabel,
    @activatedAuthMeans, @availableAuthMeans);
/*!40000 ALTER TABLE `Issuer` ENABLE KEYS */;

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'Bankard Credit';
SET @subIssuerCode = '00006';
/* @backUpLanguage corresponds to a (comma separated) list of locales that should be displayed to the user,
   and @defaultLanguage a default locale which should be selected by default. */
SET @backUpLanguages = '';
SET @defaultLanguage = 'en';
/* Provides option to call the authentication HUB at PA or VE step */
SET @HUBcallMode = 'VE_AND_PA_MODE';
/* Correspond to URL to configure for the BinRanges extraction */
SET @acsURLVEMastercard = 'https://ssl-liv-u5g-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest';
SET @acsURLVEVisa = 'https://ssl-liv-u5g-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest';
/* Corresponds to the authentication mean to use primarily */
SET @preferredAuthMean = 'OTP_SMS';
/* See en_countrycode.json, 250 is France's country code. It is important in order to know if the transaction
   was initiated from an IP from the same location as the ACS (local purchase) */
SET @issuerCountryCode = '250';
SET @maskParam = 'x,6,4';
SET @dateFormat = 'DD.MM.YYYY HH.mm';

INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `otpExcluded`, `otpAllowed`, `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`) VALUES
  ('ACS_U5G', 300, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
   'PUSHED_TO_CONFIG', @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, '^[^OIi]*$', '6:(:DIGIT:1)', NULL, TRUE, TRUE, 300,
   @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
   @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat);
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;

SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);
/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
	AND n.code in('VISA','MASTERCARD');
/*!40000 ALTER TABLE `Network_SubIssuer` ENABLE KEYS */;

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

--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
--  /!\ SubIssuerNetworkCrypto                                                     /!\
--  /!\ This is a very specific configuration, in production environment only,     /!\
--  /!\ for internal and external acceptance, use the one given here               /!\
--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
/*!40000 ALTER TABLE `SubIssuerNetworkCrypto` DISABLE KEYS */;
INSERT INTO `SubIssuerNetworkCrypto` (`authorityCertificate`, `authorityCertificateExpiryDate`, `cardNetworkAlgorithm`,
                                      `cardNetworkIdentifier`, `cardNetworkSeqGenerationMethod`, `cardNetworkSignatureKey`,
                                      `rootCertificate`, `rootCertificateExpiryDate`, `signingCertificate`, `signingCertificateExpiryDate`,
                                      `fk_id_network`, `fk_id_subIssuer`)
  SELECT 'MIIFGzCCBAOgAwIBAgIRANh0YTBB/DxEoLzGXWw28RAwDQYJKoZIhvcNAQELBQAwazELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMRwwGgYDVQQDExNWaXNhIGVDb21tZXJjZSBSb290MB4XDTE1MDYyNDE1MjcwNloXDTIyMDYyMjAwMTYwN1owcTELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMSIwIAYDVQQDExlWaXNhIGVDb21tZXJjZSBJc3N1aW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArkmC50Q+GkmQyZ29kKxp1d+nJ43JwXhGZ7aFF1PiM5SlCESQ22qV/lBA3wHYYP8i17/GQQYNBiF3u4r6juXIHFwjwvKyFMF6kmBYXvcQa8Pd75FC1n3ffIrhEj+ldbmxidzK0hPfYyXEZqDpHhkunmvD7qz1BEWKE7NUYVFREfopViflKiVZcYrHi7CJAeBNY7dygvmIMnHUeH4NtDS5qf/n9DQQffVyn5hJWi5PeB87nTlty8zdji2tj7nA2+Y3PLKRJU3y1IbchqGlnXqxaaKfkTLNsiZq9PTwKaryH+um3tXf5u4mulzRGOWh2U+Uk4LntmMFCb/LqJkWnUVe+wIDAQABo4IBsjCCAa4wHwYDVR0jBBgwFoAUFTiDDz8sP3AzHs1G/geMIODXw7cwEgYDVR0TAQH/BAgwBgEB/wIBADA5BgNVHSAEMjAwMC4GBWeBAwEBMCUwIwYIKwYBBQUHAgEWF2h0dHA6Ly93d3cudmlzYS5jb20vcGtpMIIBCwYDVR0fBIIBAjCB/zA2oDSgMoYwaHR0cDovL0Vucm9sbC52aXNhY2EuY29tL1Zpc2FDQWVDb21tZXJjZVJvb3QuY3JsMDygOqA4hjZodHRwOi8vd3d3LmludGwudmlzYWNhLmNvbS9jcmwvVmlzYUNBZUNvbW1lcmNlUm9vdC5jcmwwgYaggYOggYCGfmxkYXA6Ly9FbnJvbGwudmlzYWNhLmNvbTozODkvY249VmlzYSBlQ29tbWVyY2UgUm9vdCxvPVZJU0Esb3U9VmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFN/DKlUuL0I6ekCdkqD3R3nXj4eKMA0GCSqGSIb3DQEBCwUAA4IBAQB9Y+F99thHAOhxZoQcT9CbConVCtbm3hWlf2nBJnuaQeoftdOKWtj0YOTj7PUaKOWfwcbZSHB63rMmLiVm7ZqIVndWxvBBRL1TcgbwagDnLgArQMKHnY2uGQfPjEMAkAnnWeYJfd+cRJVo6K3R4BbQGzFSHa2i2ar6/oXzINyaxAXdoG04Cz2P0Pm613hMCpjFyYilS/425he1Tk/vHsTnFwFlk9yY2L8VhBa6j40faaFu/6fin78Kopk96gHdAIN1tbA12NNmr7bQ1pUs0nKHhzQGoRXguYd7UYO9i2sNVC1C5A3F8dopwsv2QK2+33q05O2/4DgnF4m5us6RV94D',
    NULL, 'CVV_WITH_ATN', '241122334455434156565F4D5554555F414300', 'STRING_TIMESTAMP', 'ED11223344554B544F525F4D5554555F414311',
    'MIIDojCCAoqgAwIBAgIQE4Y1TR0/BvLB+WUF1ZAcYjANBgkqhkiG9w0BAQUFADBrMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xHDAaBgNVBAMTE1Zpc2EgZUNvbW1lcmNlIFJvb3QwHhcNMDIwNjI2MDIxODM2WhcNMjIwNjI0MDAxNjEyWjBrMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xHDAaBgNVBAMTE1Zpc2EgZUNvbW1lcmNlIFJvb3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvV95WHm6h2mCxlCfLF9sHP4CFT8icttD0b0/Pmdjh28JIXDqsOTPHH2qLJj0rNfVIsZHBAk4ElpF7sDPwsRROEW+1QK8bRaVK7362rPKgH1g/EkZgPI2h4H3PVz4zHvtH8aoVlwdVZqW1LS7YgFmypw23RuwhY/81q6UCzyr0TP579ZRdhE2o8mCP2w4lPJ9zcc+U30rq299yOIzzlr3xF7zSujtFWsan9sYXiwGd/BmoKoMWuDpI/k4+oKsGGelT84ATB+0tvz8KPFUgOSwsAGl0lUq8ILKpeeUYiZGo3BxN77t+Nwtd/jmliFKMAGzsGHxBvfaLdXe6YJ2E5/4tAgMBAAGjQjBAMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQVOIMPPyw/cDMezUb+B4wg4NfDtzANBgkqhkiG9w0BAQUFAAOCAQEAX/FBfXxcCLkr4NWSR/pnXKUTwwMhmytMiUbPWU3J/qVAtmPN3XEolWcRzCSs00Rsca4BIGsDoo8Ytyk6feUWYFN4PMCvFYP3j1IzJL1kk5fui/fbGKhtcbP3LBfQdCVp9/5rPJS+TUtBjE7ic9DjkCJzQ83z7+pzzkWKsKZJ/0x9nXGIxHYdkFsd7v3M9+79YKWxehZx0RbQfBI8bGmX265fOZpwLwU8GUYEmSA20GBuYQa7FkKMcPcw++DbZqMAAb3mLNqRX6BGi01qnD093QVG/na/oAo85ADmJ7f/hC3euiInlhBx6yLt398znM/jra6O1I7mT1GvFpLgXPYHDw==',
    NULL, 'MIIFUTCCBDmgAwIBAgIQNGkVAwj/6btPCxH1ZOokdjANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJVUzENMAsGA1',
    NULL, n.id, si.id
    FROM Network n, SubIssuer si
    WHERE n.code in('VISA') AND si.fk_id_issuer = @issuerId and si.id = @subIssuerID;
	
INSERT INTO `SubIssuerNetworkCrypto` (`authorityCertificate`, `authorityCertificateExpiryDate`, `cardNetworkAlgorithm`,
                                      `cardNetworkIdentifier`, `cardNetworkSeqGenerationMethod`, `cardNetworkSignatureKey`,
                                      `rootCertificate`, `rootCertificateExpiryDate`, `signingCertificate`, `signingCertificateExpiryDate`,
                                      `fk_id_network`, `fk_id_subIssuer`)
  SELECT 'MIIEgDCCA2igAwIBAgIQQ3EBfDozHhKp3pmzcHr6ZzANBgkqhkiG9w0BAQUFADCBgDELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFE1hc3RlckNhcmQgV29ybGR3aWRlMS4wLAYDVQQLEyVNYXN0ZXJDYXJkIFdvcmxkd2lkZSBTZWN1cmVDb2RlIEdlbiAyMSIwIAYDVQQDExlQUkQgTUMgU2VjdXJlQ29kZSBSb290IENBMB4XDTEyMDYyMjA5MjIxNFoXDTI1MDYyMTA5MjIxNVowgYYxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEoMCYGA1UEAxMfUFJEIE1DIFNlY3VyZUNvZGUgSXNzdWVyIFN1YiBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANaeBgfjTKIFls7ueMTzI2nYwAbocHwkQqd8BsIyJbZdk21E+vyq9EhX1NIoiAhP7fl+y/hosX66drjfrbyspZLalrVG6gYbdB2j2Sr8zBRQnMZKKluDwYv/266nnRBeyGYW3FwyVu8L1ACYQc04ACke+07NI/AZ8OXQSoeboEEGUO520/76o1cER5Ok9HRi0jJD8E64j8dEt36Mcg0JaKQiDjShlyTw4ABYyzZ1Vxl0/iDrfwboxNEOOooC0rcGNnCpISXMWn2NmZH1QxiFt2jIZ8QzF3/z+M3iYradh9uZauleNqJ9LPKr/aFFDbe0Bv0PLbvXOnFpwOxvJODWUj8CAwEAAaOB7TCB6jAPBgNVHRMECDAGAQH/AgEAMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUwTArnR3hR1+Ij1uxMtqoPBm2j7swgacGA1UdIwSBnzCBnKGBhqSBgzCBgDELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFE1hc3RlckNhcmQgV29ybGR3aWRlMS4wLAYDVQQLEyVNYXN0ZXJDYXJkIFdvcmxkd2lkZSBTZWN1cmVDb2RlIEdlbiAyMSIwIAYDVQQDExlQUkQgTUMgU2VjdXJlQ29kZSBSb290IENBghEA7qGSrpcB0q8DkgwCPcT3kzANBgkqhkiG9w0BAQUFAAOCAQEA3lJuYVdiy11ELUfBfLuib4gPTbkDdVLBEKosx0yUDczeXoTUOjBEc90f5KRjbpe4pilOGAQnPNUGpi3ZClS+0ysTBp6RdYz1efNLSuaTJtpJpoCOk1/nw6W+nJEWyDXUcC/yVqstZidcOG6AMfKU4EC5zBNELZCGf1ynM2l+gwvkcDUv4Y2et/n/NqIKBzywGSOktojTma0kHbkAe6pj6i65TpwEgEpywVl50oMmNKvXDNMznrAG6S9us+OHDjonOlmmyWmQxXdU1MzwdKzPjHfwl+Z6kByDXruHjEcNsx7P2rUTm/Bt3SWW1K48VfNNhVa/WctTZGJCrV3Zjl6A9g==',
    NULL, 'MASTERCARD_SPA', '241122334455554341465F4D5554555F414300', 'STRING_TIMESTAMP', 'ED11223344554B544F525F4D5554555F414310',
    'MIIDzzCCAregAwIBAgIRAO6hkq6XAdKvA5IMAj3E95MwDQYJKoZIhvcNAQEFBQAwgYAxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEiMCAGA1UEAxMZUFJEIE1DIFNlY3VyZUNvZGUgUm9vdCBDQTAeFw0xMjA2MjIwOTA4MzBaFw0yNTA2MjIwOTA4MzFaMIGAMQswCQYDVQQGEwJVUzEdMBsGA1UEChMUTWFzdGVyQ2FyZCBXb3JsZHdpZGUxLjAsBgNVBAsTJU1hc3RlckNhcmQgV29ybGR3aWRlIFNlY3VyZUNvZGUgR2VuIDIxIjAgBgNVBAMTGVBSRCBNQyBTZWN1cmVDb2RlIFJvb3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDptCms6aI22T9ST60k487SZP06TKbUBpom7Z1Bo8cQQAE/tM5UOt3THMdrhT+2aIkj9T0pA35IyNMCNGDt+ejhy7tHdw1r6eDX/KXYHb4FlemY03DwRrkQSH/L+ZueS5dCfLM3m2azxBXtrVXDdNebfht8tcWRLK2Ou6vjDzdIzunuWRZ6kRDQ6oc1LSVO2BxiFO0TKowJP/M7qWRT/Jsmb6TGg0vmmQG9QEpmVmOZIexVxuYy3rn7gEbV1tv3k4aG0USMp2Xq/Xe4qe+Ir7sFqR56G4yKezSVLUzQaIB/deeCk9WU2T0XmicAEYDBQoecoS61R4nj5ODmzwmGyxrlAgMBAAGjQjBAMA8GA1UdEwQIMAYBAf8CAQEwDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQqFTcxVDO/uxI1hpFF3VSSTFMGujANBgkqhkiG9w0BAQUFAAOCAQEAhDOQ5zUX2wByVv0Cqka3ebnm/6xRzQQbWelzneDUNVdctn1nhJt2PK1uGV7RBGAGukgdAubwwnBhD2FdbhBHTVbpLPYxBbdMAyeC8ezaXGirXOAAv0YbGhPl1MUFiDmqSliavBFUs4cEuBIas4BUoZ5Fz042dDSAWffbdf3l4zrU5Lzol93yXxxIjqgIsT3QI+sRM3gg/Gdwo80DUQ2fRffsGdAUH2C/8L8/wH+E9HspjMDkXlZohPII0xtKhdIPWzbOB6DOULl2PkdGHmJc4VXxfOwE2NJAQxmoaPRDYGgOFVvkzYtyxVkxXeXAPNt8URR3jfWvYrBGH2D5A44Atg==',
    NULL, 'MIIEgDCCA2igAwIBAgIRANPdOMI3PRuQ2QrYW3TiHIAwDQYJKoZIhvcNAQEFBQAwgYYxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEoMCYGA1UEAxMfUFJEIE1DIFNlY3VyZUNvZGUgSXNzdWVyIFN1YiBDQTAeFw0xNzA3MjgxMTMyNTBaFw0yMTA3MjcxMTI5NDRaMHkxCzAJBgNVBAYTAkZSMR0wGwYDVQQKExRDUkVESVQgQUdSSUNPTEUgUy5BLjEnMCUGA1UECxMeQVRPUyBXb3JsZExpbmUgV0xQIC0gSUNBIDEyNjUzMSIwIAYDVQQDExlXTFAtQUNTIENBU0EgU2lnbmF0dXJlIE1DMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuO0yGOwsu/icuH+OPbAaSWWTUL+oePoapJ6bNZd41g8dG9fKOgRzHW+dMIrkKeXKHHQvrvU6JNJoPFWAGxeOa4D0vsp1AZKOWiWlsss6kLn0fDj7nwDErCHJNJWi3TmmSL8s8ujOrRsveZhoDtLDp1E/Q+PoG3uoI4PcH3DqlF/8IfY/0z9F9avb+uCFvOXoh6dV5LRe2mYY62KiJHvdaAPlGwPnFPgLtJafgv9RVVGyxXhxZSM1R6hX2pP28219BlDQEbQtkqHJI/3/NW5x9HjddXpbtqKt29NXfmTJym6pfZrWTXn2qXuXokPcR5TE3EWz3zGsNSkltOc0ADANsQIDAQABo4H0MIHxMCsGA1UdEAQkMCKADzIwMTcwNzI4MTEzMjUwWoEPMjAyMDA3MjcxMTMyNTBaMA4GA1UdDwEB/wQEAwIHgDAJBgNVHRMEAjAAMIGmBgNVHSMEgZ4wgZuhgYakgYMwgYAxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEiMCAGA1UEAxMZUFJEIE1DIFNlY3VyZUNvZGUgUm9vdCBDQYIQQ3EBfDozHhKp3pmzcHr6ZzANBgkqhkiG9w0BAQUFAAOCAQEAb72VYXYGFGeuoxjrq2vDduEp6gHii2SwWaf3D/wuybihroryJVMW9AX3SG8IVHEINqtqg/dTgo8TfJnJ0QEiGN0TlmFHzSptil6lBAlSnHjrEsIBG52bLKtGwCrE7Hzfx8fqW5XmlyrDJK7MaaIrFe5GPMXBLL7+nazbpemy06+9RvyDLisgxx8DPRkdZdfoQfKTH5sWUtr2VMA5NtMQAtHjMhQOFuOpfbwNz4iC/jHDM6/Zs4D4zcVFKQwS4ngtf5q4dwOdQ6nYdpreWcgbmzuH7PIRQWsO4sWpzWlwknWKeU/r2iOaRndxAmxmR3oJVFYHqD/6fy0NDoBwIrdrjA==',
    NULL, n.id, si.id
    FROM Network n, SubIssuer si
    WHERE n.code='MASTERCARD'  AND si.fk_id_issuer = @issuerId;
/*!40000 ALTER TABLE `SubIssuerNetworkCrypto` ENABLE KEYS */;


/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'Bankard_Credit';
SET @BankUB = 'BANKARD_CREDIT';
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT @createdBy, NOW(), CONCAT(@BankB,' profile set'), NULL, NULL, CONCAT('PS_', @BankUB, '_01'), 'PUSHED_TO_CONFIG', si.id
    FROM `SubIssuer` si
    WHERE si.fk_id_issuer=@issuerId and si.id = @subIssuerID;
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;

/* CustomPageLayout - Insert the predefined layouts (in order to see the templates) */
INSERT INTO `CustomPageLayout` (`controller`,`pageType`,`description`)
VALUES (NULL,'MESSAGE_BANNER', CONCAT('Message Banner (',@BankB, ')')),
	   (NULL,'HELP_PAGE',CONCAT('Help Page (',@BankB, ')')),
	   (NULL,'OTP_FORM_PAGE',CONCAT('OTP Form Page (',@BankB, ')')),
	   (NULL,'REFUSAL_PAGE',CONCAT('Refusal Page (',@BankB, ')')),
	   (NULL,'FAILURE_PAGE',CONCAT('Failure Page (',@BankB, ')'));

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

/* CustomPageLayout_ProfileSet - Link the predefined layouts to the profileSet (in order to see the templates) */
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` DISABLE KEYS */;
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
    SELECT cpl.id, p.id
    FROM `CustomPageLayout` cpl, `ProfileSet` p
	WHERE cpl.description like CONCAT('%(',@BankB, '%') and p.id=@ProfileSet;
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` ENABLE KEYS */;

/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Message Banner (',@BankB, ')%') );
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
  '
<div id="messageBanner">
  <span id="info-icon" class="fa fa-info-circle"></span>
  <custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
  <custom-text id="message" custom-text-key="$parent.message"></custom-text>

  <style>
    span#info-icon {
      position:absolute;
      top:15px;
      left:15px;
      float:none;
    }
    @media all and (max-width: 480px) {
      span#info-icon {
        position: absolute;
        font-size: 3em;
        top: 1px;
        left: 5px;
        display: inline-block;
      }
    }
    div#message-container.info {
      background-color:#069AF9;
    }
    #headingTxt {
      font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
      font-size:22px;
      width : 70%;
      margin : auto;
      display : block;
      text-align:center;
      padding:4px 1px 1px 1px;
    }
    #message {
      font-family: "Helvetica Neue",Helvetica,Arial,sans-serif; font-size:14px;
      text-align:center;
    }
    span#message {
      font-size:14px;
    }
    #message-container {
      position:relative;
    }
    #optGblPage message-banner div#message-container {
      width:100% ;
      box-shadow: none ;
      -webkit-box-shadow:none;
      position: relative;
    }
    div.message-button {
      padding-top: 0px;
    }
    div#message-content {
      text-align: center;
      background-color: inherit;
      padding-bottom: 5px;
    }
  </style>
</div>
', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Help Page (',@BankB, ')%') );
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
    '
<div id="help-page">
	<div id="help-contents">
		<p><custom-text custom-text-key="\'network_means_HELP_PAGE_1\'"></custom-text></p>
		<p><custom-text custom-text-key="\'network_means_HELP_PAGE_2\'"></custom-text></p>
		<p><custom-text custom-text-key="\'network_means_HELP_PAGE_3\'"></custom-text></p>
	</div>

	<div class="row">
		<div class="col-xs-12" style="text-align:center">
			<help-close-button id="helpCloseButton" help-label="toto"></help-close-button>
		</div>
	</div>
</div>
<style>

	#help-contents {
		text-align:left;
		margin-top:20px;
		margin-bottom:20px;
	}

	#help-container #help-modal {
		overflow:hidden;
	}

	#helpCloseButton button {
		display: flex;
		align-items: center;
		width: 120px; 
		margin-left: auto;
		margin-right: auto;
		justify-content: center;
	}

	help-page {
		font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
		padding:14px;
		overflow:auto; 
		text-align:left;
	}
  	
	@media screen and (max-width: 700px) and (min-width: 361px) {
		#helpCloseButton > button {

		}
	}
	@media screen and (max-width: 360px) {
		#helpCloseButton > button {

		}
	}

	@media only screen and (max-width: 480px) {
		div#message-container {
			width:100%;
			box-shadow: none;
			-webkit-box-shadow:none;
		}
	}
</style>
', @layoutId);
  
SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('OTP Form Page (',@BankB, ')%') );
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
    VALUES( 'div', '<style>

div#optGblPage {
  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size:14px;
}
#helpButton button {
  font: 300 16px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
  display:inline-block;
  white-space: nowrap;
  text-align: center;
  height: 40px;
  background: #fff;
  color: #323232;
  border: 1px solid rgba(0,0,0,.25);
  min-width: 15rem;
  border-radius: 4px;
  font-size: 16px;
  padding-left: 0px !important;
}
#cancelButton button {
  font: 300 16px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
  display:inline-block;
  white-space: nowrap;
  text-align: center;
  height: 40px;
  background: #fff;
  color: #323232;
  border: 1px solid rgba(0,0,0,.25);
  min-width: 15rem;
  border-radius: 4px;
  font-size: 16px;
  padding-left: 0px !important;
}
#cancelButton button:hover:enabled {
  border-color: rgba(255,106,16,.75);
}
#cancelButton button:active {
  background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
  border-color: rgba(0,0,0,.25) rgba(0,0,0,.2) rgba(0,0,0,.15);
  box-shadow: none;
  outline: 0px;
}
#cancelButton button custom-text {
  vertical-align:8px;
}
#helpButton button:hover {
  border-color: rgba(255,106,16,.75);
}

#helpButton button:active {
  background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
  border-color: rgba(0,0,0,.25) rgba(0,0,0,.2) rgba(0,0,0,.15);
  box-shadow: none;
  outline: 0px;
}
#helpButton button custom-text {
  vertical-align:8px;
}
#footer #helpButton button span:before {
  content:'';
}
#footer #cancelButton button span:before {
  content:'';
}
#footer #helpButton button span.fa {
  background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
  width:24px;
  height:26px;
  background-position-y: -1px;
  background-position-x: -2px;
  background-size: 115%;
  display:inline-block;
}
#helpCloseButton button {
  padding-left: 0px !important;
}
#helpCloseButton button span.fa {
  background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
  width:24px;
  height:26px;
  background-position-x: -2px;
  background-size: 115%;
  display:inline-block;
}
#helpCloseButton button span + span {
  margin-top: 1px;
}
#footer #cancelButton button span.fa {
  background-image:url(data:image/png;base64,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);
  width:24px;
  height:26px;
  background-position-y:1px;
  background-position-x: 2px;
  background-size:contain;
  display:inline-block;
  margin-right: 3px;
}
#footer {
  padding-top: 12px;
  padding-bottom:12px;
  width:100%;
  background-color: #CED8F6;
  text-align:center;
  margin-top: 15px;
  margin-bottom : 15px;
}
#i18n-container {
  width:100%;
  clear:both;
}
#i18n-inner {
  display: block;
  margin-left: auto;
  margin-right: auto;
  clear:both;
}
#i18n > button {
  background: transparent;
  color: #557a8e;
  border: none;
  box-shadow: none;
}
#i18n > button.active {
  background: #06446c !important;
  color:#FFFFFF!important;
  border-radius: 5px !important;
}
#issuerLogo {
  max-height: 64px;
  max-width:100%;
  padding-left: 0px;
  padding-right: 0px;
}
#networkLogo {
  max-height: 80px;
  max-width:100%;
  padding-top: 16px;
  padding-right: 16px;
}
#pageHeader {
  width: 100%;
  height: 96px;
  border-bottom: 1px solid #DCDCDC;
}
#pageHeaderLeft {
  width: 20%;
  float: left;
  padding-left: 16px;
  padding-top: 16px;
}
#pageHeaderCenter {
  width: 60%;
  float: left;
  text-align: center;
  line-height: 70px;
  padding-top: 16px;
}
#pageHeaderRight {
  width: 20%;
  float: right;
  text-align: right;
}
.paragraph {
  margin: 0px 0px 10px;
  text-align: justify;
}
.valbtn {
  margin: 0px 8px 10px 06px;
  text-align: justify;
}
.leftColumn {
  width:30%;
  display:block;
  float:left;
  padding:1em;
}
.rightColumn {
  width:70%;
  margin-left:30%;
  display:block;
  text-align:left;
  padding:20px 10px;
}
.contentRow {
  width:100%;
  padding:1em;
  padding:0px;
  padding-top:1em;
  clear:both;
}
side-menu div.text-center {
  text-align:left;
}
div.side-menu div.menu-title::before {
  display:inline;
}
div.side-menu div.menu-title::after {
  display:inline;
}
div.side-menu div.menu-title {
  display:inline;
  padding-left:50.9%;
  text-align:left;
  font-size: 18px;
}
div.side-menu div.menu-elements {
  margin-top:5px; 
}
#otp-form {
  display:inline-block;
  padding-top:12px;
}
#otp-form input {     
  box-sizing:content-box; 
  padding: 5px 10px 3px;
  background-color: #fff;
  border: 1px solid rgba(0,0,0,.2);
  border-radius: 2px;
  box-shadow: inset 1px 1px 0 0 rgba(0,0,0,.1);
  font: 300 18px "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size: 1.8rem;
  line-height: 25px;
  min-height: 25px;
}
#otp-form input:disabled {      
  color: #bebebe!important; 
  background-color: #dcdcdc!important; 
  border-color: rgba(0,0,0,.05)!important; 
  box-shadow: none!important;
}
#otp-form input:focus {
  border-color:#FF6A10 !important; 
  outline-color: #FF6A10;
}
div#otp-fields-container {
  width:70%;
  text-align:center;
  margin-top:10px;
  margin-bottom:10px;
}
div#otp-fields {
  display:inline-block;
}
div#otp-form div.tooltips {
  background: #545454;
}
div#otp-form div.tooltips span {
  background: #545454;
}
div#otp-form div.tooltips span:after {
  border-top: 8px solid #545454;
}
#validateButton {
  display:inline-block;
  padding-top:10px;
  margin-left:1em;
  vertical-align:4px;
}
#validateButton button {
  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size:16px;
  border-radius: 4px;
  color: #FFF;
  background:#00AC32;
  padding: 10px 10px 5px 10px;
  border: solid #e0e0e0 1px;
  text-decoration: none;
  min-width:200px;
  height: 40px;
  text-align: center;
  white-space: nowrap;
  display: inline-block;
}
#validateButton button:disabled {
  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size:16px;
  border-radius: 4px; 
  color: #969696;
  background:#fff;
  border-color: #dcdcdc;
  padding: 10px 10px 5px 10px;
  border: solid #e0e0e0 1px;
  text-decoration: none;
  min-width:200px;
  height: 40px;
  text-align: center;
  white-space: nowrap;
  display: inline-block;
}
#validateButton > button > span {
  width:100%;
}
#validateButton > button > span.fa-check-square {
  display: inline-block;
  width: 24px;
  height: 26px;
  background-position-y: 1px;
  background-position-x: -2px;
  background-size: contain;
  display: inline-block;
  margin-right: 3px;
}
@media all and (max-width: 1199px) and (min-width: 701px) {
  h1 { font-size:24px; }
  #issuerLogo {max-height : 64px;  max-width:140%; }
  #networkLogo {max-height : 72px;px;  max-width:100%; }
  #optGblPage {     font-size : 14px; }
  .leftColumn { display:block; float:none; width:100%; }
  .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
  .valbtn { margin: 0px 8px 10px 29px; text-align: justify; }
  div.side-menu div.menu-title { padding-left:0px; text-align:center; }
  side-menu div.text-center { text-align:center; }
  #otp-form{ display:block; width:250px; margin-left:auto; margin-right:auto; }
  #otp-form input { width:100%; }
  div#otp-fields { width:100%; }
  #validateButton { display:block; width:200px; margin-left:auto; margin-right:auto; }
  #validateButton button { width:100%; }
  div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
}

@media all and (max-width: 700px) and (min-width: 481px) {
  h1 { font-size:18px; }
  #optGblPage { font-size : 14px;}
  #issuerLogo {max-height : 54px;  max-width:160%; }
  #networkLogo {max-height : 67px;  max-width:100%; padding-top: 25px;}
  .leftColumn { display:block; float:none; width:100%; }
  .rightColumn { margin-left:0px; display:block; float:none; width:100%; }
  .valbtn { margin: 0px 8px 10px 29px; text-align: justify; }
  div.side-menu div.menu-title { padding-left:0px; text-align:center; }
  side-menu div.text-center { text-align:center; }
  #otp-form{ display:block; width:250px; margin-left:auto; margin-right:auto; }
  #otp-form input { width:100%; }
  div#otp-fields { width:100%; }
  #validateButton { display:block; width:200px; margin-left:auto; margin-right:auto; }
  #validateButton button { width:100%; }
  div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
}

@media all and (max-width: 480px) {
  h1 { font-size:16px; }
  div.side-menu div.menu-title { display:inline; }
  #optGblPage {   font-size : 14px;}
  #issuerLogo { max-height : 42px;  max-width:160%; }
  #networkLogo {max-height : 62px;  max-width:100%; padding-top: 25px; }
  .leftColumn { display:block; float:none; width:100%; }
  .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
  div.side-menu div.menu-title { padding-left:0px; text-align:center; }
  side-menu div.text-center { text-align:center; }
  #otp-form{ display:block; width:250px; margin-left:auto; margin-right:auto; }
  #otp-form input { width:100%; padding:0px; }
  div#otp-fields { width:100%; }
  #validateButton { display:block; width:200px; margin-left:auto; margin-right:auto; }
  #validateButton button { width:100%; }
  div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
  #footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
  #pageHeader { height: 75px; }
}
</style>
<div id="optGblPage">
  <div id="pageHeader" ng-style="style" class="ng-scope">
    <div id="pageHeaderLeft" ng-style="style" class="ng-scope">
      <custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
    </div>    
    <div id="pageHeaderRight" ng-style="style" class="ng-scope" >
      <custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
    </div>
  </div>
  
  <message-banner></message-banner>

  <div id="i18n-container" class="text-center">
    <div id="i18n-inner">
      <i18n></i18n>
    </div>
  </div>
  <div id="displayLayout" class="row">
    <div id="green-banner"></div>
  </div>
  <style>
    div#green-banner {
      height: 50px !important;
      background-color: #CED8F6;
      border-bottom: 5px solid #CED8F6;
      width: 100%;
    }
  </style>
  <div class="contentRow">
    <div x-ms-format-detection="none" class="leftColumn">
      <side-menu menu-title="\'TRANSACTION_SUMMARY\'"></side-menu>
    </div>
    <div class="rightColumn">
      <div class="paragraph">
        <custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
      </div>
      <div class="paragraph">
        <custom-text custom-text-key="\'network_means_pageType_3\'" id="paragraph3"></custom-text>
      </div>
      <div id="otp-fields-container">
        <div x-ms-format-detection="none" id="otp-fields">
          <otp-form></otp-form>
          <div class="valbtn">
            <val-button id="validateButton"></val-button>
          </div>
        </div>
      </div>
      <div class="paragraph">
        <custom-text custom-text-key="\'network_means_pageType_2\'" id="paragraph2"></custom-text>
      </div>
    </div>
  </div>
  <div id="footer">
    <div ng-style="style" class="style">
      <cancel-button cn-label="\'network_means_pageType_40\'" id="cancelButton" ></cancel-button>
      <help help-label="\'network_means_pageType_41\'" id="helpButton" ></help>
    </div>
  </div>
</div>
', @layoutId);  

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (',@BankB, ')%') );
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '
<style>
div#optGblPage {
  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size:14px;
}
#helpButton button {
  font: 300 16px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
  display:inline-block;
  white-space: nowrap;
  text-align: center;
  height: 40px;
  background: #fff;
  color: #323232;
  border: 1px solid rgba(0,0,0,.25);
  min-width: 15rem;
  border-radius: 4px;
  font-size: 16px;
  padding-left: 0px !important;
}
#helpButton button:hover {
  border-color: rgba(255,106,16,.75);
}
#helpButton button:active {
  background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
  border-color: rgba(0,0,0,.25) rgba(0,0,0,.2) rgba(0,0,0,.15);
  box-shadow: none;
  outline: 0px;
}
#helpButton button custom-text {
  vertical-align:8px;
}
#footer #helpButton button span:before {
  content:'';
}
#footer #cancelButton button span:before {
  content:'';
}
#footer #helpButton button span.fa {
  background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
  width:24px;
  height:26px;
  background-position-y: -1px;
  background-position-x: -2px;
  background-size: 115%;
  display:inline-block;
}
#helpCloseButton button {
  padding-left: 0px !important;
}
#helpCloseButton button span.fa {
  background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
  width:24px;
  height:26px;
  background-position-x: -2px;
  background-size: 115%;
  display:inline-block;
}
#helpCloseButton button span + span {
  margin-top: 1px;
}
#footer {
  padding-top: 12px;
  padding-bottom:12px;
  clear:both; 
  width:100%;
  background-color:#CED8F6;
  text-align:center;
  margin-top: 15px;
  margin-bottom : 15px;
}
#i18n-container {
  width:100%;
  clear:both;
}
#i18n-inner {
  display: block;
  margin-left: auto;
  margin-right: auto;
  clear:both;
}
#i18n > button {
  background: transparent;
  color: #557a8e;
  border: none;
  box-shadow: none;
}
#i18n > button.active {
  background: #06446c !important;
  color:#FFFFFF!important;
  border-radius: 5px !important;
}
#issuerLogo {
  max-height: 64px;
  padding-left: 0px;
  padding-right: 0px;
}
#networkLogo {
  max-height: 82px;
  padding-top: 16px;
  padding-right: 16px;
}
#pageHeader {
  width: 100%;
  height: 96px;
  border-bottom: 1px solid #DCDCDC;
}
#pageHeaderLeft {
  width: 20%;
  float: left;
  padding-left: 16px;
  padding-top: 16px;
}
#pageHeaderCenter {
  width: 60%;
  float: left;
  text-align: center;
  line-height: 70px;
  padding-top: 16px;
}
#pageHeaderRight {
  width: 20%;
  float: right;
  text-align: right;
}
.leftColumn {
  width:30%;
  display:block;
  float:left;
  padding:1em;
}
.rightColumn {
  width:70%;
  margin-left:30%;
  display:block;
  text-align:left;
  padding:20px 10px;
}
.contentRow {
  width:100%;
  padding:1em;
  padding:0px;
  padding-top:1em;
  clear:both;
}
side-menu div.text-center {
  text-align:left;
}
div.side-menu div.menu-title::before {
  display:inline;
}
div.side-menu div.menu-title::after {
  display:inline;
}
div.side-menu div.menu-title {
  display:inline;
  padding-left:50.9%;
  text-align:left;
  font-size: 18px;
}
div.side-menu div.menu-elements {
  margin-top:5px; 
}

@media all and (max-width: 1199px) and (min-width: 701px) {
  h1 {font-size:24px;}
  #issuerLogo { max-height : 64px;  max-width:140%; }
  #networkLogo { max-height : 72px;px;  max-width:100%; }
  #optGblPage { font-size : 14px; }
  .leftColumn { display:block; float:none; width:100%; }
  .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
  div.side-menu div.menu-title { padding-left:0px; text-align:center; }
  side-menu div.text-center { text-align:center; }
}

@media all and (max-width: 700px) and (min-width: 481px) {
  h1 { font-size:18px; }
  #optGblPage { font-size : 14px;}
  #issuerLogo { max-height : 54px;  max-width:160%; }
  #networkLogo { max-height : 67px;  max-width:100%; padding-top: 25px;}
  .leftColumn { display:block; float:none; width:100%; }
  .rightColumn { margin-left:0px; display:block; float:none; width:100%; }
  div.side-menu div.menu-title { padding-left:0px; text-align:center; }
  side-menu div.text-center { text-align:center; }
}

@media all and (max-width: 480px) {
  h1 { font-size:16px; }
  div.side-menu div.menu-title { display:inline; }
  #optGblPage { font-size : 14px;}
  #issuerLogo { max-height : 42px;  max-width:160%; }
  #networkLogo { max-height : 62px;  max-width:100%; padding-top: 25px; }
  .leftColumn { display:block; float:none; width:100%; }
  .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
  div.side-menu div.menu-title { padding-left:0px; text-align:center; }
  side-menu div.text-center { text-align:center; }
  #footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
  #pageHeader { height: 75px; }
}
</style>
<div id="optGblPage">
  <div id="pageHeader" ng-style="style" class="ng-scope">
    <div id="pageHeaderLeft" ng-style="style" class="ng-scope">
      <custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
    </div>
    <div id="pageHeaderRight" ng-style="style" class="ng-scope" >
      <custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
    </div>
  </div>

  <message-banner></message-banner>

  <div id="i18n-container" class="text-center">
    <div id="i18n-inner">
      <i18n></i18n>
    </div>
  </div>
  <div id="displayLayout" class="row">
    <div id="green-banner"></div>
  </div>
  <style>
    div#green-banner {
      height: 50px !important;
      background-color: #CED8F6;
      border-bottom: 5px solid #CED8F6;
      width: 100%;
    }
  </style>
  <div class="contentRow">
    <div x-ms-format-detection="none" class="leftColumn">
      <side-menu menu-title="\'TRANSACTION_SUMMARY\'"></side-menu>
    </div>
    <div class="rightColumn">
      <div class="paragraph">
        <custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
      </div>
      <div class="paragraph">
        <custom-text custom-text-key="\'network_means_pageType_2\'" id="paragraph2"></custom-text>
      </div>
    </div>
  </div>
  <div id="footer">
    <div ng-style="style" class="style">
      <help help-label="\'network_means_pageType_41\'" id="helpButton" ></help>
    </div>
  </div>
</div>
', @layoutId);  

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (',@BankB, ')%') );
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '
<style>
div#optGblPage {
  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size:14px;
}
#helpButton button {
  font: 300 16px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
  display:inline-block;
  white-space: nowrap;
  text-align: center;
  height: 40px;
  background: #fff;
  color: #323232;
  border: 1px solid rgba(0,0,0,.25);
  min-width: 15rem;
  border-radius: 4px;
  font-size: 16px;
  padding-left: 0px !important;
}
#helpButton button:hover {
  border-color: rgba(255,106,16,.75);
}
#helpButton button:active {
  background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
  border-color: rgba(0,0,0,.25) rgba(0,0,0,.2) rgba(0,0,0,.15);
  box-shadow: none;
  outline: 0px;
}
#helpButton button custom-text {
  vertical-align:8px;
}
#footer #helpButton button span:before {
  content:'';
}
#footer #cancelButton button span:before {
  content:'';
}
#footer #helpButton button span.fa {
  background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
  width:24px;
  height:26px;
  background-position-y: -1px;
  background-position-x: -2px;
  background-size: 115%;
  display:inline-block;
}
#helpCloseButton button {
  padding-left: 0px !important;
}
#helpCloseButton button span.fa {
  background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
  width:24px;
  height:26px;
  background-position-x: -2px;
  background-size: 115%;
  display:inline-block;
}
#helpCloseButton button span + span {
  margin-top: 1px;
}
#footer {
  padding-top: 12px;
  padding-bottom:12px;
  clear:both; 
  width:100%;
  background-color:#CED8F6;
  text-align:center;
  margin-top: 15px;
  margin-bottom : 15px;
}
#i18n-container {
  width:100%;
  clear:both;
}
#i18n-inner {
  display: block;
  margin-left: auto;
  margin-right: auto;
  clear:both;
}
#i18n > button {
  background: transparent;
  color: #557a8e;
  border: none;
  box-shadow: none;
}
#i18n > button.active {
  background: #06446c !important;
  color:#FFFFFF!important;
  border-radius: 5px !important;
}
#issuerLogo {
  max-height: 64px;
  padding-left: 0px;
  padding-right: 0px;
}
#networkLogo {
  max-height: 82px;
  padding-top: 16px;
  padding-right: 16px;
}
#pageHeader {
  width: 100%;
  height: 96px;
  border-bottom: 1px solid #DCDCDC;
}
#pageHeaderLeft {
  width: 20%;
  float: left;
  padding-left: 16px;
  padding-top: 16px;
}
#pageHeaderCenter {
  width: 60%;
  float: left;
  text-align: center;
  line-height: 70px;
  padding-top: 16px;
}
#pageHeaderRight {
  width: 20%;
  float: right;
  text-align: right;
}
.leftColumn {
  width:30%;
  display:block;
  float:left;
  padding:1em;
}
.rightColumn {
  width:70%;
  margin-left:30%;
  display:block;
  text-align:left;
  padding:20px 10px;
}
.contentRow {
  width:100%;
  padding:1em;
  padding:0px;
  padding-top:1em;
  clear:both;
}
side-menu div.text-center {
  text-align:left;
}
div.side-menu div.menu-title::before {
  display:inline;
}
div.side-menu div.menu-title::after {
  display:inline;
}
div.side-menu div.menu-title {
  display:inline;
  padding-left:50.9%;
  text-align:left;
  font-size: 18px;
}
div.side-menu div.menu-elements {
  margin-top:5px; 
}

@media all and (max-width: 1199px) and (min-width: 701px) {
  h1 {font-size:24px;}
  #issuerLogo { max-height : 64px;  max-width:140%; }
  #networkLogo { max-height : 72px;px;  max-width:100%; }
  #optGblPage { font-size : 14px; }
  .leftColumn { display:block; float:none; width:100%; }
  .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
  div.side-menu div.menu-title { padding-left:0px; text-align:center; }
  side-menu div.text-center { text-align:center; }
}

@media all and (max-width: 700px) and (min-width: 481px) {
  h1 { font-size:18px; }
  #optGblPage { font-size : 14px;}
  #issuerLogo { max-height : 54px;  max-width:160%; }
  #networkLogo { max-height : 67px;  max-width:100%; padding-top: 25px;}
  .leftColumn { display:block; float:none; width:100%; }
  .rightColumn { margin-left:0px; display:block; float:none; width:100%; }
  div.side-menu div.menu-title { padding-left:0px; text-align:center; }
  side-menu div.text-center { text-align:center; }
}

@media all and (max-width: 480px) {
  h1 { font-size:16px; }
  div.side-menu div.menu-title { display:inline; }
  #optGblPage { font-size : 14px;}
  #issuerLogo { max-height : 42px;  max-width:160%; }
  #networkLogo { max-height : 62px;  max-width:100%; padding-top: 25px; }
  .leftColumn { display:block; float:none; width:100%; }
  .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
  div.side-menu div.menu-title { padding-left:0px; text-align:center; }
  side-menu div.text-center { text-align:center; }
  #footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
  #pageHeader { height: 75px; }
}
</style>
<div id="optGblPage">
  <div id="pageHeader" ng-style="style" class="ng-scope">
    <div id="pageHeaderLeft" ng-style="style" class="ng-scope">
      <custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
    </div>
    <div id="pageHeaderRight" ng-style="style" class="ng-scope" >
      <custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
    </div>
  </div>

  <message-banner></message-banner>

  <div id="i18n-container" class="text-center">
    <div id="i18n-inner">
      <i18n></i18n>
    </div>
  </div>
  <div id="displayLayout" class="row">
    <div id="green-banner"></div>
  </div>
  <style>
    div#green-banner {
      height: 50px !important;
      background-color: #CED8F6;
      border-bottom: 5px solid #CED8F6;
      width: 100%;
    }
  </style>
  <div class="contentRow">
    <div x-ms-format-detection="none" class="leftColumn">
      <side-menu menu-title="\'TRANSACTION_SUMMARY\'"></side-menu>
    </div>
    <div class="rightColumn">
      <div class="paragraph">
        <custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
      </div>
      <div class="paragraph">
        <custom-text custom-text-key="\'network_means_pageType_2\'" id="paragraph2"></custom-text>
      </div>
    </div>
  </div>
  <div id="footer">
    <div ng-style="style" class="style">
      <help help-label="\'network_means_pageType_41\'" id="helpButton" ></help>
    </div>
  </div>
</div>
', @layoutId);  

/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;


/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.
  Or, rather, use the tool in the Back-Office (Custom items creator) and then extract the information from the database */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`)
VALUES (@createdBy, NOW(), CONCAT(@BankB,' Logo'), NULL, NULL, @BankB, 'PUSHED_TO_CONFIG', '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');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_1_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_1_REFUSAL'), 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_SMS'), 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* BinRange */
/* In this table, in the case of co-branding the primary network will be present as a foreign key (fk_id_network) and
   the 'alternative' network will be present through the field 'coBrandedCardNetwork' which contains a string that matches
   the field 'code' of the Network (it plays the same role as a foreign key, because the code is unique for each Network)
*/
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '4293820000', 16, FALSE, NULL, '4293829999', FALSE, @ProfileSet, @MaestroVID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '4311700000', 16, FALSE, NULL, '4311709999', FALSE, @ProfileSet, @MaestroVID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '4573580000', 16, FALSE, NULL, '4573589999', FALSE, @ProfileSet, @MaestroVID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '4840630000', 16, FALSE, NULL, '4840639999', FALSE, @ProfileSet, @MaestroVID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '5179680000', 16, FALSE, NULL, '5179689999', FALSE, @ProfileSet, @MaestroMID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '5179820000', 16, FALSE, NULL, '5179829999', FALSE, @ProfileSet, @MaestroMID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '5203520000', 16, FALSE, NULL, '5203529999', FALSE, @ProfileSet, @MaestroMID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '5243020000', 16, FALSE, NULL, '5243029999', FALSE, @ProfileSet, @MaestroMID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '5243180000', 16, FALSE, NULL, '5243189999', FALSE, @ProfileSet, @MaestroMID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '5523660000', 16, FALSE, NULL, '5523669999', FALSE, @ProfileSet, @MaestroMID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '5532830000', 16, FALSE, NULL, '5532839999', FALSE, @ProfileSet, @MaestroMID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '5532860000', 16, FALSE, NULL, '5532869999', FALSE, @ProfileSet, @MaestroMID, NULL);


/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4293820000' AND b.upperBound='4293829999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4311700000' AND b.upperBound='4311709999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4573580000' AND b.upperBound='4573589999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4840630000' AND b.upperBound='4840639999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5179680000' AND b.upperBound='5179689999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5179820000' AND b.upperBound='5179829999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5203520000' AND b.upperBound='5203529999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5243020000' AND b.upperBound='5243029999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5243180000' AND b.upperBound='5243189999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5523660000' AND b.upperBound='5523669999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5532830000' AND b.upperBound='5532839999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5532860000' AND b.upperBound='5532869999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

/* CustomItem */
/* Create custom items for default language and backup languages - in this example de and en */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;

/* Elements for the profile DEFAULT_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_1_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, @BankB, @MaestroVID, im.id, @customItemSetREFUSAL 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, @BankB, @MaestroMID, im.id, @customItemSetREFUSAL 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'RCBC Bankard does not have a record of your mobile number. Please call 888-1-888.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Your mobile number is required for you to receive the dynamic One-Time Password (OTP) that is essential in completing your online transaction.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Payment declined', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'No mobile number on record', @MaestroVID, NULL, @customItemSetREFUSAL),
		 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetREFUSAL);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'RCBC Bankard does not have a record of your mobile number. Please call 888-1-888.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Your mobile number is required for you to receive the dynamic One-Time Password (OTP) that is essential in completing your online transaction.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Payment declined', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'No mobile number on record', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetREFUSAL);


SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, 'To further enhance security whenever you use your RCBC Bankard to purchase online, RCBC Bankard has implemented the use of dynamic One-Time Password (OTP).', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'The OTP will be sent to your registered mobile number and this has to be supplied in order to complete your transaction.', @MaestroVID, NULL, @customItemSetREFUSAL),
  
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @helpPage, 'To ensure a safe and secure online shopping experience, please ensure that your mobile number on file is updated. For any change in mobile number, please call 888-1-888.', @MaestroVID, NULL, @customItemSetREFUSAL);
		 
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, 'To further enhance security whenever you use your RCBC Bankard to purchase online, RCBC Bankard has implemented the use of dynamic One-Time Password (OTP).', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'The OTP will be sent to your registered mobile number and this has to be supplied in order to complete your transaction.', @MaestroMID, NULL, @customItemSetREFUSAL),
  
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @helpPage, 'To ensure a safe and secure online shopping experience, please ensure that your mobile number on file is updated. For any change in mobile number, please call 888-1-888.', @MaestroMID, NULL, @customItemSetREFUSAL);

/* Elements for the profile SMS : */
SET @currentAuthentMean = 'OTP_SMS';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the SMS Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankB, @MaestroVID, im.id, @customItemSetSMS 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankB, @MaestroMID, im.id, @customItemSetSMS 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'en', 0, 'MESSAGE_BODY',
        'Do not share your RCBC Bankard One-Time Password (OTP) to anyone. Your OTP is @otp for your transaction at @merchant. Expires in 4 mins.', @MaestroVID, NULL, @customItemSetSMS);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'en', 0, 'MESSAGE_BODY',
        'Do not share your RCBC Bankard One-Time Password (OTP) to anyone. Your OTP is @otp for your transaction at @merchant. Expires in 4 mins.', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Enter the One-Time Password (OTP) received by SMS.</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'If you did not receive the OTP, please call RCBC Bankard Customer Service at 888-1-888.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @currentPageType, 'As an additional step to protect your credit card against possible fraudulent use, and to complete transaction, please enter the OTP that was sent to your registered mobile number. You should receive the OTP within four (4) minutes from the time you checked out.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'en', 12, @currentPageType, 'Authentication in progress', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'en', 13, @currentPageType, 'Your input is being checked and the page will be updated automatically in a few seconds.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'en', 14, @currentPageType, 'Transaction cancelled', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'en', 15, @currentPageType, 'You have cancelled the transaction.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'en', 26, @currentPageType, 'Authentication successful', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'en', 27, @currentPageType, 'Your authentication has been validated, you will be redirected to the shop.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'en', 28, @currentPageType, 'Wrong One-Time Password (OTP) entered', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'en', 29, @currentPageType, 'The OTP that you have entered is incorrect.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'en', 30, @currentPageType, 'Session expired', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'en', 31, @currentPageType, 'We´re sorry. Your session has expired and your purchase has been cancelled.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Technical Error', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'The purchase cannot be completed at this time. We apologize for any inconvenience. To re-try making a purchase, click Back to the shop.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'en', 40, @currentPageType, 'Cancel purchase', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetSMS);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Enter the One-Time Password (OTP) received by SMS.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'If you did not receive the OTP, please call RCBC Bankard Customer Service at 888-1-888.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @currentPageType, 'As an additional step to protect your credit card against possible fraudulent use, and to complete transaction, please enter the OTP that was sent to your registered mobile number. You should receive the OTP within four (4) minutes from the time you checked out.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'en', 12, @currentPageType, 'Authentication in progress', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'en', 13, @currentPageType, 'Your input is being checked and the page will be updated automatically in a few seconds.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'en', 14, @currentPageType, 'Transaction cancelled', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'en', 15, @currentPageType, 'You have cancelled the transaction.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'en', 26, @currentPageType, 'Authentication successful', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'en', 27, @currentPageType, 'Your authentication has been validated, you will be redirected to the shop.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'en', 28, @currentPageType, 'Wrong One-Time Password (OTP) entered', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'en', 29, @currentPageType, 'The OTP that you have entered is incorrect.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'en', 30, @currentPageType, 'Session expired', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'en', 31, @currentPageType, 'We´re sorry. Your session has expired and your purchase has been cancelled.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Technical Error', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'The purchase cannot be completed at this time. We apologize for any inconvenience. To re-try making a purchase, click Back to the shop.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'en', 40, @currentPageType, 'Cancel purchase', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the HELP page, for SMS Profile */
SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, 'To further enhance security whenever you use your RCBC Bankard to purchase online, RCBC Bankard has implemented the use of dynamic One-Time Password (OTP).', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'The OTP will be sent to your registered mobile number and this has to be supplied in order to complete your transaction.', @MaestroVID, NULL, @customItemSetSMS),
  
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @helpPage, 'To ensure a safe and secure online shopping experience, please ensure that your mobile number on file is updated. For any change in mobile number, please call 888-1-888.', @MaestroVID, NULL, @customItemSetSMS);
		 
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, 'To further enhance security whenever you use your RCBC Bankard to purchase online, RCBC Bankard has implemented the use of dynamic One-Time Password (OTP).', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'The OTP will be sent to your registered mobile number and this has to be supplied in order to complete your transaction.', @MaestroMID, NULL, @customItemSetSMS),
  
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @helpPage, 'To ensure a safe and secure online shopping experience, please ensure that your mobile number on file is updated. For any change in mobile number, please call 888-1-888.', @MaestroMID, NULL, @customItemSetSMS);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'We´re sorry. You have entered the wrong One-Time Password (OTP) three (3) times.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Your purchase has not been completed. For concerns, please call RCBC Bankard Customer Service at 888-1-888.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, 'Identification failure', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'You have entered the wrong One-Time Password (OTP) three (3) times.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetSMS);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'We´re sorry. You have entered the wrong One-Time Password (OTP) three (3) times.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Your purchase has not been completed. For concerns, please call RCBC Bankard Customer Service at 888-1-888.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, 'Identification failure', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'You have entered the wrong One-Time Password (OTP) three (3) times.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the REFUSAL page, for SMS Profile */
SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'RCBC Bankard does not have a record of your mobile number. Please call 888-1-888.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Your mobile number is required for you to receive the dynamic One-Time Password (OTP) that is essential in completing your online transaction.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Payment declined', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'No mobile number on record', @MaestroVID, NULL, @customItemSetSMS),
		 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetSMS);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'RCBC Bankard does not have a record of your mobile number. Please call 888-1-888.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Your mobile number is required for you to receive the dynamic One-Time Password (OTP) that is essential in completing your online transaction.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Payment declined', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'No mobile number on record', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS);


/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;
SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_1_REFUSAL'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_SMS'));
SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), 'REFUSAL (FRAUD)', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', -1, @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'OTP_SMS', NULL, NULL, CONCAT(@BankUB,'_SMS_01'), 'PUSHED_TO_CONFIG', 3, @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID);

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', 'PUSHED_TO_CONFIG', 1, @profileRefusal),
  (@createdBy, NOW(), 'SMS_AVAILABLE_NORMAL', NULL, NULL, 'SMS (NORMAL)', 'PUSHED_TO_CONFIG', 2, @profileSMS),
  (@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 4, @profileRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES 
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C2_P_',@BankUB,'_01_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL'), 'PUSHED_TO_CONFIG', @ruleSMSnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_DEFAULT'), 'PUSHED_TO_CONFIG', @ruleRefusalDefault);
/*!40000 ALTER TABLE `RuleCondition` ENABLE KEYS */;

/* Condition_TransactionStatuses */
/*!40000 ALTER TABLE `Condition_TransactionStatuses` DISABLE KEYS */;
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_FRAUD') AND (ts.`transactionStatusType`='PAYMENT_MEANS_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_FRAUD') AND (ts.`transactionStatusType`='CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C2_P_',@BankUB,'_01_FRAUD') AND (ts.`transactionStatusType`='MERCHANT_URL_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL') AND (ts.`transactionStatusType`='KNOWN_PHONE_NUMBER' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL') AND (ts.`transactionStatusType`='PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_DEFAULT') AND (ts.`transactionStatusType`='DEFAULT' AND ts.`reversed`=FALSE);
/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;

/* Condition_MeansProcessStatuses */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));

SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = CONCAT('PS_',@BankUB,'_01') AND r.`id` IN (@ruleRefusalFraud, @ruleSMSnormal, @ruleRefusalDefault);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES
  ('ISSUER', 'TestMerchant', 'NAME', 0, 0, @issuerId, @subIssuerID);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
