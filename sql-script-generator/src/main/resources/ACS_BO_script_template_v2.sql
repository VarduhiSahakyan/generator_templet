USE `${databaseACS_BO}`;

/*Common properties*/;
SET @createdBy ='${createdBy}';
SET @issuerCode = '${issuerCode}';
SET @subIssuerCode = '${subIssuerCode}';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);
SET @updateState = '${updateState}';

SET @MastercardID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MastercardName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');



SET @BankB = 'SWISSQUOTE';
SET @BankUB = 'SQB';

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = '${profileSetName}');




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
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, @updateState, TRUE, NOW(), @binRangeLowerBound1, 16, FALSE, NULL, @binRangeUpperBound1, FALSE, @ProfileSet, @MastercardID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, @updateState, TRUE, NOW(), @binRangeLowerBound2, 16, FALSE, NULL, @binRangeUpperBound2, FALSE, @ProfileSet, @MastercardID, NULL);

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
SET @MastercardID = NULL;
/* Elements for the profile DEFAULT_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'de', 1, 'ALL', @BankUB, @MastercardID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'de', 2, 'ALL', 'se_MasterCard SecureCode�', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'de', 1, @currentPageType, '<b>3D Secure Authentifizierung nicht m�glich</b>', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'de', 2, @currentPageType, '', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'de', 3, @currentPageType, '', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), @updateState,
         'de', 5, @currentPageType, 'Zahlungsfreigabe nicht m�glich', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'de', 22, @currentPageType, '3D Secure Authentifizierung nicht ausgef�hrt - Karte ist nicht f�r 3D Secure registriert', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'de', 23, @currentPageType, 'Die Zahlung konnte nicht ausgef�hrt werden, da Ihre Karte nicht f�r 3D-Secure-Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie, Ihre Karte gem�� der Anleitung Ihrer Bank entsprechend zu registrieren.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'de', 32, @currentPageType, '3D Secure Authentifizierung nicht ausgef�hrt - Technischer Fehler', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'de', 33, @currentPageType, 'Bei der Bearbeitung Ihrer Anfrage ist leider ein technischer Fehler aufgetreten. Bitte versuchen Sie es sp�ter noch einmal.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'de', 41, @currentPageType, 'Hilfe', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'de', 100, 'ALL', 'H�ndler', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'de', 101, 'ALL', 'Betrag', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'de', 102, 'ALL', 'Datum', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'de', 103, 'ALL', 'Kartennummer', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'de', 104, 'ALL', 'Mobiltelefonnummer', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
		 'de', 220, @currentPageType, '3D Secure Authentifizierung fehlgeschlagen', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
		 'de', 230, @currentPageType, 'Aus Sicherheitsgr�nden wurde Ihre Zahlung nicht ausgef�hrt. Ihre Karte wurde nicht belastet.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'de', 174,@currentPageType, 'Meldung schliessen', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'de', 175,@currentPageType, 'Zur�ck zum Online-Shop', @MastercardID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'de', 1, @helpPage, 'Hilfe', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'de', 2, @helpPage, 'Aus Sicherheitsgr�nden m�ssen Sie sich an das Payment Card Service Helpdesk wenden, um die �nderung Ihrer Mobiltelefonnummer zu beantragen.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'de', 3, @helpPage, 'F�r diese und alle anderen Fragen zu Ihrer Karte erreichen Sie den Helpdesk unter +41 58 721 93 93.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'de', 174, @helpPage, 'Hilfe schliessen', @MastercardID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'de', 16, @currentPageType, 'Zahlung nicht ausgef�hrt - Karte ist nicht f�r 3D Secure registriert', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'de', 17, @currentPageType, 'Die Zahlung konnte nicht ausgef�hrt werden, da Ihre Karte nicht f�r 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gem�ss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'de', 32, @currentPageType, '3D Secure Authentifizierung nicht ausgef�hrt - Technischer Fehler', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'de', 33, @currentPageType, 'Bei der Bearbeitung Ihrer Anfrage ist leider ein technischer Fehler aufgetreten. Bitte versuchen Sie es sp�ter noch einmal.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'de', 41, @currentPageType, 'Hilfe', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'de', 174, @currentPageType, 'Meldung schliessen', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'de', 175, @currentPageType, 'Zur�ck zum Online-Shop', @MastercardID, NULL, @customItemSetREFUSAL);

/*ENGLISH translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'en', 1, 'ALL', @BankUB, @MastercardID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'en', 2, 'ALL', 'se_MasterCard SecureCode�', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'en', 1, @currentPageType, '<b>3D Secure authentication not possible</b>', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'en', 2, @currentPageType, '', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'en', 3, @currentPageType, '', @MastercardID, NULL, @customItemSetREFUSAL),

   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), @updateState,
         'en', 5, @currentPageType, 'Payment approval not possible.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'en', 22, @currentPageType, '3D Secure authentication not completed � card is not registered for 3D Secure', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'en', 23, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'en', 32, @currentPageType, '3D Secure authentication not completed � technical error', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'en', 33, @currentPageType, 'Unfortunately, a technical error occurred while processing your request. Please try again later.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'en', 41, @currentPageType, 'Help', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'en', 100, 'ALL', 'Merchant', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'en', 101, 'ALL', 'Amount', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'en', 102, 'ALL', 'Date', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'en', 103, 'ALL', 'Card number', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'en', 104, 'ALL', 'Mobile phone number', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
		 'en', 220, @currentPageType, '3D Secure authentication failed', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
		 'en', 230, @currentPageType, 'For security reasons, your payment was not completed and your card not debited.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'en', 174,@currentPageType, 'Close message', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'en', 175,@currentPageType, 'Back to the online shop', @MastercardID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'en', 1, @helpPage, 'Help', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'en', 2, @helpPage, 'For security reasons, you must contact the Payment Card Service Helpdesk to request the modification of your mobile phone number.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'en', 3, @helpPage, 'For this and any other issues with your card, you can reach the Helpdesk on +41 58 721 93 93.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'en', 174, @helpPage, 'Close Help', @MastercardID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'en', 16, @currentPageType, 'Payment not completed � card is not registered for 3D Secure.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'en', 17, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'en', 32, @currentPageType, '3D Secure authentication not completed � technical error', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'en', 33, @currentPageType, 'Unfortunately, a technical error occurred while processing your request. Please try again later.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'en', 41, @currentPageType, 'Help', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'en', 174, @currentPageType, 'Close message', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'en', 175, @currentPageType, 'Back to the online shop', @MastercardID, NULL, @customItemSetREFUSAL);


/*FRENCH translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'fr', 1, 'ALL', @BankUB, @MastercardID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'fr', 2, 'ALL', 'se_MasterCard SecureCode�', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'fr', 1, @currentPageType, '<b>Authentification 3D Secure impossible</b>', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'fr', 2, @currentPageType, '', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'fr', 3, @currentPageType, '', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), @updateState,
         'fr', 5, @currentPageType, 'Activation de paiement impossible', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'fr', 22, @currentPageType, 'Authentification 3D Secure non effectu� - La carte n''est pas enregistr�e pour 3D Secure', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'fr', 23, @currentPageType, 'Le paiement n''as pas pu �tre effectu� car votre carte n''est pas enregistr�e pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conform�ment aux instructions de votre banque.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'fr', 32, @currentPageType, 'Authentification 3D Secure non effectu�e - Erreur technique', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'fr', 33, @currentPageType, 'Malheureusement une erreur technique est survenue lors du traitement de votre demande. Veuillez r�essayer plus tard.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'fr', 41, @currentPageType, 'Aide', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'fr', 100, 'ALL', 'Commer�ant', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'fr', 101, 'ALL', 'Montant', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'fr', 102, 'ALL', 'Date', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'fr', 103, 'ALL', 'Num�ro de carte', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'fr', 104, 'ALL', 'Num�ro de t�l�phone mobile', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
		 'fr', 220, @currentPageType, 'L''authentification 3D Secure a �chou�', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
		 'fr', 230, @currentPageType, 'Pour des raisons de s�curit�, votre paiement n''a pas �t� trait�. Votre carte n''a pas �t� d�bit�e.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'fr', 174,@currentPageType, 'Fermer le message', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'fr', 175,@currentPageType, 'Retour vers la boutique en ligne', @MastercardID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'fr', 1, @helpPage, 'Aide', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'fr', 2, @helpPage, 'Pour des raisons de s�curit�, vous devez contacter le Payment Card Service Helpdesk afin de demander la modification de votre num�ro de t�l�phone portable.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'fr', 3, @helpPage, 'Pour ce faire et pour tout autre probl�me, vous pouvez contacter le HelpDesk au num�ro +41 58 721 93 93.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'fr', 174, @helpPage, 'Fermer l''aide', @MastercardID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'fr', 16, @currentPageType, 'Le paiement n''a pas �t� effectu� - La carte n''est pas enregistr�e pour 3D Secure', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'fr', 17, @currentPageType, 'Le paiement n''as pas pu �tre effectu� car votre carte n''est pas enregistr�e pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conform�ment aux instructions de votre banque.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'fr', 32, @currentPageType, 'Authentification 3D Secure non effectu�e - Erreur technique', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'fr', 33, @currentPageType, 'Malheureusement une erreur technique est survenue lors du traitement de votre demande. Veuillez r�essayer plus tard.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'fr', 41, @currentPageType, 'Aide', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'fr', 174, @currentPageType, 'Fermer le message', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MastercardID, NULL, @customItemSetREFUSAL);



/*Italian translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'it', 1, 'ALL', @BankUB, @MastercardID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'it', 2, 'ALL', 'se_MasterCard SecureCode�', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'it', 1, @currentPageType, '<b>L''autenticazione 3D Secure non � possibile</b>', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'it', 2, @currentPageType, '', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'it', 3, @currentPageType, '', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_5'), @updateState,
         'it', 5, @currentPageType, 'Autorizzazione di pagamento non possibile', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'it', 22, @currentPageType, 'Autenticazione 3D Secure non eseguita  - La carta non � registrata per 3D Secure', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'it', 23, @currentPageType, 'Non � stato possibile effettuare il pagamento perch� la sua carta non � registrata per i pagamenti 3D Secure. Se desidera continuare l�acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'it', 32, @currentPageType, 'Autenticazione 3D Secure non eseguita - Errore tecnico', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'it', 33, @currentPageType, 'Spiacenti. Si � verificato un errore tecnico durante l�elaborazione della sua richiesta. La preghiamo di riprovare pi� tardi.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'it', 41, @currentPageType, 'Aiuto', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'it', 100, 'ALL', 'Commerciante', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'it', 101, 'ALL', 'Importo', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'it', 102, 'ALL', 'Data', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'it', 103, 'ALL', 'Numero di carta', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'it', 104, 'ALL', 'Numero di cellulare', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
		 'it', 220, @currentPageType, 'Autenticazione 3D Secure non riuscita', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
		 'it', 230, @currentPageType, 'Per motivi di sicurezza, il tuo pagamento non � stato elaborato. La tua carta non � stata addebitata.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'it', 174,@currentPageType, 'Chiudere messaggio', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'it', 175,@currentPageType, 'Indietro al negozio online', @MastercardID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'it', 1, @helpPage, 'Aiuto', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'it', 2, @helpPage, 'Per motivi di sicurezza, per richiedere la modifica del suo numero di cellulare dovr� contattare il Payment Card Service Helpdesk.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'it', 3, @helpPage, 'Per questo e in caso di problema, puo contattare l�Helpdesk al seguente numero di telefono: +41 58 721 93 93.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'it', 174, @helpPage, 'Chiudere l�aiuto', @MastercardID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'it', 16, @currentPageType, 'Pagamento non eseguito - La carta non � registrata per 3D Secure', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'it', 17, @currentPageType, 'Non � stato possibile effettuare il pagamento perch� la sua carta non � registrata per i pagamenti 3D Secure. Se desidera continuare l�acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'it', 32, @currentPageType, 'Autenticazione 3D Secure non eseguita - Errore tecnico', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'it', 33, @currentPageType, 'Spiacenti. Si � verificato un errore tecnico durante l�elaborazione della sua richiesta. La preghiamo di riprovare pi� tardi.', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'it', 41, @currentPageType, 'Aiuto', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'it', 174, @currentPageType, 'Chiudere messaggio', @MastercardID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'it', 175, @currentPageType, 'Indietro al negozio online', @MastercardID, NULL, @customItemSetREFUSAL);

SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusalMissing FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetREFUSAL;

SET @currentPageType = 'ALL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Die Zahlung kann nicht ausgef�hrt werden. Bitte kontaktieren Sie den Payment Card Service Helpdesk unter +41 58 721 93 93.', @MastercardID, NULL, @customItemSetRefusalMissing),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'The payment cannot be processed. Please contact the Payment Card Service Helpdesk on +41 58 721 93 93.', @MastercardID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'it', 1000, @currentPageType, 'La transazione non � andata a buon fine. Si prega di contattare il Payment Card Service Helpdesk al numero +41 58 721 93 93.', @MastercardID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'fr', 1000, @currentPageType, 'La transaction n''a pas abouti. Veuillez contacter le Payment Card Service Helpdesk au +41 58 721 93 93.', @MastercardID, NULL, @customItemSetRefusalMissing),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Die Zahlung kann nicht ausgef�hrt werden. Bitte kontaktieren Sie den Payment Card Service Helpdesk unter +41 58 721 93 93.', @MastercardID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'The payment cannot be processed. Please contact the Payment Card Service Helpdesk on +41 58 721 93 93.', @MastercardID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'it', 1001, @currentPageType, 'La transazione non � andata a buon fine. Si prega di contattare il Payment Card Service Helpdesk al numero +41 58 721 93 93.', @MastercardID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'fr', 1001, @currentPageType, 'La transaction n''a pas abouti. Veuillez contacter le Payment Card Service Helpdesk au +41 58 721 93 93.', @MastercardID, NULL, @customItemSetRefusalMissing),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Die Zahlung kann nicht ausgef�hrt werden. Bitte kontaktieren Sie den Payment Card Service Helpdesk unter +41 58 721 93 93.', @MastercardID, NULL, @customItemSetRefusalMissing),
   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'The payment cannot be processed. Please contact the Payment Card Service Helpdesk on +41 58 721 93 93.', @MastercardID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'it', 1002, @currentPageType, 'La transazione non � andata a buon fine. Si prega di contattare il Payment Card Service Helpdesk al numero +41 58 721 93 93.', @MastercardID, NULL, @customItemSetRefusalMissing),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'fr', 1002, @currentPageType, 'La transaction n''a pas abouti. Veuillez contacter le Payment Card Service Helpdesk au +41 58 721 93 93.', @MastercardID, NULL, @customItemSetRefusalMissing);

/* Elements for the profile SMS : */
SET @currentAuthentMean = 'OTP_SMS';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the SMS Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'de', 1, 'ALL', @BankUB, @MastercardID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'de', 2, 'ALL', 'se_MasterCard SecureCode�', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', @updateState, 'de', 0, 'MESSAGE_BODY',
        'Ihr Authentifizierungscode lautet @otp f�r Ihren Kauf von @amount bei @merchant mit Karte @maskedPan, am @formattedDate.', @MastercardID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'de', 1, @currentPageType, '<b>3D Secure Authentifizierung via SMS</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'de', 2, @currentPageType, 'Authentifizierungscode Code bitte hier eingeben:', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), @updateState,
         'de', 12, @currentPageType, '3D Secure Authentifizierung wird gepr�ft', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), @updateState,
         'de', 13, @currentPageType, 'Bitte haben Sie einen Moment Geduld. Wir pr�fen Ihre Zahlungsfreigabe und somit die Authentifikation f�r die gew�nschte Zahlung.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), @updateState,
         'de', 14, @currentPageType, '3D Secure Authentifizierung abgebrochen', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), @updateState,
         'de', 15, @currentPageType, 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess trotzdem fortsetzen m�chten, starten Sie den Zahlungsversuch bitte erneut.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), @updateState,
         'de', 19, @currentPageType, 'SMS TAN erneut senden', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'de', 22, @currentPageType, '3D Secure Authentifizierung fehlgeschlagen', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'de', 23, @currentPageType, 'Sie haben 3 Mal einen ung�ltigen Authentifizierungscode eingegeben. 3D Secure wurde f�r Ihre Karte gesperrt und die Zahlung wurde nicht ausgef�hrt.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), @updateState,
         'de', 26, @currentPageType, '3D Secure Authentifizierung war erfolgreich', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), @updateState,
         'de', 27, @currentPageType, 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum H�ndler weitergeleitet.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), @updateState,
         'de', 28, @currentPageType, 'Ung�ltiger Authentifizierungscode', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), @updateState,
         'de', 29, @currentPageType, 'Der von Ihnen eingegebene Ung�ltiger Authentifizierungscode ist ung�ltig. Die Zahlung wurde nicht ausgef�hrt und Ihre Karte wurde nicht belastet. Sofern Sie den Kauf fortsetzen wollen, versuchen Sie es erneut.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), @updateState,
         'de', 30, @currentPageType, 'Zahlung nicht ausgef�hrt - Sitzung abgelaufen', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), @updateState,
         'de', 31, @currentPageType, 'Ihre Sitzung ist nach einer l�ngeren Inaktivit�t abgelaufen. Aus Sicherheitsgr�nden wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zum Online-Shop zur�ck und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung t�tigen wollen.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'de', 32, @currentPageType, 'Zahlung nicht ausgef�hrt - Technischer Fehler', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgef�hrt werden und Ihre Karte wurde nicht belastet. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MastercardID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), @updateState,
         'de', 34, @currentPageType, 'Ein neuer Authentifizierungscode wurde Ihnen per SMS gesendet.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), @updateState,
         'de', 35, @currentPageType, 'Bitte haben Sie einen kleinen Moment Geduld. In K�rze erhalten Sie einen neuen Authentifizierungscode an Ihre Mobiltelefonnummer.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), @updateState,
         'de', 40, @currentPageType, 'Abbrechen', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'de', 41, @currentPageType, 'Hilfe', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), @updateState,
         'de', 42, @currentPageType, 'Best�tigen', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'de', 100, 'ALL', 'H�ndler', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'de', 101, 'ALL', 'Betrag', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'de', 102, 'ALL', 'Datum', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'de', 103, 'ALL', 'Kartennummer', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'de', 104, 'ALL', 'Mobiltelefonnummer', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'de', 174, @currentPageType, 'Meldung schliessen', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'de', 175, @currentPageType, 'Zur�ck zum Online-Shop', @MastercardID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'de', 1, @currentPageType, 'Hilfe', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'de', 2, @currentPageType, 'Aus Sicherheitsgr�nden m�ssen Sie sich an das Payment Card Service Helpdesk wenden, um die �nderung Ihrer Mobiltelefonnummer zu beantragen.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'de', 3, @currentPageType, 'F�r diese und alle anderen Fragen zu Ihrer Karte erreichen Sie den Helpdesk unter +41 58 721 93 93.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'de', 174, @currentPageType, 'Hilfe schlie�en', @MastercardID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'de', 16, @currentPageType, '3D Secure Authentifizierung fehlgeschlagen', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'de', 17, @currentPageType, 'Sie haben 3 Mal einen ung�ltigen Authentifizierungscode eingegeben. 3D Secure wurde f�r Ihre Karte gesperrt und die Zahlung wurde nicht ausgef�hrt.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'de', 32, @currentPageType, 'Zahlung nicht ausgef�hrt - Technischer Fehler', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgef�hrt werden und Ihre Karte wurde nicht belastet. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'de', 41, @currentPageType, 'Hilfe', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'de', 174, @currentPageType, 'Meldung schliessen', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'de', 175, @currentPageType, 'Zur�ck zum Online-Shop', @MastercardID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'de', 1, @currentPageType, '<b>Zahlungsfreigabe nicht m�glich</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'de', 2, @currentPageType, 'Leider konnten wir Ihre Anfrage nicht ausf�hren, da wir keine Freigabe-Methode (SMS oder App) f�r Ihre Karte gefunden haben. ', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'de', 3, @currentPageType, 'Bitte hinterlegen Sie f�r Ihre Karte eine entsprechende Freigabe-Methode im Registrierungsportal gem�ss der Anleitung Ihrer Bank. ', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'de', 22, @currentPageType, 'Zahlung nicht ausgef�hrt - Karte ist nicht f�r 3D Secure registriert', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'de', 23, @currentPageType, 'Die Zahlung konnte nicht ausgef�hrt werden, da Ihre Karte nicht f�r 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gem�ss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'de', 32, @currentPageType, 'Zahlung nicht ausgef�hrt - Technischer Fehler', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'de', 33, @currentPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgef�hrt werden und Ihre Karte wurde nicht belastet. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'de', 41, @currentPageType, 'Hilfe', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'de', 174, @currentPageType, 'Meldung schliessen', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'de', 175, @currentPageType, 'Zur�ck zum Online-Shop', @MastercardID, NULL, @customItemSetSMS);


/*ENGLISH translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'en', 1, 'ALL', @BankUB, @MastercardID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'en', 2, 'ALL', 'se_MasterCard SecureCode�', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', @updateState, 'en', 0, 'MESSAGE_BODY',
        'Your authentication code is @otp for your @amount purchase at @merchant with card @maskedPan, on @formattedDate.', @MastercardID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'en', 1, @currentPageType, '<b>3D Secure authentication via SMS</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'en', 2, @currentPageType, 'Please enter authentication code here:', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), @updateState,
         'en', 12, @currentPageType, '3D Secure authentication is being verified', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), @updateState,
         'en', 13, @currentPageType, 'Please be patient. We are verifying your payment approval and thereby the authentication for the requested payment.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), @updateState,
         'en', 14, @currentPageType, '3D Secure authentication cancelled', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), @updateState,
         'en', 15, @currentPageType, 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the purchase process, please start the payment attempt again. ', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), @updateState,
         'en', 19, @currentPageType, 'Resend SMS Code', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'en', 22, @currentPageType, '3D Secure authentication failed', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'en', 23, @currentPageType, 'You have entered an invalid authentication code 3 times.The 3D Secure service has been blocked for your card and the payment was not completed.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), @updateState,
         'en', 26, @currentPageType, 'Successful 3D Secure authentication', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), @updateState,
         'en', 27, @currentPageType, 'You have successfully approved the payment and will be automatically routed back to the merchant.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), @updateState,
         'en', 28, @currentPageType, 'Invalid authentication code', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), @updateState,
         'en', 29, @currentPageType, 'The authentication code you entered is invalid. The payment was not conducted and your card was not debited. Please try again if you wish to continue the purchase.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), @updateState,
         'en', 30, @currentPageType, 'Payment not completed � session expired', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), @updateState,
         'en', 31, @currentPageType, 'Your session has expired due to an extended period of inactivity. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process, if you wish to make the purchase.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'en', 32, @currentPageType, 'Payment not completed � technical error', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), @updateState,
         'en', 34, @currentPageType, 'A new authentication code has been sent by SMS to your mobile phone number.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), @updateState,
         'en', 35, @currentPageType, 'Please wait, this may take a moment. A new authentication code will be sent to your mobile phone number.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), @updateState,
         'en', 40, @currentPageType, 'Quit', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'en', 41, @currentPageType, 'Help', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), @updateState,
         'en', 42, @currentPageType, 'Submit', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'en', 100, 'ALL', 'Merchant', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'en', 101, 'ALL', 'Amount', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'en', 102, 'ALL', 'Date', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'en', 103, 'ALL', 'Card number', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'en', 104, 'ALL', 'Mobile phone number', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'en', 174, @currentPageType, 'Close message', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'en', 175, @currentPageType, 'Back to the online shop', @MastercardID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'en', 1, @currentPageType, 'Help', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'en', 2, @currentPageType, 'For security reasons, you must contact the Payment Card Service Helpdesk to request the modification of your mobile phone number.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'en', 3, @currentPageType, 'For this and any other issues with your card, you can reach the Helpdesk on +41 58 721 93 93.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'en', 174, @currentPageType, 'Close Help', @MastercardID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'en', 16, @currentPageType, '3D Secure authentication failed', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'en', 17, @currentPageType, 'You have entered an invalid authentication code 3 times.The 3D Secure service has been blocked for your card and the payment was not completed.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'en', 32, @currentPageType, 'Payment not completed � technical error', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'en', 41, @currentPageType, 'Help', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'en', 174, @currentPageType, 'Close message', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'en', 175, @currentPageType, 'Back to the online shop', @MastercardID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'en', 1, @currentPageType, '<b>Payment approval not possible.</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'en', 2, @currentPageType, 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. ', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'en', 3, @currentPageType, 'Please set up a corresponding approval method for your card on the registration portal according to your bank''s instructions. ', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'en', 22, @currentPageType, 'Payment not completed � card is not registered for 3D Secure.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'en', 23, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'en', 32, @currentPageType, 'Payment not completed � technical error', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'en', 33, @currentPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'en', 41, @currentPageType, 'Help', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'en', 174, @currentPageType, 'Close message', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'en', 175, @currentPageType, 'Back to the online shop', @MastercardID, NULL, @customItemSetSMS);




/*FRENCH translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'fr', 1, 'ALL', @BankUB, @MastercardID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'fr', 2, 'ALL', 'se_MasterCard SecureCode�', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', @updateState, 'fr', 0, 'MESSAGE_BODY',
        'Votre code d''authentification est le @otp pour votre achat de @amount aupr�s de @merchant avec votre carte @maskedPan, le @formattedDate.', @MastercardID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'fr', 1, @currentPageType, '<b>Authentification 3D Secure par SMS</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'fr', 2, @currentPageType, 'Veuillez saisir ici le code d''authentification:', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), @updateState,
         'fr', 12, @currentPageType, 'L''authentification 3D Secure va �tre v�rifi�e', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), @updateState,
         'fr', 13, @currentPageType, 'Merci de patienter. Nous v�rifions l''authentification pour le paiement souhait�.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), @updateState,
         'fr', 14, @currentPageType, 'Authentification 3D Secure annul�e', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), @updateState,
         'fr', 15, @currentPageType, 'Le paiement a �t� interrompu et votre carte n�a pas �t� d�bit�e. Si vous souhaitez malgr� tout continuer le processus d�achat, veuillez recommencer la tentative de paiement.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), @updateState,
         'fr', 19, @currentPageType, 'Renvoyer le code SMS', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'fr', 22, @currentPageType, 'L''authentification 3D Secure a �chou�', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'fr', 23, @currentPageType, 'Vous avez entr� un code d�authentification invalide 3 fois. Le service 3D Secure a �t� bloqu� pour votre carte et le paiement n�a pas �t� r�alis�.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), @updateState,
         'fr', 26, @currentPageType, 'L''autorisation 3D Secure a r�ussi', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), @updateState,
         'fr', 27, @currentPageType, 'Vous avez r�ussi � activer le paiement et vous serez redirig� automatiquement vers le site du commer�ant.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), @updateState,
         'fr', 28, @currentPageType, 'Code d�authentification incorrect', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), @updateState,
         'fr', 29, @currentPageType, 'Le code d�authentification que vous avez saisi n''est pas correct. Le paiement n''a pas �t� effectu� et votre carte n''a pas �t� d�bit�e. Si vous voulez continuer l''achat, essayez � nouveau.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), @updateState,
         'fr', 30, @currentPageType, 'Paiement non effectu� - La session a expir�', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), @updateState,
         'fr', 31, @currentPageType, 'Votre session a expir� en raison d''une trop longue p�riode d''inactivit�. Pour des raisons de s�curit�, la proc�dure de paiement a donc �t� interrompue. Veuillez retourner sur la boutique en ligne et recommencez la proc�dure de paiement si vous voulez effectuer l''achat.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'fr', 32, @currentPageType, 'Paiement non effectu� - Probl�me technique', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'fr', 33, @currentPageType, 'En raison d�un probl�me technique, le paiement n�a pas pu �tre effectu� et votre carte n�a pas �t� d�bit�e. Si vous souhaitez poursuivre l�achat, nous vous prions de bien vouloir essayer � nouveau.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), @updateState,
         'fr', 34, @currentPageType, 'Un nouveau code d�authentification vient de vous �tre transmis par SMS.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), @updateState,
         'fr', 35, @currentPageType, 'Veuillez patienter un instant. Vous recevrez d�ici peu un nouveau code�d�authentification�sur votre num�ro de t�l�phone�mobile.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), @updateState,
         'fr', 40, @currentPageType, 'Abandonner', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'fr', 41, @currentPageType, 'Aide', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), @updateState,
         'fr', 42, @currentPageType, 'Valider', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'fr', 100, 'ALL', 'Commer�ant', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'fr', 101, 'ALL', 'Montant', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'fr', 102, 'ALL', 'Date', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'fr', 103, 'ALL', 'Num�ro de carte', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'fr', 104, 'ALL', 'Num�ro de t�l�phone mobile', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'fr', 174, @currentPageType, 'Fermer le message', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MastercardID, NULL, @customItemSetSMS);



/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'fr', 1, @currentPageType, 'Aide', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'fr', 2, @currentPageType, 'Pour des raisons de s�curit�, vous devez contacter le Payment Card Service Helpdesk afin de demander la modification de votre num�ro de t�l�phone portable.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'fr', 3, @currentPageType, 'Pour ce faire et pour tout autre probl�me, vous pouvez contacter le HelpDesk au num�ro +41 58 721 93 93.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'fr', 174, @currentPageType, 'Fermer l''aide', @MastercardID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'fr', 16, @currentPageType, 'L''authentification 3D Secure a �chou�', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'fr', 17, @currentPageType, 'Vous avez entr� un code d�authentification invalide 3 fois. Le service 3D Secure a �t� bloqu� pour votre carte et le paiement n�a pas �t� r�alis�.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'fr', 32, @currentPageType, 'Paiement non effectu� - Probl�me technique', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'fr', 33, @currentPageType, 'En raison d�un probl�me technique, le paiement n�a pas pu �tre effectu� et votre carte n�a pas �t� d�bit�e. Si vous souhaitez poursuivre l�achat, nous vous prions de bien vouloir essayer � nouveau.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'fr', 41, @currentPageType, 'Aide', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'fr', 174, @currentPageType, 'Fermer le message', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MastercardID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'fr', 1, @currentPageType, '<b>Activation de paiement impossible</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'fr', 2, @currentPageType, 'Nous n''avons malheureusement pas pu r�pondre � votre demande car nous n''avons trouv� aucune m�thode d''activation (SMS ou App) pour votre carte. ', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'fr', 3, @currentPageType, 'Veuillez consigner une m�thode d''activation pour votre carte dans le portail d�inscription, conform�ment aux instructions de votre banque.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'fr', 22, @currentPageType, 'Le paiement n''a pas �t� effectu� - La carte n''est pas enregistr�e pour 3D Secure', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'fr', 23, @currentPageType, 'Le paiement n''as pas pu �tre effectu� car votre carte n''est pas enregistr�e pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conform�ment aux instructions de votre banque.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'fr', 32, @currentPageType, 'Paiement non effectu� - Probl�me technique', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'fr', 33, @currentPageType, 'En raison d''une erreur technique, le paiement n''a pas pu �tre effectu�. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer � nouveau.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'fr', 41, @currentPageType, 'Aide', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'fr', 174, @currentPageType, 'Fermer le message', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MastercardID, NULL, @customItemSetSMS);




/*ITALIAN translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
         'it', 1, 'ALL', @BankUB, @MastercardID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState,
         'it', 2, 'ALL', 'se_MasterCard SecureCode�', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', @updateState, 'it', 0, 'MESSAGE_BODY',
        'Il suo codice di autenticazione � il @otp per suo acquisto di @amount da @merchant con la sua carta @maskedPan, il @formattedDate.', @MastercardID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'it', 1, @currentPageType, '<b>Autenticazione 3D Secure tramite SMS</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'it', 2, @currentPageType, 'Inserisca qui il codice di autenticazione:', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), @updateState,
         'it', 12, @currentPageType, 'L''autenticazione 3D Secure viene controllata', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), @updateState,
         'it', 13, @currentPageType, 'La preghiamo di aspettare un attimo. Stiamo verificando la sua autorizzazione di pagamento e quindi l�autenticazione per il pagamento desiderato.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), @updateState,
         'it', 14, @currentPageType, 'Autenticazione 3D Secure annullata', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), @updateState,
         'it', 15, @currentPageType, 'Il pagamento � stato annullato e la sua carta non � stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), @updateState,
         'it', 19, @currentPageType, 'Invia nuovo codice SMS', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'it', 22, @currentPageType, 'Autenticazione 3D Secure non riuscita', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'it', 23, @currentPageType, 'Ha inserito 3 volte un codice di autenticazione non valido. Il servizio 3D Secure � stato bloccato per la sua carta; non � stato pertanto possibile effettuare il pagamento.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), @updateState,
         'it', 26, @currentPageType, 'L''autorizzazione 3D Secure � stata eseguita correttamente', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), @updateState,
         'it', 27, @currentPageType, 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), @updateState,
         'it', 28, @currentPageType, 'Codice di autenticazione non valido', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), @updateState,
         'it', 29, @currentPageType, 'Il codice di autenticazione inserito da lei non � valido. Il pagamento non � stato eseguito e la sua carta non � stata addebitata. Se desidera continuare l�acquisto, provi nuovamente.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), @updateState,
         'it', 30, @currentPageType, 'Pagamento non effettuato - Sessione scaduta', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), @updateState,
         'it', 31, @currentPageType, 'La sua sessione � scaduta in seguito a un periodo di inattivit� prolungato. Il processo di pagamento � stato quindi annullato per motivi di sicurezza. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'it', 33, @currentPageType, 'Non � stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non � stata addebitata. Se desidera continuare l�acquisto, la preghiamo di riprovare nuovamente.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), @updateState,
         'it', 34, @currentPageType, 'Abbiamo inviato tramite SMS al suo numero di cellulare un nuovo codice di autenticazione.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), @updateState,
         'it', 35, @currentPageType, 'La preghiamo di aspettare. A breve ricever� un nuovo codice di autenticazione sul suo numero di cellulare.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), @updateState,
         'it', 40, @currentPageType, 'Esci', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'it', 41, @currentPageType, 'Aiuto', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), @updateState,
         'it', 42, @currentPageType, 'Continua', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
         'it', 100, 'ALL', 'Commerciante', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), @updateState,
         'it', 101, 'ALL', 'Importo', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), @updateState,
         'it', 102, 'ALL', 'Data', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), @updateState,
         'it', 103, 'ALL', 'Numero di carta', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), @updateState,
         'it', 104, 'ALL', 'Numero di cellulare', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'it', 174, @currentPageType, 'Chiudere messaggio', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'it', 175, @currentPageType, 'Indietro al negozio online', @MastercardID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_1'), @updateState,
         'it', 1, @currentPageType, 'Aiuto', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_2'), @updateState,
         'it', 2, @currentPageType, 'Per motivi di sicurezza, per richiedere la modifica del suo numero di cellulare dovr� contattare il Payment Card Service Helpdesk.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_3'), @updateState,
         'it', 3, @currentPageType, 'Per questo e in caso di problema, puo contattare l�Helpdesk al seguente numero di telefono: +41 58 721 93 93.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@helpPage,'_174'), @updateState,
         'it', 174, @currentPageType, 'Chiudere l�aiuto', @MastercardID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
         'it', 16, @currentPageType, 'Autenticazione 3D Secure non riuscita', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
         'it', 17, @currentPageType, 'Ha inserito 3 volte un codice di autenticazione non valido. Il servizio 3D Secure � stato bloccato per la sua carta; non � stato pertanto possibile effettuare il pagamento.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'it', 33, @currentPageType, 'Non � stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non � stata addebitata. Se desidera continuare l�acquisto, la preghiamo di riprovare nuovamente.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'it', 41, @currentPageType, 'Aiuto', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'it', 174, @currentPageType, 'Chiudere messaggio', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'it', 175, @currentPageType, 'Indietro al negozio online', @MastercardID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
         'it', 1, @currentPageType, '<b>Autorizzazione di pagamento non possibile</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
         'it', 2, @currentPageType, 'Purtroppo non siamo riusciti a elaborare la sua richiesta perch� non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta. ', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), @updateState,
         'it', 3, @currentPageType, 'Stabilisca un metodo di autenticazione corrispondente per la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), @updateState,
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), @updateState,
         'it', 22, @currentPageType, 'Pagamento non eseguito - La carta non � registrata per 3D Secure', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), @updateState,
         'it', 23, @currentPageType, 'Non � stato possibile effettuare il pagamento perch� la sua carta non � registrata per i pagamenti 3D Secure. Se desidera continuare l�acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
         'it', 32, @currentPageType, 'Pagamento non eseguito - Errore tecnico', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
         'it', 33, @currentPageType, 'Non � stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l�acquisto, la preghiamo di riprovare nuovamente.', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
         'it', 41, @currentPageType, 'Aiuto', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), @updateState,
         'it', 174, @currentPageType, 'Chiudere messaggio', @MastercardID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MastercardName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), @updateState,
         'it', 175, @currentPageType, 'Indietro al negozio online', @MastercardID, NULL, @customItemSetSMS);

/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;
