/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

/* Two new AthentMeans for Consorsbank */
/*!40000 ALTER TABLE `AuthentMeans` DISABLE KEYS */;
INSERT INTO `AuthentMeans` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`) VALUES
  ('A169318', NOW(), NULL, NULL, NULL, 'TOKEN', 'PUSHED_TO_CONFIG');
/*!40000 ALTER TABLE `AuthentMeans` ENABLE KEYS */;

/* Issuer */
/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
INSERT INTO `Issuer` (`code`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                      `updateState`, `label`, `authentMeans`, `availaibleAuthentMeans`) VALUES
  ('16900', 'A169318', NOW(), NULL, NULL, NULL, 'Consorsbank', 'PUSHED_TO_CONFIG', 'Consorsbank',
      '[{"authentMeans":"OTP_SMS", "validate":true}, {"authentMeans":"TOKEN", "validate":true}, {"authentMeans":"ATTEMPT", "validate":true}, {"authentMeans":"REFUSAL", "validate":true}]',
   'OTP_SMS|TOKEN|ATTEMPT|REFUSAL');
/*!40000 ALTER TABLE `Issuer` ENABLE KEYS */;

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '16900');
INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `otpExcluded`, `otpAllowed`, `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `fk_id_issuer`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`) VALUES
  ('ACS_U5G', 300, '', '16900', '16900', 'EUR', 'A169318', NOW(), NULL, NULL, NULL, 'Consorsbank', 'PUSHED_TO_CONFIG', 'de', 600, 'Consorsbank', b'1', b'1', '^[^OIi]*$', '8:(:DIGIT:1)', NULL, b'1', b'1', 300, @issuerId, 'https://ssl-qlf-u9f-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest', 'https://ssl-qlf-u9f-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest', 'https://ssl-qlf-u9f-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest', 'https://ssl-qlf-u9f-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest', b'0', b'1', b'1', b'1', 'OTP_SMS', '250', 'VE_AND_PA_MODE');
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;

/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '16900');
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId;
/*!40000 ALTER TABLE `Network_SubIssuer` ENABLE KEYS */;

--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
--  /!\ SubIssuerCrypto                                                            /!\
--  /!\ This is a very specific configuration, contact your Project Manager to get /!\
--  /!\ the correct information for your instance                                  /!\
--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
/*!40000 ALTER TABLE `SubIssuerCrypto` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '16900');
INSERT INTO `SubIssuerCrypto` (`acsIdForCrypto`, `binKeyIdentifier`, `cavvKeyIndicator`, `cipherKeyIdentifier`,
                               `desCipherKeyIdentifier`, `desKeyId`, `hubAESKey`, `secondFactorAuthentication`, `fk_id_subIssuer`)
    SELECT '0A', '1', '03', 'EC11223344554B544F4B5F4D5554555F414301', 'EC09250002314B544F4B5F4B454B5F41485300', '1', '01', 'NO_SECOND_FACTOR', si.id
    FROM `SubIssuer` si WHERE si.fk_id_issuer = @issuerId;
/*!40000 ALTER TABLE `SubIssuerCrypto` ENABLE KEYS */;

--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
--  /!\ SubIssuerNetworkCrypto                                                     /!\
--  /!\ This is a very specific configuration, contact your Project Manager to get /!\
--  /!\ the correct information for your instance                                  /!\
--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
/*!40000 ALTER TABLE `SubIssuerNetworkCrypto` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '16900');
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
    WHERE n.code='VISA' AND si.fk_id_issuer = @issuerId;

INSERT INTO `SubIssuerNetworkCrypto` (`authorityCertificate`, `authorityCertificateExpiryDate`, `cardNetworkAlgorithm`,
                                      `cardNetworkIdentifier`, `cardNetworkSeqGenerationMethod`, `cardNetworkSignatureKey`,
                                      `rootCertificate`, `rootCertificateExpiryDate`, `signingCertificate`, `signingCertificateExpiryDate`,
                                      `fk_id_network`, `fk_id_subIssuer`)
  SELECT 'MIIEgDCCA2igAwIBAgIQQ3EBfDozHhKp3pmzcHr6ZzANBgkqhkiG9w0BAQUFADCBgDELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFE1hc3RlckNhcmQgV29ybGR3aWRlMS4wLAYDVQQLEyVNYXN0ZXJDYXJkIFdvcmxkd2lkZSBTZWN1cmVDb2RlIEdlbiAyMSIwIAYDVQQDExlQUkQgTUMgU2VjdXJlQ29kZSBSb290IENBMB4XDTEyMDYyMjA5MjIxNFoXDTI1MDYyMTA5MjIxNVowgYYxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEoMCYGA1UEAxMfUFJEIE1DIFNlY3VyZUNvZGUgSXNzdWVyIFN1YiBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANaeBgfjTKIFls7ueMTzI2nYwAbocHwkQqd8BsIyJbZdk21E+vyq9EhX1NIoiAhP7fl+y/hosX66drjfrbyspZLalrVG6gYbdB2j2Sr8zBRQnMZKKluDwYv/266nnRBeyGYW3FwyVu8L1ACYQc04ACke+07NI/AZ8OXQSoeboEEGUO520/76o1cER5Ok9HRi0jJD8E64j8dEt36Mcg0JaKQiDjShlyTw4ABYyzZ1Vxl0/iDrfwboxNEOOooC0rcGNnCpISXMWn2NmZH1QxiFt2jIZ8QzF3/z+M3iYradh9uZauleNqJ9LPKr/aFFDbe0Bv0PLbvXOnFpwOxvJODWUj8CAwEAAaOB7TCB6jAPBgNVHRMECDAGAQH/AgEAMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUwTArnR3hR1+Ij1uxMtqoPBm2j7swgacGA1UdIwSBnzCBnKGBhqSBgzCBgDELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFE1hc3RlckNhcmQgV29ybGR3aWRlMS4wLAYDVQQLEyVNYXN0ZXJDYXJkIFdvcmxkd2lkZSBTZWN1cmVDb2RlIEdlbiAyMSIwIAYDVQQDExlQUkQgTUMgU2VjdXJlQ29kZSBSb290IENBghEA7qGSrpcB0q8DkgwCPcT3kzANBgkqhkiG9w0BAQUFAAOCAQEA3lJuYVdiy11ELUfBfLuib4gPTbkDdVLBEKosx0yUDczeXoTUOjBEc90f5KRjbpe4pilOGAQnPNUGpi3ZClS+0ysTBp6RdYz1efNLSuaTJtpJpoCOk1/nw6W+nJEWyDXUcC/yVqstZidcOG6AMfKU4EC5zBNELZCGf1ynM2l+gwvkcDUv4Y2et/n/NqIKBzywGSOktojTma0kHbkAe6pj6i65TpwEgEpywVl50oMmNKvXDNMznrAG6S9us+OHDjonOlmmyWmQxXdU1MzwdKzPjHfwl+Z6kByDXruHjEcNsx7P2rUTm/Bt3SWW1K48VfNNhVa/WctTZGJCrV3Zjl6A9g==',
    NULL, 'HMAC_MASTERCARD_SPA', '241122334455554341465F4D5554555F414300', 'HEX_TIMESTAMP', 'ED11223344554B544F525F4D5554555F414310',
    'MIIDzzCCAregAwIBAgIRAO6hkq6XAdKvA5IMAj3E95MwDQYJKoZIhvcNAQEFBQAwgYAxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEiMCAGA1UEAxMZUFJEIE1DIFNlY3VyZUNvZGUgUm9vdCBDQTAeFw0xMjA2MjIwOTA4MzBaFw0yNTA2MjIwOTA4MzFaMIGAMQswCQYDVQQGEwJVUzEdMBsGA1UEChMUTWFzdGVyQ2FyZCBXb3JsZHdpZGUxLjAsBgNVBAsTJU1hc3RlckNhcmQgV29ybGR3aWRlIFNlY3VyZUNvZGUgR2VuIDIxIjAgBgNVBAMTGVBSRCBNQyBTZWN1cmVDb2RlIFJvb3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDptCms6aI22T9ST60k487SZP06TKbUBpom7Z1Bo8cQQAE/tM5UOt3THMdrhT+2aIkj9T0pA35IyNMCNGDt+ejhy7tHdw1r6eDX/KXYHb4FlemY03DwRrkQSH/L+ZueS5dCfLM3m2azxBXtrVXDdNebfht8tcWRLK2Ou6vjDzdIzunuWRZ6kRDQ6oc1LSVO2BxiFO0TKowJP/M7qWRT/Jsmb6TGg0vmmQG9QEpmVmOZIexVxuYy3rn7gEbV1tv3k4aG0USMp2Xq/Xe4qe+Ir7sFqR56G4yKezSVLUzQaIB/deeCk9WU2T0XmicAEYDBQoecoS61R4nj5ODmzwmGyxrlAgMBAAGjQjBAMA8GA1UdEwQIMAYBAf8CAQEwDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQqFTcxVDO/uxI1hpFF3VSSTFMGujANBgkqhkiG9w0BAQUFAAOCAQEAhDOQ5zUX2wByVv0Cqka3ebnm/6xRzQQbWelzneDUNVdctn1nhJt2PK1uGV7RBGAGukgdAubwwnBhD2FdbhBHTVbpLPYxBbdMAyeC8ezaXGirXOAAv0YbGhPl1MUFiDmqSliavBFUs4cEuBIas4BUoZ5Fz042dDSAWffbdf3l4zrU5Lzol93yXxxIjqgIsT3QI+sRM3gg/Gdwo80DUQ2fRffsGdAUH2C/8L8/wH+E9HspjMDkXlZohPII0xtKhdIPWzbOB6DOULl2PkdGHmJc4VXxfOwE2NJAQxmoaPRDYGgOFVvkzYtyxVkxXeXAPNt8URR3jfWvYrBGH2D5A44Atg==',
    NULL, 'MIIEgDCCA2igAwIBAgIRANPdOMI3PRuQ2QrYW3TiHIAwDQYJKoZIhvcNAQEFBQAwgYYxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEoMCYGA1UEAxMfUFJEIE1DIFNlY3VyZUNvZGUgSXNzdWVyIFN1YiBDQTAeFw0xNzA3MjgxMTMyNTBaFw0yMTA3MjcxMTI5NDRaMHkxCzAJBgNVBAYTAkZSMR0wGwYDVQQKExRDUkVESVQgQUdSSUNPTEUgUy5BLjEnMCUGA1UECxMeQVRPUyBXb3JsZExpbmUgV0xQIC0gSUNBIDEyNjUzMSIwIAYDVQQDExlXTFAtQUNTIENBU0EgU2lnbmF0dXJlIE1DMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuO0yGOwsu/icuH+OPbAaSWWTUL+oePoapJ6bNZd41g8dG9fKOgRzHW+dMIrkKeXKHHQvrvU6JNJoPFWAGxeOa4D0vsp1AZKOWiWlsss6kLn0fDj7nwDErCHJNJWi3TmmSL8s8ujOrRsveZhoDtLDp1E/Q+PoG3uoI4PcH3DqlF/8IfY/0z9F9avb+uCFvOXoh6dV5LRe2mYY62KiJHvdaAPlGwPnFPgLtJafgv9RVVGyxXhxZSM1R6hX2pP28219BlDQEbQtkqHJI/3/NW5x9HjddXpbtqKt29NXfmTJym6pfZrWTXn2qXuXokPcR5TE3EWz3zGsNSkltOc0ADANsQIDAQABo4H0MIHxMCsGA1UdEAQkMCKADzIwMTcwNzI4MTEzMjUwWoEPMjAyMDA3MjcxMTMyNTBaMA4GA1UdDwEB/wQEAwIHgDAJBgNVHRMEAjAAMIGmBgNVHSMEgZ4wgZuhgYakgYMwgYAxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEiMCAGA1UEAxMZUFJEIE1DIFNlY3VyZUNvZGUgUm9vdCBDQYIQQ3EBfDozHhKp3pmzcHr6ZzANBgkqhkiG9w0BAQUFAAOCAQEAb72VYXYGFGeuoxjrq2vDduEp6gHii2SwWaf3D/wuybihroryJVMW9AX3SG8IVHEINqtqg/dTgo8TfJnJ0QEiGN0TlmFHzSptil6lBAlSnHjrEsIBG52bLKtGwCrE7Hzfx8fqW5XmlyrDJK7MaaIrFe5GPMXBLL7+nazbpemy06+9RvyDLisgxx8DPRkdZdfoQfKTH5sWUtr2VMA5NtMQAtHjMhQOFuOpfbwNz4iC/jHDM6/Zs4D4zcVFKQwS4ngtf5q4dwOdQ6nYdpreWcgbmzuH7PIRQWsO4sWpzWlwknWKeU/r2iOaRndxAmxmR3oJVFYHqD/6fy0NDoBwIrdrjA==',
    NULL, n.id, si.id
    FROM Network n, SubIssuer si
    WHERE n.code='MASTERCARD'  AND si.fk_id_issuer = @issuerId;
/*!40000 ALTER TABLE `SubIssuerNetworkCrypto` ENABLE KEYS */;

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '16900');
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT 'A169318', NOW(), 'Consorsbank profile set', NULL, NULL, CONCAT('PS_', si.code, '_01'), 'PUSHED_TO_CONFIG', si.id
    FROM `SubIssuer` si
    WHERE si.fk_id_issuer=@issuerId;
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `CustomPageLayout` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `controller` varchar(255) DEFAULT NULL,
  `pageType` varchar(255) DEFAULT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `CustomComponent` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `controller` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` LONGTEXT NULL,
  `fk_id_layout` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `CustomComponent_CustomLayout_id_KEY` (`fk_id_layout`),
  KEY `CustomComponent_CustomComponent_id_KEY` (`parent_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;


SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_16900_01');

/* ------------------------------- */
/*!40000 ALTER TABLE `CustomPageLayout` DISABLE KEYS */;

/*!40000 ALTER TABLE `CustomComponent` DISABLE KEYS */;

INSERT INTO `CustomPageLayout` (`pageType`, `description`) VALUES
  ('MESSAGE_BANNER', 'Message Banner (Consorsbank)');

SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MESSAGE_BANNER' and DESCRIPTION = 'Message Banner (Consorsbank)') ;
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
  '
  <span id="info-icon" class="col-xs-12 col-sm-1 fa fa-info-circle"></span>
  <custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
  <custom-text id="message" custom-text-key="$parent.message"></custom-text>

  <style>
    span#info-icon {
        left: auto;
    }
    #headingTxt {
        font-size : large;
        font-weight : bold;
        width : 80%;
        margin : auto;
        display : block;
    }
  </style>
  ', @lastCPLId);

INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES
  (@lastCPLId, @ProfileSet);
/* ------------------------------- */
/* ------------------------------- */  
 
INSERT INTO `CustomPageLayout` (`pageType`, `description`) VALUES  
  ('HELP_PAGE', 'Help Page (Consorsbank)');
  
SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'HELP_PAGE' and DESCRIPTION = 'Help Page (Consorsbank)') ;
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
    '
<div class="container-fluid">
    <div class=" col-xs-12 col-md-10 col-md-offset-1">
        <div id="helpContent">
            <div class="paragraph">
                <custom-text custom-text-key="''network_means_HELP_PAGE_1''" id="paragraph1">
                </custom-text>
            </div>
            <div class="paragraph">
                <custom-text custom-text-key="''network_means_HELP_PAGE_2''" id="paragraph2">
                </custom-text>
            </div>
            <div class="paragraph">
                <custom-text custom-text-key="''network_means_HELP_PAGE_3''" id="paragraph3">
                </custom-text>
            </div>
            <div class="paragraph">
                <custom-text custom-text-key="''network_means_HELP_PAGE_4''" id="paragraph4">
                </custom-text>
            </div>
            <help-close-button id="helpCloseButton"></help-close-button>
        </div>
    </div>
</div>

<style>
    #helpContent {
        padding: 5px 10px 0px;
        min-height: 200px;
        text-align: justify;
    }
    .paragraph {
        margin: 0px 0px 10px;
        text-align: justify;
    }
</style>
', @lastCPLId);
  

INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES
  (@lastCPLId, @ProfileSet);
/* ------------------------------- */  
/* ------------------------------- */ 
INSERT INTO `CustomPageLayout` (`pageType`, `description`) VALUES  
  ('HAMBURGER_MENU', 'Hamburger Menu (Consorsbank)');

SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'HAMBURGER_MENU' and DESCRIPTION = 'Hamburger Menu (Consorsbank)') ;
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
    VALUES( 'div', '
<div id="content">
    <div id="hamburger-i18n" class="text-center">
        <i18n></i18n>
    </div>

    <custom-text custom-text-key="$parent.$parent.hamburgerTextKey" id="hamburgerText"></custom-text>

    <div id="hamburgerBottomMenu" class="text-center">
        <div class="btn-group">
            <div id="inlineCancel">
                <cancel-button cn-label="''network_means_HAMBURGER_MENU_40''" id="hamburgerCancelButton">
                </cancel-button>
            </div>
            <div id="inlineInfo">
                <help help-label="''network_means_HAMBURGER_MENU_41''" id="hamburgerHelpButton">
                </help>
            </div>
        </div>
    </div>
</div>
<style>
    #hamburgerText {
        display: block;
        padding: 2px 0px;
    }
    #hamburgerBottomMenu {
        border-top: 5px solid rgb(0, 100, 62);
        padding: 8px 3px 8px;
    }
    #hamburgerCancelButton, #hamburgerHelpButton {
        width: 200px;
        margin-top: 5px;
        margin-bottom: 5px;
    }
    #inlineCancel, #inlineInfo {
        display: inline-block;
        padding: 5px;
    }
</style>
', @lastCPLId);  

INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES
  (@lastCPLId, @ProfileSet);
/* ------------------------------- */  
/* ------------------------------- */ 
INSERT INTO `CustomPageLayout` (`pageType`, `description`) VALUES  
  ('OTP_FORM_PAGE', 'OTP Form Page (Consorsbank)');
  
SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_FORM_PAGE' and DESCRIPTION = 'OTP Form Page (Consorsbank)') ;
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
    VALUES( 'div', '<div class="container-fluid">
    <div id="headerLayout" class="row">
        <div id="pageHeader" class="text-center col-xs-12">
            <div class="row">
                <div class=" col-xs-4 col-lg-3">
                    <custom-image id="issuerLogo"
                                  alt-key="''network_means_pageType_1_IMAGE_ALT''"
                                  image-key="''network_means_pageType_1_IMAGE_DATA''"
                                  straight-mode="false">
                    </custom-image>
                </div>
                <div class=" col-xs-4 col-lg-6">
                    <div id="centeredTitle">
                        <custom-text id="page-title" custom-text-key="''network_means_pageType_20''">
                        </custom-text>
                    </div>
                </div>
                <div class=" col-xs-4 col-lg-3">
                    <custom-image id="networkLogo"
                                  alt-key="''network_means_pageType_2_IMAGE_ALT''"
                                  image-key="''network_means_pageType_2_IMAGE_DATA''"
                                  straight-mode="false">
                    </custom-image>
                </div>
            </div>
        </div>
    </div>
    <style>
        #issuerLogo,
        #networkLogo {
            max-height: 75px;
            max-width: 100%;
            height: auto;
            padding: 0px;
        }
        #centeredTitle {
            color: rgb(0, 100, 62);
            font-weight: 500;
            display: block;
            font-size: 150%;
            margin-top:10px;
        }
    </style>

    <hamburger hamburger-text-key="''network_means_pageType_1''" ></hamburger>
    <message-banner></message-banner>
    <style>
        message-banner {
            display: block;
            width: 100%;
            position: relative;
        }
    </style>

    <div id="displayLayout" class="row">
        <div id="green-banner"></div>
    </div>
    <style>
        div#green-banner {
            height: 50px !important;
            background-color: #008991;
            border-bottom: 5px solid #DE1300;
            width: 100%;
        }
        @media screen and (max-width: 480px) {
            div#green-banner {
                display: none;
            }
        }
    </style>

    <div id="mainLayout" class="row">
        <div class="noLeftRightMargin">
            <div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <div class="noLeftRightPadding">
                    <side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
                </div>
            </div>

            <div id="centerPieceLayout" class=" col-xs-12 col-sm-8 col-md-8 col-lg-7">
                <div class="paragraph hideable-text">
                    <custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
                    </custom-text>
                </div>
                <div class="paragraph">
                    <custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3">
                    </custom-text>
                </div>
                <div class="text-center">
                    <otp-form ></otp-form>
                </div>
                <div class="text-center">
                    <val-button id="validateButton"></val-button>
                </div>
                <div class="paragraph">
                    <custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2">
                    </custom-text>
                </div>

            </div>
        </div>
    </div>
    <style>
        .noLeftRightMargin {
            margin-left: 0px;
            margin-right: 0px;
        }
        .noLeftRightPadding {
            padding-left: 0px;
            padding-right: 0px;
        }
        #centerPieceLayout {
            padding: 5px 10px 0px;
            min-height: 200px;
        }
        .paragraph {
            margin: 0px 0px 10px;
            text-align: justify;
        }
        .menu-title {
            color: rgb(0, 100, 62);
        }
        .menu-title span {
            display: block;
            font-size: 18px;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        #validateButton {
            background-color: rgb(255, 255, 255);
            color: rgb(51, 51, 51);
            white-space: normal;
            border-radius: 4px;
            border-color: rgb(204, 204, 204);
        }
        #validateButton button {
            margin-top: 5px;
        }
        button span.fa {
            padding-right: 7px;
        }
        @media screen and (max-width: 480px){
            div.hideable-text {
                display: none;
	        }
        }
    </style>
    <div id="bottomLayout" class="row">
        <div id="bottomMenu" >
            <cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
            <help help-label="''network_means_pageType_41''" id="helpButton" ></help>
        </div>
    </div>
    <style>
        #bottomMenu {
            background-color: rgb(0, 137, 145);
            border-top: 5px solid rgb(0, 100, 62);
            margin-top: 10px;
            text-align: center;
        }
        #cancelButton, #helpButton {
            color: rgb(51, 51, 51);
            white-space: normal;
            display: inline-block;
            border-width: 1px;
            border-style: solid;
            border-color: rgb(0, 166, 235);
            border-image: initial;
            margin: 10px;
        }
    </style>
</div>
', @lastCPLId);  

INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES
  (@lastCPLId, @ProfileSet);
/* ------------------------------- */  
/* ------------------------------- */  

INSERT INTO `CustomPageLayout` (`pageType`, `description`) VALUES  
  ('REFUSAL_PAGE', 'Refusal Page (Consorsbank)');
  
SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'REFUSAL_PAGE' and DESCRIPTION = 'Refusal Page (Consorsbank)') ;
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '
<div class="container-fluid">
    <div id="headerLayout" class="row">
        <div id="pageHeader" class="text-center col-xs-12">
            <div class="row">
                <div class=" col-xs-4 col-lg-3">
                    <custom-image id="issuerLogo"
                                  alt-key="''network_means_pageType_1_IMAGE_ALT''"
                                  image-key="''network_means_pageType_1_IMAGE_DATA''"
                                  straight-mode="false">
                    </custom-image>
                </div>
                <div class=" col-xs-4 col-lg-6">
                    <div id="centeredTitle">
                        <custom-text id="page-title" custom-text-key="''network_means_pageType_20''">
                        </custom-text>
                    </div>
                </div>
                <div class=" col-xs-4 col-lg-3">
                    <custom-image id="networkLogo"
                                  alt-key="''network_means_pageType_2_IMAGE_ALT''"
                                  image-key="''network_means_pageType_2_IMAGE_DATA''"
                                  straight-mode="false">
                    </custom-image>
                </div>
            </div>
        </div>
    </div>
    <style>
        #issuerLogo,
        #networkLogo {
            max-height: 75px;
            max-width: 100%;
            height: auto;
            padding: 0px;
        }
        #centeredTitle {
            color: rgb(0, 100, 62);
            font-weight: 500;
            display: block;
            font-size: 150%;
            margin-top:10px;
        }
    </style>

    <hamburger hamburger-text-key="''network_means_pageType_1''" ></hamburger>
    <message-banner></message-banner>
    <style>
        message-banner {
            display: block;
            width: 100%;
            position: relative;
        }
    </style>

    <div id="displayLayout" class="row">
        <div id="green-banner"></div>
    </div>
    <style>
        div#green-banner {
            height: 50px !important;
            background-color: #008991;
            border-bottom: 5px solid #DE1300;
            width: 100%;
        }
        @media screen and (max-width: 480px) {
            div#green-banner {
                display: none;
            }
        }
    </style>

    <div id="mainLayout" class="row">
        <div class="noLeftRightMargin">
            <div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <div class="noLeftRightPadding">
                    <side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
                </div>
            </div>

            <div id="centerPieceLayout" class=" col-xs-12 col-sm-8 col-md-8 col-lg-7">
                <div class="paragraph">
                    <custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
                    </custom-text>
                </div>
                <div class="paragraph">
                    <custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2">
                    </custom-text>
                </div>

            </div>
        </div>
    </div>
    <style>
        .noLeftRightMargin {
            margin-left: 0px;
            margin-right: 0px;
        }
        .noLeftRightPadding {
            padding-left: 0px;
            padding-right: 0px;
        }
        #centerPieceLayout {
            padding: 5px 10px 0px;
            min-height: 200px;
        }
        .paragraph {
            margin: 0px 0px 10px;
            text-align: justify;
        }
        .menu-title {
            color: rgb(0, 100, 62);
        }
        .menu-title span {
            display: block;
            font-size: 18px;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        #validateButton {
            background-color: rgb(255, 255, 255);
            color: rgb(51, 51, 51);
            white-space: normal;
            border-radius: 4px;
            border-color: rgb(204, 204, 204);
        }
        #validateButton button {
            margin-top: 5px;
        }
        button span.fa {
            padding-right: 7px;
        }
    </style>
    <div id="bottomLayout" class="row">
        <div id="bottomMenu" >
            <cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
            <help help-label="''network_means_pageType_41''" id="helpButton" ></help>
        </div>
    </div>
    <style>
        #bottomMenu {
            background-color: rgb(0, 137, 145);
            border-top: 5px solid rgb(0, 100, 62);
            margin-top: 10px;
            text-align: center;
        }
        #cancelButton, #helpButton {
            color: rgb(51, 51, 51);
            white-space: normal;
            display: inline-block;
            border-width: 1px;
            border-style: solid;
            border-color: rgb(0, 166, 235);
            border-image: initial;
            margin: 10px;
        }
    </style>
</div>
', @lastCPLId);  

INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES
  (@lastCPLId, @ProfileSet);
/* ------------------------------- */  
/* ------------------------------- */  
INSERT INTO `CustomPageLayout` (`pageType`, `description`) VALUES  
  ('FAILURE_PAGE', 'Failure Page (Consorsbank)');
  
SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'FAILURE_PAGE' and DESCRIPTION = 'Failure Page (Consorsbank)') ;
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '
<div class="container-fluid">
    <div id="headerLayout" class="row">
        <div id="pageHeader" class="text-center col-xs-12">
            <div class="row">
                <div class=" col-xs-4 col-lg-3">
                    <custom-image id="issuerLogo"
                                  alt-key="''network_means_pageType_1_IMAGE_ALT''"
                                  image-key="''network_means_pageType_1_IMAGE_DATA''"
                                  straight-mode="false">
                    </custom-image>
                </div>
                <div class=" col-xs-4 col-lg-6">
                    <div id="centeredTitle">
                        <custom-text id="page-title" custom-text-key="''network_means_pageType_20''">
                        </custom-text>
                    </div>
                </div>
                <div class=" col-xs-4 col-lg-3">
                    <custom-image id="networkLogo"
                                  alt-key="''network_means_pageType_2_IMAGE_ALT''"
                                  image-key="''network_means_pageType_2_IMAGE_DATA''"
                                  straight-mode="false">
                    </custom-image>
                </div>
            </div>
        </div>
    </div>
    <style>
        #issuerLogo,
        #networkLogo {
            max-height: 75px;
            max-width: 100%;
            height: auto;
            padding: 0px;
        }
        #centeredTitle {
            color: rgb(0, 100, 62);
            font-weight: 500;
            display: block;
            font-size: 150%;
            margin-top:10px;
        }
    </style>

    <hamburger hamburger-text-key="''network_means_pageType_1''" ></hamburger>
    <message-banner></message-banner>
    <style>
        message-banner {
            display: block;
            width: 100%;
            position: relative;
        }
    </style>

    <div id="displayLayout" class="row">
        <div id="green-banner"></div>
    </div>
    <style>
        div#green-banner {
            height: 50px !important;
            background-color: #008991;
            border-bottom: 5px solid #DE1300;
            width: 100%;
        }
        @media screen and (max-width: 480px) {
            div#green-banner {
                display: none;
            }
        }
    </style>

    <div id="mainLayout" class="row">
        <div class="noLeftRightMargin">
            <div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <div class="noLeftRightPadding">
                    <side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
                </div>
            </div>

            <div id="centerPieceLayout" class=" col-xs-12 col-sm-8 col-md-8 col-lg-7">
                <div class="paragraph">
                    <custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
                    </custom-text>
                </div>
                <div class="paragraph">
                    <custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2">
                    </custom-text>
                </div>
                <div class="paragraph">
                    <custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3">
                    </custom-text>
                </div>

            </div>
        </div>
    </div>
    <style>
        .noLeftRightMargin {
            margin-left: 0px;
            margin-right: 0px;
        }
        .noLeftRightPadding {
            padding-left: 0px;
            padding-right: 0px;
        }
        #centerPieceLayout {
            padding: 5px 10px 0px;
            min-height: 200px;
        }
        .paragraph {
            margin: 0px 0px 10px;
            text-align: justify;
        }
        .menu-title {
            color: rgb(0, 100, 62);
        }
        .menu-title span {
            display: block;
            font-size: 18px;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        #validateButton {
            background-color: rgb(255, 255, 255);
            color: rgb(51, 51, 51);
            white-space: normal;
            border-radius: 4px;
            border-color: rgb(204, 204, 204);
        }
        #validateButton button {
            margin-top: 5px;
        }
        button span.fa {
            padding-right: 7px;
        }
    </style>
    <div id="bottomLayout" class="row">
        <div id="bottomMenu" >
            <cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
            <help help-label="''network_means_pageType_41''" id="helpButton" ></help>
        </div>
    </div>
    <style>
        #bottomMenu {
            background-color: rgb(0, 137, 145);
            border-top: 5px solid rgb(0, 100, 62);
            margin-top: 10px;
            text-align: center;
        }
        #cancelButton, #helpButton {
            color: rgb(51, 51, 51);
            white-space: normal;
            display: inline-block;
            border-width: 1px;
            border-style: solid;
            border-color: rgb(0, 166, 235);
            border-image: initial;
            margin: 10px;
        }
    </style>
</div>
', @lastCPLId);  

INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`) VALUES
  (@lastCPLId, @ProfileSet);
/* ------------------------------- */  
/* ------------------------------- */  
INSERT INTO `CustomPageLayout` (`pageType`, `description`) VALUES  
  ('CHOICE_PAGE', 'Choice Page (Consorsbank)');
  

/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;

/*!40000 ALTER TABLE `CustomComponent` ENABLE KEYS */;


/* BinRange */
/* BinRange_SubIssuer */
SET @VISA = (SELECT id FROM `Network` WHERE `code` = 'VISA');
SET @code = '16900';
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_16900_01');

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`, `sharedBinRange`, `updateDSDate`, `upperBound`, `fk_id_network`, `fk_id_profileSet`, `toExport`) VALUES
  ('ACTIVATED', 'A169318', NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', b'0', NULL, '4159320000', 16, b'0', NULL, '4159329999', @VISA, @ProfileSet, b'0'),
  ('ACTIVATED', 'A169318', NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', b'0', NULL, '4163690000', 16, b'0', NULL, '4163699999', @VISA, @ProfileSet, b'0');

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`) VALUES
  ((SELECT id FROM BinRange WHERE lowerBound='4159320000' AND upperBound='4159329999' AND fk_id_profileSet=@ProfileSet), (SELECT id FROM SubIssuer WHERE code=@code)),
  ((SELECT id FROM BinRange WHERE lowerBound='4163690000' AND upperBound='4163699999' AND fk_id_profileSet=@ProfileSet), (SELECT id FROM SubIssuer WHERE code=@code));

/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.  */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`)
VALUES ('A169318', '2018-04-16 08:00:00', 'Consorsbank Logo', NULL, NULL, 'Consorsbank', 'PUSHED_TO_CONFIG', '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');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = '16900');
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`) VALUES
  ('A169318', NOW(), 'customitemset_16900_1_REFUSAL_Current', NULL, NULL, 'customitemset_16900_1_REFUSAL', 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID),
  ('A169318', NOW(), 'customitemset_16900_SMS_Current', NULL, NULL, 'customitemset_16900_SMS', 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID),
  ('A169318', NOW(), 'customitemset_16900_TOKENTAN_Current', NULL, NULL, 'customitemset_16900_TOKENTAN', 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID),
  ('A169318', NOW(), 'customitemset_16900_ACCEPT_MAINT_Current', NULL, NULL, 'customitemset_16900_ACCEPT_MAINT', 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* CustomItem */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;
SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_1_REFUSAL');
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_SMS');
SET @customItemSetTokenTan = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_TOKENTAN');
SET @customItemSetAcceptMaint = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_ACCEPT_MAINT');
SET @csbLogo = (SELECT id FROM `Image` WHERE `name` = 'Consorsbank');
SET @visaLogo = (SELECT id FROM `Image` WHERE `name` LIKE '%VISA_LOGO%');
SET @visaId = (SELECT id FROM `Network` WHERE `code` LIKE '%VISA%');


INSERT INTO `CustomItem` (`DTYPE`, `id`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `backgroundColor`, `borderStyle`, `textColor`, `fk_id_network`, `fk_id_image`, `fk_id_font`, `fk_id_customItemSet`) VALUES
	('I', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'VISA Logo', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL', 'VISA', NULL, NULL, NULL,@visaId, @visaLogo, NULL, @customItemSetSMS),
	('I', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', 'de', 1, 'ALL', 'Consorsbank', NULL, NULL, NULL, @visaId,  @csbLogo, NULL, @customItemSetSMS),
	('I', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'VISA Logo', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL', 'VISA', NULL, NULL, NULL,@visaId, @visaLogo, NULL, @customItemSetTokenTan),
	('I', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', 'de', 1, 'ALL', 'Consorsbank', NULL, NULL, NULL, @visaId,  @csbLogo, NULL, @customItemSetTokenTan),
	
	/* @customItemSetRefusal */
	/* REFUSAL_PAGE */
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_1_en', 'PUSHED_TO_CONFIG', 'de', 1, 'REFUSAL_PAGE', 'Aus Sicherheitsgründen wurde der Einkauf mit Verified by Visa abgelehnt.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_2_en', 'PUSHED_TO_CONFIG', 'de', 2, 'REFUSAL_PAGE', 'Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetRefusal),
	/*('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_14_en', 'PUSHED_TO_CONFIG', 'de', 14, 'REFUSAL_PAGE', 'Transaction cancelled', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_15_en', 'PUSHED_TO_CONFIG', 'de', 15, 'REFUSAL_PAGE', 'YYou have cancelled your transaction. You are going to be redirected to the merchant site', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetRefusal),*/
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_20_en', 'PUSHED_TO_CONFIG', 'de', 20, 'REFUSAL_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_40_en', 'PUSHED_TO_CONFIG', 'de', 40, 'REFUSAL_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_41_en', 'PUSHED_TO_CONFIG', 'de', 41, 'REFUSAL_PAGE', 'Hilfe', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_16_en', 'PUSHED_TO_CONFIG', 'de', 22, 'REFUSAL_PAGE', 'Ihre Anfrage wurde abgelehnt', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_23', 'PUSHED_TO_CONFIG', 'de', 23, 'REFUSAL_PAGE', 'Ihre Zahlung mit Verified by Visa wurde abgelehnt!', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetRefusal),	
	('I', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', 'de', 2, 'REFUSAL_PAGE', 'Verified by Visa™', NULL, NULL, NULL, @visaId, @visaLogo, NULL, @customItemSetRefusal),
	('I', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'Bank  Logo', 'PUSHED_TO_CONFIG', 'de', 1, 'REFUSAL_PAGE', 'Consorsbank', NULL, NULL, NULL, @visaId, @csbLogo, NULL, @customItemSetRefusal),
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	
	/* @customItemSetSMS */
	/* MESSAGE_BODY */
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'de', 0, 'MESSAGE_BODY', 'Um Ihren Kauf von Betrag @amount auf der Webseite @merchant zu authentifizieren, geben Sie bitte den Code ein @otp', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),	
	/* FAILURE_PAGE */
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_1_en', 'PUSHED_TO_CONFIG', 'de', 1, 'FAILURE_PAGE', 'Beachten Sie, dass aus Sicherheitsgründen nach dreimaliger falscher Eingabe der mobilen TAN Ihr TAN-Verfahren gesperrt wird.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_2_en', 'PUSHED_TO_CONFIG', 'de', 2, 'FAILURE_PAGE', 'Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_3_en', 'PUSHED_TO_CONFIG', 'de', 3, 'FAILURE_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_14_en', 'PUSHED_TO_CONFIG', 'de', 14, 'FAILURE_PAGE', 'Ihre Transaktion wurde abgebrochen', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_15_en', 'PUSHED_TO_CONFIG', 'de', 15, 'FAILURE_PAGE', 'Sie haben den Bezahlvorgang abgebrochen. Falls Sie den Artikel dennoch kaufen wollen, starten Sie den Bezahlvorgang bitte erneut.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_20_en', 'PUSHED_TO_CONFIG', 'de', 20, 'FAILURE_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_40_en', 'PUSHED_TO_CONFIG', 'de', 40, 'FAILURE_PAGE', 'Abbrechen', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_41_en', 'PUSHED_TO_CONFIG', 'de', 41, 'FAILURE_PAGE', 'Hilfe', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_13', 'PUSHED_TO_CONFIG', 'de', 20, 'FAILURE_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	/*('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_17', 'PUSHED_TO_CONFIG', 'de', 17, 'FAILURE_PAGE', 'Your submitted code is incorrect. Maximum number of attempts is reached.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_16', 'PUSHED_TO_CONFIG', 'de', 16, 'FAILURE_PAGE', 'Authentication failure.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),*/
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_32_en', 'PUSHED_TO_CONFIG', 'de', 16, 'FAILURE_PAGE', 'Ihr TAN-Verfahren wurde gesperrt', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_OTP_SMS_FAILURE_PAGE_33_en', 'PUSHED_TO_CONFIG', 'de', 17, 'FAILURE_PAGE', 'Die TAN-Prüfung ist fehlgeschlagen. Sperrung aufgrund dreimaliger falscher TAN-Eingabe.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	/* HELP_PAGE */	
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_HELP_PAGE_1_en', 'PUSHED_TO_CONFIG', 'de', 1, 'HELP_PAGE', '<b>Informationen über Verified by VISA</b></br>Verified by VISA ist ein Service von VISA und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz von der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_HELP_PAGE_2_en', 'PUSHED_TO_CONFIG', 'de', 2, 'HELP_PAGE', '<b>Registrierung für Verified by VISA</b></br>Eine separate Registrierung bei VISA ist nicht erforderlich. Sie werden als Inhaber der Consorsbank girocard sowie der VISA Card  automatisch für den Verified by VISA Service  angemeldet.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_HELP_PAGE_3_en', 'PUSHED_TO_CONFIG', 'de', 3, 'HELP_PAGE', '<b>Deaktivierung des Verified by VISA Service</b></br>Solange Sie ein Girokonto und eine VISA Card bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Verified by VISA nicht möglich.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_HELP_PAGE_4_en', 'PUSHED_TO_CONFIG', 'de', 4, 'HELP_PAGE', '<b>Höhere Sicherheit durch Verified by VISA</b></br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Verified by VISA Eingabefenster. Verified by VISA erkennt automatisch das von Ihnen genutzte TAN-Verfahren (mobile TAN oder TAN-Generator). Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.</br></br><b>Falscheingabe der Verified by VISA TAN</b></br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre VISA Card behält während der Sperre des TAN-Service weiterhin Ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	/* OTP_FORM_PAGE */
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_1_en', 'PUSHED_TO_CONFIG', 'de', 1, 'OTP_FORM_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_2_en', 'PUSHED_TO_CONFIG', 'de', 2, 'OTP_FORM_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_14_en', 'PUSHED_TO_CONFIG', 'de', 14, 'OTP_FORM_PAGE', 'Ihre Transaktion wurde abgebrochen', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_15_en', 'PUSHED_TO_CONFIG', 'de', 15, 'OTP_FORM_PAGE', 'Sie haben den Bezahlvorgang abgebrochen. Falls Sie den Artikel dennoch kaufen wollen, starten Sie den Bezahlvorgang bitte erneut.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_20_en', 'PUSHED_TO_CONFIG', 'de', 20, 'OTP_FORM_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_40_en', 'PUSHED_TO_CONFIG', 'de', 40, 'OTP_FORM_PAGE', 'Abbrechen', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_41_en', 'PUSHED_TO_CONFIG', 'de', 41, 'OTP_FORM_PAGE', 'Hilfe', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_15_en', 'PUSHED_TO_CONFIG', 'de', 3, 'OTP_FORM_PAGE', 'Ihre mobile TAN', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_24_en', 'PUSHED_TO_CONFIG', 'de', 12, 'OTP_FORM_PAGE', 'Ihre Authentifizierung läuft', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_25_en', 'PUSHED_TO_CONFIG', 'de', 13, 'OTP_FORM_PAGE', 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_26_en', 'PUSHED_TO_CONFIG', 'de', 26, 'OTP_FORM_PAGE', 'Ihre Authentifizierung erfolgreich', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_27_en', 'PUSHED_TO_CONFIG', 'de', 27, 'OTP_FORM_PAGE', 'Sie wurden erfolgreich authentifiziert und werden automatisch zur Händler-Website weitergeleitet.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_28_en', 'PUSHED_TO_CONFIG', 'de', 28, 'OTP_FORM_PAGE', 'Ungültige TAN', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_29_en', 'PUSHED_TO_CONFIG', 'de', 29, 'OTP_FORM_PAGE', 'Beachten Sie, dass aus Sicherheitsgründen nach dreimaliger falscher Eingabe der mobilen TAN Ihr TAN-Verfahren gesperrt wird.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_30_en', 'PUSHED_TO_CONFIG', 'de', 30, 'OTP_FORM_PAGE', 'Ihre Session ist abgelaufen', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_31_en', 'PUSHED_TO_CONFIG', 'de', 31, 'OTP_FORM_PAGE', 'Aus Sicherheitsgründen wurde die Transaktion aufgrund Überschreitung des Zeitlimits abgebrochen. Bitte versuchen Sie es erneut.</br>Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_32_en', 'PUSHED_TO_CONFIG', 'de', 32, 'OTP_FORM_PAGE', 'Technischer Fehler', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_33_en', 'PUSHED_TO_CONFIG', 'de', 33, 'OTP_FORM_PAGE', 'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.</br>Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	/* REFUSAL_PAGE */
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_1_en', 'PUSHED_TO_CONFIG', 'de', 1, 'REFUSAL_PAGE', 'Aus Sicherheitsgründen wurde der Einkauf mit Verified by Visa abgelehnt.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_2_en', 'PUSHED_TO_CONFIG', 'de', 2, 'REFUSAL_PAGE', 'Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	/*('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_14_en', 'PUSHED_TO_CONFIG', 'de', 14, 'REFUSAL_PAGE', 'Transaction cancelled', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_15_en', 'PUSHED_TO_CONFIG', 'de', 15, 'REFUSAL_PAGE', 'You have cancelled your transaction. You are going to be redirected to the merchant site', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),*/
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_20_en', 'PUSHED_TO_CONFIG', 'de', 20, 'REFUSAL_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_40_en', 'PUSHED_TO_CONFIG', 'de', 40, 'REFUSAL_PAGE', 'Abbrechen', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_41_en', 'PUSHED_TO_CONFIG', 'de', 41, 'REFUSAL_PAGE', 'Hilfe', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetSMS),
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	
	/* @customItemSetTokenTan */
	/* MESSAGE_BODY */
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'de', 0, 'MESSAGE_BODY', 'Um Ihren Kauf von Betrag @amount auf der Webseite @merchant zu authentifizieren, geben Sie bitte den Code ein @otp', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),	
	/* FAILURE_PAGE */
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_1_en', 'PUSHED_TO_CONFIG', 'de', 1, 'FAILURE_PAGE', 'Beachten Sie, dass aus Sicherheitsgründen nach dreimaliger falscher Eingabe der mobilen TAN Ihr TAN-Verfahren gesperrt wird.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_2_en', 'PUSHED_TO_CONFIG', 'de', 2, 'FAILURE_PAGE', 'Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_3_en', 'PUSHED_TO_CONFIG', 'de', 3, 'FAILURE_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_14_en', 'PUSHED_TO_CONFIG', 'de', 14, 'FAILURE_PAGE', 'Ihre Transaktion wurde abgebrochen', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_15_en', 'PUSHED_TO_CONFIG', 'de', 15, 'FAILURE_PAGE', 'Sie haben den Bezahlvorgang abgebrochen. Falls Sie den Artikel dennoch kaufen wollen, starten Sie den Bezahlvorgang bitte erneut.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_20_en', 'PUSHED_TO_CONFIG', 'de', 20, 'FAILURE_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_40_en', 'PUSHED_TO_CONFIG', 'de', 40, 'FAILURE_PAGE', 'Abbrechen', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_41_en', 'PUSHED_TO_CONFIG', 'de', 41, 'FAILURE_PAGE', 'Hilfe', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_13', 'PUSHED_TO_CONFIG', 'de', 20, 'FAILURE_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	/*('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_17', 'PUSHED_TO_CONFIG', 'de', 17, 'FAILURE_PAGE', 'Your submitted code is incorrect. Maximum number of attempts is reached.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_16', 'PUSHED_TO_CONFIG', 'de', 16, 'FAILURE_PAGE', 'Authentication failure.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),*/
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_FAILURE_PAGE_32_en', 'PUSHED_TO_CONFIG', 'de', 16, 'FAILURE_PAGE', 'Ihr TAN-Verfahren wurde gesperrt', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_OTP_SMS_FAILURE_PAGE_33_en', 'PUSHED_TO_CONFIG', 'de', 17, 'FAILURE_PAGE', 'Die TAN-Prüfung ist fehlgeschlagen. Sperrung aufgrund dreimaliger falscher TAN-Eingabe.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	/* HELP_PAGE */	
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_HELP_PAGE_1_en', 'PUSHED_TO_CONFIG', 'de', 1, 'HELP_PAGE', '<b>Informationen über Verified by VISA</b></br>Verified by VISA ist ein Service von VISA und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz von der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_HELP_PAGE_2_en', 'PUSHED_TO_CONFIG', 'de', 2, 'HELP_PAGE', '<b>Registrierung für Verified by VISA</b></br>Eine separate Registrierung bei VISA ist nicht erforderlich. Sie werden als Inhaber der Consorsbank girocard sowie der VISA Card  automatisch für den Verified by VISA Service  angemeldet.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_HELP_PAGE_3_en', 'PUSHED_TO_CONFIG', 'de', 3, 'HELP_PAGE', '<b>Deaktivierung des Verified by VISA Service</b></br>Solange Sie ein Girokonto und eine VISA Card bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Verified by VISA nicht möglich.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_HELP_PAGE_4_en', 'PUSHED_TO_CONFIG', 'de', 4, 'HELP_PAGE', '<b>Höhere Sicherheit durch Verified by VISA</b></br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Verified by VISA Eingabefenster. Verified by VISA erkennt automatisch das von Ihnen genutzte TAN-Verfahren (mobile TAN oder TAN-Generator). Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.</br></br><b>Falscheingabe der Verified by VISA TAN</b></br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre VISA Card behält während der Sperre des TAN-Service weiterhin Ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	/* OTP_FORM_PAGE */
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_1_en', 'PUSHED_TO_CONFIG', 'de', 1, 'OTP_FORM_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_2_en', 'PUSHED_TO_CONFIG', 'de', 2, 'OTP_FORM_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_14_en', 'PUSHED_TO_CONFIG', 'de', 14, 'OTP_FORM_PAGE', 'Ihre Transaktion wurde abgebrochen', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_15_en', 'PUSHED_TO_CONFIG', 'de', 15, 'OTP_FORM_PAGE', 'Sie haben den Bezahlvorgang abgebrochen. Falls Sie den Artikel dennoch kaufen wollen, starten Sie den Bezahlvorgang bitte erneut.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_20_en', 'PUSHED_TO_CONFIG', 'de', 20, 'OTP_FORM_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_40_en', 'PUSHED_TO_CONFIG', 'de', 40, 'OTP_FORM_PAGE', 'Abbrechen', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_41_en', 'PUSHED_TO_CONFIG', 'de', 41, 'OTP_FORM_PAGE', 'Hilfe', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_15_en', 'PUSHED_TO_CONFIG', 'de', 3, 'OTP_FORM_PAGE', 'Ihre mobile TAN', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_24_en', 'PUSHED_TO_CONFIG', 'de', 12, 'OTP_FORM_PAGE', 'Ihre Authentifizierung läuft', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_25_en', 'PUSHED_TO_CONFIG', 'de', 13, 'OTP_FORM_PAGE', 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_26_en', 'PUSHED_TO_CONFIG', 'de', 26, 'OTP_FORM_PAGE', 'Ihre Authentifizierung erfolgreich', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_27_en', 'PUSHED_TO_CONFIG', 'de', 27, 'OTP_FORM_PAGE', 'Sie wurden erfolgreich authentifiziert und werden automatisch zur Händler-Website weitergeleitet.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_28_en', 'PUSHED_TO_CONFIG', 'de', 28, 'OTP_FORM_PAGE', 'Ungültige mTAN', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_29_en', 'PUSHED_TO_CONFIG', 'de', 29, 'OTP_FORM_PAGE', 'Die mTAN-Prüfung ist fehlgeschlagen. Bitte fordern Sie eine neue mTAN an. Nach 3x falscher mTAN Eingabe erfolgt eine Sperrung Ihres TAN-Verfahren.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_30_en', 'PUSHED_TO_CONFIG', 'de', 30, 'OTP_FORM_PAGE', 'Ihre Session ist abgelaufen', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_31_en', 'PUSHED_TO_CONFIG', 'de', 31, 'OTP_FORM_PAGE', 'Aus Sicherheitsgründen wurde die Transaktion aufgrund Überschreitung des Zeitlimits abgebrochen. Bitte versuchen Sie es erneut.</br>Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_32_en', 'PUSHED_TO_CONFIG', 'de', 32, 'OTP_FORM_PAGE', 'Technischer Fehler', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_OTP_FORM_PAGE_33_en', 'PUSHED_TO_CONFIG', 'de', 33, 'OTP_FORM_PAGE', 'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.</br>Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	/* REFUSAL_PAGE */
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_1_en', 'PUSHED_TO_CONFIG', 'de', 1, 'REFUSAL_PAGE', 'Aus Sicherheitsgründen wurde der Einkauf mit Verified by Visa abgelehnt.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_2_en', 'PUSHED_TO_CONFIG', 'de', 2, 'REFUSAL_PAGE', 'Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	/*('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_14_en', 'PUSHED_TO_CONFIG', 'de', 14, 'REFUSAL_PAGE', 'Transaction cancelled', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_15_en', 'PUSHED_TO_CONFIG', 'de', 15, 'REFUSAL_PAGE', 'You have cancelled your transaction. You are going to be redirected to the merchant site', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),*/
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_20_en', 'PUSHED_TO_CONFIG', 'de', 20, 'REFUSAL_PAGE', '', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_40_en', 'PUSHED_TO_CONFIG', 'de', 40, 'REFUSAL_PAGE', 'Abbrechen', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'REFUSAL_REFUSAL_PAGE_41_en', 'PUSHED_TO_CONFIG', 'de', 41, 'REFUSAL_PAGE', 'Hilfe', NULL, NULL, NULL, @visaId, NULL, NULL, @customItemSetTokenTan);
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/	
	/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;

/* Profiles */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = '16900');
SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_1_REFUSAL');
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_SMS');
SET @customItemSetTOKENTAN = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_TOKENTAN');
SET @customItemSetACCEPT_MAINT = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_ACCEPT_MAINT');
SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
SET @authMeanTokenTan = (SELECT id FROM `AuthentMeans` WHERE `name` = 'TOKEN');
SET @authMeanAcceptMaint = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ATTEMPT');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  ('A169318', NOW(), 'Authentication refused', NULL, NULL, '16900_REFUSAL_01', 'PUSHED_TO_CONFIG', -1, @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID),
  ('A169318', NOW(), 'Authentication by OTP SMS', NULL, NULL, '16900_SMS_01', 'PUSHED_TO_CONFIG', 3, @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID),
  ('A169318', NOW(), 'Authentication by Token Tan', NULL, NULL, '16900_TOKEN_01', 'PUSHED_TO_CONFIG', 3, @authMeanTokenTan, @customItemSetTOKENTAN, NULL, NULL, @subIssuerID),
  ('A169318', NOW(), 'Automatic Authentication', NULL, NULL, '16900_ACCEPT_01', 'PUSHED_TO_CONFIG', 0, @authMeanAcceptMaint, @customItemSetACCEPT_MAINT, NULL, NULL, @subIssuerID);

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = '16900_REFUSAL_01');
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = '16900_SMS_01');
SET @profileToken = (SELECT id FROM `Profile` WHERE `name` = '16900_TOKEN_01');
SET @profileAccept = (SELECT id FROM `Profile` WHERE `name` = '16900_ACCEPT_01');
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  ('A169318', NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', 'PUSHED_TO_CONFIG', 1, @profileRefusal),
  ('A169318', NOW(), 'TOKEN_AVAILABLE', NULL, NULL, 'TOKEN (NORMAL)', 'PUSHED_TO_CONFIG', 2, @profileToken),
  ('A169318', NOW(), 'SMS_AVAILABLE_NORMAL', NULL, NULL, 'SMS (NORMAL)', 'PUSHED_TO_CONFIG', 3, @profileSMS),
  ('A169318', NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 5, @profileRefusal),
  ('A169318', NOW(), 'ACCEPT_MAINTENANCE', NULL, NULL, 'ACCEPT (MAINT)', 'PUSHED_TO_CONFIG', 6, @profileAccept);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);
SET @ruleToken = (SELECT id FROM `Rule` WHERE `description`='TOKEN_AVAILABLE' AND `fk_id_profile`=@profileToken);
SET @ruleAccept = (SELECT id FROM `Rule` WHERE `description`='ACCEPT_MAINTENANCE' AND `fk_id_profile`=@profileAccept);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('A169318', NOW(), NULL, NULL, NULL, 'C1_P_16900_01_FRAUD', 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  ('A169318', NOW(), NULL, NULL, NULL, 'C2_P_16900_01_FRAUD', 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  ('A169318', NOW(), NULL, NULL, NULL, 'C1_P_16900_01_TOKEN_TAN', 'PUSHED_TO_CONFIG', @ruleToken),
  ('A169318', NOW(), NULL, NULL, NULL, 'C2_P_16900_01_TOKEN_TAN', 'PUSHED_TO_CONFIG', @ruleToken),
  ('A169318', NOW(), NULL, NULL, NULL, 'C1_P_16900_01_OTP_SMS', 'PUSHED_TO_CONFIG', @ruleSMSnormal),
  ('A169318', NOW(), NULL, NULL, NULL, 'C2_P_16900_01_OTP_SMS', 'PUSHED_TO_CONFIG', @ruleSMSnormal),
  ('A169318', NOW(), NULL, NULL, NULL, 'C1_P_16900_01_ACCEPT', 'PUSHED_TO_CONFIG', @ruleAccept),
  ('A169318', NOW(), NULL, NULL, NULL, 'C2_P_16900_01_ACCEPT', 'PUSHED_TO_CONFIG', @ruleAccept),
  ('A169318', NOW(), NULL, NULL, NULL, 'C3_P_16900_01_ACCEPT', 'PUSHED_TO_CONFIG', @ruleAccept),		
  ('A169318', NOW(), NULL, NULL, NULL, 'C1_P_16900_01_DEFAULT', 'PUSHED_TO_CONFIG', @ruleRefusalDefault);
/*!40000 ALTER TABLE `RuleCondition` ENABLE KEYS */;

/* **** Condition_TransactionStatuses  **** */

/* Fraud */
/*!40000 ALTER TABLE `Condition_TransactionStatuses` DISABLE KEYS */;
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_P_16900_01_FRAUD' AND (ts.`transactionStatusType`='PAYMENT_MEANS_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C2_P_16900_01_FRAUD' AND (ts.`transactionStatusType`='CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C3_P_16900_01_FRAUD' AND (ts.`transactionStatusType`='CARD_HOLDER_COUNTRY_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C4_P_16900_01_FRAUD' AND (ts.`transactionStatusType`='MERCHANT_URL_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);
  
/* DEFAULT */
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_P_16900_01_DEFAULT' AND (ts.`transactionStatusType`='DEFAULT' AND ts.`reversed`=FALSE);


/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;

/* **** Condition_MeansProcessStatuses **** */

/* SMS (NORMAL) */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_P_16900_01_OTP_SMS_NORMAL'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C2_P_16900_01_OTP_SMS_NORMAL'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);
	
	/* TAN TOKEN (NORMAL) */

SET @authMeanOTPtoken = (SELECT id FROM `AuthentMeans` WHERE `name` = 'TOKEN');
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_P_16900_01_TOKEN_TAN'
    AND mps.`fk_id_authentMean`=@authMeanOTPtoken
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_P_16900_01_TOKEN_TAN'
    AND mps.`fk_id_authentMean`=@authMeanOTPtoken AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);
	
	/* ACCEPT (MAINT) */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;
SET @authMeanOTPattempt = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ATTEMPT');

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_P_16900_01_ACCEPT'
    AND mps.`fk_id_authentMean`=@authMeanOTPattempt
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=FALSE);
	
	INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C2_P_16900_01_ACCEPT'
    AND mps.`fk_id_authentMean`=@authMeanOTtoken
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_P_16900_01_TOKEN_TAN'
    AND mps.`fk_id_authentMean`=@authMeanOTPattempt AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);	


/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = '16900_REFUSAL_01');
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = '16900_SMS_01');
SET @profileToken = (SELECT id FROM `Profile` WHERE `name` = '16900_TOKEN_01');
SET @profileAccept = (SELECT id FROM `Profile` WHERE `name` = '16900_ACCEPT_01');

SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleToken = (SELECT id FROM `Rule` WHERE `description`='TOKEN_AVAILABLE' AND `fk_id_profile`=@profileToken);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);
SET @ruleAccept = (SELECT id FROM `Rule` WHERE `description`='ACCEPT_MAINTENANCE' AND `fk_id_profile`=@profileAccept);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = 'PS_16900_01' AND r.`id` IN (@ruleRefusalFraud, @ruleSMSnormal, @ruleRefusalDefault, @ruleToken, @ruleAccept);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '16900');
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES
  ('ISSUER', 'TestMerchant', 'NAME', 0, 0, @issuerId, NULL);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;


  /* Not yet specified for CBC */
 /*
INSERT INTO `SpecificReports_Issuer`(id_specificReport, id_issuer) VALUES
  ((SELECT id from SpecificReports WHERE name = 'SMS_NOTIFICATIONS'),(SELECT id FROM Issuer where code = '16900')),
  ((SELECT id from SpecificReports WHERE name = 'REFUSALCAUSES_PA_BY_PROFILEMEANS'),(SELECT id FROM Issuer where code = '16900')),
  ((SELECT id from SpecificReports WHERE name = 'STATUS_PA_BY_PROFILEMEANS'),(SELECT id FROM Issuer where code = '16900'));
  */

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
