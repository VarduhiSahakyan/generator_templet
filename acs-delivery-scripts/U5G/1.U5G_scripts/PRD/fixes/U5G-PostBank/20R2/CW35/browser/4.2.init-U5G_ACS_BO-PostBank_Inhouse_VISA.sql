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
SET @issuerCode = '18500';
SET @createdBy ='A699391';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'Postbank EBK';
SET @subIssuerCode = '18501';
SET @sharedSubIssuerCode = '18500';
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);
SET @sharedSubIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @sharedSubIssuerCode);
/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id in (@subIssuerID, @sharedSubIssuerID)
	AND n.code in('VISA');
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id in (@subIssuerID, @sharedSubIssuerID)
	AND n.code in('MASTERCARD');
/*!40000 ALTER TABLE `Network_SubIssuer` ENABLE KEYS */;

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
    WHERE n.code in('VISA') AND si.fk_id_issuer = @issuerId and si.id in (@subIssuerID, @sharedSubIssuerID);
	
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
    WHERE n.code='MASTERCARD'  AND si.fk_id_issuer = @issuerId and si.id in (@subIssuerID, @sharedSubIssuerID);
	
/*!40000 ALTER TABLE `SubIssuerNetworkCrypto` ENABLE KEYS */;

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'Postbank EBK';
SET @BankUB = '18501_PB';
SET @BankUS = '18500_PB';

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_Shared_PB_01' and `fk_id_subIssuer` = @sharedSubIssuerID);

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
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4035940000', 16, TRUE, NULL, '4035940099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4035942000', 16, TRUE, NULL, '4035942999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4104031000', 16, TRUE, NULL, '4104031999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4644400000', 16, TRUE, NULL, '4644409999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4655950000', 16, TRUE, NULL, '4655959999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4655960000', 16, TRUE, NULL, '4655969999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907440100', 16, TRUE, NULL, '4907440199', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907441000', 16, TRUE, NULL, '4907441099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907442000', 16, TRUE, NULL, '4907442999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907443000', 16, TRUE, NULL, '4907443999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907444000', 16, TRUE, NULL, '4907444999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907445000', 16, TRUE, NULL, '4907445099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907446000', 16, TRUE, NULL, '4907446099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907446600', 16, TRUE, NULL, '4907446699', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907446700', 16, TRUE, NULL, '4907446799', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907447000', 16, TRUE, NULL, '4907447099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907447500', 16, TRUE, NULL, '4907447599', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907448000', 16, TRUE, NULL, '4907448999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4907449000', 16, TRUE, NULL, '4907449099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941160000', 16, TRUE, NULL, '4941160999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941161000', 16, TRUE, NULL, '4941161999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941162000', 16, TRUE, NULL, '4941162099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941163000', 16, TRUE, NULL, '4941163099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941164300', 16, TRUE, NULL, '4941164399', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941164600', 16, TRUE, NULL, '4941164699', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941165000', 16, TRUE, NULL, '4941165099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941166000', 16, TRUE, NULL, '4941166099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941166600', 16, TRUE, NULL, '4941166699', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941166700', 16, TRUE, NULL, '4941166799', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941167000', 16, TRUE, NULL, '4941167099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941167500', 16, TRUE, NULL, '4941167599', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941168000', 16, TRUE, NULL, '4941168099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941168500', 16, TRUE, NULL, '4941168599', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4941169000', 16, TRUE, NULL, '4941169099', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5415560000', 16, TRUE, NULL, '5415569999', FALSE, @ProfileSet, @MaestroMID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5415760000', 16, TRUE, NULL, '5415769999', FALSE, @ProfileSet, @MaestroMID, NULL);
   
/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4035940000' AND b.upperBound='4035940099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4035942000' AND b.upperBound='4035942999' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4104031000' AND b.upperBound='4104031999' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4644400000' AND b.upperBound='4644409999' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4655950000' AND b.upperBound='4655959999' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4655960000' AND b.upperBound='4655969999' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907440100' AND b.upperBound='4907440199' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907441000' AND b.upperBound='4907441099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907442000' AND b.upperBound='4907442999' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907443000' AND b.upperBound='4907443999' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907444000' AND b.upperBound='4907444999' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907445000' AND b.upperBound='4907445099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907446000' AND b.upperBound='4907446099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907446600' AND b.upperBound='4907446699' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907446700' AND b.upperBound='4907446799' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907447000' AND b.upperBound='4907447099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907447500' AND b.upperBound='4907447599' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907448000' AND b.upperBound='4907448999' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4907449000' AND b.upperBound='4907449099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941160000' AND b.upperBound='4941160999' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941161000' AND b.upperBound='4941161999' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941162000' AND b.upperBound='4941162099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941163000' AND b.upperBound='4941163099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941164300' AND b.upperBound='4941164399' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941164600' AND b.upperBound='4941164699' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941165000' AND b.upperBound='4941165099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941166000' AND b.upperBound='4941166099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941166600' AND b.upperBound='4941166699' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941166700' AND b.upperBound='4941166799' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941167000' AND b.upperBound='4941167099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941167500' AND b.upperBound='4941167599' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941168000' AND b.upperBound='4941168099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941168500' AND b.upperBound='4941168599' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='4941169000' AND b.upperBound='4941169099' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='5415560000' AND b.upperBound='5415569999' AND b.fk_id_profileSet=@ProfileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @sharedSubIssuerID
  FROM BinRange b 
  WHERE b.lowerBound='5415760000' AND b.upperBound='5415769999' AND b.fk_id_profileSet=@ProfileSet;

/* CustomItem */
/* Create custom items for default language and backup languages - in this example de */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;
SET @MaestroVID = NULL;
/* Elements for the profile DEFAULT_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_1_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankB, @MaestroVID, im.id, @customItemSetREFUSAL 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Wegen eines technischen Fehlers kann Ihr Einkauf nicht durchgeführt werden. Bitte versuchen Sie es zu einem späteren Zeitpunkt noch einmal.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, '<b>Abrechnungskonto</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '@pam', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, ' ', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, 'ALL', 'Schließen', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, 'ALL', 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetREFUSAL);

/* Elements for the profile SHARED_REFUSAL : */
SET @customItemSetPBSHRDRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUS,'_Shared_REFUSAL'));


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, @MaestroVID, `fk_id_image`, @customItemSetPBSHRDRefusal
  FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetREFUSAL;
  

/* Elements for the profile MISSING_AUTHENT_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_2_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'INFO';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankB, @MaestroVID, im.id, @customItemSetREFUSAL 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Dieser Einkauf kann nicht durchgeführt werden, weil Sie im Postbank Banking & Brokerage noch kein Sicherheitsverfahren hinterlegt haben.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte fügen Sie im Postbank Banking & Brokerage eines der Sicherheitsverfahren „mobileTAN“ oder „BestSign“ hinzu.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Weitere Informationen finden Sie unter www.postbank.de/3d_secure', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
         'de', 4, @currentPageType, '<b>Abrechnungskonto</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
         'de', 5, @currentPageType, '@pam', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Authentifizierung nicht möglich', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, '', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, 'ALL', 'Schließen', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, 'ALL', 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetREFUSAL);

/* Elements for the profile MEANS_CHOICE : */
SET @customItemSetUndefined = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_UNDEFINED'));
SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean = 'UNDEFINED';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankB, @MaestroVID, im.id, @customItemSetUndefined 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetUndefined
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetUndefined
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Bitte wählen Sie Ihr gewünschtes Sicherheitsverfahren aus.', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, '<b>Abrechnungskonto</b>', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '@pam', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung durchführen möchten.', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Zeitüberschreitung', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Die Transaktion wurde nicht in der vorgegebenen Zeit bestätigt. Bitte starten Sie den Bezahlungsprozess erneut.', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Wegen eines technischen Fehlers kann ihr Einkauf nicht durchgeführt werden. Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, 'ALL', 'Schließen', @MaestroVID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, 'ALL', 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetUndefined);

/* Elements for the profile SMS : */
SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'OTP_FORM_PAGE';
SET @Imageid = (SELECT `id` FROM `Image` im WHERE im.name = 'OTP_SMS_Logo' );
/* Here are the images for all pages associated to the SMS Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankB, @MaestroVID, im.id, @customItemSetSMS 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
/*in this case it will be sent from HUB*/

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Bitte bestätigen Sie Ihren Einkauf.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Dazu haben Sie eine mobileTAN angefordert.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Bitte geben Sie diese hier ein:', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
         'de', 4, @currentPageType, '<b>Abrechnungskonto</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
         'de', 5, @currentPageType, '@pam', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12, @currentPageType, 'Authentifizierung wird durchgeführt', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'de', 13, @currentPageType, 'Wir bitten Sie um einen Moment Geduld.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung durchführen möchten.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'de', 26, @currentPageType, 'Authentifizierung erfolgreich', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'de', 27, @currentPageType, 'Sie werden automatisch zum Händler weitergeleitet.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'de', 28, @currentPageType, 'Ungültige mobileTAN', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'de', 29, @currentPageType, 'Ihre Eingabe war nicht korrekt.\nBitte geben Sie die Ihnen zugesandte mobileTAN erneut ein.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Zeitüberschreitung', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Die Transaktion wurde nicht in der vorgegebenen Zeit bestätigt. Bitte starten Sie den Bezahlungsprozess erneut.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Wegen eines technischen Fehlers kann ihr Einkauf nicht durchgeführt werden. Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Fortsetzen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'de', 104, 'ALL', 'mobileTAN-Verfahren', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, 'ALL', 'Schließen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, 'ALL', 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the CHOICE page, for SMS Profile */
SET @currentPageType = 'CHOICE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Bitte wählen Sie Ihr gewünschtes Gerät aus.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, '<b>Abrechnungskonto</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '@pam', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung durchführen möchten.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Zeitüberschreitung', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Die Transaktion wurde nicht in der vorgegebenen Zeit bestätigt. Bitte starten Sie den Bezahlungsprozess erneut.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Wegen eines technischen Fehlers kann ihr Einkauf nicht durchgeführt werden. Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_36'), 'PUSHED_TO_CONFIG',
         'de', 36, @currentPageType, 'Authentifizierung wird durchgeführt', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_37'), 'PUSHED_TO_CONFIG',
         'de', 37, @currentPageType, 'Wir bitten Sie um einen Moment Geduld.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Fortsetzen', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Ihre Eingabe war nicht korrekt. Daher kann Ihr Einkauf aus Sicherheitsgründen nicht fortgesetzt werden. Bei einem weiteren Fehlversuch kommt es zu einer Sperrung.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Die Sperrung des Sicherheitsverfahrens kann im Postbank Banking & Brokerage aufgehoben werden. Alternativ können Sie uns einen unterschriebenen Auftrag zur Entsperrung per Brief, Fax oder E-Mail zusenden.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Abrechnungskonto</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
         'de', 4, @currentPageType, '@pam', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Authentifizierung fehlgeschlagen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, ' ', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the REFUSAL page, for SMS Profile */
/*
SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Wegen eines technischen Fehlers kann Ihr Einkauf nicht durchgeführt werden. Bitte versuchen Sie es zu einem späteren Zeitpunkt noch einmal.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, '<b>Abrechnungskonto :</b> @pam', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, ' ', @MaestroVID, NULL, @customItemSetSMS);
*/
/* Elements for SMS Choice Profile */
SET @customItemSetSMSChoice = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_SMS_Choice'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, @MaestroVID, `fk_id_image`, @customItemSetSMSChoice
  FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetSMS;
  
/* Elements for the MEANS page, for SMS Profile */
SET @currentPageType = 'MEANS_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, 'mobileTAN', @MaestroVID, NULL, @customItemSetSMS),

  ('I', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), @MaestroVID, @Imageid, @customItemSetSMS);

/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;

/* Elements for the profile BESTSIGN : */
SET @currentAuthentMean = 'MOBILE_APP_EXT';
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @currentPageType = 'POLLING_PAGE';
SET @Imageid = (SELECT `id` FROM `Image` im WHERE im.name = 'MOBILE_APP_Logo' );
/* Here are the images for all pages associated to the BESTSIGN Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankB, @MaestroVID, im.id, @customItemSetMobileApp 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileApp
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileApp
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the BESTSIGN will be */
/*in this case it will be sent from HUB*/

/* Elements for the OTP page, for BESTSIGN Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Bitte bestätigen Sie Ihren Einkauf.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Geben Sie dazu die Zahlung über BestSign frei.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Abrechnungskonto</b>', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
         'de', 4, @currentPageType, '@pam', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12, @currentPageType, 'Authentifizierung wird durchgeführt', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'de', 13, @currentPageType, 'Wir bitten Sie um einen Moment Geduld.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung durchführen möchten.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'de', 26, @currentPageType, 'Authentifizierung erfolgreich', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'de', 27, @currentPageType, 'Sie werden automatisch zum Händler weitergeleitet.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'de', 28, @currentPageType, 'Ungültige BestSign TAN', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'de', 29, @currentPageType, 'Sie haben eine ungültige BestSign TAN eingegeben. Nach der zweiten falschen TAN-Eingabe in Folge wird das Sicherheitsverfahren gesperrt. Bitte geben Sie die Ihnen zugesandte BestSign TAN erneut ein.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Zeitüberschreitung', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Die Transaktion wurde nicht in der vorgegebenen Zeit bestätigt. Bitte starten Sie den Bezahlungsprozess erneut.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Wegen eines technischen Fehlers kann ihr Einkauf nicht durchgeführt werden. Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'de', 104, 'ALL', 'BestSign-Verfahren', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, 'ALL', 'Schließen', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, 'ALL', 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetMobileApp);

/* Elements for the CHOICE page, for SMS Profile */
SET @currentPageType = 'CHOICE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Bitte wählen Sie Ihr gewünschtes Gerät aus.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, '<b>Abrechnungskonto</b>', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '@pam', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung durchführen möchten.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Zeitüberschreitung', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Die Transaktion wurde nicht in der vorgegebenen Zeit bestätigt. Bitte starten Sie den Bezahlungsprozess erneut.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Wegen eines technischen Fehlers kann ihr Einkauf nicht durchgeführt werden. Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_36'), 'PUSHED_TO_CONFIG',
         'de', 36, @currentPageType, 'Authentifizierung wird durchgeführt', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_37'), 'PUSHED_TO_CONFIG',
         'de', 37, @currentPageType, 'Wir bitten Sie um einen Moment Geduld.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Fortsetzen', @MaestroVID, NULL, @customItemSetMobileApp);

/* Elements for the FAILURE page, for BESTSIGN Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Ihre Eingabe war nicht korrekt. Daher kann Ihr Einkauf aus Sicherheitsgründen nicht fortgesetzt werden. Bei einem weiteren Fehlversuch kommt es zu einer Sperrung.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bei BestSign ist eine Entsperrung nicht möglich. Bitte löschen Sie daher im Falle einer Sperrung das Sicherheitsverfahren in der App und im Postbank Banking & Brokerage und richten es anschließend neu ein.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Abrechnungskonto</b>', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
         'de', 4, @currentPageType, '@pam', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Authentifizierung fehlgeschlagen', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, ' ', @MaestroVID, NULL, @customItemSetMobileApp);

/* Elements for the REFUSAL page, for BESTSIGN Profile */
/*SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Wegen eines technischen Fehlers kann Ihr Einkauf nicht durchgeführt werden. Bitte versuchen Sie es zu einem späteren Zeitpunkt noch einmal.', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, '<b>Abrechnungskonto :</b> @pam', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, ' ', @MaestroVID, NULL, @customItemSetMobileApp);
*/
/* Elements for MOBILE Choice Profile */
SET @customItemSetMobileAppChoice = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_MOBILE_APP_Choice'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, @MaestroVID, `fk_id_image`, @customItemSetMobileAppChoice
  FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetMobileApp;
  
/* Elements for the MEANS page, for MOBILE Profile */
SET @currentPageType = 'MEANS_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, 'BestSign', @MaestroVID, NULL, @customItemSetMobileApp),

  ('I', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), @MaestroVID, @Imageid, @customItemSetMobileApp);

/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;

/* Elements for the profile LOGIN : */
SET @currentAuthentMean = 'EXT_LOGIN';
SET @customItemSetLogin = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_LOGIN'));
SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the LOGIN Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankB, @MaestroVID, im.id, @customItemSetLogin 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetLogin
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetLogin
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the LOGIN will be */
/*in this case it will be sent from HUB*/

/* Elements for the OTP page, for LOGIN Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Damit Sie noch sicherer mit Ihrer Kreditkarte zahlen, haben wir eine zusätzliche Abfrage eingefügt. Bitte geben Sie das Passwort zu Ihrer Postbank-ID ein.', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Passwort zur Postbank-ID', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Abrechnungskonto</b>', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
         'de', 4, @currentPageType, '@pam', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12, @currentPageType, 'Authentifizierung wird durchgeführt', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'de', 13, @currentPageType, 'Wir bitten Sie um einen Moment Geduld.', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung durchführen möchten.', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'de', 26, @currentPageType, 'Authentifizierung wird fortgesetzt', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'de', 27, @currentPageType, ' ', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'de', 28, @currentPageType, 'Ungültiges Passwort', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'de', 29, @currentPageType, 'Ihre Eingabe war nicht korrekt. Nach 3 Fehleingaben wird Ihre Postbank-ID vorläufig gesperrt. Nutzen Sie in diesem Fall die Funktion "Zugangsdaten vergessen?" auf der Startseite des Online-Bankings und wählen Sie auf der Folgeseite aus, dass Sie Ihr Passwort vergessen haben. Alternativ können Sie uns einen unterschriebenen Auftrag zur Entsperrung zusenden.', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Zeitüberschreitung', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Die Transaktion wurde nicht in der vorgegebenen Zeit bestätigt. Bitte starten Sie den Bezahlungsprozess erneut.', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Wegen eines technischen Fehlers kann ihr Einkauf nicht durchgeführt werden. Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @MaestroVID, NULL, @customItemSetLogin),

  /*('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
         'de', 10, @currentPageType, 'Freigabe über PIN zum Abrechnungskonto', @MaestroVID, NULL, @customItemSetLogin),*/

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Fortsetzen', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, 'ALL', 'Schließen', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, 'ALL', 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetLogin);

/* Elements for the MEANS page, for PASSWORD Profile */
/*SET @currentPageType = 'MEANS_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, 'Freigabe über Passwort zur Postbank-ID', @MaestroVID, NULL, @customItemSetLogin);
*/
/* Elements for the HELP page, for PASSWORD Profile */
SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  /*('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @helpPage, 'Geben Sie bitte hier das Passwort zu Ihrer Postbank-ID ein.', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @helpPage, 'Sie können die Zahlung auch mit Ihrer Online-PIN zum Konto freigeben. Klicken Sie dazu auf den Button unten links.', @MaestroVID, NULL, @customItemSetLogin),*/
  
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @helpPage, 'Mehr zum Sicherheitscheck unter www.postbank.de/3d_secure', @MaestroVID, NULL, @customItemSetLogin);
		 
/* Elements for the FAILURE page, for LOGIN Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Ihre Eingabe war nicht korrekt. Aus Sicherheitsgründen kann Ihr Einkauf nicht fortgesetzt werden.', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Nach 3 Fehleingaben wird Ihre Postbank-ID vorläufig gesperrt. Nutzen Sie in diesem Fall die Funktion "Zugangsdaten vergessen?" auf der Startseite des Online-Bankings und wählen Sie auf der Folgeseite aus, dass Sie Ihr Passwort vergessen haben. Alternativ können Sie uns einen unterschriebenen Auftrag zur Entsperrung zusenden.', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Abrechnungskonto</b>', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
         'de', 4, @currentPageType, '@pam', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Authentifizierung fehlgeschlagen', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, ' ', @MaestroVID, NULL, @customItemSetLogin);

/* Elements for the REFUSAL page, for LOGIN Profile */
/*SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Wegen eines technischen Fehlers kann Ihr Einkauf nicht durchgeführt werden. Bitte versuchen Sie es zu einem späteren Zeitpunkt noch einmal.', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, '<b>Abrechnungskonto :</b> @pam', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetLogin),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, ' ', @MaestroVID, NULL, @customItemSetLogin);
*/

/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;
/* Elements for the profile PASSWORD : *//*
SET @currentAuthentMean = 'EXT_PASSWORD';
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'));
SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the PASSWORD Profile */
/*
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankB, @MaestroVID, im.id, @customItemSetPassword 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetPassword
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetPassword
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the PASSWORD will be */
/*in this case it will be sent from HUB*/

/* Elements for the OTP page, for PASSWORD Profile */
/*
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Damit Sie noch sicherer mit Ihrer Kreditkarte zahlen, haben wir eine zusätzliche Abfrage eingefügt. Bitte geben Sie das Passwort zu Ihrer Postbank-ID ein.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Online-PIN zum Abrechnungskonto', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Abrechnungskonto :</b> @pam', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12, @currentPageType, 'Authentifizierung wird durchgeführt', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'de', 13, @currentPageType, 'Wir bitten Sie um einen Moment Geduld.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung durchführen möchten.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'de', 26, @currentPageType, 'Authentifizierung wird fortgesetzt', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'de', 27, @currentPageType, 'Sie werden automatisch zur nächsten Seite weitergeleitet.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'de', 28, @currentPageType, 'Ungültige Online-PIN', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'de', 29, @currentPageType, 'Ihre Eingabe war nicht korrekt. Beachten Sie bitte: Nach insgesamt 3 Fehlversuchen ist Ihr Zugang zum Postbank Banking & Brokerage gesperrt. Sie können die Entsperrung telefonisch unter (0228) 5500 5500 veranlassen. Bitte halten Sie dazu Ihre Telefon-PIN bereit.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Zeitüberschreitung', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Die Transaktion wurde nicht in der vorgegebenen Zeit bestätigt. Bitte starten Sie den Bezahlungsprozess erneut.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Wegen eines technischen Fehlers kann ihr Einkauf nicht durchgeführt werden. Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @MaestroVID, NULL, @customItemSetPassword),

  /*('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
         'de', 10, @currentPageType, 'Freigabe über Passwort zur Postbank-ID', @MaestroVID, NULL, @customItemSetPassword),*/
/*
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Fortsetzen', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, 'ALL', 'Schließen', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, 'ALL', 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetPassword);

/* Elements for the MEANS page, for PASSWORD Profile */
/*SET @currentPageType = 'MEANS_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, 'Freigabe über PIN zum Abrechnungskonto', @MaestroVID, NULL, @customItemSetPassword);
*/
/* Elements for the HELP page, for PASSWORD Profile *//*
SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @helpPage, 'Geben Sie bitte hier die Online-PIN zum Abrechnungskonto ein.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @helpPage, 'Sie können die Zahlung auch mit Ihrem Passwort zur Postbank-ID freigeben. Klicken Sie dazu auf den Button unten links.', @MaestroVID, NULL, @customItemSetPassword),
  
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @helpPage, 'Mehr zum Sicherheitscheck unter www.postbank.de/3d_secure', @MaestroVID, NULL, @customItemSetPassword);
		 
/* Elements for the FAILURE page, for PASSWORD Profile *//*
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Ihre Eingabe war nicht korrekt. Aus Sicherheitsgründen kann Ihr Einkauf nicht fortgesetzt werden. Sie werden zu den Seiten Ihres Händlers zurückgeleitet. Bei einem weiteren Fehlversuch kommt es zu einer vorläufigen Sperrung Ihrer Postbank-ID.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Melden Sie sich bitte im Online-Banking an, um den Zugang wieder freizuschalten. Alternativ können Sie uns einen unterschriebenen Auftrag zur Entsperrung per Brief, Fax oder E-Mail zusenden.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Abrechnungskonto :</b> @pam', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Authentifizierung fehlgeschlagen', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, ' ', @MaestroVID, NULL, @customItemSetPassword);

/* Elements for the REFUSAL page, for PASSWORD Profile */
/*
SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, 'Wegen eines technischen Fehlers kann Ihr Einkauf nicht durchgeführt werden. Bitte versuchen Sie es zu einem späteren Zeitpunkt noch einmal.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, '<b>Abrechnungskonto :</b> @pam', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, ' ', @MaestroVID, NULL, @customItemSetPassword);

/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;
