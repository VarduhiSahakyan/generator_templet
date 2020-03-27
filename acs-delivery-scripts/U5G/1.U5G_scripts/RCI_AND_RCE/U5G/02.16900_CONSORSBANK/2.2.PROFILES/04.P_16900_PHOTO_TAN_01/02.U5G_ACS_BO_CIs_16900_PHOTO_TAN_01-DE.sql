USE `U5G_ACS_BO`;

SET @codeSubIssuer = '16900';
SET @nameCustomItemSet = 'customitemset_16900_PHOTO_TAN';
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
('T' ,'A169318' , NOW() ,NULL ,'Bank Logo' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'ALL' ,'Consorsbank' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'Visa logo' ,'PUSHED_TO_CONFIG' ,@locale ,2 ,'ALL' ,'Visa' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_ALL_100_de' ,'PUSHED_TO_CONFIG' ,@locale ,100 ,'ALL' ,'Händler' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_ALL_101_de' ,'PUSHED_TO_CONFIG' ,@locale ,101 ,'ALL' ,'Betrag' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_ALL_102_de' ,'PUSHED_TO_CONFIG' ,@locale ,102 ,'ALL' ,'Datum' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_ALL_103_de' ,'PUSHED_TO_CONFIG' ,@locale ,103 ,'ALL' ,'Kreditkartennummer' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_ALL_104_de' ,'PUSHED_TO_CONFIG' ,@locale ,104 ,'ALL' ,'Gerätenummer / -name' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_1_de' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'FAILURE_PAGE' ,'Bitte bestätigen Sie folgende Zahlung' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_3_de' ,'PUSHED_TO_CONFIG' ,@locale ,3 ,'FAILURE_PAGE' ,'SecurePlus Freigabe' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_4_de' ,'PUSHED_TO_CONFIG' ,@locale ,4 ,'FAILURE_PAGE' ,'Wir haben Ihnen über Ihre Secure<b>Plus</b> App eine Anfrage geschickt. Bitte öffnen Sie die App und geben Sie die Zahlung frei.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_5_de' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'FAILURE_PAGE' ,'Hilfe & FAQ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_6_de' ,'PUSHED_TO_CONFIG' ,@locale ,6 ,'FAILURE_PAGE' ,'Wir sind für Sie da: 0911 - 369 30 00' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_7_de' ,'PUSHED_TO_CONFIG' ,@locale ,7 ,'FAILURE_PAGE' ,'Mo-So: 7:00 Uhr - 22:30 Uhr' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_8_de' ,'PUSHED_TO_CONFIG' ,@locale ,8 ,'FAILURE_PAGE' ,'(Halten Sie als Kunde bitte Ihre Kontonummer bereit.)' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_9_de' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'FAILURE_PAGE' ,'VISA Secure - ein Service von VISA in Kooperation mit Consorsbank' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_10_de' ,'PUSHED_TO_CONFIG' ,@locale ,10 ,'FAILURE_PAGE' ,'&copy; VISA Europa 2018' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_16_de' ,'PUSHED_TO_CONFIG' ,@locale ,16 ,'FAILURE_PAGE' ,'Ihr TAN-Verfahren wurde gesperrt' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_17_de' ,'PUSHED_TO_CONFIG' ,@locale ,17 ,'FAILURE_PAGE' ,'Die TAN-Prüfung ist fehlgeschlagen. Beachten Sie bitte, dass aus Sicherheitsgründen aufgrund dreimaliger falscher TAN-Eingabe Ihr TAN-Verfahren gesperrt wurde.</br>
Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_FAILURE_PAGE_8_de' ,'PUSHED_TO_CONFIG' ,@locale ,53 ,'FAILURE_PAGE' ,'Zurück zum Händler' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_1_en' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'HELP_PAGE' ,'<b>Informationen über Visa Secure</b></br>Visa Secure ist ein Service von Visa und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_2_en' ,'PUSHED_TO_CONFIG' ,@locale ,2 ,'HELP_PAGE' ,'<b>Registrierung für Visa Secure</b></br>Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Consorsbank Visa Card  automatisch für den Visa Secure Service  angemeldet.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_3_en' ,'PUSHED_TO_CONFIG' ,@locale ,3 ,'HELP_PAGE' ,'<b>Deaktivierung des Visa Secure Service</b></br>Solange Sie ein Girokonto und eine Visa Card bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_4_en' ,'PUSHED_TO_CONFIG' ,@locale ,4 ,'HELP_PAGE' ,'<b>Höhere Sicherheit durch Visa Secure</b></br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'OTP_SMS_HELP_PAGE_5_en' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'HELP_PAGE' ,'<b>Falscheingabe der Visa Secure TAN</b></br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Service weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_MOBILE_APP_HELP_PAGE_11_de' ,'PUSHED_TO_CONFIG' ,@locale ,11 ,'HELP_PAGE' ,'Schließen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_OTP_FORM_PAGE_1_de' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'OTP_FORM_PAGE' ,'Bitte bestätigen Sie folgende Zahlung' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_OTP_FORM_PAGE_3_de' ,'PUSHED_TO_CONFIG' ,@locale ,3 ,'OTP_FORM_PAGE' ,'QR-Code Eingabe' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_OTP_FORM_PAGE_4_de' ,'PUSHED_TO_CONFIG' ,@locale ,4 ,'OTP_FORM_PAGE' ,'Scannen Sie den QR-Code mit der SecurePlus App oder Ihrem Generator' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_OTP_FORM_PAGE_9_de' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'OTP_FORM_PAGE' ,'Hilfe & FAQ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_OTP_FORM_PAGE_10_de' ,'PUSHED_TO_CONFIG' ,@locale ,6 ,'OTP_FORM_PAGE' ,'Wir sind für Sie da: 0911 - 369 30 00' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_OTP_FORM_PAGE_10_de' ,'PUSHED_TO_CONFIG' ,@locale ,7 ,'OTP_FORM_PAGE' ,'Mo-So: 7:00 Uhr – 22:30 Uhr' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_OTP_FORM_PAGE_53_de' ,'PUSHED_TO_CONFIG' ,@locale ,8 ,'OTP_FORM_PAGE' ,'(Halten Sie als Kunde bitte Ihre Kontonummer bereit.)' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_OTP_FORM_PAGE_53_de' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'OTP_FORM_PAGE' ,'VISA Secure – ein Service von VISA in Kooperation mit der Consorsbank' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_OTP_FORM_PAGE_53_de' ,'PUSHED_TO_CONFIG' ,@locale ,10 ,'OTP_FORM_PAGE' ,'&copy; VISA Europe' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_11_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_11_de' ,'PUSHED_TO_CONFIG' ,@locale ,11 ,'OTP_FORM_PAGE' ,'Scannen Sie bitte jetzt den abgebildeten QR-Code mit Ihrer SecurePlus App oder dem SecurePlus Generator. Geben Sie die generierte QR-TAN ein.<br>Sie generieren die QR-TAN folgendermaßen:<br><b>SecurePlus App:</b> - Button „QR-TAN generieren“ > in die App einloggen > QR-Code scannen<br><b>SecurePlus Generator:</b> - mit OK-Taste einschalten > QR-Code scannen<br>' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_12_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_12_de' ,'PUSHED_TO_CONFIG' ,@locale ,12 ,'OTP_FORM_PAGE' ,'Ihre QR-TAN wird geprüft' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_13_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_13_de' ,'PUSHED_TO_CONFIG' ,@locale ,13 ,'OTP_FORM_PAGE' ,'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre QR-TAN.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_14_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_14_de' ,'PUSHED_TO_CONFIG' ,@locale ,14 ,'OTP_FORM_PAGE' ,'Sie haben die Bezahlung abgebrochen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_15_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_15_de' ,'PUSHED_TO_CONFIG' ,@locale ,15 ,'OTP_FORM_PAGE' ,'Falls Sie den Artikel dennoch kaufen möchten, starten Sie den Zahlungsvorgang bitte erneut.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_18_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_18_de' ,'PUSHED_TO_CONFIG' ,@locale ,18 ,'OTP_FORM_PAGE' ,'QR-TAN' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_19_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_19_de' ,'PUSHED_TO_CONFIG' ,@locale ,19 ,'OTP_FORM_PAGE' ,'Bestätigen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_22_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_22_de' ,'PUSHED_TO_CONFIG' ,@locale ,22 ,'OTP_FORM_PAGE' ,'Ihr TAN-Verfahren wurde gesperrt' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_23_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_23_de' ,'PUSHED_TO_CONFIG' ,@locale ,23 ,'OTP_FORM_PAGE' ,'Die Prüfung der QR-TAN ist fehlgeschlagen. Bitte beachten Sie: Sie haben dreimal eine falsche QR-TAN eingegeben. Ihr TAN-Verfahren wurde aus Sicherheitsgründen gesperrt. Bitte wenden Sie sich an Ihr persönliches Betreuungsteam.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_26_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_26_de' ,'PUSHED_TO_CONFIG' ,@locale ,26 ,'OTP_FORM_PAGE' ,'Ihre Authentifizierung war erfolgreich' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_27_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_27_de' ,'PUSHED_TO_CONFIG' ,@locale ,27 ,'OTP_FORM_PAGE' ,'Sie wurden erfolgreich authentifiziert und werden automatisch zur Händler-Website weitergeleitet.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_28_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_28_de' ,'PUSHED_TO_CONFIG' ,@locale ,28 ,'OTP_FORM_PAGE' ,'Ungültige  QR-TAN' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_29_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_29_de' ,'PUSHED_TO_CONFIG' ,@locale ,29 ,'OTP_FORM_PAGE' ,'Die Prüfung der QR-TAN ist fehlgeschlagen. Nach dreimaliger falscher Eingabe der QR-TAN wird Ihr TAN-Verfahren gesperrt.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_30_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_30_de' ,'PUSHED_TO_CONFIG' ,@locale ,30 ,'OTP_FORM_PAGE' ,'Ihre Session ist abgelaufen' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_31_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_31_de' ,'PUSHED_TO_CONFIG' ,@locale ,31 ,'OTP_FORM_PAGE' ,'Das Zeitlimit wurde überschritten. Aus Sicherheitsgründen wird die Transaktion abgebrochen. Bitte versuchen Sie es erneut.Bei Fragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_32_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_32_de' ,'PUSHED_TO_CONFIG' ,@locale ,32 ,'OTP_FORM_PAGE' ,'Technischer Fehler' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A513048' , NOW() ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_33_de' ,'VISA_PHOTO_TAN_OTP_FORM_PAGE_33_de' ,'PUSHED_TO_CONFIG' ,@locale ,33 ,'OTP_FORM_PAGE' ,'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_OTP_FORM_PAGE_55_de' ,'PUSHED_TO_CONFIG' ,@locale ,55 ,'OTP_FORM_PAGE' ,'Abbrechen und zurück zum Händler' ,@idNetworkVisa , NULL ,@idCustomItemSet);
