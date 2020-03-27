USE `U5G_ACS_BO`;

SET @codeSubIssuer = '16900';
SET @nameCustomItemSet = 'customitemset_16900_MOBILE_APP_EXT';
SET @issuerIdREISEBANK = (SELECT id FROM `SubIssuer` WHERE `code` = @codeSubIssuer);

SET @idCustomItemSet = (SELECT id FROM `CustomItemSet` WHERE `name` = @nameCustomItemSet);

SET @idImageVisa = (SELECT id FROM `Image` WHERE `name` = 'VISA_LOGO');
SET @bankLogo = (SELECT id FROM `Image` WHERE `name` = 'Consorsbank');
SET @mobileAppLogo = (SELECT id FROM `Image` WHERE `name` = 'Consors Mobile APP Logo');
SET @idNetworkVisa = (SELECT id FROM `Network` WHERE `code` = 'VISA');

SET @locale = 'de';

-- 12. CustomItem

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES
('I' ,'A169318' , NOW() ,NULL ,'Bank Logo' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'ALL' ,'Consorsbank' ,@idNetworkVisa , @bankLogo ,@idCustomItemSet),
('I' ,'A169318' , NOW() ,NULL ,'VISA Logo' ,'PUSHED_TO_CONFIG' ,@locale ,2 ,'ALL' ,'VISA' ,@idNetworkVisa , @idImageVisa ,@idCustomItemSet),
('I' ,'A169318' , NOW() ,NULL ,'Mobile App Logo' ,'PUSHED_TO_CONFIG' ,@locale ,3 ,'ALL' ,'Mobile App Logo' ,@idNetworkVisa , @mobileAppLogo ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'Phone Symbol' ,'PUSHED_TO_CONFIG' ,@locale ,4 ,'ALL' ,'Phone Symbol' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'Smartphone Picture' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'ALL' ,'Smartphone Picture' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA Logo' ,'PUSHED_TO_CONFIG' ,@locale ,104 ,'ALL' ,'Gerätenummer / -name' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_ALL_MERCHANT_NAME_100_de' ,'PUSHED_TO_CONFIG' ,@locale ,100 ,'ALL' ,'Onlinehändler' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'16500_OTP_SIDE_MENU_10_de' ,'PUSHED_TO_CONFIG' ,@locale ,100 ,'ALL' ,'Onlinehändler' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_1_de' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'FAILURE_PAGE' ,'Bitte bestätigen Sie folgende Zahlung' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_FAILURE_PAGE_3_de' ,'PUSHED_TO_CONFIG' ,@locale ,3 ,'FAILURE_PAGE' ,'<b>069 / 34 22 24</b><br>' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_FAILURE_PAGE_4_de' ,'PUSHED_TO_CONFIG' ,@locale ,4 ,'FAILURE_PAGE' ,'Zurück zum Shop' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_FAILURE_PAGE_5_de' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'FAILURE_PAGE' ,'Was ist passiert? Wir haben Ihren Zugang aus Sicherheitsgründen gesperrt. Sie können ihn aber jederzeit wieder entsperren. Rufen Sie uns einfach unter 069 / 34 22 24 an. Und halten Sie Ihre ING Kontonummer und die Telebanking PIN bereit.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA _MOBILE_APP_FAILURE_PAGE_5_de' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'FAILURE_PAGE' ,'Hilfe & FAQ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA _MOBILE_APP_FAILURE_PAGE_6_de' ,'PUSHED_TO_CONFIG' ,@locale ,6 ,'FAILURE_PAGE' ,'Wir sind für Sie da: 0911 - 369 30 00' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA _MOBILE_APP_FAILURE_PAGE_7_de' ,'PUSHED_TO_CONFIG' ,@locale ,7 ,'FAILURE_PAGE' ,'Mo-So: 7:00 Uhr - 22:30 Uhr' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA _MOBILE_APP_FAILURE_PAGE_8_de' ,'PUSHED_TO_CONFIG' ,@locale ,8 ,'FAILURE_PAGE' ,'(Halten Sie als Kunde bitte Ihre Kontonummer bereit.)' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA _MOBILE_APP_FAILURE_PAGE_9_de' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'FAILURE_PAGE' ,'VISA Secure - ein Service von VISA in Kooperation mit Consorsbank' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_FAILURE_PAGE_9_de' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'FAILURE_PAGE' ,'Hilfe' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA _MOBILE_APP_FAILURE_PAGE_10_de' ,'PUSHED_TO_CONFIG' ,@locale ,10 ,'FAILURE_PAGE' ,'&copy; VISA Europe' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_FAILURE_PAGE_11_de' ,'PUSHED_TO_CONFIG' ,@locale ,11 ,'FAILURE_PAGE' ,'Infos zu VISA Secure' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_FAILURE_PAGE_12_de' ,'PUSHED_TO_CONFIG' ,@locale ,12 ,'FAILURE_PAGE' ,'Schließen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_OTP_FAILURE_PAGE_16_de' ,'PUSHED_TO_CONFIG' ,@locale ,16 ,'FAILURE_PAGE' ,'Ihr Authentifizierungsverfahren wurde gesperrt' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_OTP_FAILURE_PAGE_17_de' ,'PUSHED_TO_CONFIG' ,@locale ,17 ,'FAILURE_PAGE' ,'Beachten Sie bitte, dass aus Sicherheitsgründen aufgrund mehrfach falscher Authentifizierung Ihr Authentifizierungs-Verfahren gesperrt wurde. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_OTP_FAILURE_PAGE_22_de' ,'PUSHED_TO_CONFIG' ,@locale ,22 ,'FAILURE_PAGE' ,'Ihr Zugang wurde aus Sicherheitsgründen gesperrt' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_OTP_FAILURE_PAGE_23_de' ,'PUSHED_TO_CONFIG' ,@locale ,23 ,'FAILURE_PAGE' ,'Bitte entsperren Sie Ihren Zugang.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_OTP_FAILURE_PAGE_32_de' ,'PUSHED_TO_CONFIG' ,@locale ,32 ,'FAILURE_PAGE' ,'Technischer Fehler' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_OTP_FAILURE_PAGE_33_de' ,'PUSHED_TO_CONFIG' ,@locale ,33 ,'FAILURE_PAGE' ,'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_1_en' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'HELP_PAGE' ,'<b>Informationen über Visa Secure</b></br>Visa Secure ist ein Service von Visa und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_2_en' ,'PUSHED_TO_CONFIG' ,@locale ,2 ,'HELP_PAGE' ,'<b>Registrierung für Visa Secure</b></br>Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Consorsbank Visa Card  automatisch für den Visa Secure Service  angemeldet.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_3_en' ,'PUSHED_TO_CONFIG' ,@locale ,3 ,'HELP_PAGE' ,'<b>Deaktivierung des Visa Secure Service</b></br>Solange Sie ein Girokonto und eine Visa Card bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_4_en' ,'PUSHED_TO_CONFIG' ,@locale ,4 ,'HELP_PAGE' ,'<b>Höhere Sicherheit durch Visa Secure</b></br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_5_en' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'HELP_PAGE' ,'<b>Falscheingabe der Visa Secure TAN</b></br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Service weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_HELP_PAGE_11_de' ,'PUSHED_TO_CONFIG' ,@locale ,11 ,'HELP_PAGE' ,'Schließen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_POLLING_PAGE_1_de' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'POLLING_PAGE' ,'Bitte bestätigen Sie folgende Zahlung' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_POLLING_PAGE_3_en' ,'PUSHED_TO_CONFIG' ,@locale ,3 ,'POLLING_PAGE' ,'SecurePlus Freigabe' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_POLLING_PAGE_3_en' ,'PUSHED_TO_CONFIG' ,@locale ,4 ,'POLLING_PAGE' ,'Wir haben Ihnen über Ihre Secure<b>Plus</b> App eine Anfrage geschickt. Bitte öffnen Sie die App und geben Sie die Zahlung frei.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_POLLING_PAGE_5_en' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'POLLING_PAGE' ,'Hilfe & FAQ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_POLLING_PAGE_6_en' ,'PUSHED_TO_CONFIG' ,@locale ,6 ,'POLLING_PAGE' ,'Wir sind für Sie da: 0911 - 369 30 00' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_POLLING_PAGE_7_en' ,'PUSHED_TO_CONFIG' ,@locale ,7 ,'POLLING_PAGE' ,'Mo-So: 7:00 Uhr - 22:30 Uhr' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_POLLING_PAGE_8_en' ,'PUSHED_TO_CONFIG' ,@locale ,8 ,'POLLING_PAGE' ,'(Halten Sie als Kunde bitte Ihre Kontonummer bereit.)' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_POLLING_PAGE_9_en' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'POLLING_PAGE' ,'Verifed by Visa - ein Service von VISA in Kooperation mit Consorsbank' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_POLLING_PAGE_10_en' ,'PUSHED_TO_CONFIG' ,@locale ,10 ,'POLLING_PAGE' ,'&copy; VISA Europe' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_POLLING_PAGE_4_en' ,'PUSHED_TO_CONFIG' ,@locale ,11 ,'POLLING_PAGE' ,'Abbrechen und zurück zum Händler' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_12_de' ,'PUSHED_TO_CONFIG' ,@locale ,12 ,'POLLING_PAGE' ,'Authentifizierung läuft' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_13_de' ,'PUSHED_TO_CONFIG' ,@locale ,13 ,'POLLING_PAGE' ,'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_14_de' ,'PUSHED_TO_CONFIG' ,@locale ,14 ,'POLLING_PAGE' ,'Sie haben die Bezahlung abgebrochen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_15_de' ,'PUSHED_TO_CONFIG' ,@locale ,15 ,'POLLING_PAGE' ,'Falls Sie den Artikel dennoch kaufen möchten, starten Sie den Zahlungsvorgang bitte erneut.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_16_de' ,'PUSHED_TO_CONFIG' ,@locale ,16 ,'POLLING_PAGE' ,'Ihr Zugang wurde aus Sicherheitsgründen gesperrt' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_17_de' ,'PUSHED_TO_CONFIG' ,@locale ,17 ,'POLLING_PAGE' ,'Bitte entsperren Sie Ihren Zugang.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_22_de' ,'PUSHED_TO_CONFIG' ,@locale ,22 ,'POLLING_PAGE' ,'Ihr Zugang wurde aus Sicherheitsgründen gesperrt' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_23_de' ,'PUSHED_TO_CONFIG' ,@locale ,23 ,'POLLING_PAGE' ,'Bitte entsperren Sie Ihren Zugang.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_26_de' ,'PUSHED_TO_CONFIG' ,@locale ,26 ,'POLLING_PAGE' ,'Authentifizierung erfolgreich' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_27_de' ,'PUSHED_TO_CONFIG' ,@locale ,27 ,'POLLING_PAGE' ,'Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_30_de' ,'PUSHED_TO_CONFIG' ,@locale ,30 ,'POLLING_PAGE' ,'Session abgelaufen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_31_de' ,'PUSHED_TO_CONFIG' ,@locale ,31 ,'POLLING_PAGE' ,'Das Zeitlimit wurde überschritten. Aus Sicherheitsgründen wird die Transaktion abgebrochen. Bitte versuchen Sie es erneut. Bei Fragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_32_de' ,'PUSHED_TO_CONFIG' ,@locale ,32 ,'POLLING_PAGE' ,'Technischer Fehler' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_33_de' ,'PUSHED_TO_CONFIG' ,@locale ,33 ,'POLLING_PAGE' ,'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_42_de' ,'PUSHED_TO_CONFIG' ,@locale ,42 ,'POLLING_PAGE' ,'<b>Angaben</b>' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_POLLING_PAGE_43_de' ,'PUSHED_TO_CONFIG' ,@locale ,43 ,'POLLING_PAGE' ,'<b>Freigabe</b>' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_1_de' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'REFUSAL_PAGE' ,'Bitte bestätigen Sie folgende Zahlung' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_5_de' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'REFUSAL_PAGE' ,'Hilfe & FAQ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_6_de' ,'PUSHED_TO_CONFIG' ,@locale ,6 ,'REFUSAL_PAGE' ,'Wir sind für Sie da: 0911 - 369 30 00' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_7_de' ,'PUSHED_TO_CONFIG' ,@locale ,7 ,'REFUSAL_PAGE' ,'Mo-So: 7:00 Uhr - 22:30 Uhr' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_8_de' ,'PUSHED_TO_CONFIG' ,@locale ,8 ,'REFUSAL_PAGE' ,'(Halten Sie als Kunde bitte Ihre Kontonummer bereit.)' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_9_de' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'REFUSAL_PAGE' ,'VISA Secure - ein Service von VISA in Kooperation mit Consorsbank' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_10_de' ,'PUSHED_TO_CONFIG' ,@locale ,10 ,'REFUSAL_PAGE' ,'&copy; VISA Europe' ,@idNetworkVisa , NULL ,@idCustomItemSet);