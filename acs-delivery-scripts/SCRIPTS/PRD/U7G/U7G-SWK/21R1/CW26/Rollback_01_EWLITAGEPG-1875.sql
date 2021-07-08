USE `U7G_ACS_BO`;

-- Refusal --
SET @customItemSetDefaultRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_DEFAULT_REFUSAL');

SET @pageRefusal = 'REFUSAL_PAGE';

UPDATE `CustomItem` SET value = 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert '
WHERE locale = 'de' and  `ordinal` = 22 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.'
WHERE locale = 'de' and  `ordinal` = 23 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;

UPDATE `CustomItem` SET value = 'Payment not completed – card is not registered for 3D Secure.'
WHERE locale = 'en' and  `ordinal` = 22 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.'
WHERE locale = 'en' and  `ordinal` = 23 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;

UPDATE `CustomItem` SET value = 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure '
WHERE locale = 'fr' and  `ordinal` = 22 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.'
WHERE locale = 'fr' and  `ordinal` = 23 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;

UPDATE `CustomItem` SET value = 'Pagamento non eseguito - La carta non è registrata per 3D Secure'
WHERE locale = 'it' and  `ordinal` = 22 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.'
WHERE locale = 'it' and  `ordinal` = 23 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;


SET @pageHelp = 'HELP_PAGE';

UPDATE `CustomItem` SET value = 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank eine zwei-stufige Authentifikation eingeführt. '
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pageHelp  and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'Um eine Zahlung ausführen zu können, müssen Sie diese entweder anhand eines Freigabe-Codes per SMS, oder durch die Verifikation Ihrer Person auf einer Mobile Authentifikations-App bestätigen. Für diesen Service müssen Sie sich einmalig registrieren. Für den entsprechenden Registrierungsprozess, oder Änderungen Ihrer Authentifikationsmethode, wenden Sie sich bitte an Ihre Bank. '
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetDefaultRefusal;

UPDATE `CustomItem` SET value = 'To boost security while paying online, your bank has introduced two-level authentification. '
WHERE locale = 'en' and  `ordinal` = 2 and pageTypes = @pageHelp  and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'To complete a payment, you must confirm it either by means of an approval code per SMS, or through verification of your identity with a mobile authentication app. You need to register once for this service. Contact your bank for the corresponding registration process or changes to your authentification method.'
WHERE locale = 'en' and  `ordinal` = 3 and pageTypes = @pageHelp  and fk_id_customItemSet = @customItemSetDefaultRefusal;

UPDATE `CustomItem` SET value = 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes. '
WHERE locale = 'fr' and  `ordinal` = 2 and pageTypes = @pageHelp  and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'Afin de pouvoir effectuer un paiement, vous devez le confirmer soit au moyen d''un code d''activation par SMS, soit par la vérification de votre personne sur une App d''authentification mobile. Pour ce service, vous devez vous enregistrer une fois. Pour la procédure d''enregistrement correspondante, ou pour les modifications de votre méthode d''authentification, veuillez vous adresser à votre banque.'
WHERE locale = 'fr' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetDefaultRefusal;

UPDATE `CustomItem` SET value = 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi.  '
WHERE locale = 'it' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'Per poter effettuare un pagamento, deve confermarlo utilizzando un codice di autenticazione tramite SMS o verificando la sua persona su un’app di autenticazione mobile. Deve effettuare una volta la registrazione per questo servizio. Si rivolga alla sua banca per il processo di registrazione corrispondente o per modifiche al metodo di autenticazione. '
WHERE locale = 'it' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetDefaultRefusal;

-- Technical error --
SET @pageFailure = 'FAILURE_PAGE';
UPDATE `CustomItem` SET value = 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen. '
WHERE locale = 'de' and  `ordinal` = 33 and pageTypes = @pageFailure and fk_id_customItemSet = @customItemSetDefaultRefusal;
SET @pageFailure = 'REFUSAL_PAGE';
UPDATE `CustomItem` SET value = 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen. '
WHERE locale = 'de' and  `ordinal` = 33 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;

-- Refusal Fraud --
SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_REFUSAL_FRAUD');

SET @pageRefusal = 'REFUSAL_PAGE';
UPDATE `CustomItem` SET value = 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert'
WHERE locale = 'de' and  `ordinal` = 22 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren. '
WHERE locale = 'de' and  `ordinal` = 23 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'Payment not completed – card is not registered for 3D Secure.'
WHERE locale = 'en' and  `ordinal` = 22 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.  '
WHERE locale = 'en' and  `ordinal` = 23 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure '
WHERE locale = 'fr' and  `ordinal` = 22 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.  '
WHERE locale = 'fr' and  `ordinal` = 23 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'Pagamento non eseguito - La carta non è registrata per 3D Secure'
WHERE locale = 'it' and  `ordinal` = 22 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca. '
WHERE locale = 'it' and  `ordinal` = 23 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;


-- PWD --
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_PASSWORD');

SET @pageOTP = 'OTP_FORM_PAGE';

UPDATE `CustomItem` SET value = '<b>Passwort-Freigabe der Zahlung</b>'
WHERE locale = 'de' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = '<b>Password approval of the  payment</b>'
WHERE locale = 'en' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = '<b>Mot de passe - Activation de paiement</b>'
WHERE locale = 'fr' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = '<b>Autorizzazione password per il pagamento</b>'
WHERE locale = 'it' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

SET @pageHelp = 'HELP_PAGE';

UPDATE `CustomItem` SET value = 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank eine zwei-stufige Authentifikation eingeführt. '
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Um eine Zahlung freizugeben bestätigen Sie diese mit Ihrem Passwort, welches Sie Bei der Registrierung des Services definiert haben. Für Änderungen Ihres Passworts, oder anderen Fragen zum Online-Einkauf mit Ihrer Karte wenden Sie sich an Ihre Bank.'
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Hilfe schließen'
WHERE locale = 'de' and  `ordinal` = 174 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetPassword;

-- PWD processing --
SET @pageOTP = 'OTP_FORM_PAGE';

UPDATE `CustomItem` SET value = 'Zahlungsfreigabe wird geprüft'
WHERE locale = 'de' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Payment approval is being verified'
WHERE locale = 'en' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'L''activation de paiement va être vérifiée'
WHERE locale = 'fr' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'L’autorizzazione di pagamento viene controllata'
WHERE locale = 'it' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;


-- PWD success --
UPDATE `CustomItem` SET value = 'Zahlungsfreigabe war erfolgreich '
WHERE locale = 'de' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum Händler weitergeleitet. '
WHERE locale = 'de' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'Successful payment approval '
WHERE locale = 'en' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'You have successfully approved the payment and will be automatically routed back to the merchant. '
WHERE locale = 'en' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'L’activation du paiement a réussi '
WHERE locale = 'fr' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant. '
WHERE locale = 'fr' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'L’autorizzazione di pagamento è andata a buon fine '
WHERE locale = 'it' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante. '
WHERE locale = 'it' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

-- PWD cancel --
UPDATE `CustomItem` SET value = 'Zahlungsfreigabe abgebrochen '
WHERE locale = 'de' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess trotzdem fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut. '
WHERE locale = 'de' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'Payment approval cancelled '
WHERE locale = 'en' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the payment process, please start the payment attempt again. '
WHERE locale = 'en' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'Activation de paiement interrompue'
WHERE locale = 'fr' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement. '
WHERE locale = 'fr' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'Autorizzazione di pagamento annullata '
WHERE locale = 'it' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento. '
WHERE locale = 'it' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

-- PWD technical error --
UPDATE `CustomItem` SET value = 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.'
WHERE locale = 'de' and  `ordinal` = 33 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
SET @pageFailure = 'FAILURE_PAGE';
UPDATE `CustomItem` SET value = 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.'
WHERE locale = 'de' and  `ordinal` = 33 and pageTypes = @pageFailure and fk_id_customItemSet = @customItemSetPassword;

-- PWD timeout --
UPDATE `CustomItem` SET value = 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zurück zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung tätigen wollen.'
WHERE locale = 'de' and  `ordinal` = 31 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

-- PWD invalid --
UPDATE `CustomItem` SET value = 'Das eingegebene Passwort oder Eingabe-Code ist nicht korrekt. Bitte versuchen Sie es erneut.'
WHERE locale = 'de' and  `ordinal` = 29 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'The entered password or approval code is incorrect. Please try again.'
WHERE locale = 'en' and  `ordinal` = 29 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Le mot de passe ou le code d''activation saisi est incorrect. Veuillez réessayer.'
WHERE locale = 'fr' and  `ordinal` = 29 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'La password o il codice di autenticazione inseriti non sono corretti. Per favore riprova.'
WHERE locale = 'it' and  `ordinal` = 29 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;


-- SMS --

SET @customItemSetSMSOverride = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_SMS_OVERRIDE');
SET @customItemSetSMSEXT = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_SMS');

SET @pageOTP = 'OTP_FORM_PAGE';
UPDATE `CustomItem` SET value = '<b>SMS-Freigabe der Zahlung</b>'
WHERE locale = 'de' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Wir haben Ihnen zur Bestätigung der Zahlung einen Freigabe-Code auf Ihr Mobil-Telefon gesendet.  '
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Bitte prüfen Sie die Zahlungsdetails links und bestätigen Sie die Zahlung durch Eingabe des Freigabe-Codes.'
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Neuen Freigabe-Code anfordern'
WHERE locale = 'de' and  `ordinal` = 19 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Freigeben'
WHERE locale = 'de' and  `ordinal` = 42 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = '<b><b>SMS approval of the payment</b></b>'
WHERE locale = 'en' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'We have sent an approval code to your mobile phone to approve the payment.  '
WHERE locale = 'en' and  `ordinal` = 2 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Please check the payment details to the left and confirm the payment by entering the approval code.'
WHERE locale = 'en' and  `ordinal` = 3 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Request new approval code'
WHERE locale = 'en' and  `ordinal` = 19 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Approve'
WHERE locale = 'en' and  `ordinal` = 42 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = '<b><b>SMS - Activation du paiement</b></b>'
WHERE locale = 'fr' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Pour la confirmation du paiement, nous vous avons envoyé un code d''activation sur votre téléphone portable.  '
WHERE locale = 'fr' and  `ordinal` = 2 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Veuillez vérifier les détails du paiement à gauche et confirmez le paiement en saisissant le code d''activation.'
WHERE locale = 'fr' and  `ordinal` = 3 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Demander un nouveau code d''activation'
WHERE locale = 'fr' and  `ordinal` = 19 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Activer'
WHERE locale = 'fr' and  `ordinal` = 42 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = '<b>Autorizzazione del pagamento via SMS</b>'
WHERE locale = 'it' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Le abbiamo inviato un codice di autenticazione sul suo cellulare per confermare il pagamento.   '
WHERE locale = 'it' and  `ordinal` = 2 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Controlli i dettagli del pagamento a sinistra e confermi il pagamento inserendo il codice di autorizzazione.'
WHERE locale = 'it' and  `ordinal` = 3 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Richiede un nuovo codice di autenticazione'
WHERE locale = 'it' and  `ordinal` = 19 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Autorizzare'
WHERE locale = 'it' and  `ordinal` = 42 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

SET @pageHelp = 'HELP_PAGE';
UPDATE `CustomItem` SET value = 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank eine zwei-stufige Authetifikation eingeführt.  '
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Um eine Zahlung freizugeben, bestätigen Sie diese mit einem Freigabe-Code, welchen Sie per SMS erhalten. Bei jedem Kauf wird Ihnen per SMS ein neuer, einmaliger Code an die von Ihnen registrierte Telefonnummer gesendet. Für Änderungen Ihrer Telefonnummer, oder anderen Fragen zum Online-Einkauf mit Ihrer Karte, wenden Sie sich bitte an Ihre Bank.'
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Hilfe-Text schliessen'
WHERE locale = 'de' and  `ordinal` = 174 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'To boost security while paying online, your bank has introduced two-level authentification.  '
WHERE locale = 'en' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'To approve a payment, please confirm it with the approval code you receive via SMS. For each purchase an SMS is sent to you with a new one-time code at the telephone number you registered. For changes to your telephone number, or other questions about online shopping with you card, please contact your bank.'
WHERE locale = 'en' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes.  '
WHERE locale = 'fr' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Afin d''activer un paiement, confirmez celui-ci avec un code d''activation que vous avez reçu par SMS. Lors de chaque achat, un nouveau code unique vous sera envoyé par SMS au numéro de téléphone que vous avez enregistré. Pour modifier votre numéro de téléphone ou pour toute autre question concernant les achats en ligne avec votre carte, veuillez vous adresser à votre banque.'
WHERE locale = 'fr' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi.  '
WHERE locale = 'it' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Per autorizzare un pagamento, lo confermi con un codice di autenticazione che riceverà tramite SMS. A ogni acquisto le verrà inviato tramite SMS un nuovo codice univoco al numero di telefono da lei registrato. Si rivolga alla sua banca per modificare il suo numero di telefono o per altre domande sugli acquisti online con la sua carta.'
WHERE locale = 'it' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS Fallback --
DELETE from CustomItem where fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT ) and ordinal in (51, 52);

-- SMS Processing --
UPDATE `CustomItem` SET value = 'Zahlungsfreigabe wird geprüft'
WHERE locale = 'de' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung. '
WHERE locale = 'de' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Payment approval is being verified'
WHERE locale = 'en' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Please be patient. We are verifying your payment approval and thereby the authentication for the requested payment. '
WHERE locale = 'en' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'L''activation de paiement va être vérifiée'
WHERE locale = 'fr' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité. '
WHERE locale = 'fr' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'L’autorizzazione di pagamento viene controllata'
WHERE locale = 'it' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.  '
WHERE locale = 'it' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS Resend --
UPDATE `CustomItem` SET value = 'SMS-Code wird versendet'
WHERE locale = 'de' and  `ordinal` = 34 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie einen neuen Bestätigungscode an Ihre Mobilnummer für Sicherheitsnachrichten. '
WHERE locale = 'de' and  `ordinal` = 35 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'SMS code sent'
WHERE locale = 'en' and  `ordinal` = 34 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Please wait, this may take a moment. A new confirmation code for security messages will be sent to your mobile phone. '
WHERE locale = 'en' and  `ordinal` = 35 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Vous allez recevoir un code par SMS'
WHERE locale = 'fr' and  `ordinal` = 34 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Veuillez patienter un instant. Vous recevrez d’ici peu un nouveau code de confirmation sur votre numéro de mobile pour les notifications de sécurité.  '
WHERE locale = 'fr' and  `ordinal` = 35 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Codice SMS inviato.'
WHERE locale = 'it' and  `ordinal` = 34 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'La preghiamo di attendere. A breve riceverà un nuovo codice di conferma sul suo numero di cellulare per messaggi sulla sicurezza. '
WHERE locale = 'it' and  `ordinal` = 35 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS success --
UPDATE `CustomItem` SET value = 'Zahlungsfreigabe war erfolgreich'
WHERE locale = 'de' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum Händler weitergeleitet. '
WHERE locale = 'de' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Successful payment approval '
WHERE locale = 'en' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'You have successfully approved the payment and will be automatically routed back to the merchant. '
WHERE locale = 'en' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'L’activation du paiement a réussi '
WHERE locale = 'fr' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant. '
WHERE locale = 'fr' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'L’autorizzazione di pagamento è andata a buon fine '
WHERE locale = 'it' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante. '
WHERE locale = 'it' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS cancel --
UPDATE `CustomItem` SET value = 'Zahlungsfreigabe abgebrochen'
WHERE locale = 'de' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess trotzdem fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.'
WHERE locale = 'de' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Payment approval cancelled'
WHERE locale = 'en' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the payment process, please start the payment attempt again. '
WHERE locale = 'en' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Activation de paiement interrompue'
WHERE locale = 'fr' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement.'
WHERE locale = 'fr' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Autorizzazione di pagamento annullata'
WHERE locale = 'it' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento.'
WHERE locale = 'it' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS failure --
SET @pageFailure = 'FAILURE_PAGE';
UPDATE `CustomItem` SET value = 'Sie haben 3 Mal einen fehlerhaften Freigabe-Code eingegeben. Ihre Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Ihre Karte wird nun aus Sicherheitsgründen während einer kurzen Zeitdauer für Online Zahlungen blockiert.  '
WHERE locale = 'de' and  `ordinal` = 23 and pageTypes = @pageFailure and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS technical error --
UPDATE `CustomItem` SET value = 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut. '
WHERE locale = 'de' and  `ordinal` = 33 and pageTypes = @pageFailure and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS timeout --
UPDATE `CustomItem` SET value = 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zurück zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung tätigen wollen.'
WHERE locale = 'de' and  `ordinal` = 31 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );




-- TA --

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_MOBILE_APP');

-- TA main + processing  --
SET @pagePolling = 'POLLING_PAGE';

UPDATE `CustomItem` SET value = '<b>Zahlung im App freigeben</b>'
WHERE locale = 'de' and  `ordinal` = 1 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Damit die Zahlung abgeschlossen werden kann, müssen Sie diese in der von Ihrer Bank zur Vergfügung gestellten App freigeben. '
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Sie sollten bereits eine entsprechende Benachrichtigung auf Ihrem Mobil-Telefon erhalten haben. Andernfalls können Sie direkt in die App einsteigen und die Zahlung dort verifizieren.'
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Stattdessen Freigabe durch SMS anfordern'
WHERE locale = 'de' and  `ordinal` = 10 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Zahlungsfreigabe wird geprüft'
WHERE locale = 'de' and  `ordinal` = 12 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung.'
WHERE locale = 'de' and  `ordinal` = 13 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Hilfe schliessen'
WHERE locale = 'de' and  `ordinal` = 174 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = '<b>Approve payment in the app</b>'
WHERE locale = 'en' and  `ordinal` = 1 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'To complete the payment, you must approve it in the app provided by your bank. '
WHERE locale = 'en' and  `ordinal` = 2 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'You should already have received a corresponding message on your mobile phone. Otherwise, you can open the app directly and approve the payment there.'
WHERE locale = 'en' and  `ordinal` = 3 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Request approval via SMS instead'
WHERE locale = 'en' and  `ordinal` = 10 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Payment approval is being verified'
WHERE locale = 'en' and  `ordinal` = 12 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Please be patient. We are verifying your payment approval and thereby the authentification for the requested payment.'
WHERE locale = 'en' and  `ordinal` = 13 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = '<b>Activer le paiement dans l''App</b>'
WHERE locale = 'fr' and  `ordinal` = 1 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Pour que le paiement puisse être terminé, vous devez l''activer dans l''App mise à disposition par votre banque. '
WHERE locale = 'fr' and  `ordinal` = 2 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Vous devriez déjà avoir reçu un message correspondant sur votre téléphone portable. Dans le cas contraire, vous pouvez aller directement dans votre App et y vérifier le paiement.'
WHERE locale = 'fr' and  `ordinal` = 3 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'À la place, demander l''activation pas SMS'
WHERE locale = 'fr' and  `ordinal` = 10 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'L''activation de paiement va être vérifiée'
WHERE locale = 'fr' and  `ordinal` = 12 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité.'
WHERE locale = 'fr' and  `ordinal` = 13 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = '<b>Autorizzare il pagamento nell’app</b>'
WHERE locale = 'it' and  `ordinal` = 1 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Per poter completare il pagamento, è necessario autorizzarlo nell’app fornita sua banca. '
WHERE locale = 'it' and  `ordinal` = 2 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Dovrebbe aver già ricevuto una notifica sul suo cellulare.  In caso contrario può accedere direttamente all''app e verificare il pagamento lì.'
WHERE locale = 'it' and  `ordinal` = 3 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Al posto di questo, richiedere l’autorizzazione tramite SMS'
WHERE locale = 'it' and  `ordinal` = 10 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'L’autorizzazione di pagamento viene controllata'
WHERE locale = 'it' and  `ordinal` = 12 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.'
WHERE locale = 'it' and  `ordinal` = 13 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

-- TA success --
UPDATE `CustomItem` SET value = 'Zahlungsfreigabe war erfolgreich '
WHERE locale = 'de' and  `ordinal` = 26 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Sie haben die Zahlung erfolgreich freigegeben und werden automatisch zum Händler weitergeleitet. '
WHERE locale = 'de' and  `ordinal` = 27 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Zahlung abbrechen'
WHERE locale = 'de' and  `ordinal` = 40 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Successful payment approval '
WHERE locale = 'en' and  `ordinal` = 26 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'You have successfully approved the payment and will be automatically routed back to the merchant.'
WHERE locale = 'en' and  `ordinal` = 27 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Cancel payment'
WHERE locale = 'en' and  `ordinal` = 40 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'L’activation du paiement a réussi  '
WHERE locale = 'fr' and  `ordinal` = 26 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant. '
WHERE locale = 'fr' and  `ordinal` = 27 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Interrompre le paiement'
WHERE locale = 'fr' and  `ordinal` = 40 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'L’autorizzazione di pagamento è andata a buon fine '
WHERE locale = 'it' and  `ordinal` = 26 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.'
WHERE locale = 'it' and  `ordinal` = 27 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Interrompere il pagamento'
WHERE locale = 'it' and  `ordinal` = 40 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

-- TA cancel --
UPDATE `CustomItem` SET value = 'Zahlungsfreigabe abgebrochen '
WHERE locale = 'de' and  `ordinal` = 14 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Die Zahlung wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess trotzdem fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.'
WHERE locale = 'de' and  `ordinal` = 15 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Payment approval cancelled'
WHERE locale = 'en' and  `ordinal` = 14 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the payment process, please start the payment attempt again.'
WHERE locale = 'en' and  `ordinal` = 15 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Activation de paiement interrompue'
WHERE locale = 'fr' and  `ordinal` = 14 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement.'
WHERE locale = 'fr' and  `ordinal` = 15 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Autorizzazione di pagamento annullata'
WHERE locale = 'it' and  `ordinal` = 14 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento.'
WHERE locale = 'it' and  `ordinal` = 15 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

-- TA failure --
SET @pageFailure = 'FAILURE_PAGE';
UPDATE `CustomItem` SET value = 'Die Authentifikation auf Ihrem Mobil-Telefon und somit die Zahlungsfreigabe ist fehlgeschlagen. Der Zahlungsprozess wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.'
WHERE locale = 'de' and  `ordinal` = 17 and pageTypes = @pageFailure and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'The authentication on your mobile phone and thus the payment approval failed. The payment process was cancelled and your card was not debited. If you wish to continue the payment process, please start the payment attempt again. '
WHERE locale = 'en' and  `ordinal` = 17 and pageTypes = @pageFailure and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'L''authentification sur votre téléphone portable et donc l''activation de paiement, ont échoué. Le processus de paiement a été interrompu et votre carte n''a pas été débitée. Si vous souhaitez continuer le processus d''achat, veuillez recommencer la tentative de paiement.'
WHERE locale = 'fr' and  `ordinal` = 17 and pageTypes = @pageFailure and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'L’autenticazione sul suo cellulare e quindi l’autorizzazione del pagamento non sono riuscite. Il processo di pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare il processo di acquisto, provi a iniziare di nuovo il pagamento.'
WHERE locale = 'it' and  `ordinal` = 17 and pageTypes = @pageFailure and fk_id_customItemSet = @customItemSetMobileApp;

-- TA timeout --
UPDATE `CustomItem` SET value = 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde Ihr Zahlungsvorgang deshalb abgebrochen. Bitte kehren Sie zurück zum Online-Shop zurück und starten Sie den Zahlungsprozess erneut, sofern Sie die Zahlung tätigen wollen. '
WHERE locale = 'de' and  `ordinal` = 31 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

-- TA technical error --
UPDATE `CustomItem` SET value = 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden und Ihre Karte wurde nicht belastet. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.'
WHERE locale = 'de' and  `ordinal` = 33 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

-- Update banner color --


SET @pageLayoutMessageBanner = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` = 'Message Banner (SWISSKEY)' );

UPDATE CustomComponent SET value = '
<style>
		#message-container {
		    	position:relative;
		}
		div#message-container.info {
                background-color:#de3919;
                font-family: Arial, standard;
                font-size:12px;
                color: #EAEAEA;
		}
		div#message-container.success {
                background-color:#449D44;
                font-family: Arial, standard;
                font-size:12px;
                color: #EAEAEA;
		}
		div#message-container.error {
                background-color:#de3919;
                font-family: Arial, standard;
                font-size:12px;
                color: #EAEAEA;
		}
		div#message-container.warn {
                background-color:#EC971F;
                font-family: Arial, standard;
                font-size:12px;
                color: #EAEAEA;
		}
		span#info-icon {
                position:absolute;
                top:15px;
                left:15px;
                float:none;
		}
		#headingTxt {
                font-family: Arial,bold;
                color: #FFFFFF;
                font-size : 14px;
                font-weight : bold;
                width : 70%;
                margin : auto;
                display : block;
                text-align:center;
                padding:4px 1px 1px 1px;
		}
		#message {
                font-family: Arial,regular;
                color: #FFFFFF;
                font-size:12px;
                text-align:center;
		}
		span#message {
                font-size:14px;
		}
		div.message-button {
			    padding-top: 0px;
		}
		div#message-content {
                text-align: center;
                background-color: inherit;
                padding-bottom: 5px;
		}
        #return-button-row button {
                border-radius: 30px
        }
        #close-button-row button {
                border-radius: 30px
        }
        @media all and (max-width: 480px) {
			    span#info-icon {position: absolute;font-size: 3em;top: 1px;left: 5px;display: inline-block;}
		}
</style>
<div id="messageBanner">
	<span id="info-icon" class="fa fa-info-circle"></span>
	<custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
	<custom-text id="message" custom-text-key="$parent.message"></custom-text>
</div>' where fk_id_layout = @pageLayoutMessageBanner;


-- Native App Based --

SET @pageAppView = 'APP_VIEW';

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_MOBILE_APP');

UPDATE `CustomItem` SET value = 'Zur zusätzlichen Sicherheit müssen Sie die Zahlung in Ihrer Authentifikations-App freigeben. Öffnen Sie dazu ihre Authentifikations-App Ihrer Bank und bestätigen Sie die Zahlung dort.\nHändler: @merchantName\nBetrag: @amount\nDatum: @formattedDate\nKartennummer: @displayedPan\n'
WHERE locale = 'de' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Bitte kontaktieren Sie Ihre Bank für weiteren Support. '
WHERE locale = 'de' and  `ordinal` = 157 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'You must approve the payment in your authentication app for added security. To do so, open the authentication app provided by your bank and approve the payment there.\nMerchant: @merchantName\nAmount: @amount\nDate: @formattedDate\nCard number: @displayedPan\n'
WHERE locale = 'en' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Please contact your bank for further support. '
WHERE locale = 'en' and  `ordinal` = 157 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Pour plus de sécurité, vous devez activer le paiement dans votre App d''authentification. Pour cela, ouvrez l''App d''authentification de votre banque et confirmez le paiement. \nCommerçant: @merchantName\nMontant: @amount\nDate: @formattedDate\nNuméro de carte: @displayedPan\n'
WHERE locale = 'fr' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Veuillez contacter votre banque pour plus de support.'
WHERE locale = 'fr' and  `ordinal` = 157 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Per ulteriore sicurezza, deve autorizzare il pagamento nella sua app di autenticazione. Per fare ciò, apra l’app di autenticazione della sua banca e confermi qui il pagamento. \nCommerciante: @merchantName\nImporto: @amount\nData: @formattedDate\nNumero della carta: @displayedPan\n'
WHERE locale = 'it' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Contatti la sua banca per ottenere ulteriore supporto.'
WHERE locale = 'it' and  `ordinal` = 157 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;

-- TA auth failure --
UPDATE `CustomItem` SET value = ''
WHERE locale = 'de' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = ''
WHERE locale = 'en' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = ''
WHERE locale = 'fr' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = ''
WHERE locale = 'it' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;

-- PWD --

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_PASSWORD');

UPDATE `CustomItem` SET value = 'Wir haben Ihnen zur Bestätigung der Zahlung einen Freigabe-Code gesendet. Sofern die Zahlung durch Sie veranlasst worden ist, bestätigen Sie dies durch Eingabe dieses Codes. \n\nDurch die Freigabe bezahlen Sie dem Händler @merchantName den Betrag von @amount am @formattedDate.\nHändler: @merchantName\nBetrag: @amount\nDatum: @formattedDate\nKartennummer: @displayedPan'
WHERE locale = 'de' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'We have sent you an approval code for confirmation of the payment. If the payment has been made by you, please confirm this by entering this code.\n\nWith the confirmation you pay the merchant @merchantName the amount of @amount on @formattedDate. \nMerchant: @merchantName\nAmount: @amount\nDate: @formattedDate\nCard number: @displayedPan'
WHERE locale = 'en' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Nous vous avons envoyé un code d''activation pour la confirmation du paiement. Si c''est bien vous qui avez ordonné le paiement, confirmez-le en saisissant ce code. \n\nPar l''activation, vous payez au commerçant @merchantName le montant de @amount le @formattedDate.\nCommerçant: @merchantName\nMontant: @amount\nDate: @formattedDate\nNuméro de carte: @displayedPan'
WHERE locale = 'fr' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Le abbiamo inviato un codice di autenticazione per confermare il pagamento. Se il pagamento è stato disposto da lei, lo confermi inserendo questo codice.\n\nAttraverso l’autorizzazione, lei paga al commerciante @merchantName l’importo di @amount in data @formattedDate.\nCommerciante: @merchantName\nImporto: @amount\nData: @formattedDate\nNumero della carta: @displayedPan'
WHERE locale = 'it' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;

-- PWD+SMS invalid --
UPDATE `CustomItem` SET value = 'Das eingegebene Passwort oder Eingabe-Code ist nicht korrekt. Bitte versuchen Sie es erneut.'
WHERE locale = 'de' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'The entered password or approval code is incorrect. Please try again.'
WHERE locale = 'en' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Le mot de passe ou le code d''activation saisi est incorrect. Veuillez réessayer.'
WHERE locale = 'fr' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'La password o il codice di autenticazione inseriti non sono corretti. Per favore riprova.'
WHERE locale = 'it' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;