USE `U5G_ACS_BO`;

SET @codeSubIssuer = '16900';
SET @nameCustomItemSet = 'customitemset_16900_SMS';
SET @issuerIdREISEBANK = (SELECT id FROM `SubIssuer` WHERE `code` = @codeSubIssuer);

SET @idCustomItemSet = (SELECT id FROM `CustomItemSet` WHERE `name` = @nameCustomItemSet);

SET @idImageVisa = (SELECT id FROM `Image` WHERE `name` = 'VISA_LOGO');
SET @bankLogo = (SELECT id FROM `Image` WHERE `name` = 'Consorsbank');

SET @idNetworkVisa = (SELECT id FROM `Network` WHERE `code` = 'VISA');

SET @locale = 'de';

-- 12. CustomItem

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES
('I' ,'A169318' , NOW() ,NULL ,'Bank Logo' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'ALL' ,'Consorsbank' ,@idNetworkVisa , @bankLogo ,@idCustomItemSet),
('I' ,'A169318' , NOW() ,NULL ,'VISA Logo' ,'PUSHED_TO_CONFIG' ,@locale ,2 ,'ALL' ,'VISA' ,@idNetworkVisa , @idImageVisa ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA Logo' ,'PUSHED_TO_CONFIG' ,@locale ,104 ,'ALL' ,'Gerätenummer / -name' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_1_de' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'FAILURE_PAGE' ,'Bitte bestätigen Sie folgende Zahlung' ,@idNetworkVisa , @bankLogo ,@idCustomItemSet),

('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_5_de' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'FAILURE_PAGE' ,'Hilfe & FAQ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_6_de' ,'PUSHED_TO_CONFIG' ,@locale ,6 ,'FAILURE_PAGE' ,'Wir sind für Sie da: 0911 - 369 30 00' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_7_de' ,'PUSHED_TO_CONFIG' ,@locale ,7 ,'FAILURE_PAGE' ,'Mo-So: 7:00 Uhr - 22:30 Uhr' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_8_de' ,'PUSHED_TO_CONFIG' ,@locale ,8 ,'FAILURE_PAGE' ,'(Halten Sie als Kunde bitte Ihre Kontonummer bereit.)' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_9_de' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'FAILURE_PAGE' ,'VISA Secure - ein Service von VISA in Kooperation mit Consorsbank' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_10_de' ,'PUSHED_TO_CONFIG' ,@locale ,10 ,'FAILURE_PAGE' ,'&copy; VISA Europe' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_FAILURE_PAGE_14_en' ,'PUSHED_TO_CONFIG' ,@locale ,14 ,'FAILURE_PAGE' ,'Sie haben die Bezahlung abgebrochen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_FAILURE_PAGE_15_en' ,'PUSHED_TO_CONFIG' ,@locale ,15 ,'FAILURE_PAGE' ,'Falls Sie den Artikel dennoch kaufen möchten, starten Sie den Zahlungsvorgang bitte erneut. ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_FAILURE_PAGE_32_en' ,'PUSHED_TO_CONFIG' ,@locale ,16 ,'FAILURE_PAGE' ,'Ihr Authentifizierungsverfahren wurde gesperrt ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_OTP_SMS_FAILURE_PAGE_33_en' ,'PUSHED_TO_CONFIG' ,@locale ,17 ,'FAILURE_PAGE' ,'Beachten Sie bitte, dass aus Sicherheitsgründen aufgrund mehrfach falscher Authentifizierung Ihr Authentifizierungs-Verfahren gesperrt wurde. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_FAILURE_PAGE_40_en' ,'PUSHED_TO_CONFIG' ,@locale ,40 ,'FAILURE_PAGE' ,'Abbrechen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_FAILURE_PAGE_41_en' ,'PUSHED_TO_CONFIG' ,@locale ,41 ,'FAILURE_PAGE' ,'Hilfe' ,@idNetworkVisa , NULL ,@idCustomItemSet),

('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_1_en' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'HELP_PAGE' ,'<b>Informationen über Visa Secure</b></br>Visa Secure ist ein Service von Visa und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_2_en' ,'PUSHED_TO_CONFIG' ,@locale ,2 ,'HELP_PAGE' ,'<b>Registrierung für Visa Secure</b></br>Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Consorsbank Visa Card  automatisch für den Visa Secure Service  angemeldet.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_3_en' ,'PUSHED_TO_CONFIG' ,@locale ,3 ,'HELP_PAGE' ,'<b>Deaktivierung des Visa Secure Service</b></br>Solange Sie ein Girokonto und eine Visa Card bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_4_en' ,'PUSHED_TO_CONFIG' ,@locale ,4 ,'HELP_PAGE' ,'<b>Höhere Sicherheit durch Visa Secure</b></br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_5_en' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'HELP_PAGE' ,'<b>Falscheingabe der Visa Secure TAN</b></br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Service weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_HELP_PAGE_11_de' ,'PUSHED_TO_CONFIG' ,@locale ,11 ,'HELP_PAGE' ,'Schließen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_MESSAGE_BODY' ,'PUSHED_TO_CONFIG' ,@locale ,0 ,'MESSAGE_BODY' ,'Um Ihren Kauf von Betrag @amount auf der Webseite @merchant zu authentifizieren, geben Sie bitte den Code ein @otp' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_1_de' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'OTP_FORM_PAGE' ,'Bitte bestätigen Sie folgende Zahlung' ,@idNetworkVisa , NULL ,@idCustomItemSet),

('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_3_en' ,'PUSHED_TO_CONFIG' ,@locale ,3 ,'OTP_FORM_PAGE' ,'Zahlung mit mobiler TAN bestätigen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_4_en' ,'PUSHED_TO_CONFIG' ,@locale ,4 ,'OTP_FORM_PAGE' ,'Abbrechen und zurück zum Händler' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_5_en' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'OTP_FORM_PAGE' ,'Hilfe & FAQ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_6_en' ,'PUSHED_TO_CONFIG' ,@locale ,6 ,'OTP_FORM_PAGE' ,'Wir sind für Sie da: 0911 - 369 30 00' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_7_en' ,'PUSHED_TO_CONFIG' ,@locale ,7 ,'OTP_FORM_PAGE' ,'Mo-So: 7:00 Uhr - 22:30 Uhr' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_8_en' ,'PUSHED_TO_CONFIG' ,@locale ,8 ,'OTP_FORM_PAGE' ,'(Halten Sie als Kunde bitte Ihre Kontonummer bereit.)' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_9_en' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'OTP_FORM_PAGE' ,'VISA Secure - ein Service von VISA in Kooperation mit Consorsbank' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_10_en' ,'PUSHED_TO_CONFIG' ,@locale ,10 ,'OTP_FORM_PAGE' ,'&copy; VISA Europe' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_11_de' ,'PUSHED_TO_CONFIG' ,@locale ,11 ,'OTP_FORM_PAGE' ,'Bitte fordern Sie eine mobile TAN an.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_12_en' ,'PUSHED_TO_CONFIG' ,@locale ,12 ,'OTP_FORM_PAGE' ,'Ihre mobile TAN wird geprüft' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_25_en' ,'PUSHED_TO_CONFIG' ,@locale ,13 ,'OTP_FORM_PAGE' ,'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre mobile TAN. ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_14_en' ,'PUSHED_TO_CONFIG' ,@locale ,14 ,'OTP_FORM_PAGE' ,'Sie haben die Bezahlung abgebrochen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_15_en' ,'PUSHED_TO_CONFIG' ,@locale ,15 ,'OTP_FORM_PAGE' ,'Falls Sie den Artikel dennoch kaufen möchten, starten Sie den Zahlungsvorgang bitte erneut. ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_18_en' ,'PUSHED_TO_CONFIG' ,@locale ,18 ,'OTP_FORM_PAGE' ,'Zahlung bestätigen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_19_en' ,'PUSHED_TO_CONFIG' ,@locale ,19 ,'OTP_FORM_PAGE' ,'Mobile TAN anfordern' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_20_en' ,'PUSHED_TO_CONFIG' ,@locale ,20 ,'OTP_FORM_PAGE' ,'Bestätigung ihrer Zahlung an @merchant' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_20_en' ,'PUSHED_TO_CONFIG' ,@locale ,21 ,'OTP_FORM_PAGE' ,'am @purchaseDate um @purchasetime' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_22_en' ,'PUSHED_TO_CONFIG' ,@locale ,22 ,'OTP_FORM_PAGE' ,'Ihr mobiler TAN-Service wurde gesperrt' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_23_en' ,'PUSHED_TO_CONFIG' ,@locale ,23 ,'OTP_FORM_PAGE' ,'Die Prüfung der mobilen TAN ist fehlgeschlagen. Bitte beachten Sie: Sie haben dreimal eine falsche mobile TAN eingeben. Ihr mobiler TAN-Service wurde aus Sicherheitsgründen gesperrt. Bitte wenden Sie sich an Ihr persönliches Betreuungsteam.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_26_en' ,'PUSHED_TO_CONFIG' ,@locale ,26 ,'OTP_FORM_PAGE' ,'Ihre Authentifizierung war erfolgreich' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_27_en' ,'PUSHED_TO_CONFIG' ,@locale ,27 ,'OTP_FORM_PAGE' ,'Sie wurden erfolgreich authentifiziert und werden automatisch zur Händler-Website weitergeleitet.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_28_en' ,'PUSHED_TO_CONFIG' ,@locale ,28 ,'OTP_FORM_PAGE' ,'Ungültige mobile TAN' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_29_en' ,'PUSHED_TO_CONFIG' ,@locale ,29 ,'OTP_FORM_PAGE' ,'Die Prüfung der mobilen TAN ist fehlgeschlagen. Bitte fordern Sie erneut eine mobile TAN an. Wenn Sie dreimal eine falsche mobile TAN eingeben, wird Ihr mobiler TAN-Service gesperrt. ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_30_en' ,'PUSHED_TO_CONFIG' ,@locale ,30 ,'OTP_FORM_PAGE' ,'Ihre Session ist abgelaufen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_31_en' ,'PUSHED_TO_CONFIG' ,@locale ,31 ,'OTP_FORM_PAGE' ,'Das Zeitlimit wurde überschritten. Aus Sicherheitsgründen wird die Transaktion abgebrochen. Bitte versuchen Sie es erneut. Bei Fragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_32_en' ,'PUSHED_TO_CONFIG' ,@locale ,32 ,'OTP_FORM_PAGE' ,'Technischer Fehler' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_33_en' ,'PUSHED_TO_CONFIG' ,@locale ,33 ,'OTP_FORM_PAGE' ,'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_34_en' ,'PUSHED_TO_CONFIG' ,@locale ,34 ,'OTP_FORM_PAGE' ,'Ihre mobile TAN wird versendet' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_35_en' ,'PUSHED_TO_CONFIG' ,@locale ,35 ,'OTP_FORM_PAGE' ,'Bitte warten Sie ein paar Sekunden' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_36_en' ,'PUSHED_TO_CONFIG' ,@locale ,36 ,'OTP_FORM_PAGE' ,'Ihre mobile TAN wird versendet' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_37_en' ,'PUSHED_TO_CONFIG' ,@locale ,37 ,'OTP_FORM_PAGE' ,'Bitte warten Sie ein paar Sekunden' ,@idNetworkVisa , NULL ,@idCustomItemSet),

('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_40_en' ,'PUSHED_TO_CONFIG' ,@locale ,40 ,'OTP_FORM_PAGE' ,'Abbrechen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_41_en' ,'PUSHED_TO_CONFIG' ,@locale ,41 ,'OTP_FORM_PAGE' ,'Hilfe' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_OTP_FORM_PAGE_53_en' ,'PUSHED_TO_CONFIG' ,@locale ,53 ,'OTP_FORM_PAGE' ,'TAN' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_REFUSAL_PAGE_1_de' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'REFUSAL_PAGE' ,'Bitte bestätigen Sie folgende Zahlung' ,@idNetworkVisa , NULL ,@idCustomItemSet),

('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_REFUSAL_PAGE_5_de' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'REFUSAL_PAGE' ,'Hilfe & FAQ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_REFUSAL_PAGE_6_de' ,'PUSHED_TO_CONFIG' ,@locale ,6 ,'REFUSAL_PAGE' ,'Wir sind für Sie da: 0911 - 369 30 00' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_REFUSAL_PAGE_7_de' ,'PUSHED_TO_CONFIG' ,@locale ,7 ,'REFUSAL_PAGE' ,'Mo-So: 7:00 Uhr - 22:30 Uhr' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_REFUSAL_PAGE_8_de' ,'PUSHED_TO_CONFIG' ,@locale ,8 ,'REFUSAL_PAGE' ,'(Halten Sie als Kunde bitte Ihre Kontonummer bereit.)' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_REFUSAL_PAGE_9_de' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'REFUSAL_PAGE' ,'VISA Secure - ein Service von VISA in Kooperation mit Consorsbank' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_REFUSAL_PAGE_10_de' ,'PUSHED_TO_CONFIG' ,@locale ,10 ,'REFUSAL_PAGE' ,'&copy; VISA Europe' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_REFUSAL_PAGE_22_en' ,'PUSHED_TO_CONFIG' ,@locale ,22 ,'REFUSAL_PAGE' ,'Ihr mobiler TAN-Service wurde gesperrt' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_REFUSAL_PAGE_23_en' ,'PUSHED_TO_CONFIG' ,@locale ,23 ,'REFUSAL_PAGE' ,'Die Prüfung der mobilen TAN ist fehlgeschlagen. Bitte beachten Sie: Sie haben dreimal eine falsche mobile TAN eingeben. Ihr mobiler TAN-Service wurde aus Sicherheitsgründen gesperrt. Bitte wenden Sie sich an Ihr persönliches Betreuungsteam.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_REFUSAL_PAGE_32_en' ,'PUSHED_TO_CONFIG' ,@locale ,32 ,'REFUSAL_PAGE' ,'Technischer Fehler' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_REFUSAL_PAGE_PAGE_33_en' ,'PUSHED_TO_CONFIG' ,@locale ,33 ,'REFUSAL_PAGE' ,'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.' ,@idNetworkVisa , NULL ,@idCustomItemSet),

('T' ,'A169318' , NOW() ,NULL ,'REFUSAL_REFUSAL_PAGE_40_en' ,'PUSHED_TO_CONFIG' ,@locale ,40 ,'REFUSAL_PAGE' ,'Abbrechen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'REFUSAL_REFUSAL_PAGE_41_en' ,'PUSHED_TO_CONFIG' ,@locale ,41 ,'REFUSAL_PAGE' ,'Hilfe' ,@idNetworkVisa , NULL ,@idCustomItemSet);
