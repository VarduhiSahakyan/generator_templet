USE `U7G_ACS_BO`;
SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @createdBy = 'A757435';


SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = '58810');
SET @BankUB = 'NAB';

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));

SET @currentAuthentMean = 'REFUSAL';
SET @language = 'de';

SET @currentPageType = 'REFUSAL_PAGE';
UPDATE `CustomItem` SET `value` = 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (SMS oder App) für Ihre Karte gefunden haben. Bitte hinterlegen Sie für Ihre Karte eine '
    WHERE `fk_id_customItemSet` = @customItemSetREFUSAL and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
     @language, 3, @currentPageType, 'entsprechende Freigabe-Methode im Enrollment Portal gemäss der Anleitung Ihrer Bank.', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @currentPageType = 'HELP_PAGE';
UPDATE `CustomItem` SET `value` = 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank eine zwei-stufige Authetifikation eingeführt. Um eine Zahlung ausführen zu können, '
    WHERE `fk_id_customItemSet` = @customItemSetREFUSAL and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
     @language, 3, @currentPageType, 'entsprechende Freigabe-Methode im Enrollment Portal gemäss der Anleitung Ihrer Bank.', @MaestroMID, NULL, @customItemSetREFUSAL);

/*ENGLISH translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
SET @language = 'en';
UPDATE `CustomItem` SET `value` = 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. Please set up a corresponding approval method '
    WHERE `fk_id_customItemSet` = @customItemSetREFUSAL and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         @language, 3, @currentPageType, 'for your card on the enrollment portal according to your bank''s instructions.', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @currentPageType = 'HELP_PAGE';
UPDATE `CustomItem` SET `value` = 'To boost security while paying online, your bank has introduced two-level authentification. To complete a payment,'
    WHERE `fk_id_customItemSet` = @customItemSetREFUSAL and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'you must confirm it either by means of an approval code per SMS, or through verification of your identity with a mobile authentication app. You need to register once for this service. Contact your bank for the corresponding registration process or changes to your authentification method.', @MaestroMID, NULL, @customItemSetREFUSAL);

/*FRENCH translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
SET @language = 'fr';
UPDATE `CustomItem` SET `value` = 'Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte.'
    WHERE `fk_id_customItemSet` = @customItemSetREFUSAL and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         @language, 3, @currentPageType, 'Veuillez consigner une méthode d''activation pour votre carte dans le portail d''Enrollment, conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @currentPageType = 'HELP_PAGE';
UPDATE `CustomItem` SET `value` = 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes.'
    WHERE `fk_id_customItemSet` = @customItemSetREFUSAL and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'Afin de pouvoir effectuer un paiement, vous devez le confirmer soit au moyen d''un code d''activation par SMS, soit par la vérification de votre personne sur une App d''authentification mobile. Pour ce service, vous devez vous enregistrer une fois. Pour la procédure d''enregistrement correspondante, ou pour les modifications de votre méthode d''authentification, veuillez vous adresser à votre banque.', @MaestroMID, NULL, @customItemSetREFUSAL);

/*Italian translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
SET @language = 'it';
UPDATE `CustomItem` SET `value` = 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta. Stabilisca un metodo di autenticazione corrispondente per '
    WHERE `fk_id_customItemSet` = @customItemSetREFUSAL and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         @language, 3, @currentPageType, 'la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @currentPageType = 'HELP_PAGE';
UPDATE `CustomItem` SET `value` = 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi.'
    WHERE `fk_id_customItemSet` = @customItemSetREFUSAL and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'Per poter effettuare un pagamento, deve confermarlo utilizzando un codice di autenticazione tramite SMS o verificando la sua persona su un’app di autenticazione mobile. Deve effettuare una volta la registrazione per questo servizio. Si rivolga alla sua banca per il processo di registrazione corrispondente o per modifiche al metodo di autenticazione.', @MaestroMID, NULL, @customItemSetREFUSAL);


SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @language = 'de';
SET @currentPageType = 'OTP_FORM_PAGE';
UPDATE `CustomItem` SET `value` = 'Wir haben Ihnen zur Bestätigung der Zahlung einen Freigabe-Code auf Ihr Mobil-Telefon gesendet. Bitte prüfen Sie die Zahlungsdetails links und bestätigen'
    WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'Sie die Zahlung durch Eingabe des Freigabe-Codes.', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'HELP_PAGE';
UPDATE `CustomItem` SET `value` = 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank eine zwei-stufige Authetifikation eingeführt. Um eine Zahlung freizugeben,'
    WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'bestätigen Sie diese mit einem Freigabe-Code, welchen Sie per SMS erhalten. Bei jedem Kauf wird Ihnen per SMS ein neuer, einmaliger Code an die von Ihnen registrierte Telefonnummer gesendet. Für Änderungen Ihrer Telefonnummer, oder anderen Fragen zum Online-Einkauf mit Ihrer Karte, wenden Sie sich bitte an Ihre Bank.', @MaestroMID, NULL, @customItemSetSMS);


SET @currentPageType = 'REFUSAL_PAGE';
UPDATE `CustomItem` SET `value` = 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (SMS oder App) für Ihre Karte gefunden haben. Bitte hinterlegen Sie für Ihre Karte eine '
    WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'entsprechende Freigabe-Methode im Enrollment Portal gemäss der Anleitung Ihrer Bank.', @MaestroMID, NULL, @customItemSetSMS);

/*ENGLISH translations for OTP_SMS*/
SET @language = 'en';
SET @currentPageType = 'OTP_FORM_PAGE';
UPDATE `CustomItem` SET `value` = 'We have sent an approval code to your mobile phone to confirm the payment. Please check the payment details to the left '
    WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'and confirm the payment by entering the approval code.', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'HELP_PAGE';
UPDATE `CustomItem` SET `value` = 'To boost security while paying online, your bank has introduced two-level authentification. To approve a payment,'
    WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'please confirm it with the approval code you receive via SMS. For each purchase an SMS is sent to you with a new one-time code at the telephone number you registered. For changes to your telephone number, or other questions about online shopping with you card, please contact your bank.', @MaestroMID, NULL, @customItemSetSMS);


SET @currentPageType = 'REFUSAL_PAGE';
UPDATE `CustomItem` SET `value` = 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. Please set up a corresponding approval method '
    WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'for your card on the enrollment portal according to your bank''s instructions.', @MaestroMID, NULL, @customItemSetSMS);

/*FRENCH translations for OTP_SMS*/
SET @language = 'fr';
SET @currentPageType = 'OTP_FORM_PAGE';
UPDATE `CustomItem` SET `value` = 'Pour la confirmation du paiement, nous vous avons envoyé un code d''activation sur votre téléphone portable. Veuillez vérifier les détails du paiement '
    WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'à gauche et confirmez le paiement en saisissant le code d''activation.', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'HELP_PAGE';
UPDATE `CustomItem` SET `value` = 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes.'
    WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'Afin d''activer un paiement, confirmez celui-ci avec un code d''activation que vous avez reçu par SMS. Lors de chaque achat, un nouveau code unique vous sera envoyé par SMS au numéro de téléphone que vous avez enregistré. Pour modifier votre numéro de téléphone ou pour toute autre question concernant les achats en ligne avec votre carte, veuillez vous adresser à votre banque.', @MaestroMID, NULL, @customItemSetSMS);


SET @currentPageType = 'REFUSAL_PAGE';
UPDATE `CustomItem` SET `value` = 'Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte. Veuillez consigner une méthode d''activation pour votre '
    WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'carte dans le portail d''Enrollment, conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetSMS);

/*ITALIAN translations for OTP_SMS*/
SET @language = 'it';
SET @currentPageType = 'OTP_FORM_PAGE';
UPDATE `CustomItem` SET `value` = 'Le abbiamo inviato un codice di autenticazione sul suo cellulare per confermare il pagamento. Controlli i dettagli del pagamento a sinistra '
    WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'e confermi il pagamento inserendo il codice di autorizzazione.', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'HELP_PAGE';
UPDATE `CustomItem` SET `value` = 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi.'
    WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'Per autorizzare un pagamento, lo confermi con un codice di autenticazione che riceverà tramite SMS. A ogni acquisto le verrà inviato tramite SMS un nuovo codice univoco al numero di telefono da lei registrato. Si rivolga alla sua banca per modificare il suo numero di telefono o per altre domande sugli acquisti online con la sua carta.', @MaestroMID, NULL, @customItemSetSMS);


SET @currentPageType = 'REFUSAL_PAGE';
UPDATE `CustomItem` SET `value` = 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta. Stabilisca un metodo di autenticazione corrispondente per '
    WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetSMS);


SET @currentAuthentMean = 'MOBILE_APP';
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @updateState = 'PUSHED_TO_CONFIG';
SET @currentPageType = 'POLLING_PAGE';
SET @language = 'de';

UPDATE `CustomItem` SET `value` = 'Damit die Zahlung abgeschlossen werden kann, müssen Sie diese in der von Ihrer Bank zur Vergfügung '
    WHERE `fk_id_customItemSet` = @customItemSetMobileApp and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'gestellten App freigeben. Sie sollten bereits eine entsprechende Benachrichtigung auf Ihrem Mobil-Telefon erhalten haben. Andernfalls können Sie direkt in die App einsteigen und die Zahlung dort verifizieren.', @MaestroMID, NULL, @customItemSetMobileApp);

SET @currentPageType = 'HELP_PAGE';
UPDATE `CustomItem` SET `value` = 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank ein zwei-stufiges Authentifikationsverfahren eingeführt. Sie können Online-Zahlungen '
    WHERE `fk_id_customItemSet` = @customItemSetMobileApp and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'auf Ihrem Mobil-Telefon in der von Ihrer Bank zur Verfügung gestellten Authentifikations-App freigeben. Bei Fragen oder Unklarheiten wenden Sie sich bitte an Ihre Bank.', @MaestroMID, NULL, @customItemSetMobileApp);

/*ENGLISH translations for MOBILE_APP*/
SET @language = 'en';
SET @currentPageType = 'POLLING_PAGE';
UPDATE `CustomItem` SET `value` = 'To complete the payment, you must confirm it in the app provided by your bank. You should already have received a corresponding message on your mobile phone. Otherwise, '
    WHERE `fk_id_customItemSet` = @customItemSetMobileApp and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'you can open the app directly and confirm the payment there.', @MaestroMID, NULL, @customItemSetMobileApp);

SET @currentPageType = 'HELP_PAGE';
UPDATE `CustomItem` SET `value` = 'To boost security while paying online, your bank has introduced two-level authentification. '
    WHERE `fk_id_customItemSet` = @customItemSetMobileApp and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'You can approve online payments on your mobile telephone in the app provided by your bank. If you have questions, please contact your bank directly.', @MaestroMID, NULL, @customItemSetMobileApp);

/*FRENCH translations for MOBILE_APP*/
SET @language = 'fr';
SET @currentPageType = 'POLLING_PAGE';
UPDATE `CustomItem` SET `value` = 'Pour que le paiement puisse être terminé, vous devez l''activer dans l''App mise à disposition par votre banque. Vous devriez déjà avoir reçu un message correspondant sur votre téléphone portable.'
    WHERE `fk_id_customItemSet` = @customItemSetMobileApp and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'Dans le cas contraire, vous pouvez aller directement dans votre App et y vérifier le paiement.', @MaestroMID, NULL, @customItemSetMobileApp);

SET @currentPageType = 'HELP_PAGE';
UPDATE `CustomItem` SET `value` = 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes.'
    WHERE `fk_id_customItemSet` = @customItemSetMobileApp and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'Afin d''activer un paiement, confirmez celui-ci avec un code d''activation que vous avez reçu par SMS. Lors de chaque achat, un nouveau code unique vous sera envoyé par SMS au numéro de téléphone que vous avez enregistré. Pour modifier votre numéro de téléphone ou pour toute autre question concernant les achats en ligne avec votre carte, veuillez vous adresser à votre banque.', @MaestroMID, NULL, @customItemSetMobileApp);

/*ITALIAN translations for MOBILE_APP*/
SET @language = 'it';
SET @currentPageType = 'POLLING_PAGE';
UPDATE `CustomItem` SET `value` = 'Per poter completare il pagamento, è necessario autorizzarlo nell’app fornita sua banca.  Dovrebbe aver già ricevuto una notifica sul suo cellulare.  In caso contrario può accedere direttamente all''app e verificare il pagamento lì.'
    WHERE `fk_id_customItemSet` = @customItemSetMobileApp and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'Al posto di questo, richiedere l’autorizzazione tramite SMS', @MaestroMID, NULL, @customItemSetMobileApp);

SET @currentPageType = 'HELP_PAGE';
UPDATE `CustomItem` SET `value` = 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi.'
    WHERE `fk_id_customItemSet` = @customItemSetMobileApp and `pageTypes` = @currentPageType and locale = @language and `ordinal` = 2 ;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUE
    ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
        @language, 3, @currentPageType, 'Può autorizzare i pagamenti online sul suo cellulare nell’app di autenticazione fornita dalla sua banca. In caso di domande o chiarimenti, la preghiamo di contattare la sua banca.', @MaestroMID, NULL, @customItemSetMobileApp);

