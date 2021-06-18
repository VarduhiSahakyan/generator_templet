USE `U7G_ACS_BO`;

SET @createdBy ='W100851';
SET @issuerCode = '70000';
SET @subIssuerCode = '70000';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

SET @BankUB = 'ZKB';

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
SELECT n.id, si.id
FROM `Network` n, `SubIssuer` si
WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
AND n.code = 'VISA';


SET @subIssuerIDSOBA = (SELECT id FROM SubIssuer where code = 83340 AND name = 'Baloise Bank SoBa AG');

/* BinRange */
/* In this table, in the case of co-branding the primary network will be present as a foreign key (fk_id_network) and
   the 'alternative' network will be present through the field 'coBrandedCardNetwork' which contains a string that matches
   the field 'code' of the Network (it plays the same role as a foreign key, because the code is unique for each Network)
*/
SET @updateState = 'PUSHED_TO_CONFIG';

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						`name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
						`sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
						`coBrandedCardNetwork`) VALUES
('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, @updateState, TRUE, NOW(), '4395907000', 16, FALSE, NULL, '4395907099', FALSE, @ProfileSet, @MaestroVID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
SELECT b.id, s.id
FROM BinRange b, SubIssuer s
WHERE b.lowerBound = '4395907000' AND b.upperBound = '4395907099'
AND b.fk_id_profileSet=@ProfileSet
AND s.code=@subIssuerCode;

/* CustomItem */
/* Create custom items for default language and backup languages - in this example de and en */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;

SET @MaestroVID = NULL;
SET @refusalPageType = 'REFUSAL_PAGE';
SET @helpPagePageType = 'HELP_PAGE';
SET @failurePagePageType = 'FAILURE_PAGE';
SET @otpFormPagePageType = 'OTP_FORM_PAGE';
SET @pollingPagePageType = 'POLLING_PAGE';


SET @refusalAuthentMean = 'REFUSAL';
SET @otpSMSExtMessageAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @mobilleAppExtAuthentMean = 'MOBILE_APP_EXT';

/* ----------- Elements for the profile DEFAULT_REFUSAL : ------------*/
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
		'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetREFUSAL
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
		'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

/* ----------- DE Elements for the profile DEFAULT_REFUSAL : ------------*/


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'de', 1, @refusalPageType, '<b>Zahlungsfreigabe nicht möglich</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'de', 2, @refusalPageType, 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (SMS oder App) für Ihre Karte gefunden haben. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'de', 3, @refusalPageType, 'Bitte hinterlegen Sie für Ihre Karte eine entsprechende Freigabe-Methode im Registrierungsportal gemäss der Anleitung Ihrer Bank. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'de', 11, @refusalPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'de', 22, @refusalPageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'de', 23, @refusalPageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'de', 32, @refusalPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'de', 33, @refusalPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'de', 41, @refusalPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'de', 174,@refusalPageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetREFUSAL),


('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'de', 175,@refusalPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetREFUSAL);

# ------------- HELP PAGE ----------

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'de', 1, @helpPagePageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'de', 2, @helpPagePageType, 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat die Zürcher Kantonalbank eine zweistufige Authentifikation eingeführt.	', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'de', 3, @helpPagePageType, 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder anhand eines Freigabe-Codes per SMS, oder durch die Verifikation Ihrer Person auf einer Mobile Authentifikations-App bestätigen. Für diesen Service müssen Sie sich einmalig registrieren. Für den entsprechenden Registrierungsprozess, oder Änderungen Ihrer Authentifikationsmethode, wenden Sie sich bitte an die Zürcher Kantonalbank.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'de', 174, @helpPagePageType, 'Hilfe-Text schliessen', @MaestroVID, NULL, @customItemSetREFUSAL);


# --------- FAILURE_PAGE -----------

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'de', 11, @failurePagePageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'de', 16, @failurePagePageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'de', 17, @failurePagePageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'de', 32, @failurePagePageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'de', 33, @failurePagePageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet.Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'de', 41, @failurePagePageType, 'Hilfe', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'de', 174, @failurePagePageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'de', 175, @failurePagePageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetREFUSAL);


/*ENGLISH translations for DEFAULT_REFUSAL*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'en', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetREFUSAL
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'en', 1, @refusalPageType, '<b>Payment approval not possible.</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'en', 2, @refusalPageType, 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'en', 3, @refusalPageType, 'Please set up a corresponding approval method for your card on the registration portal according to your bank''s instructions. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'en', 11, @refusalPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'en', 22, @refusalPageType, 'Payment not completed – card is not registered for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'en', 23, @refusalPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'en', 32, @refusalPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'en', 33, @refusalPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'en', 41, @refusalPageType, 'Help', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'en', 100, 'ALL', 'Merchant', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'en', 101, 'ALL', 'Amount', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'en', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'en', 103, 'ALL', 'Card number', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'en', 104, 'ALL', 'Phone number', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'en', 174,@refusalPageType, 'Close message', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'en', 175,@refusalPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetREFUSAL);



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'en', 1, @helpPagePageType, '<b>Help</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'en', 2, @helpPagePageType, 'To boost security while paying online, Zürcher Kantonalbank has introduced two-level authentification. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'en', 3, @helpPagePageType, 'To complete a payment, you must confirm it either by means of an approval code per SMS, or through verification of your identity with a mobile authentication app. You need to register once for this service. Contact Zürcher Kantonalbank for the corresponding registration process or changes to your authentification method.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'en', 174, @helpPagePageType, 'Close help text', @MaestroVID, NULL, @customItemSetREFUSAL);



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'en', 11, @failurePagePageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'en', 16, @failurePagePageType, 'Payment not completed – card is not registered for 3-D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'en', 17, @failurePagePageType, 'The payment could not be completed because your card is not registered for 3-D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'en', 32, @failurePagePageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'en', 33, @failurePagePageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'en', 41, @failurePagePageType, 'Help', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'en', 174, @failurePagePageType, 'Close message', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'en', 175, @failurePagePageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetREFUSAL);



/*FRENCH translations for DEFAULT_REFUSAL*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'fr', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetREFUSAL
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'fr', 1, @refusalPageType, '<b>Activation de paiement impossible</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'fr', 2, @refusalPageType, '''Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'fr', 3, @refusalPageType, 'Veuillez consigner une méthode d''activation pour votre carte dans le portail d’inscription, conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'fr', 11, @refusalPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'fr', 22, @refusalPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'fr', 23, @refusalPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'fr', 32, @refusalPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'fr', 33, @refusalPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'fr', 41, @refusalPageType, 'Aide', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'fr', 100, 'ALL', 'Commerçant', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'fr', 101, 'ALL', 'Montant', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'fr', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'fr', 103, 'ALL', 'Numéro de carte', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'fr', 174,@refusalPageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'fr', 175,@refusalPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetREFUSAL);



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'fr', 1, @helpPagePageType, '<b>Aide</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'fr', 2, @helpPagePageType, 'Afin d''augmenter votre sécurité lors des paiements en ligne, Zürcher Kantonalbank a mis en place une authentification en deux étapes. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'fr', 3, @helpPagePageType, 'Afin de pouvoir effectuer un paiement, vous devez le confirmer soit au moyen d''un code d''activation par SMS, soit par la vérification de votre personne sur une App d''authentification mobile. Pour ce service, vous devez vous enregistrer une fois. Pour la procédure d''enregistrement correspondante, ou pour les modifications de votre méthode d''authentification, veuillez vous adresser à Zürcher Kantonalbank.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'fr', 174, @helpPagePageType, 'Fermer le texte d''aide', @MaestroVID, NULL, @customItemSetREFUSAL);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'fr', 11, @failurePagePageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'fr', 16, @failurePagePageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'fr', 17, @failurePagePageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'fr', 32, @failurePagePageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'fr', 33, @failurePagePageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'fr', 41, @failurePagePageType, 'Aide', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'fr', 174, @failurePagePageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'fr', 175, @failurePagePageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetREFUSAL);




/*Italian translations for DEFAULT_REFUSAL*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'it', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetREFUSAL
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'it', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'it', 1, @refusalPageType, '<b>Autorizzazione di pagamento non possibile</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'it', 2, @refusalPageType, 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'it', 3, @refusalPageType, ' Stabilisca un metodo di autenticazione corrispondente per la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'it', 11, @refusalPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'it', 22, @refusalPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'it', 23, @refusalPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'it', 32, @refusalPageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'it', 33, @refusalPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'it', 41, @refusalPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'it', 100, 'ALL', 'Commerciante', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'it', 101, 'ALL', 'Importo', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'it', 102, 'ALL', 'Data', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'it', 103, 'ALL', 'Numero della carta', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'it', 104, 'ALL', 'Numero di telefono', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'it', 174,@refusalPageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'it', 175,@refusalPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetREFUSAL);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'it', 1, @helpPagePageType, '<b>Aiuto</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'it', 2, @helpPagePageType, 'Al fine di aumentare la sicurezza per i pagamenti online, Zürcher Kantonalbank ha introdotto una procedura di autenticazione in due fasi. ', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'it', 3, @helpPagePageType, ' Per poter effettuare un pagamento, deve confermarlo utilizzando un codice di autenticazione tramite SMS o verificando la sua persona su un’app di autenticazione mobile. Deve effettuare una volta la registrazione per questo servizio. Si rivolga alla Zürcher Kantonalbank per il processo di registrazione corrispondente o per modifiche al metodo di autenticazione.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'it', 174, @helpPagePageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetREFUSAL);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'it', 11, @failurePagePageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'it', 16, @failurePagePageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'it', 17, @failurePagePageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'it', 32, @failurePagePageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'it', 33, @failurePagePageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'it', 41, @failurePagePageType, 'Aiuto', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'it', 174, @failurePagePageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'it', 175, @failurePagePageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetREFUSAL);




/* Elements for the profile SMS : */

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS_EXT'));

/* Here are the images for all pages associated to the SMS Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetSMS
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetSMS
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_EXT_MESSAGE_BODY', @updateState, 'de', 0, 'MESSAGE_BODY',
		'Sie haben einen Freigabe-Code für eine Online-Zahlung angefordert. Bitte verwenden Sie folgenden Code: @otp', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */
# ---------- de TRANSLATE FOR SMS PROFILE ---------

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_1'), @updateState,
 'de', 1, @otpFormPagePageType, '<b>SMS-Freigabe der Zahlung</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_2'), @updateState,
 'de', 2, @otpFormPagePageType, 'Wir haben Ihnen zur Bestätigung der Zahlung einen Freigabe-Code auf Ihr Mobil-Telefon gesendet.  ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_3'), @updateState,
 'de', 3, @otpFormPagePageType, 'Bitte prüfen Sie die Zahlungsdetails links und bestätigen Sie die Zahlung durch Eingabe des Freigabe-Codes.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_11'), @updateState,
 'de', 11, @otpFormPagePageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_12'), @updateState,
 'de', 12, @otpFormPagePageType, 'Zahlungsfreigabe wird geprüft', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_13'), @updateState,
 'de', 13, @otpFormPagePageType, 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_14'), @updateState,
 'de', 14, @otpFormPagePageType, 'Zahlungsfreigabe abgebrochen', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_15'), @updateState,
 'de', 15, @otpFormPagePageType, 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess trotzdem fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_19'), @updateState,
 'de', 19, @otpFormPagePageType, 'Neuen Freigabe-Code anfordern', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_22'), @updateState,
 'de', 22, @otpFormPagePageType, 'Freigabe fehlgeschlagen', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_23'), @updateState,
 'de', 23, @otpFormPagePageType, 'Sie haben 3 Mal einen fehlerhaften Freigabe-Code eingegeben. Ihre Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Ihre Karte wird nun aus Sicherheitsgründen während einer kurzen Zeitdauer für Online-Zahlungen blockiert.  ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_26'), @updateState,
 'de', 26, @otpFormPagePageType, 'Zahlungsfreigabe war erfolgreich', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_27'), @updateState,
 'de', 27, @otpFormPagePageType, 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum Händler weitergeleitet.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_28'), @updateState,
 'de', 28, @otpFormPagePageType, 'Fehlerhafter Freigabe-Code', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_29'), @updateState,
 'de', 29, @otpFormPagePageType, 'Der von Ihnen eingegebene Freigabe-Code ist nicht korrekt. Die Zahlung wurde nicht ausgeführt und Ihre Karte wurde nicht belastet. Sofern Sie den Kauf fortsetzen wollen, versuchen Sie es bitte erneut.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_30'), @updateState,
 'de', 30, @otpFormPagePageType, 'Zahlung nicht ausgeführt - Sitzung abgelaufen', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_31'), @updateState,
 'de', 31, @otpFormPagePageType, 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zurück zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung tätigen wollen.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_32'), @updateState,
 'de', 32, @otpFormPagePageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_33'), @updateState,
 'de', 33, @otpFormPagePageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_34'), @updateState,
 'de', 34, @otpFormPagePageType, 'SMS-Code wird versendet', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_35'), @updateState,
 'de', 35, @otpFormPagePageType, 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie einen neuen Bestätigungscode an Ihre Mobilnummer für Sicherheitsnachrichten. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_40'), @updateState,
 'de', 40, @otpFormPagePageType, 'Zahlung abbrechen', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_41'), @updateState,
 'de', 41, @otpFormPagePageType, 'Hilfe', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_42'), @updateState,
 'de', 42, @otpFormPagePageType, 'Freigeben', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_100'), @updateState,
 'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_101'), @updateState,
 'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_102'), @updateState,
 'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_103'), @updateState,
 'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_104'), @updateState,
 'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_174'), @updateState,
 'de', 174, @otpFormPagePageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_175'), @updateState,
 'de', 175, @otpFormPagePageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'de', 1, @helpPagePageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'de', 2, @helpPagePageType, 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat die Zürcher Kantonalbank eine zweistufige Authentifikation eingeführt.	', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'de', 3, @helpPagePageType, 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder anhand eines Freigabe-Codes per SMS, oder durch die Verifikation Ihrer Person auf einer Mobile Authentifikations-App bestätigen. Für diesen Service müssen Sie sich einmalig registrieren. Für den entsprechenden Registrierungsprozess, oder Änderungen Ihrer Authentifikationsmethode, wenden Sie sich bitte an die Zürcher Kantonalbank.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'de', 174, @helpPagePageType, 'Hilfe-Text schliessen', @MaestroVID, NULL, @customItemSetSMS);


/* Elements for the FAILURE page, for SMS Profile */


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'de', 11, @failurePagePageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'de', 16, @failurePagePageType, 'Freigabe fehlgeschlagen', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'de', 17, @failurePagePageType, 'Sie haben 3 Mal einen fehlerhaften Freigabe-Code eingegeben. Ihre Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Ihre Karte wird nun aus Sicherheitsgründen während einer kurzen Zeitdauer für Online-Zahlungen blockiert. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'de', 32, @failurePagePageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'de', 33, @failurePagePageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'de', 41, @failurePagePageType, 'Hilfe', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'de', 174, @failurePagePageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'de', 175, @failurePagePageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetSMS);



/*ENGLISH translations for OTP_SMS_EXT*/
/* Here are the images for all pages associated to the SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'en', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetSMS
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetSMS
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_EXT_MESSAGE_BODY', @updateState, 'en', 0, 'MESSAGE_BODY',
		'You have requested an approval code for an online purchase. Please use the following code: @otp', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_1'), @updateState,
 'en', 1, @otpFormPagePageType, '<b>SMS approval of the payment</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_2'), @updateState,
 'en', 2, @otpFormPagePageType, 'We have sent an approval code to your mobile phone to approve the payment.	 ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_3'), @updateState,
 'en', 3, @otpFormPagePageType, 'Please check the payment details to the left and confirm the payment by entering the approval code.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_11'), @updateState,
 'en', 11, @otpFormPagePageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_12'), @updateState,
 'en', 12, @otpFormPagePageType, 'Payment approval is being verified', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_13'), @updateState,
 'en', 13, @otpFormPagePageType, 'Please be patient. We are verifying your payment approval and thereby the authentication for the requested payment.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_14'), @updateState,
 'en', 14, @otpFormPagePageType, 'Payment approval cancelled', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_15'), @updateState,
 'en', 15, @otpFormPagePageType, 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the payment process, please start the payment attempt again. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_19'), @updateState,
 'en', 19, @otpFormPagePageType, 'Request new approval code', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_22'), @updateState,
 'en', 22, @otpFormPagePageType, 'Approval failed', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_23'), @updateState,
 'en', 23, @otpFormPagePageType, 'You have entered an incorrect approval code multiple times. Your payment could not be completed and your card was not debited. Your card will now be temporarily blocked for online payments for security reasons. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_26'), @updateState,
 'en', 26, @otpFormPagePageType, 'Successful payment approval', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_27'), @updateState,
 'en', 27, @otpFormPagePageType, 'You have successfully approved the payment and will be automatically routed back to the merchant.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_28'), @updateState,
 'en', 28, @otpFormPagePageType, 'Incorrect approval code', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_29'), @updateState,
 'en', 29, @otpFormPagePageType, 'The approval code you entered is incorrect. The payment was not conducted and your card was not debited. Please try again if you wish to continue the purchase.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_30'), @updateState,
 'en', 30, @otpFormPagePageType, 'Payment not completed – session expired', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_31'), @updateState,
 'en', 31, @otpFormPagePageType, 'Too much time has passed before the payment was approved. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process, if you wish to make the payment.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_32'), @updateState,
 'en', 32, @otpFormPagePageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_33'), @updateState,
 'en', 33, @otpFormPagePageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_34'), @updateState,
 'en', 34, @otpFormPagePageType, 'SMS code sent', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_35'), @updateState,
 'en', 35, @otpFormPagePageType, 'Please wait, this may take a moment. A new confirmation code for security messages will be sent to your mobile phone.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_40'), @updateState,
 'en', 40, @otpFormPagePageType, 'Cancel payment', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_41'), @updateState,
 'en', 41, @otpFormPagePageType, 'Help', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_42'), @updateState,
 'en', 42, @otpFormPagePageType, 'Approve', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_100'), @updateState,
 'en', 100, 'ALL', 'Merchant', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_101'), @updateState,
 'en', 101, 'ALL', 'Amount', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_102'), @updateState,
 'en', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_103'), @updateState,
 'en', 103, 'ALL', 'Card number', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_104'), @updateState,
 'en', 104, 'ALL', 'Phone number', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_174'), @updateState,
 'en', 174, @otpFormPagePageType, 'Close message', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_175'), @updateState,
 'en', 175, @otpFormPagePageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'en', 1, @helpPagePageType, '<b>Help</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'en', 2, @helpPagePageType, 'To boost security while paying online, Zürcher Kantonalbank has introduced two-level authentification. To complete a payment, you must confirm it either by means of an approval code per SMS, or through verification of your identity with a mobile authentication app. You need to register once for this service.	  ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'en', 3, @helpPagePageType, 'Contact Zürcher Kantonalbank for the corresponding registration process or changes to your authentification method.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'en', 174, @helpPagePageType, 'Close Help', @MaestroVID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
								`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'en', 11, @failurePagePageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'en', 16, @failurePagePageType, 'Approval failed', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'en', 17, @failurePagePageType, 'You have entered an incorrect approval code multiple times. Your payment could not be completed and your card was not debited. Your card will now be temporarily blocked for online payments for security reasons. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'en', 32, @failurePagePageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'en', 33, @failurePagePageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'en', 41, @failurePagePageType, 'Help', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'en', 174, @failurePagePageType, 'Close message', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'en', 175, @failurePagePageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetSMS);


/*FRENCH translations for OTP_SMS_EXT*/
/* Here are the images for all pages associated to the SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'fr', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetSMS
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetSMS
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_EXT_MESSAGE_BODY', @updateState, 'fr', 0, 'MESSAGE_BODY',
		'Vous avez demandé un code d’activation pour un paiement en ligne. Veuillez utiliser le code suivant : @otp', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_1'), @updateState,
 'fr', 1, @otpFormPagePageType, '<b>SMS - Activation du paiement</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_2'), @updateState,
 'fr', 2, @otpFormPagePageType, 'Pour la confirmation du paiement, nous vous avons envoyé un code d''activation sur votre téléphone portable.  ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_3'), @updateState,
 'fr', 3, @otpFormPagePageType, 'Veuillez vérifier les détails du paiement à gauche et confirmez le paiement en saisissant le code d''activation.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_11'), @updateState,
 'fr', 11, @otpFormPagePageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_12'), @updateState,
 'fr', 12, @otpFormPagePageType, 'L''activation de paiement va être vérifiée', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_13'), @updateState,
 'fr', 13, @otpFormPagePageType, 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_14'), @updateState,
 'fr', 14, @otpFormPagePageType, 'Activation de paiement interrompue', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_15'), @updateState,
 'fr', 15, @otpFormPagePageType, 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_19'), @updateState,
 'fr', 19, @otpFormPagePageType, 'Demander un nouveau code d''activation', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_22'), @updateState,
 'fr', 22, @otpFormPagePageType, 'L''activation a échoué', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_23'), @updateState,
 'fr', 23, @otpFormPagePageType, '''Vous avez saisi 3 fois un mauvais code d''activation. Votre paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_26'), @updateState,
 'fr', 26, @otpFormPagePageType, 'L’activation du paiement a réussi', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_27'), @updateState,
 'fr', 27, @otpFormPagePageType, 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_28'), @updateState,
 'fr', 28, @otpFormPagePageType, 'Code d''activation erroné', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_29'), @updateState,
 'fr', 29, @otpFormPagePageType, 'Le code de validation que vous avez saisi n’est pas correct. Le paiement n’a pas été exécuté et votre carte n’a pas été débitée. Si vous voulez continuer l''achat, essayez à nouveau.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_30'), @updateState,
 'fr', 30, @otpFormPagePageType, 'Paiement non effectué - La session a expiré', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_31'), @updateState,
 'fr', 31, @otpFormPagePageType, 'Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_32'), @updateState,
 'fr', 32, @otpFormPagePageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_33'), @updateState,
 'fr', 33, @otpFormPagePageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_34'), @updateState,
 'fr', 34, @otpFormPagePageType, 'Vous allez recevoir un code par SMS', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_35'), @updateState,
 'fr', 35, @otpFormPagePageType, 'Veuillez patienter un instant. Vous recevrez d’ici peu un nouveau code de confirmation sur votre numéro de mobile pour les notifications de sécurité.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_40'), @updateState,
 'fr', 40, @otpFormPagePageType, 'Interrompre le paiement', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_41'), @updateState,
 'fr', 41, @otpFormPagePageType, 'Aide', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_42'), @updateState,
 'fr', 42, @otpFormPagePageType, 'Activer', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_100'), @updateState,
 'fr', 100, 'ALL', 'Commerçant', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_101'), @updateState,
 'fr', 101, 'ALL', 'Montant', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_102'), @updateState,
 'fr', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_103'), @updateState,
 'fr', 103, 'ALL', 'Numéro de carte', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_104'), @updateState,
 'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_174'), @updateState,
 'fr', 174, @otpFormPagePageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_175'), @updateState,
 'fr', 175, @otpFormPagePageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetSMS);



/* Elements for the HELP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'fr', 1, @helpPagePageType, '<b>Aide</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'fr', 2, @helpPagePageType, 'Afin d''augmenter votre sécurité lors des paiements en ligne, Zürcher Kantonalbank a mis en place une authentification en deux étapes.  ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'fr', 3, @helpPagePageType, 'Afin de pouvoir effectuer un paiement, vous devez le confirmer soit au moyen d''un code d''activation par SMS, soit par la vérification de votre personne sur une App d''authentification mobile. Pour ce service, vous devez vous enregistrer une fois. Pour la procédure d''enregistrement correspondante, ou pour les modifications de votre méthode d''authentification, veuillez vous adresser à Zürcher Kantonalbank.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'fr', 174, @helpPagePageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'fr', 11, @failurePagePageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'fr', 16, @failurePagePageType, 'L''activation a échoué', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'fr', 17, @failurePagePageType, 'Vous avez saisi 3 fois un mauvais code d''activation. Votre paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'fr', 32, @failurePagePageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'fr', 33, @failurePagePageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'fr', 41, @failurePagePageType, 'Aide', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'fr', 174, @failurePagePageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'fr', 175, @failurePagePageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetSMS);




/*ITALIAN translations for OTP_SMS_EXT*/
/* Here are the images for all pages associated to the SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'it', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetSMS
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'it', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetSMS
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_EXT_MESSAGE_BODY', @updateState, 'it', 0, 'MESSAGE_BODY',
		'Ha richiesto un codice di autenticazione per un pagamento online. Utilizzi il seguente codice: @otp', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_1'), @updateState,
 'it', 1, @otpFormPagePageType, '<b>Autorizzazione del pagamento via SMS</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_2'), @updateState,
 'it', 2, @otpFormPagePageType, 'Le abbiamo inviato un codice di autenticazione sul suo cellulare per confermare il pagamento.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_3'), @updateState,
 'it', 3, @otpFormPagePageType, '  Controlli i dettagli del pagamento a sinistra e confermi il pagamento inserendo il codice di autorizzazione.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_11'), @updateState,
 'it', 11, @otpFormPagePageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_12'), @updateState,
 'it', 12, @otpFormPagePageType, 'L’autorizzazione di pagamento viene controllata', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_13'), @updateState,
 'it', 13, @otpFormPagePageType, 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_14'), @updateState,
 'it', 14, @otpFormPagePageType, 'Autorizzazione di pagamento annullata', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_15'), @updateState,
 'it', 15, @otpFormPagePageType, 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_19'), @updateState,
 'it', 19, @otpFormPagePageType, 'Richiede un nuovo codice di autenticazione', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_22'), @updateState,
 'it', 22, @otpFormPagePageType, 'Autenticazione fallita', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_23'), @updateState,
 'it', 23, @otpFormPagePageType, '''Ha inserito 3 volte il codice di autenticazione errato. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_26'), @updateState,
 'it', 26, @otpFormPagePageType, 'L’autorizzazione di pagamento è andata a buon fine', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_27'), @updateState,
 'it', 27, @otpFormPagePageType, 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_28'), @updateState,
 'it', 28, @otpFormPagePageType, 'Codice di autenticazione errato', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_29'), @updateState,
 'it', 29, @otpFormPagePageType, 'Il codice di autenticazione da lei inserito non è corretto. Il pagamento non è stato eseguito e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, provi nuovamente.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_30'), @updateState,
 'it', 30, @otpFormPagePageType, 'Pagamento non effettuato - Sessione scaduta', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_31'), @updateState,
 'it', 31, @otpFormPagePageType, '''È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_32'), @updateState,
 'it', 32, @otpFormPagePageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_33'), @updateState,
 'it', 33, @otpFormPagePageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_34'), @updateState,
 'it', 34, @otpFormPagePageType, 'Codice SMS inviato.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_35'), @updateState,
 'it', 35, @otpFormPagePageType, 'La preghiamo di attendere. A breve riceverà un nuovo codice di conferma sul suo numero di cellulare per messaggi sulla sicurezza.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_40'), @updateState,
 'it', 40, @otpFormPagePageType, 'Interrompere il pagamento', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_41'), @updateState,
 'it', 41, @otpFormPagePageType, 'Aiuto', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_42'), @updateState,
 'it', 42, @otpFormPagePageType, 'Autorizzare', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_100'), @updateState,
 'it', 100, 'ALL', 'Commerciante', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_101'), @updateState,
 'it', 101, 'ALL', 'Importo', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_102'), @updateState,
 'it', 102, 'ALL', 'Data', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_103'), @updateState,
 'it', 103, 'ALL', 'Numero della carta', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_104'), @updateState,
 'it', 104, 'ALL', 'Numero di telefono', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_174'), @updateState,
 'it', 174, @otpFormPagePageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_175'), @updateState,
 'it', 175, @otpFormPagePageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'it', 1, @helpPagePageType, '<b>Aiuto</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'it', 2, @helpPagePageType, 'Al fine di aumentare la sicurezza per i pagamenti online, Zürcher Kantonalbank ha introdotto una procedura di autenticazione in due fasi.	 ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'it', 3, @helpPagePageType, 'Per poter effettuare un pagamento, deve confermarlo utilizzando un codice di autenticazione tramite SMS o verificando la sua persona su un’app di autenticazione mobile. Deve effettuare una volta la registrazione per questo servizio. Si rivolga alla Zürcher Kantonalbank per il processo di registrazione corrispondente o per modifiche al metodo di autenticazione.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'it', 174, @helpPagePageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'it', 11, @failurePagePageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'it', 16, @failurePagePageType, 'Autenticazione fallita', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'it', 17, @failurePagePageType, '''Ha inserito 3 volte il codice di autenticazione errato. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo. ', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'it', 32, @failurePagePageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'it', 33, @failurePagePageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'it', 41, @failurePagePageType, 'Aiuto', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'it', 174, @failurePagePageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'it', 175, @failurePagePageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetSMS);


/*MOBILE_APP_EXT*/

SET @customItemSetMobileAppExt = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileAppExt
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileAppExt
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

/*MOBILE_APP_EXT_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_1'), @updateState,
 'de', 1, @pollingPagePageType, '<b>Zahlung im App freigeben</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_2'), @updateState,
 'de', 2, @pollingPagePageType, 'Damit die Zahlung abgeschlossen werden kann, müssen Sie diese in der von der Zürcher Kantonalbank zur Verfügung gestellten App freigeben. Sie sollten bereits eine entsprechende Benachrichtigung auf Ihrem Mobil-Telefon erhalten haben. Andernfalls können Sie direkt in die App einsteigen und die Zahlung dort verifizieren. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_3'), @updateState,
 'de', 3, @pollingPagePageType, 'Falls Sie die App zurzeit nicht nutzen können, können Sie die Zahlung per SMS-Code bestätigen:', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_10'), @updateState,
 'de', 10, @pollingPagePageType, 'Per SMS-Code bestätigen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_11'), @updateState,
 'de', 11, @pollingPagePageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_12'), @updateState,
 'de', 12,@pollingPagePageType, 'Zahlungsfreigabe wird geprüft', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_13'), @updateState,
 'de', 13,@pollingPagePageType, 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_14'), @updateState,
 'de', 14,@pollingPagePageType, 'Zahlungsfreigabe abgebrochen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_15'), @updateState,
 'de', 15,@pollingPagePageType, 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess trotzdem fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_26'), @updateState,
 'de', 26,@pollingPagePageType, 'Zahlungsfreigabe war erfolgreich', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_27'), @updateState,
 'de', 27,@pollingPagePageType, 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum Händler weitergeleitet.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_30'), @updateState,
 'de', 30,@pollingPagePageType, 'Zahlung nicht ausgeführt - Sitzung abgelaufen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_31'), @updateState,
 'de', 31,@pollingPagePageType, 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zurück zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung tätigen wollen.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_32'), @updateState,
 'de', 32,@pollingPagePageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_33'), @updateState,
 'de', 33,@pollingPagePageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_40'), @updateState,
 'de', 40, @pollingPagePageType, 'Zahlung abbrechen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_41'), @updateState,
 'de', 41, @pollingPagePageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_100'), @updateState,
 'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_101'), @updateState,
 'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_102'), @updateState,
 'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_103'), @updateState,
 'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_104'), @updateState,
 'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_174'), @updateState,
 'de', 174, @pollingPagePageType, 'Hilfe schließen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_175'), @updateState,
 'de', 175, @pollingPagePageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetMobileAppExt);


/* Elements for the HELP page, for MOBILE APP EXT Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'de', 1, @helpPagePageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'de', 2, @helpPagePageType, 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat die Zürcher Kantonalbank ein zweistufiges Authentifikationsverfahren eingeführt.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'de', 3, @helpPagePageType, ' Sie können Online-Zahlungen auf Ihrem Mobil-Telefon in der von Ihrer Bank zur Verfügung gestellten Authentifikations-App freigeben. Bei Fragen oder Unklarheiten wenden Sie sich bitte an Ihre Bank. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'de', 174, @helpPagePageType, 'Hilfe schliessen', @MaestroVID, NULL, @customItemSetMobileAppExt);


/* Elements for the FAILURE page, for MOBILE APP EXT Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'de', 11, @failurePagePageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'de', 16, @failurePagePageType, 'Freigabe fehlgeschlagen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'de', 17, @failurePagePageType, 'Die Authentifikation auf Ihrem Mobil-Telefon und somit die Zahlungsfreigabe ist fehlgeschlagen. Der Zahlungsprozess wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'de', 32, @failurePagePageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'de', 33, @failurePagePageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'de', 41, @failurePagePageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'de', 174, @failurePagePageType, 'Hilfe schliessen', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'de', 175, @failurePagePageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetMobileAppExt);



/*ENGLISH translations for MOBILE_APP_EXT*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'en', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileAppExt
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileAppExt
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_1'), @updateState,
 'en', 1, @pollingPagePageType, '<b>Approve payment in the app</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_2'), @updateState,
 'en', 2, @pollingPagePageType, 'To complete the payment, you must approve it in the app provided by Zürcher Kantonalbank. You should already have received a corresponding message on your mobile phone. Otherwise, you can open the app directly and approve the payment there.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_3'), @updateState,
 'en', 3, @pollingPagePageType, 'If you cannot use the app at the moment, you can confirm the payment via SMS code:', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_10'), @updateState,
 'en', 10, @pollingPagePageType, 'Confirm via SMS code', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_11'), @updateState,
 'en', 11, @pollingPagePageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_12'), @updateState,
 'en', 12,@pollingPagePageType, 'Payment approval is being verified', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_13'), @updateState,
 'en', 13,@pollingPagePageType, 'Please be patient. We are verifying your payment approval and thereby the authentification for the requested payment.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_14'), @updateState,
 'en', 14,@pollingPagePageType, 'Payment approval cancelled', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_15'), @updateState,
 'en', 15,@pollingPagePageType, 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the payment process, please start the payment attempt again. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_26'), @updateState,
 'en', 26,@pollingPagePageType, 'Successful payment approval', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_27'), @updateState,
 'en', 27,@pollingPagePageType, 'You have successfully approved the payment and will be automatically routed back to the merchant.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_30'), @updateState,
 'en', 30,@pollingPagePageType, 'Payment not completed – session expired', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_31'), @updateState,
 'en', 31,@pollingPagePageType, 'Too much time has passed before the payment was approved. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process, if you wish to make the payment.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_32'), @updateState,
 'en', 32,@pollingPagePageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_33'), @updateState,
 'en', 33,@pollingPagePageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_40'), @updateState,
 'en', 40, @pollingPagePageType, 'Cancel payment', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_41'), @updateState,
 'en', 41, @pollingPagePageType, 'Help', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_100'), @updateState,
 'en', 100, 'ALL', 'Merchant', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_101'), @updateState,
 'en', 101, 'ALL', 'Amount', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_102'), @updateState,
 'en', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_103'), @updateState,
 'en', 103, 'ALL', 'Card number', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_104'), @updateState,
 'en', 104, 'ALL', 'Phone number', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_174'), @updateState,
 'en', 174, @pollingPagePageType, 'Close Help', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_175'), @updateState,
 'en', 175, @pollingPagePageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetMobileAppExt);



/* Elements for the HELP page, for MOBILE APP EXT Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'en', 1, @helpPagePageType, '<b>Help</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'en', 2, @helpPagePageType, 'To boost security while paying online, Zürcher Kantonalbank has introduced two-level authentification.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'en', 3, @helpPagePageType, ' You can approve online payments on your mobile phone in the app provided by your bank. If you have questions, please contact your bank directly.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'en', 174, @helpPagePageType, 'Close Help', @MaestroVID, NULL, @customItemSetMobileAppExt);


/* Elements for the FAILURE page, for MOBILE APP EXT Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'en', 11, @failurePagePageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'en', 16, @failurePagePageType, 'Approval failed', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'en', 17, @failurePagePageType, 'The authentication on your mobile phone and thus the payment approval failed. The payment process was cancelled and your card was not debited. If you wish to continue the payment process, please start the payment attempt again. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'en', 32, @failurePagePageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'en', 33, @failurePagePageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'en', 41, @failurePagePageType, 'Help', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'en', 174, @failurePagePageType, 'Close Help', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'en', 175, @failurePagePageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetMobileAppExt);


/*FRENCH translations for MOBILE_APP_EXT*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'fr', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileAppExt
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileAppExt
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


/*MOBILE_APP_EXT_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_1'), @updateState,
 'fr', 1, @pollingPagePageType, '<b>Activer le paiement dans l''App</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_2'), @updateState,
 'fr', 2, @pollingPagePageType, 'Pour que le paiement puisse être terminé, vous devez l''activer dans l''App mise à disposition par Zürcher Kantonalbank. Vous devriez déjà avoir reçu un message correspondant sur votre téléphone portable. Dans le cas contraire, vous pouvez aller directement dans votre App et y vérifier le paiement.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_3'), @updateState,
 'fr', 3, @pollingPagePageType, 'Si vous n''êtes actuellement pas en masure d''utiliser l''app, vous pouvez confirmer le paiement par code SMS:', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_10'), @updateState,
 'fr', 10, @pollingPagePageType, 'Confirmer par code SMS', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_11'), @updateState,
 'fr', 11, @pollingPagePageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_12'), @updateState,
 'fr', 12,@pollingPagePageType, 'L''activation de paiement va être vérifiée', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_13'), @updateState,
 'fr', 13,@pollingPagePageType, 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_14'), @updateState,
 'fr', 14,@pollingPagePageType, 'Activation de paiement interrompue', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_15'), @updateState,
 'fr', 15,@pollingPagePageType, '''Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_26'), @updateState,
 'fr', 26,@pollingPagePageType, 'L’activation du paiement a réussi', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_27'), @updateState,
 'fr', 27,@pollingPagePageType, 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_30'), @updateState,
 'fr', 30,@pollingPagePageType, 'Paiement non effectué - La session a expiré', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_31'), @updateState,
 'fr', 31,@pollingPagePageType, '''Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_32'), @updateState,
 'fr', 32,@pollingPagePageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_33'), @updateState,
 'fr', 33,@pollingPagePageType, '''En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_40'), @updateState,
 'fr', 40, @pollingPagePageType, 'Interrompre le paiement', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_41'), @updateState,
 'fr', 41, @pollingPagePageType, 'Aide', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_100'), @updateState,
 'fr', 100, 'ALL', 'Commerçant', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_101'), @updateState,
 'fr', 101, 'ALL', 'Montant', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_102'), @updateState,
 'fr', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_103'), @updateState,
 'fr', 103, 'ALL', 'Numéro de carte', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_104'), @updateState,
 'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_174'), @updateState,
 'fr', 174, @pollingPagePageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_175'), @updateState,
 'fr', 175, @pollingPagePageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetMobileAppExt);



/* Elements for the HELP page, for MOBILE APP EXT Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'fr', 1, @helpPagePageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'fr', 2, @helpPagePageType, 'Afin d''augmenter votre sécurité lors des paiements en ligne, Zürcher Kantonalbank a mis en place une procédure d''authentification en deux étapes. ', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'fr', 3, @helpPagePageType, 'Vous pouvez activer les paiements en ligne sur votre téléphone portable dans l''App d''authentificaiton mise à disposition par votre banque. En cas de questions ou d''imprécisions, veuillez vous adresser à votre banque.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'fr', 174, @helpPagePageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetMobileAppExt);


/* Elements for the FAILURE page, for MOBILE APP EXT Profile */


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'fr', 11, @failurePagePageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'fr', 16, @failurePagePageType, 'L''activation a échoué', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'fr', 17, @failurePagePageType, 'L''authentification sur votre téléphone portable et donc l''activation de paiement, ont échoué. Le processus de paiement a été interrompu et votre carte n''a pas été débitée. Si vous souhaitez continuer le processus d''achat, veuillez recommencer la tentative de paiement.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'fr', 32, @failurePagePageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'fr', 33, @failurePagePageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'fr', 41, @failurePagePageType, 'Aide', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'fr', 174, @failurePagePageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'fr', 175, @failurePagePageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetMobileAppExt);





/*ITALIAN translations for MOBILE_APP_EXT*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'it', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileAppExt
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'it', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileAppExt
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

/*MOBILE_APP_EXT_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES


('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_1'), @updateState,
 'it', 1, @pollingPagePageType, '<b>Autorizzare il pagamento nell’app</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_2'), @updateState,
 'it', 2, @pollingPagePageType, 'Per poter completare il pagamento, è necessario autorizzarlo nell’app fornita sua Zürcher Kantonalbank.  Dovrebbe aver già ricevuto una notifica sul suo cellulare.  In caso contrario può accedere direttamente all''app e verificare il pagamento lì.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_3'), @updateState,
 'it', 3, @pollingPagePageType, 'Se al momento non sei in grado di utilizzare l''app, potete confermare il pagamento via codice SMS:', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_10'), @updateState,
 'it', 10, @pollingPagePageType, 'Confermare via codice SMS', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_11'), @updateState,
 'it', 11, @pollingPagePageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_12'), @updateState,
 'it', 12,@pollingPagePageType, 'L’autorizzazione di pagamento viene controllata', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_13'), @updateState,
 'it', 13,@pollingPagePageType, 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_14'), @updateState,
 'it', 14,@pollingPagePageType, 'Autorizzazione di pagamento annullata', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_15'), @updateState,
 'it', 15,@pollingPagePageType, '''Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_26'), @updateState,
 'it', 26,@pollingPagePageType, 'L’autorizzazione di pagamento è andata a buon fine', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_27'), @updateState,
 'it', 27,@pollingPagePageType, 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_30'), @updateState,
 'it', 30,@pollingPagePageType, 'Pagamento non effettuato - Sessione scaduta', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_31'), @updateState,
 'it', 31,@pollingPagePageType, '''È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_32'), @updateState,
 'it', 32,@pollingPagePageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_33'), @updateState,
 'it', 33,@pollingPagePageType, '''Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_40'), @updateState,
 'it', 40, @pollingPagePageType, 'Interrompere il pagamento', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_41'), @updateState,
 'it', 41, @pollingPagePageType, 'Aiuto', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_100'), @updateState,
 'it', 100, 'ALL', 'Commerciante', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_101'), @updateState,
 'it', 101, 'ALL', 'Importo', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_102'), @updateState,
 'it', 102, 'ALL', 'Data', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_103'), @updateState,
 'it', 103, 'ALL', 'Numero della carta', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_104'), @updateState,
 'it', 104, 'ALL', 'Numero di telefono', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_174'), @updateState,
 'it', 174, @pollingPagePageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@pollingPagePageType,'_175'), @updateState,
 'it', 175, @pollingPagePageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetMobileAppExt);


/* Elements for the HELP page, for MOBILE APP EXT Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'it', 1, @helpPagePageType, '<b>Aiuto</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'it', 2, @helpPagePageType, 'Al fine di aumentare la sicurezza per i pagamenti online, Zürcher Kantonalbank ha introdotto una procedura di autenticazione in due fasi.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'it', 3, @helpPagePageType, ' Può autorizzare i pagamenti online sul suo cellulare nell’app di autenticazione fornita dalla sua banca. In caso di domande o chiarimenti, la preghiamo di contattare la sua banca.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'it', 174, @helpPagePageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetMobileAppExt);



/* Elements for the FAILURE page, for MOBILE APP EXT Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'it', 11, @failurePagePageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'it', 16, @failurePagePageType, 'Autenticazione fallita', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'it', 17, @failurePagePageType, 'L’autenticazione sul suo cellulare e quindi l’autorizzazione del pagamento non sono riuscite. Il processo di pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'it', 32, @failurePagePageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'it', 33, @failurePagePageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'it', 41, @failurePagePageType, 'Aiuto', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'it', 174, @failurePagePageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetMobileAppExt),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppExtAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'it', 175, @failurePagePageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetMobileAppExt);



# ---------- REFUSAL_FRAUD -------------------


SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'));


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusalFraud FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetREFUSAL;


UPDATE `CustomItem` SET `value` = 'Zahlung nicht ausgeführt' WHERE `fk_id_customItemSet` = @customItemSetRefusalFraud AND
                                                                   `locale` = 'de' AND
                                                                   `pageTypes` = @refusalPageType AND
                                                                   `ordinal` = 22;

UPDATE `CustomItem` SET `value` = 'Ihre Karte ist aus Sicherheitsgründen während einer kurzen Zeitdauer für Online-Zahlungen blockiert. ' WHERE `fk_id_customItemSet` = @customItemSetRefusalFraud AND
                                                                   `locale` = 'de' AND
                                                                   `pageTypes` = @refusalPageType AND
                                                                   `ordinal` = 23;


UPDATE `CustomItem` SET `value` = 'Payment not completed' WHERE `fk_id_customItemSet` = @customItemSetRefusalFraud AND
                                                                   `locale` = 'en' AND
                                                                   `pageTypes` = @refusalPageType AND
                                                                   `ordinal` = 22;

UPDATE `CustomItem` SET `value` = 'Your card is temporarily blocked for online payments for security reasons.' WHERE `fk_id_customItemSet` = @customItemSetRefusalFraud AND
                                                                   `locale` = 'en' AND
                                                                   `pageTypes` = @refusalPageType AND
                                                                   `ordinal` = 23;


UPDATE `CustomItem` SET `value` = 'Le paiement n''a pas été effectué' WHERE `fk_id_customItemSet` = @customItemSetRefusalFraud AND
                                                                   `locale` = 'fr' AND
                                                                   `pageTypes` = @refusalPageType AND
                                                                   `ordinal` = 22;

UPDATE `CustomItem` SET `value` = 'Pour des raisons de sécurité, votre carte est bloquée, pour une courte durée, pour les paiements en ligne.' WHERE `fk_id_customItemSet` = @customItemSetRefusalFraud AND
                                                                   `locale` = 'fr' AND
                                                                   `pageTypes` = @refusalPageType AND
                                                                   `ordinal` = 23;


UPDATE `CustomItem` SET `value` = 'Pagamento non eseguito' WHERE `fk_id_customItemSet` = @customItemSetRefusalFraud AND
                                                                   `locale` = 'it' AND
                                                                   `pageTypes` = @refusalPageType AND
                                                                   `ordinal` = 22;

UPDATE `CustomItem` SET `value` = 'Per motivi di sicurezza la sua carta è bloccata per i pagamenti online per un breve periodo di tempo.' WHERE `fk_id_customItemSet` = @customItemSetRefusalFraud AND
                                                                   `locale` = 'it' AND
                                                                   `pageTypes` = @refusalPageType AND
                                                                   `ordinal` = 23;


# ---------- MISSING_AUTHENTICATION_REFUSAL -------------------


SET @customItemSetMISSING = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMISSING
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMISSING
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

/* ----------- DE Elements for the profile MISSING : ------------*/


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'de', 1, @refusalPageType, '<b>Zahlungsfreigabe nicht möglich</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'de', 2, @refusalPageType, 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (SMS oder App) für Ihre Karte gefunden haben. ', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'de', 3, @refusalPageType, 'Bitte hinterlegen Sie für Ihre Karte eine entsprechende Freigabe-Methode im Registrierungsportal gemäss der Anleitung Ihrer Bank. ', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'de', 11, @refusalPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'de', 22, @refusalPageType, 'Zahlung nicht ausgeführt', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'de', 23, @refusalPageType, 'Ihre Karte ist aus Sicherheitsgründen während einer kurzen Zeitdauer für Online-Zahlungen blockiert.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'de', 32, @refusalPageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'de', 33, @refusalPageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'de', 41, @refusalPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'de', 174,@refusalPageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetMISSING ),


('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'de', 175,@refusalPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetMISSING );


# ------------- HELP PAGE ----------

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'de', 1, @helpPagePageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'de', 2, @helpPagePageType, 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat die Zürcher Kantonalbank eine zweistufige Authentifikation eingeführt.	', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'de', 3, @helpPagePageType, 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder anhand eines Freigabe-Codes per SMS, oder durch die Verifikation Ihrer Person auf einer Mobile Authentifikations-App bestätigen. Für diesen Service müssen Sie sich einmalig registrieren. Für den entsprechenden Registrierungsprozess, oder Änderungen Ihrer Authentifikationsmethode, wenden Sie sich bitte an die Zürcher Kantonalbank.', @MaestroVID, NULL, @customItemSetMISSING),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'de', 174, @helpPagePageType, 'Hilfe-Text schliessen', @MaestroVID, NULL, @customItemSetMISSING );


# --------- FAILURE_PAGE -----------

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'de', 11, @failurePagePageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'de', 16, @failurePagePageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'de', 17, @failurePagePageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'de', 32, @failurePagePageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'de', 33, @failurePagePageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet.Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'de', 41, @failurePagePageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'de', 174, @failurePagePageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'de', 175, @failurePagePageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetMISSING );


/*ENGLISH translations for MISSING*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'en', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMISSING
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMISSING
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'en', 1, @refusalPageType, '<b>Payment approval not possible.</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'en', 2, @refusalPageType, 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. ', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'en', 3, @refusalPageType, 'Please set up a corresponding approval method for your card on the registration portal according to your bank''s instructions. ', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'en', 11, @refusalPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'en', 22, @refusalPageType, 'Payment not completed', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'en', 23, @refusalPageType, 'Your card is temporarily blocked for online payments for security reasons. ', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'en', 32, @refusalPageType, 'Payment not completed – card is not registered for 3-D Secure.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'en', 33, @refusalPageType, 'The payment could not be completed because your card is not registered for 3-D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'en', 41, @refusalPageType, 'Help', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'en', 100, 'ALL', 'Merchant', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'en', 101, 'ALL', 'Amount', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'en', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'en', 103, 'ALL', 'Card number', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'en', 104, 'ALL', 'Phone number', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'en', 174,@refusalPageType, 'Close message', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'en', 175,@refusalPageType, 'Back to online shop', @MaestroVID, NULL, @customItemSetMISSING );


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'en', 1, @helpPagePageType, '<b>Help</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'en', 2, @helpPagePageType, 'To boost security while paying online, Zürcher Kantonalbank has introduced two-level authentification. ', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'en', 3, @helpPagePageType, 'To complete a payment, you must confirm it either by means of an approval code per SMS, or through verification of your identity with a mobile authentication app. You need to register once for this service. Contact Zürcher Kantonalbank for the corresponding registration process or changes to your authentification method.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'en', 174, @helpPagePageType, 'Close help text', @MaestroVID, NULL, @customItemSetMISSING );



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'en', 11, @failurePagePageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'en', 16, @failurePagePageType, 'Payment not completed – card is not registered for 3-D Secure.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'en', 17, @failurePagePageType, 'The payment could not be completed because your card is not registered for 3-D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'en', 32, @failurePagePageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'en', 33, @failurePagePageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'en', 41, @failurePagePageType, 'Help', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'en', 174, @failurePagePageType, 'Close message', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'en', 175, @failurePagePageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetMISSING );



/*FRENCH translations for MISSING*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'fr', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMISSING
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMISSING
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'fr', 1, @refusalPageType, '<b>Activation de paiement impossible</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'fr', 2, @refusalPageType, '''Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'fr', 3, @refusalPageType, 'Veuillez consigner une méthode d''activation pour votre carte dans le portail d’inscription, conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'fr', 11, @refusalPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'fr', 22, @refusalPageType, 'Le paiement n''a pas été effectuéLe paiement n''a pas été effectué', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'fr', 23, @refusalPageType, 'Pour des raisons de sécurité, votre carte est bloquée, pour une courte durée,	 pour les paiements en ligne.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'fr', 32, @refusalPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'fr', 33, @refusalPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'fr', 41, @refusalPageType, 'Aide', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'fr', 100, 'ALL', 'Commerçant', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'fr', 101, 'ALL', 'Montant', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'fr', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'fr', 103, 'ALL', 'Numéro de carte', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'fr', 174,@refusalPageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'fr', 175,@refusalPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetMISSING );


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'fr', 1, @helpPagePageType, '<b>Aide</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'fr', 2, @helpPagePageType, 'Afin d''augmenter votre sécurité lors des paiements en ligne, Zürcher Kantonalbank a mis en place une authentification en deux étapes. ', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'fr', 3, @helpPagePageType, 'Afin de pouvoir effectuer un paiement, vous devez le confirmer soit au moyen d''un code d''activation par SMS, soit par la vérification de votre personne sur une App d''authentification mobile. Pour ce service, vous devez vous enregistrer une fois. Pour la procédure d''enregistrement correspondante, ou pour les modifications de votre méthode d''authentification, veuillez vous adresser à Zürcher Kantonalbank.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'fr', 174, @helpPagePageType, 'Fermer le texte d''aide', @MaestroVID, NULL, @customItemSetMISSING );


# SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'fr', 11, @failurePagePageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'fr', 16, @failurePagePageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'fr', 17, @failurePagePageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'fr', 32, @failurePagePageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'fr', 33, @failurePagePageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'fr', 41, @failurePagePageType, 'Aide', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'fr', 174, @failurePagePageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'fr', 175, @failurePagePageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetMISSING );




/*Italian translations for MISSING*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'it', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMISSING
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'it', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMISSING
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'it', 1, @refusalPageType, '<b>Autorizzazione di pagamento non possibile</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'it', 2, @refusalPageType, 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'it', 3, @refusalPageType, ' Stabilisca un metodo di autenticazione corrispondente per la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'it', 11, @refusalPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'it', 22, @refusalPageType, 'Pagamento non eseguito', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'it', 23, @refusalPageType, 'Per motivi di sicurezza la sua carta è bloccata per i pagamenti online per un breve periodo di tempo.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'it', 32, @refusalPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'it', 33, @refusalPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'it', 41, @refusalPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'it', 100, 'ALL', 'Commerciante', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'it', 101, 'ALL', 'Importo', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'it', 102, 'ALL', 'Data', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'it', 103, 'ALL', 'Numero della carta', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'it', 104, 'ALL', 'Numero di telefono', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'it', 174,@refusalPageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'it', 175,@refusalPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetMISSING );



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'it', 1, @helpPagePageType, '<b>Aiuto</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'it', 2, @helpPagePageType, 'Al fine di aumentare la sicurezza per i pagamenti online, Zürcher Kantonalbank ha introdotto una procedura di autenticazione in due fasi. ', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'it', 3, @helpPagePageType, ' Per poter effettuare un pagamento, deve confermarlo utilizzando un codice di autenticazione tramite SMS o verificando la sua persona su un’app di autenticazione mobile. Deve effettuare una volta la registrazione per questo servizio. Si rivolga alla Zürcher Kantonalbank per il processo di registrazione corrispondente o per modifiche al metodo di autenticazione.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'it', 174, @helpPagePageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetMISSING );


# SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'it', 11, @failurePagePageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'it', 16, @failurePagePageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'it', 17, @failurePagePageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'it', 32, @failurePagePageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'it', 33, @failurePagePageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'it', 41, @failurePagePageType, 'Aiuto', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'it', 174, @failurePagePageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetMISSING ),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'it', 175, @failurePagePageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetMISSING );


# ---------- BACKUP_REFUSAL -------------------

SET @customItemSetBackupRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_BACKUP_REFUSAL'));


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetBackupRefusal
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetBackupRefusal
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

/* ----------- DE Elements for the profile BACKUP_REFUSAL : ------------*/


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'de', 1, @refusalPageType, '<b>Zahlungsfreigabe nicht möglich</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'de', 2, @refusalPageType, 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (SMS oder App) für Ihre Karte gefunden haben. ', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'de', 3, @refusalPageType, 'Bitte hinterlegen Sie für Ihre Karte eine entsprechende Freigabe-Methode im Registrierungsportal gemäss der Anleitung Ihrer Bank. ', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'de', 11, @refusalPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'de', 22, @refusalPageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'de', 23, @refusalPageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'de', 32, @refusalPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'de', 33, @refusalPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'de', 41, @refusalPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'de', 174,@refusalPageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetBackupRefusal),


('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'de', 175,@refusalPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetBackupRefusal);

# ------------- HELP PAGE ----------

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'de', 1, @helpPagePageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'de', 2, @helpPagePageType, 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat die Zürcher Kantonalbank eine zweistufige Authentifikation eingeführt.	', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'de', 3, @helpPagePageType, 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder anhand eines Freigabe-Codes per SMS, oder durch die Verifikation Ihrer Person auf einer Mobile Authentifikations-App bestätigen. Für diesen Service müssen Sie sich einmalig registrieren. Für den entsprechenden Registrierungsprozess, oder Änderungen Ihrer Authentifikationsmethode, wenden Sie sich bitte an die Zürcher Kantonalbank.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'de', 174, @helpPagePageType, 'Hilfe-Text schliessen', @MaestroVID, NULL, @customItemSetBackupRefusal);


# --------- FAILURE_PAGE -----------

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'de', 11, @failurePagePageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'de', 16, @failurePagePageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'de', 17, @failurePagePageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'de', 32, @failurePagePageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'de', 33, @failurePagePageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet.Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'de', 41, @failurePagePageType, 'Hilfe', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'de', 174, @failurePagePageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'de', 175, @failurePagePageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetBackupRefusal);


/*ENGLISH translations for BACKUP_REFUSAL*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'en', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetBackupRefusal
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetBackupRefusal
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'en', 1, @refusalPageType, '<b>Payment approval not possible.</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'en', 2, @refusalPageType, 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. ', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'en', 3, @refusalPageType, 'Please set up a corresponding approval method for your card on the registration portal according to your bank''s instructions. ', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'en', 11, @refusalPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'en', 22, @refusalPageType, 'Payment not completed – card is not registered for 3D Secure.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'en', 23, @refusalPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'en', 32, @refusalPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'en', 33, @refusalPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'en', 41, @refusalPageType, 'Help', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'en', 100, 'ALL', 'Merchant', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'en', 101, 'ALL', 'Amount', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'en', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'en', 103, 'ALL', 'Card number', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'en', 104, 'ALL', 'Phone number', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'en', 174,@refusalPageType, 'Close message', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'en', 175,@refusalPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetBackupRefusal);



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'en', 1, @helpPagePageType, '<b>Help</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'en', 2, @helpPagePageType, 'To boost security while paying online, Zürcher Kantonalbank has introduced two-level authentification. ', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'en', 3, @helpPagePageType, 'To complete a payment, you must confirm it either by means of an approval code per SMS, or through verification of your identity with a mobile authentication app. You need to register once for this service. Contact Zürcher Kantonalbank for the corresponding registration process or changes to your authentification method.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'en', 174, @helpPagePageType, 'Close help text', @MaestroVID, NULL, @customItemSetBackupRefusal);



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'en', 11, @failurePagePageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'en', 16, @failurePagePageType, 'Payment not completed – card is not registered for 3-D Secure.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'en', 17, @failurePagePageType, 'The payment could not be completed because your card is not registered for 3-D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'en', 32, @failurePagePageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'en', 33, @failurePagePageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'en', 41, @failurePagePageType, 'Help', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'en', 174, @failurePagePageType, 'Close message', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'en', 175, @failurePagePageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetBackupRefusal);



/*FRENCH translations for BACKUP_REFUSAL*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'fr', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetBackupRefusal
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetBackupRefusal
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'fr', 1, @refusalPageType, '<b>Activation de paiement impossible</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'fr', 2, @refusalPageType, '''Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'fr', 3, @refusalPageType, 'Veuillez consigner une méthode d''activation pour votre carte dans le portail d’inscription, conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'fr', 11, @refusalPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'fr', 22, @refusalPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'fr', 23, @refusalPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'fr', 32, @refusalPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'fr', 33, @refusalPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'fr', 41, @refusalPageType, 'Aide', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'fr', 100, 'ALL', 'Commerçant', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'fr', 101, 'ALL', 'Montant', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'fr', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'fr', 103, 'ALL', 'Numéro de carte', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'fr', 174,@refusalPageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'fr', 175,@refusalPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetBackupRefusal);



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'fr', 1, @helpPagePageType, '<b>Aide</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'fr', 2, @helpPagePageType, 'Afin d''augmenter votre sécurité lors des paiements en ligne, Zürcher Kantonalbank a mis en place une authentification en deux étapes. ', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'fr', 3, @helpPagePageType, 'Afin de pouvoir effectuer un paiement, vous devez le confirmer soit au moyen d''un code d''activation par SMS, soit par la vérification de votre personne sur une App d''authentification mobile. Pour ce service, vous devez vous enregistrer une fois. Pour la procédure d''enregistrement correspondante, ou pour les modifications de votre méthode d''authentification, veuillez vous adresser à Zürcher Kantonalbank.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'fr', 174, @helpPagePageType, 'Fermer le texte d''aide', @MaestroVID, NULL, @customItemSetBackupRefusal);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'fr', 11, @failurePagePageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'fr', 16, @failurePagePageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'fr', 17, @failurePagePageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'fr', 32, @failurePagePageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'fr', 33, @failurePagePageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'fr', 41, @failurePagePageType, 'Aide', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'fr', 174, @failurePagePageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'fr', 175, @failurePagePageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetBackupRefusal);




/*Italian translations for BACKUP_REFUSAL*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'it', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetBackupRefusal
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'it', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetBackupRefusal
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'it', 1, @refusalPageType, '<b>Autorizzazione di pagamento non possibile</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'it', 2, @refusalPageType, 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'it', 3, @refusalPageType, ' Stabilisca un metodo di autenticazione corrispondente per la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'it', 11, @refusalPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'it', 22, @refusalPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'it', 23, @refusalPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'it', 32, @refusalPageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'it', 33, @refusalPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'it', 41, @refusalPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'it', 100, 'ALL', 'Commerciante', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'it', 101, 'ALL', 'Importo', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'it', 102, 'ALL', 'Data', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'it', 103, 'ALL', 'Numero della carta', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'it', 104, 'ALL', 'Numero di telefono', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'it', 174,@refusalPageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'it', 175,@refusalPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetBackupRefusal);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'it', 1, @helpPagePageType, '<b>Aiuto</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'it', 2, @helpPagePageType, 'Al fine di aumentare la sicurezza per i pagamenti online, Zürcher Kantonalbank ha introdotto una procedura di autenticazione in due fasi. ', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'it', 3, @helpPagePageType, ' Per poter effettuare un pagamento, deve confermarlo utilizzando un codice di autenticazione tramite SMS o verificando la sua persona su un’app di autenticazione mobile. Deve effettuare una volta la registrazione per questo servizio. Si rivolga alla Zürcher Kantonalbank per il processo di registrazione corrispondente o per modifiche al metodo di autenticazione.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'it', 174, @helpPagePageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetBackupRefusal);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'it', 11, @failurePagePageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'it', 16, @failurePagePageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'it', 17, @failurePagePageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'it', 32, @failurePagePageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'it', 33, @failurePagePageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'it', 41, @failurePagePageType, 'Aiuto', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'it', 174, @failurePagePageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetBackupRefusal),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'it', 175, @failurePagePageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetBackupRefusal);



# ---------EWLACS3SWK-472 UPDATE -------

SET @ZKBBankUB = 'ZKB';


SET @customItemSetREFUSALZKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @ZKBBankUB, '_DEFAULT_REFUSAL'));
SET @refusalPageType = 'REFUSAL_PAGE';

SET @ordinal = 32;

SET @textValue = 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Payment not completed – card is not registered for 3D Secure.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Pagamento non eseguito - La carta non è registrata per 3D Secure';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;




SET @ordinal = 33;

SET @textValue = 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;


SET @ordinal = 22;

SET @textValue = 'Zahlung nicht ausgeführt - Technischer Fehler';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Payment not completed – technical error';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Paiement non effectué - Problème technique';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Pagamento non eseguito - Errore tecnico';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;



SET @ordinal = 23;

SET @textValue = 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;




