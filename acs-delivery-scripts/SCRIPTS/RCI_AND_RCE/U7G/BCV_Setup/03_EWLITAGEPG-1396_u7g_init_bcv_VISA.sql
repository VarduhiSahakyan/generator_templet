USE `U7G_ACS_BO`;

SET @createdBy ='A709391';
SET @issuerCode = '76700';
SET @subIssuerCode = '76700';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

SET @bank = 'BCV';

SET @profileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @bank, '_01'));

SET @maestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @maestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
SELECT n.id, si.id
FROM `Network` n, `SubIssuer` si
WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
  AND n.code = 'VISA';

SET @subIssuerIDSOBA = (SELECT id FROM SubIssuer where code = 83340 AND name = 'Baloise Bank SoBa AG');

SET @updateState = 'PUSHED_TO_CONFIG';

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, @updateState, TRUE, NOW(), '4395906000', 16, FALSE, NULL, '4395906999', FALSE, @profileSet, @maestroVID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
SELECT b.id, s.id
FROM BinRange b, SubIssuer s
WHERE b.lowerBound = '4395906000' AND b.upperBound = '4395906999'
  AND b.fk_id_profileSet=@profileSet
  AND s.code=@subIssuerCode;

SET @maestroVID = NULL;
SET @refusalPageType = 'REFUSAL_PAGE';
SET @helpPagePageType = 'HELP_PAGE';
SET @failurePagePageType = 'FAILURE_PAGE';
SET @otpFormPagePageType = 'OTP_FORM_PAGE';
SET @pollingPagePageType = 'POLLING_PAGE';

SET @refusalAuthentMean = 'REFUSAL';
SET @otpSMSExtMessageAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @mobilleAppAuthentMean = 'MOBILE_APP';

-- SMS --

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @bank, '_SMS'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
       'de', 1, 'ALL', @bank, @maestroVID, im.id, @customItemSetSMS
FROM `Image` im WHERE im.name LIKE CONCAT('%',@bank,'%');

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
        'Sie haben einen Freigabe-Code für eine Online-Zahlung angefordert. Bitte verwenden Sie folgenden Code: @otp', @maestroVID, NULL, @customItemSetSMS);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_1'), @updateState,
 'de', 1, @otpFormPagePageType, '<b>Zahlungsfreigabe per SMS</b>', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_2'), @updateState,
'de', 2, @otpFormPagePageType, 'Wir haben Ihnen einen Freigabecode per SMS an die von Ihnen angegebene Handynummer gesendet. ', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_3'), @updateState,
 'de', 3, @otpFormPagePageType, 'Bitte überprüfen Sie die Zahlung und bestätigen Sie sie durch Eingabe des Freigabecodes.  ', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_11'), @updateState,
 'de', 11, @otpFormPagePageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_12'), @updateState,
 'de', 12, @otpFormPagePageType, 'Zahlungsfreigabe wird geprüft', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_13'), @updateState,
 'de', 13, @otpFormPagePageType, 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_14'), @updateState,
 'de', 14, @otpFormPagePageType, 'Zahlungsfreigabe abgebrochen', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_15'), @updateState,
 'de', 15, @otpFormPagePageType, 'Die Zahlung wurde abgebrochen und Ihr Konto nicht belastet. Falls Sie den Kauf dennoch durchführen möchten, starten Sie einen neuen Zahlungsversuch.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_19'), @updateState,
'de', 19, @otpFormPagePageType, 'Neuen Freigabecode anfordern', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_22'), @updateState,
 'de', 22, @otpFormPagePageType, 'Zahlungsfreigabe fehlgeschlagen', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_23'), @updateState,
 'de', 23, @otpFormPagePageType, 'Sie haben 3-mal einen falschen Code eingegeben. Die Zahlung konnte nicht ausgeführt werden und Ihr Konto wurde nicht belastet. Aus Sicherheitsgründen wird Ihre Karte für Online-Zahlungen kurzzeitig gesperrt. ', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_26'), @updateState,
 'de', 26, @otpFormPagePageType, 'Zahlungsfreigabe erfolgreich', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_27'), @updateState,
 'de', 27, @otpFormPagePageType, 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zur Website des Händlers weitergeleitet.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_28'), @updateState,
 'de', 28, @otpFormPagePageType, 'Falscher Freigabecode', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_29'), @updateState,
 'de', 29, @otpFormPagePageType, 'Der von Ihnen erfasste Freigabecode ist nicht korrekt. Die Zahlung wurde nicht ausgeführt und Ihr Konto nicht belastet. Falls Sie den Kauf immer noch tätigen möchten, versuchen Sie es bitte erneut.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_30'), @updateState,
 'de', 30, @otpFormPagePageType, 'Zahlung nicht ausgeführt – Sitzung abgelaufen', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_31'), @updateState,
 'de', 31, @otpFormPagePageType, 'Die Zahlung wurde nicht innerhalb der vorgegebenen Frist freigegeben. Aus Sicherheitsgründen wurde der Zahlungsvorgang deshalb abgebrochen. Falls Sie die Zahlung dennoch vornehmen möchten, kehren Sie bitte zum Online-Shop zurück und starten Sie den Zahlungsvorgang neu.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_32'), @updateState,
 'de', 32, @otpFormPagePageType, 'Zahlung nicht ausgeführt – Technischer Fehler', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_33'), @updateState,
 'de', 33, @otpFormPagePageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Falls Sie den Kauf immer noch tätigen möchten, versuchen Sie es bitte erneut.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_34'), @updateState,
 'de', 34, @otpFormPagePageType, 'Freigabecode per SMS versandt', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_35'), @updateState,
 'de', 35, @otpFormPagePageType, 'Bitte haben Sie einen kleinen Moment Geduld. Sie werden in wenigen Augenblicken eine SMS mit dem neuen Freigabecode auf Ihr Handy erhalten. ', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_40'), @updateState,
 'de', 40, @otpFormPagePageType, 'Zahlung abbrechen', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_41'), @updateState,
 'de', 41, @otpFormPagePageType, 'Hilfe', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_42'), @updateState,
 'de', 42, @otpFormPagePageType, 'Freigeben', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_51'), @updateState,
 'de', 51, @otpFormPagePageType, 'Zugriff auf BCV Mobile zurzeit nicht möglich', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_52'), @updateState,
 'de', 52, @otpFormPagePageType, 'Da der Zugriff auf BCV Mobile zurzeit nicht möglich ist, haben wir eine SMS mit einem Freigabecode an Ihr Handy geschickt, mit dessen Hilfe Sie die Zahlung freigeben können.', @MaestroVID, NULL, @customItemSetSMS);

/* Elements for the HELP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'de', 1, @helpPagePageType, '<b>Hilfe</b>', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'de', 2, @helpPagePageType, 'Um die Sicherheit bei Online-Zahlungen zu erhöhen, hat die BCV ein System zur Zahlungsfreigabe durch den/die Karteninhaber/in eingerichtet. 	', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'de', 3, @helpPagePageType, 'Bevor die Zahlung ausgeführt wird, muss sie zuerst durch Eingabe des per SMS erhaltenen Codes freigegeben werden. Wenden Sie sich bei Fragen direkt an die BCV.', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'de', 174, @helpPagePageType, 'Hilfe schliessen', @maestroVID, NULL, @customItemSetSMS);

/* Elements for the FAILURE page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'de', 11, @failurePagePageType, '<b>Informationen zur Zahlung</b>', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'de', 16, @failurePagePageType, 'Freigabe fehlgeschlagen', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'de', 17, @failurePagePageType, 'Sie haben 3 Mal einen fehlerhaften Freigabe-Code eingegeben. Ihre Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Ihre Karte wird nun aus Sicherheitsgründen während einer kurzen Zeitdauer für Online-Zahlungen blockiert. ', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'de', 32, @failurePagePageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'de', 33, @failurePagePageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'de', 41, @failurePagePageType, 'Hilfe', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'de', 174, @failurePagePageType, 'Meldung schliessen', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'de', 175, @failurePagePageType, 'Zurück zum Online Shop', @maestroVID, NULL, @customItemSetSMS);


/*ENGLISH translations for OTP_SMS*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
       'en', 1, 'ALL', @bank, @maestroVID, im.id, @customItemSetSMS
FROM `Image` im WHERE im.name LIKE CONCAT('%',@bank,'%');

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
        'You have requested an approval code for an online purchase. Please use the following code: @otp', @maestroVID, NULL, @customItemSetSMS);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_1'), @updateState,
 'en', 1, @otpFormPagePageType, '<b>Payment confirmation via text message</b>', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_2'), @updateState,
 'en', 2, @otpFormPagePageType, 'We have sent a text message with a confirmation code to your mobile phone.	 ', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_3'), @updateState,
'en', 3, @otpFormPagePageType, 'If the payment details are correct, please confirm the payment by entering the confirmation code. ', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_11'), @updateState,
 'en', 11, @otpFormPagePageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_12'), @updateState,
 'en', 12, @otpFormPagePageType, 'Payment approval is being verified', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_13'), @updateState,
 'en', 13, @otpFormPagePageType, 'Please be patient. We are verifying your payment approval and thereby the authentication for the requested payment.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_14'), @updateState,
 'en', 14, @otpFormPagePageType, 'Canceling payment approval', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_15'), @updateState,
 'en', 15, @otpFormPagePageType, 'This card payment has been canceled and your account has not been debited. If you still wish to make this purchase, you must start over.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_19'), @updateState,
 'en', 19, @otpFormPagePageType, 'Request a new confirmation code', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_22'), @updateState,
 'en', 22, @otpFormPagePageType, 'Payment approval failed', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_23'), @updateState,
 'en', 23, @otpFormPagePageType, 'You have entered an incorrect confirmation code three times. The payment was not completed and your account has not been debited. For security reasons, your card has been temporarily blocked for online payments.  ', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_26'), @updateState,
 'en', 26, @otpFormPagePageType, 'Your payment has been approved', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_27'), @updateState,
 'en', 27, @otpFormPagePageType, 'You have confirmed this payment. You will now be redirected to the merchant’s website.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_28'), @updateState,
 'en', 28, @otpFormPagePageType, 'Incorrect confirmation code', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_29'), @updateState,
 'en', 29, @otpFormPagePageType, 'The approval code you entered is incorrect. The payment was not conducted and your card was not debited. Please try again if you wish to continue the purchase.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_30'), @updateState,
 'en', 30, @otpFormPagePageType, 'Payment not completed - Session timed out', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_31'), @updateState,
 'en', 31, @otpFormPagePageType, 'The payment was not completed within the allotted time. For security reasons, the payment has been canceled. If you still wish to make this purchase, please return to the merchant’s website and start over.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_32'), @updateState,
 'en', 32, @otpFormPagePageType, 'Payment not completed - Technical issue', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_33'), @updateState,
 'en', 33, @otpFormPagePageType, 'The payment was not completed due to a technical issue. If you still wish to make this purchase, you must start over.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_34'), @updateState,
 'en', 34, @otpFormPagePageType, 'Code sent via text', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_35'), @updateState,
 'en', 35, @otpFormPagePageType, 'The confirmation code you have entered is incorrect. The payment was not completed and your account has not been debited. If you still wish to make this purchase, you must start over.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_40'), @updateState,
 'en', 40, @otpFormPagePageType, 'Cancel payment', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_41'), @updateState,
 'en', 41, @otpFormPagePageType, 'Help', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_42'), @updateState,
 'en', 42, @otpFormPagePageType, 'Approve', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_51'), @updateState,
 'en', 51, @otpFormPagePageType, 'Unable to connect to BCV Mobile', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_52'), @updateState,
 'en', 52, @otpFormPagePageType, 'Since it is not possible to connect to BCV Mobile at this time, we have sent a text message with a payment confirmation code to your mobile phone.', @MaestroVID, NULL, @customItemSetSMS);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'en', 1, @helpPagePageType, '<b>Help</b>', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'en', 2, @helpPagePageType, 'To make your online payments more secure, BCV uses a system that requires card users to verify their identity first. Payments are therefore not executed until you have entered the confirmation code you received in a text message. ', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'en', 3, @helpPagePageType, 'Please contact BCV directly if you have any questions.', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'en', 174, @helpPagePageType, 'Close Help', @maestroVID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'en', 11, @failurePagePageType, '<b>Information about payment</b>', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'en', 16, @failurePagePageType, 'Approval failed', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'en', 17, @failurePagePageType, 'You have entered an incorrect approval code multiple times. Your payment could not be completed and your card was not debited. Your card will now be temporarily blocked for online payments for security reasons. ', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'en', 32, @failurePagePageType, 'Payment not completed – technical error', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'en', 33, @failurePagePageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'en', 41, @failurePagePageType, 'Help', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'en', 174, @failurePagePageType, 'Close message', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'en', 175, @failurePagePageType, 'Back to the online shop', @maestroVID, NULL, @customItemSetSMS);



/*FRENCH translations for OTP_SMS_EXT*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
       'fr', 1, 'ALL', @bank, @maestroVID, im.id, @customItemSetSMS
FROM `Image` im WHERE im.name LIKE CONCAT('%',@bank,'%');

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
        'Vous avez demandé un code d’activation pour un paiement en ligne. Veuillez utiliser le code suivant : @otp', @maestroVID, NULL, @customItemSetSMS);



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_1'), @updateState,
 'fr', 1, @otpFormPagePageType, '<b>SMS - Activation du paiement</b>', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_2'), @updateState,
 'fr', 2, @otpFormPagePageType, 'Nous vous avons envoyé un code de confirmation par SMS sur votre téléphone portable. ', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_3'), @updateState,
 'fr', 3, @otpFormPagePageType, 'Nous vous remercions de vérifier le détail du paiement et de confirmer le paiement en saisissant le code de confirmation.', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_11'), @updateState,
 'fr', 11, @otpFormPagePageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_12'), @updateState,
 'fr', 12, @otpFormPagePageType, 'Votre paiement est en cours de vérification.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_13'), @updateState,
 'fr', 13, @otpFormPagePageType, 'Merci de patienter. Nous vérifions votre confirmation de paiement.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_14'), @updateState,
 'fr', 14, @otpFormPagePageType, 'Annulation de la confirmation de paiement', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_15'), @updateState,
 'fr', 15, @otpFormPagePageType, 'Le paiement avec votre carte a été annulé et votre compte n’a pas été débité. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_19'), @updateState,
 'fr', 19, @otpFormPagePageType, 'Demander un nouveau code d''activation', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_22'), @updateState,
 'fr', 22, @otpFormPagePageType, 'Echec de la confirmation de paiement', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_23'), @updateState,
 'fr', 23, @otpFormPagePageType, 'Vous avez saisi  3 fois un mauvais code de confirmation Votre paiement n''a pas pu être terminé et votre compte n''a pas été débité. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne.  ', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_26'), @updateState,
 'fr', 26, @otpFormPagePageType, 'Votre paiement a été validé', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_27'), @updateState,
 'fr', 27, @otpFormPagePageType, 'Vous avez confirmé le paiement. Vous serez redirigé automatiquement vers le site du commerçant.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_28'), @updateState,
 'fr', 28, @otpFormPagePageType, 'Code de confirmation erroné', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_29'), @updateState,
 'fr', 29, @otpFormPagePageType, 'Le code de confirmation que vous avez saisi n''est pas correct. Le paiement n''a pas été effectué et votre compte n''a pas été débité. Si vous voulez continuer l''achat, essayez à nouveau.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_30'), @updateState,
 'fr', 30, @otpFormPagePageType, 'Paiement non effectué - La session a expiré', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_31'), @updateState,
 'fr', 31, @otpFormPagePageType, 'Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_32'), @updateState,
 'fr', 32, @otpFormPagePageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_33'), @updateState,
 'fr', 33, @otpFormPagePageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau. ', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_34'), @updateState,
 'fr', 34, @otpFormPagePageType, 'Envoi d''un code par SMS', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_35'), @updateState,
 'fr', 35, @otpFormPagePageType, 'Veuillez patienter un instant. Vous recevrez d’ici peu  ,par SMS, un nouveau code pour confirmer votre paiement avec votre téléphone portable.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_40'), @updateState,
 'fr', 40, @otpFormPagePageType, 'Interrompre le paiement', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_41'), @updateState,
 'fr', 41, @otpFormPagePageType, 'Aide', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_42'), @updateState,
 'fr', 42, @otpFormPagePageType, 'Confirmer', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_51'), @updateState,
 'fr', 51, @otpFormPagePageType, 'La connexion avec BCV Mobile est actuellement impossible.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_52'), @updateState,
 'fr', 52, @otpFormPagePageType, 'La connexion avec BCV Mobile étant actuellement impossible, pour confirmer le paiement, nous vous avons envoyé, par SMS, un code de validation sur votre téléphone mobile.', @MaestroVID, NULL, @customItemSetSMS);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
'fr', 1, @helpPagePageType, '<b>Aide</b>', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'fr', 2, @helpPagePageType, 'Afin d''augmenter la sécurité lors de vos paiements en ligne, la BCV a mis en place un système de validation par authentifcation du détenteur de la carte. ', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'fr', 3, @helpPagePageType, 'Pour être exécuté, le paiement doit, au préalable, être confirmé en saisissant le code reçu par SMS. En cas de question, vous pouvez contacter directement la BCV.', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'fr', 174, @helpPagePageType, 'Fermer l''aide', @maestroVID, NULL, @customItemSetSMS);


/* Elements for the FAILURE page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'fr', 11, @failurePagePageType, '<b>Informations concernant le paiement.</b>', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'fr', 16, @failurePagePageType, 'L''activation a échoué', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'fr', 17, @failurePagePageType, 'Vous avez saisi 3 fois un mauvais code d''activation. Votre paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne. ', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'fr', 32, @failurePagePageType, 'Paiement non effectué - Problème technique', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'fr', 33, @failurePagePageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau. ', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'fr', 41, @failurePagePageType, 'Aide', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'fr', 174, @failurePagePageType, 'Fermer le message', @maestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'fr', 175, @failurePagePageType, 'Retour vers la boutique en ligne', @maestroVID, NULL, @customItemSetSMS);


-- ------------------- Mobile APP --------------------------- --

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @bank, '_MOBILE_APP'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
       'de', 1, 'ALL', @bank, @MaestroVID, im.id, @customItemSetMobileApp
FROM `Image` im WHERE im.name LIKE CONCAT('%',@bank,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
       'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileApp
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

/*MOBILE_APP_EXT_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_1'), @updateState,
 'de', 1, @pollingPagePageType, '<b>Zahlung in BCV Mobile freigeben</b>', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_2'), @updateState,
 'de', 2, @pollingPagePageType, 'Aus Sicherheitsgründen müssen Sie Ihre Zahlung in BCV Mobile noch freigeben. Sie sollten auf Ihrem Handy bereits eine entsprechende Nachricht erhalten haben. ', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_3'), @updateState,
 'de', 3, @pollingPagePageType, 'Sollte dies nicht der Fall sein, öffnen Sie einfach BCV Mobile und klicken Sie auf dem Startbildschirm oben rechts auf das Kartensymbol. Die Anfrage zur Zahlungsfreigabe wird dann angezeigt.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_11'), @updateState,
 'de', 11, @pollingPagePageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_12'), @updateState,
 'de', 12,@pollingPagePageType, 'Die Zahlungsfreigabe wird geprüft.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_13'), @updateState,
 'de', 13,@pollingPagePageType, 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre Zahlungsfreigabe.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_14'), @updateState,
 'de', 14,@pollingPagePageType, 'Zahlungsfreigabe abgebrochen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_15'), @updateState,
 'de', 15,@pollingPagePageType, 'Die Zahlung wurde abgebrochen und Ihr Konto nicht belastet. Falls Sie Ihren Kauf trotzdem durchführen möchten, starten Sie den Zahlungsvorgang bitte von Neuem.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_26'), @updateState,
 'de', 26,@pollingPagePageType, 'Die Zahlungsfreigabe war erfolgreich.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_27'), @updateState,
 'de', 27,@pollingPagePageType, 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zur Website des Händlers weitergeleitet.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_30'), @updateState,
 'de', 30,@pollingPagePageType, 'Zahlung nicht ausgeführt – Sitzung abgelaufen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_31'), @updateState,
 'de', 31,@pollingPagePageType, 'Wir haben in der dafür vorgesehenen Zeit keine Zahlungsfreigabe erhalten. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Ihr Konto wurde nicht belastet. Falls Sie die Zahlung dennoch vornehmen möchten, kehren Sie bitte zum Online-Shop zurück.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_32'), @updateState,
 'de', 32,@pollingPagePageType, 'Zahlung nicht ausgeführt – Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_33'), @updateState,
 'de', 33,@pollingPagePageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihr Konto wurde nicht belastet. Falls Sie Ihren Kauf trotzdem durchführen möchten, starten Sie den Zahlungsvorgang bitte von Neuem.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_40'), @updateState,
'de', 40, @pollingPagePageType, 'Zahlung abbrechen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_41'), @updateState,
'de', 41, @pollingPagePageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMobileApp);

/* HELP page for MOBILE APP */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'de', 1, @helpPagePageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'de', 2, @helpPagePageType, 'Um die Sicherheit bei Online-Zahlungen zu erhöhen, hat die BCV ein System zur Zahlungsfreigabe durch den/die Karteninhaber/in eingerichtet. ', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'de', 3, @helpPagePageType, 'Bevor die Zahlung ausgeführt wird, muss sie zuerst in der App BCV Mobile freigegeben werden. Bei Fragen wenden Sie sich bitte direkt an die BCV. ', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'de', 174, @helpPagePageType, 'Hilfe schliessen', @MaestroVID, NULL, @customItemSetMobileApp);

/* Elements for the FAILURE page, for MOBILE APP EXT Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'de', 11, @failurePagePageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'de', 16, @failurePagePageType, 'Zahlungsfreigabe fehlgeschlagen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'de', 17, @failurePagePageType, 'Die Authentifikation auf Ihrem Handy ist fehlgeschlagen. Der Zahlungsvorgang wurde daher abgebrochen und Ihr Konto nicht belastet. Falls Sie Ihren Kauf trotzdem durchführen möchten, starten Sie den Zahlungsvorgang bitte von Neuem.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'de', 32, @failurePagePageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'de', 33, @failurePagePageType, 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'de', 41, @failurePagePageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'de', 174, @failurePagePageType, 'Hilfe schliessen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'de', 175, @failurePagePageType, 'Zurück zum Online Shop', @MaestroVID, NULL, @customItemSetMobileApp);



    /*ENGLISH translations for MOBILE_APP_EXT*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                              `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                              `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
    'en', 1, 'ALL', @bank, @MaestroVID, im.id, @customItemSetMobileApp
FROM `Image` im WHERE im.name LIKE CONCAT('%',@bank,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
       'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileApp
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_1'), @updateState,
 'en', 1, @pollingPagePageType, '<b>Confirm this payment in BCV Mobile</b>', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_2'), @updateState,
 'en', 2, @pollingPagePageType, 'For greater security, you must approve this payment in BCV Mobile. You should have received a payment alert on your mobile phone. ', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_3'), @updateState,
 'en', 3, @pollingPagePageType, 'If not, simply open BCV Mobile and click on the card icon in the upper right-hand corner of the home screen. This will bring up the payment approval request.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_11'), @updateState,
 'en', 11, @pollingPagePageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_12'), @updateState,
 'en', 12,@pollingPagePageType, 'Your payment is being verified', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_13'), @updateState,
 'en', 13,@pollingPagePageType, 'Thank you for your patience. We are verifying your payment confirmation.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_14'), @updateState,
 'en', 14,@pollingPagePageType, 'Canceling payment approval', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_15'), @updateState,
 'en', 15,@pollingPagePageType, 'This card payment has been canceled and your account has not been debited. If you still wish to make this purchase, you must start over. ', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_26'), @updateState,
 'en', 26,@pollingPagePageType, 'Your payment has been approved.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_27'), @updateState,
'en', 27,@pollingPagePageType, 'You have confirmed this payment. You will now be redirected to the merchant’s website.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_30'), @updateState,
 'en', 30,@pollingPagePageType, 'Payment not completed - Session timed out', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_31'), @updateState,
 'en', 31,@pollingPagePageType, 'We did not receive payment approval within the allotted time. For security reasons, the payment has been canceled and your account has not been debited. If you still wish to make the purchase, please go back to the merchant website.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_32'), @updateState,
 'en', 32,@pollingPagePageType, 'Payment not completed - Technical issue', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_33'), @updateState,
 'en', 33,@pollingPagePageType, 'The payment was not completed due to a technical issue. Your account has not been debited. If you still wish to make this purchase, you must start over.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_40'), @updateState,
'en', 40, @pollingPagePageType, 'Cancel the payment', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_41'), @updateState,
'en', 41, @pollingPagePageType, 'Help', @MaestroVID, NULL, @customItemSetMobileApp);


/*  HELP page for MOBILE APP*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'en', 1, @helpPagePageType, '<b>Help</b>', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'en', 2, @helpPagePageType, 'To make your online payments more secure, BCV uses a system that requires card users to verify their identity first. ', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'en', 3, @helpPagePageType, 'Payments are therefore not executed until they are approved in BCV Mobile. Please contact BCV directly if you have any questions.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'en', 174, @helpPagePageType, 'Close Help', @MaestroVID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP EXT Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'en', 11, @failurePagePageType, '<b>Information about payment</b>', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'en', 16, @failurePagePageType, 'Payment approval failed', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'en', 17, @failurePagePageType, 'User authentication on your mobile phone has failed. This card payment has been canceled and your account has not been debited. If you still wish to make this purchase, you must start over.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'en', 32, @failurePagePageType, 'Payment not completed – technical error', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'en', 33, @failurePagePageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'en', 41, @failurePagePageType, 'Help', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'en', 174, @failurePagePageType, 'Close Help', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'en', 175, @failurePagePageType, 'Back to the online shop', @MaestroVID, NULL, @customItemSetMobileApp);



/*FRENCH translations for MOBILE_APP_EXT*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
       'fr', 1, 'ALL', @bank, @MaestroVID, im.id, @customItemSetMobileApp
FROM `Image` im WHERE im.name LIKE CONCAT('%',@bank,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
       'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetMobileApp
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


/*MOBILE_APP_EXT_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_1'), @updateState,
 'fr', 1, @pollingPagePageType, '<b>Confirmer le paiement dans BCV Mobile</b>', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_2'), @updateState,
 'fr', 2, @pollingPagePageType, 'Afin de garantir la sécurité de votre paiement, vous devez le valider avec BCV Mobile. À cet effet, vous devriez avoir recu une notification sur votre téléphone portable. ', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_3'), @updateState,
 'fr', 3, @pollingPagePageType, 'Dans le cas contraire, il vous suffit d’ouvrir BCV Mobile et de cliquer sur l''icône "Carte" en haut à droite de l''écran d''accueil. Un message de demande de validation s''affichera aussitôt.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_11'), @updateState,
 'fr', 11, @pollingPagePageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_12'), @updateState,
 'fr', 12,@pollingPagePageType, 'Votre paiement est en cours de vérification', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_13'), @updateState,
 'fr', 13,@pollingPagePageType, 'Merci de patienter. Nous vérifions votre confirmation de paiement.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_14'), @updateState,
 'fr', 14,@pollingPagePageType, 'Annulation de la confirmation de paiement', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_15'), @updateState,
 'fr', 15,@pollingPagePageType, 'Le paiement avec votre carte a été annulé et votre compte n’a pas été débité. Si vous souhaitez effectuer votre achat, veuillez recommencer le processus de paiement dès le début.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_26'), @updateState,
 'fr', 26,@pollingPagePageType, 'Votre paiement a été validé', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_27'), @updateState,
 'fr', 27,@pollingPagePageType, 'Vous avez confirmé le paiement. Vous allez être redirigé automatiquement vers le site du commerçant.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_30'), @updateState,
 'fr', 30,@pollingPagePageType, 'Paiement non effectué - La session a expiré', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_31'), @updateState,
 'fr', 31,@pollingPagePageType, 'Aucune confirmation de paiement ne nous est parvenue pendant le temps imparti. Pour des raisons de sécurité, le processus de paiement a donc été interrompu. Votre compte n''a pas été débité. Veuillez retourner sur la boutique en ligne si vous souhaitez effectuer votre paiement.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_32'), @updateState,
 'fr', 32,@pollingPagePageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_33'), @updateState,
 'fr', 33,@pollingPagePageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Votre compte n''a pas été débité. Si vous souhaitez  effectuer votre achat, veuillez recommencer le processus de paiement depuis le début.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_40'), @updateState,
 'fr', 40, @pollingPagePageType, 'Interrompre le paiement', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@pollingPagePageType,'_41'), @updateState,
 'fr', 41, @pollingPagePageType, 'Aide', @MaestroVID, NULL, @customItemSetMobileApp);


/*  HELP page for MOBILE APP  */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'fr', 1, @helpPagePageType, '<b>Aide</b>', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'fr', 2, @helpPagePageType, 'Afin d''augmenter la sécurité lors de vos paiements en ligne, la BCV a mis en place un système de validation par authentification du détenteur de la carte.  ', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'fr', 3, @helpPagePageType, 'Pour être exécuté, le paiement doit, au préalable, être confirmé dans l''application BCV Mobile. Pour toute question, vous pouvez prendre contact directement avec la BCV.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'fr', 174, @helpPagePageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP EXT Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'fr', 11, @failurePagePageType, '<b>Informations concernant le paiement.</b>', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'fr', 16, @failurePagePageType, 'Échec de la confirmation de paiement', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'fr', 17, @failurePagePageType, 'L''authentification sur votre téléphone portable a échoué. Le processus de paiement avec votre carte a donc été interrompu et votre compte n''a pas été débité. Si vous souhaitez effectuer votre achat, veuillez recommencer le processus de paiement dès le début.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'fr', 32, @failurePagePageType, 'Paiement non effectué - Problème technique', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'fr', 33, @failurePagePageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'fr', 41, @failurePagePageType, 'Aide', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'fr', 174, @failurePagePageType, 'Fermer l''aide', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobilleAppAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'fr', 175, @failurePagePageType, 'Retour vers la boutique en ligne', @MaestroVID, NULL, @customItemSetMobileApp);




-- --------------------------------------------------- Refusal Default ------------------------------------------------------ --

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @bank, '_DEFAULT_REFUSAL'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
       'de', 1, 'ALL', @bank, @maestroVID, im.id, @customItemSetREFUSAL
FROM `Image` im WHERE im.name LIKE CONCAT('%',@bank,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
       'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'de', 1, @refusalPageType, '<b>Zahlungsfreigabe nicht möglich</b>', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'de', 2, @refusalPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihr Konto wurde nicht belastet. ', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'de', 3, @refusalPageType, 'Falls Sie Ihren Kauf trotzdem durchführen möchten, starten Sie den Zahlungsvorgang bitte von Neuem.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'de', 11, @refusalPageType, '<b>Informationen zur Zahlung</b>', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'de', 22, @refusalPageType, 'Zahlung nicht ausgeführt – Technischer Fehler', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'de', 23, @refusalPageType, '', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'de', 32, @refusalPageType, 'Zahlung nicht ausgeführt – Technischer Fehler', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'de', 33, @refusalPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihr Konto wurde nicht belastet. Falls Sie den Kauf immer noch tätigen möchten, versuchen Sie es bitte erneut.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'de', 41, @refusalPageType, 'Hilfe', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'de', 175,@refusalPageType, 'Zurück zum Online Shop', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_220'), @updateState,
 'de', 220, @refusalPageType, 'Zahlung nicht ausgeführt', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_230'), @updateState,
 'de', 230, @refusalPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihr Konto wurde nicht belastet. Falls Sie Ihren Kauf trotzdem durchführen möchten, starten Sie den Zahlungsvorgang bitte von Neuem.', @maestroVID, NULL, @customItemSetREFUSAL);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'de', 1, @helpPagePageType, '<b>Hilfe</b>', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'de', 2, @helpPagePageType, 'Um die Sicherheit bei Online-Zahlungen zu erhöhen, hat die BCV ein System zur Zahlungsfreigabe durch den/die Karteninhaber/in eingerichtet. ', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'de', 3, @helpPagePageType, 'Bevor die Zahlung ausgeführt wird, muss sie zuerst in der App BCV Mobile freigegeben werden. Bei Fragen wenden Sie sich bitte direkt an die BCV.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'de', 174, @helpPagePageType, 'Hilfe schliessen', @maestroVID, NULL, @customItemSetREFUSAL);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'de', 11, @failurePagePageType, '<b>Informationen zur Zahlung</b>', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'de', 16, @failurePagePageType, 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'de', 17, @failurePagePageType, 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'de', 32, @failurePagePageType, 'Zahlung nicht ausgeführt - Technischer Fehler', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'de', 33, @failurePagePageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet.Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'de', 41, @failurePagePageType, 'Hilfe', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'de', 174, @failurePagePageType, 'Meldung schliessen', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'de', 175, @failurePagePageType, 'Zurück zum Online Shop', @maestroVID, NULL, @customItemSetREFUSAL);


/*ENGLISH translations for DEFAULT_REFUSAL*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
       'en', 1, 'ALL', @bank, @maestroVID, im.id, @customItemSetREFUSAL
FROM `Image` im WHERE im.name LIKE CONCAT('%',@bank,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
       'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'en', 1, @refusalPageType, '<b>Payment approval impossible</b>', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'en', 2, @refusalPageType, 'The payment was not completed due to a technical issue. Your account has not been debited. ', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'en', 3, @refusalPageType, 'If you still wish to make this purchase, you must start over.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'en', 11, @refusalPageType, '<b>Information about payment</b>', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'en', 22, @refusalPageType, 'Payment not completed - Technical issue', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'en', 23, @refusalPageType, '', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'en', 32, @refusalPageType, 'Payment not completed - Technical issue', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'en', 33, @refusalPageType, 'The payment was not completed due to a technical issue. Your account has not been debited. If you still wish to make this purchase, you must start over.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'en', 41, @refusalPageType, 'Help', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'en', 175,@refusalPageType, 'Back to the merchant website', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_220'), @updateState,
 'en', 220, @refusalPageType, 'The payment was not completed.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_230'), @updateState,
 'en', 230, @refusalPageType, 'The payment was not completed due to a technical issue. Your account has not been debited. If you still wish to make this purchase, you must start over.', @maestroVID, NULL, @customItemSetREFUSAL);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'en', 1, @helpPagePageType, '<b>Help</b>', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'en', 2, @helpPagePageType, 'To make your online payments more secure, BCV uses a system that requires card users to verify their identity first. ', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'en', 3, @helpPagePageType, 'Payments are therefore not executed until they are approved in BCV Mobile. Please contact BCV directly if you have any questions.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'en', 174, @helpPagePageType, 'Close help', @maestroVID, NULL, @customItemSetREFUSAL);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'en', 11, @failurePagePageType, '<b>Information about payment</b>', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'en', 16, @failurePagePageType, 'Payment not completed – card is not registered for 3-D Secure.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'en', 17, @failurePagePageType, 'The payment could not be completed because your card is not registered for 3-D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'en', 32, @failurePagePageType, 'Payment not completed – technical error', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'en', 33, @failurePagePageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'en', 41, @failurePagePageType, 'Help', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'en', 174, @failurePagePageType, 'Close message', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'en', 175, @failurePagePageType, 'Back to the online shop', @maestroVID, NULL, @customItemSetREFUSAL);

/*FRENCH translations for DEFAULT_REFUSAL*/

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
       'fr', 1, 'ALL', @bank, @maestroVID, im.id, @customItemSetREFUSAL
FROM `Image` im WHERE im.name LIKE CONCAT('%',@bank,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
       'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'fr', 1, @refusalPageType, '<b>Validation de paiement impossible</b>', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'fr', 2, @refusalPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Votre compte n''a pas été débité. ', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'fr', 3, @refusalPageType, 'Si vous souhaitez  effectuer votre achat, veuillez recommencer le processus de paiement depuis le début.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'fr', 11, @refusalPageType, '<b>Informations concernant le paiement.</b>', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'fr', 22, @refusalPageType, 'Paiement non effectué - Problème technique', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'fr', 23, @refusalPageType, '', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'fr', 32, @refusalPageType, 'Paiement non effectué - Problème technique', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'fr', 33, @refusalPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'fr', 41, @refusalPageType, 'Aide', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_175'), @updateState,
 'fr', 175,@refusalPageType, 'Retour vers la boutique en ligne', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_220'), @updateState,
 'fr', 220, @refusalPageType, 'Le paiement n''a pas été effectué. ', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@refusalPageType,'_230'), @updateState,
 'fr', 230, @refusalPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Votre compte n''a pas été débité. Si vous souhaitez  effectuer votre achat, veuillez recommencer le processus de paiement depuis le début.', @maestroVID, NULL, @customItemSetREFUSAL);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'fr', 1, @helpPagePageType, '<b>Aide</b>', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'fr', 2, @helpPagePageType, 'Afin d''augmenter la sécurité lors de vos paiements en ligne, la BCV a mis en place un système de validation par authentification du détenteur de la carte.  ', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'fr', 3, @helpPagePageType, 'Pour être exécuté, le paiement doit, au préalable, être confirmé dans l''application BCV Mobile. Pour toute question, vous pouvez prendre contact directement avec la BCV.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'fr', 174, @helpPagePageType, 'Fermer l''aide', @maestroVID, NULL, @customItemSetREFUSAL);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_11'), @updateState,
 'fr', 11, @failurePagePageType, '<b>Informations concernant le paiement.</b>', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_16'), @updateState,
 'fr', 16, @failurePagePageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_17'), @updateState,
 'fr', 17, @failurePagePageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_32'), @updateState,
 'fr', 32, @failurePagePageType, 'Paiement non effectué - Problème technique', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_33'), @updateState,
 'fr', 33, @failurePagePageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_41'), @updateState,
 'fr', 41, @failurePagePageType, 'Aide', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_174'), @updateState,
 'fr', 174, @failurePagePageType, 'Fermer le message', @maestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@refusalAuthentMean,'_',@failurePagePageType,'_175'), @updateState,
 'fr', 175, @failurePagePageType, 'Retour vers la boutique en ligne', @maestroVID, NULL, @customItemSetREFUSAL);


-- Refusal Missing Auth --

SET @customItemSetRefusalMissingAuth = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @bank, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @InfoAuthentMean = 'INFO';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
       'de', 1, 'ALL', @bank, @maestroVID, im.id, @customItemSetRefusalMissingAuth
FROM `Image` im WHERE im.name LIKE CONCAT('%',@bank,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
       'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetRefusalMissingAuth
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'de', 1, @refusalPageType, '<b>Zahlungsfreigabe nicht möglich</b>', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'de', 2, @refusalPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihr Konto wurde nicht belastet. ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'de', 3, @refusalPageType, 'Falls Sie Ihren Kauf trotzdem durchführen möchten, starten Sie den Zahlungsvorgang bitte von Neuem.', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'de', 11, @refusalPageType, '<b>Informationen zur Zahlung</b>', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'de', 22, @refusalPageType, 'Zahlung nicht ausgeführt', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'de', 23, @refusalPageType, 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihr Konto wurde nicht belastet. Falls Sie den Kauf immer noch tätigen möchten, versuchen Sie es bitte erneut.  ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'de', 32, @refusalPageType, 'Zahlung wurde nicht ausgeführt – Online-Shopping-Funktion nicht aktiviert', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'de', 33, @refusalPageType, 'Sie können die Online-Shopping-Funktion für Ihre Karte im Bereich «Karten» in BCV Mobile aktivieren. ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'de', 41, @refusalPageType, 'Hilfe', @maestroVID, NULL, @customItemSetRefusalMissingAuth);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'de', 1, @helpPagePageType, '<b>Hilfe</b>', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'de', 2, @helpPagePageType, 'Um die Sicherheit bei Online-Zahlungen zu erhöhen, hat die BCV ein System zur Zahlungsfreigabe durch den/die Karteninhaber/in eingerichtet. ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'de', 3, @helpPagePageType, 'Bevor die Zahlung ausgeführt wird, muss sie zuerst in der App BCV Mobile freigegeben werden. Bei Fragen wenden Sie sich bitte direkt an die BCV.', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'de', 174, @helpPagePageType, 'Hilfe schliessen', @maestroVID, NULL, @customItemSetRefusalMissingAuth);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
       'en', 1, 'ALL', @bank, @maestroVID, im.id, @customItemSetRefusalMissingAuth
FROM `Image` im WHERE im.name LIKE CONCAT('%',@bank,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
       'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetRefusalMissingAuth
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'en', 1, @refusalPageType, '<b>Payment approval impossible </b>', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'en', 2, @refusalPageType, 'The payment was not completed due to a technical issue. Your account has not been debited. ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'en', 3, @refusalPageType, 'If you still wish to make this purchase, you must start over.', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'en', 11, @refusalPageType, '<b>Information about payment</b>', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'en', 22, @refusalPageType, 'The payment was not completed', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'en', 23, @refusalPageType, 'The payment was not completed due to a technical issue. Your account has not been debited. If you still wish to make this purchase, you must start over.', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'en', 32, @refusalPageType, 'Payment not completed – online shopping function not activated', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'en', 33, @refusalPageType, 'Please go to the Cards section in BCV Mobile and activate the online shopping function.', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'en', 41, @refusalPageType, 'Help', @maestroVID, NULL, @customItemSetRefusalMissingAuth);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'en', 1, @helpPagePageType, '<b>Help</b>', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'en', 2, @helpPagePageType, 'To make your online payments more secure, BCV uses a system that requires card users to verify their identity first. ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'en', 3, @helpPagePageType, 'Payments are therefore not executed until they are approved in BCV Mobile. Please contact BCV directly if you have any questions.', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'en', 174, @helpPagePageType, 'Close help', @maestroVID, NULL, @customItemSetRefusalMissingAuth);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState,
       'fr', 1, 'ALL', @bank, @maestroVID, im.id, @customItemSetRefusalMissingAuth
FROM `Image` im WHERE im.name LIKE CONCAT('%',@bank,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState,
       'fr', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetRefusalMissingAuth
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_1'), @updateState,
 'fr', 1, @refusalPageType, '<b>Validation de paiement impossible</b>', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_2'), @updateState,
 'fr', 2, @refusalPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Votre compte n''a pas été débité. ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_3'), @updateState,
 'fr', 3, @refusalPageType, 'Si vous souhaitez  effectuer votre achat, veuillez recommencer le processus de paiement depuis le début.', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_11'), @updateState,
 'fr', 11, @refusalPageType, '<b>Informations concernant le paiement.</b>', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_22'), @updateState,
 'fr', 22, @refusalPageType, 'Paiement non effectué - Problème technique ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_23'), @updateState,
 'fr', 23, @refusalPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Votre compte n''a pas été débité. Si vous souhaitez  effectuer votre achat, veuillez recommencer le processus de paiement depuis le début. ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_32'), @updateState,
 'fr', 32, @refusalPageType, 'Le paiement n''a pas été effectué - La fonctionnalité e-commerce n''est pas activée  ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_33'), @updateState,
 'fr', 33, @refusalPageType, 'Veuillez vous rendre dans la section "Cartes" de BCV Mobile pour activer la fonction e-commerce. ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@refusalPageType,'_41'), @updateState,
 'fr', 41, @refusalPageType, 'Aide', @maestroVID, NULL, @customItemSetRefusalMissingAuth);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'fr', 1, @helpPagePageType, '<b>Aide</b>', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'fr', 2, @helpPagePageType, 'Afin d''augmenter la sécurité lors de vos paiements en ligne, la BCV a mis en place un système de validation par authentification du détenteur de la carte.  ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'fr', 3, @helpPagePageType, 'Pour être exécuté, le paiement doit, au préalable, être confirmé dans l''application BCV Mobile. Pour toute question, vous pouvez prendre contact directement avec la BCV.', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'fr', 174, @helpPagePageType, 'Fermer l''aide', @maestroVID, NULL, @customItemSetRefusalMissingAuth);