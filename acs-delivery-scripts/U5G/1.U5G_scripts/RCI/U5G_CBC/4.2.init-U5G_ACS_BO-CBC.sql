/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

/* Issuer */
/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
INSERT INTO `Issuer` (`code`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                      `updateState`, `label`, `authentMeans`, `availaibleAuthentMeans`) VALUES
  ('00070', 'A169318', NOW(), NULL, NULL, NULL, 'China Bank Corporation', 'PUSHED_TO_CONFIG', 'China Bank Corporation',
      '[{"authentMeans":"OTP_SMS", "validate":true}, {"authentMeans":"REFUSAL", "validate":true}]',
   'OTP_SMS|REFUSAL');
/*!40000 ALTER TABLE `Issuer` ENABLE KEYS */;

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00070');
INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `otpExcluded`, `otpAllowed`, `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `fk_id_issuer`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`) VALUES
  ('ACS_U5G', 300, '', '00070', '00070', 'EUR', 'A169318', NOW(), NULL, NULL, NULL, 'China Bank Corporation', 'PUSHED_TO_CONFIG', 'en', 600, 'China Bank Corporation', b'1', b'1', '^[^OIi]*$', '6:(:DIGIT:1)', NULL, b'1', b'1', 300, @issuerId, 'https://ssl-qlf-u9f-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest', 'https://ssl-qlf-u9f-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest', 'https://ssl-qlf-u9f-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest', 'https://ssl-qlf-u9f-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest', b'0', b'1', b'1', b'1', 'OTP_SMS', '250', 'VE_AND_PA_MODE');
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;

/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00070');
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
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00070');
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
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00070');
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
    NULL, 'MASTERCARD_SPA', '241122334455554341465F4D5554555F414300', 'STRING_TIMESTAMP', 'ED11223344554B544F525F4D5554555F414310',
    'MIIDzzCCAregAwIBAgIRAO6hkq6XAdKvA5IMAj3E95MwDQYJKoZIhvcNAQEFBQAwgYAxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEiMCAGA1UEAxMZUFJEIE1DIFNlY3VyZUNvZGUgUm9vdCBDQTAeFw0xMjA2MjIwOTA4MzBaFw0yNTA2MjIwOTA4MzFaMIGAMQswCQYDVQQGEwJVUzEdMBsGA1UEChMUTWFzdGVyQ2FyZCBXb3JsZHdpZGUxLjAsBgNVBAsTJU1hc3RlckNhcmQgV29ybGR3aWRlIFNlY3VyZUNvZGUgR2VuIDIxIjAgBgNVBAMTGVBSRCBNQyBTZWN1cmVDb2RlIFJvb3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDptCms6aI22T9ST60k487SZP06TKbUBpom7Z1Bo8cQQAE/tM5UOt3THMdrhT+2aIkj9T0pA35IyNMCNGDt+ejhy7tHdw1r6eDX/KXYHb4FlemY03DwRrkQSH/L+ZueS5dCfLM3m2azxBXtrVXDdNebfht8tcWRLK2Ou6vjDzdIzunuWRZ6kRDQ6oc1LSVO2BxiFO0TKowJP/M7qWRT/Jsmb6TGg0vmmQG9QEpmVmOZIexVxuYy3rn7gEbV1tv3k4aG0USMp2Xq/Xe4qe+Ir7sFqR56G4yKezSVLUzQaIB/deeCk9WU2T0XmicAEYDBQoecoS61R4nj5ODmzwmGyxrlAgMBAAGjQjBAMA8GA1UdEwQIMAYBAf8CAQEwDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQqFTcxVDO/uxI1hpFF3VSSTFMGujANBgkqhkiG9w0BAQUFAAOCAQEAhDOQ5zUX2wByVv0Cqka3ebnm/6xRzQQbWelzneDUNVdctn1nhJt2PK1uGV7RBGAGukgdAubwwnBhD2FdbhBHTVbpLPYxBbdMAyeC8ezaXGirXOAAv0YbGhPl1MUFiDmqSliavBFUs4cEuBIas4BUoZ5Fz042dDSAWffbdf3l4zrU5Lzol93yXxxIjqgIsT3QI+sRM3gg/Gdwo80DUQ2fRffsGdAUH2C/8L8/wH+E9HspjMDkXlZohPII0xtKhdIPWzbOB6DOULl2PkdGHmJc4VXxfOwE2NJAQxmoaPRDYGgOFVvkzYtyxVkxXeXAPNt8URR3jfWvYrBGH2D5A44Atg==',
    NULL, 'MIIEgDCCA2igAwIBAgIRANPdOMI3PRuQ2QrYW3TiHIAwDQYJKoZIhvcNAQEFBQAwgYYxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEoMCYGA1UEAxMfUFJEIE1DIFNlY3VyZUNvZGUgSXNzdWVyIFN1YiBDQTAeFw0xNzA3MjgxMTMyNTBaFw0yMTA3MjcxMTI5NDRaMHkxCzAJBgNVBAYTAkZSMR0wGwYDVQQKExRDUkVESVQgQUdSSUNPTEUgUy5BLjEnMCUGA1UECxMeQVRPUyBXb3JsZExpbmUgV0xQIC0gSUNBIDEyNjUzMSIwIAYDVQQDExlXTFAtQUNTIENBU0EgU2lnbmF0dXJlIE1DMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuO0yGOwsu/icuH+OPbAaSWWTUL+oePoapJ6bNZd41g8dG9fKOgRzHW+dMIrkKeXKHHQvrvU6JNJoPFWAGxeOa4D0vsp1AZKOWiWlsss6kLn0fDj7nwDErCHJNJWi3TmmSL8s8ujOrRsveZhoDtLDp1E/Q+PoG3uoI4PcH3DqlF/8IfY/0z9F9avb+uCFvOXoh6dV5LRe2mYY62KiJHvdaAPlGwPnFPgLtJafgv9RVVGyxXhxZSM1R6hX2pP28219BlDQEbQtkqHJI/3/NW5x9HjddXpbtqKt29NXfmTJym6pfZrWTXn2qXuXokPcR5TE3EWz3zGsNSkltOc0ADANsQIDAQABo4H0MIHxMCsGA1UdEAQkMCKADzIwMTcwNzI4MTEzMjUwWoEPMjAyMDA3MjcxMTMyNTBaMA4GA1UdDwEB/wQEAwIHgDAJBgNVHRMEAjAAMIGmBgNVHSMEgZ4wgZuhgYakgYMwgYAxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEiMCAGA1UEAxMZUFJEIE1DIFNlY3VyZUNvZGUgUm9vdCBDQYIQQ3EBfDozHhKp3pmzcHr6ZzANBgkqhkiG9w0BAQUFAAOCAQEAb72VYXYGFGeuoxjrq2vDduEp6gHii2SwWaf3D/wuybihroryJVMW9AX3SG8IVHEINqtqg/dTgo8TfJnJ0QEiGN0TlmFHzSptil6lBAlSnHjrEsIBG52bLKtGwCrE7Hzfx8fqW5XmlyrDJK7MaaIrFe5GPMXBLL7+nazbpemy06+9RvyDLisgxx8DPRkdZdfoQfKTH5sWUtr2VMA5NtMQAtHjMhQOFuOpfbwNz4iC/jHDM6/Zs4D4zcVFKQwS4ngtf5q4dwOdQ6nYdpreWcgbmzuH7PIRQWsO4sWpzWlwknWKeU/r2iOaRndxAmxmR3oJVFYHqD/6fy0NDoBwIrdrjA==',
    NULL, n.id, si.id
    FROM Network n, SubIssuer si
    WHERE n.code='MASTERCARD'  AND si.fk_id_issuer = @issuerId;
/*!40000 ALTER TABLE `SubIssuerNetworkCrypto` ENABLE KEYS */;

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00070');
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT 'A169318', NOW(), 'China Bank Coroporation profile set', NULL, NULL, CONCAT('PS_', si.code, '_01'), 'PUSHED_TO_CONFIG', si.id
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


SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_00070_01');

/* ------------------------------- */
/*!40000 ALTER TABLE `CustomPageLayout` DISABLE KEYS */;

/*!40000 ALTER TABLE `CustomComponent` DISABLE KEYS */;

INSERT INTO `CustomPageLayout` (`pageType`, `description`) VALUES
  ('MESSAGE_BANNER', 'Message Banner (CBC)');

SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MESSAGE_BANNER' and DESCRIPTION = 'Message Banner (CBC)') ;
  
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
  ('HELP_PAGE', 'Help Page (CBC)');
  
SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'HELP_PAGE' and DESCRIPTION = 'Help Page (CBC)') ;
  
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
  ('HAMBURGER_MENU', 'Hamburger Menu (CBC)');

SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'HAMBURGER_MENU' and DESCRIPTION = 'Hamburger Menu (CBC)') ;
  
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
  ('OTP_FORM_PAGE', 'OTP Form Page (CBC)');
  
SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_FORM_PAGE' and DESCRIPTION = 'OTP Form Page (CBC)') ;
  
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
  ('REFUSAL_PAGE', 'Refusal Page (CBC)');
  
SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'REFUSAL_PAGE' and DESCRIPTION = 'Refusal Page (CBC)') ;
  
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
  ('FAILURE_PAGE', 'Failure Page (CBC)');
  
SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'FAILURE_PAGE' and DESCRIPTION = 'Failure Page (CBC)') ;
  
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
  ('CHOICE_PAGE', 'Choice Page (CBC)');
  
SET @lastCPLId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'CHOICE_PAGE' and DESCRIPTION = 'Choice Page (CBC)') ;
  
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
                <div class="paragraph hideable-text">
                    <custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
                    </custom-text>
                </div>
                <div class="paragraph">
                    <custom-text custom-text-key="''means_SELECT_INSTRUCTION''">
                    </custom-text>
                </div>
                <div class="text-center">
                    <device-select devices="deviceSelectValues"></device-select>
                </div>
                <div class="comboButtons">
                    <div class="comboButtonsAligned">
                        <val-button class="comboButton"></val-button>
                        <switch-means-button class="comboButton"></switch-means-button>
                    </div>
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

        .comboButtonsAligned {
            margin: 5px;
            text-align: center;
        }
        .comboButtons > div > .comboButton:first-child:not(:last-child) > .btn {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
            margin-left: 0px;
        }
        .comboButtons > div > .comboButton:not(:first-child):not(:last-child) > .btn {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
            margin-left: -1px;
        }
        .comboButtons > div > .comboButton:last-child:not(:first-child) > .btn {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
            margin-left: 0px;
        }
        .comboButtons > div > .btn.comboButton:first-child:not(:last-child)  {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
            margin-left: 0px;
        }
        .comboButtons > div > .btn.comboButton:not(:first-child):not(:last-child) {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
            margin-left: -1px;
        }
        .comboButtons > div > .btn.comboButton:last-child:not(:first-child) {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
            margin-left: 0px;
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
/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;

/*!40000 ALTER TABLE `CustomComponent` ENABLE KEYS */;


/* BinRange */
/* BinRange_SubIssuer */
SET @MASTERCARD = (SELECT id FROM `Network` WHERE `code` = 'MASTERCARD');
SET @code = '00070';
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_00070_01');

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`, `sharedBinRange`, `updateDSDate`, `upperBound`, `fk_id_network`, `fk_id_profileSet`, `toExport`, `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', 'A169318', NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', b'0', NULL, '5226440000', 16, b'0', NULL, '5226449999', @MASTERCARD, @ProfileSet, b'0', null),
  ('ACTIVATED', 'A169318', NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', b'0', NULL, '5226040000', 16, b'0', NULL, '5226049999', @MASTERCARD, @ProfileSet, b'0', null),
  ('ACTIVATED', 'A169318', NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', b'0', NULL, '5285570000', 16, b'0', NULL, '5285579999', @MASTERCARD, @ProfileSet, b'0', null);

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`) VALUES
  ((SELECT id FROM BinRange WHERE lowerBound='4226440000' AND upperBound='4226449999' AND fk_id_profileSet=@ProfileSet), (SELECT id FROM SubIssuer WHERE code=@code)),
  ((SELECT id FROM BinRange WHERE lowerBound='4226040000' AND upperBound='4226049999' AND fk_id_profileSet=@ProfileSet), (SELECT id FROM SubIssuer WHERE code=@code)),
  ((SELECT id FROM BinRange WHERE lowerBound='4285570000' AND upperBound='4285579999' AND fk_id_profileSet=@ProfileSet), (SELECT id FROM SubIssuer WHERE code=@code));

/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.  */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`)
VALUES ('A169318', '2018-04-16 08:00:00', 'China Bank Corporation Logo', NULL, NULL, 'China Bank Corporation', 'PUSHED_TO_CONFIG', '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IQkyk7ehZfDzEi9DhsC73jowRo6Af6MN4Nti89hMPUEQBEEQBJfp9wJLEARBEARhoGEz0EcQBEEQBEHoCRFYgiAIgiAILiMCSxAEQRAEwWVEYAmCIAiCILiMCCxBEARBEASXEYElCIIgCILgMiKwBEEQBEEQXEYEliAIgiAIgsuIwBIEQRAEQXAZEViCIAiCIAguI0vlCIIgCH8IysvL8f333yMQCGD06NHYYINVF4n+o9Lc3Izc3Fz9qm9aW1uRnZ2tXyVPW1sbsrKy9Kvksft7axLxYAmCIAiDmvHjx8MwDKy11lrYZ599cNBBB2HDDTdUtl133RUVFRX6kytTVlamPvPMM89oy+Dk2GOPRV5eHkKhkLYkZtasWRg+fLg6Jzk5Oepx7NixWL58uf5EYs4//3z1Wd5YJPFjaWkpnn/+ef2JxDz55JPwer0r/d5+++2HcDisP9G/EQ+WIAiCMGjx+XyIRCLqOTfS2223Hfx+P7755hv89ttvys7Mnj0be+yxh34VY8SIEeozzz77LI477jhtHVw8/vjjOO2009RzPk8eT2K/y1VXXYXbbrtNPV9//fWVSP3xxx8xY8YMZZs8eTKOP/549bwrLIriHHrooUrkLly4EB9//LGyHXzwwXjttdfU865ccMEFuP/++9XzI488Uv3dU089haamJmVjL2RaWpp63m9hgSUIgiAIg41jjjmGHQhqW7RokbauDImFzs90Z9q0aeYjjzxi/vrrr9oyuLjjjjs6j503Elj6nZWZP39+52feeustbY3R0dHR+V5VVZW2xth6662VfbPNNtOW31mxYkXn3z3zzDPaGuOTTz7pfK87Z599trIPGzZMW/ovIrAEQRCEQUm8kZ4yZYq2JCb+ueuvv15bBj/bbbdd53HHt54EFgskfn/8+PHasjLvvfeeen/s2LHaYpqNjY2d39sTkydPVu+PHDlSW2JstNFGyj516lRtWZmioiL1/rfffqst/RMZIhQEQRAGHTyUlJ+fr57X1dWhsLBQPU/EnnvuiTlz5mD77bfHggULtBVob29HNBpFZmZm59AZN5kcqM1Dj+np6crGQ14fffSRimM6/PDD1VBkX7z99ttYtGgRiouLVVxRb/vH/PLLLyAho4LRN998c+y+++76HWu8//772G233dRzHr7j44sP4/U0RBh/v6Ojo/OYuxP/TFxSPPHEE/jrX/+qhhN5KDERHLgeP1ddpUj37+rOHXfcgSuuuAJnnXUWHnroIW3th9ABCIIgCMKgg5s43m655RZtsUZJSYn6+0mTJmmLaZIAU7a99trLJIHQ+Rtdt7333lt/elUuvvjihH/DHqVELF261BwyZEjCv7nvvvv0p5Ln6aefVn978803a8vv5ymRB4uEauf7vUFCUX2Gh/e60n3YsCtdhx7jzJ07V70eNWqUtqxK/O/WWmstbemfyCxCQRAEYVDy5z//WT3+/e9/VzPllixZol4nC890Y7qmFYh7cNiTxDPiOGD+7rvvxnPPPdcZ5P3uu+8q70132EN2zz33qOck+kBCQQWHs4eMg77ZA9YVTimx7rrrKg8cB4O/9dZb+PDDD5UHh+FA8AsvvFA9Txb2fFHbr85JMvC+JUNNTY167O6tIpGqn63KGWecoR45iD3Od999px432WQT9ZgIngHKdJ2k0C+J6SxBEARBGHywJ4Sbuq7bHnvsYd55550q0Lo34rFHL7/8sraY5ueff975Pbvssou2/s7EiRM73+/K9OnTE9rjxN977LHHtOV321NPPaUtKxN/n0SJttgj/j09xWDF3//iiy+0ZWW6evL4vCbDTTfd1Pk3JM601TSvvfZaZTvzzDO1JTHxv+3PiAdLEARBGLRw7BLH6XSNceJ4q8suuwzDhg1TsVQPPvigfsca7Knqzumnn66fxZJqxrnyyivV46OPPqoeu0PCojN9BMOeLWaLLbbAySefrJ53J55H6tJLL1WPqSLumdt5553VY3c4l1gczlvVF7zf11xzjXo+YcIEFBUVqedM/Jwl8z39HRFYgiAIwqCGg6F5mK2hoQEPP/wwDjzwQP1OLLD73HPP7Rx2skJfeZg4V1Ocr7/+Wj2edNJJ6rE7N9xwA4LBIO688071mnNvMXEhkohjjjlGPb7++uvqMVXExR4HpXMQ/AMPPIB58+YpOwvXzz77DLvssov6DJ/P3uBcWvGcYnxdeJgzEfFA94GMCCxBEAThDwHPKjzzzDOVIDFNE4sXL+4UWz/88IN6L1mSWbal6+y7OMkmx4x7sjh2jL+np211weKUvUp83s477zwlqE488URlZ+HFGd6ZUaNGqcdEnH322SphKcOPiWYAxmd+dvX+DVREYAmCIAiDkvr6euUV6glei5DF1jnnnKNeT5w4UT0mA6c3SJauAitZWLQwI0eOVKkOONg90cbvJZMWwiksfHiJmldeeUWdLw5QnzRpkhJcPAkgnpl97bXXVo/d4QB/9h4yjzzyCP71r3+p593h7PnMihUr1GMiqqqq9LP+jeTBEgRBEAYdBQUFaGxsVLPlbr75Zm1NDK+lx0KG4b+Jz+bjfFPsSXr55Zc7Z7p98cUX2HrrrdXsup68LHHPEgs83g8mbku2yd10003VjDqO89prr720NTXE962nPFjJ0Nvx8UzC+CxDFmK8fmFPxM8vC61ly5Zp68rMnTtXzYbceOONO2cd9kfEgyUIgiAMOuIpGuLr2fUGp1yI0z1VgtvwUGQiWIyxSIkPse24447qkRN29gaLv19//VW/Sg2PPfaYilP78ssvtWVlOAEqExeTXRk6dGinuOLkr72JK2arrbZSj70tIP3GG2+ox/3331899ldEYAmCIAiDjhtvvFE9cqPeW6A4w7FEzGabbaYeU0F8JiDPFkzEfffdpx7jAu/8889Xj0899ZR6TARnMx83bpzy5KQSFnk80/Kuu+7SlpWJD7Heeuut6jEOzz6srKxUgfDs2crNzdXv9E4803xPszvjw4vjx49Xj/0VGSIUBEEQBiUXXXSRSgPAcLwVJ/nkoHb2FHHTx54QFgdxDxAPScVjgBg3hwj59+LDbzxk2TXRZ3zIi+HZhnGhxyka+DUHl7NQ6ZrOgOOf4qLt888/7/T82KGvIUI+B3wuGJ49uNNOO6nnDKelYA8Xp5joGu/Wddj1+uuvV0HwvPRQIjhG7fLLL9evYglE49eh++9xSogPPvhAefg4UWu/hgWWIAiCIAxGelqapvtGDbn+i99Zf/311XsvvPCCtpjmwoULO/+mJ+Lv19bWakuMjz/+uPM93nhx5KysrM7XJAb1J39n2LBhne/n5eWtskjzww8/rD9pn/h3hcNhbVmVCy+8sPNzvHTPmDFjOl/z1j1J6UknnbTS+31t3bnrrrs63xs6dKi5/fbbd75OT0/Xn+rfiAdLEARBGNSwJ+m6667Da6+9hqVLl2prbMmVU045BVdffbW2rAzHHXGOJx4ai+d54uV2eEiRPTLs2UoEe1l4xt3MmTNXGRbj2Yc8A4+X1ol7dHixac4t1dNQHw8Tcn6sr776Sr1mL9Nhhx2mvHNxL5ET2EPE+8WeIU682hNvvvmmSpjKXjyG46tIwHYmUe0K57fipX76SkvBEoRnTHLy1+58++23OO200zoX4OaZjOxx7D4U2V8RgSUIgiAIguAyEuQuCIIgCILgMiKwBEEQBEEQXEYEliAIgiAIgsuIwBIEQRAEQXAZEViCIAiCIAguIwJLEARBEATBZURgCYIgCIIguIwILEEQBEEQBJcRgSUIgiAIguAyIrAEQRAEQRBcRgSWIAiCIAiCy4jAEgRBEARBcBkRWIIgCIIgCK4C/D8CYbYUP5QRnQAAAABJRU5ErkJggg==');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = '00070');
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`) VALUES
  ('A169318', NOW(), 'customitemset_00070_1_REFUSAL_Current', NULL, NULL, 'customitemset_00070_1_REFUSAL', 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID),
  ('A169318', NOW(), 'customitemset_00070_SMS_Current', NULL, NULL, 'customitemset_00070_SMS', 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* CustomItem */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;
SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_00070_1_REFUSAL');
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_00070_SMS');
SET @cbcLogo = (SELECT id FROM `Image` WHERE `name` = 'China Bank Corporation');
SET @mcLogo = (SELECT id FROM `Image` WHERE `name` LIKE '%MC_LOGO%');
SET @mcId = (SELECT id FROM `Network` WHERE `code` LIKE '%MASTERCARD%');


INSERT INTO `CustomItem` (`DTYPE`, `id`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `backgroundColor`, `borderStyle`, `textColor`, `fk_id_network`, `fk_id_image`, `fk_id_font`, `fk_id_customItemSet`) VALUES
	('I', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', 'en', 2, 'ALL', 'MasterCard SecureCode™', NULL, NULL, NULL,@mcId, @mcLogo, NULL, @customItemSetSMS),
	('I', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', 'en', 1, 'ALL', 'China National Bank', NULL, NULL, NULL, @mcId,  @cbcLogo, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_1_en', 'PUSHED_TO_CONFIG', 'en', 1, 'REFUSAL_PAGE', 'Your payment with Mastercard SecureCode™ is unsuccessful', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_2_en', 'PUSHED_TO_CONFIG', 'en', 2, 'REFUSAL_PAGE', 'Your Mastercard SecureCode™ authentication failed. Please call China Bank Tellerphone 24/7 Hotline at +632 8855888.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetRefusal),
	/*('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_14_en', 'PUSHED_TO_CONFIG', 'en', 14, 'REFUSAL_PAGE', 'Transaction cancelled', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_15_en', 'PUSHED_TO_CONFIG', 'en', 15, 'REFUSAL_PAGE', 'You have cancelled your transaction. You are going to be redirected to the merchant site', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetRefusal),*/
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_20_en', 'PUSHED_TO_CONFIG', 'en', 20, 'REFUSAL_PAGE', '', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_40_en', 'PUSHED_TO_CONFIG', 'en', 40, 'REFUSAL_PAGE', 'Cancel my purchase', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_41_en', 'PUSHED_TO_CONFIG', 'en', 41, 'REFUSAL_PAGE', 'Information', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'en', 0, 'MESSAGE_BODY', 'To authentify your purchase of amount @amount on @merchant, please enter the code @otp. Yours China Banking Corporation', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_FAILURE_PAGE_1_en', 'PUSHED_TO_CONFIG', 'en', 1, 'FAILURE_PAGE', 'You have submitted a wrong one-time password three times, your transaction has been cancelled.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_FAILURE_PAGE_2_en', 'PUSHED_TO_CONFIG', 'en', 2, 'FAILURE_PAGE', 'A new transaction can be initiated on the mechant website.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_FAILURE_PAGE_3_en', 'PUSHED_TO_CONFIG', 'en', 3, 'FAILURE_PAGE', '', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	/*('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_FAILURE_PAGE_14_en', 'PUSHED_TO_CONFIG', 'en', 14, 'FAILURE_PAGE', 'Transaction cancelled', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_FAILURE_PAGE_15_en', 'PUSHED_TO_CONFIG', 'en', 15, 'FAILURE_PAGE', 'You have cancelled your transaction. You are going to be redirected to the merchant site', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),*/
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_FAILURE_PAGE_20_en', 'PUSHED_TO_CONFIG', 'en', 20, 'FAILURE_PAGE', '', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_FAILURE_PAGE_40_en', 'PUSHED_TO_CONFIG', 'en', 40, 'FAILURE_PAGE', 'Cancel my purchase', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_FAILURE_PAGE_41_en', 'PUSHED_TO_CONFIG', 'en', 41, 'FAILURE_PAGE', 'Information', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_1_en', 'PUSHED_TO_CONFIG', 'en', 1, 'OTP_FORM_PAGE', 'Please enter the six characters long one-time password you received via SMS in the following field.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_2_en', 'PUSHED_TO_CONFIG', 'en', 2, 'OTP_FORM_PAGE', 'If your phone number is incorrect, please contact customer service under +632 8855 888.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_14_en', 'PUSHED_TO_CONFIG', 'en', 14, 'OTP_FORM_PAGE', 'Authentication cancelled', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_15_en', 'PUSHED_TO_CONFIG', 'en', 15, 'OTP_FORM_PAGE', 'Your payment has been canceled, you will be redirected to the merchant website.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_20_en', 'PUSHED_TO_CONFIG', 'en', 20, 'OTP_FORM_PAGE', '', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_40_en', 'PUSHED_TO_CONFIG', 'en', 40, 'OTP_FORM_PAGE', 'Cancel my purchase', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_41_en', 'PUSHED_TO_CONFIG', 'en', 41, 'OTP_FORM_PAGE', 'Information', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
    ('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_40_en', 'PUSHED_TO_CONFIG', 'en', 40, 'HAMBURGER_MENU', 'Cancel my purchase', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_41_en', 'PUSHED_TO_CONFIG', 'en', 41, 'HAMBURGER_MENU', 'Information', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),	
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_HELP_PAGE_1_en', 'PUSHED_TO_CONFIG', 'en', 1, 'HELP_PAGE', 'Mastercard introduced Mastercard SecureCode™ in order to increase simplicity and security of online shopping. You will receive a one-time password via SMS, which is sent to your registered and valid phone number. ', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_HELP_PAGE_2_en', 'PUSHED_TO_CONFIG', 'en', 2, 'HELP_PAGE', 'You have to submit this code into the authentication page to validate your 3-D Secure authentication.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_HELP_PAGE_3_en', 'PUSHED_TO_CONFIG', 'en', 3, 'HELP_PAGE', 'With this procedure, Mastercard and China Banking Corporation offers you higher security when paying online with your China Banking Corporation Mastercard at participating merchants.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_HELP_PAGE_4_en', 'PUSHED_TO_CONFIG', 'en', 4, 'HELP_PAGE', 'If your phone number is incorrect or if you do not receive the SMS, please contact customer service under +632 8855 888.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_FAILURE_PAGE_13', 'PUSHED_TO_CONFIG', 'en', 20, 'FAILURE_PAGE', '', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_FAILURE_PAGE_17', 'PUSHED_TO_CONFIG', 'en', 17, 'FAILURE_PAGE', 'Your submitted code is incorrect. Maximum number of attempts is reached.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_FAILURE_PAGE_16', 'PUSHED_TO_CONFIG', 'en', 16, 'FAILURE_PAGE', 'Authentication failure.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_16_en', 'PUSHED_TO_CONFIG', 'en', 22, 'REFUSAL_PAGE', 'Payment unsuccessful', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_23', 'PUSHED_TO_CONFIG', 'en', 23, 'REFUSAL_PAGE', 'Your payment with Mastercard SecureCode™ is unsuccessful.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetRefusal),
	('I', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', 'en', 2, 'REFUSAL_PAGE', 'MasterCard SecureCode™', NULL, NULL, NULL, @mcId, @mcLogo, NULL, @customItemSetRefusal),
	('I', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'Bank  Logo', 'PUSHED_TO_CONFIG', 'en', 1, 'REFUSAL_PAGE', 'China National Bank', NULL, NULL, NULL, @mcId, @cbcLogo, NULL, @customItemSetRefusal),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_15_en', 'PUSHED_TO_CONFIG', 'en', 3, 'OTP_FORM_PAGE', 'By submitting the password you identify yourself as the cardholder and approve the transaction.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_24_en', 'PUSHED_TO_CONFIG', 'en', 12, 'OTP_FORM_PAGE', 'Authentication in progress', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_25_en', 'PUSHED_TO_CONFIG', 'en', 13, 'OTP_FORM_PAGE', 'Your entry will be checked and the page will be updated automatically in a few seconds.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_26_en', 'PUSHED_TO_CONFIG', 'en', 26, 'OTP_FORM_PAGE', 'Authentication successful', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_27_en', 'PUSHED_TO_CONFIG', 'en', 27, 'OTP_FORM_PAGE', 'Your authentication has been validated, you will be redirected to the merchant website.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_28_en', 'PUSHED_TO_CONFIG', 'en', 28, 'OTP_FORM_PAGE', 'Wrong one-time password', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_29_en', 'PUSHED_TO_CONFIG', 'en', 29, 'OTP_FORM_PAGE', 'Your submitted one-time password is incorrect. Please try again. You have three attempts in total.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_30_en', 'PUSHED_TO_CONFIG', 'en', 30, 'OTP_FORM_PAGE', 'Session expired', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_31_en', 'PUSHED_TO_CONFIG', 'en', 31, 'OTP_FORM_PAGE', 'Your session has expired. Your payment is cancelled.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_32_en', 'PUSHED_TO_CONFIG', 'en', 32, 'OTP_FORM_PAGE', 'Technical Error', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_OTP_FORM_PAGE_33_en', 'PUSHED_TO_CONFIG', 'en', 33, 'OTP_FORM_PAGE', 'A technical error occured and your payment has been cancelled. Please re-try later.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_1_en', 'PUSHED_TO_CONFIG', 'en', 1, 'REFUSAL_PAGE', 'Your payment with Mastercard SecureCode™ is unsuccessful', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_2_en', 'PUSHED_TO_CONFIG', 'en', 2, 'REFUSAL_PAGE', 'Your Mastercard SecureCode™ authentication failed. Please call China Bank Tellerphone 24/7 Hotline at +632 8855888.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	/*('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_14_en', 'PUSHED_TO_CONFIG', 'en', 14, 'REFUSAL_PAGE', 'Transaction cancelled', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_15_en', 'PUSHED_TO_CONFIG', 'en', 15, 'REFUSAL_PAGE', 'You have cancelled your transaction. You are going to be redirected to the merchant site', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),*/
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_20_en', 'PUSHED_TO_CONFIG', 'en', 20, 'REFUSAL_PAGE', '', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_40_en', 'PUSHED_TO_CONFIG', 'en', 40, 'REFUSAL_PAGE', 'Cancel my purchase', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_41_en', 'PUSHED_TO_CONFIG', 'en', 41, 'REFUSAL_PAGE', 'Information', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_16_en', 'PUSHED_TO_CONFIG', 'en', 22, 'REFUSAL_PAGE', 'Payment unsuccessful', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_REFUSAL_REFUSAL_PAGE_23', 'PUSHED_TO_CONFIG', 'en', 23, 'REFUSAL_PAGE', 'Your payment with Mastercard SecureCode™ is unsuccessful.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),
    
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_FAILURE_PAGE_32_en', 'PUSHED_TO_CONFIG', 'en', 32, 'REFUSAL_PAGE', 'Technical Error', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS),	
	('T', NULL, 'A169318', '2018-05-02 11:18:30', NULL, NULL, NULL, 'MASTERCARD_OTP_OTP_SMS_FAILURE_PAGE_33_en', 'PUSHED_TO_CONFIG', 'en', 33, 'REFUSAL_PAGE', 'A technical error occured and your payment has been cancelled. Please re-try later.', NULL, NULL, NULL, @mcId, NULL, NULL, @customItemSetSMS);
/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = '00070');
SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_00070_1_REFUSAL');
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_00070_SMS');
SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  ('A169318', NOW(), 'Authentification refus', NULL, NULL, '00070_REFUSAL_01', 'PUSHED_TO_CONFIG', -1, @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID),
  ('A169318', NOW(), 'Authentification porteur par OTP SMS', NULL, NULL, '00070_SMS_01', 'PUSHED_TO_CONFIG', 3, @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID);

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = '00070_REFUSAL_01');
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = '00070_SMS_01');
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  ('A169318', NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', 'PUSHED_TO_CONFIG', 1, @profileRefusal),
  ('A169318', NOW(), 'SMS_AVAILABLE_NORMAL', NULL, NULL, 'SMS (NORMAL)', 'PUSHED_TO_CONFIG', 2, @profileSMS),
  ('A169318', NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 4, @profileRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('A169318', NOW(), NULL, NULL, NULL, 'C1_P_00070_01_FRAUD', 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  ('A169318', NOW(), NULL, NULL, NULL, 'C2_P_00070_01_FRAUD', 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  ('A169318', NOW(), NULL, NULL, NULL, 'C3_P_00070_01_FRAUD', 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  ('A169318', NOW(), NULL, NULL, NULL, 'C4_P_00070_01_FRAUD', 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  ('A169318', NOW(), NULL, NULL, NULL, 'C1_P_00070_01_OTP_SMS_NORMAL', 'PUSHED_TO_CONFIG', @ruleSMSnormal),
  ('A169318', NOW(), NULL, NULL, NULL, 'C1_P_00070_01_DEFAULT', 'PUSHED_TO_CONFIG', @ruleRefusalDefault);
/*!40000 ALTER TABLE `RuleCondition` ENABLE KEYS */;

/* Condition_TransactionStatuses */
/*!40000 ALTER TABLE `Condition_TransactionStatuses` DISABLE KEYS */;
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_P_00070_01_FRAUD' AND (ts.`transactionStatusType`='PAYMENT_MEANS_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C2_P_00070_01_FRAUD' AND (ts.`transactionStatusType`='CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C3_P_00070_01_FRAUD' AND (ts.`transactionStatusType`='CARD_HOLDER_COUNTRY_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C4_P_00070_01_FRAUD' AND (ts.`transactionStatusType`='MERCHANT_URL_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_P_00070_01_OTP_SMS_NORMAL' AND (ts.`transactionStatusType`='KNOWN_PHONE_NUMBER' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_P_00070_01_OTP_SMS_NORMAL' AND (ts.`transactionStatusType`='PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_P_00070_01_DEFAULT' AND (ts.`transactionStatusType`='DEFAULT' AND ts.`reversed`=FALSE);
/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;

/* Condition_MeansProcessStatuses */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_P_00070_01_OTP_SMS_NORMAL'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR', 'USER_CHOICE_DEMANDED', 'MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_P_00070_01_OTP_SMS_NORMAL'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = '00070_REFUSAL_01');
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = '00070_SMS_01');
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = 'PS_00070_01' AND r.`id` IN (@ruleRefusalFraud, @ruleSMSnormal, @ruleRefusalDefault);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00070');
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES
  ('ISSUER', 'TestMerchant', 'NAME', 0, 0, @issuerId, NULL);
  /*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

  /* Not yet specified for CBC */
 /*
INSERT INTO `SpecificReports_Issuer`(id_specificReport, id_issuer) VALUES
  ((SELECT id from SpecificReports WHERE name = 'SMS_NOTIFICATIONS'),(SELECT id FROM Issuer where code = '00070')),
  ((SELECT id from SpecificReports WHERE name = 'REFUSALCAUSES_PA_BY_PROFILEMEANS'),(SELECT id FROM Issuer where code = '00070')),
  ((SELECT id from SpecificReports WHERE name = 'STATUS_PA_BY_PROFILEMEANS'),(SELECT id FROM Issuer where code = '00070'));
  */
  


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
