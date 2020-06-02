/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
SET @createdBy ='A757435';
SET @issuerCode = '16900';
SET @subIssuerCode = '16901';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = '16900';
SET @BankUB = 'BNP_WM';

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
	SELECT n.id, si.id
	FROM `Network` n, `SubIssuer` si
	WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
	AND n.code = 'VISA';
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
WHERE n.code='VISA' AND si.fk_id_issuer=@issuerId and si.id = @subIssuerID;
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
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4163698000', 16, FALSE, NULL, '4163698999', FALSE, @ProfileSet, @MaestroVID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4163698000' AND b.upperBound='4163698999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;


/* Elements for the profile SMS : */
SET @customItemSetPASSWORD = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'));
SET @currentPageType = 'OTP_FORM_PAGE';
SET @currentAuthentMean = 'EXT_PASSWORD';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
	   'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetPassword
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
	   'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetPassword
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
	'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
	'de', 3, @currentPageType, 'Bestätigung mit der PIN von BNP Paribas Wealth Management - Private Banking', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
	'de', 4, @currentPageType, 'Abbrechen und zurück zum Händler', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
	'de', 5, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_6'), 'PUSHED_TO_CONFIG',
	'de', 6, @currentPageType, 'Wir sind für Sie da: 0911 - 369 2000', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_7'), 'PUSHED_TO_CONFIG',
	'de', 7, @currentPageType, 'Mo-Fr: 09:00 Uhr bis 20:00 Uhr', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_8'), 'PUSHED_TO_CONFIG',
	'de', 8, @currentPageType, '(Halten Sie als Kunde bitte ihre Kontonummer bereit.)', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
	'de', 9, @currentPageType, 'Visa Secure - ein Service von Visa in Kooperation mit BNP Paribas', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
	'de', 10, @currentPageType, '&copy; Visa Europe', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
	'de', 11, @currentPageType, 'Bitte bestätigen Sie Ihre Zahlung. Geben Sie dazu die 2. und 5. Stelle Ihrer 5-stelligen Online-PIN hintereinander und ohne Kommastellen ein.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
	'de', 12, @currentPageType, 'Authentifizierung läuft', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
	'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
	'de', 14, @currentPageType, 'Ihre Transaktion wurde abgebrochen', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
	'de', 15, @currentPageType, 'Sie haben den Bezahlvorgang abgebrochen. Falls Sie den Artikel dennoch kaufen wollen, starten Sie den Bezahlvorgang bitte erneut.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_18'), 'PUSHED_TO_CONFIG',
	'de', 18, @currentPageType, 'Zahlung bestätigen', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
	'de', 26, @currentPageType, 'Die PIN Prüfung war erfolgreich.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
	'de', 27, @currentPageType, 'Es folgt der nächste Authentifizierungsschritt.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
	'de', 28, @currentPageType, 'PIN fehlerhaft.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
	'de', 29, @currentPageType, 'Die eingegebene PIN ist falsch. Nach drei falschen Eingaben wird Ihre PIN gesperrt.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
	'de', 30, @currentPageType, 'Ihre Session ist abgelaufen', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
	'de', 31, @currentPageType, 'Aus Sicherheitsgründen wurde die Transaktion aufgrund Überschreitung des Zeitlimits abgebrochen. Bitte versuchen Sie es erneut.
	Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
	'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
	'de', 33, @currentPageType, 'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.
	Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_53'), 'PUSHED_TO_CONFIG',
	'de', 53, @currentPageType, 'Eingabe', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
	'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
	'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
	'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
	'de', 103, 'ALL', 'Kreditkartennummer', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
	'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
	'de', 174, @currentPageType, 'Schliessen', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
	'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetPassword);

SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
	'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
	'de', 5, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_6'), 'PUSHED_TO_CONFIG',
	'de', 6, @currentPageType, 'Wir sind für Sie da: 0911 - 369 2000', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_7'), 'PUSHED_TO_CONFIG',
	'de', 7, @currentPageType, 'Mo-Fr: 09:00 Uhr bis 20:00 Uhr', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_8'), 'PUSHED_TO_CONFIG',
	'de', 8, @currentPageType, '(Halten Sie als Kunde bitte ihre Kontonummer bereit.)', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
	'de', 9, @currentPageType, 'Visa Secure - ein Service von Visa in Kooperation mit BNP Paribas', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
	'de', 10, @currentPageType, '&copy; Visa Europa 2018', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
	'de', 16, @currentPageType, 'Ihr Authentifizierungsverfahren wurde gesperrt', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
	'de', 17, @currentPageType, 'Beachten Sie bitte, dass aus Sicherheitsgründen aufgrund mehrfach falscher Authentifizierung Ihr Authentifizierungs-Verfahren gesperrt wurde. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
	'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
	'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten, sodass der Bezahlvorgang abgebrochen wurde. Bitte versuchen Sie es zu einem anderen Zeitpunkt erneut.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
	'de', 174, @currentPageType, 'Schliessen', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
	'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetPassword);

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
	'de', 1, @currentPageType, '<b>Informationen über Visa Secure</b></br>Visa Secure ist ein Service von Visa und BNP Paribas Wealth Management - Private Banking, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
	'de', 2, @currentPageType, '<b>Registrierung für Visa Secure</b><br>Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Visa Card von BNP Paribas Wealth Management - Private Banking automatisch für den Visa Secure Service angemeldet.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
	'de', 3, @currentPageType, '<b>Deaktivierung des Visa Secure Service</b><br>Solange Sie ein Girokonto und eine Visa Card von BNP Paribas Wealth Management - Private Banking haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
	'de', 4, @currentPageType, '<b>Höhere Sicherheit durch Visa Secure</b><br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
	'de', 5, @currentPageType, '<b>Falscheingabe der Visa Secure TAN</b><br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr persönliches Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Services weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
	'de', 11, @currentPageType, 'Hilfe schließen', @MaestroVID, NULL, @customItemSetPassword);


/* Elements for the profile Photo_Tan : */
SET @customItemSetPhotoTan = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PHOTO_TAN'));
SET @currentPageType = 'OTP_FORM_PAGE';
SET @currentAuthentMean = 'PHOTO_TAN';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
	   'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetPhotoTan
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
	   'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetPhotoTan
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
	'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
	'de', 3, @currentPageType, 'QR-Code Eingabe', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
	'de', 5, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_6'), 'PUSHED_TO_CONFIG',
	'de', 6, @currentPageType, 'Wir sind für Sie da: 0911 - 369 2000', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_7'), 'PUSHED_TO_CONFIG',
	'de', 7, @currentPageType, 'Mo-Fr: 09:00 Uhr bis 20:00 Uhr', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_8'), 'PUSHED_TO_CONFIG',
	'de', 8, @currentPageType, '(Halten Sie als Kunde bitte ihre Kontonummer bereit.)', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
	'de', 9, @currentPageType, 'Visa Secure - ein Service von Visa in Kooperation mit BNP Paribas', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
	'de', 10, @currentPageType, '&copy; Visa Europe', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
	'de', 11, @currentPageType, 'Scannen Sie bitte jetzt den abgebildeten QR-Code mit Ihrer SecurePlus App oder dem SecurePlus Generator. Geben Sie die generierte QR-TAN ein.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
	'de', 12, @currentPageType, 'Ihre QR-TAN wird geprüft', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
	'de', 13, @currentPageType, 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre QR-TAN.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
	'de', 14, @currentPageType, 'Sie haben die Bezahlung abgebrochen', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
	'de', 15, @currentPageType, 'Falls Sie den Artikel dennoch kaufen möchten, starten Sie den Zahlungsvorgang bitte erneut.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_18'), 'PUSHED_TO_CONFIG',
	'de', 18, @currentPageType, 'QR-TAN', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), 'PUSHED_TO_CONFIG',
	'de', 19, @currentPageType, 'Zahlung bestätigen', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
	'de', 26, @currentPageType, 'Ihre Authentifizierung war erfolgreich', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
	'de', 27, @currentPageType, 'Sie wurden erfolgreich authentifiziert und werden automatisch zur Händler-Website weitergeleitet.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
	'de', 28, @currentPageType, 'Ungültige QR-TAN', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
	'de', 29, @currentPageType, 'Die Prüfung der QR-TAN ist fehlgeschlagen. Nach dreimaliger falscher Eingabe der QR-TAN wird Ihr TAN-Verfahren gesperrt.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
	'de', 30, @currentPageType, 'Ihre Session ist abgelaufen', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
	'de', 31, @currentPageType, 'Das Zeitlimit wurde überschritten. Aus Sicherheitsgründen wird die Transaktion abgebrochen. Bitte versuchen Sie es erneut. Bei Fragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
	'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
	'de', 33, @currentPageType, 'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_55'), 'PUSHED_TO_CONFIG',
	'de', 55, @currentPageType, 'Abbrechen und zurück zum Händler', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
	'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
	'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
	'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
	'de', 103, 'ALL', 'Kreditkartennummer', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
	'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
	'de', 174, @currentPageType, 'Schliessen', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
	'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetPhotoTan);

SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
	'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
	'de', 5, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_6'), 'PUSHED_TO_CONFIG',
	'de', 6, @currentPageType, 'Wir sind für Sie da: 0911 - 369 2000', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_7'), 'PUSHED_TO_CONFIG',
	'de', 7, @currentPageType, 'Mo-Fr: 09:00 Uhr bis 20:00 Uhr', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_8'), 'PUSHED_TO_CONFIG',
	'de', 8, @currentPageType, '(Halten Sie als Kunde bitte ihre Kontonummer bereit.)', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
	'de', 9, @currentPageType, 'Visa Secure - ein Service von Visa in Kooperation mit BNP Paribas', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
	'de', 10, @currentPageType, '&copy; Visa Europa 2018', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
	'de', 16, @currentPageType, 'Die TAN-Prüfung ist fehlgeschlagen', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
	'de', 17, @currentPageType, 'Bitte versuchen Sie es zu einem späteren Zeitpunkt noch einmal.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
	'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
	'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten, sodass der Bezahlvorgang abgebrochen wurde. Bitte versuchen Sie es zu einem anderen Zeitpunkt erneut.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
	'de', 174, @currentPageType, 'Schliessen', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
	'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetPhotoTan);


SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
	'de', 1, @currentPageType, '<b>Informationen über Visa Secure</b></br>Visa Secure ist ein Service von Visa und BNP Paribas Wealth Management - Private Banking, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
	'de', 2, @currentPageType, '<b>Registrierung für Visa Secure</b><br>Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Visa Card von BNP Paribas Wealth Management - Private Banking automatisch für den Visa Secure Service angemeldet.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
	'de', 3, @currentPageType, '<b>Deaktivierung des Visa Secure Service</b><br>Solange Sie ein Girokonto und eine Visa Card von BNP Paribas Wealth Management - Private Banking haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
	'de', 4, @currentPageType, '<b>Höhere Sicherheit durch Visa Secure</b><br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
	'de', 5, @currentPageType, '<b>Falscheingabe der Visa Secure TAN</b><br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr persönliches Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Services weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.', @MaestroVID, NULL, @customItemSetPhotoTan),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
	'de', 11, @currentPageType, 'Hilfe schließen', @MaestroVID, NULL, @customItemSetPhotoTan);

/* Elements for the profile MOBILE_APP : */
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));
SET @currentPageType = 'POLLING_PAGE';
SET @currentAuthentMean = 'MOBILE_APP_EXT';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
	   'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileApp
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
	   'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileApp
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mobile App Logo', 'PUSHED_TO_CONFIG',
	   'de', 3, 'ALL', 'Mobile App Logo', @MaestroVID, im.id, @customItemSetMobileApp
FROM `Image` im WHERE im.name = 'MOBILE_APP_Logo';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
	'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
	'de', 3, @currentPageType, 'SecurePlus Freigabe', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
	'de', 4, @currentPageType, 'Wir haben Ihnen über Ihre SecurePlus App eine Anfrage geschickt. Bitte öffnen Sie die App und geben Sie die Zahlung frei.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
	'de', 5, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_6'), 'PUSHED_TO_CONFIG',
	'de', 6, @currentPageType, 'Wir sind für Sie da: 0911 - 369 2000', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_7'), 'PUSHED_TO_CONFIG',
	'de', 7, @currentPageType, 'Mo-Fr: 09:00 Uhr bis 20:00 Uhr', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_8'), 'PUSHED_TO_CONFIG',
	'de', 8, @currentPageType, '(Halten Sie als Kunde bitte ihre Kontonummer bereit.)', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
	'de', 9, @currentPageType, 'Visa Secure - ein Service von Visa in Kooperation mit BNP Paribas', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
	'de', 11, @currentPageType, 'Abbrechen und zurück zum Händler', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
	'de', 12, @currentPageType, 'Authentifizierung läuft', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
	'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
	'de', 14, @currentPageType, 'Sie haben die Bezahlung abgebrochen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
	'de', 15, @currentPageType, 'Falls Sie den Artikel dennoch kaufen möchten, starten Sie den Zahlungsvorgang bitte erneut.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
	'de', 26, @currentPageType, 'Authentifizierung erfolgreich', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
	'de', 27, @currentPageType, 'Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
	'de', 30, @currentPageType, 'Ihre Session ist abgelaufen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
	'de', 31, @currentPageType, 'Aus Sicherheitsgründen wurde die Transaktion aufgrund Überschreitung des Zeitlimits abgebrochen. Bitte versuchen Sie es erneut.
	Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
	'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
	'de', 33, @currentPageType, 'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_44'), 'PUSHED_TO_CONFIG',
	'de', 44, @currentPageType, '&copy; Visa Europe', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
	'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
	'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
	'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
	'de', 103, 'ALL', 'Kreditkartennummer', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
	'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
	'de', 174, @currentPageType, 'Schliessen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
	'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetMobileApp);

SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
	'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
	'de', 5, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_6'), 'PUSHED_TO_CONFIG',
	'de', 6, @currentPageType, 'Wir sind für Sie da: 0911 - 369 2000', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_7'), 'PUSHED_TO_CONFIG',
	'de', 7, @currentPageType, 'Mo-Fr: 09:00 Uhr bis 20:00 Uhr', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_8'), 'PUSHED_TO_CONFIG',
	'de', 8, @currentPageType, '(Halten Sie als Kunde bitte ihre Kontonummer bereit.)', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
	'de', 9, @currentPageType, 'Visa Secure - ein Service von Visa in Kooperation mit BNP Paribas', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_44'), 'PUSHED_TO_CONFIG',
	'de', 10, @currentPageType, '&copy; Visa Europe', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
	'de', 16, @currentPageType, 'Ihr Authentifizierungsverfahren wurde gesperrt', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
	'de', 17, @currentPageType, 'Beachten Sie bitte, dass aus Sicherheitsgründen aufgrund mehrfach falscher Authentifizierung Ihr Authentifizierungs-Verfahren gesperrt wurde. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
	'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
	'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten, sodass der Bezahlvorgang abgebrochen wurde. Bitte versuchen Sie es zu einem anderen Zeitpunkt erneut.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
	'de', 174, @currentPageType, 'Schliessen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
	'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetMobileApp);

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
	'de', 1, @currentPageType, '<b>Informationen über Visa Secure</b></br>Visa Secure ist ein Service von Visa und BNP Paribas Wealth Management - Private Banking, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
	'de', 2, @currentPageType, '<b>Registrierung für Visa Secure</b><br>Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Visa Card von BNP Paribas Wealth Management - Private Banking automatisch für den Visa Secure Service angemeldet.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
	'de', 3, @currentPageType, '<b>Deaktivierung des Visa Secure Service</b><br>Solange Sie ein Girokonto und eine Visa Card von BNP Paribas Wealth Management - Private Banking haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
	'de', 4, @currentPageType, '<b>Höhere Sicherheit durch Visa Secure</b><br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
	'de', 5, @currentPageType, '<b>Falscheingabe der Visa Secure TAN</b><br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr persönliches Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Services weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
	'de', 11, @currentPageType, 'Hilfe schließen', @MaestroVID, NULL, @customItemSetMobileApp);

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_1_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
	   'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetREFUSAL
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
	   'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
	'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
	'de', 5, @currentPageType, 'Hilfe & FAQ', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_6'), 'PUSHED_TO_CONFIG',
	'de', 6, @currentPageType, 'Wir sind für Sie da: 0911 - 369 2000', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_7'), 'PUSHED_TO_CONFIG',
	'de', 7, @currentPageType, 'Mo-Fr: 09:00 Uhr bis 20:00 Uhr', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_8'), 'PUSHED_TO_CONFIG',
	'de', 8, @currentPageType, '(Halten Sie als Kunde bitte ihre Kontonummer bereit.)', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
	'de', 9, @currentPageType, 'Visa Secure - ein Service von Visa in Kooperation mit BNP Paribas', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
	'de', 10, @currentPageType, '&copy; Visa Europe', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
	'de', 22, @currentPageType, 'Ihre Zahlung mit Visa Secure wurde abgelehnt', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
	'de', 23, @currentPageType, 'Aus Sicherheitsgründen wurde der Einkauf mit Visa Secure abgelehnt. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
	'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
	'de', 33, @currentPageType, 'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
	'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
	'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
	'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
	'de', 103, 'ALL', 'Kreditkartennummer', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
	'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
	'de', 175,@currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetREFUSAL);

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
	'de', 1, @currentPageType, '<b>Informationen über Visa Secure</b></br>Visa Secure ist ein Service von Visa und BNP Paribas Wealth Management - Private Banking, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
	'de', 2, @currentPageType, '<b>Registrierung für Visa Secure</b><br>Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Visa Card von BNP Paribas Wealth Management - Private Banking automatisch für den Visa Secure Service angemeldet.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
	'de', 3, @currentPageType, '<b>Deaktivierung des Visa Secure Service</b><br>Solange Sie ein Girokonto und eine Visa Card von BNP Paribas Wealth Management - Private Banking haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
	'de', 4, @currentPageType, '<b>Höhere Sicherheit durch Visa Secure</b><br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
	'de', 5, @currentPageType, '<b>Falscheingabe der Visa Secure TAN</b><br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr persönliches Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Services weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
	'de', 11, @currentPageType, 'Hilfe schließen', @MaestroVID, NULL, @customItemSetREFUSAL);

/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;