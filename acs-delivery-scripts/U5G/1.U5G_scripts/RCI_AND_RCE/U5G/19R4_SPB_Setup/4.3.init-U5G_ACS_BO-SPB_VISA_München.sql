/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

SET @createdBy ='A758582';
SET @issuerCode = '16950';
/* SubIssuer */
SET @subIssuerNameAndLabel = 'SBK_München';
SET @subIssuerCode = '17009';

SET @BankB = 'SBK_München';
SET @BankUB = 'SBK_München';

SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
SET @profileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01') and `fk_id_subIssuer` = @subIssuerID);

SET @NetworkCode = 'VISA';
SET @NetworkID = (SELECT `id` FROM `Network` WHERE `code` = @NetworkCode);
SET @NetworkName = (SELECT `name` FROM `Network` WHERE `code` = @NetworkCode);

SET @NetworkCustomItemName = 'Visa Logo';
SET @NetworkCustomItemValue = 'Verified by Visa™';
SET @NetworkImageNameLike = '%VISA_LOGO%';
SET @NetworkImageCodeLike = '%VISA%';

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
  SELECT 'MIIFGzCCBAOgAwIBAgIRANh0YTBB/DxEoLzGXWw28RAwDQYJKoZIhvcNAQELBQAwazELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMRwwGgYDVQQDExNWaXNhIGVDb21tZXJjZSBSb290MB4XDTE1MDYyNDE1MjcwNloXDTIyMDYyMjAwMTYwN1owcTELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMSIwIAYDVQQDExlWaXNhIGVDb21tZXJjZSBJc3N1aW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArkmC50Q+GkmQyZ29kKxp1d+nJ43JwXhGZ7aFF1PiM5SlCESQ22qV/lBA3wHYYP8i17/GQQYNBiF3u4r6juXIHFwjwvKyFMF6kmBYXvcQa8Pd75FC1n3ffIrhEj+ldbmxidzK0hPfYyXEZqDpHhkunmvD7qz1BEWKE7NUYVFREfopViflKiVZcYrHi7CJAeBNY7dygvmIMnHUeH4NtDS5qf/n9DQQffVyn5hJWi5PeB87nTlty8zdji2tj7nA2+Y3PLKRJU3y1IbchqGlnXqxaaKfkTLNsiZq9PTwKaryH+um3tXf5u4mulzRGOWh2U+Uk4LntmMFCb/LqJkWnUVe+wIDAQABo4IBsjCCAa4wHwYDVR0jBBgwFoAUFTiDDz8sP3AzHs1G/geMIODXw7cwEgYDVR0TAQH/BAgwBgEB/wIBADA5BgNVHSAEMjAwMC4GBWeBAwEBMCUwIwYIKwYBBQUHAgEWF2h0dHA6Ly93d3cudmlzYS5jb20vcGtpMIIBCwYDVR0fBIIBAjCB/zA2oDSgMoYwaHR0cDovL0Vucm9sbC52aXNhY2EuY29tL1Zpc2FDQWVDb21tZXJjZVJvb3QuY3JsMDygOqA4hjZodHRwOi8vd3d3LmludGwudmlzYWNhLmNvbS9jcmwvVmlzYUNBZUNvbW1lcmNlUm9vdC5jcmwwgYaggYOggYCGfmxkYXA6Ly9FbnJvbGwudmlzYWNhLmNvbTozODkvY249VmlzYSBlQ29tbWVyY2UgUm9vdCxvPVZJU0Esb3U9VmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFN/DKlUuL0I6ekCdkqD3R3nXj4eKMA0GCSqGSIb3DQEBCwUAA4IBAQB9Y+F99thHAOhxZoQcT9CbConVCtbm3hWlf2nBJnuaQeoftdOKWtj0YOTj7PUaKOWfwcbZSHB63rMmLiVm7ZqIVndWxvBBRL1TcgbwagDnLgArQMKHnY2uGQfPjEMAkAnnWeYJfd+cRJVo6K3R4BbQGzFSHa2i2ar6/oXzINyaxAXdoG04Cz2P0Pm613hMCpjFyYilS/425he1Tk/vHsTnFwFlk9yY2L8VhBa6j40faaFu/6fin78Kopk96gHdAIN1tbA12NNmr7bQ1pUs0nKHhzQGoRXguYd7UYO9i2sNVC1C5A3F8dopwsv2QK2+33q05O2/4DgnF4m5us6RV94D',
    NULL, 'CVV_WITH_ATN', '241122334455434156565F4D5554555F414300', 'STRING_TIMESTAMP', 'ED11223344554B544F525F4D5554555F414311',
    'MIIDojCCAoqgAwIBAgIQE4Y1TR0/BvLB+WUF1ZAcYjANBgkqhkiG9w0BAQUFADBrMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xHDAaBgNVBAMTE1Zpc2EgZUNvbW1lcmNlIFJvb3QwHhcNMDIwNjI2MDIxODM2WhcNMjIwNjI0MDAxNjEyWjBrMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xHDAaBgNVBAMTE1Zpc2EgZUNvbW1lcmNlIFJvb3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvV95WHm6h2mCxlCfLF9sHP4CFT8icttD0b0/Pmdjh28JIXDqsOTPHH2qLJj0rNfVIsZHBAk4ElpF7sDPwsRROEW+1QK8bRaVK7362rPKgH1g/EkZgPI2h4H3PVz4zHvtH8aoVlwdVZqW1LS7YgFmypw23RuwhY/81q6UCzyr0TP579ZRdhE2o8mCP2w4lPJ9zcc+U30rq299yOIzzlr3xF7zSujtFWsan9sYXiwGd/BmoKoMWuDpI/k4+oKsGGelT84ATB+0tvz8KPFUgOSwsAGl0lUq8ILKpeeUYiZGo3BxN77t+Nwtd/jmliFKMAGzsGHxBvfaLdXe6YJ2E5/4tAgMBAAGjQjBAMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQVOIMPPyw/cDMezUb+B4wg4NfDtzANBgkqhkiG9w0BAQUFAAOCAQEAX/FBfXxcCLkr4NWSR/pnXKUTwwMhmytMiUbPWU3J/qVAtmPN3XEolWcRzCSs00Rsca4BIGsDoo8Ytyk6feUWYFN4PMCvFYP3j1IzJL1kk5fui/fbGKhtcbP3LBfQdCVp9/5rPJS+TUtBjE7ic9DjkCJzQ83z7+pzzkWKsKZJ/0x9nXGIxHYdkFsd7v3M9+79YKWxehZx0RbQfBI8bGmX265fOZpwLwU8GUYEmSA20GBuYQa7FkKMcPcw++DbZqMAAb3mLNqRX6BGi01qnD093QVG/na/oAo85ADmJ7f/hC3euiInlhBx6yLt398znM/jra6O1I7mT1GvFpLgXPYHDw==',
    NULL, 'MIIFUTCCBDmgAwIBAgIQNGkVAwj/6btPCxH1ZOokdjANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJVUzENMAsGA1',
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
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4908040000', 16, TRUE, NULL, '4908049999', FALSE, @profileSet, @NetworkID, NULL);


/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, @subIssuerID
  FROM BinRange b
  WHERE b.lowerBound='4908040000' AND b.upperBound='4908049999' AND b.fk_id_profileSet=@profileSet;

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

SET @Imageid = (SELECT `id` FROM `Image` im WHERE im.name = 'MOBILE_APP_Logo');
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