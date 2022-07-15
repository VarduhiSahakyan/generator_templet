USE U7G_ACS_BO;

USE U7G_ACS_BO;
SET @createdBy ='A758581';
SET @subIssuerCode = '70000';
SET @subIssuerNameAndLabel = 'Zürcher Kantonalbank ';
SET @BankUB = 'ZKB';
SET @updateState =	'PUSHED_TO_CONFIG';
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
SET @status = 'DEPLOYED_IN_PRODUCTION';
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD_Current'), NULL, NULL,
 CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_BACKUP_REFUSAL_Current'), NULL, NULL,
 CONCAT('customitemset_', @BankUB, '_BACKUP_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID);


SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'));
SET @customItemSetBackupRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_BACKUP_REFUSAL'));
SET @customItemSetDefaultRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_DEFAULT_REFUSAL'));
SET @profileBackupRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_BACKUP_REFUSAL'));
SET @profileRefusalFraud = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REFUSAL_FRAUD'));
SET @authMeanREFUSAL = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @description = 'INFO';
SET @refusalPageType = 'REFUSAL_PAGE';

UPDATE `Profile` SET `fk_id_AuthentMeans` = @authMeanREFUSAL,
                     `description` = @description, `fk_id_customItemSetCurrent` = @customItemSetBackupRefusal WHERE `id` = @profileBackupRefusal;

UPDATE `Profile` SET  `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud WHERE `id` = @profileRefusalFraud;

DELETE FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetDefaultRefusal and pageTypes = @refusalPageType and ordinal in (220, 230);

SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @refusalAuthentMean = 'REFUSAL';
SET @MaestroVID = NULL;
SET @helpPagePageType = 'HELP_PAGE';
SET @failurePagePageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
		'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetRefusalFraud
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
		'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetRefusalFraud
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'de', 1, @refusalPageType, '<b>Zahlungsfreigabe nicht möglich</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'de', 2, @refusalPageType, 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (SMS oder App) für Ihre Karte gefunden haben. ', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'de', 3, @refusalPageType, 'Bitte hinterlegen Sie für Ihre Karte eine entsprechende Freigabe-Methode im Registrierungsportal gemäss der Anleitung Ihrer Bank. ', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'de', 11, @refusalPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_220'), @updateState,
 'de', 220, @refusalPageType, 'Zahlung nicht ausgeführt', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_230'), @updateState,
 'de', 230, @refusalPageType, 'Ihre Karte ist aus Sicherheitsgründen während einer kurzen Zeitdauer für Online-Zahlungen blockiert. ', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'de', 32, @refusalPageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'de', 33, @refusalPageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'de', 41, @refusalPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'de', 101, 'ALL', 'Betrag', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'de', 102, 'ALL', 'Datum', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'de', 103, 'ALL', 'Kartennummer', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'de', 104, 'ALL', 'Telefonnummer', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'de', 174,@refusalPageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetRefusalFraud),


('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'de', 175,@refusalPageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetRefusalFraud);

# ------------- HELP PAGE ----------

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'de', 1, @helpPagePageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'de', 2, @helpPagePageType, 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat die Zürcher Kantonalbank eine zweistufige Authentifikation eingeführt.	', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'de', 3, @helpPagePageType, 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder anhand eines Freigabe-Codes per SMS, oder durch die Verifikation Ihrer Person auf einer Mobile Authentifikations-App bestätigen. Für diesen Service müssen Sie sich einmalig registrieren. Für den entsprechenden Registrierungsprozess, oder Änderungen Ihrer Authentifikationsmethode, wenden Sie sich bitte an die Zürcher Kantonalbank.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'de', 174, @helpPagePageType, 'Hilfe-Text schliessen', @MaestroVID, NULL, @customItemSetRefusalFraud);


# --------- FAILURE_PAGE -----------

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'de', 11, @failurePagePageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'de', 16, @failurePagePageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'de', 17, @failurePagePageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'de', 32, @failurePagePageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'de', 33, @failurePagePageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet.Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'de', 41, @failurePagePageType, 'Hilfe', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'de', 174, @failurePagePageType, 'Meldung schliessen', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'de', 175, @failurePagePageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetRefusalFraud);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'en', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetRefusalFraud
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetRefusalFraud
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'en', 1, @refusalPageType, '<b>Payment approval not possible.</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'en', 2, @refusalPageType, 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. ', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'en', 3, @refusalPageType, 'Please set up a corresponding approval method for your card on the registration portal according to your bank''s instructions. ', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'en', 11, @refusalPageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_ALL','_220'), @updateState,
 'en', 220, @refusalPageType, 'Payment not completed', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_ALL','_230'), @updateState,
 'en', 230, @refusalPageType, 'Your card is temporarily blocked for online payments for security reasons.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'en', 32, @refusalPageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'en', 33, @refusalPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'en', 41, @refusalPageType, 'Help', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'en', 100, 'ALL', 'Merchant', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'en', 101, 'ALL', 'Amount', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'en', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'en', 103, 'ALL', 'Card number', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'en', 104, 'ALL', 'Phone number', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'en', 174,@refusalPageType, 'Close message', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'en', 175,@refusalPageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetRefusalFraud);



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'en', 1, @helpPagePageType, '<b>Help</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'en', 2, @helpPagePageType, 'To boost security while paying online, Zürcher Kantonalbank has introduced two-level authentification. ', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'en', 3, @helpPagePageType, 'To complete a payment, you must confirm it either by means of an approval code per SMS, or through verification of your identity with a mobile authentication app. You need to register once for this service. Contact Zürcher Kantonalbank for the corresponding registration process or changes to your authentification method.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'en', 174, @helpPagePageType, 'Close help text', @MaestroVID, NULL, @customItemSetRefusalFraud);



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'en', 11, @failurePagePageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'en', 16, @failurePagePageType, 'Payment not completed – card is not registered for 3-D Secure.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'en', 17, @failurePagePageType, 'The payment could not be completed because your card is not registered for 3-D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'en', 32, @failurePagePageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'en', 33, @failurePagePageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'en', 41, @failurePagePageType, 'Help', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'en', 174, @failurePagePageType, 'Close message', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'en', 175, @failurePagePageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetRefusalFraud);



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'fr', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetRefusalFraud
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetRefusalFraud
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'fr', 1, @refusalPageType, '<b>Activation de paiement impossible</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'fr', 2, @refusalPageType, '''Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'fr', 3, @refusalPageType, 'Veuillez consigner une méthode d''activation pour votre carte dans le portail d’inscription, conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'fr', 11, @refusalPageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_ALL','_220'), @updateState,
 'fr', 220, @refusalPageType, 'Le paiement n''a pas été effectué', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_ALL','_230'), @updateState,
 'fr', 230, @refusalPageType, 'Pour des raisons de sécurité, votre carte est bloquée, pour une courte durée, pour les paiements en ligne.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'fr', 32, @refusalPageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'fr', 33, @refusalPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'fr', 41, @refusalPageType, 'Aide', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'fr', 100, 'ALL', 'Commerçant', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'fr', 101, 'ALL', 'Montant', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'fr', 102, 'ALL', 'Date', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'fr', 103, 'ALL', 'Numéro de carte', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'fr', 174,@refusalPageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'fr', 175,@refusalPageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetRefusalFraud);



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'fr', 1, @helpPagePageType, '<b>Aide</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'fr', 2, @helpPagePageType, 'Afin d''augmenter votre sécurité lors des paiements en ligne, Zürcher Kantonalbank a mis en place une authentification en deux étapes. ', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'fr', 3, @helpPagePageType, 'Afin de pouvoir effectuer un paiement, vous devez le confirmer soit au moyen d''un code d''activation par SMS, soit par la vérification de votre personne sur une App d''authentification mobile. Pour ce service, vous devez vous enregistrer une fois. Pour la procédure d''enregistrement correspondante, ou pour les modifications de votre méthode d''authentification, veuillez vous adresser à Zürcher Kantonalbank.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'fr', 174, @helpPagePageType, 'Fermer le texte d''aide', @MaestroVID, NULL, @customItemSetRefusalFraud);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'fr', 11, @failurePagePageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'fr', 16, @failurePagePageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'fr', 17, @failurePagePageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'fr', 32, @failurePagePageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'fr', 33, @failurePagePageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'fr', 41, @failurePagePageType, 'Aide', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'fr', 174, @failurePagePageType, 'Fermer le message', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'fr', 175, @failurePagePageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetRefusalFraud);





INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
	   'it', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetRefusalFraud
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
	   'it', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetRefusalFraud
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'it', 1, @refusalPageType, '<b>Autorizzazione di pagamento non possibile</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'it', 2, @refusalPageType, 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'it', 3, @refusalPageType, ' Stabilisca un metodo di autenticazione corrispondente per la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'it', 11, @refusalPageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_220'), @updateState,
 'it', 220, @refusalPageType, 'Pagamento non eseguito', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_230'), @updateState,
 'it', 230, @refusalPageType, 'Per motivi di sicurezza la sua carta è bloccata per i pagamenti online per un breve periodo di tempo.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'it', 32, @refusalPageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'it', 33, @refusalPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'it', 41, @refusalPageType, 'Aiuto', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_100'), @updateState,
 'it', 100, 'ALL', 'Commerciante', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_101'), @updateState,
 'it', 101, 'ALL', 'Importo', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_102'), @updateState,
 'it', 102, 'ALL', 'Data', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_103'), @updateState,
 'it', 103, 'ALL', 'Numero della carta', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_104'), @updateState,
 'it', 104, 'ALL', 'Numero di telefono', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_174'), @updateState,
 'it', 174,@refusalPageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'it', 175,@refusalPageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetRefusalFraud);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'it', 1, @helpPagePageType, '<b>Aiuto</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'it', 2, @helpPagePageType, 'Al fine di aumentare la sicurezza per i pagamenti online, Zürcher Kantonalbank ha introdotto una procedura di autenticazione in due fasi. ', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'it', 3, @helpPagePageType, ' Per poter effettuare un pagamento, deve confermarlo utilizzando un codice di autenticazione tramite SMS o verificando la sua persona su un’app di autenticazione mobile. Deve effettuare una volta la registrazione per questo servizio. Si rivolga alla Zürcher Kantonalbank per il processo di registrazione corrispondente o per modifiche al metodo di autenticazione.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'it', 174, @helpPagePageType, 'Chiudere l’aiuto', @MaestroVID, NULL, @customItemSetRefusalFraud);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'it', 11, @failurePagePageType, '<b>Informazioni sul pagamento</b>', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'it', 16, @failurePagePageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'it', 17, @failurePagePageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'it', 32, @failurePagePageType, 'Pagamento non eseguito - Errore tecnico', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'it', 33, @failurePagePageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'it', 41, @failurePagePageType, 'Aiuto', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'it', 174, @failurePagePageType, 'Chiudere messaggio', @MaestroVID, NULL, @customItemSetRefusalFraud),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'it', 175, @failurePagePageType, 'Indietro al negozio online', @MaestroVID, NULL, @customItemSetRefusalFraud);







# ---------- BACKUP_REFUSAL -------------------

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


SET @customPageLayoutDesc = 'Refusal Page (Kantonal)';
SET @pageType = 'REFUSAL_PAGE';

SET @pageLayoutId = (select id
                      from `CustomPageLayout`
                      where `pageType` = @pageType
                        and DESCRIPTION = @customPageLayoutDesc);

UPDATE `CustomComponent` SET `value` = '
<style>
	div#optGblPage {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 14px;
	}
	#optGblPage .warn {
		background-color: #3399FF
	}
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 40%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderRight {
		width: 50%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: flex-end;
	}
	#issuerLogo {
		max-height: 64px;
		max-width: 100%;
	}
	#networkLogo {
		max-height: 65px;
		max-width: 100%;
	}
	#i18n > button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#i18n-container {
		width: 100%;
		clear: both;
	}
	#i18n-inner {
		display: block;
		margin-left: auto;
		margin-right: auto;
		clear: both;
	}
	#i18n > button {
		background: transparent;
		color: #557a8e;
		border: none;
		box-shadow: none;
	}
	#i18n > button.active {
		background: #06446c !important;
		color:#FFFFFF!important;
		border-radius: 5px !important;
	}
	div#green-banner {
		height: 50px !important;
		background-color: #ada398;
		border-bottom: 5px solid #ada398;
		width: 100%;
	}
	.paragraph {
		text-align: left;
		margin-bottom: 10px;
	}
	.paragraphDescription {
		text-align: left;
	}
	.leftColumn {
		width: 40%;
		display: block;
		float: left;
		padding-top: 1.5em;
		padding-bottom: 1.5em;
		padding-right: 1em;
	}
	.rightColumn {
		width: 60%;
		margin-left: 40%;
		display: block;
		text-align: left;
		padding: 20px 10px;
	}
	.contentRow {
		width: 100%;
		padding: 1em;
		padding: 0px;
		clear: both;
		font-size: 12px;
		color: #000000;
	}
	side-menu div.text-center {
		text-align: center;
	}
	div.side-menu div.menu-title::before {
		display: inline;
	}
	div.side-menu div.menu-title::after {
		display: inline;
	}
	div.side-menu div.menu-title {
		display: inline;
		text-align: left;
		font-size: 14px;
		color: #000000;
	}
	div.side-menu div.menu-elements {
		margin-top: 5px;
		display: grid;
	}
	div#footer {
		padding-top: 5px;
		padding-bottom: 5px;
		width: 100%;
		background-color: #ada398;
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
	}
	div#footer #helpButton button span:before {
		content: '''';
	}
	div#footer #cancelButton button span:before {
		content: '''';
	}
	div#footer #helpButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-position-y: -1px;
		background-size: 115%;
		display: inline-block;
	}
	div#footer #cancelButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAACLxJREFUeAHtmw1oVlUYx92mbjqbH03TID8rQaGZpnNSFlhWFpaRkYFYEChYOud0ToUUbTrn/NgoEkwIykBMy+yDjLIy076I1FmZlkFTVNxKfZ06t37P630ux3f33ve979cGvRfunnPOPec5////nHPPOfe8a9cudaUUSCmQUiClwP9XgbRkUN+yZUvGnj17hqWnp49pamoanJaWdmtzc3MvbBfqz+IOED+PreU+Qr7DGRkZeyorK38hntArYQJUVVVlHjt27BEIT4HBeO4cv0wQ6BTC7Gjfvv3mnJycL5YsWdLk10e4/HEXoLS0tOfFixdfBPhM7h7hAET6HDH+JG9l9+7dNyFEINJy4fLFTQBAZZ09e7YEoCUQ7+RQ8SWe7Sb9J+xJ8pygq58kXN/Y2JiL7cPdmx4jtoB8+eRJD/XDs1OkLVy3bt0mws2hz/3G4yLArFmzxgFmI4D7hwA4TfoO7p10412rV6++EPLcNSo9KRAIPEyGR7kn4Ds7JPO3CPgsQhwOSfcVjUkAWr19XV3dUmpcENJadZAup7tWx6O7FhcX96KXLKR3zKCuTINhABFelN5gpPkKRi0AoLKvXLnyDsQf1BohfYH4uk6dOlWUl5f/o+nxsrNnz+6L/5fwN407w/Bb3aNHj0LE9v2SjEqAuXPn5tIiHwJmpAGihqnrsbVr1/5upCUkiBBjqXsrzntqBYj//aBBg+5mOF7StEhsi5dMuEKo3MWB/PtZWVmjk0Fe8K1fv/7LDh06jIT0AcWLIHcdPXr0E6yvRvUlgDXmt5otD4gyut/jq1atOqdgkmGp9wz1XDfMwDW2sLCw0k/95jgKWy4vL6+MSmT8BS9ALKc1Fu/evTvm6Uh9RmKt948MwXsc8hdw/bZv376DDs9aJEXcXebMmTP+6tWrH+NBy7wH+UmI0FrkxyobhKhkNngIO9RK+zczM3N4RUXFUc3jZiMaAnT9zkxBG3ESJA/pQ4z5qW2BPJhWVFdXF3fs2PEx8Jy1iOZcvnx5gxtpMz0iAZjrS1H3FilIJedQe2Kyx7zR7e2WB84K9hwLBZfV2k9LWC7wjuN98OS1mPvfsALMmzevN87mqQvClbztj2k8GTYcecXAkNxFA23XOFjLZSeqcScbVgC6UiEFg6svnJ+h669xcpSotEjJa/0suReDM7ggQoCBbMMn6zMn6ymAVE4hWX4GLxyvSGbX90teQPINoQbzZhDwtT/FRrhF0FMAFjwTUbGrlIL8iW7dur3awkOCEqIhr1BYJC0hfNWKj2DlOkSfhVpPASD/jBYgvI3ZoEHjibSxkBdc7Dr/oMG+UYw0pHyUcbxcBYBsR0jfr6VY5+/UcCJtrOQNbDZeeDxipF8XdBWAqW8UOeV7nXT/CwMGDPj8upIJiDiRp+4yner8VAnpDzQ/PvJKSkqCQ1nT1LoKgIMxmonwp353WVo2UutGnqltUaQ+zHyIdpD4cUkDf3pDQ8No87mGXQUgw2DNhII/ajgRNt7kFSO4f9Aw1uZjpLXzEuA2I+MJIxzXYKLIWyBPGmBNPnaylwA3aS6WvqYjTY7ZJpi84LMbjmHQywmwlwByaKGX7UgTYrVJIC8vb7vhCN/ghNlLAPvTNsvLOqfC0aYlg7xgo9Vt3ISDM1ooZlcBUCygmdkP5Go4Vpss8oIT0jcqXpOPpol1FYBn5zUj74DeGo7FJpO8hbOPgdfmY6R5CmCPe74EmY7M8hGHW4G8vAPMhrP5mKC9esARzYijmARoDfKCnSFg4rb5KC+xXgKYR075ZiE/4VYkT7ulyXI+eBH+RcOmdRWAcf+1ZkTJ+4SIxiO1rUVe8HF4Mlx7AOQbmcn2O+F2FaBr166y/NUXRyZbygecHLiltSZ5C5Mcqur1g9vBrKsAbIcbUe4j9cBXYdctpeZR2wbIywvQFoDw+4ot1LoKIBkpuNkoMGn+/PmOqykjT7u2QF6+ANH9RygueLyt4VDrKcDAgQOlB5y2Ct3IlrIo1IEZbwvkBQ/DdTlGD3C+8vqK7SmAfANAvSqDZBE/XLBXV0Z6m2h5wcMJ1ihaf5Ji40tWhYadrKcAUoCz/lcQ4ZxVOIdfbZSGOmorLS+4eFeVKT5wH1yzZs1OjTvZsAKsXLlSNhTLtDDqziwqKsrTeFsiT+s/Bb5xig1bhAieZ5c6TowyLYMbNmzoUFNTcwDng62nx7Ozs0fyC5EAt5zS2sdVVFgW7WesljVHnsIx2DBaX9YunaUUOLaD44lwHsL2AHEwffr0K5hp3GLl6sdQ2MYu8aO2QF5+UAX5d8Gl5E8hwMwg0jB/PM/NzLL79+//Oz8//xJpuiDqS7if5mmtlpfeWVtbK+Nch2UzL77J/HDqJ8XmZSMaAuqA1k6jq72FnaJpYiFfTndbYKYlI8x8n8sQ3Epd92p9YCkFy0qNh7MRDQF1gvPmIUOGTMOG7qzGyimy5kuGZa1/B/P9d9Rlkq/yQ15w+hJACsj7gKlRdoc/S1wuekQB74PvATXyWkpi/1rn/nupt79RUzXdXk6yfV2+hoDpWcbeoUOHXidtqpEuB5Jv0EOW0hJ/GelxCTL93snHmZchLr8g1auZnesiyK/QBD82agG0Elr9BQCtJp6padhLgHqNLWgZuzD5bW9MF8Rvp7vLWkTO+m3MCH2GuqdxCvRhtBXYzqJ1IOWsOVh+Q2RvQCx/DYD8jHsnQD/w0ytY1AxlapMd3aOULcCGzljy28QZ/F6h1qorKhMXAaRmts/p/Fr8ecguA7DjIQTP5L0R/LU49gQETzJl1WNzifehXG/y9CFcQLg/tsXF8195VhRLq5tO4yaAOkWIrPr6+ucEJPetmh6rhbh80angB9jbqaMpVn9aPu4CqGOxDI0CWlfWDBO4B0lapBeEmxDwAO+SHfSSzYn695mECmCS5WPKzUyVYyB1O+m3ccsw6UI8C7IBwucJ10JY1hiHGd97rY0Y0dSVUiClQEqBlAIJUeA/Mi9ovi9iSQYAAAAASUVORK5CYII=);
		width: 24px;
		height: 26px;
		background-position-y: 1px;
		background-size: contain;
		display: inline-block;
		margin-left: 3px;
	}
	div#footer {
		padding-top: 12px;
		padding-bottom: 12px;
		clear: both;
		width: 100%;
		background-color: #f0f0f0;
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
	}
	div#footer {
		height: 60px;
	}
	#helpButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0, 0, 0, .25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
	}
	#cancelButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0, 0, 0, .25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
	}
	#cancelButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#helpButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:hover:enabled {
		border-color: rgba(255, 106, 16, .75);
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align: 8px;
	}
	#helpButton button:hover {
		border-color: rgba(255, 106, 16, .75);
	}
	#helpButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#helpButton button custom-text {
		vertical-align: 8px;
	}
	#helpCloseButton button {
		padding-left: 0px !important;
	}
	#helpCloseButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	div#footer {
		height: 50px;
	}
	 @media all and (max-width: 1610px) {
		#pageHeader {height: 96px;}
		.leftColumn { padding-bottom: 10em; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 701px) {
		#pageHeader {height: 80px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left; }
	}
	@media all and (max-width: 700px) and (min-width: 601px){
		 #pageHeader {height: 80px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		.leftColumn { padding-top: 0em; padding-bottom: 0em;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top:0px;}
		.paragraph{ text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 600px) and (min-width: 501px) {
		h1 { font-size:24px; }
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		#optGblPage {  font-size : 14px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display:block; float:none; width:100%; padding-bottom: 5px; padding-top: 5px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 0px; padding: 0px 0px;}
	}
	@media all and (max-width: 500px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display:block; float:none; width:100%; padding-bottom: 5px; padding-top: 5px;}
		.rightColumn { margin-left:0px; display:block; float:none; width:100%; margin-top: 0px; padding: 0px 0px;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size: 16px; }
		div.side-menu div.menu-title { display: inline; }
		#optGblPage { font-size: 14px;}
		span.ng-binding { word-break: break-word; }
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 0em; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 10px; }
	}
	@media all and (max-width: 391px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		div#green-banner { display: none;}
		#optGblPage {   font-size : 14px;}
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		span.ng-binding { word-break: break-word; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display:block; float:none; width:100%; padding-bottom: 5px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; padding: 0px 10px;}
	}
	@media all and (max-width: 250px) {
		div#green-banner { display: none;}
		.contentRow { font-size: 11px; }
		.rightColumn { margin-top: 20px; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

   <alternative-display attribute="''currentProfileName''" value="''ZKB_REFUSAL_FRAUD''" enabled="''fraud_refusal''" default-fallback="''default_refusal''" ></alternative-display>
	<div class="fraud_refusal" ng-style="style" class="ng-scope" style="display: none;">
		<message-banner display-type="''1''" heading-attr="''network_means_pageType_220''" message-attr="''network_means_pageType_230''" close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''" show=true ></message-banner>
	</div>
	<div class="default_refusal" ng-style="style" class="ng-scope" style="display: none;">
		<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''" ></message-banner>
	</div>
	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<div class="contentRow">
		<div class="leftColumn">
			<side-menu menu-title="''network_means_pageType_11''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
			</div>
			<div class="paragraphDescription">
				<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
			</div>
			<div class="paragraphDescription">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		</div>
	</div>
</div>
' WHERE fk_id_layout = @pageLayoutId;



