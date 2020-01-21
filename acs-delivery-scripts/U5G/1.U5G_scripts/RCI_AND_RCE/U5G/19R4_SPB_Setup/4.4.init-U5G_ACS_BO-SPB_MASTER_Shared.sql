/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

SET @createdBy ='A758582';
SET @issuerCode = '16950';
/* SubIssuer */
SET @subIssuerNameAndLabel = 'sharedBIN';
SET @subIssuerCode = '99999';

SET @BankB = 'SPB_sharedBIN';
SET @BankUB = 'SPB_sharedBIN';

SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
SET @profileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01') and `fk_id_subIssuer` = @subIssuerID);

SET @NetworkCode = 'MASTERCARD';
SET @NetworkID = (SELECT `id` FROM `Network` WHERE `code` = @NetworkCode);
SET @NetworkName = (SELECT `name` FROM `Network` WHERE `code` = @NetworkCode);

SET @NetworkCustomItemName = 'Mastercard Logo';
SET @NetworkCustomItemValue = 'se_MasterCard SecureCode™';
SET @NetworkImageNameLike = '%MC_ID_LOGO%';
SET @NetworkImageCodeLike = '%MASTERCARD%';

/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id in (@subIssuerID)
	AND n.code in(@NetworkCode);
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
  SELECT 'MIIEgDCCA2igAwIBAgIQQ3EBfDozHhKp3pmzcHr6ZzANBgkqhkiG9w0BAQUFADCBgDELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFE1hc3RlckNhcmQgV29ybGR3aWRlMS4wLAYDVQQLEyVNYXN0ZXJDYXJkIFdvcmxkd2lkZSBTZWN1cmVDb2RlIEdlbiAyMSIwIAYDVQQDExlQUkQgTUMgU2VjdXJlQ29kZSBSb290IENBMB4XDTEyMDYyMjA5MjIxNFoXDTI1MDYyMTA5MjIxNVowgYYxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEoMCYGA1UEAxMfUFJEIE1DIFNlY3VyZUNvZGUgSXNzdWVyIFN1YiBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANaeBgfjTKIFls7ueMTzI2nYwAbocHwkQqd8BsIyJbZdk21E+vyq9EhX1NIoiAhP7fl+y/hosX66drjfrbyspZLalrVG6gYbdB2j2Sr8zBRQnMZKKluDwYv/266nnRBeyGYW3FwyVu8L1ACYQc04ACke+07NI/AZ8OXQSoeboEEGUO520/76o1cER5Ok9HRi0jJD8E64j8dEt36Mcg0JaKQiDjShlyTw4ABYyzZ1Vxl0/iDrfwboxNEOOooC0rcGNnCpISXMWn2NmZH1QxiFt2jIZ8QzF3/z+M3iYradh9uZauleNqJ9LPKr/aFFDbe0Bv0PLbvXOnFpwOxvJODWUj8CAwEAAaOB7TCB6jAPBgNVHRMECDAGAQH/AgEAMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUwTArnR3hR1+Ij1uxMtqoPBm2j7swgacGA1UdIwSBnzCBnKGBhqSBgzCBgDELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFE1hc3RlckNhcmQgV29ybGR3aWRlMS4wLAYDVQQLEyVNYXN0ZXJDYXJkIFdvcmxkd2lkZSBTZWN1cmVDb2RlIEdlbiAyMSIwIAYDVQQDExlQUkQgTUMgU2VjdXJlQ29kZSBSb290IENBghEA7qGSrpcB0q8DkgwCPcT3kzANBgkqhkiG9w0BAQUFAAOCAQEA3lJuYVdiy11ELUfBfLuib4gPTbkDdVLBEKosx0yUDczeXoTUOjBEc90f5KRjbpe4pilOGAQnPNUGpi3ZClS+0ysTBp6RdYz1efNLSuaTJtpJpoCOk1/nw6W+nJEWyDXUcC/yVqstZidcOG6AMfKU4EC5zBNELZCGf1ynM2l+gwvkcDUv4Y2et/n/NqIKBzywGSOktojTma0kHbkAe6pj6i65TpwEgEpywVl50oMmNKvXDNMznrAG6S9us+OHDjonOlmmyWmQxXdU1MzwdKzPjHfwl+Z6kByDXruHjEcNsx7P2rUTm/Bt3SWW1K48VfNNhVa/WctTZGJCrV3Zjl6A9g==',
    NULL, 'MASTERCARD_SPA', '241122334455554341465F4D5554555F414300', 'STRING_TIMESTAMP', 'ED11223344554B544F525F4D5554555F414310',
    'MIIDzzCCAregAwIBAgIRAO6hkq6XAdKvA5IMAj3E95MwDQYJKoZIhvcNAQEFBQAwgYAxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEiMCAGA1UEAxMZUFJEIE1DIFNlY3VyZUNvZGUgUm9vdCBDQTAeFw0xMjA2MjIwOTA4MzBaFw0yNTA2MjIwOTA4MzFaMIGAMQswCQYDVQQGEwJVUzEdMBsGA1UEChMUTWFzdGVyQ2FyZCBXb3JsZHdpZGUxLjAsBgNVBAsTJU1hc3RlckNhcmQgV29ybGR3aWRlIFNlY3VyZUNvZGUgR2VuIDIxIjAgBgNVBAMTGVBSRCBNQyBTZWN1cmVDb2RlIFJvb3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDptCms6aI22T9ST60k487SZP06TKbUBpom7Z1Bo8cQQAE/tM5UOt3THMdrhT+2aIkj9T0pA35IyNMCNGDt+ejhy7tHdw1r6eDX/KXYHb4FlemY03DwRrkQSH/L+ZueS5dCfLM3m2azxBXtrVXDdNebfht8tcWRLK2Ou6vjDzdIzunuWRZ6kRDQ6oc1LSVO2BxiFO0TKowJP/M7qWRT/Jsmb6TGg0vmmQG9QEpmVmOZIexVxuYy3rn7gEbV1tv3k4aG0USMp2Xq/Xe4qe+Ir7sFqR56G4yKezSVLUzQaIB/deeCk9WU2T0XmicAEYDBQoecoS61R4nj5ODmzwmGyxrlAgMBAAGjQjBAMA8GA1UdEwQIMAYBAf8CAQEwDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQqFTcxVDO/uxI1hpFF3VSSTFMGujANBgkqhkiG9w0BAQUFAAOCAQEAhDOQ5zUX2wByVv0Cqka3ebnm/6xRzQQbWelzneDUNVdctn1nhJt2PK1uGV7RBGAGukgdAubwwnBhD2FdbhBHTVbpLPYxBbdMAyeC8ezaXGirXOAAv0YbGhPl1MUFiDmqSliavBFUs4cEuBIas4BUoZ5Fz042dDSAWffbdf3l4zrU5Lzol93yXxxIjqgIsT3QI+sRM3gg/Gdwo80DUQ2fRffsGdAUH2C/8L8/wH+E9HspjMDkXlZohPII0xtKhdIPWzbOB6DOULl2PkdGHmJc4VXxfOwE2NJAQxmoaPRDYGgOFVvkzYtyxVkxXeXAPNt8URR3jfWvYrBGH2D5A44Atg==',
    NULL, 'MIIEgDCCA2igAwIBAgIRANPdOMI3PRuQ2QrYW3TiHIAwDQYJKoZIhvcNAQEFBQAwgYYxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEoMCYGA1UEAxMfUFJEIE1DIFNlY3VyZUNvZGUgSXNzdWVyIFN1YiBDQTAeFw0xNzA3MjgxMTMyNTBaFw0yMTA3MjcxMTI5NDRaMHkxCzAJBgNVBAYTAkZSMR0wGwYDVQQKExRDUkVESVQgQUdSSUNPTEUgUy5BLjEnMCUGA1UECxMeQVRPUyBXb3JsZExpbmUgV0xQIC0gSUNBIDEyNjUzMSIwIAYDVQQDExlXTFAtQUNTIENBU0EgU2lnbmF0dXJlIE1DMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuO0yGOwsu/icuH+OPbAaSWWTUL+oePoapJ6bNZd41g8dG9fKOgRzHW+dMIrkKeXKHHQvrvU6JNJoPFWAGxeOa4D0vsp1AZKOWiWlsss6kLn0fDj7nwDErCHJNJWi3TmmSL8s8ujOrRsveZhoDtLDp1E/Q+PoG3uoI4PcH3DqlF/8IfY/0z9F9avb+uCFvOXoh6dV5LRe2mYY62KiJHvdaAPlGwPnFPgLtJafgv9RVVGyxXhxZSM1R6hX2pP28219BlDQEbQtkqHJI/3/NW5x9HjddXpbtqKt29NXfmTJym6pfZrWTXn2qXuXokPcR5TE3EWz3zGsNSkltOc0ADANsQIDAQABo4H0MIHxMCsGA1UdEAQkMCKADzIwMTcwNzI4MTEzMjUwWoEPMjAyMDA3MjcxMTMyNTBaMA4GA1UdDwEB/wQEAwIHgDAJBgNVHRMEAjAAMIGmBgNVHSMEgZ4wgZuhgYakgYMwgYAxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEiMCAGA1UEAxMZUFJEIE1DIFNlY3VyZUNvZGUgUm9vdCBDQYIQQ3EBfDozHhKp3pmzcHr6ZzANBgkqhkiG9w0BAQUFAAOCAQEAb72VYXYGFGeuoxjrq2vDduEp6gHii2SwWaf3D/wuybihroryJVMW9AX3SG8IVHEINqtqg/dTgo8TfJnJ0QEiGN0TlmFHzSptil6lBAlSnHjrEsIBG52bLKtGwCrE7Hzfx8fqW5XmlyrDJK7MaaIrFe5GPMXBLL7+nazbpemy06+9RvyDLisgxx8DPRkdZdfoQfKTH5sWUtr2VMA5NtMQAtHjMhQOFuOpfbwNz4iC/jHDM6/Zs4D4zcVFKQwS4ngtf5q4dwOdQ6nYdpreWcgbmzuH7PIRQWsO4sWpzWlwknWKeU/r2iOaRndxAmxmR3oJVFYHqD/6fy0NDoBwIrdrjA==',
    NULL, n.id, si.id
    FROM Network n, SubIssuer si
    WHERE n.code in(@NetworkCode) AND si.fk_id_issuer = @issuerId and si.id in (@subIssuerID);

/*!40000 ALTER TABLE `SubIssuerNetworkCrypto` ENABLE KEYS */;


/* BinRange */
/* In this table, in the case of co-branding the primary network will be present as a foreign key (fk_id_network) and
   the 'alternative' network will be present through the field 'coBrandedCardNetwork' which contains a string that matches
   the field 'code' of the Network (it plays the same role as a foreign key, because the code is unique for each Network)
*/

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5232790000', 16, TRUE, NULL, '5232799999', FALSE, @profileSet, @NetworkID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5247210000', 16, TRUE, NULL, '5247219999', FALSE, @profileSet, @NetworkID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5256150000', 16, TRUE, NULL, '5256159999', FALSE, @profileSet, @NetworkID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @subIssuerID
  FROM BinRange b
  WHERE b.lowerBound='5232790000' AND b.upperBound='5232799999' AND b.fk_id_profileSet=@profileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @subIssuerID
  FROM BinRange b
  WHERE b.lowerBound='5247210000' AND b.upperBound='5247219999' AND b.fk_id_profileSet=@profileSet;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @subIssuerID
  FROM BinRange b
  WHERE b.lowerBound='5256150000' AND b.upperBound='5256159999' AND b.fk_id_profileSet=@profileSet;

/* CustomItem */
/* Create custom items for default language and backup languages - in this example de */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;
/* Elements for the profile DEFAULT_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, @BankB, @NetworkID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @NetworkCustomItemName, 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, @NetworkCustomItemValue, n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE @NetworkImageNameLike AND n.code LIKE @NetworkImageCodeLike;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Eine Freigabe der Zahlung ist nicht möglich</b>', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Eine Freigabe der Zahlung durch das Online-Banking ist nicht möglich.', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Der Vorgang konnte nicht durchgeführt werden.', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, 'Bitte aktivieren Sie Ihre Kreditkarte im Online Banking oder wenden Sie sich an den Berater in Ihrer Filiale.', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetREFUSAL);


/* Elements for the profile _TE_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_TE_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, @BankB, @NetworkID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @NetworkCustomItemName, 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, @NetworkCustomItemValue, n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE @NetworkImageNameLike AND n.code LIKE @NetworkImageCodeLike;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Eine Freigabe der Zahlung ist nicht möglich</b>', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Eine Freigabe der Zahlung durch das Online-Banking ist nicht möglich.', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Der Vorgang konnte nicht durchgeführt werden.', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, 'Bitte aktivieren Sie Ihre Kreditkarte im Online Banking oder wenden Sie sich an den Berater in Ihrer Filiale.', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetREFUSAL);


/* Elements for the profile _FE_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_FE_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, @BankB, @NetworkID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @NetworkCustomItemName, 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, @NetworkCustomItemValue, n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE @NetworkImageNameLike AND n.code LIKE @NetworkImageCodeLike;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Eine Freigabe der Zahlung ist nicht möglich</b>', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Der Einkauf kann leider nicht fortgesetzt werden. Bitte wenden Sie sich an die kontoführende Filiale Ihrer Sparda-Bank.', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Der Vorgang konnte nicht durchgeführt werden.', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, 'Bitte aktivieren Sie Ihre Kreditkarte im Online Banking oder wenden Sie sich an den Berater in Ihrer Filiale.', @NetworkID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetREFUSAL);


/* Elements for the profile SMS : */
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the SMS Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankB, @NetworkID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @NetworkCustomItemName, 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', @NetworkCustomItemValue, n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE @NetworkImageNameLike AND n.code LIKE @NetworkImageCodeLike;

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'de', 0, 'MESSAGE_BODY',
        'Die mobileTAN für Ihren Einkauf mit Kreditkarte @maskedPan am @formattedDate bei @merchant über @amount lautet:
@otp Ihre Sparda Bank', @NetworkID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 2: Eingabe mobileTAN</b>', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte geben Sie die TAN ein, die per SMS an die unten aufgeführte Mobilfunknummer gesendet wurde.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>TAN* :</b>', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12, @currentPageType, 'Authentifizierung läuft', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung durchführen möchten.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'de', 26, @currentPageType, 'Authentifizierung erfolgreich.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'de', 27, @currentPageType, 'Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'de', 28, @currentPageType, 'Fehlerhafte TAN', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'de', 29, @currentPageType, 'Diese TAN-Nummer ist ungültig. Bitte ändern Sie Ihre Eingabe.Die Anzahl der Ihnen verbleibenden Versuche lautet: <remaining tries>', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Die Session ist abgelaufen.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung durchführen  möchten.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Technischer Fehler.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten, Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
         'de', 34, @currentPageType, 'SMS wird versendet.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
         'de', 35, @currentPageType, 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie ein neues Einmalpasswort.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Senden', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Shop', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'de', 104, 'ALL', 'Mobilfunknummer', @NetworkID, NULL, @customItemSetSMS);


SET @Imageid = (SELECT `id` FROM `Image` im WHERE im.name LIKE CONCAT('%','OTP_SMS_Logo','%'));
/* Elements for the MEANS page, for SMS Profile */
SET @currentPageType = 'MEANS_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 2: Auswahl TAN-Verfahren</b>', @NetworkID, NULL, @customItemSetSMS),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte wählen Sie eines der möglichen TAN-Verfahren aus.', @NetworkID, NULL, @customItemSetSMS),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Auswahl TAN-Verfahren*: </b>', @NetworkID, NULL, @customItemSetSMS),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, 'SMS', @NetworkID, NULL, @customItemSetSMS),
  ('I', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), @NetworkID, @Imageid, @customItemSetSMS),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetSMS),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Senden', @NetworkID, NULL, @customItemSetSMS);

/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Eine Freigabe der Zahlung ist nicht möglich.</b>', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Die Anmeldung ist fehlgeschlagen. Bitte versuchen Sie es erneut mit gültigen Anmeldedaten.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Maximale Anzahl der Fehlversuche erreicht.', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, 'Die Transaktion wurde abgebrochen, die Zahlung nicht durchgeführt.', @NetworkID, NULL, @customItemSetSMS),

   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Shop', @NetworkID, NULL, @customItemSetSMS);

/* Elements for the REFUSAL page, for SMS Profile */
SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Hinweise zur Anmeldung</b>', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte geben Sie die zu der angezeigten Kundennummer passende Online-PIN Ihres SpardaOnline-Bankings ein. Um fortzufahren, bestätigen Sie die Eingabe mit "Senden". Um die Freigabe der Zahlung abzubrechen, klicken Sie auf "Abbrechen". ', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Aus Sicherheitsgründen zeigen wir sowohl die Kartennummer als auch die Kundennummer nur maskiert an."', @NetworkID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetSMS);

/* Elements for the profile PASSWORD : */
SET @currentAuthentMean = 'EXT_PASSWORD';
SET @customItemSetPASSWORD = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'));
SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the PASSWORD Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankB, @NetworkID, im.id, @customItemSetPASSWORD
     FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @NetworkCustomItemName, 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', @NetworkCustomItemValue, n.id, im.id, @customItemSetPASSWORD
  FROM `Image` im, `Network` n WHERE im.name LIKE @NetworkImageNameLike AND n.code LIKE @NetworkImageCodeLike;

/* Here is what the content of the PASSWORD will be */
/*in this case it will be sent from HUB*/

/* Elements for the OTP page, for PASSWORD Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 1: Eingabe Online-Banking-PIN</b>', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte geben Sie Ihre PIN für das SpardaOnline-Banking zur dargestellten Kundenummer ein, um den Bezahlvorgang zu bestätigen.', @NetworkID, NULL, @customItemSetPASSWORD),

   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Kundennummer:</b>', @NetworkID, NULL, @customItemSetPASSWORD),

   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
         'de', 4, @currentPageType, '<b>Online-PIN*:</b>', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12, @currentPageType, 'Authentifizierung läuft.', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen.', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'de', 28, @currentPageType, '<h3>Falsche Online-PIN</h3>', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'de', 29, @currentPageType, 'Die Anmeldung ist fehlgeschlagen. Bitte versuchen Sie es erneut mit einer gültigen Online-PIN.
Die Anzahl der Ihnen verbleibenden Versuche lautet: <remaining tries>
', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Die Session ist abgelaufen.', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Technischer Fehler.', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Senden', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Shop', @NetworkID, NULL, @customItemSetPASSWORD);

/* Elements for the FAILURE page, for PASSWORD Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Eine Freigabe der Zahlung ist nicht möglich.</b>', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Die Anmeldung ist fehlgeschlagen. Bitte versuchen Sie es erneut mit gültigen Anmeldedaten.', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Maximale Anzahl der Fehlversuche erreicht.', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, 'Die Transaktion wurde abgebrochen, die Zahlung nicht durchgeführt.', @NetworkID, NULL, @customItemSetPASSWORD),

   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetPASSWORD);


/* Elements for the REFUSAL page, for PASSWORD Profile */
SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Hinweise zur Anmeldung</b>', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte geben Sie die zu der angezeigten Kundennummer passende Online-PIN Ihres SpardaOnline-Bankings ein. Um fortzufahren, bestätigen Sie die Eingabe mit "Senden". Um die Freigabe der Zahlung abzubrechen, klicken Sie auf "Abbrechen". ', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Aus Sicherheitsgründen zeigen wir sowohl die Kartennummer als auch die Kundennummer nur maskiert an."', @NetworkID, NULL, @customItemSetPASSWORD),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetPASSWORD);

/* Elements for the profile APP : */
SET @currentAuthentMean = 'MOBILE_APP_EXT';
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));
SET @currentPageType = 'POLLING_PAGE';
/* Here are the images for all pages associated to the APP Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankB, @NetworkID, im.id, @customItemSetMobileApp
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @NetworkCustomItemName, 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', @NetworkCustomItemValue, n.id, im.id, @customItemSetMobileApp
  FROM `Image` im, `Network` n WHERE im.name LIKE @NetworkImageNameLike AND n.code LIKE @NetworkImageCodeLike;

/* Here is what the content of the APP will be */
/*in this case it will be sent from HUB*/

/* Elements for the OTP page, for APP Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 2: Freigabe per SpardaSecureApp</b>', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte geben Sie den Auftrag in der SpardaSecureApp frei.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Hinweis :</b>', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
         'de', 4, @currentPageType, 'Sie können die Zahlungsfreigabe in der SpardaSecureApp auch ablehnen.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12, @currentPageType, 'Authentifizierung läuft', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'de', 26, @currentPageType, 'Authentifizierung erfolgreich', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'de', 27, @currentPageType, 'Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'de', 28, @currentPageType, 'Ungültige BestSign TAN', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'de', 29, @currentPageType, 'Sie haben eine ungültige BestSign TAN eingegeben. Nach der zweiten falschen TAN-Eingabe in Folge wird das Sicherheitsverfahren gesperrt. Bitte geben Sie die Ihnen zugesandte BestSign TAN erneut ein.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Die Session ist abgelaufen.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Technischer Fehler', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Shop', @NetworkID, NULL, @customItemSetMobileApp);

/* Elements for the CHOICE page, for APP Profile */
SET @currentPageType = 'CHOICE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 2: Geräteauswahl</b>', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte wählen Sie das Gerät aus, mit dem Sie diesen Auftrag bestätigen wollen.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Senden', @NetworkID, NULL, @customItemSetMobileApp);

/* Elements for the FAILURE page, for APP Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Eine Freigabe der Zahlung ist nicht möglich.</b>', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Die Anmeldung ist fehlgeschlagen. Bitte versuchen Sie es erneut mit gültigen Anmeldedaten.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Authentifizierung fehlgeschlagen', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, '', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetMobileApp);

/* Elements for the REFUSAL page, for APP Profile */
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Eine Freigabe der Zahlung ist nicht möglich</b>', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Eine Freigabe der Zahlung durch das Online-Banking ist nicht möglich.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Der Vorgang konnte nicht durchgeführt werden.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, 'Bitte aktivieren Sie Ihre Kreditkarte im Online Banking oder wenden Sie sich an den Berater in Ihrer Filiale.', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Shop', @NetworkID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetMobileApp);

SET @Imageid = (SELECT `id` FROM `Image` im WHERE im.name LIKE CONCAT('%','MOBILE_APP_Logo','%'));
SET @currentPageType = 'MEANS_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 2: Auswahl TAN-Verfahren</b>', @NetworkID, NULL, @customItemSetMobileApp),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte wählen Sie eines der möglichen TAN-Verfahren aus.', @NetworkID, NULL, @customItemSetMobileApp),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Auswahl TAN-Verfahren*: </b>', @NetworkID, NULL, @customItemSetMobileApp),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, 'SMS', @NetworkID, NULL, @customItemSetMobileApp),
  ('I', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), @NetworkID, @Imageid, @customItemSetMobileApp),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetMobileApp),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Senden', @NetworkID, NULL, @customItemSetMobileApp);

/* Elements for the CHOICE page, for CHOICE ALL Profile */
SET @customItemSetCHOICEALL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_CHOICE_ALL'));
SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean = 'UNDEFINED';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, @BankB, @NetworkID, im.id, @customItemSetCHOICEALL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @NetworkCustomItemName, 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, @NetworkCustomItemValue, n.id, im.id, @customItemSetCHOICEALL
  FROM `Image` im, `Network` n WHERE im.name LIKE @NetworkImageNameLike AND n.code LIKE @NetworkImageCodeLike;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 2: Auswahl TAN-Verfahren</b>', @NetworkID, NULL, @customItemSetCHOICEALL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte wählen Sie eines der möglichen TAN-Verfahren aus.', @NetworkID, NULL, @customItemSetCHOICEALL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Auswahl TAN-Verfahren*: </b>', @NetworkID, NULL, @customItemSetCHOICEALL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetCHOICEALL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Senden', @NetworkID, NULL, @customItemSetCHOICEALL);


/* Elements for the CHOICE page, for CHOICE_SMS_CHIP Profile */
SET @customItemSetCHOICE_SMS_CHIP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS_CHIP'));
SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean = 'UNDEFINED';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, @BankB, @NetworkID, im.id, @customItemSetCHOICE_SMS_CHIP
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @NetworkCustomItemName, 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, @NetworkCustomItemValue, n.id, im.id, @customItemSetCHOICE_SMS_CHIP
  FROM `Image` im, `Network` n WHERE im.name LIKE @NetworkImageNameLike AND n.code LIKE @NetworkImageCodeLike;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 2: Auswahl TAN-Verfahren</b>', @NetworkID, NULL, @customItemSetCHOICE_SMS_CHIP),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte wählen Sie eines der möglichen TAN-Verfahren aus.', @NetworkID, NULL, @customItemSetCHOICE_SMS_CHIP),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Auswahl TAN-Verfahren*: </b>', @NetworkID, NULL, @customItemSetCHOICE_SMS_CHIP),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetCHOICE_SMS_CHIP),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Senden', @NetworkID, NULL, @customItemSetCHOICE_SMS_CHIP);


/* Elements for the CHOICE page, for CHOICE_CHIP_APP Profile */
SET @customItemSetCHOICE_CHIP_APP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_CHIP_APP'));
SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean = 'UNDEFINED';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, @BankB, @NetworkID, im.id, @customItemSetCHOICE_CHIP_APP
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @NetworkCustomItemName, 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, @NetworkCustomItemValue, n.id, im.id, @customItemSetCHOICE_CHIP_APP
  FROM `Image` im, `Network` n WHERE im.name LIKE @NetworkImageNameLike AND n.code LIKE @NetworkImageCodeLike;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 2: Auswahl TAN-Verfahren</b>', @NetworkID, NULL, @customItemSetCHOICE_CHIP_APP),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte wählen Sie eines der möglichen TAN-Verfahren aus.', @NetworkID, NULL, @customItemSetCHOICE_CHIP_APP),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Auswahl TAN-Verfahren*: </b>', @NetworkID, NULL, @customItemSetCHOICE_CHIP_APP),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetCHOICE_CHIP_APP),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Senden', @NetworkID, NULL, @customItemSetCHOICE_CHIP_APP);


/* Elements for the CHOICE page, for CHOICE_SMS_APP Profile */
SET @customItemSetCHOICE_SMS_APP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS_APP'));
SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean = 'UNDEFINED';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, @BankB, @NetworkID, im.id, @customItemSetCHOICE_SMS_APP
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @NetworkCustomItemName, 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, @NetworkCustomItemValue, n.id, im.id, @customItemSetCHOICE_SMS_APP
  FROM `Image` im, `Network` n WHERE im.name LIKE @NetworkImageNameLike AND n.code LIKE @NetworkImageCodeLike;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 2: Auswahl TAN-Verfahren</b>', @NetworkID, NULL, @customItemSetCHOICE_SMS_APP),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte wählen Sie eines der möglichen TAN-Verfahren aus.', @NetworkID, NULL, @customItemSetCHOICE_SMS_APP),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Auswahl TAN-Verfahren*: </b>', @NetworkID, NULL, @customItemSetCHOICE_SMS_APP),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetCHOICE_SMS_APP),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Senden', @NetworkID, NULL, @customItemSetCHOICE_SMS_APP);


/* Elements for the profile MEANS_CHOICE : */
SET @customItemSetUndefined = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_UNDEFINED'));
SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean = 'UNDEFINED';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankB, @NetworkID, im.id, @customItemSetUndefined
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @NetworkCustomItemName, 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', @NetworkCustomItemValue, n.id, im.id, @customItemSetUndefined
  FROM `Image` im, `Network` n WHERE im.name LIKE @NetworkImageNameLike AND n.code LIKE @NetworkImageCodeLike;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 2: Auswahl TAN-Verfahren</b>', @NetworkID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte wählen Sie eines der möglichen TAN-Verfahren aus.', @NetworkID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Auswahl TAN-Verfahren*: </b>', @NetworkID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Senden', @NetworkID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @NetworkID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @NetworkID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @NetworkID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @NetworkID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, 'ALL', 'Schließen', @NetworkID, NULL, @customItemSetUndefined),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, 'ALL', 'Zurück zum Händler', @NetworkID, NULL, @customItemSetUndefined);


/* Elements for the profile CHIPTAN : */
SET @currentAuthentMean = 'CHIP_TAN';
SET @customItemSetCHIPTAN = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_CHIP_TAN'));
SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the CHIPTAN Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankB, @NetworkID, im.id, @customItemSetCHIPTAN
     FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @NetworkCustomItemName, 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', @NetworkCustomItemValue, n.id, im.id, @customItemSetCHIPTAN
  FROM `Image` im, `Network` n WHERE im.name LIKE @NetworkImageNameLike AND n.code LIKE @NetworkImageCodeLike;

/* Here is what the content of the CHIPTAN will be */

/* Elements for the OTP page, for CHIPTAN Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 2: Eingabe chipTAN</b>', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte geben Sie die Generierte chipTAN ein.', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>TAN* :</b>', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12, @currentPageType, 'Authentifizierung läuft.', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen.', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'de', 28, @currentPageType, '<h3>Fehlerhafte TAN</h3>', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'de', 29, @currentPageType, 'Diese TAN-Nummer ist ungültig. Bitte ändern Sie Ihre Eingabe.
Die Anzahl der Ihnen verbleibenden Versuche lautet: <remaining tries>', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Die Session ist abgelaufen.', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Technischer Fehler.', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Senden', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, @currentPageType, 'Händler', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, @currentPageType, 'Betrag', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, @currentPageType, 'Datum', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, @currentPageType, 'Kreditkartennummer', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Shop', @NetworkID, NULL, @customItemSetCHIPTAN);

/* Elements for the FAILURE page, for CHIPTAN Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Eine Freigabe der Zahlung ist nicht möglich.</b>', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Die Anmeldung ist fehlgeschlagen. Bitte versuchen Sie es erneut mit gültigen Anmeldedaten.', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Maximale Anzahl der Fehlversuche erreicht.', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, 'Die Transaktion wurde abgebrochen, die Zahlung nicht durchgeführt.', @NetworkID, NULL, @customItemSetCHIPTAN),

   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetCHIPTAN);


/* Elements for the REFUSAL page, for CHIPTAN Profile */
SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Hinweise zur chipTAN</b>', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, '<b>Eingabe per Flickercode:</b> <p>Stecken Sie nun Ihre BankCard (nicht die für den Einkauf verwendete Sparda-Kreditkarte) in den TAN-Generator und drücken „F“. Halten Sie den TAN-Generator vor die animierte Grafik.
Dabei müssen die Markierungen (Dreiecke) der Grafik mit denen auf Ihrem TAN-Generator übereinstimmen. Prüfen Sie die Anzeige auf dem Leserdisplay und drücken "OK".
Prüfen Sie die Hinweise und bestätigen Sie diese dann jeweils mit "OK" auf Ihrem TAN-Generator.
</p>', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Manuelle Eingabe:</b> <p>Führen Sie Ihre Karte in den TAN-Generator ein. Drücken Sie die Taste "TAN", so dass im Display "Start-Code" erscheint. Geben Sie den Start-Code 267160 ein. Drücken Sie die Taste "OK". Geben Sie die geforderten Daten in den TAN-Generator ein und bestätigen Sie diese mit "OK".</p>', @NetworkID, NULL, @customItemSetCHIPTAN),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Schließen', @NetworkID, NULL, @customItemSetCHIPTAN);

SET @currentPageType = 'MEANS_PAGE';
SET @Imageid = (SELECT `id` FROM `Image` im WHERE im.name LIKE CONCAT('%','MOBILE_APP_Logo','%'));/*TODO use CHIPTAN logo*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Schritt 2: Auswahl TAN-Verfahren</b>', @NetworkID, NULL, @customItemSetCHIPTAN),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte wählen Sie eines der möglichen TAN-Verfahren aus.', @NetworkID, NULL, @customItemSetCHIPTAN),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, '<b>Auswahl TAN-Verfahren*: </b>', @NetworkID, NULL, @customItemSetCHIPTAN),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, 'SMS', @NetworkID, NULL, @customItemSetCHIPTAN),
  ('I', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
         'de', 9, @currentPageType, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), @NetworkID, @Imageid, @customItemSetCHIPTAN),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Abbrechen', @NetworkID, NULL, @customItemSetCHIPTAN),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@NetworkName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Senden', @NetworkID, NULL, @customItemSetCHIPTAN);

/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;