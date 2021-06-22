USE `U7G_ACS_BO`;

-- Refusal Default --
SET @customItemSetDefaultRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_DEFAULT_REFUSAL');

SET @pageRefusal = 'REFUSAL_PAGE';

UPDATE `CustomItem` SET value = 'Zahlung nicht ausgeführt - Technischer Fehler'
WHERE locale = 'de' and  `ordinal` = 22 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen. '
WHERE locale = 'de' and  `ordinal` = 23 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;

UPDATE `CustomItem` SET value = 'Payment not completed – technical error'
WHERE locale = 'en' and  `ordinal` = 22 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'The payment could not be completed due to a technical error. Your card not debited. If you wish to continue with the purchase, please try again.'
WHERE locale = 'en' and  `ordinal` = 23 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;

UPDATE `CustomItem` SET value = 'Paiement non effectué - Problème technique'
WHERE locale = 'fr' and  `ordinal` = 22 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Votre carte n''a pas été débitée. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.'
WHERE locale = 'fr' and  `ordinal` = 23 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;

UPDATE `CustomItem` SET value = 'Pagamento non eseguito - Errore tecnico'
WHERE locale = 'it' and  `ordinal` = 22 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. La sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.'
WHERE locale = 'it' and  `ordinal` = 23 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;

SET @pageHelp = 'HELP_PAGE';

UPDATE `CustomItem` SET value = 'Um die Sicherheit bei Online-Zahlungen zu erhöhen, hat Ihre Bank eine zweistufige Authentifikation eingeführt. '
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'Um diese Zahlung ausführen zu können, müssen Sie die Zahlung bestätigen. Dies können Sie entweder mit der von Ihrer Bank zur Verfügung gestellten App oder mit einem SMS-Code. Für diesen Service ist eine einmalige Registrierung für 3D Secure notwendig. Für Fragen und Details zum Registrierungsprozess, oder Änderungen der Freigabemethode, wenden Sie sich bitte an Ihre Bank.'
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetDefaultRefusal;

UPDATE `CustomItem` SET value = 'To increase the security of online payments, your bank has introduced two-step authentication. '
WHERE locale = 'en' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'To be able to make this payment, you must confirm the payment. You can do this either with the app provided by your bank or with an SMS code. A one-time registration for 3D Secure is required for this service. For questions and details about the registration process or changes to the approval method please contact your bank. '
WHERE locale = 'en' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetDefaultRefusal;

UPDATE `CustomItem` SET value = 'Pour renforcer la sécurité des paiements en ligne, votre banque a mis en place une authentification en deux étapes. '
WHERE locale = 'fr' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'Pour pouvoir effectuer ce paiement, vous devez confirmer le paiement. Vous pouvez le faire soit avec l''application fournie par votre banque, soit avec un code SMS. Un enregistrement unique pour 3D Secure est requis pour ce service. Pour les questions et les détails concernant le processus d''enregistrement, ou les modifications de la méthode d''approbation, veuillez contacter votre banque.'
WHERE locale = 'fr' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetDefaultRefusal;

UPDATE `CustomItem` SET value = 'Al fine di aumentare la sicurezza dei pagamenti online, la sua banca ha introdotto l''autenticazione in due fasi. '
WHERE locale = 'it' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetDefaultRefusal;
UPDATE `CustomItem` SET value = 'Per poter effettuare un pagamento, deve confermarlo utilizzando l''app fornita dalla sua banca o un codice SMS. Per questo servizio è richiesta una registrazione una tantum per 3D Secure. Per domande e dettagli sul processo di registrazione, o modifiche al metodo di approvazione, si rivolga alla sua banca.'
WHERE locale = 'it' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetDefaultRefusal;

-- Refusal Technical error --
SET @pageFailure = 'FAILURE_PAGE';
UPDATE `CustomItem` SET value = 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.'
WHERE locale = 'de' and  `ordinal` = 33 and pageTypes = @pageFailure and fk_id_customItemSet = @customItemSetDefaultRefusal;
SET @pageFailure = 'REFUSAL_PAGE';
UPDATE `CustomItem` SET value = 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.'
WHERE locale = 'de' and  `ordinal` = 33 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetDefaultRefusal;

-- Refusal Fraud --
SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_REFUSAL_FRAUD');

SET @pageRefusal = 'REFUSAL_PAGE';
UPDATE `CustomItem` SET value = 'Zahlung nicht ausgeführt'
WHERE locale = 'de' and  `ordinal` = 220 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'Aus Sicherheitsgründen wurde Ihre Transaktion nicht ausgeführt. Ihre Karte wurde nicht belastet. '
WHERE locale = 'de' and  `ordinal` = 230 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'Payment not completed'
WHERE locale = 'en' and  `ordinal` = 220 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'For security reasons, your transaction was not completed. Your card was not debited.  '
WHERE locale = 'en' and  `ordinal` = 230 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'Le paiement n''a pas été effectué '
WHERE locale = 'fr' and  `ordinal` = 220 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'Pour des raisons de sécurité, votre transaction n''a pas été exécutée. Votre carte n''a pas été débitée.  '
WHERE locale = 'fr' and  `ordinal` = 230 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'Pagamento non eseguito'
WHERE locale = 'it' and  `ordinal` = 220 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;
UPDATE `CustomItem` SET value = 'Per ragioni di sicurezza, la tua transazione non è stata eseguita. La sua carta non è stata addebitata. '
WHERE locale = 'it' and  `ordinal` = 230 and pageTypes = @pageRefusal and fk_id_customItemSet = @customItemSetRefusalFraud;


-- PWD --
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_PASSWORD');

-- PWD main --
SET @pageOTP = 'OTP_FORM_PAGE';

UPDATE `CustomItem` SET value = '<b>Eingabe persönliches Password<b>'
WHERE locale = 'de' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = '<b>Enter your password<b>'
WHERE locale = 'en' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = '<b>Votre mot de passe<b>'
WHERE locale = 'fr' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = '<b>Inserire la password<b>'
WHERE locale = 'it' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

SET @pageHelp = 'HELP_PAGE';

UPDATE `CustomItem` SET value = 'Um Ihre Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank eine zwei-stufige Authentifikation eingeführt. '
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Um eine Zahlung freizugeben bestätigen Sie diese mit Ihrem persönlichen Passwort, welches Sie bei der Registrierung für 3D Secure definiert haben. Für Änderungen des Passworts, oder anderen Fragen zum Online-Einkauf mit Ihrer Karte wenden Sie sich an Ihre Bank.'
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Hilfe schliessen'
WHERE locale = 'de' and  `ordinal` = 174 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetPassword;

-- PWD processing --
SET @pageOTP = 'OTP_FORM_PAGE';

UPDATE `CustomItem` SET value = 'Bestätigung der Zahlung erforderlich'
WHERE locale = 'de' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Confirmation of payment required'
WHERE locale = 'en' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Confirmation du paiement requise'
WHERE locale = 'fr' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Richiesta conferma di pagamento'
WHERE locale = 'it' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

-- PWD success --
UPDATE `CustomItem` SET value = 'Bitte warten, Ihre Zahlung wird verarbeitet. '
WHERE locale = 'de' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Sie haben die Zahlung bestätigt. Die Zahlung wird jetzt verarbeitet. Warten Sie, bis Sie automatisch weitergeleitet werden. '
WHERE locale = 'de' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'Please wait, your payment is being processed. '
WHERE locale = 'en' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'You have confirmed the payment. The payment is now being processed. Wait until you are automatically redirected. '
WHERE locale = 'en' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'Veuillez patienter, votre paiement est en cours de traitement. '
WHERE locale = 'fr' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Vous avez confirmé le paiement. Le paiement est en cours de traitement. Attendez d’être automatiquement redirigé. '
WHERE locale = 'fr' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'Per favore attenda, il suo pagamento è in corso di elaborazione. '
WHERE locale = 'it' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Ha confermato il pagamento. Il pagamento è ora in corso di elaborazione. Aspetti di essere reindirizzato automaticamente. '
WHERE locale = 'it' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

-- PWD cancel --
UPDATE `CustomItem` SET value = 'Zahlungsfreigabe abgebrochen oder fehlgeschlagen '
WHERE locale = 'de' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Es gab keine Belastung auf Ihrer Karte. Die Zahlung wurde nicht durchgeführt. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut. '
WHERE locale = 'de' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'Payment approval canceled or failed '
WHERE locale = 'en' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'There was no debit to your card. The payment was not made. Please return to the online shop and restart the payment process if you wish to make the payment. '
WHERE locale = 'en' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'L’activation de paiement a été annulée ou a échoué '
WHERE locale = 'fr' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Il n’y a pas eu de débit sur votre carte. Le paiement n’a pas été effectué. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement. '
WHERE locale = 'fr' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'Autorizzazione di pagamento annullata o non riuscita '
WHERE locale = 'it' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Non c''è stato alcun addebito sulla sua carta. Il pagamento non è stato effettuato. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento. '
WHERE locale = 'it' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

-- PWD technical error --
UPDATE `CustomItem` SET value = 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Die Zahlung wurde nicht ausgeführt und Ihre Karte nicht belastet. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut. '
WHERE locale = 'de' and  `ordinal` = 33 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
SET @pageFailure = 'FAILURE_PAGE';
UPDATE `CustomItem` SET value = 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Die Zahlung wurde nicht ausgeführt und Ihre Karte nicht belastet. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut. '
WHERE locale = 'de' and  `ordinal` = 33 and pageTypes = @pageFailure and fk_id_customItemSet = @customItemSetPassword;

-- PWD timeout --
UPDATE `CustomItem` SET value = 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde der Zahlungsvorgang abgebrochen. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut.'
WHERE locale = 'de' and  `ordinal` = 31 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

-- PWD invalid --
UPDATE `CustomItem` SET value = 'Eingegebenes Passwort oder  SMS-Code nicht korrekt. Bitte versuchen Sie es erneut.'
WHERE locale = 'de' and  `ordinal` = 29 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Entered password or SMS code incorrect. Please try again.'
WHERE locale = 'en' and  `ordinal` = 29 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Mot de passe ou code SMS incorrect. Veuillez réessayer.'
WHERE locale = 'fr' and  `ordinal` = 29 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Password o codice SMS non sono corretti. Per favore riprovi.'
WHERE locale = 'it' and  `ordinal` = 29 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;


-- SMS OVERRIDE and EXT --

SET @customItemSetSMSOverride = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_SMS_OVERRIDE');
SET @customItemSetSMSEXT = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_SMS');

-- SMS main --
SET @pageOTP = 'OTP_FORM_PAGE';
UPDATE `CustomItem` SET value = '<b>Zahlung mit SMS-Code bestätigen</b>'
WHERE locale = 'de' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Um die Zahlung zu bestätigen, haben wir Ihnen einen SMS-Code an Ihre Mobiltelefonnummer geschickt. '
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Überprüfen Sie die Zahlungsdetails, geben Sie den 6-stelligen SMS-Code unten ein und klicken Sie auf "Bestätigen".'
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Neuen SMS-Code anfordern'
WHERE locale = 'de' and  `ordinal` = 19 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Bestätigen'
WHERE locale = 'de' and  `ordinal` = 42 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = '<b>Confirm payment with SMS code</b>'
WHERE locale = 'en' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'To confirm the payment, we have sent an SMS code to your mobile phone number. '
WHERE locale = 'en' and  `ordinal` = 2 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Check the payment details, enter the 6-digit SMS code below and click "Confirm".'
WHERE locale = 'en' and  `ordinal` = 3 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Request new SMS code'
WHERE locale = 'en' and  `ordinal` = 19 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Confirm'
WHERE locale = 'en' and  `ordinal` = 42 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = '<b>Confirmez le paiement avec le code SMS</b>'
WHERE locale = 'fr' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Pour confirmer le paiement, nous vous avons envoyé un code SMS sur votre numéro de téléphone mobile. '
WHERE locale = 'fr' and  `ordinal` = 2 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Vérifiez les détails du paiement, saisissez le code SMS à 6 chiffres ci-dessous et cliquez sur "Confirmer".'
WHERE locale = 'fr' and  `ordinal` = 3 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Demander un nouveau code SMS'
WHERE locale = 'fr' and  `ordinal` = 19 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Confirmer'
WHERE locale = 'fr' and  `ordinal` = 42 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = '<b>Conferma il pagamento con il codice SMS</b>'
WHERE locale = 'it' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Per confermare il pagamento, le abbiamo inviato un codice SMS al suo numero di cellulare. '
WHERE locale = 'it' and  `ordinal` = 2 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Controlli i dettagli del pagamento, inserisca il codice SMS di 6 cifre qui sotto e clicchi su "Conferma".'
WHERE locale = 'it' and  `ordinal` = 3 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Richiedere un nuovo codice SMS'
WHERE locale = 'it' and  `ordinal` = 19 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Conferma'
WHERE locale = 'it' and  `ordinal` = 42 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

SET @pageHelp = 'HELP_PAGE';
UPDATE `CustomItem` SET value = 'Um die Sicherheit von Online-Zahlungen zu erhöhen, hat Ihre Bank die zweistufige Authentifizierung eingeführt. '
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Bitte bestätigen Sie die Zahlung mit dem einmaligen SMS-Code, der an Ihre registrierte Telefonnummer gesendet wurde. Bei Fragen oder Änderungen Ihrer Telefonnummer wenden Sie sich bitte an Ihre Bank.'
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Hilfe schliessen'
WHERE locale = 'de' and  `ordinal` = 174 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'To increase the security of online payments, your bank has introduced two-step authentication. '
WHERE locale = 'en' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Please confirm the payment with the one-time SMS code that has been sent to your registered mobile phone number. For any questions or changes to your mobile phone number, please contact your bank. '
WHERE locale = 'en' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Afin d’augmenter la sécurité des paiements en ligne, votre banque a mis en place l’authentification en deux étapes. '
WHERE locale = 'fr' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Veuillez confirmer le paiement avec le code SMS à usage unique qui a été envoyé à votre numéro de téléphone mobile enregistré. Pour toute question ou modification de votre numéro de téléphone mobile, veuillez contacter votre banque.'
WHERE locale = 'fr' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Al fine di aumentare la sicurezza dei pagamenti online, la sua banca ha introdotto l''autenticazione in due fasi. '
WHERE locale = 'it' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'La preghiamo di confermare il pagamento con il codice SMS monouso che è stato inviato al numero di telefono da lei registrato. Per eventuali domande di chiarimento o per modificare il suo numero di telefono, si rivolga alla sua banca.'
WHERE locale = 'it' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );


-- SMS EXT Fallback --
SET @createdBy ='A709391';
SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@pageOTP,'_51'), 'PUSHED_TO_CONFIG',
 'de', 51, @pageOTP, 'Zahlung mit SMS-Code statt App bestätigen', @MaestroVID, NULL, @customItemSetSMSEXT),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@pageOTP,'_51'), 'PUSHED_TO_CONFIG',
 'en', 51, @pageOTP, 'Confirm payment with SMS code instead of app', @MaestroVID, NULL, @customItemSetSMSEXT),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@pageOTP,'_51'), 'PUSHED_TO_CONFIG',
 'fr', 51, @pageOTP, 'Confirmez le paiement avec le code SMS au lieu de l''app', @MaestroVID, NULL, @customItemSetSMSEXT),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@pageOTP,'_51'), 'PUSHED_TO_CONFIG',
 'it', 51, @pageOTP, 'Conferma il pagamento con un codice SMS invece che con l''app', @MaestroVID, NULL, @customItemSetSMSEXT),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@pageOTP,'_52'), 'PUSHED_TO_CONFIG',
 'de', 52, @pageOTP, 'Um die Zahlung zu bestätigen, haben wir Ihnen einen SMS-Code an Ihre Mobiltelefonnummer geschickt, da die Verbindung zur App  zur Zeit nicht möglich ist. ', @MaestroVID, NULL, @customItemSetSMSEXT),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@pageOTP,'_52'), 'PUSHED_TO_CONFIG',
 'en', 52, @pageOTP, 'To confirm the payment, we have sent an SMS code to your mobile phone number, as the connection to the app is currently not possible.', @MaestroVID, NULL, @customItemSetSMSEXT),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@pageOTP,'_52'), 'PUSHED_TO_CONFIG',
 'fr', 52, @pageOTP, 'Pour confirmer le paiement, nous vous avons envoyé un code SMS sur votre numéro de téléphone mobile, car la connexion avec l''app  est impossible.', @MaestroVID, NULL, @customItemSetSMSEXT),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@pageOTP,'_52'), 'PUSHED_TO_CONFIG',
 'it', 52, @pageOTP, 'Per confermare il pagamento, le abbiamo inviato un codice SMS al suo numero di cellulare, poiché il collegamento con l’app non è possibile.', @MaestroVID, NULL, @customItemSetSMSEXT);

-- SMS Processing --
UPDATE `CustomItem` SET value = 'Bestätigung der Zahlung erforderlich'
WHERE locale = 'de' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Sie erhalten in Kürze einen Freigabe-Code per SMS zur Bestätigung der Zahlung. '
WHERE locale = 'de' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Confirmation of payment required'
WHERE locale = 'en' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'You will receive an approval code via SMS shortly to confirm the payment. '
WHERE locale = 'en' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Confirmation du paiement requise'
WHERE locale = 'fr' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Vous recevrez sous peu un code d''activation par SMS pour confirmer le paiement. '
WHERE locale = 'fr' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Richiesta conferma di pagamento'
WHERE locale = 'it' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'A breve riceverà un codice di autenticazione via SMS per confermare il pagamento.  '
WHERE locale = 'it' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS Resend --
UPDATE `CustomItem` SET value = 'Neuer SMS-Code'
WHERE locale = 'de' and  `ordinal` = 34 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Sie erhalten in Kürze einen neuen SMS-Code an Ihre Telefonnummer. '
WHERE locale = 'de' and  `ordinal` = 35 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'New SMS code'
WHERE locale = 'en' and  `ordinal` = 34 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'You will receive a new SMS code shortly, which will be sent to your mobile number. '
WHERE locale = 'en' and  `ordinal` = 35 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Nouveau code SMS'
WHERE locale = 'fr' and  `ordinal` = 34 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Vous recevrez sous peu un nouveau code SMS sur votre numéro de téléphone portable.  '
WHERE locale = 'fr' and  `ordinal` = 35 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Nuovo codice SMS'
WHERE locale = 'it' and  `ordinal` = 34 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'A breve riceverà un nuovo codice SMS al suo numero di cellulare. '
WHERE locale = 'it' and  `ordinal` = 35 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS success --
UPDATE `CustomItem` SET value = 'Bitte warten, Ihre Zahlung wird verarbeitet. '
WHERE locale = 'de' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Sie haben die Zahlung bestätigt. Ihre Zahlung wird jetzt verarbeitet. Warten Sie, bis Sie automatisch weitergeleitet werden. '
WHERE locale = 'de' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Please wait, your payment is being processed. '
WHERE locale = 'en' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'You have confirmed the payment. The payment is now being processed. Wait until you are automatically redirected. '
WHERE locale = 'en' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Veuillez patienter, votre paiement est en cours de traitement. '
WHERE locale = 'fr' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Vous avez confirmé le paiement. Le paiement est en cours de traitement. Attendez d’être automatiquement redirigé. '
WHERE locale = 'fr' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Per favore attenda, il suo pagamento è in corso di elaborazione. '
WHERE locale = 'it' and  `ordinal` = 26 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Ha confermato il pagamento. Il pagamento è ora in corso di elaborazione. Aspetti di essere reindirizzato automaticamente. '
WHERE locale = 'it' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS cancel --
UPDATE `CustomItem` SET value = 'Zahlungsfreigabe abgebrochen oder fehlgeschlagen'
WHERE locale = 'de' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Es gab keine Belastung auf Ihrer Karte. Die Zahlung wurde nicht durchgeführt. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut.'
WHERE locale = 'de' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Payment approval canceled or failed'
WHERE locale = 'en' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'There was no debit to your card. The payment was not made. Please return to the online shop and restart the payment process if you wish to make the payment.'
WHERE locale = 'en' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'L’activation de paiement a été annulée ou a échoué'
WHERE locale = 'fr' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Il n''y a pas eu de débit sur votre carte. Le paiement n''a pas été effectué. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement.'
WHERE locale = 'fr' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Autorizzazione di pagamanto annullata o non riuscita'
WHERE locale = 'it' and  `ordinal` = 14 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Non c''è stato alcun addebito sulla sua carta. Il pagamento non è stato effettuato. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.'
WHERE locale = 'it' and  `ordinal` = 15 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS failure --
SET @pageFailure = 'FAILURE_PAGE';
UPDATE `CustomItem` SET value = 'Sie haben 3 Mal einen fehlerhaften SMS-Code eingegeben. Ihre Zahlung konnte nicht abgeschlossen werden. Die Karte wurde nicht belastet. Aus Sicherheitsgründen ist Ihre Karte während einer kurzen Zeitdauer für Online-Zahlungen blockiert.  '
WHERE locale = 'de' and  `ordinal` = 23 and pageTypes = @pageFailure and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS technical error --
SET @pageFailure = 'FAILURE_PAGE';
UPDATE `CustomItem` SET value = 'Aufgrund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Ihre Karte wurde nicht belastet. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut. '
WHERE locale = 'de' and  `ordinal` = 33 and pageTypes = @pageFailure and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS timeout --
UPDATE `CustomItem` SET value = 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde der Zahlungsvorgang abgebrochen. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut.'
WHERE locale = 'de' and  `ordinal` = 31 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS wrong input --
UPDATE `CustomItem` SET value = 'Fehlerhafter SMS-Code'
WHERE locale = 'de' and  `ordinal` = 28 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Der eingegebene SMS-Code ist nicht korrekt. Die Zahlung wurde nicht ausgeführt und Ihre Karte nicht belastet. Geben Sie unten den korrekten SMS-Code ein, um es erneut zu versuchen.  '
WHERE locale = 'de' and  `ordinal` = 29 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );


-- TA --

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_MOBILE_APP');

-- TA main + processing  --
SET @pagePolling = 'POLLING_PAGE';

UPDATE `CustomItem` SET value = '<b>Zahlung mit der App bestätigen</b>'
WHERE locale = 'de' and  `ordinal` = 1 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Damit die Zahlung abgeschlossen werden kann, müssen Sie die Zahlung in der App, welche von Ihrer Bank für 3D Secure zur Verfügung gestellt wird, freigeben. \n'
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Sie haben keine Benachrichtigung auf Ihr Mobiltelefon erhalten? Öffnen Sie die App, um die Zahlung freizugeben.'
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Stattdessen SMS-Code anfordern'
WHERE locale = 'de' and  `ordinal` = 10 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Bestätigung der Zahlung erforderlich'
WHERE locale = 'de' and  `ordinal` = 12 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Sie erhalten in Kürze eine Freigabeanfrage über die App. Sie können die Zahlung stattdessen auch über einen SMS-Code bestätigen.'
WHERE locale = 'de' and  `ordinal` = 13 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Hilfe schliessen'
WHERE locale = 'de' and  `ordinal` = 174 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = '<b>Confirm payment with the app</b>'
WHERE locale = 'en' and  `ordinal` = 1 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'In order for the payment to be completed, you must approve the payment in the app provided by your bank for 3D Secure.  \n'
WHERE locale = 'en' and  `ordinal` = 2 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'You have not received a notification on your cell phone? Open the app to approve the payment.'
WHERE locale = 'en' and  `ordinal` = 3 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Request SMS code instead'
WHERE locale = 'en' and  `ordinal` = 10 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Confirmation of payment required'
WHERE locale = 'en' and  `ordinal` = 12 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'You will receive an approval request via the app shortly. You can also confirm the payment via an SMS code instead.'
WHERE locale = 'en' and  `ordinal` = 13 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = '<b>Confirmez le paiement avec l''app</b>'
WHERE locale = 'fr' and  `ordinal` = 1 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Pour que le paiement soit effectué, vous devez approuver le paiement dans l’application fournie par votre banque pour 3D Secure.   \n'
WHERE locale = 'fr' and  `ordinal` = 2 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Vous n’avez pas reçu de notification sur votre téléphone portable? Ouvrez l’application pour approuver le paiement.'
WHERE locale = 'fr' and  `ordinal` = 3 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Demandez plutôt un code SMS'
WHERE locale = 'fr' and  `ordinal` = 10 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Confirmation du paiement requise'
WHERE locale = 'fr' and  `ordinal` = 12 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Vous recevrez sous peu une demande d''activation via l''app. Vous pouvez également confirmer le paiement avec un code SMS.'
WHERE locale = 'fr' and  `ordinal` = 13 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = '<b>Confermare il pagamento con l''app</b>'
WHERE locale = 'it' and  `ordinal` = 1 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Affinché il pagamento sia completato, deve approvare il pagamento nell''app fornita dalla sua banca per 3D Secure.  \n'
WHERE locale = 'it' and  `ordinal` = 2 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Non haricevuto una notifica sul suo cellulare?  Apra l''applicazione per autorizzare lì il pagamento.'
WHERE locale = 'it' and  `ordinal` = 3 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Richiedere invece il codice SMS'
WHERE locale = 'it' and  `ordinal` = 10 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Richiesta conferma di pagamento'
WHERE locale = 'it' and  `ordinal` = 12 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'A breve riceveràuna richiesta di autenticazione tramite l''app. Può anche confermare il pagamento con un codice SMS.'
WHERE locale = 'it' and  `ordinal` = 13 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

-- TA success --
UPDATE `CustomItem` SET value = 'Bitte warten, Ihre Zahlung wird verarbeitet. '
WHERE locale = 'de' and  `ordinal` = 26 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Sie haben die Zahlung bestätigt. Die Zahlung wird jetzt verarbeitet. Warten Sie, bis Sie automatisch weitergeleitet werden. '
WHERE locale = 'de' and  `ordinal` = 27 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Zahlungsvorgang abbrechen'
WHERE locale = 'de' and  `ordinal` = 40 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Please wait, your payment is being processed. '
WHERE locale = 'en' and  `ordinal` = 26 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'You have confirmed the payment. The payment is now being processed. Wait until you are automatically redirected.'
WHERE locale = 'en' and  `ordinal` = 27 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Cancel payment transaction'
WHERE locale = 'en' and  `ordinal` = 40 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Veuillez patienter, votre paiement est en cours de traitement.  '
WHERE locale = 'fr' and  `ordinal` = 26 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Vous avez confirmé le paiement. Le paiement est en cours de traitement. Attendez d’être automatiquement redirigé. '
WHERE locale = 'fr' and  `ordinal` = 27 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Annuler l’opération de paiement'
WHERE locale = 'fr' and  `ordinal` = 40 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Per favore attenda, il suo pagamento è in corso di elaborazione.  '
WHERE locale = 'it' and  `ordinal` = 26 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Ha confermato il pagamento. Il pagamento è ora in corso di elaborazione. Aspetti di essere reindirizzato automaticamente.'
WHERE locale = 'it' and  `ordinal` = 27 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Annullare il processo di pagamento'
WHERE locale = 'it' and  `ordinal` = 40 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

-- TA cancel --
UPDATE `CustomItem` SET value = 'Zahlungsfreigabe abgebrochen oder fehlgeschlagen '
WHERE locale = 'de' and  `ordinal` = 14 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Es gab keine Belastung auf Ihrer Karte. Die Zahlung wurde nicht durchgeführt. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut.'
WHERE locale = 'de' and  `ordinal` = 15 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Payment approval canceled or failed'
WHERE locale = 'en' and  `ordinal` = 14 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'There was no debit to your card. The payment was not made. Please return to the online shop and restart the payment process if you wish to make the payment.'
WHERE locale = 'en' and  `ordinal` = 15 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'L’activation de paiement a été annulée ou a échoué '
WHERE locale = 'fr' and  `ordinal` = 14 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Il n''y a pas eu de débit sur votre carte. Le paiement n''a pas été effectué. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement. '
WHERE locale = 'fr' and  `ordinal` = 15 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Autorizzazione di pagamento annullata o non riuscita '
WHERE locale = 'it' and  `ordinal` = 14 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Non c''è stato alcun addebito sulla sua carta. Il pagamento non è stato effettuato. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.'
WHERE locale = 'it' and  `ordinal` = 15 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

-- TA failure --
SET @pageFailure = 'FAILURE_PAGE';
UPDATE `CustomItem` SET value = 'Die Bestätigung mit der App hat nicht funktioniert. Die Zahlung wurde nicht ausgeführt und Ihre Karte nicht belastet. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut.'
WHERE locale = 'de' and  `ordinal` = 17 and pageTypes = @pageFailure and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'The confirmation with the app did not work. The payment was not made, and your card was not charged. Please return to the online shop and restart the payment process if you wish to make the payment.'
WHERE locale = 'en' and  `ordinal` = 17 and pageTypes = @pageFailure and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'La confirmation avec l’application n’a pas fonctionné. Le paiement n’a pas été traité et votre carte n’a pas été débitée. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement.'
WHERE locale = 'fr' and  `ordinal` = 17 and pageTypes = @pageFailure and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'La conferma con l''app non ha funzionato. Il pagamento non è stato eseguito e la sua carta non è stata addebitata. Se desidera effettuare il pagamento, ritorni al negozio online e inizi di nuovo il processo di pagamento.'
WHERE locale = 'it' and  `ordinal` = 17 and pageTypes = @pageFailure and fk_id_customItemSet = @customItemSetMobileApp;

-- TA timeout --
UPDATE `CustomItem` SET value = 'Es ist zu viel Zeit verstrichen bis zur Freigabe der Zahlung. Aus Sicherheitsgründen wurde der Zahlungsvorgang abgebrochen. Die Zahlung wurde nicht ausgeführt und Ihre Karte nicht belastet. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut. '
WHERE locale = 'de' and  `ordinal` = 31 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

-- TA technical error --
UPDATE `CustomItem` SET value = 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden.Ihre Karte wurde nicht belastet. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut.'
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
                background-color:#EC971F;
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

-- TA main --
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_MOBILE_APP');

UPDATE `CustomItem` SET value = 'Damit die Zahlung abgeschlossen werden kann, müssen Sie die Zahlung in der App, welche von Ihrer Bank für 3D Secure zur Verfügung gestellt wird, freigeben.\nSie haben keine Benachrichtigung auf Ihr Mobiltelefon erhalten? Öffnen Sie die App, um die Zahlung freizugeben.'
WHERE locale = 'de' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Für weitere Informationen rund um den 3D Secure Service wenden Sie sich bitte an Ihre Bank. '
WHERE locale = 'de' and  `ordinal` = 157 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'In order for the payment to be completed, you must approve the payment in the app provided by your bank for 3D Secure.\nYou have not received a notification on your cell phone? Open the app to appove the payment.'
WHERE locale = 'en' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'For more information about the 3D Secure service, please contact your bank. '
WHERE locale = 'en' and  `ordinal` = 157 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Pour que le paiement soit effectué, vous devez approuver le paiement dans l’application fournie par votre banque pour 3D Secure.\nVous n’avez pas reçu de notification sur votre téléphone portable? Ouvrez l’application pour approuver le paiement.'
WHERE locale = 'fr' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'For more information about the 3D Secure service, please contact your bank.'
WHERE locale = 'fr' and  `ordinal` = 157 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Affinché il pagamento possa essere completato, deve autorizzare il pagamento nell''app fornita dalla sua banca per 3D Secure. \nNon ha ricevuto una notifica sul suo cellulare? Apra l''applicazione e confermi lì il pagamento.'
WHERE locale = 'it' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Per ulteriori informazioni sul servizio 3D Secure, si rivolga alla sua banca. '
WHERE locale = 'it' and  `ordinal` = 157 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;

-- TA auth failure --
UPDATE `CustomItem` SET value = 'Die Authentifikation auf Ihrem Mobiltelefon ist fehlgeschlagen. Die Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Bitte versuchen Sie es erneut. '
WHERE locale = 'de' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'The authentication on your mobile phone failed. Your payment could not be completed and your card was not debited. Please try it again.'
WHERE locale = 'en' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'L''authentification sur votre téléphone portable a échoué. Le paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Veuillez réessayer à nouveau.'
WHERE locale = 'fr' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'L’autenticazione sul suo cellulare non è riuscita. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. La preghiamo di riprovare.'
WHERE locale = 'it' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;

-- TA PWD --

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_PASSWORD');

UPDATE `CustomItem` SET value = 'Bitte prüfen Sie die Zahlungsdetails und bestätigen Sie die Zahlung durch Eingabe Ihres Passworts. \n\n Durch die Freigabe bezahlen Sie dem Händler @merchantName den Betrag von @amount am @formattedDate.'
WHERE locale = 'de' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Please check the payment details and approve the payment by entering your password. \n\n By confirming, you will pay the merchant @merchantName the amount of @amount on @formattedDate.'
WHERE locale = 'en' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Veuillez vérifier les détails de paiement et activer le paiement en saisissant votre mot de passe. \n\n Par l''activation, vous payez au commerçant @merchantName le montant de @amount le @formattedDate.'
WHERE locale = 'fr' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Controlli i dettagli del pagamento a sinistra e confermi il pagamento inserendo la password. \n\n Attraverso l’autorizzazione, lei paga al commerciante @merchantName l’importo di @amount in data @formattedDate.'
WHERE locale = 'it' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;

-- PWD+SMS invalid --
UPDATE `CustomItem` SET value = 'Das eingegebene Passwort oder der SMS-Code ist nicht korrekt.\nBitte versuchen Sie es erneut.'
WHERE locale = 'de' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'The entered password or SMS code is incorrect.\nPlease try again.'
WHERE locale = 'en' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Le mot de passe ou le code SMS saisi est incorrect.\nVeuillez réessayer.'
WHERE locale = 'fr' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'La password o il codice SMS inseriti non sono corretti.\nPer favore riprovi.'
WHERE locale = 'it' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;

