USE `U7G_ACS_BO`;


SET @createdBy = 'A758582';

SET @BankB = 'Kantonal';
SET @BankUB = 'ZKB';


SET @pageType = 'OTP_FORM_PAGE';
SET @customItemSetIdSms = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS_EXT'));


SET @ordinal = 2;
SET @textValue = 'Wir haben Ihnen zur Bestätigung der Zahlung einen Freigabe-Code auf Ihr Mobil-Telefon gesendet.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;

SET @textValue = 'We have sent an approval code to your mobile phone to approve the payment.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;

SET @textValue = 'Pour la confirmation du paiement, nous vous avons envoyé un code d''activation sur votre téléphone portable.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;

SET @textValue = 'Le abbiamo inviato un codice di autenticazione sul suo cellulare per confermare il pagamento.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;



SET @ordinal = 3;
SET @textValue = 'Bitte prüfen Sie die Zahlungsdetails links und bestätigen Sie die Zahlung durch Eingabe des Freigabe-Codes.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;

SET @textValue = 'Please check the payment details to the left and confirm the payment by entering the approval code.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;

SET @textValue = 'Veuillez vérifier les détails du paiement à gauche et confirmez le paiement en saisissant le code d''activation.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;

SET @textValue = 'Controlli i dettagli del pagamento a sinistra e confermi il pagamento inserendo il codice di autorizzazione.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;


SET @pageType = 'HELP_PAGE';
SET @ordinal = 2;
SET @textValue = 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat die Zürcher Kantonalbank eine zweistufige Authentifikation eingeführt. ';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;

SET @textValue = 'To increase your security when making online payments, Zürcher Kantonalbank has introduced two-factor authentication. ';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;

SET @textValue = 'Afin d’accroître votre sécurité pour le paiement en ligne, la Zürcher Kantonalbank a mis en place une authentification en deux étapes. ';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;

SET @textValue = 'Per aumentare la sicurezza nei pagamenti online, Zürcher Kantonalbank ha introdotto un''autenticazione a due livelli. ';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;



SET @ordinal = 3;
SET @textValue = 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder durch die Verifikation in der ZKB Access App oder anhand eines Freigabe-Codes per SMS bestätigen. Für diesen Service müssen Sie sich einmalig im Online Banking registrieren. Bei Fragen wenden Sie sich bitte an die Zürcher Kantonalbank.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;

SET @textValue = 'In order to be able to make a payment, you need to confirm this either by verification in the ZKB Access app or by using an approval code sent by SMS. This service requires your one-time registration in online banking. If you have any questions, please contact Zürcher Kantonalbank.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;

SET @textValue = 'Pour pouvoir effectuer un paiement, vous devez le confirmer soit par vérification dans l’application ZKB Access, soit au moyen d’un code de validation reçu par SMS. Pour accéder à ce service, vous devez vous enregistrer une seule fois dans la banque en ligne. Pour toute question, veuillez vous adresser à la Zürcher Kantonalbank.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;

SET @textValue = 'Per poter eseguire un pagamento, è necessario confermarlo tramite verifica nell''app ZKB Access o inserendo un codice di autorizzazione ricevuto via SMS. Per questo servizio è necessario registrarsi una volta nell''Online Banking. In caso di domande, è possibile rivolgersi a Zürcher Kantonalbank.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdSms;


SET @pageType = 'POLLING_PAGE';
SET @customItemSetIdApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));

SET @ordinal = 2;
SET @textValue = 'Damit die Zahlung abgeschlossen werden kann, müssen Sie diese in der ZKB Access App freigeben. Sie sollten bereits eine entsprechende Benachrichtigung auf Ihrem Mobiltelefon erhalten haben. Falls sie keine Benachrichtigung erhalten, müssen Sie ihre Einstellungen für Online bezahlen im Online Banking der Zürcher Kantonalbank anpassen.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'In order for the payment to be completed, you have to approve it in the ZKB Access app. You should already have received a notification on your mobile phone. If you do not receive a notification, you need to adjust your settings for online payments in Zürcher Kantonalbank''s online banking.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Pour pouvoir finaliser le paiement, vous devez le valider dans l’application ZKB Access. Vous devriez déjà avoir reçu une notification correspondante sur votre téléphone portable. Si vous ne recevez pas de notification, vous devez modifier vos paramètres de paiement en ligne dans la banque en ligne de la Zürcher Kantonalbank.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Per poter concludere il pagamento, è necessario autorizzarlo nell''app ZKB Access. Dovrebbe aver già ricevuto una notifica sul suo cellulare. Se non riceve alcuna notifica, deve modificare le sue impostazioni per i pagamenti online nell''Online Banking di Zürcher Kantonalbank.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;



SET @ordinal = 3;
SET @textValue = 'Sollten Sie die App zurzeit nicht nutzen können, so können Sie die Zahlung per SMS-Code bestätigen:';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'If you are currently unable to use the app, you can confirm the payment using an SMS code:';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Si vous ne pouvez pas utiliser l’application actuellement, vous pouvez confirmer le paiement avec le code reçu par SMS:';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Se al momento non le fosse possibile utilizzare l''app, può confermare il pagamento tramite codice SMS:';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;


SET @pageType = 'HELP_PAGE';
SET @ordinal = 2;
SET @textValue = 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat die Zürcher Kantonalbank eine zweistufige Authentifikation eingeführt. ';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'To increase your security when making online payments, Zürcher Kantonalbank has introduced two-factor authentication. ';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Afin d’accroître votre sécurité pour le paiement en ligne, la Zürcher Kantonalbank a mis en place une authentification en deux étapes. ';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Per aumentare la sicurezza nei pagamenti online, Zürcher Kantonalbank ha introdotto un''autenticazione a due livelli. ';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;



SET @ordinal = 3;
SET @textValue = 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder durch die Verifikation in der ZKB Access App oder anhand eines Freigabe-Codes per SMS bestätigen. Für diesen Service müssen Sie sich einmalig im Online Banking registrieren. Bei Fragen wenden Sie sich bitte an die Zürcher Kantonalbank.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'In order to be able to make a payment, you need to confirm this either by verification in the ZKB Access app or by using an approval code sent by SMS. This service requires your one-time registration in online banking. If you have any questions, please contact Zürcher Kantonalbank.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Pour pouvoir effectuer un paiement, vous devez le confirmer soit par vérification dans l’application ZKB Access, soit au moyen d’un code de validation reçu par SMS. Pour accéder à ce service, vous devez vous enregistrer une seule fois dans la banque en ligne. Pour toute question, veuillez vous adresser à la Zürcher Kantonalbank.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Per poter eseguire un pagamento, è necessario confermarlo tramite verifica nell''app ZKB Access o inserendo un codice di autorizzazione ricevuto via SMS. Per questo servizio è necessario registrarsi una volta nell''Online Banking. In caso di domande, è possibile rivolgersi a Zürcher Kantonalbank.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;



SET @pageType = 'REFUSAL_PAGE';
SET @customItemSetIdRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));

SET @ordinal = 2;
SET @textValue = 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (App oder SMS) für Ihre Karte gefunden haben. ';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;

SET @textValue = 'Unfortunately, we were unable to process your request because we could not find an approval method (app or SMS) for your card.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;

SET @textValue = 'Nous n’avons malheureusement pas pu traiter votre demande, car nous n’avons trouvé aucune méthode de validation (application ou SMS) pour votre carte. ';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;

SET @textValue = 'Purtroppo non abbiamo potuto soddisfare la sua richiesta perché non abbiamo trovato alcun metodo di autorizzazione (app o SMS) per la sua carta. ';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;



SET @ordinal = 3;
SET @textValue = 'Bitte hinterlegen Sie für Ihre Karte eine entsprechende Freigabe-Methode im Online Banking der Zürcher Kantonalbank.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;

SET @textValue = 'Please enter a corresponding approval method for your card in Zürcher Kantonalbank''s online banking.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;

SET @textValue = 'Veuillez enregistrer une méthode de validation correspondante pour votre carte dans la banque en ligne de la Zürcher Kantonalbank.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;

SET @textValue = 'La preghiamo di immettere il metodo di approvazione corrispondente alla sua carta nell''Online Banking di Zürcher Kantonalbank.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;



SET @pageType = 'HELP_PAGE';
SET @ordinal = 2;
SET @textValue = 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat die Zürcher Kantonalbank eine zweistufige Authentifikation eingeführt. ';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;

SET @textValue = 'To increase your security when making online payments, Zürcher Kantonalbank has introduced two-factor authentication. ';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;

SET @textValue = 'Afin d’accroître votre sécurité pour le paiement en ligne, la Zürcher Kantonalbank a mis en place une authentification en deux étapes. ';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;

SET @textValue = 'Per aumentare la sicurezza nei pagamenti online, Zürcher Kantonalbank ha introdotto un''autenticazione a due livelli. ';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;



SET @ordinal = 3;
SET @textValue = 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder durch die Verifikation in der ZKB Access App oder anhand eines Freigabe-Codes per SMS bestätigen. Für diesen Service müssen Sie sich einmalig im Online Banking registrieren. Bei Fragen wenden Sie sich bitte an die Zürcher Kantonalbank.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;

SET @textValue = 'In order to be able to make a payment, you need to confirm this either by verification in the ZKB Access app or by using an approval code sent by SMS. This service requires your one-time registration in online banking. If you have any questions, please contact Zürcher Kantonalbank.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;

SET @textValue = 'Pour pouvoir effectuer un paiement, vous devez le confirmer soit par vérification dans l’application ZKB Access, soit au moyen d’un code de validation reçu par SMS. Pour accéder à ce service, vous devez vous enregistrer une seule fois dans la banque en ligne. Pour toute question, veuillez vous adresser à la Zürcher Kantonalbank.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;

SET @textValue = 'Per poter eseguire un pagamento, è necessario confermarlo tramite verifica nell''app ZKB Access o inserendo un codice di autorizzazione ricevuto via SMS. Per questo servizio è necessario registrarsi una volta nell''Online Banking. In caso di domande, è possibile rivolgersi a Zürcher Kantonalbank.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusal;


SET @customItemSetIdRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'));
SET @pageType = 'HELP_PAGE';
SET @ordinal = 2;
SET @textValue = 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat die Zürcher Kantonalbank eine zweistufige Authentifikation eingeführt. ';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;

SET @textValue = 'To increase your security when making online payments, Zürcher Kantonalbank has introduced two-factor authentication. ';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;

SET @textValue = 'Afin d’accroître votre sécurité pour le paiement en ligne, la Zürcher Kantonalbank a mis en place une authentification en deux étapes. ';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;

SET @textValue = 'Per aumentare la sicurezza nei pagamenti online, Zürcher Kantonalbank ha introdotto un''autenticazione a due livelli. ';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;


SET @ordinal = 3;
SET @textValue = 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder durch die Verifikation in der ZKB Access App oder anhand eines Freigabe-Codes per SMS bestätigen. Für diesen Service müssen Sie sich einmalig im Online Banking registrieren. Bei Fragen wenden Sie sich bitte an die Zürcher Kantonalbank.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;

SET @textValue = 'In order to be able to make a payment, you need to confirm this either by verification in the ZKB Access app or by using an approval code sent by SMS. This service requires your one-time registration in online banking. If you have any questions, please contact Zürcher Kantonalbank.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;

SET @textValue = 'Pour pouvoir effectuer un paiement, vous devez le confirmer soit par vérification dans l’application ZKB Access, soit au moyen d’un code de validation reçu par SMS. Pour accéder à ce service, vous devez vous enregistrer une seule fois dans la banque en ligne. Pour toute question, veuillez vous adresser à la Zürcher Kantonalbank.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;

SET @textValue = 'Per poter eseguire un pagamento, è necessario confermarlo tramite verifica nell''app ZKB Access o inserendo un codice di autorizzazione ricevuto via SMS. Per questo servizio è necessario registrarsi una volta nell''Online Banking. In caso di domande, è possibile rivolgersi a Zürcher Kantonalbank.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;


SET @pageType = 'REFUSAL_PAGE';
SET @ordinal = 2;
SET @textValue = NULL;
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;

SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;

SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;

SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;


SET @ordinal = 3;
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;

SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;

SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;

SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalFraud;




SET @customItemSetIdRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @pageType = 'HELP_PAGE';
SET @ordinal = 2;
SET @textValue = 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat die Zürcher Kantonalbank eine zweistufige Authentifikation eingeführt. ';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalMissing;

SET @textValue = 'To increase your security when making online payments, Zürcher Kantonalbank has introduced two-factor authentication. ';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalMissing;

SET @textValue = 'Afin d’accroître votre sécurité pour le paiement en ligne, la Zürcher Kantonalbank a mis en place une authentification en deux étapes. ';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalMissing;

SET @textValue = 'Per aumentare la sicurezza nei pagamenti online, Zürcher Kantonalbank ha introdotto un''autenticazione a due livelli. ';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalMissing;


SET @ordinal = 3;
SET @textValue = 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder durch die Verifikation in der ZKB Access App oder anhand eines Freigabe-Codes per SMS bestätigen. Für diesen Service müssen Sie sich einmalig im Online Banking registrieren. Bei Fragen wenden Sie sich bitte an die Zürcher Kantonalbank.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalMissing;

SET @textValue = 'In order to be able to make a payment, you need to confirm this either by verification in the ZKB Access app or by using an approval code sent by SMS. This service requires your one-time registration in online banking. If you have any questions, please contact Zürcher Kantonalbank.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalMissing;

SET @textValue = 'Pour pouvoir effectuer un paiement, vous devez le confirmer soit par vérification dans l’application ZKB Access, soit au moyen d’un code de validation reçu par SMS. Pour accéder à ce service, vous devez vous enregistrer une seule fois dans la banque en ligne. Pour toute question, veuillez vous adresser à la Zürcher Kantonalbank.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalMissing;

SET @textValue = 'Per poter eseguire un pagamento, è necessario confermarlo tramite verifica nell''app ZKB Access o inserendo un codice di autorizzazione ricevuto via SMS. Per questo servizio è necessario registrarsi una volta nell''Online Banking. In caso di domande, è possibile rivolgersi a Zürcher Kantonalbank.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalMissing;



SET @pageType = 'REFUSAL_PAGE';

SET @ordinal = 33;
SET @textValue = 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (App oder SMS) für Ihre Karte gefunden haben. Bitte hinterlegen Sie für Ihre Karte eine entsprechende Freigabe-Methode im Online Banking der Zürcher Kantonalbank.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalMissing;

SET @textValue = 'Unfortunately, we were unable to process your request because we could not find an approval method (app or SMS) for your card. Please enter a corresponding approval method for your card in Zürcher Kantonalbank''s online banking.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalMissing;

SET @textValue = 'Nous n’avons malheureusement pas pu traiter votre demande, car nous n’avons trouvé aucune méthode de validation (application ou SMS) pour votre carte. Veuillez enregistrer une méthode de validation correspondante pour votre carte dans la banque en ligne de la Zürcher Kantonalbank.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalMissing;

SET @textValue = 'Purtroppo non abbiamo potuto soddisfare la sua richiesta perché non abbiamo trovato alcun metodo di autorizzazione (app o SMS) per la sua carta. La preghiamo di immettere il metodo di approvazione corrispondente alla sua carta nell''Online Banking di Zürcher Kantonalbank.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdRefusalMissing;



SET @pageType = 'APP_VIEW';
SET @customItemSetIdApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));

SET @ordinal = 152;
SET @textValue = 'Zur zusätzlichen Sicherheit müssen Sie die Zahlung in Ihrer ZKB Access App freigeben. Sie sollten bereits eine entsprechende Benachrichtigung auf Ihrem Mobiltelefon erhalten haben. Falls sie keine Benachrichtigung erhalten, müssen Sie ihre Einstellungen für Online bezahlen im Online Banking der Zürcher Kantonalbank anpassen.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'For additional security, you have to approve the payment in your ZKB Access app. You should already have received a notification on your mobile phone. If you do not receive a notification, you need to adjust your settings for online payments in Zürcher Kantonalbank''s online banking.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Pour plus de sécurité, vous devez valider le paiement dans votre application ZKB Access. Vous devriez déjà avoir reçu une notification correspondante sur votre téléphone portable. Si vous ne recevez pas de notification, vous devez modifier vos paramètres de paiement en ligne dans la banque en ligne de la Zürcher Kantonalbank.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Per maggiore sicurezza è necessario autorizzare il pagamento nell''app ZKB Access. Dovrebbe aver già ricevuto una notifica sul suo cellulare. Se non riceve alcuna notifica, deve modificare le sue impostazioni per i pagamenti online nell''Online Banking di Zürcher Kantonalbank.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;


SET @ordinal = 157;
SET @textValue = 'Ihre Kartenzahlung muss mit 3-D Secure bestätigt werden.\n \n Nähere Informationen finden Sie im Online Banking.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Your payment has to be approved with 3-D Secure.\n \n Further information can be found in your online banking.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Veuillez contacter votre banque pour plus de support.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;

SET @textValue = 'Contatti la sua banca per ottenere ulteriore supporto.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @pageType AND locale = @local AND fk_id_customItemSet = @customItemSetIdApp;



SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS OTP Form Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '
<style>
	div#optGblPage {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 14px;
	}
	#optGblPage .warn {
		background-color: #3399ff
	}
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
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
		color: #ffffff !important;
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
		font-size: 12px;
	}
	.paragraphDescription {
		text-align: left;
	}
	.paragraphDescription {
		text-align: left;
	}
	.leftColumn {
		width: 40%;
		display: block;
		float: left;
		padding-top: 1.5em;
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
		padding-top: 0.5em;
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
	#otp-form {
		display: inline-block;
		padding-top: 12px;
	}
	#otp-form input {
		box-sizing: content-box;
		padding: 5px 10px 3px;
		background-color: #fff;
		border: 1px solid rgba(0, 0, 0, .2);
		border-radius: 2px;
		box-shadow: inset 1px 1px 0 0 rgba(0, 0, 0, .1);
		font: 300 18px "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 1.8rem;
		line-height: 25px;
		min-height: 35px;
	}
	#otp-form input:disabled {
		color: #bebebe !important;
		background-color: #dcdcdc !important;
		border-color: rgba(0, 0, 0, .05) !important;
		box-shadow: none !important;
	}
	#otp-form input:focus {
		border-color: #ff6a10 !important;
		outline-color: #ff6a10;
	}
	div#otp-fields-container {
		width: 100%;
		text-align: left;
		margin-bottom: 10px;
	}
	div#otp-fields {
		display: inline-block;
	}
	div#otp-form div.tooltips {
		background: #545454;
	}
	div#otp-form div.tooltips span {
		background: #545454;
		bottom: 40px;
	}
	div#otp-form div.tooltips span:after {
		border-top: 8px solid #545454;
	}
	#reSendOtp > button {
		background: none !important;
		color: #000000;
		border: none;
		padding: 0 !important;
		font: inherit;
		cursor: pointer;
		font-family: Arial, regular;
		font-size: 12px;
	}
	#reSendOtp > button:disabled {
		background: none !important;
		color: #000000;
		border: none;
		padding: 0 !important;
		font: inherit;
		cursor: not-allowed;
		font-family: Arial, regular;
		font-size: 12px;
	}
	#validateButton {
		display: inline-block;
		padding-top: 10px;
		margin-left: 1em;
		border-radius: 20px;
	}
	#validateButton button {
		display: inline-block;
		font-family: "Arial", Helvetica, Arial, sans-serif;
		font-size: 14px;
		border-radius: 20px;
		color: #ffffff;
		background: #449d44;
		padding: 10px 30px 10px 20px;
		border: solid #449d44 1px;
		text-decoration: none;
		min-width: 150px;
	}
	#validateButton button:disabled {
		display: inline-block;
		font-family: "Arial", Helvetica, Arial, sans-serif;
		font-size: 14px;
		border-radius: 20px;
		color: #000;
		background: #fff;
		border-color: #dcdcdc;
		padding: 10px 30px 10px 20px;
		border: solid #000 1px;
		text-decoration: none;
		min-width: 150px;
	}
	#validateButton > button > span {
		display: inline-block;
		float: left;
		margin-top: 3px;
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
		margin: 5px;
	}
	#cancelButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #4e4e4e;
		color: #ffffff;
		border: 1px solid #4e4e4e;
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
		margin: 5px;
	}
	#validateButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
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
	div#footer {
		height: 50px;
	}
	#footer {
		padding-bottom: 12px;
		width: 100%;
		background-color: #ada398;
		text-align: center;
	}
	#footer #cancelButton button span.fa {
		background-image: url(data:image/png;base64,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);
		width: 24px;
		height: 26px;
		background-position-y: 1px;
		background-size: contain;
		display: inline-block;
		margin-left: 3px;
	}
	#footer #helpButton button span:before {
		content: '''';
	}
	#footer #cancelButton button span:before {
		content: '''';
	}
	#footer #helpButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-position-y: -1px;
		background-size: 115%;
		display: inline-block;
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
	@media all and (max-width: 1610px) {
		#pageHeader {height: 96px;}
		.leftColumn { padding-bottom: 10em; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left;}
		 #footer {text-align: inherit;}
	}
	@media all and (max-width: 1278px) and (min-width: 701px) {
		#pageHeader {height: 80px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left; }
	}
	@media all and (max-width: 700px) and (min-width: 601px) {
		#pageHeader {height: 80px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		span.ng-binding { word-break: break-word; }
		.rightColumn { display: block; float: none; width: 100%; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left;}
		 #footer {text-align: center;}
	}
	@media all and (max-width: 600px) and (min-width: 501px) {
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		span.ng-binding { word-break: break-word; }
		.contentRow { padding-top: 0px; }
		.rightColumn { display: block; float: none; width: 50%; margin-left: 50%; padding: 5px 0px}
		.leftColumn { width: 50%; padding-top: 5px;}
		.paragraph { text-align: left; margin-bottom: 5px; }
		.paragraphDescription {text-align: left;}
		div#otp-fields-container { margin-bottom: 5px;}
		#validateButton {margin-left: 0em;}
		#footer { margin-top: 0px; display: inline-block; }
	}
	 @media all and (max-width: 500px) and (min-width: 481px) {
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		span.ng-binding { word-break: break-word; }
		.contentRow { padding-top: 0px; }
		.leftColumn { display: block; float: none; width: 100%; padding-top: 0.5em; padding-bottom: 0em; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0%; padding: 0px; }
		.paragraph { text-align: center; margin-bottom: 5px;}
		.paragraphDescription {text-align: center;}
		div#otp-fields-container { margin-top: 0px; margin-bottom: 5px; text-align: center;}
		#validateButton {margin-left: 0em;}
		.refreshDiv { margin-left: 2%;}
		#footer { height: 60px;  margin-bottom: 5px;  margin-top: 0px;}
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
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 0em; padding-top: 0em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 0px; padding: 0px 10px;}
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; padding: 0px; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 180px; margin-left: auto; margin-right: auto;}
		#validateButton button { width: 100%; }
	}
	@media all and (max-width: 391px) {
		h1 { font-size: 24px; }
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		#optGblPage { font-size: 14px; }
		div#green-banner { display: none; }
		span.ng-binding { word-break: break-word; }
		.contentRow { padding-top: 0px}
		.paragraph { text-align: center; margin-bottom: 5px;}
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-top: 0.5em; padding-bottom: 0em; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; padding: 0px 10px; }
		div#otp-fields-container { margin-top: 0px; margin-bottom: 5px;}
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 180px; margin-left: auto; margin-right: auto; padding-top: 5px; }
		#validateButton button { width: 100%; }
		#footer { height: 44px; margin-top: 0px; margin-bottom: 0px;}
	}
	@media all and (max-width: 250px) {
		div#green-banner { display: none; }
		span.ng-binding { word-break: break-word; }
		.contentRow { font-size: 10px; }
		.leftColumn { display: block; float: none; width: 100%; padding-top: 2px; }
		.rightColumn { margin-top: 0px; }
		#otp-form { display: block; width: 160px; margin-left: 25px; margin-right: auto; padding-top: 2px; }
		#otp-form input { min-height: 25px; }
		div#footer { height: 90px; }
		#cancelButton button { height: 35px; min-width: 1rem;}
		#helpButton button { height: 35px; min-width: 1rem;}
		#cancelButton button custom-text { vertical-align: 10px;}
		#helpButton button custom-text { vertical-align: 10px;}
		#footer #cancelButton button span.fa {background-position-y: -1px;}
		#footer #helpButton button span.fa {background-position-y: -3px;}
		button.btn.btn-default { width: 160px;}
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

		<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

		<div id="i18n-container" class="text-center">
			<div id="i18n-inner">
				<i18n></i18n>
			</div>
		</div>
		<div id="displayLayout" class="row">
			<div id="green-banner"></div>
		</div>
		<div class="contentRow">
			<div x-ms-format-detection="none" class="leftColumn">
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
				<div id="otp-fields-container">
					<div x-ms-format-detection="none" id="otp-fields">
						<otp-form></otp-form>
					</div>
				</div>
				<div class="paragraph">
					<div class="refreshDiv">
						<span class="fa fa-life-ring" aria-hidden="true"></span>
						<re-Send-Otp id="reSendOtp" rso-Label="''network_means_pageType_19''"></re-Send-Otp>
					</div>
					<val-button val-label="''network_means_pageType_42''" id="validateButton" ></val-button>
				</div>
			</div>
		</div>
		<div id="footer">
			<div ng-style="style" class="style">
				<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
				<help help-label="''network_means_pageType_41''" id="helpButton"></help>
			</div>
		</div>
</div>
' WHERE `fk_id_layout` = @id_layout;