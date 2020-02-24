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
SET @issuerCode = '00006';
SET @createdBy ='A699391';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'Bankard Credit';
SET @subIssuerCode = '00006';
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);


/*!40000 ALTER TABLE `Network` DISABLE KEYS */;
INSERT INTO `Network` (`binRangeCode`, `code`, `createdBy`, `creationDate`, `description`, `name`, `updateState`, `label`, `solution`)
VALUES
  (6, 'JCB', 'InitPhase', NOW(), 'J/Secure™ network', 'JCB', 'PUSHED_TO_CONFIG', 'JCB', 'J/Secure™');
/*!40000 ALTER TABLE `Network` ENABLE KEYS */;

-- To add another image, you'll need to transform it into a Base64 format, and then in Hexadecimal (or use the tool in BO)
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `name`, `updateState`, `binaryData`) VALUES
  ('InitPhase', NOW(), 'The JCB logo', 'JCB_LOGO', 'PUSHED_TO_CONFIG', '/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QPqaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjUtYzAyMSA3OS4xNTU3NzIsIDIwMTQvMDEvMTMtMTk6NDQ6MDAgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcFJpZ2h0cz0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3JpZ2h0cy8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBSaWdodHM6TWFya2VkPSJGYWxzZSIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6YTU2N2EwNjYtMTliYy0xMWRjLTk4YTYtYTRiZDFhMGM4NDc0IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjMzM0NCRjVGMUUyMDExRTU4RTcyOEI1NkIzRDI5MzJGIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjMzM0NCRjVFMUUyMDExRTU4RTcyOEI1NkIzRDI5MzJGIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE0IChXaW5kb3dzKSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOmEyZmVmZTZhLWFjMjMtZjk0My04YzU4LTY3ZDVh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');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
	AND n.code in('JCB');
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
    WHERE n.code='JCB' AND si.fk_id_issuer = @issuerId;

/*!40000 ALTER TABLE `SubIssuerNetworkCrypto` ENABLE KEYS */;


/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'Bankard_Credit';
SET @BankUB = 'BANKARD_CREDIT';
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* BinRange */
/* In this table, in the case of co-branding the primary network will be present as a foreign key (fk_id_network) and
   the 'alternative' network will be present through the field 'coBrandedCardNetwork' which contains a string that matches
   the field 'code' of the Network (it plays the same role as a foreign key, because the code is unique for each Network)
*/
SET @MaestroJID = (SELECT `id` FROM `Network` WHERE `code` = 'JCB');
SET @MaestroJName = (SELECT `name` FROM `Network` WHERE `code` = 'JCB');

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '3563860100', 16, FALSE, NULL, '3563860999', FALSE, @ProfileSet, @MaestroJID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '3563861200', 16, FALSE, NULL, '3563861299', FALSE, @ProfileSet, @MaestroJID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '3562880100', 16, FALSE, NULL, '3562880699', FALSE, @ProfileSet, @MaestroJID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '3562887000', 16, FALSE, NULL, '3562887999', FALSE, @ProfileSet, @MaestroJID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='3563860100' AND b.upperBound='3563860999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='3563861200' AND b.upperBound='3563861299' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='3562880100' AND b.upperBound='3562880699' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='3562887000' AND b.upperBound='3562887999' AND b.fk_id_profileSet=@ProfileSet
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
         'en', 1, @currentPageType, @BankB, @MaestroJID, im.id, @customItemSetREFUSAL 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'JCB Logo', 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'J/Secure™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%JCB_LOGO%' AND n.code LIKE '%JCB%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'RCBC Bankard does not have a record of your mobile number. Please call 888-1-888.', @MaestroJID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Your mobile number is required for you to receive the dynamic One-Time Password (OTP) that is essential in completing your online transaction.', @MaestroJID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Payment declined', @MaestroJID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'No mobile number on record', @MaestroJID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroJID, NULL, @customItemSetREFUSAL);

		 
SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, 'To further enhance security whenever you use your RCBC Bankard to purchase online, RCBC Bankard has implemented the use of dynamic One-Time Password (OTP).', @MaestroJID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'The OTP will be sent to your registered mobile number and this has to be supplied in order to complete your transaction.', @MaestroJID, NULL, @customItemSetREFUSAL),
  
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @helpPage, 'To ensure a safe and secure online shopping experience, please ensure that your mobile number on file is updated. For any change in mobile number, please call 888-1-888.', @MaestroJID, NULL, @customItemSetREFUSAL);


/* Elements for the profile SMS : */
SET @currentAuthentMean = 'OTP_SMS';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the SMS Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankB, @MaestroJID, im.id, @customItemSetSMS 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'JCB Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'J/Secure™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%JCB_LOGO%' AND n.code LIKE '%JCB%';
  
/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'en', 0, 'MESSAGE_BODY',
        'Do not share your RCBC Bankard One-Time Password (OTP) to anyone. Your OTP is @otp for your transaction at @merchant. Expires in 4 mins.', @MaestroJID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Enter the One-Time Password (OTP) received by SMS.</b>', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'If you did not receive the OTP, please call RCBC Bankard Customer Service at 888-1-888.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @currentPageType, 'As an additional step to protect your credit card against possible fraudulent use, and to complete transaction, please enter the OTP that was sent to your registered mobile number. You should receive the OTP within four (4) minutes from the time you checked out.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'en', 12, @currentPageType, 'Authentication in progress', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'en', 13, @currentPageType, 'Your input is being checked and the page will be updated automatically in a few seconds.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'en', 14, @currentPageType, 'Transaction cancelled', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'en', 15, @currentPageType, 'You have cancelled the transaction.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'en', 26, @currentPageType, 'Authentication successful', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'en', 27, @currentPageType, 'Your authentication has been validated, you will be redirected to the shop.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'en', 28, @currentPageType, 'Wrong One-Time Password (OTP) entered', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'en', 29, @currentPageType, 'The OTP that you have entered is incorrect.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'en', 30, @currentPageType, 'Session expired', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'en', 31, @currentPageType, 'We´re sorry. Your session has expired and your purchase has been cancelled.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Technical Error', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'The purchase cannot be completed at this time. We apologize for any inconvenience. To re-try making a purchase, click Back to the shop.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'en', 40, @currentPageType, 'Cancel purchase', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroJID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */
SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, 'To further enhance security whenever you use your RCBC Bankard to purchase online, RCBC Bankard has implemented the use of dynamic One-Time Password (OTP).', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'The OTP will be sent to your registered mobile number and this has to be supplied in order to complete your transaction.', @MaestroJID, NULL, @customItemSetSMS),
  
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @helpPage, 'To ensure a safe and secure online shopping experience, please ensure that your mobile number on file is updated. For any change in mobile number, please call 888-1-888.', @MaestroJID, NULL, @customItemSetSMS);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'We´re sorry. You have entered the wrong One-Time Password (OTP) three (3) times.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Your purchase has not been completed. For concerns, please call RCBC Bankard Customer Service at 888-1-888.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, 'Identification failure', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'You have entered the wrong One-Time Password (OTP) three (3) times.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroJID, NULL, @customItemSetSMS);

/* Elements for the REFUSAL page, for SMS Profile */
SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'RCBC Bankard does not have a record of your mobile number. Please call 888-1-888.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Your mobile number is required for you to receive the dynamic One-Time Password (OTP) that is essential in completing your online transaction.', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Payment declined', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'No mobile number on record', @MaestroJID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroJName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroJID, NULL, @customItemSetSMS);

/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;
