/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
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
  ('00010', 'InitPhase', NOW(), NULL, NULL, NULL, 'AnIssuer', 'PUSHED_TO_CONFIG', 'AnIssuer',
    '[{"authentMeans":"OTP_SMS", "validate":true}, {"authentMeans":"REFUSAL", "validate":true}]', 'OTP_SMS|REFUSAL');
/*!40000 ALTER TABLE `Issuer` ENABLE KEYS */;

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00010');
INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `otpExcluded`, `otpAllowed`, `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `fk_id_issuer`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`) VALUES
  ('ACS_U5G', 300, 'en', '00001', '00001', 'EUR', 'InitPhase', NOW(), NULL, NULL, NULL, 'ASubIssuer', 'PUSHED_TO_CONFIG',
    'en', 600, 'ASubIssuer', TRUE, TRUE, '^[^OIi]*$', '8:(:DIGIT:1)', NULL, TRUE, TRUE, 300, @issuerId,
    'https://ssl-qlf-u5g-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest', 'https://ssl-qlf-u5g-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest',
    'https://ssl-qlf-u5g-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest', 'https://ssl-qlf-u5g-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest',
    FALSE, TRUE, TRUE, TRUE, 'OTP_SMS', '250', 'VE_AND_PA_MODE');
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;

/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00010');
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId;
/*!40000 ALTER TABLE `Network_SubIssuer` ENABLE KEYS */;

--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\
--  /!\ SubIssuerCrypto                                                                    /!\
--  /!\ This is a very specific configuration, contact your Project Manager to get         /!\
--  /!\ the correct information for your instance (unless the configuration is mutualized) /!\
--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\
/*!40000 ALTER TABLE `SubIssuerCrypto` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00010');
INSERT INTO `SubIssuerCrypto` (`acsIdForCrypto`, `binKeyIdentifier`, `cavvKeyIndicator`, `cipherKeyIdentifier`,
                               `desCipherKeyIdentifier`, `desKeyId`, `hubAESKey`, `secondFactorAuthentication`, `fk_id_subIssuer`)
  SELECT '00', '5', '00', 'EC11223344554B544F4B5F4145535F74657300', 'EC11223344554B544F4B5F4145535F74657300', '1', '01', 'NO_SECOND_FACTOR', si.id
  FROM `SubIssuer` si WHERE si.fk_id_issuer = @issuerId;
/*!40000 ALTER TABLE `SubIssuerCrypto` ENABLE KEYS */;

--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\
--  /!\ SubIssuerNetworkCrypto                                                             /!\
--  /!\ This is a very specific configuration, contact your Project Manager to get         /!\
--  /!\ the correct information for your instance (unless the configuration is mutualized) /!\
--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\
/*!40000 ALTER TABLE `SubIssuerNetworkCrypto` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00010');
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
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00010');
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT 'InitPhase', NOW(), 'Initial profile set', NULL, NULL, CONCAT('PS_', si.code, '_01'), 'PUSHED_TO_CONFIG', si.id
    FROM `SubIssuer` si
    WHERE si.fk_id_issuer=@issuerId;
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;

/* CustomPageLayout_ProfileSet - Link the predefined layouts to the profileSet (in order to see the templates) */
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` DISABLE KEYS */;
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
    SELECT cpl.id, p.id
    FROM `CustomPageLayout` cpl, `ProfileSet` p;
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` ENABLE KEYS */;

/* BinRange */
/* BinRange_SubIssuer */
/* Nothing to add for now */

/* Image - The image is stored as 'Blob' so you need to convert you image (example.png) to Base64 before inserting it. */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`)
VALUES ('InitPhase', NOW(), 'RandomBank  Logo', NULL, NULL, 'RandomBank', 'PUSHED_TO_CONFIG', 'iVBORw0KGgoAAAANSUhEUgAAAMAAAABVCAIAAACQFXygAAAACXBIWXMAAAsSAAALEgHS3X78AAAHt0lEQVR42u2dvcolRRCG5xYEr8BbMDbzFvYWNtfEwFgQDIy/UDBQg40EFxaENTFZs4VdBEEDRRBNxMBoLC227K9/at7q6umZc069FMt3Zuf09HQ907/Vc5Y1FHJoOToDoctWABRyKQAKuRQAhVwKgEIuBUAhlwKgkEsBUMilACjkUgAUcmm5++Z73L56/vPRGT6jTGV4iO1378vy8BOrffj4eZbKa+98lp3z4O7pD7/9Wb3ks59+T8+kj/o5fP/pkfcefbd59S+e/di6Z/q6fOXtj59UyzdNU05o5byjDCfbuQAi++Ovv6slzm4jwujvN95/VJ7GevLiFwXH7BxJh/338NNvW/7mq9O/9JXU8SJKh/+LL0of3/zgy5LIjCHCkY/Qt+QgZe//Qjyaj8sDKC2+0oXkGD6tVQ0QBOwY5qN6Tlnl8BHF2XI5+oM+0sHqdanWKa9SVoT0daZN0qEvcp6z8w/n42oBKk9jkWPIqI1rOU9cSz6Tc3CAqkfkYFbnpXVSdjLVT/y/fCN0hCvXAGhfgLiU0wc9FbdN7DBuQaqtmODC1Qad2QFQmnKrXuRKRdqpDCC+F/qXa7VqjXU4H9cDkBgVfeuSDAQ7QHpLCkDScaG/9wOo7FoxQIw7PQx0An2URAKgXQBi37Cny2eaxTRkVg7Z0vqGOeNLIAC12tCOJky+xe1XADQDIPZ92YddX7Vf6fio5b+sweLGDgSI0q9WbNZONAMk/TDKfAA0AyD5WJ7GLkyPc+1SNnmMmuAio/pNgGQYX15dxu3gMJ5zJfXf2qjbDufjSICyKcu3PnrcAVDaAWJnSIWRPqkyhBFny6h4ud/kVacNGb7S2eVEIp3ZmsZcjROJdCM8WqTsCT3ZrR04xYw46/V3P98RoOwzO6mjBgodIsRZrZm2MRnIPgdAl6UAKORSABRyKQAKuXSFANGYhUZbPJeYGR3kubhRuafU2KqXE+M5QLb9ihIRlRtnoxw58uCR/qu6MtjSVQFEN1+dZS6NBs9KvI4igo+uAmZSKdBNjtMZB9AUOmm8bcozL6HMAchTkv/aEIA6ipsxUmZrSm5AOnHjhbZRAC216exWZQNm7/oBoiKTOcM+06siSt9Z3+hG3m3Vph2ppZUQ3Vc3OjhDlw0QRzj4TQnaHV7r6M+DEyBe0qdaLZ1hd5r+gF0wQH1FbGVoDkBUVWSNaXejTFXm2Dz73X9GgGSBeqBVRx9zAFqK8Lc+gHbKrdKhvlSA9rDqfU4DaKnFCJzElJ5QAHTPypHwTICq+z3W/2a2ZmajtFZo3hCATPfIM2r3MuAHiGfGsj4E9Wn0yb1W/rJx9eZd8aRO2YWivqe1FqlGwLHSfUjzTSFgFECI63kfRJ6BboDAOVMrkdV409ZziWTANCBSErR6nQPyycoeDF3FBLdC9kCA9H5tlZ5+gExrYWDck5T7JkD4RK2VIWXMjD8A4CQ7+QOfKNobIN1HLXomAbS+CrMHLW3FSoCUDkFLlCDoKmU5YuCzLsLroV1z1U3PPIBWS3d4jyVP8L4mA5Rttj8EIA8960yA8GlrZA3IKvBZnwwQmOx+ADnpWSfHA4GVkLIpsVsgvvMBAstkj1z56VknA4T3hHo5aQoch98OQEPoWScDhLdiYO5xBUCpRtGzTgYo21c1PH1FAZBoID3r/JhosLz64hUVBUCszTk5a90/GyBwGX/ztX68UqHE+6Vx0FTzBUAIPYt9CDwbIDD9FkDEzcBYrZsCCF8PsEX1nxOg0pHyyoRd7VoBMq0mKS+3PB4gcCSfvRhqj/i12wGow/CGbDZA1hnh4RGiARBo6L6icwLEfaD5kVwBUHovSEN20j4QAzSt5QqAqgZtTDsnQJS+qd/Hm4KrV+St1udcjT85QIijTzoPhHd9+A1im9e95XmgMpP4XtDNhmw2QGDWv375K0gPOOAMgCSH9LzJK94Ra+01OAYgJPH0hfCjshEALffXuUxB2Vqk70yAwAC8B3dPkelmU9hQAFTW1vgYRWnIpgKETwIhLZ1etQZAOj2rMaq/VdpTAQKXscAetCl0+pYBKnfbifwN2TyAwGAg3gMVAA0ESM+VsyGbBxAIO09eIcUaTdiQXJkasnJP1SSA8J1ZHEuA9IGiEz0qV6Y526whmwQQ2PuRd6yA5+Phc7ErY4iDlqJH1QmQKW4N3x4vXILtHbhL1b8lDZx52w+g6qMyMFemhiyt+/tfrkCpbEYuU7bwPlrqPHzLpo4yZcAUwVgta0oEnEDfD6ByxWZ4rkwNGb+LzQWQZK76dhXry3jLHr5pvaZ8bS8d6Qt+paLhSOqO75aWtfWmNYSdTIk37ykxJ0BDrHxFofWBOK1dFkD4WOdEAFGOW1Hcu8bPB0BVmd+8awWI+hwD/Uqtj7IHQH5u128cMBQAbQJkfm5NAElPZYgz+DcA9ZvBu4qKyQ9c+t/8fQsA2QoKByhra+jv7pBTAtG097S7Yc3eZTb/VYeXCNBqashAV7V6KlRA1p8RQW6glPU3D1q/5+L/bYZbAMjw0JboyY7g1DbbGv5idduX7DIe8kNPdP+UVLXykxH4ZiL6O1w7fnbpZrX4kwjdsgKgkEsBUMilACjkUgAUcikACrkUAIVcCoBCLgVAIZcCoJBL/wBme+MDWZBaWAAAAABJRU5ErkJggg==');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet - Use the status 'BEING_MODIFIED_IN_ACCEPTANCE' as default */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = '00001');
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`) VALUES
  ('InitPhase', NOW(), 'customitemset_00001_DEFAULT_REFUSAL_Current', NULL, NULL, 'customitemset_00001_DEFAULT_REFUSAL', 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), 'customitemset_00001_1_REFUSAL_Current', NULL, NULL, 'customitemset_00001_1_REFUSAL', 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), 'customitemset_00001_SMS_Current', NULL, NULL, 'customitemset_00001_SMS', 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* CustomItem */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_00001_SMS');
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', 'InitPhase', NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', 'fr', 2, 'ALL', 'MasterCard SecureCode™',
          n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', 'InitPhase', NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', 'en', 2, 'ALL', 'MasterCard SecureCode™',
          n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', 'InitPhase', NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', 'fr', 2, 'ALL', 'Verified by Visa™',
          n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', 'InitPhase', NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', 'en', 2, 'ALL', 'Verified by Visa™',
          n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', 'InitPhase', NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', 'fr', 1, 'ALL', 'Random Bank™',
         NULL, im.id, @customItemSetSMS
  FROM `Image` im WHERE im.name LIKE '%RandomBank%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', 'InitPhase', NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', 'en', 1, 'ALL', 'Random Bank™',
         NULL, im.id, @customItemSetSMS
  FROM `Image` im WHERE im.name LIKE '%RandomBank%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
    SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_1_fr'), 'PUSHED_TO_CONFIG',
           'fr', 1, 'REFUSAL_PAGE', 'FR_Text 1 on refusal page with authent mean OTP_SMS and network @network',
           n.id, NULL, @customItemSetSMS
    FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_1_en'), 'PUSHED_TO_CONFIG',
         'en', 1, 'REFUSAL_PAGE', 'Text 1 on refusal page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_2_fr'), 'PUSHED_TO_CONFIG',
         'fr', 2, 'REFUSAL_PAGE', 'FR_Text 2 on refusal page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_2_en'), 'PUSHED_TO_CONFIG',
         'en', 2, 'REFUSAL_PAGE', 'Text 2 on refusal page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_14_fr'), 'PUSHED_TO_CONFIG',
         'fr', 14, 'REFUSAL_PAGE', 'FR_Transaction cancelled',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_14_en'), 'PUSHED_TO_CONFIG',
         'en', 14, 'REFUSAL_PAGE', 'Transaction cancelled',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_15_fr'), 'PUSHED_TO_CONFIG',
         'fr', 15, 'REFUSAL_PAGE', 'FR_You have cancelled your transaction. You are going to be redirected to the merchant site',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_15_en'), 'PUSHED_TO_CONFIG',
         'en', 15, 'REFUSAL_PAGE', 'You have cancelled your transaction. You are going to be redirected to the merchant site',
          n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_20_fr'), 'PUSHED_TO_CONFIG',
         'fr', 20, 'REFUSAL_PAGE', 'FR_Page title (@network)',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_20_en'), 'PUSHED_TO_CONFIG',
         'en', 20, 'REFUSAL_PAGE', 'Page title (@network)',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_40_fr'), 'PUSHED_TO_CONFIG',
         'fr', 40, 'REFUSAL_PAGE', 'FR_Cancel my purchase', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_40_en'), 'PUSHED_TO_CONFIG',
         'en', 40, 'REFUSAL_PAGE', 'Cancel my purchase', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_41_fr'), 'PUSHED_TO_CONFIG',
         'fr', 41, 'REFUSAL_PAGE', 'FR_Information', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_REFUSAL_PAGE_41_en'), 'PUSHED_TO_CONFIG',
         'en', 41, 'REFUSAL_PAGE', 'Information', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  VALUES ('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'fr', 0, 'MESSAGE_BODY',
          'FR_To authenticate your purchase of amount @amount on the web page @merchant, please enter the code @otp', NULL, NULL, @customItemSetSMS);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  VALUES ('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'en', 0, 'MESSAGE_BODY',
        'To authenticate your purchase of amount @amount on the web page @merchant, please enter the code @otp', NULL, NULL, @customItemSetSMS);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_1_fr'), 'PUSHED_TO_CONFIG',
         'fr', 1, 'FAILURE_PAGE', 'FR_Text 1 on failure page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_1_en'), 'PUSHED_TO_CONFIG',
         'en', 1, 'FAILURE_PAGE', 'Text 1 on failure page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_2_fr'), 'PUSHED_TO_CONFIG',
         'fr', 2, 'FAILURE_PAGE', 'FR_Text 2 on failure page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_2_en'), 'PUSHED_TO_CONFIG',
         'en', 2, 'FAILURE_PAGE', 'Text 2 on failure page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_3_fr'), 'PUSHED_TO_CONFIG',
         'fr', 3, 'FAILURE_PAGE', 'FR_Text 3 on failure page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_3_en'), 'PUSHED_TO_CONFIG',
         'en', 3, 'FAILURE_PAGE', 'Text 3 on failure page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_14_fr'), 'PUSHED_TO_CONFIG',
         'fr', 14, 'FAILURE_PAGE', 'FR_Transaction cancelled', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_14_en'), 'PUSHED_TO_CONFIG',
         'en', 14, 'FAILURE_PAGE', 'Transaction cancelled', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_15_fr'), 'PUSHED_TO_CONFIG',
         'fr', 15, 'FAILURE_PAGE', 'FR_You have cancelled your transaction. You are going to be redirected to the merchant site',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_15_en'), 'PUSHED_TO_CONFIG',
         'en', 15, 'FAILURE_PAGE', 'You have cancelled your transaction. You are going to be redirected to the merchant site',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_20_fr'), 'PUSHED_TO_CONFIG',
         'fr', 20, 'FAILURE_PAGE', 'FR_Page title (@network)', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_20_en'), 'PUSHED_TO_CONFIG',
         'en', 20, 'FAILURE_PAGE', 'Page title (@network)', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_40_fr'), 'PUSHED_TO_CONFIG',
         'fr', 40, 'FAILURE_PAGE', 'FR_Cancel my purchase', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_40_en'), 'PUSHED_TO_CONFIG',
         'en', 40, 'FAILURE_PAGE', 'Cancel my purchase', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_41_fr'), 'PUSHED_TO_CONFIG',
         'fr', 41, 'FAILURE_PAGE', 'FR_Information', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_FAILURE_PAGE_41_en'), 'PUSHED_TO_CONFIG',
         'en', 41, 'FAILURE_PAGE', 'Information', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_1_fr'), 'PUSHED_TO_CONFIG',
         'fr', 1, 'CHOICE_PAGE', 'FR_Text 1 on choice page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_1_en'), 'PUSHED_TO_CONFIG',
         'en', 1, 'CHOICE_PAGE', 'Text 1 on choice page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_2_fr'), 'PUSHED_TO_CONFIG',
         'fr', 2, 'CHOICE_PAGE', 'FR_Text 2 on choice page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_2_en'), 'PUSHED_TO_CONFIG',
         'en', 2, 'CHOICE_PAGE', 'Text 2 on choice page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_14_fr'), 'PUSHED_TO_CONFIG',
         'fr', 14, 'CHOICE_PAGE', 'FR_Transaction cancelled', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_14_en'), 'PUSHED_TO_CONFIG',
         'en', 14, 'CHOICE_PAGE', 'Transaction cancelled', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_15_fr'), 'PUSHED_TO_CONFIG',
         'fr', 15, 'CHOICE_PAGE', 'FR_You have cancelled your transaction. You are going to be redirected to the merchant site',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_15_en'), 'PUSHED_TO_CONFIG',
         'en', 15, 'CHOICE_PAGE', 'You have cancelled your transaction. You are going to be redirected to the merchant site',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_20_fr'), 'PUSHED_TO_CONFIG',
         'fr', 20, 'CHOICE_PAGE', 'FR_Page title (@network)', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_20_en'), 'PUSHED_TO_CONFIG',
         'en', 20, 'CHOICE_PAGE', 'Page title (@network)', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_40_fr'), 'PUSHED_TO_CONFIG',
         'fr', 40, 'CHOICE_PAGE', 'FR_Cancel my purchase', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_40_en'), 'PUSHED_TO_CONFIG',
         'en', 40, 'CHOICE_PAGE', 'Cancel my purchase', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_41_fr'), 'PUSHED_TO_CONFIG',
         'fr', 41, 'CHOICE_PAGE', 'FR_Information', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_CHOICE_PAGE_41_en'), 'PUSHED_TO_CONFIG',
         'en', 41, 'CHOICE_PAGE', 'Information', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_1_fr'), 'PUSHED_TO_CONFIG',
         'fr', 1, 'OTP_FORM_PAGE', 'FR_Text 1 on choice page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_1_en'), 'PUSHED_TO_CONFIG',
         'en', 1, 'OTP_FORM_PAGE', 'Text 1 on choice page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_2_fr'), 'PUSHED_TO_CONFIG',
         'fr', 2, 'OTP_FORM_PAGE', 'FR_Text 2 on choice page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_2_en'), 'PUSHED_TO_CONFIG',
         'en', 2, 'OTP_FORM_PAGE', 'Text 2 on choice page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_14_fr'), 'PUSHED_TO_CONFIG',
         'fr', 14, 'OTP_FORM_PAGE', 'FR_Transaction cancelled', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_14_en'), 'PUSHED_TO_CONFIG',
         'en', 14, 'OTP_FORM_PAGE', 'Transaction cancelled', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_15_fr'), 'PUSHED_TO_CONFIG',
         'fr', 15, 'OTP_FORM_PAGE', 'FR_You have cancelled your transaction. You are going to be redirected to the merchant site',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_15_en'), 'PUSHED_TO_CONFIG',
         'en', 15, 'OTP_FORM_PAGE', 'You have cancelled your transaction. You are going to be redirected to the merchant site',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_20_fr'), 'PUSHED_TO_CONFIG',
         'fr', 20, 'OTP_FORM_PAGE', 'FR_Page title (@network)',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_20_en'), 'PUSHED_TO_CONFIG',
         'en', 20, 'OTP_FORM_PAGE', 'Page title (@network)', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_40_fr'), 'PUSHED_TO_CONFIG',
         'fr', 40, 'OTP_FORM_PAGE', 'FR_Cancel my purchase', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_40_en'), 'PUSHED_TO_CONFIG',
         'en', 40, 'OTP_FORM_PAGE', 'Cancel my purchase', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_41_fr'), 'PUSHED_TO_CONFIG',
         'fr', 41, 'OTP_FORM_PAGE', 'FR_Information', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_OTP_FORM_PAGE_41_en'), 'PUSHED_TO_CONFIG',
         'en', 41, 'OTP_FORM_PAGE', 'Information', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_HELP_PAGE_1_fr'), 'PUSHED_TO_CONFIG', 'fr', 1,
         'HELP_PAGE', 'FR_Text 1 on help page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_HELP_PAGE_1_en'), 'PUSHED_TO_CONFIG', 'en', 1,
         'HELP_PAGE', 'Text 1 on help page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_HELP_PAGE_2_fr'), 'PUSHED_TO_CONFIG', 'fr', 2,
         'HELP_PAGE', 'FR_Text 2 on help page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_HELP_PAGE_2_en'), 'PUSHED_TO_CONFIG', 'en', 2,
         'HELP_PAGE', 'Text 2 on help page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_HELP_PAGE_3_fr'), 'PUSHED_TO_CONFIG', 'fr', 3,
         'HELP_PAGE', 'FR_Text 3 on help page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_HELP_PAGE_3_en'), 'PUSHED_TO_CONFIG', 'en', 3,
         'HELP_PAGE', 'Text 3 on help page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_HELP_PAGE_4_fr'), 'PUSHED_TO_CONFIG', 'fr', 4,
         'HELP_PAGE', 'FR_Text 4 on help page with authent mean OTP_SMS and network @network',
          n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_OTP_SMS_HELP_PAGE_4_en'), 'PUSHED_TO_CONFIG', 'en', 4,
         'HELP_PAGE', 'Text 4 on help page with authent mean OTP_SMS and network @network',
         n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_means_HAMBURGER_MENU_40_fr'), 'PUSHED_TO_CONFIG',
         'fr', 40, 'HAMBURGER_MENU', 'FR_Cancel my purchase', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_means_HAMBURGER_MENU_40_en'), 'PUSHED_TO_CONFIG',
         'en', 40, 'HAMBURGER_MENU', 'Cancel my purchase', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_means_HAMBURGER_MENU_41_fr'), 'PUSHED_TO_CONFIG',
         'fr', 41, 'HAMBURGER_MENU', 'FR_Information', n.id, NULL, @customItemSetSMS
  FROM `Network` n;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(n.code,'_means_HAMBURGER_MENU_41_en'), 'PUSHED_TO_CONFIG',
         'en', 41, 'HAMBURGER_MENU', 'Information', n.id, NULL, @customItemSetSMS
  FROM `Network` n;
/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = '00001');
SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_00001_1_REFUSAL');
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_00001_SMS');
SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  ('InitPhase', NOW(), 'Authentification refusal', NULL, NULL, '00001_REFUSAL_01', 'PUSHED_TO_CONFIG', -1, @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), 'Authentification through OTP SMS', NULL, NULL, '00001_SMS_01', 'PUSHED_TO_CONFIG', 3, @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID);

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = '00001_REFUSAL_01');
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = '00001_SMS_01');
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  ('InitPhase', NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', 'PUSHED_TO_CONFIG', 1, @profileRefusal),
  ('InitPhase', NOW(), 'SMS_AVAILABLE_NORMAL', NULL, NULL, 'SMS (NORMAL)', 'PUSHED_TO_CONFIG', 2, @profileSMS),
  ('InitPhase', NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 4, @profileRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_P_00001_01_FRAUD', 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C2_P_00001_01_FRAUD', 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C3_P_00001_01_FRAUD', 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C4_P_00001_01_FRAUD', 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_P_00001_01_OTP_SMS_NORMAL', 'PUSHED_TO_CONFIG', @ruleSMSnormal),
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_P_00001_01_DEFAULT', 'PUSHED_TO_CONFIG', @ruleRefusalDefault);
/*!40000 ALTER TABLE `RuleCondition` ENABLE KEYS */;

/* Condition_TransactionStatuses */
/*!40000 ALTER TABLE `Condition_TransactionStatuses` DISABLE KEYS */;
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_P_00001_01_FRAUD' AND (ts.`transactionStatusType`='PAYMENT_MEANS_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C2_P_00001_01_FRAUD' AND (ts.`transactionStatusType`='CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C3_P_00001_01_FRAUD' AND (ts.`transactionStatusType`='CARD_HOLDER_COUNTRY_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C4_P_00001_01_FRAUD' AND (ts.`transactionStatusType`='MERCHANT_URL_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_P_00001_01_OTP_SMS_NORMAL' AND (ts.`transactionStatusType`='KNOWN_PHONE_NUMBER' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_P_00001_01_OTP_SMS_NORMAL' AND (ts.`transactionStatusType`='PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_P_00001_01_DEFAULT' AND (ts.`transactionStatusType`='DEFAULT' AND ts.`reversed`=FALSE);
/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;

/* Condition_MeansProcessStatuses */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_P_00001_01_OTP_SMS_NORMAL'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR', 'USER_CHOICE_DEMANDED', 'MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_P_00001_01_OTP_SMS_NORMAL'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = '00001_REFUSAL_01');
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = '00001_SMS_01');
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = 'PS_00001_01' AND r.`id` IN (@ruleRefusalFraud, @ruleSMSnormal, @ruleRefusalDefault);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00010');
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES
  ('ISSUER', 'TestMerchant', 'NAME', 0, 0, @issuerId, NULL);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
