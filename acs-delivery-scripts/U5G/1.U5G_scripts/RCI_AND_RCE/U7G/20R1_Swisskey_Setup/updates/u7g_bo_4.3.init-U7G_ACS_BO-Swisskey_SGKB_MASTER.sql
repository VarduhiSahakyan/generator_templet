/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
SET @createdBy ='A757436';
SET @issuerCode = '41001';
SET @subIssuerCode = '78100';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'SWISSKEY';
SET @BankUB = 'SGKB';

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');

/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
	AND n.code = 'MASTERCARD';
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
    WHERE n.code='MASTERCARD' AND si.fk_id_issuer=@issuerId and si.id = @subIssuerID;
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
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5351478100', 16, FALSE, NULL, '5351478199', FALSE, @ProfileSet, @MaestroMID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5351478100' AND b.upperBound='5351478199' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

/* CustomItem */
/* Create custom items for default language and backup languages - in this example de and en */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;

/* Elements for the profile DEFAULT_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Zahlungsfreigabe nicht möglich</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (SMS oder App) für Ihre Karte gefunden haben. Bitte hinterlegen Sie für Ihre Karte eine entsprechende Freigabe-Methode im Enrollment Portal gemäss der Anleitung Ihrer Bank.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'de', 104, 'ALL', 'Telefonnummer', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174,@currentPageType, 'Meldung schliessen', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175,@currentPageType, 'Zurück zum Online Shop', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @helpPage, '<b>Hilfe</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @helpPage, 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank eine zwei-stufige Authetifikation eingeführt. Um eine Zahlung ausführen zu können, müssen Sie diese entweder anhand eines Freigabe-Codes per SMS, oder durch die Verifikation Ihrer Person auf einer Mobile Authentifikations-App bestätigen. Für diesen Service müssen Sie sich einmalig registrieren. Für den entsprechenden Registrierungsprozess, oder Änderungen Ihrer Authentifikationsmethode, wenden Sie sich bitte an Ihre Bank.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @helpPage, 'Hilfe-Text schliessen', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Meldung schliessen', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroMID, NULL, @customItemSetREFUSAL);

/*ENGLISH translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Payment approval not possible.</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. Please set up a corresponding approval method for your card on the enrollment portal according to your bank''s instructions.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Payment not completed – card is not registered for 3D Secure.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'en', 100, 'ALL', 'Merchant', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'en', 101, 'ALL', 'Amount', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'en', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'en', 103, 'ALL', 'Card number', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'en', 104, 'ALL', 'Phone number', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174,@currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175,@currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, '<b>Help</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'To boost security while paying online, your bank has introduced two-level authentification. To complete a payment, you must confirm it either by means of an approval code per SMS, or through verification of your identity with a mobile authentication app. You need to register once for this service. Contact your bank for the corresponding registration process or changes to your authentification method.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @helpPage, 'Close help text', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, 'Payment not completed – card is not registered for 3D Secure.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetREFUSAL);


/*FRENCH translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'fr', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'fr', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Activation de paiement impossible</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte. Veuillez consigner une méthode d''activation pour votre carte dans le portail d''Enrollment, conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'fr', 22, @currentPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'fr', 23, @currentPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'fr', 100, 'ALL', 'Commerçant', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'fr', 101, 'ALL', 'Montant', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'fr', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'fr', 103, 'ALL', 'Numéro de carte', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174,@currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175,@currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @helpPage, '<b>Aide</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @helpPage, 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes. Afin de pouvoir effectuer un paiement, vous devez le confirmer soit au moyen d''un code d''activation par SMS, soit par la vérification de votre personne sur une App d''authentification mobile. Pour ce service, vous devez vous enregistrer une fois. Pour la procédure d''enregistrement correspondante, ou pour les modifications de votre méthode d''authentification, veuillez vous adresser à votre banque.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @helpPage, 'Fermer le texte d''aide', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'fr', 16, @currentPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'fr', 17, @currentPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetREFUSAL);



/*Italian translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'it', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'it', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Autorizzazione di pagamento non possibile</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta. Stabilisca un metodo di autenticazione corrispondente per la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'it', 22, @currentPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'it', 23, @currentPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non eseguito - Errore tecnico', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'it', 100, 'ALL', 'Commerciante', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'it', 101, 'ALL', 'Importo', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'it', 102, 'ALL', 'Data', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'it', 103, 'ALL', 'Numero della carta', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'it', 104, 'ALL', 'Numero di telefono', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174,@currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175,@currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @helpPage, '<b>Aiuto</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @helpPage, 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi. Per poter effettuare un pagamento, deve confermarlo utilizzando un codice di autenticazione tramite SMS o verificando la sua persona su un’app di autenticazione mobile. Deve effettuare una volta la registrazione per questo servizio. Si rivolga alla sua banca per il processo di registrazione corrispondente o per modifiche al metodo di autenticazione.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @helpPage, 'Chiudere il testo di aiuto', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'it', 16, @currentPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'it', 17, @currentPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non eseguito - Errore tecnico', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the profile SMS : */
SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the SMS Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'de', 0, 'MESSAGE_BODY',
        'Sie haben einen Freigabe-Code für eine Online Zahlung angefordert. Bitte verwenden Sie folgenden Code: @otp', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>SMS-Freigabe der Zahlung</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Wir haben Ihnen zur Bestätigung der Zahlung einen Freigabe-Code auf Ihr Mobil-Telefon gesendet. Bitte prüfen Sie die Zahlungsdetails links und bestätigen Sie die Zahlung durch Eingabe des Freigabe-Codes.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12, @currentPageType, 'Zahlungsfreigabe wird geprüft', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'de', 13, @currentPageType, 'Bitte haben Sie einen Moment geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Zahlungsfreigabe abgebrochen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess trotzdem fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), 'PUSHED_TO_CONFIG',
         'de', 19, @currentPageType, 'Neuen Freigabe-Code anfordern', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Freigabe fehlgeschlagen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, 'Sie haben 3 Mal einen fehlerhaften Freigabe-Code eingegeben. Ihre Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Ihre Karte wird nun aus Sicherheitsgründen während einer kurzen Zeitdauer für Online Zahlungen blockiert. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'de', 26, @currentPageType, 'Zahlungsfreigabe war erfolgreich', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'de', 27, @currentPageType, 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum Händler weitergeleitet.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'de', 28, @currentPageType, 'Fehlerhafter Freigabe-Code', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'de', 29, @currentPageType, 'Der von Ihnen eingegebene Freigabe-Code ist nicht korrekt. Die Zahlung wurde nicht ausgeführt und Ihre Karte wurde nicht belastet. Sofern Sie den Kauf fortsetzen wollen, versuchen Sie es erneut.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Zahlung nicht ausgeführt - Sitzung abgelaufen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zurück zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung tätigen wollen.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Zahlung abbrechen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Freigeben', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'de', 104, 'ALL', 'Telefonnummer', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Meldung schliessen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroMID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Hilfe</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank eine zwei-stufige Authetifikation eingeführt. Um eine Zahlung freizugeben, bestätigen Sie diese mit einem Freigabe-Code, welchen Sie per SMS erhalten. Bei jedem Kauf wird Ihnen per SMS ein neuer, einmaliger Code an die von Ihnen registrierte Telefonnummer gesendet. Für Änderungen Ihrer Telefonnummer, oder anderen Fragen zum Online-Einkauf mit Ihrer Karte, wenden Sie sich bitte an Ihre Bank.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Hilfe schließen', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Freigabe fehlgeschlagen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, 'Sie haben 3 Mal einen fehlerhaften Freigabe-Code eingegeben. Ihre Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Ihre Karte wird nun aus Sicherheitsgründen während einer kurzen Zeitdauer für Online Zahlungen blockiert. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Meldung schliessen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Zahlungsfreigabe nicht möglich</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (SMS oder App) für Ihre Karte gefunden haben. Bitte hinterlegen Sie für Ihre Karte eine entsprechende Freigabe-Methode im Enrollment Portal gemäss der Anleitung Ihrer Bank.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Meldung schliessen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroMID, NULL, @customItemSetSMS);


/*ENGLISH translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'en', 0, 'MESSAGE_BODY',
        'You have requested an approval code for an online purchase. Please use the following code: @otp', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>SMS approval of the payment</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'We have sent an approval code to your mobile phone to confirm the payment. Please check the payment details to the left and confirm the payment by entering the approval code.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'en', 12, @currentPageType, 'Payment approval is being verified', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'en', 13, @currentPageType, 'Please be patient. We are verifying your payment approval and thereby the authentication for the requested payment.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'en', 14, @currentPageType, 'Payment confirmation cancelled', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'en', 15, @currentPageType, 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the payment process, please start the payment attempt again. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), 'PUSHED_TO_CONFIG',
         'en', 19, @currentPageType, 'Request new approval code', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Confirmation failed', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'You have entered an incorrect approval code multiple times. Your payment could not be completed and your card was not debited. Your card will now be temporarily blocked for online payments for security reasons. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'en', 26, @currentPageType, 'Successful payment confirmation', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'en', 27, @currentPageType, 'You have successfully confirmed the payment and will be automatically routed back to the merchant.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'en', 28, @currentPageType, 'Incorrect approval code', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'en', 29, @currentPageType, 'The approval code you entered is incorrect. The payment was not conducted and your card was not debited. Please try again if you wish to continue the purchase.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'en', 30, @currentPageType, 'Payment not completed – session expired', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'en', 31, @currentPageType, 'Too much time has passed before the payment was confirmed. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process, if you wish to make the payment.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'en', 40, @currentPageType, 'Cancel payment', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'en', 42, @currentPageType, 'Approve', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'en', 100, 'ALL', 'Merchant', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'en', 101, 'ALL', 'Amount', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'en', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'en', 103, 'ALL', 'Card number', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'en', 104, 'ALL', 'Phone number', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Help</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'To boost security while paying online, your bank has introduced two-level authentification. To approve a payment, please confirm it with the approval code you receive via SMS. For each purchase an SMS is sent to you with a new one-time code at the telephone number you registered. For changes to your telephone number, or other questions about online shopping with you card, please contact your bank.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close Help', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, 'Confirmation failed', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'You have entered an incorrect approval code multiple times. Your payment could not be completed and your card was not debited. Your card will now be temporarily blocked for online payments for security reasons. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Payment approval not possible.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. Please set up a corresponding approval method for your card on the enrollment portal according to your bank''s instructions.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Payment not completed – card is not registered for 3D Secure.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to online shop', @MaestroMID, NULL, @customItemSetSMS);




/*FRENCH translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'fr', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'fr', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'fr', 0, 'MESSAGE_BODY',
        'Vous avez demandé un code d’activation pour un paiement en ligne. Veuillez utiliser le code suivant : @otp', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>SMS - Activation du paiement</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Pour la confirmation du paiement, nous vous avons envoyé un code d''activation sur votre téléphone portable. Veuillez vérifier les détails du paiement à gauche et confirmez le paiement en saisissant le code d''activation.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'fr', 12, @currentPageType, 'L''activation de paiement va être vérifiée', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'fr', 13, @currentPageType, 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'fr', 14, @currentPageType, 'Activation de paiement interrompue', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'fr', 15, @currentPageType, 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), 'PUSHED_TO_CONFIG',
         'fr', 19, @currentPageType, 'Demander un nouveau code d''activation', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'fr', 22, @currentPageType, 'L''activation a échoué', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'fr', 23, @currentPageType, 'Vous avez saisi 3 fois un mauvais code d''activation. Votre paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'fr', 26, @currentPageType, 'L’activation du paiement a réussi', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'fr', 27, @currentPageType, 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'fr', 28, @currentPageType, 'Code d''activation erroné', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'fr', 29, @currentPageType, 'Le code d''activation que vous avez saisi n''est pas correct. Le paiement n''a pas été effectué et votre carte n''a pas été débitée. Si vous voulez continuer l''achat, essayez à nouveau.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'fr', 30, @currentPageType, 'Paiement non effectué - La session a expiré', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'fr', 31, @currentPageType, 'Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'fr', 40, @currentPageType, 'Interrompre le paiement', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'fr', 42, @currentPageType, 'Activer', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'fr', 100, 'ALL', 'Commerçant', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'fr', 101, 'ALL', 'Montant', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'fr', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'fr', 103, 'ALL', 'Numéro de carte', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'fr', 104, 'ALL', 'Numéro de carte', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Aide</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes. Afin d''activer un paiement, confirmez celui-ci avec un code d''activation que vous avez reçu par SMS. Lors de chaque achat, un nouveau code unique vous sera envoyé par SMS au numéro de téléphone que vous avez enregistré. Pour modifier votre numéro de téléphone ou pour toute autre question concernant les achats en ligne avec votre carte, veuillez vous adresser à votre banque.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'fr', 16, @currentPageType, 'L''activation a échoué', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'fr', 17, @currentPageType, 'Vous avez saisi 3 fois un mauvais code d''activation. Votre paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Activation de paiement impossible</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte. Veuillez consigner une méthode d''activation pour votre carte dans le portail d''Enrollment, conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'fr', 22, @currentPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'fr', 23, @currentPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetSMS);




/*ITALIAN translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'it', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'it', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'it', 0, 'MESSAGE_BODY',
        'Ha richiesto un codice di autenticazione per un pagamento online. Utilizzi il seguente codice: @otp', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Autorizzazione del pagamento via SMS</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Le abbiamo inviato un codice di autenticazione sul suo cellulare per confermare il pagamento. Controlli i dettagli del pagamento a sinistra e confermi il pagamento inserendo il codice di autorizzazione.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'it', 12, @currentPageType, 'L’autorizzazione di pagamento viene controllata', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'it', 13, @currentPageType, 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'it', 14, @currentPageType, 'Autorizzazione di pagamento annullata', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'it', 15, @currentPageType, 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), 'PUSHED_TO_CONFIG',
         'it', 19, @currentPageType, 'Richiede un nuovo codice di autenticazione', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'it', 22, @currentPageType, 'Autenticazione fallita', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'it', 23, @currentPageType, 'Ha inserito 3 volte il codice di autenticazione errato. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'it', 26, @currentPageType, 'L’autorizzazione di pagamento è andata a buon fine', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'it', 27, @currentPageType, 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'it', 28, @currentPageType, 'Codice di autenticazione errato', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'it', 29, @currentPageType, 'Il codice di autenticazione da lei inserito non è corretto. Il pagamento non è stato eseguito e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, provi nuovamente.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'it', 30, @currentPageType, 'Indietro al negozio online Pagamento non effettuato - Sessione scaduta', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'it', 31, @currentPageType, 'È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'it', 40, @currentPageType, 'Interrompere il pagamento', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'it', 42, @currentPageType, 'Autorizzare', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'it', 100, 'ALL', 'Commerciante', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'it', 101, 'ALL', 'Importo', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'it', 102, 'ALL', 'Data', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'it', 103, 'ALL', 'Numero della carta', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'it', 104, 'ALL', 'Numero di telefono', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Aiuto</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi. Per autorizzare un pagamento, lo confermi con un codice di autenticazione che riceverà tramite SMS. A ogni acquisto le verrà inviato tramite SMS un nuovo codice univoco al numero di telefono da lei registrato. Si rivolga alla sua banca per modificare il suo numero di telefono o per altre domande sugli acquisti online con la sua carta.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'it', 16, @currentPageType, 'Autenticazione fallita', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'it', 17, @currentPageType, 'Ha inserito 3 volte il codice di autenticazione errato. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Autorizzazione di pagamento non possibile</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta. Stabilisca un metodo di autenticazione corrispondente per la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'it', 22, @currentPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'it', 23, @currentPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non eseguito - Errore tecnico', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetSMS);




SET @currentAuthentMean = 'MOBILE_APP';
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @currentPageType = 'POLLING_PAGE';
SET @updateState = 'PUSHED_TO_CONFIG';
SET @locale = 'de';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetMobileApp
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileApp
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

   /*MOBILE_APP_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Zahlung im App freigeben</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Damit die Zahlung abgeschlossen werden kann, müssen Sie diese in der von Ihrer Bank zur Vergfügung gestellten App freigeben. Sie sollten bereits eine entsprechende Benachrichtigung auf Ihrem Mobil-Telefon erhalten haben. Andernfalls können Sie direkt in die App einsteigen und die Zahlung dort verifizieren.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Stattdessen Freigabe durch SMS anfordern', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12,@currentPageType, 'Zahlungsfreigabe wird geprüft', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'de', 13,@currentPageType, 'Bitte haben Sie einen Moment geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14,@currentPageType, 'Zahlungsfreigabe abgebrochen', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15,@currentPageType, 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess trotzdem fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'de', 26,@currentPageType, 'Zahlungsfreigabe war erfolgreich', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'de', 27,@currentPageType, 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum Händler weitergeleitet.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30,@currentPageType, 'Zahlung nicht ausgeführt - Sitzung abgelaufen', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31,@currentPageType, 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zurück zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung tätigen wollen.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32,@currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33,@currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Zahlung abbrechen', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'de', 104, 'ALL', 'Telefonnummer', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Hilfe schließen', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroMID, NULL, @customItemSetMobileApp);


/* Elements for the HELP page, for MOBILE APP Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Hilfe</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank ein zwei-stufiges Authentifikationsverfahren eingeführt. Sie können Online-Zahlungen auf Ihrem Mobil-Telefon in der von Ihrer Bank zur Verfügung gestellten Authentifikations-App freigeben. Bei Fragen oder Unklarheiten wenden Sie sich bitte an Ihre Bank.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Hilfe schließen', @MaestroMID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Freigabe fehlgeschlagen', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, 'Die Authentifikation auf Ihrem Mobil-Telefon und somit die Zahlungsfreigabe ist fehlgeschlagen. Der Zahlungsprozess wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess fotsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Hilfe schliessen', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroMID, NULL, @customItemSetMobileApp);



/*ENGLISH translations for MOBILE_APP*/
SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetMobileApp
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileApp
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

   /*MOBILE_APP_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Confirm payment in the app</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'To complete the payment, you must confirm it in the app provided by your bank. You should already have received a corresponding message on your mobile phone. Otherwise, you can open the app directly and confirm the payment there.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @currentPageType, 'Request confirmation via SMS instead.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'en', 12,@currentPageType, 'Payment approval is being verified', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'en', 13,@currentPageType, 'Please be patient. We are verifying your payment confirmation and thereby the authentification for the requested payment.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'en', 14,@currentPageType, 'Payment confirmation cancelled', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'en', 15,@currentPageType, 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the payment process, please start the payment attempt again.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'en', 26,@currentPageType, 'Successful payment confirmation', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'en', 27,@currentPageType, 'You have successfully confirmed the payment and will be automatically routed back to the merchant.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'en', 30,@currentPageType, 'Payment not completed – session expired', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'en', 31,@currentPageType, 'Too much time has passed before the payment was confirmed. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process, if you wish to make the payment.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32,@currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33,@currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'en', 40, @currentPageType, 'Cancel payment', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'en', 100, 'ALL', 'Merchant', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'en', 101, 'ALL', 'Amount', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'en', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'en', 103, 'ALL', 'Card number', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'en', 104, 'ALL', 'Phone number', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close Help', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetMobileApp);



/* Elements for the HELP page, for MOBILE APP Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Help</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'To boost security while paying online, your bank has introduced two-level authentification. You can approve online payments on your mobile telephone in the app provided by your bank. If you have questions, please contact your bank directly.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close Help', @MaestroMID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, 'Confirmation failed', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'The authentication on your mobile phone and thus the payment confirmation failed. The payment process was cancelled and your card was not debited. If you wish to continue the payment process, please start the payment attempt again.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close Help', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetMobileApp);



/*FRENCH translations for MOBILE_APP*/
SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'fr', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetMobileApp
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'fr', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileApp
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

   /*MOBILE_APP_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Activer le paiement dans l''App</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Pour que le paiement puisse être terminé, vous devez l''activer dans l''App mise à disposition par votre banque. Vous devriez déjà avoir reçu un message correspondant sur votre téléphone portable. Dans le cas contraire, vous pouvez aller directement dans votre App et y vérifier le paiement.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'fr', 3, @currentPageType, 'À la place, demander l''activation pas SMS', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'fr', 12,@currentPageType, 'Payment approval is being verified', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'fr', 13,@currentPageType, 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'fr', 14,@currentPageType, 'Activation de paiement interrompue', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'fr', 15,@currentPageType, 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'fr', 26,@currentPageType, 'L’activation du paiement a réussi', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'fr', 27,@currentPageType, 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'fr', 30,@currentPageType, 'Paiement non effectué - La session a expiré', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'fr', 31,@currentPageType, 'Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32,@currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33,@currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'fr', 40, @currentPageType, 'Interrompre le paiement', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'fr', 100, 'ALL', 'Commerçant', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'fr', 101, 'ALL', 'Montant', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'fr', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'fr', 103, 'ALL', 'Numéro de carte', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetMobileApp);



/* Elements for the HELP page, for MOBILE APP Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Aide</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes. Afin d''activer un paiement, confirmez celui-ci avec un code d''activation que vous avez reçu par SMS. Lors de chaque achat, un nouveau code unique vous sera envoyé par SMS au numéro de téléphone que vous avez enregistré. Pour modifier votre numéro de téléphone ou pour toute autre question concernant les achats en ligne avec votre carte, veuillez vous adresser à votre banque.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroMID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'fr', 16, @currentPageType, 'L''activation a échoué', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'fr', 17, @currentPageType, 'L''authentification sur votre téléphone portable et donc l''activation de paiement, ont échoué. Le processus de paiement a été interrompu et votre carte n''a pas été débitée. Si vous souhaitez continuer le processus d''achat, veuillez recommencer la tentative de paiement.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetMobileApp);



/*ITALIAN translations for MOBILE_APP*/
SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'it', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetMobileApp
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'it', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileApp
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

   /*MOBILE_APP_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Autorizzare il pagamento nell’app</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Per poter completare il pagamento, è necessario autorizzarlo nell’app fornita sua banca.  Dovrebbe aver già ricevuto una notifica sul suo cellulare.  In caso contrario può accedere direttamente all''app e verificare il pagamento lì.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'it', 3, @currentPageType, 'Al posto di questo, richiedere l’autorizzazione tramite SMS', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'it', 12,@currentPageType, 'L’autorizzazione di pagamento viene controllata', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'it', 13,@currentPageType, 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'it', 14,@currentPageType, 'Autorizzazione di pagamento annullata', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'it', 15,@currentPageType, 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'it', 26,@currentPageType, 'L’autorizzazione di pagamento è andata a buon fine', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'it', 27,@currentPageType, 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'it', 30,@currentPageType, 'Indietro al negozio online Pagamento non effettuato - Sessione scaduta', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'it', 31,@currentPageType, 'È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32,@currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33,@currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'it', 40, @currentPageType, 'Interrompere il pagamento', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'it', 100, 'ALL', 'Commerciante', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'it', 101, 'ALL', 'Importo', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'it', 102, 'ALL', 'Data', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'it', 103, 'ALL', 'Numero della carta', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'it', 104, 'ALL', 'Numero di telefono', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetMobileApp);



/* Elements for the HELP page, for MOBILE APP Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Aiuto</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi. Può autorizzare i pagamenti online sul suo cellulare nell’app di autenticazione fornita dalla sua banca. In caso di domande o chiarimenti, la preghiamo di contattare la sua banca.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroMID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'it', 16, @currentPageType, 'Autenticazione fallita', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'it', 17, @currentPageType, 'L’autenticazione sul suo cellulare e quindi l’autorizzazione del pagamento non sono riuscite. Il processo di pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetMobileApp);



/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;
