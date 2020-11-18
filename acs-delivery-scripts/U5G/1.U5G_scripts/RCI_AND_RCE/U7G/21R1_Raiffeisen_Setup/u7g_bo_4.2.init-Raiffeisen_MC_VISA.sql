/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
SET @createdBy ='A709391';
SET @issuerCode = '80808';
SET @subIssuerCode = '80808';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankUB = 'RCH';

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');

/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
SELECT n.id, si.id
FROM `Network` n, `SubIssuer` si
WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
  AND n.code = 'VISA';

INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
SELECT n.id, si.id
FROM `Network` n, `SubIssuer` si
WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
  AND n.code = 'MASTERCARD';
/*!40000 ALTER TABLE `Network_SubIssuer` ENABLE KEYS */;

SET @subIssuerIDSOBA = (SELECT id FROM SubIssuer where code = 83340 AND name = 'Baloise Bank SoBa AG');

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
('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4395900000', 16, FALSE, NULL, '4395901999', FALSE, @ProfileSet, @MaestroVID, NULL);

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5574520000', 16, FALSE, NULL, '5574520999', FALSE, @ProfileSet, @MaestroMID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
SELECT b.id, s.id
FROM BinRange b, SubIssuer s
WHERE b.lowerBound = '4395900000' AND b.upperBound = '4395901999'
  AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
SELECT b.id, s.id
FROM BinRange b, SubIssuer s
WHERE ((b.lowerBound = '5574520000' and b.upperBound = '5574520999'))
  AND b.fk_id_profileSet=@ProfileSet
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
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
       'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Zahlungsfreigabe nicht möglich</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (SMS oder App) für Ihre Raiffeisen Karte gefunden haben. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Bitte hinterlegen Sie für Ihre Karte eine entsprechende Freigabe-Methode im Registrierungsportal. Ihre Raiffeisenbank hilft Ihnen bei Bedarf gerne weiter. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
 'de', 22, @currentPageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3-D Secure registriert', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
 'de', 23, @currentPageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3-D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetREFUSAL),

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
 'de', 2, @helpPage, 'Um Ihre Sicherheit bei Online-Zahlungen zu erhöhen, verwendet Raiffeisen ein zweistufiges Authentifikationsverfahren.  ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @helpPage, 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder anhand eines Freigabe-Codes per SMS oder durch die Verifikation Ihrer Person auf einer Mobile Authentifikations-App bestätigen. Für diesen Service müssen Sie sich einmalig registrieren.Für den entsprechenden Registrierungsprozess oder Änderungen Ihrer Authentifikationsmethode, wenden Sie sich bitte an Ihre Raiffeisenbank.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @helpPage, 'Hilfe-Text schliessen', @MaestroVID, NULL, @customItemSetREFUSAL);


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
 'de', 33, @currentPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet.Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetREFUSAL),

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
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
       'en', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'en', 1, @currentPageType, '<b>Payment approval not possible.</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'en', 2, @currentPageType, 'Unfortunately, we were not able to execute your request because we could not find an approval method (SMS or app) for your Raiffeisen card. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'en', 3, @currentPageType, 'Please add an approval method for your card in the registration portal. Your Raiffeisen bank will be happy to help you if required. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
 'en', 22, @currentPageType, 'Payment not completed – card is not registered for 3-D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
 'en', 23, @currentPageType, 'The payment could not be completed because your card is not registered for 3-D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroVID, NULL, @customItemSetREFUSAL),

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
 'en', 2, @helpPage, 'To make your online payments more secure, Raiffeisen uses a two-factor authentication procedure.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'en', 3, @helpPage, 'To complete a payment, you must confirm it either by means of an approval code per SMS, or through verification of your identity with a mobile authentication app. You need to register once for this service. To register for this or to make changes to your authentication method, please contact your Raiffeisen bank.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
 'en', 174, @helpPage, 'Close help text', @MaestroVID, NULL, @customItemSetREFUSAL);


SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'en', 16, @currentPageType, 'Payment not completed – card is not registered for 3-D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'en', 17, @currentPageType, 'The payment could not be completed because your card is not registered for 3-D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroVID, NULL, @customItemSetREFUSAL),

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
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
       'fr', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'fr', 1, @currentPageType, '<b>Activation de paiement impossible</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'fr', 2, @currentPageType, 'Malheureusement, nous n’avons pas pu exécuter votre demande, car nous n’avons trouvé aucune méthode de validation (SMS ou app) pour votre carte Raiffeisen. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'fr', 3, @currentPageType, 'Merci de fournir une méthode de validation appropriée pour votre carte dans le portail d’enregistrement. Votre Banque Raiffeisen se fera un plaisir de vous assister en cas de besoin.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
 'fr', 22, @currentPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3-D Secure', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
 'fr', 23, @currentPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3-D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetREFUSAL),

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
 'fr', 2, @helpPage, 'Raiffeisen utilise une méthode d’authentification en deux étapes afin renforcer votre sécurité lors de paiements en ligne. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'fr', 3, @helpPage, 'Afin de pouvoir effectuer un paiement, vous devez le confirmer soit au moyen d''un code d''activation par SMS, soit par la vérification de votre personne sur une App d''authentification mobile. Pour ce service, vous devez vous enregistrer une fois. Merci de bien vouloir contacter votre Banque Raiffeisen pour la procédure d’enregistrement correspondante ou pour toute modification de votre méthode d’authentification.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
 'fr', 174, @helpPage, 'Fermer le texte d''aide', @MaestroVID, NULL, @customItemSetREFUSAL);


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
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
       'it', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'it', 1, @currentPageType, '<b>Autorizzazione di pagamento non possibile</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'it', 2, @currentPageType, 'Purtroppo non è stato possibile elaborare la sua richiesta poiché non abbiamo trovato alcun metodo di autorizzazione (SMS o app) per la sua carta Raiffeisen.  ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'it', 3, @currentPageType, 'La preghiamo di inserire un relativo metodo di autorizzazione per la sua carta nel portale di registrazione. In caso di necessità, la sua Banca Raiffeisen sarà lieta di fornirle assistenza. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
 'it', 22, @currentPageType, 'Pagamento non eseguito - La carta non è registrata per 3-D Secure', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
 'it', 23, @currentPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3-D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetREFUSAL),

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
 'it', 2, @helpPage, 'Per aumentare la sua sicurezza nei pagamenti online, Raiffeisen utilizza una procedura di autentificazione a due livelli.  ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'it', 3, @helpPage, 'Per poter effettuare un pagamento, deve confermarlo utilizzando un codice di autenticazione tramite SMS o verificando la sua persona su un’app di autenticazione mobile. Deve effettuare una volta la registrazione per questo servizio. Per la relativa procedura di registrazione o per modifiche del suo metodo di autentificazione, la preghiamo di contattare la sua Banca Raiffeisen.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
 'it', 174, @helpPage, 'Chiudere il testo di aiuto', @MaestroVID, NULL, @customItemSetREFUSAL);


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
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusalMissing FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetREFUSAL;

SET @currentPageType = 'REFUSAL_PAGE';

SET @locale = 'en';
SET @text = 'Payment not completed';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22 AND pageTypes = @currentPageType AND locale = @locale AND fk_id_customItemSet =  @customItemSetRefusalMissing;

SET @text = 'Your card is temporarily blocked for online payments for security reasons. ';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23 AND pageTypes = @currentPageType AND locale = @locale AND fk_id_customItemSet =  @customItemSetRefusalMissing;

SET @text = 'Back to online shop';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 175 AND pageTypes = @currentPageType AND locale = @locale AND fk_id_customItemSet =  @customItemSetRefusalMissing;

SET @locale = 'de';
SET @text = 'Zahlung nicht ausgeführt';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22 AND pageTypes = @currentPageType AND locale = @locale AND fk_id_customItemSet =  @customItemSetRefusalMissing;

SET @text = 'Ihre Karte ist aus Sicherheitsgründen während einer kurzen Zeitdauer für Online-Zahlungen blockiert. ';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23 AND pageTypes = @currentPageType AND locale = @locale AND fk_id_customItemSet =  @customItemSetRefusalMissing;

SET @text = 'Zurück zum Online Shop';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 175 AND pageTypes = @currentPageType AND locale = @locale AND fk_id_customItemSet =  @customItemSetRefusalMissing;

SET @locale = 'fr';
SET @text = 'Le paiement n''a pas été effectué';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22 AND pageTypes = @currentPageType AND locale = @locale AND fk_id_customItemSet =  @customItemSetRefusalMissing;

SET @text = 'Pour des raisons de sécurité, votre carte est bloquée, pour une courte durée,  pour les paiements en ligne.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23 AND pageTypes = @currentPageType AND locale = @locale AND fk_id_customItemSet =  @customItemSetRefusalMissing;

SET @text = 'Retour vers la boutique en ligne';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 175 AND pageTypes = @currentPageType AND locale = @locale AND fk_id_customItemSet =  @customItemSetRefusalMissing;

SET @locale = 'it';
SET @text = 'Pagamento non eseguito';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22 AND pageTypes = @currentPageType AND locale = @locale AND fk_id_customItemSet =  @customItemSetRefusalMissing;

SET @text = 'Per motivi di sicurezza la sua carta è bloccata per i pagamenti online per un breve periodo di tempo.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23 AND pageTypes = @currentPageType AND locale = @locale AND fk_id_customItemSet =  @customItemSetRefusalMissing;

SET @text = 'Indietro al negozio online';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 175 AND pageTypes = @currentPageType AND locale = @locale AND fk_id_customItemSet =  @customItemSetRefusalMissing;


SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'));


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusalFraud FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetREFUSAL;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
 'de', 22, @currentPageType, 'Zahlung nicht ausgeführt', @MaestroVID, NULL, @customItemSetRefusalFraud),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
 'de', 23, @currentPageType, 'Ihre Karte ist aus Sicherheitsgründen während einer kurzen Zeitdauer für Online-Zahlungen blockiert. ', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
 'en', 22, @currentPageType, 'Payment not completed', @MaestroVID, NULL, @customItemSetRefusalFraud),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
 'en', 23, @currentPageType, 'Your card is temporarily blocked for online payments for security reasons.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
 'fr', 22, @currentPageType, 'Le paiement n''a pas été effectué', @MaestroVID, NULL, @customItemSetRefusalFraud),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
 'fr', 23, @currentPageType, 'Pour des raisons de sécurité, votre carte est bloquée, pour une courte durée,  pour les paiements en ligne.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
 'it', 22, @currentPageType, 'Pagamento non eseguito', @MaestroVID, NULL, @customItemSetRefusalFraud),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
 'it', 23, @currentPageType, 'Per motivi di sicurezza la sua carta è bloccata per i pagamenti online per un breve periodo di tempo.', @MaestroVID, NULL, @customItemSetRefusalFraud);


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
        'Sie haben einen Freigabe-Code für eine Online-Zahlung angefordert. Bitte verwenden Sie folgenden Code: @otp', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>SMS-Freigabe der Zahlung</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Wir haben Ihnen zur Bestätigung der Zahlung einen Freigabe-Code auf Ihr Mobiltelefon gesendet. Bitte prüfen Sie die Zahlungsdetails auf der linken Seite und bestätigen Sie die Zahlung, indem Sie den erhaltenen Freigabe-Code im nachfolgenden Feld eingeben. ', @MaestroVID, NULL, @customItemSetSMS),

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
 'de', 29, @currentPageType, 'Der von Ihnen eingegebene Freigabe-Code ist nicht korrekt. Die Zahlung wurde nicht ausgeführt und Ihre Karte nicht belastet. Sofern Sie den Kauf fortsetzen wollen, versuchen Sie es erneut.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'de', 30, @currentPageType, 'Zahlung nicht ausgeführt - Sitzung abgelaufen', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'de', 31, @currentPageType, 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, wenn Sie die Zahlung tätigen möchten.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet.Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
 'de', 34, @currentPageType, 'SMS-Code wird versendet', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
 'de', 35, @currentPageType, 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie einen neuen Bestätigungscode an Ihre Mobilnummer. ', @MaestroVID, NULL, @customItemSetSMS),

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
 'de', 2, @currentPageType, 'Um Ihre Sicherheit bei Online-Zahlungen zu erhöhen, verwendet Raiffeisen ein zweistufiges Authentifikationsverfahren. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Um eine Zahlung freizugeben, bestätigen Sie diese mit einem Freigabe-Code, welchen Sie per SMS erhalten. Bei jedem Kauf wird Ihnen per SMS ein neuer, einmaliger Code an die von Ihnen registrierte Mobilnummer gesendet. Für Änderung Ihrer Mobilnummer oder Fragen zum Online-Einkauf mit Ihrer Karte, wenden Sie sich bitte an Ihre Raiffeisenbank. ', @MaestroVID, NULL, @customItemSetSMS),

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
 'de', 33, @currentPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet.Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetSMS),

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
        'You have requested an approval code for an online purchase. Please use the following code: @otp', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'en', 1, @currentPageType, '<b>SMS approval of the payment</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'en', 2, @currentPageType, 'We sent an approval code to your mobile phone, which you can use to confirm the payment. Please check the payment details on the left side and confirm the payment by entering the received approval code in the field below. ', @MaestroVID, NULL, @customItemSetSMS),

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
 'en', 29, @currentPageType, 'The approval code you entered is not correct. The payment was not carried out and your card was not charged. Please try again if you wish to continue the purchase.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'en', 30, @currentPageType, 'Payment not completed – session expired', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'en', 31, @currentPageType, 'Too much time has passed before the payment was confirmed. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process, if you wish to make the payment.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
 'en', 34, @currentPageType, 'SMS code sent', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
 'en', 35, @currentPageType, 'Please wait, this may take a moment. A new confirmation code will be sent to your mobile phone.', @MaestroVID, NULL, @customItemSetSMS),

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
 'en', 2, @currentPageType, 'To make your online payments more secure, Raiffeisen uses a two-factor authentication procedure.  ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'en', 3, @currentPageType, 'To approve a payment, please confirm it with the approval code you receive via SMS. For each purchase an SMS is sent to you with a new one-time code at the mobile phone number you registered. If you want to change your mobile phone number or have any questions about online purchases with your card, please contact your Raiffeisen bank.', @MaestroVID, NULL, @customItemSetSMS),

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
        'Vous avez demandé un code d’activation pour un paiement en ligne. Veuillez utiliser le code suivant : @otp', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'fr', 1, @currentPageType, '<b>SMS - Activation du paiement</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'fr', 2, @currentPageType, 'Pour confirmer le paiement, nous vous avons envoyé un code de validation sur votre téléphone mobile.  ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'fr', 3, @currentPageType, 'Veuillez vérifier les informations détaillées du paiement sur le côté gauche et confirmer le paiement en saisissant dans le champ ci-dessous le code de validation que vous avez reçu.', @MaestroVID, NULL, @customItemSetSMS),

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
 'fr', 29, @currentPageType, 'Le code de validation que vous avez saisi n’est pas correct. Le paiement n’a pas été exécuté et votre carte n’a pas été débitée. Si vous voulez continuer l''achat, essayez à nouveau.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'fr', 30, @currentPageType, 'Paiement non effectué - La session a expiré', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'fr', 31, @currentPageType, 'Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur le site de vente en ligne et recommencer la procédure de paiement si vous souhaitez effectuer le paiement.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
 'fr', 34, @currentPageType, 'Vous allez recevoir un code par SMS', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
 'fr', 35, @currentPageType, 'Veuillez patienter un instant. Vous recevrez d’ici peu un nouveau code de confirmation sur votre numéro de mobile.', @MaestroVID, NULL, @customItemSetSMS),

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
 'fr', 2, @currentPageType, 'Raiffeisen utilise une méthode d’authentification en deux étapes afin renforcer votre sécurité lors de paiements en ligne.  ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'fr', 3, @currentPageType, 'Afin d''activer un paiement, confirmez celui-ci avec un code d''activation que vous avez reçu par SMS. Lors de chaque achat, un nouveau code unique vous sera envoyé par SMS au numéro de mobile que vous avez enregistré. Pour changer votre numéro de mobile ou si vous avez des questions sur les achats en ligne avec votre carte, veuillez contacter votre Banque Raiffeisen.', @MaestroVID, NULL, @customItemSetSMS),

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
        'Ha richiesto un codice di autenticazione per un pagamento online. Utilizzi il seguente codice: @otp', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'it', 1, @currentPageType, '<b>Autorizzazione del pagamento via SMS</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'it', 2, @currentPageType, 'Le abbiamo inviato un codice di autorizzazione sul suo cellulare per confermare il pagamento.  ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'it', 3, @currentPageType, ' La preghiamo di controllare i dettagli del pagamento sul lato sinistro e di confermare il pagamento inserendo il codice di autorizzazione ricevuto nel campo seguente.', @MaestroVID, NULL, @customItemSetSMS),

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
 'it', 29, @currentPageType, 'Il codice di autorizzazione da lei inserito non è corretto. Il pagamento non è stato eseguito e non è stato effettuato alcun addebito sulla sua carta. Se desidera continuare l’acquisto, provi nuovamente.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'it', 30, @currentPageType, 'Indietro al negozio online Pagamento non effettuato - Sessione scaduta', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'it', 31, @currentPageType, 'È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Se desidera effettuare il pagamento la preghiamo di tornare allo shop online e di riavviare il processo di pagamento.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
 'it', 34, @currentPageType, 'Codice SMS inviato.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
 'it', 35, @currentPageType, 'La preghiamo di attendere. A breve riceverà un nuovo codice di conferma sul suo numero di cellulare.', @MaestroVID, NULL, @customItemSetSMS),

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
 'it', 2, @currentPageType, 'Per aumentare la sua sicurezza nei pagamenti online, Raiffeisen utilizza una procedura di autentificazione a due livelli.  ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'it', 3, @currentPageType, 'Per autorizzare un pagamento, lo confermi con un codice di autenticazione che riceverà tramite SMS. A ogni acquisto le verrà inviato tramite SMS un nuovo codice univoco al numero di cellulare da lei registrato. Per modificare il suo numero di cellulare o per domande sugli acquisti online con la sua carta, si rivolga alla sua Banca Raiffeisen.', @MaestroVID, NULL, @customItemSetSMS),

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



SET @currentAuthentMean = 'MOBILE_APP';
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @currentPageType = 'POLLING_PAGE';
SET @updateState = 'PUSHED_TO_CONFIG';
SET @locale = 'de';

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
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
       'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileApp
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/*MOBILE_APP_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Zahlung in der App freigeben</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Damit die Zahlung abgeschlossen werden kann, müssen Sie diese in der von Ihrer Bank zur Vergfügung gestellten App freigeben.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Sie sollten bereits eine entsprechende Benachrichtigung auf Ihrem Mobil-Telefon erhalten haben. Andernfalls können Sie direkt in die App einsteigen und die Zahlung dort verifizieren.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
 'de', 10, @currentPageType, 'Stattdessen Freigabe durch SMS anfordern', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'de', 12,@currentPageType, 'Zahlungsfreigabe wird geprüft', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'de', 13,@currentPageType, 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'de', 14,@currentPageType, 'Zahlungsfreigabe abgebrochen', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'de', 15,@currentPageType, 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Wenn Sie den Kaufprozess fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'de', 26,@currentPageType, 'Zahlungsfreigabe war erfolgreich', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'de', 27,@currentPageType, 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum Händler weitergeleitet.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'de', 30,@currentPageType, 'Zahlung nicht ausgeführt - Sitzung abgelaufen', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'de', 31,@currentPageType, 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung tätigen wollen.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32,@currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33,@currentPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet.Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'de', 40, @currentPageType, 'Zahlung abbrechen', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
 'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Hilfe schließen', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetMobileApp);


/* Elements for the HELP page, for MOBILE APP Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Um Ihre Sicherheit bei Online-Zahlungen zu erhöhen, hat Raiffeisen ein zweistufiges Authentifikationsverfahren eingeführt. ', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Sie können Online-Zahlungen auf Ihrem Smartphone in der entsprechenden Authentifikations-App von Raiffeisen freigeben. Bei Fragen oder Unklarheiten wenden Sie sich bitte an Ihre Raiffeisenbank.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Hilfe schliessen', @MaestroVID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'de', 16, @currentPageType, 'Freigabe fehlgeschlagen', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'de', 17, @currentPageType, 'Die Authentifikation auf Ihrem Smartphone ist fehlgeschlagen und somit die Zahlung nicht freigegeben. Der Zahlungsprozess wurde abgebrochen und Ihre Karte nicht belastet. Wenn Sie den Kaufprozess fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet.Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Hilfe schliessen', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetMobileApp);



/*ENGLISH translations for MOBILE_APP*/
SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
       'en', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileApp
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
       'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileApp
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

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
 'en', 1, @currentPageType, '<b>Approve payment in the app</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'en', 2, @currentPageType, 'To complete the payment, you must approve it in the app provided by your bank. ', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'en', 3, @currentPageType, 'You should already have received a corresponding message on your mobile phone. Otherwise, you can open the app directly and approve the payment there.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
 'en', 10, @currentPageType, 'Request approval via SMS instead', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'en', 12,@currentPageType, 'Payment approval is being verified', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'en', 13,@currentPageType, 'Please be patient. We are verifying your payment approval and thereby the authentification for the requested payment.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'en', 14,@currentPageType, 'Payment approval cancelled', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'en', 15,@currentPageType, 'The payment was cancelled and your card was not debited. If you wish to continue the purchase process, please attempt payment again.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'en', 26,@currentPageType, 'Successful payment approval', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'en', 27,@currentPageType, 'You have successfully approved the payment and will be automatically routed back to the merchant.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'en', 30,@currentPageType, 'Payment not completed – session expired', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'en', 31,@currentPageType, 'Too much time has passed before the payment was approved. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process if you wish to make the payment.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'en', 32,@currentPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'en', 33,@currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'en', 40, @currentPageType, 'Cancel payment', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'en', 100, 'ALL', 'Merchant', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'en', 101, 'ALL', 'Amount', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'en', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'en', 103, 'ALL', 'Card number', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
 'en', 104, 'ALL', 'Phone number', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'en', 174, @currentPageType, 'Close Help', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'en', 175, @currentPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetMobileApp);



/* Elements for the HELP page, for MOBILE APP Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
 'en', 1, @currentPageType, '<b>Help</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
 'en', 2, @currentPageType, 'To make your online payments more secure, Raiffeisen uses a two-factor authentication procedure.  ', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'en', 3, @currentPageType, 'You can approve online payments in the corresponding Raiffeisen authentication app on your smartphone. Please contact your Raiffeisen bank if you have any questions or if anything is unclear.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
 'en', 174, @currentPageType, 'Close Help', @MaestroVID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'en', 16, @currentPageType, 'Approval failed', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'en', 17, @currentPageType, 'The authentication on your smartphone failed and the payment was not approved. The payment process was cancelled and your card was not debited. If you wish to continue the purchase process, please attempt payment again. ', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'en', 174, @currentPageType, 'Close Help', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'en', 175, @currentPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetMobileApp);



/*FRENCH translations for MOBILE_APP*/
SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
       'fr', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileApp
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
       'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileApp
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

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
 'fr', 1, @currentPageType, '<b>Activer le paiement dans l''App</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'fr', 2, @currentPageType, 'Pour que le paiement puisse être terminé, vous devez l''activer dans l''App mise à disposition par votre banque. ', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'fr', 3, @currentPageType, 'Vous devriez déjà avoir reçu un message correspondant sur votre téléphone portable. Dans le cas contraire, vous pouvez aller directement dans votre App et y vérifier le paiement.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
 'fr', 10, @currentPageType, 'À la place, demander l''activation pas SMS', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'fr', 12,@currentPageType, 'L''activation de paiement va être vérifiée', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'fr', 13,@currentPageType, 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'fr', 14,@currentPageType, 'Activation de paiement interrompue', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'fr', 15,@currentPageType, 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez poursuivre le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'fr', 26,@currentPageType, 'L’activation du paiement a réussi', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'fr', 27,@currentPageType, 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'fr', 30,@currentPageType, 'Paiement non effectué - La session a expiré', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'fr', 31,@currentPageType, 'Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur le site de vente en ligne et recommencer la procédure de paiement si vous souhaitez effectuer le paiement.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'fr', 32,@currentPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'fr', 33,@currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'fr', 40, @currentPageType, 'Interrompre le paiement', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'fr', 41, @currentPageType, 'Aide', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'fr', 100, 'ALL', 'Commerçant', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'fr', 101, 'ALL', 'Montant', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'fr', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'fr', 103, 'ALL', 'Numéro de carte', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
 'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetMobileApp);



/* Elements for the HELP page, for MOBILE APP Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
 'fr', 1, @currentPageType, '<b>Aide</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
 'fr', 2, @currentPageType, 'Raiffeisen utilise une méthode d’authentification en deux étapes afin renforcer votre sécurité lors de paiements en ligne. ', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'fr', 3, @currentPageType, 'Vous pouvez valider des paiements en ligne sur votre smartphone, dans l’app d’authentification de Raiffeisen correspondante. En cas de questions ou de doutes, merci de vous à adresser à votre Banque Raiffeisen.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
 'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'fr', 16, @currentPageType, 'L''activation a échoué', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'fr', 17, @currentPageType, 'L’authentification sur votre smartphone a échoué et le paiement n’est donc pas validé. Le processus de paiement a été interrompu et votre carte n''a pas été débitée. Si vous souhaitez poursuivre le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'fr', 41, @currentPageType, 'Aide', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetMobileApp);



/*ITALIAN translations for MOBILE_APP*/
SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
       'it', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileApp
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
       'it', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileApp
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

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
 'it', 1, @currentPageType, '<b>Autorizzare il pagamento nell’app</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'it', 2, @currentPageType, 'Per poter completare il pagamento, è necessario autorizzarlo nell’app fornita sua banca. ', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'it', 3, @currentPageType, 'Dovrebbe aver già ricevuto una notifica sul suo cellulare.  In caso contrario può accedere direttamente all''app e verificare il pagamento lì.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
 'it', 10, @currentPageType, 'Al posto di questo, richiedere l’autorizzazione tramite SMS', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'it', 12,@currentPageType, 'L’autorizzazione di pagamento viene controllata', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'it', 13,@currentPageType, 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'it', 14,@currentPageType, 'Autorizzazione di pagamento annullata', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'it', 15,@currentPageType, 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare il processo di acquisto, la preghiamo di riprovare ad effettuare il pagamento.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'it', 26,@currentPageType, 'L’autorizzazione di pagamento è andata a buon fine', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'it', 27,@currentPageType, 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'it', 30,@currentPageType, 'Pagamento non effettuato - Sessione scaduta', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'it', 31,@currentPageType, 'È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Se desidera effettuare il pagamento la preghiamo di tornare allo shop online e di riavviare il processo di pagamento.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'it', 32,@currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'it', 33,@currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'it', 40, @currentPageType, 'Interrompere il pagamento', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'it', 41, @currentPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'it', 100, 'ALL', 'Commerciante', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'it', 101, 'ALL', 'Importo', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'it', 102, 'ALL', 'Data', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'it', 103, 'ALL', 'Numero della carta', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
 'it', 104, 'ALL', 'Numero di telefono', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetMobileApp);



/* Elements for the HELP page, for MOBILE APP Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
 'it', 1, @currentPageType, '<b>Aiuto</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
 'it', 2, @currentPageType, 'Per aumentare la sua sicurezza nei pagamenti online, Raiffeisen utilizza una procedura di autentificazione a due livelli. ', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'it', 3, @currentPageType, 'Può autorizzare i pagamenti online sul suo smartphone nella corrispondente app di autentificazione Raiffeisen. In caso di domande o dubbi si rivolga alla sua Banca Raiffeisen.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
 'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'it', 16, @currentPageType, 'Autenticazione fallita', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'it', 17, @currentPageType, 'L''autentificazione sul suo smartphone non è andata a buon fine, pertanto il pagamento non è stato autorizzato. Il processo di pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare il processo di acquisto, la preghiamo di riprovare ad effettuare il pagamento.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'it', 41, @currentPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetMobileApp);

/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;


/*MOBILE_APP_EXT*/

SET @currentAuthentMean = 'MOBILE_APP_EXT';
SET @customItemSetMobileAppExt = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));
SET @currentPageType = 'POLLING_PAGE';
SET @updateState = 'PUSHED_TO_CONFIG';
SET @locale = 'de';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
       'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileAppExt
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
       'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileAppExt
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
       'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileAppExt
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/*MOBILE_APP_EXT_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Zahlung in der App freigeben</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Damit die Zahlung abgeschlossen werden kann, müssen Sie diese in der von Ihrer Bank zur Vergfügung gestellten App freigeben.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Sie sollten bereits eine entsprechende Benachrichtigung auf Ihrem Mobil-Telefon erhalten haben. Andernfalls können Sie direkt in die App einsteigen und die Zahlung dort verifizieren.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
 'de', 10, @currentPageType, 'Stattdessen Freigabe durch SMS anfordern', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'de', 12,@currentPageType, 'Zahlungsfreigabe wird geprüft', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'de', 13,@currentPageType, 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'de', 14,@currentPageType, 'Zahlungsfreigabe abgebrochen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'de', 15,@currentPageType, 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Wenn Sie den Kaufprozess fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'de', 26,@currentPageType, 'Zahlungsfreigabe war erfolgreich', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'de', 27,@currentPageType, 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum Händler weitergeleitet.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'de', 30,@currentPageType, 'Zahlung nicht ausgeführt - Sitzung abgelaufen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'de', 31,@currentPageType, 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung tätigen wollen.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32,@currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33,@currentPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet.Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'de', 40, @currentPageType, 'Zahlung abbrechen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
 'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Hilfe schließen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetMobileAppExt);


/* Elements for the HELP page, for MOBILE APP EXT Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Um Ihre Sicherheit bei Online-Zahlungen zu erhöhen, hat Raiffeisen ein zweistufiges Authentifikationsverfahren eingeführt. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Sie können Online-Zahlungen auf Ihrem Smartphone in der entsprechenden Authentifikations-App von Raiffeisen freigeben. Bei Fragen oder Unklarheiten wenden Sie sich bitte an Ihre Raiffeisenbank.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Hilfe schliessen', @MaestroVID, NULL, @customItemSetMobileAppExt);


/* Elements for the FAILURE page, for MOBILE APP EXT Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'de', 16, @currentPageType, 'Freigabe fehlgeschlagen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'de', 17, @currentPageType, 'Die Authentifikation auf Ihrem Smartphone ist fehlgeschlagen und somit die Zahlung nicht freigegeben. Der Zahlungsprozess wurde abgebrochen und Ihre Karte nicht belastet. Wenn Sie den Kaufprozess fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet.Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Hilfe schliessen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetMobileAppExt);



/*ENGLISH translations for MOBILE_APP_EXT*/
SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
       'en', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileAppExt
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
       'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileAppExt
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
       'en', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileAppExt
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/*MOBILE_APP_EXT_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'en', 1, @currentPageType, '<b>Approve payment in the app</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'en', 2, @currentPageType, 'To complete the payment, you must approve it in the app provided by your bank. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'en', 3, @currentPageType, 'You should already have received a corresponding message on your mobile phone. Otherwise, you can open the app directly and approve the payment there.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
 'en', 10, @currentPageType, 'Request approval via SMS instead', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'en', 12,@currentPageType, 'Payment approval is being verified', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'en', 13,@currentPageType, 'Please be patient. We are verifying your payment approval and thereby the authentification for the requested payment.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'en', 14,@currentPageType, 'Payment approval cancelled', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'en', 15,@currentPageType, 'The payment was cancelled and your card was not debited. If you wish to continue the purchase process, please attempt payment again.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'en', 26,@currentPageType, 'Successful payment approval', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'en', 27,@currentPageType, 'You have successfully approved the payment and will be automatically routed back to the merchant.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'en', 30,@currentPageType, 'Payment not completed – session expired', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'en', 31,@currentPageType, 'Too much time has passed before the payment was approved. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process if you wish to make the payment.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'en', 32,@currentPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'en', 33,@currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'en', 40, @currentPageType, 'Cancel payment', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'en', 100, 'ALL', 'Merchant', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'en', 101, 'ALL', 'Amount', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'en', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'en', 103, 'ALL', 'Card number', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
 'en', 104, 'ALL', 'Phone number', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'en', 174, @currentPageType, 'Close Help', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'en', 175, @currentPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetMobileAppExt);



/* Elements for the HELP page, for MOBILE APP EXT Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
 'en', 1, @currentPageType, '<b>Help</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
 'en', 2, @currentPageType, 'To make your online payments more secure, Raiffeisen uses a two-factor authentication procedure.  ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'en', 3, @currentPageType, 'You can approve online payments in the corresponding Raiffeisen authentication app on your smartphone. Please contact your Raiffeisen bank if you have any questions or if anything is unclear.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
 'en', 174, @currentPageType, 'Close Help', @MaestroVID, NULL, @customItemSetMobileAppExt);


/* Elements for the FAILURE page, for MOBILE APP EXT Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'en', 16, @currentPageType, 'Approval failed', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'en', 17, @currentPageType, 'The authentication on your smartphone failed and the payment was not approved. The payment process was cancelled and your card was not debited. If you wish to continue the purchase process, please attempt payment again. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'en', 174, @currentPageType, 'Close Help', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'en', 175, @currentPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetMobileAppExt);



/*FRENCH translations for MOBILE_APP_EXT*/
SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
       'fr', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileAppExt
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
       'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileAppExt
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
       'fr', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileAppExt
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/*MOBILE_APP_EXT_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'fr', 1, @currentPageType, '<b>Activer le paiement dans l''App</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'fr', 2, @currentPageType, 'Pour que le paiement puisse être terminé, vous devez l''activer dans l''App mise à disposition par votre banque. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'fr', 3, @currentPageType, 'Vous devriez déjà avoir reçu un message correspondant sur votre téléphone portable. Dans le cas contraire, vous pouvez aller directement dans votre App et y vérifier le paiement.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
 'fr', 10, @currentPageType, 'À la place, demander l''activation pas SMS', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'fr', 12,@currentPageType, 'L''activation de paiement va être vérifiée', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'fr', 13,@currentPageType, 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'fr', 14,@currentPageType, 'Activation de paiement interrompue', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'fr', 15,@currentPageType, 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez poursuivre le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'fr', 26,@currentPageType, 'L’activation du paiement a réussi', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'fr', 27,@currentPageType, 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'fr', 30,@currentPageType, 'Paiement non effectué - La session a expiré', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'fr', 31,@currentPageType, 'Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur le site de vente en ligne et recommencer la procédure de paiement si vous souhaitez effectuer le paiement.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'fr', 32,@currentPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'fr', 33,@currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'fr', 40, @currentPageType, 'Interrompre le paiement', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'fr', 41, @currentPageType, 'Aide', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'fr', 100, 'ALL', 'Commerçant', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'fr', 101, 'ALL', 'Montant', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'fr', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'fr', 103, 'ALL', 'Numéro de carte', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
 'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetMobileAppExt);



/* Elements for the HELP page, for MOBILE APP EXT Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
 'fr', 1, @currentPageType, '<b>Aide</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
 'fr', 2, @currentPageType, 'Raiffeisen utilise une méthode d’authentification en deux étapes afin renforcer votre sécurité lors de paiements en ligne. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'fr', 3, @currentPageType, 'Vous pouvez valider des paiements en ligne sur votre smartphone, dans l’app d’authentification de Raiffeisen correspondante. En cas de questions ou de doutes, merci de vous à adresser à votre Banque Raiffeisen.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
 'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetMobileAppExt);


/* Elements for the FAILURE page, for MOBILE APP EXT Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'fr', 16, @currentPageType, 'L''activation a échoué', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'fr', 17, @currentPageType, 'L’authentification sur votre smartphone a échoué et le paiement n’est donc pas validé. Le processus de paiement a été interrompu et votre carte n''a pas été débitée. Si vous souhaitez poursuivre le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'fr', 41, @currentPageType, 'Aide', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetMobileAppExt);



/*ITALIAN translations for MOBILE_APP_EXT*/
SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
       'it', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileAppExt
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
       'it', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileAppExt
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
       'it', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileAppExt
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/*MOBILE_APP_EXT_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'it', 1, @currentPageType, '<b>Autorizzare il pagamento nell’app</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'it', 2, @currentPageType, 'Per poter completare il pagamento, è necessario autorizzarlo nell’app fornita sua banca. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'it', 3, @currentPageType, 'Dovrebbe aver già ricevuto una notifica sul suo cellulare.  In caso contrario può accedere direttamente all''app e verificare il pagamento lì.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), 'PUSHED_TO_CONFIG',
 'it', 10, @currentPageType, 'Al posto di questo, richiedere l’autorizzazione tramite SMS', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'it', 12,@currentPageType, 'L’autorizzazione di pagamento viene controllata', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'it', 13,@currentPageType, 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'it', 14,@currentPageType, 'Autorizzazione di pagamento annullata', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'it', 15,@currentPageType, 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare il processo di acquisto, la preghiamo di riprovare ad effettuare il pagamento.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'it', 26,@currentPageType, 'L’autorizzazione di pagamento è andata a buon fine', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'it', 27,@currentPageType, 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'it', 30,@currentPageType, 'Pagamento non effettuato - Sessione scaduta', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'it', 31,@currentPageType, 'È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Se desidera effettuare il pagamento la preghiamo di tornare allo shop online e di riavviare il processo di pagamento.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'it', 32,@currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'it', 33,@currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'it', 40, @currentPageType, 'Interrompere il pagamento', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'it', 41, @currentPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'it', 100, 'ALL', 'Commerciante', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'it', 101, 'ALL', 'Importo', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'it', 102, 'ALL', 'Data', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'it', 103, 'ALL', 'Numero della carta', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
 'it', 104, 'ALL', 'Numero di telefono', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetMobileAppExt);



/* Elements for the HELP page, for MOBILE APP EXT Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
 'it', 1, @currentPageType, '<b>Aiuto</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
 'it', 2, @currentPageType, 'Per aumentare la sua sicurezza nei pagamenti online, Raiffeisen utilizza una procedura di autentificazione a due livelli. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
 'it', 3, @currentPageType, 'Può autorizzare i pagamenti online sul suo smartphone nella corrispondente app di autentificazione Raiffeisen. In caso di domande o dubbi si rivolga alla sua Banca Raiffeisen.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
 'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetMobileAppExt);


/* Elements for the FAILURE page, for MOBILE APP EXT Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'it', 16, @currentPageType, 'Autenticazione fallita', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'it', 17, @currentPageType, 'L''autentificazione sul suo smartphone non è andata a buon fine, pertanto il pagamento non è stato autorizzato. Il processo di pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare il processo di acquisto, la preghiamo di riprovare ad effettuare il pagamento.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'it', 41, @currentPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetMobileAppExt);

/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;
