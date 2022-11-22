/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
SET @createdBy ='A709391';
SET @issuerCode = '00601';
SET @subIssuerCode = '00601';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'SWISSQUOTE';
SET @BankUB = 'SQB';

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @updateState = 'PUSHED_TO_CONFIG';

/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
	AND n.code = 'MASTERCARD';
/*!40000 ALTER TABLE `Network_SubIssuer` ENABLE KEYS */;

/* BinRange */
/* In this table, in the case of co-branding the primary network will be present as a foreign key (fk_id_network) and
   the 'alternative' network will be present through the field 'coBrandedCardNetwork' which contains a string that matches
   the field 'code' of the Network (it plays the same role as a foreign key, because the code is unique for each Network)
*/
set @binRangeLowerBound1='5163979000';
set @binRangeUpperBound1='5163979089';

set @binRangeLowerBound2='5169840000';
set @binRangeUpperBound2='5169840029';
INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, @updateState, TRUE, NOW(), @binRangeLowerBound1, 16, FALSE, NULL, @binRangeUpperBound1, FALSE, @ProfileSet, @MaestroMID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, @updateState, TRUE, NOW(), @binRangeLowerBound2, 16, FALSE, NULL, @binRangeUpperBound2, FALSE, @ProfileSet, @MaestroMID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE ((b.lowerBound = @binRangeLowerBound1 and b.upperBound = @binRangeUpperBound1) or
		 (b.lowerBound = @binRangeLowerBound2 and b.upperBound = @binRangeUpperBound2))
    AND b.fk_id_profileSet=@ProfileSet
    AND s.code=@subIssuerCode;



/* CustomItem */
/* Create custom items for default language and backup languages - in this example de and en */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;
SET @MaestroMID = NULL;
/* Elements for the profile DEFAULT_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'de', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'de', 1, @currentPageType, '<b>3D Secure Authentifizierung nicht möglich</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'de', 2, @currentPageType, '', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'de', 3, @currentPageType, '', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), @updateState,
         'de', 5, @currentPageType, 'Zahlungsfreigabe nicht möglich', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'de', 22, @currentPageType, '3D Secure Authentifizierung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'de', 23, @currentPageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D-Secure-Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie, Ihre Karte gemäß der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'de', 32, @currentPageType, '3D Secure Authentifizierung nicht ausgeführt - Technischer Fehler', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'de', 33, @currentPageType, 'Bei der Bearbeitung Ihrer Anfrage ist leider ein technischer Fehler aufgetreten. Bitte versuchen Sie es später noch einmal.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'de', 41, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'de', 100, 'ALL', 'Händler', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'de', 101, 'ALL', 'Betrag', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'de', 102, 'ALL', 'Datum', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'de', 103, 'ALL', 'Kartennummer', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'de', 104, 'ALL', 'Mobiltelefonnummer', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
		 'de', 220, @currentPageType, '3D Secure Authentifizierung fehlgeschlagen', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
		 'de', 230, @currentPageType, 'Aus Sicherheitsgründen wurde Ihre Zahlung nicht ausgeführt. Ihre Karte wurde nicht belastet.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'de', 174,@currentPageType, 'Meldung schliessen', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'de', 175,@currentPageType, 'Zurück zum Online-Shop', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'de', 1, @helpPage, 'Hilfe', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'de', 2, @helpPage, 'Aus Sicherheitsgründen müssen Sie sich an das Payment Card Service Helpdesk wenden, um die Änderung Ihrer Mobiltelefonnummer zu beantragen.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'de', 3, @helpPage, 'Für diese und alle anderen Fragen zu Ihrer Karte erreichen Sie den Helpdesk unter +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'de', 174, @helpPage, 'Hilfe schliessen', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'de', 16, @currentPageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'de', 17, @currentPageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'de', 32, @currentPageType, '3D Secure Authentifizierung nicht ausgeführt - Technischer Fehler', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'de', 33, @currentPageType, 'Bei der Bearbeitung Ihrer Anfrage ist leider ein technischer Fehler aufgetreten. Bitte versuchen Sie es später noch einmal.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'de', 41, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'de', 174, @currentPageType, 'Meldung schliessen', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'de', 175, @currentPageType, 'Zurück zum Online-Shop', @MaestroMID, NULL, @customItemSetREFUSAL);

/*ENGLISH translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'en', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'en', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'en', 1, @currentPageType, '<b>3D Secure authentication not possible</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'en', 2, @currentPageType, '', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'en', 3, @currentPageType, '', @MaestroMID, NULL, @customItemSetREFUSAL),

   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), @updateState,
         'en', 5, @currentPageType, 'Payment approval not possible.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'en', 22, @currentPageType, '3D Secure authentication not completed – card is not registered for 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'en', 23, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'en', 32, @currentPageType, '3D Secure authentication not completed – technical error', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'en', 33, @currentPageType, 'Unfortunately, a technical error occurred while processing your request. Please try again later.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'en', 100, 'ALL', 'Merchant', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'en', 101, 'ALL', 'Amount', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'en', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'en', 103, 'ALL', 'Card number', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'en', 104, 'ALL', 'Mobile phone number', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
		 'en', 220, @currentPageType, '3D Secure authentication failed', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
		 'en', 230, @currentPageType, 'For security reasons, your payment was not completed and your card not debited.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'en', 174,@currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'en', 175,@currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'en', 1, @helpPage, 'Help', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'en', 2, @helpPage, 'For security reasons, you must contact the Payment Card Service Helpdesk to request the modification of your mobile phone number.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'en', 3, @helpPage, 'For this and any other issues with your card, you can reach the Helpdesk on +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'en', 174, @helpPage, 'Close Help', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'en', 16, @currentPageType, 'Payment not completed – card is not registered for 3D Secure.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'en', 17, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'en', 32, @currentPageType, '3D Secure authentication not completed – technical error', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'en', 33, @currentPageType, 'Unfortunately, a technical error occurred while processing your request. Please try again later.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'en', 174, @currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetREFUSAL);


/*FRENCH translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'fr', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'fr', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'fr', 1, @currentPageType, '<b>Authentification 3D Secure impossible</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'fr', 2, @currentPageType, '', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'fr', 3, @currentPageType, '', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), @updateState,
         'fr', 5, @currentPageType, 'Activation de paiement impossible', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'fr', 22, @currentPageType, 'Authentification 3D Secure non effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'fr', 23, @currentPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'fr', 32, @currentPageType, 'Authentification 3D Secure non effectuée - Erreur technique', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'fr', 33, @currentPageType, 'Malheureusement une erreur technique est survenue lors du traitement de votre demande. Veuillez réessayer plus tard.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'fr', 100, 'ALL', 'Commerçant', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'fr', 101, 'ALL', 'Montant', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'fr', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'fr', 103, 'ALL', 'Numéro de carte', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'fr', 104, 'ALL', 'Numéro de téléphone mobile', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
		 'fr', 220, @currentPageType, 'L''authentification 3D Secure a échoué', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
		 'fr', 230, @currentPageType, 'Pour des raisons de sécurité, votre paiement n''a pas été traité. Votre carte n''a pas été débitée.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'fr', 174,@currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'fr', 175,@currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'fr', 1, @helpPage, 'Aide', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'fr', 2, @helpPage, 'Pour des raisons de sécurité, vous devez contacter le Payment Card Service Helpdesk afin de demander la modification de votre numéro de téléphone portable.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'fr', 3, @helpPage, 'Pour ce faire et pour tout autre problème, vous pouvez contacter le HelpDesk au numéro +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'fr', 174, @helpPage, 'Fermer l''aide', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'fr', 16, @currentPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'fr', 17, @currentPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'fr', 32, @currentPageType, 'Authentification 3D Secure non effectuée - Erreur technique', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'fr', 33, @currentPageType, 'Malheureusement une erreur technique est survenue lors du traitement de votre demande. Veuillez réessayer plus tard.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetREFUSAL);



/*Italian translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'it', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'it', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'it', 1, @currentPageType, '<b>L''autenticazione 3D Secure non è possibile</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'it', 2, @currentPageType, '', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'it', 3, @currentPageType, '', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), @updateState,
         'it', 5, @currentPageType, 'Autorizzazione di pagamento non possibile', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'it', 22, @currentPageType, 'Autenticazione 3D Secure non eseguita  - La carta non è registrata per 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'it', 23, @currentPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'it', 32, @currentPageType, 'Autenticazione 3D Secure non eseguita - Errore tecnico', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'it', 33, @currentPageType, 'Spiacenti. Si è verificato un errore tecnico durante l’elaborazione della sua richiesta. La preghiamo di riprovare più tardi.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'it', 100, 'ALL', 'Commerciante', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'it', 101, 'ALL', 'Importo', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'it', 102, 'ALL', 'Data', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'it', 103, 'ALL', 'Numero di carta', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'it', 104, 'ALL', 'Numero di cellulare', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
		 'it', 220, @currentPageType, 'Autenticazione 3D Secure non riuscita', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
		 'it', 230, @currentPageType, 'Per motivi di sicurezza, il tuo pagamento non è stato elaborato. La tua carta non è stata addebitata.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'it', 174,@currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'it', 175,@currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'it', 1, @helpPage, 'Aiuto', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'it', 2, @helpPage, 'Per motivi di sicurezza, per richiedere la modifica del suo numero di cellulare dovrà contattare il Payment Card Service Helpdesk.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'it', 3, @helpPage, 'Per questo e in caso di problema, puo contattare l’Helpdesk al seguente numero di telefono: +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'it', 174, @helpPage, 'Chiudere l’aiuto', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'it', 16, @currentPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'it', 17, @currentPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'it', 32, @currentPageType, 'Autenticazione 3D Secure non eseguita - Errore tecnico', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'it', 33, @currentPageType, 'Spiacenti. Si è verificato un errore tecnico durante l’elaborazione della sua richiesta. La preghiamo di riprovare più tardi.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusalMissing FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetREFUSAL;

SET @currentPageType = 'ALL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie den Payment Card Service Helpdesk unter +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetRefusalMissing),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'The payment cannot be processed. Please contact the Payment Card Service Helpdesk on +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'it', 1000, @currentPageType, 'La transazione non è andata a buon fine. Si prega di contattare il Payment Card Service Helpdesk al numero +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'fr', 1000, @currentPageType, 'La transaction n''a pas abouti. Veuillez contacter le Payment Card Service Helpdesk au +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetRefusalMissing),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie den Payment Card Service Helpdesk unter +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'The payment cannot be processed. Please contact the Payment Card Service Helpdesk on +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'it', 1001, @currentPageType, 'La transazione non è andata a buon fine. Si prega di contattare il Payment Card Service Helpdesk al numero +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'fr', 1001, @currentPageType, 'La transaction n''a pas abouti. Veuillez contacter le Payment Card Service Helpdesk au +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetRefusalMissing),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie den Payment Card Service Helpdesk unter +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetRefusalMissing),
   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'The payment cannot be processed. Please contact the Payment Card Service Helpdesk on +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'it', 1002, @currentPageType, 'La transazione non è andata a buon fine. Si prega di contattare il Payment Card Service Helpdesk al numero +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'fr', 1002, @currentPageType, 'La transaction n''a pas abouti. Veuillez contacter le Payment Card Service Helpdesk au +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetRefusalMissing);

/* Elements for the profile SMS : */
SET @currentAuthentMean = 'OTP_SMS';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the SMS Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'de', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', @updateState, 'de', 0, 'MESSAGE_BODY',
        'Ihr Authentifizierungscode lautet @otp für Ihren Kauf von @amount bei @merchant mit Karte @maskedPan, am @formattedDate.', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'de', 1, @currentPageType, '<b>3D Secure Authentifizierung via SMS</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'de', 2, @currentPageType, 'Authentifizierungscode Code bitte hier eingeben:', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), @updateState,
         'de', 12, @currentPageType, '3D Secure Authentifizierung wird geprüft', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), @updateState,
         'de', 13, @currentPageType, 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), @updateState,
         'de', 14, @currentPageType, '3D Secure Authentifizierung abgebrochen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), @updateState,
         'de', 15, @currentPageType, 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess trotzdem fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), @updateState,
         'de', 19, @currentPageType, 'SMS TAN erneut senden', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'de', 22, @currentPageType, '3D Secure Authentifizierung fehlgeschlagen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'de', 23, @currentPageType, 'Sie haben 3 Mal einen ungültigen Authentifizierungscode eingegeben. 3D Secure wurde für Ihre Karte gesperrt und die Zahlung wurde nicht ausgeführt.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), @updateState,
         'de', 26, @currentPageType, '3D Secure Authentifizierung war erfolgreich', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), @updateState,
         'de', 27, @currentPageType, 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum Händler weitergeleitet.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), @updateState,
         'de', 28, @currentPageType, 'Ungültiger Authentifizierungscode', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), @updateState,
         'de', 29, @currentPageType, 'Der von Ihnen eingegebene Ungültiger Authentifizierungscode ist ungültig. Die Zahlung wurde nicht ausgeführt und Ihre Karte wurde nicht belastet. Sofern Sie den Kauf fortsetzen wollen, versuchen Sie es erneut.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), @updateState,
         'de', 30, @currentPageType, 'Zahlung nicht ausgeführt - Sitzung abgelaufen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), @updateState,
         'de', 31, @currentPageType, 'Ihre Sitzung ist nach einer längeren Inaktivität abgelaufen. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung tätigen wollen.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroMID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), @updateState,
         'de', 34, @currentPageType, 'Ein neuer Authentifizierungscode wurde Ihnen per SMS gesendet.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), @updateState,
         'de', 35, @currentPageType, 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie einen neuen Authentifizierungscode an Ihre Mobiltelefonnummer.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), @updateState,
         'de', 40, @currentPageType, 'Abbrechen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'de', 41, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), @updateState,
         'de', 42, @currentPageType, 'Bestätigen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'de', 100, 'ALL', 'Händler', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'de', 101, 'ALL', 'Betrag', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'de', 102, 'ALL', 'Datum', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'de', 103, 'ALL', 'Kartennummer', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'de', 104, 'ALL', 'Mobiltelefonnummer', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'de', 174, @currentPageType, 'Meldung schliessen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'de', 175, @currentPageType, 'Zurück zum Online-Shop', @MaestroMID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'de', 1, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'de', 2, @currentPageType, 'Aus Sicherheitsgründen müssen Sie sich an das Payment Card Service Helpdesk wenden, um die Änderung Ihrer Mobiltelefonnummer zu beantragen.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'de', 3, @currentPageType, 'Für diese und alle anderen Fragen zu Ihrer Karte erreichen Sie den Helpdesk unter +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'de', 174, @currentPageType, 'Hilfe schließen', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'de', 16, @currentPageType, '3D Secure Authentifizierung fehlgeschlagen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'de', 17, @currentPageType, 'Sie haben 3 Mal einen ungültigen Authentifizierungscode eingegeben. 3D Secure wurde für Ihre Karte gesperrt und die Zahlung wurde nicht ausgeführt.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'de', 41, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'de', 174, @currentPageType, 'Meldung schliessen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'de', 175, @currentPageType, 'Zurück zum Online-Shop', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'de', 1, @currentPageType, '<b>Zahlungsfreigabe nicht möglich</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'de', 2, @currentPageType, 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (SMS oder App) für Ihre Karte gefunden haben. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'de', 3, @currentPageType, 'Bitte hinterlegen Sie für Ihre Karte eine entsprechende Freigabe-Methode im Registrierungsportal gemäss der Anleitung Ihrer Bank. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'de', 22, @currentPageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'de', 23, @currentPageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'de', 32, @currentPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'de', 41, @currentPageType, 'Hilfe', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'de', 174, @currentPageType, 'Meldung schliessen', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'de', 175, @currentPageType, 'Zurück zum Online-Shop', @MaestroMID, NULL, @customItemSetSMS);


/*ENGLISH translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'en', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'en', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', @updateState, 'en', 0, 'MESSAGE_BODY',
        'Your authentication code is @otp for your @amount purchase at @merchant with card @maskedPan, on @formattedDate.', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'en', 1, @currentPageType, '<b>3D Secure authentication via SMS</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'en', 2, @currentPageType, 'Please enter authentication code here:', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), @updateState,
         'en', 12, @currentPageType, '3D Secure authentication is being verified', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), @updateState,
         'en', 13, @currentPageType, 'Please be patient. We are verifying your payment approval and thereby the authentication for the requested payment.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), @updateState,
         'en', 14, @currentPageType, '3D Secure authentication cancelled', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), @updateState,
         'en', 15, @currentPageType, 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the purchase process, please start the payment attempt again. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), @updateState,
         'en', 19, @currentPageType, 'Resend SMS Code', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'en', 22, @currentPageType, '3D Secure authentication failed', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'en', 23, @currentPageType, 'You have entered an invalid authentication code 3 times.The 3D Secure service has been blocked for your card and the payment was not completed.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), @updateState,
         'en', 26, @currentPageType, 'Successful 3D Secure authentication', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), @updateState,
         'en', 27, @currentPageType, 'You have successfully approved the payment and will be automatically routed back to the merchant.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), @updateState,
         'en', 28, @currentPageType, 'Invalid authentication code', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), @updateState,
         'en', 29, @currentPageType, 'The authentication code you entered is invalid. The payment was not conducted and your card was not debited. Please try again if you wish to continue the purchase.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), @updateState,
         'en', 30, @currentPageType, 'Payment not completed – session expired', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), @updateState,
         'en', 31, @currentPageType, 'Your session has expired due to an extended period of inactivity. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process, if you wish to make the purchase.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), @updateState,
         'en', 34, @currentPageType, 'A new authentication code has been sent by SMS to your mobile phone number.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), @updateState,
         'en', 35, @currentPageType, 'Please wait, this may take a moment. A new authentication code will be sent to your mobile phone number.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), @updateState,
         'en', 40, @currentPageType, 'Quit', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), @updateState,
         'en', 42, @currentPageType, 'Submit', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'en', 100, 'ALL', 'Merchant', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'en', 101, 'ALL', 'Amount', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'en', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'en', 103, 'ALL', 'Card number', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'en', 104, 'ALL', 'Mobile phone number', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'en', 174, @currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'en', 1, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'en', 2, @currentPageType, 'For security reasons, you must contact the Payment Card Service Helpdesk to request the modification of your mobile phone number.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'en', 3, @currentPageType, 'For this and any other issues with your card, you can reach the Helpdesk on +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'en', 174, @currentPageType, 'Close Help', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'en', 16, @currentPageType, '3D Secure authentication failed', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'en', 17, @currentPageType, 'You have entered an invalid authentication code 3 times.The 3D Secure service has been blocked for your card and the payment was not completed.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'en', 174, @currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'en', 1, @currentPageType, '<b>Payment approval not possible.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'en', 2, @currentPageType, 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'en', 3, @currentPageType, 'Please set up a corresponding approval method for your card on the registration portal according to your bank''s instructions. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'en', 22, @currentPageType, 'Payment not completed – card is not registered for 3D Secure.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'en', 23, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'en', 33, @currentPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'en', 174, @currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetSMS);




/*FRENCH translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'fr', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'fr', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', @updateState, 'fr', 0, 'MESSAGE_BODY',
        'Votre code d''authentification est le @otp pour votre achat de @amount auprès de @merchant avec votre carte @maskedPan, le @formattedDate.', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'fr', 1, @currentPageType, '<b>Authentification 3D Secure par SMS</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'fr', 2, @currentPageType, 'Veuillez saisir ici le code d''authentification:', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), @updateState,
         'fr', 12, @currentPageType, 'L''authentification 3D Secure va être vérifiée', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), @updateState,
         'fr', 13, @currentPageType, 'Merci de patienter. Nous vérifions l''authentification pour le paiement souhaité.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), @updateState,
         'fr', 14, @currentPageType, 'Authentification 3D Secure annulée', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), @updateState,
         'fr', 15, @currentPageType, 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), @updateState,
         'fr', 19, @currentPageType, 'Renvoyer le code SMS', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'fr', 22, @currentPageType, 'L''authentification 3D Secure a échoué', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'fr', 23, @currentPageType, 'Vous avez entré un code d’authentification invalide 3 fois. Le service 3D Secure a été bloqué pour votre carte et le paiement n’a pas été réalisé.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), @updateState,
         'fr', 26, @currentPageType, 'L''autorisation 3D Secure a réussi', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), @updateState,
         'fr', 27, @currentPageType, 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), @updateState,
         'fr', 28, @currentPageType, 'Code d’authentification incorrect', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), @updateState,
         'fr', 29, @currentPageType, 'Le code d’authentification que vous avez saisi n''est pas correct. Le paiement n''a pas été effectué et votre carte n''a pas été débitée. Si vous voulez continuer l''achat, essayez à nouveau.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), @updateState,
         'fr', 30, @currentPageType, 'Paiement non effectué - La session a expiré', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), @updateState,
         'fr', 31, @currentPageType, 'Votre session a expiré en raison d''une trop longue période d''inactivité. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer l''achat.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), @updateState,
         'fr', 34, @currentPageType, 'Un nouveau code d‘authentification vient de vous être transmis par SMS.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), @updateState,
         'fr', 35, @currentPageType, 'Veuillez patienter un instant. Vous recevrez d’ici peu un nouveau code d‘authentification sur votre numéro de téléphone mobile.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), @updateState,
         'fr', 40, @currentPageType, 'Abandonner', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), @updateState,
         'fr', 42, @currentPageType, 'Valider', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'fr', 100, 'ALL', 'Commerçant', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'fr', 101, 'ALL', 'Montant', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'fr', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'fr', 103, 'ALL', 'Numéro de carte', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'fr', 104, 'ALL', 'Numéro de téléphone mobile', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'fr', 1, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'fr', 2, @currentPageType, 'Pour des raisons de sécurité, vous devez contacter le Payment Card Service Helpdesk afin de demander la modification de votre numéro de téléphone portable.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'fr', 3, @currentPageType, 'Pour ce faire et pour tout autre problème, vous pouvez contacter le HelpDesk au numéro +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'fr', 16, @currentPageType, 'L''authentification 3D Secure a échoué', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'fr', 17, @currentPageType, 'Vous avez entré un code d’authentification invalide 3 fois. Le service 3D Secure a été bloqué pour votre carte et le paiement n’a pas été réalisé.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'fr', 1, @currentPageType, '<b>Activation de paiement impossible</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'fr', 2, @currentPageType, 'Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'fr', 3, @currentPageType, 'Veuillez consigner une méthode d''activation pour votre carte dans le portail d’inscription, conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'fr', 22, @currentPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'fr', 23, @currentPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'fr', 33, @currentPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetSMS);




/*ITALIAN translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'it', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'it', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', @updateState, 'it', 0, 'MESSAGE_BODY',
        'Il suo codice di autenticazione è il @otp per suo acquisto di @amount da @merchant con la sua carta @maskedPan, il @formattedDate.', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'it', 1, @currentPageType, '<b>Autenticazione 3D Secure tramite SMS</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'it', 2, @currentPageType, 'Inserisca qui il codice di autenticazione:', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), @updateState,
         'it', 12, @currentPageType, 'L''autenticazione 3D Secure viene controllata', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), @updateState,
         'it', 13, @currentPageType, 'La preghiamo di aspettare un attimo. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), @updateState,
         'it', 14, @currentPageType, 'Autenticazione 3D Secure annullata', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), @updateState,
         'it', 15, @currentPageType, 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), @updateState,
         'it', 19, @currentPageType, 'Invia nuovo codice SMS', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'it', 22, @currentPageType, 'Autenticazione 3D Secure non riuscita', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'it', 23, @currentPageType, 'Ha inserito 3 volte un codice di autenticazione non valido. Il servizio 3D Secure è stato bloccato per la sua carta; non è stato pertanto possibile effettuare il pagamento.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), @updateState,
         'it', 26, @currentPageType, 'L''autorizzazione 3D Secure è stata eseguita correttamente', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), @updateState,
         'it', 27, @currentPageType, 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), @updateState,
         'it', 28, @currentPageType, 'Codice di autenticazione non valido', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), @updateState,
         'it', 29, @currentPageType, 'Il codice di autenticazione inserito da lei non è valido. Il pagamento non è stato eseguito e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, provi nuovamente.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), @updateState,
         'it', 30, @currentPageType, 'Pagamento non effettuato - Sessione scaduta', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), @updateState,
         'it', 31, @currentPageType, 'La sua sessione è scaduta in seguito a un periodo di inattività prolungato. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), @updateState,
         'it', 34, @currentPageType, 'Abbiamo inviato tramite SMS al suo numero di cellulare un nuovo codice di autenticazione.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), @updateState,
         'it', 35, @currentPageType, 'La preghiamo di aspettare. A breve riceverà un nuovo codice di autenticazione sul suo numero di cellulare.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), @updateState,
         'it', 40, @currentPageType, 'Esci', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), @updateState,
         'it', 42, @currentPageType, 'Continua', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'it', 100, 'ALL', 'Commerciante', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'it', 101, 'ALL', 'Importo', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'it', 102, 'ALL', 'Data', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'it', 103, 'ALL', 'Numero di carta', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'it', 104, 'ALL', 'Numero di cellulare', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'it', 1, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'it', 2, @currentPageType, 'Per motivi di sicurezza, per richiedere la modifica del suo numero di cellulare dovrà contattare il Payment Card Service Helpdesk.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'it', 3, @currentPageType, 'Per questo e in caso di problema, puo contattare l’Helpdesk al seguente numero di telefono: +41 58 721 93 93.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'it', 16, @currentPageType, 'Autenticazione 3D Secure non riuscita', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'it', 17, @currentPageType, 'Ha inserito 3 volte un codice di autenticazione non valido. Il servizio 3D Secure è stato bloccato per la sua carta; non è stato pertanto possibile effettuare il pagamento.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'it', 1, @currentPageType, '<b>Autorizzazione di pagamento non possibile</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'it', 2, @currentPageType, 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'it', 3, @currentPageType, 'Stabilisca un metodo di autenticazione corrispondente per la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'it', 22, @currentPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'it', 23, @currentPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'it', 32, @currentPageType, 'Pagamento non eseguito - Errore tecnico', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetSMS);

/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;
