/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
SET @createdBy ='A707825';
SET @issuerCode = '41001';
SET @subIssuerCode = '88000';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'SWISSKEY';
SET @BankUB = 'LLB';

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

SET @subIssuerIDSOBA = (SELECT id FROM SubIssuer where code = 83340 AND name = 'Baloise Bank SoBa AG');

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
SELECT `authorityCertificate`, `authorityCertificateExpiryDate`, `cardNetworkAlgorithm`,
       `cardNetworkIdentifier`, `cardNetworkSeqGenerationMethod`, `cardNetworkSignatureKey`,
       `rootCertificate`, `rootCertificateExpiryDate`, `signingCertificate`, `signingCertificateExpiryDate`,
       `fk_id_network`, @subIssuerID
FROM SubIssuerNetworkCrypto where fk_id_subIssuer = @subIssuerIDSOBA;
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
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4396640000', 16, FALSE, NULL, '4396640099', FALSE, @ProfileSet, @MaestroVID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4396640000' AND b.upperBound='4396640099' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

/* CustomItem */
/* Create custom items for default language and backup languages - in this example de and en */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;
SET @MaestroVID = NULL;
/* Elements for the profile DEFAULT_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
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
         'de', 1, @currentPageType, '<b>Zahlungsfreigabe nicht möglich</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (SMS oder App) für Ihre Karte gefunden haben. ', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Bitte hinterlegen Sie für Ihre Karte eine entsprechende Freigabe-Methode im Registrierungsportal gemäss der Anleitung Ihrer Bank. ', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174,@currentPageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175,@currentPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @helpPage, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @helpPage, 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank eine zwei-stufige Authentifikation eingeführt. ', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @helpPage, 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder anhand eines Freigabe-Codes per SMS, oder durch die Verifikation Ihrer Person auf einer Mobile Authentifikations-App bestätigen. Für diesen Service müssen Sie sich einmalig registrieren. Für den entsprechenden Registrierungsprozess, oder Änderungen Ihrer Authentifikationsmethode, wenden Sie sich bitte an Ihre Bank.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @helpPage, 'Hilfe-Text schliessen', @MaestroVID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetREFUSAL);

/*ENGLISH translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Payment approval not possible.</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. ', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @currentPageType, 'Please set up a corresponding approval method for your card on the registration portal according to your bank''s instructions. ', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Payment not completed – card is not registered for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'en', 100, 'ALL', 'Merchant', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'en', 101, 'ALL', 'Amount', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'en', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'en', 103, 'ALL', 'Card number', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'en', 104, 'ALL', 'Phone number', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174,@currentPageType, 'Close message', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175,@currentPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, '<b>Help</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'To boost security while paying online, your bank has introduced two-level authentification.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @helpPage, 'To complete a payment, you must confirm it either by means of an approval code per SMS, or through verification of your identity with a mobile authentication app. You need to register once for this service. Contact your bank for the corresponding registration process or changes to your authentification method.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @helpPage, 'Close help text', @MaestroVID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, 'Payment not completed – card is not registered for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close message', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetREFUSAL);


/*FRENCH translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'fr', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Activation de paiement impossible</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte. ', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'fr', 3, @currentPageType, 'Veuillez consigner une méthode d''activation pour votre carte dans le portail d’inscription, conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'fr', 22, @currentPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'fr', 23, @currentPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'fr', 100, 'ALL', 'Commerçant', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'fr', 101, 'ALL', 'Montant', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'fr', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'fr', 103, 'ALL', 'Numéro de carte', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174,@currentPageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175,@currentPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @helpPage, '<b>Aide</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @helpPage, 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'fr', 3, @helpPage, 'Afin de pouvoir effectuer un paiement, vous devez le confirmer soit au moyen d''un code d''activation par SMS, soit par la vérification de votre personne sur une App d''authentification mobile. Pour ce service, vous devez vous enregistrer une fois. Pour la procédure d''enregistrement correspondante, ou pour les modifications de votre méthode d''authentification, veuillez vous adresser à votre banque.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @helpPage, 'Fermer le texte d''aide', @MaestroVID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'fr', 16, @currentPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'fr', 17, @currentPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetREFUSAL);



/*Italian translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'it', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'it', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Autorizzazione di pagamento non possibile</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta. ', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'it', 3, @currentPageType, 'Stabilisca un metodo di autenticazione corrispondente per la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'it', 22, @currentPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'it', 23, @currentPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'it', 100, 'ALL', 'Commerciante', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'it', 101, 'ALL', 'Importo', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'it', 102, 'ALL', 'Data', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'it', 103, 'ALL', 'Numero della carta', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'it', 104, 'ALL', 'Numero di telefono', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174,@currentPageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175,@currentPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @helpPage, '<b>Aiuto</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @helpPage, 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi. ', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'it', 3, @helpPage, 'Per poter effettuare un pagamento, deve confermarlo utilizzando un codice di autenticazione tramite SMS o verificando la sua persona su un’app di autenticazione mobile. Deve effettuare una volta la registrazione per questo servizio. Si rivolga alla sua banca per il processo di registrazione corrispondente o per modifiche al metodo di autenticazione.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @helpPage, 'Chiudere il testo di aiuto', @MaestroVID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'it', 16, @currentPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'it', 17, @currentPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetREFUSAL);

SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusalMissing FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusal;


/* Elements for the profile SMS : */
SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the SMS Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'de', 0, 'MESSAGE_BODY',
        'Sie haben einen Freigabe-Code für eine Online-Zahlung angefordert. Bitte verwenden Sie folgenden Code: @otp', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>SMS-Freigabe der Zahlung</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Wir haben Ihnen zur Bestätigung der Zahlung einen Freigabe-Code auf Ihr Mobil-Telefon gesendet. ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Bitte prüfen Sie die Zahlungsdetails links und bestätigen Sie die Zahlung durch Eingabe des Freigabe-Codes.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12, @currentPageType, 'Zahlungsfreigabe wird geprüft', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'de', 13, @currentPageType, 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14, @currentPageType, 'Zahlungsfreigabe abgebrochen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15, @currentPageType, 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess trotzdem fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), 'PUSHED_TO_CONFIG',
         'de', 19, @currentPageType, 'Neuen Freigabe-Code anfordern', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'de', 22, @currentPageType, 'Freigabe fehlgeschlagen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'de', 23, @currentPageType, 'Sie haben 3 Mal einen fehlerhaften Freigabe-Code eingegeben. Ihre Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Ihre Karte wird nun aus Sicherheitsgründen während einer kurzen Zeitdauer für Online Zahlungen blockiert. ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'de', 26, @currentPageType, 'Zahlungsfreigabe war erfolgreich', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'de', 27, @currentPageType, 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum Händler weitergeleitet.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'de', 28, @currentPageType, 'Fehlerhafter Freigabe-Code', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'de', 29, @currentPageType, 'Der von Ihnen eingegebene Freigabe-Code ist nicht korrekt. Die Zahlung wurde nicht ausgeführt und Ihre Karte wurde nicht belastet. Sofern Sie den Kauf fortsetzen wollen, versuchen Sie es erneut.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30, @currentPageType, 'Zahlung nicht ausgeführt - Sitzung abgelaufen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31, @currentPageType, 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zurück zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung tätigen wollen.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Freigabe fehlgeschlagen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Sie haben 3 Mal einen fehlerhaften Freigabe-Code eingegeben. Ihre Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Ihre Karte wird nun aus Sicherheitsgründen während einer kurzen Zeitdauer für Online-Zahlungen blockiert.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
         'de', 34, @currentPageType, 'SMS-Code wird versendet', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
         'de', 35, @currentPageType, 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie einen neuen Bestätigungscode an Ihre Mobilnummer für Sicherheitsnachrichten.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Zahlung abbrechen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Freigeben', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank eine zwei-stufige Authetifikation eingeführt. ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Um eine Zahlung freizugeben, bestätigen Sie diese mit einem Freigabe-Code, welchen Sie per SMS erhalten. Bei jedem Kauf wird Ihnen per SMS ein neuer, einmaliger Code an die von Ihnen registrierte Telefonnummer gesendet. Für Änderungen Ihrer Telefonnummer, oder anderen Fragen zum Online-Einkauf mit Ihrer Karte, wenden Sie sich bitte an Ihre Bank.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Hilfe-Text schliessen', @MaestroVID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Freigabe fehlgeschlagen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, 'Sie haben 3 Mal einen fehlerhaften Freigabe-Code eingegeben. Ihre Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Ihre Karte wird nun aus Sicherheitsgründen während einer kurzen Zeitdauer für Online Zahlungen blockiert. ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetSMS);

/*ENGLISH translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'en', 0, 'MESSAGE_BODY',
        'You have requested an approval code for an online purchase. Please use the following code: @otp', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>SMS approval of the payment</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'We have sent an approval code to your mobile phone to approve the payment. ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @currentPageType, 'Please check the payment details to the left and confirm the payment by entering the approval code.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'en', 12, @currentPageType, 'Payment approval is being verified', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'en', 13, @currentPageType, 'Please be patient. We are verifying your payment approval and thereby the authentication for the requested payment.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'en', 14, @currentPageType, 'Payment approval cancelled', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'en', 15, @currentPageType, 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the payment process, please start the payment attempt again. ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), 'PUSHED_TO_CONFIG',
         'en', 19, @currentPageType, 'Request new approval code', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Approval failed', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'You have entered an incorrect approval code multiple times. Your payment could not be completed and your card was not debited. Your card will now be temporarily blocked for online payments for security reasons. ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'en', 26, @currentPageType, 'Successful payment approval', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'en', 27, @currentPageType, 'You have successfully approved the payment and will be automatically routed back to the merchant.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'en', 28, @currentPageType, 'Incorrect approval code', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'en', 29, @currentPageType, 'The approval code you entered is incorrect. The payment was not conducted and your card was not debited. Please try again if you wish to continue the purchase.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'en', 30, @currentPageType, 'Payment not completed – session expired', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'en', 31, @currentPageType, 'Too much time has passed before the payment was confirmed. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process, if you wish to make the payment.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Approval failed', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'You have entered an incorrect approval code multiple times. Your payment could not be completed and your card was not debited. Your card will now be temporarily blocked for online payments for security reasons.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
         'en', 34, @currentPageType, 'SMS code sent', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
         'en', 35, @currentPageType, 'Please wait, this may take a moment. A new confirmation code for security messages will be sent to your mobile phone.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'en', 40, @currentPageType, 'Cancel payment', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'en', 42, @currentPageType, 'Approve', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'en', 100, 'ALL', 'Merchant', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'en', 101, 'ALL', 'Amount', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'en', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'en', 103, 'ALL', 'Card number', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'en', 104, 'ALL', 'Phone number', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close message', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Help</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'To boost security while paying online, your bank has introduced two-level authentification. ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @currentPageType, 'To approve a payment, please confirm it with the approval code you receive via SMS. For each purchase an SMS is sent to you with a new one-time code at the telephone number you registered. For changes to your telephone number, or other questions about online shopping with you card, please contact your bank.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close Help', @MaestroVID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, 'Confirmation failed', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'You have entered an incorrect approval code multiple times. Your payment could not be completed and your card was not debited. Your card will now be temporarily blocked for online payments for security reasons. ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close message', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetSMS);

/*FRENCH translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'fr', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'fr', 0, 'MESSAGE_BODY',
        'Vous avez demandé un code d’activation pour un paiement en ligne. Veuillez utiliser le code suivant : @otp', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>SMS - Activation du paiement</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Pour la confirmation du paiement, nous vous avons envoyé un code d''activation sur votre téléphone portable. ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'fr', 3, @currentPageType, 'Veuillez vérifier les détails du paiement à gauche et confirmez le paiement en saisissant le code d''activation.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'fr', 12, @currentPageType, 'L''activation de paiement va être vérifiée', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'fr', 13, @currentPageType, 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'fr', 14, @currentPageType, 'Activation de paiement interrompue', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'fr', 15, @currentPageType, 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), 'PUSHED_TO_CONFIG',
         'fr', 19, @currentPageType, 'Demander un nouveau code d''activation', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'fr', 22, @currentPageType, 'L''activation a échoué', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'fr', 23, @currentPageType, 'Vous avez saisi 3 fois un mauvais code d''activation. Votre paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'fr', 26, @currentPageType, 'L’activation du paiement a réussi', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'fr', 27, @currentPageType, 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'fr', 28, @currentPageType, 'Code d''activation erroné', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'fr', 29, @currentPageType, 'Le code d''activation que vous avez saisi n''est pas correct. Le paiement n''a pas été effectué et votre carte n''a pas été débitée. Si vous voulez continuer l''achat, essayez à nouveau.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'fr', 30, @currentPageType, 'Paiement non effectué - La session a expiré', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'fr', 31, @currentPageType, 'Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'L''activation a échoué', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'Vous avez saisi 3 fois un mauvais code d''activation. Votre paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
         'fr', 34, @currentPageType, 'Vous allez recevoir un code par SMS', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
         'fr', 35, @currentPageType, 'Veuillez patienter un instant. Vous recevrez d’ici peu un nouveau code de confirmation sur votre numéro de mobile pour les notifications de sécurité.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'fr', 40, @currentPageType, 'Interrompre le paiement', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'fr', 42, @currentPageType, 'Activer', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'fr', 100, 'ALL', 'Commerçant', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'fr', 101, 'ALL', 'Montant', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'fr', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'fr', 103, 'ALL', 'Numéro de carte', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetSMS);



/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Aide</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes. ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'fr', 3, @currentPageType, 'Afin d''activer un paiement, confirmez celui-ci avec un code d''activation que vous avez reçu par SMS. Lors de chaque achat, un nouveau code unique vous sera envoyé par SMS au numéro de téléphone que vous avez enregistré. Pour modifier votre numéro de téléphone ou pour toute autre question concernant les achats en ligne avec votre carte, veuillez vous adresser à votre banque.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'fr', 16, @currentPageType, 'L''activation a échoué', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'fr', 17, @currentPageType, 'Vous avez saisi 3 fois un mauvais code d''activation. Votre paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetSMS);

/*ITALIAN translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'it', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'it', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'it', 0, 'MESSAGE_BODY',
        'Ha richiesto un codice di autenticazione per un pagamento online. Utilizzi il seguente codice: @otp', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Autorizzazione del pagamento via SMS</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Le abbiamo inviato un codice di autenticazione sul suo cellulare per confermare il pagamento.  ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'it', 3, @currentPageType, 'Controlli i dettagli del pagamento a sinistra e confermi il pagamento inserendo il codice di autorizzazione.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'it', 12, @currentPageType, 'L’autorizzazione di pagamento viene controllata', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'it', 13, @currentPageType, 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'it', 14, @currentPageType, 'Autorizzazione di pagamento annullata', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'it', 15, @currentPageType, 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), 'PUSHED_TO_CONFIG',
         'it', 19, @currentPageType, 'Richiede un nuovo codice di autenticazione', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'it', 22, @currentPageType, 'Autenticazione fallita', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'it', 23, @currentPageType, 'Ha inserito 3 volte il codice di autenticazione errato. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'it', 26, @currentPageType, 'L’autorizzazione di pagamento è andata a buon fine', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'it', 27, @currentPageType, 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'it', 28, @currentPageType, 'Codice di autenticazione errato', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'it', 29, @currentPageType, 'Il codice di autenticazione da lei inserito non è corretto. Il pagamento non è stato eseguito e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, provi nuovamente.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'it', 30, @currentPageType, 'Indietro al negozio online Pagamento non effettuato - Sessione scaduta', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'it', 31, @currentPageType, 'È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Autenticazione fallita', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Ha inserito 3 volte il codice di autenticazione errato. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
         'it', 34, @currentPageType, 'Codice SMS inviato.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
         'it', 35, @currentPageType, 'La preghiamo di attendere. A breve riceverà un nuovo codice di conferma sul suo numero di cellulare per messaggi sulla sicurezza.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'it', 40, @currentPageType, 'Interrompere il pagamento', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'it', 42, @currentPageType, 'Autorizzare', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'it', 100, 'ALL', 'Commerciante', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'it', 101, 'ALL', 'Importo', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'it', 102, 'ALL', 'Data', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'it', 103, 'ALL', 'Numero della carta', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'it', 104, 'ALL', 'Numero di telefono', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Aiuto</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi. ', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'it', 3, @currentPageType, 'Per autorizzare un pagamento, lo confermi con un codice di autenticazione che riceverà tramite SMS. A ogni acquisto le verrà inviato tramite SMS un nuovo codice univoco al numero di telefono da lei registrato. Si rivolga alla sua banca per modificare il suo numero di telefono o per altre domande sugli acquisti online con la sua carta.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'it', 16, @currentPageType, 'Autenticazione fallita', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'it', 17, @currentPageType, 'Ha inserito 3 volte il codice di autenticazione errato. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetSMS);

SET @currentAuthentMean = 'EXT_PASSWORD';
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'));
SET @currentPageType = 'OTP_FORM_PAGE';

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

   /*PASSWORD_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Passwort-Freigabe der Zahlung</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Bitte prüfen Sie die Zahlungsdetails links und bestätigen Sie die Zahlung durch Eingabe Ihres Passworts.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12,@currentPageType, 'Zahlungsfreigabe wird geprüft', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'de', 13,@currentPageType, 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'de', 14,@currentPageType, 'Zahlungsfreigabe abgebrochen', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'de', 15,@currentPageType, 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess trotzdem fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'de', 26,@currentPageType, 'Zahlungsfreigabe war erfolgreich', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'de', 27,@currentPageType, 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum Händler weitergeleitet.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'de', 28, @currentPageType, 'Passwort nicht korrekt', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'de', 29, @currentPageType, 'Das eingegebene Passwort ist nicht korrekt. Die Zahlung wurde nicht ausgeführt und Ihre Karte wurde nicht belastet. Sofern Sie den Kauf fortsetzen wollen, versuchen Sie es bitte erneut.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'de', 30,@currentPageType, 'Zahlung nicht ausgeführt - Sitzung abgelaufen', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'de', 31,@currentPageType, 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zurück zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung tätigen wollen.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32,@currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33,@currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'de', 40, @currentPageType, 'Zahlung abbrechen', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'de', 42, @currentPageType, 'Freigeben', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Hilfe schließen', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetPassword);


/* Elements for the HELP page, for EXT_PASSWORD Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'de', 1, @currentPageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'de', 2, @currentPageType, 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank eine zwei-stufige Authentifikation eingeführt. ', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'de', 3, @currentPageType, 'Um eine Zahlung freizugeben bestätigen Sie diese mit Ihrem Passwort, welches Sie Bei der Registrierung des Services definiert haben. Für Änderungen Ihres Passworts, oder anderen Fragen zum Online-Einkauf mit Ihrer Karte wenden Sie sich an Ihre Bank.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Hilfe schließen', @MaestroVID, NULL, @customItemSetPassword);


/* Elements for the FAILURE page, for EXT_PASSWORD Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'de', 16, @currentPageType, 'Freigabe fehlgeschlagen', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'de', 17, @currentPageType, 'Sie haben Ihr Passwort 3 Mal falsch eingegeben. Ihre Zahlung konnte nicht abgeschlossen werden. Ihre Karte wird nun aus Sicherheitsgründen während einer kurzen Zeitdauer für Online-Zahlungen blockiert.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'de', 174, @currentPageType, 'Hilfe schließen', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetPassword);



/*ENGLISH translations for PASSWORD*/
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetPassword
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetPassword
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

   /*PASSWORD_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Password approval of the  payment</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Please check the payment details to the left and approve the payment by entering your password.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'en', 12,@currentPageType, 'Payment approval is being verified', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'en', 13,@currentPageType, 'Please be patient. We are verifying your payment approval and thereby the authentication for the requested payment.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'en', 14,@currentPageType, 'Payment approval cancelled', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'en', 15,@currentPageType, 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the payment process, please start the payment attempt again.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'en', 26,@currentPageType, 'Successful payment approval', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'en', 27,@currentPageType, 'You have successfully approved the payment and will be automatically routed back to the merchant.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'en', 28, @currentPageType, 'Incorrect password', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'en', 29, @currentPageType, 'The password entered is incorrect. The payment was not conducted and your card was not debited. Please try again if you wish to continue the purchase.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'en', 30,@currentPageType, 'Payment not completed – session expired', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'en', 31,@currentPageType, 'Too much time has passed before the payment was approved. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process, if you wish to make the payment.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32,@currentPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33,@currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'en', 40, @currentPageType, 'Cancel payment', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'en', 42, @currentPageType, 'Approve', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'en', 100, 'ALL', 'Merchant', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'en', 101, 'ALL', 'Amount', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'en', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'en', 103, 'ALL', 'Card number', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'en', 104, 'ALL', 'Phone number', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close Help', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetPassword);



/* Elements for the HELP page, for EXT_PASSWORD Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Help</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'To boost security while paying online, your bank has introduced two-level authentification. ', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @currentPageType, 'To approve a payment, please confirm it with your password which you defined when registering for the service. For changes to your password, or other questions about online shopping with you card, please contact your bank.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close Help', @MaestroVID, NULL, @customItemSetPassword);


/* Elements for the FAILURE page, for EXT_PASSWORD Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, 'Approval failed', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'You entered your password incorrectly 3 times. Your payment could not be completed. Your card will now be temporarily blocked for online payments for security reasons.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close Help', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetPassword);



/*FRENCH translations for PASSWORD*/
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'fr', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetPassword
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetPassword
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

   /*PASSWORD_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Mot de passe - Activation de paiement</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Veuillez vérifier les détails de paiement à gauche et activer le paiement en saisissant votre mot de passe.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'fr', 12,@currentPageType, 'L''activation de paiement va être vérifiée', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'fr', 13,@currentPageType, 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'fr', 14,@currentPageType, 'Activation de paiement interrompue', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'fr', 15,@currentPageType, 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'fr', 26,@currentPageType, 'L’activation du paiement a réussi', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'fr', 27,@currentPageType, 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'fr', 28, @currentPageType, 'Le mot de passe n''est pas correct', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'fr', 29, @currentPageType, 'Le mot de passe saisi n''est pas correct. Le paiement n''a pas été effectué et votre carte n''a pas été débitée. Si vous voulez continuer l''achat, essayez à nouveau.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'fr', 30,@currentPageType, 'Paiement non effectué - La session a expiré', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'fr', 31,@currentPageType, 'Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32,@currentPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33,@currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'fr', 40, @currentPageType, 'Interrompre le paiement', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'fr', 42, @currentPageType, 'Activer', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'fr', 100, 'ALL', 'Commerçant', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'fr', 101, 'ALL', 'Montant', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'fr', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'fr', 103, 'ALL', 'Numéro de carte', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetPassword);



/* Elements for the HELP page, for EXT_PASSWORD Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Aide</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes. ', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'fr', 3, @currentPageType, 'Pour activer un paiement, confirmez celui-ci avec le mot de passe que vous avez défini lors de l''enregistrement du service. Pour toute modification de votre mot de passe ou en cas de questions concernant les achats en ligne, veuillez vous adresser à votre banque.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetPassword);


/* Elements for the FAILURE page, for EXT_PASSWORD Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'fr', 16, @currentPageType, 'L''activation a échoué', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'fr', 17, @currentPageType, 'Vous avez saisi votre mot de passe 3 fois de manière erronée. Votre paiement n''a pas pu être terminé. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetPassword);



/*ITALIAN translations for PASSWORD*/
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'it', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetPassword
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'it', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetPassword
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

   /*PASSWORD_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Autorizzazione password per il pagamento</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Controlli i dettagli del pagamento a sinistra e confermi il pagamento inserendo la password.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'it', 12,@currentPageType, 'L’autorizzazione di pagamento viene controllata', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'it', 13,@currentPageType, 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'it', 14,@currentPageType, 'Autorizzazione di pagamento annullata', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'it', 15,@currentPageType, 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'it', 26,@currentPageType, 'L’autorizzazione di pagamento è andata a buon fine', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'it', 27,@currentPageType, 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'it', 28, @currentPageType, 'La password non è corretta', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'it', 29, @currentPageType, 'La password inserita non è corretta. Il pagamento non è stato eseguito e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di provare nuovamente.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'it', 30,@currentPageType, 'Pagamento non effettuato - Sessione scaduta', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'it', 31,@currentPageType, 'È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32,@currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33,@currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'it', 40, @currentPageType, 'Interrompere il pagamento', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'it', 42, @currentPageType, 'Autorizzare', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'it', 100, 'ALL', 'Commerciante', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'it', 101, 'ALL', 'Importo', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'it', 102, 'ALL', 'Data', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'it', 103, 'ALL', 'Numero della carta', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'it', 104, 'ALL', 'Numero di telefono', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetPassword);



/* Elements for the HELP page, for EXT_PASSWORD Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Aiuto</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'it', 3, @currentPageType, ' Per autorizzare un pagamento, lo confermi con la password che ha definito al momento della registrazione al servizio. Si rivolga alla sua banca per modificare la sua password o per altre domande sugli acquisti online con la sua carta.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetPassword);


/* Elements for the FAILURE page, for EXT_PASSWORD Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'it', 16, @currentPageType, 'L’autorizzazione di pagamento è stata annullata', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'it', 17, @currentPageType, 'Ha inserito 3 volte la password in modo errato. Non è stato possibile portare a termine il pagamento. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetPassword),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetPassword);



/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;
