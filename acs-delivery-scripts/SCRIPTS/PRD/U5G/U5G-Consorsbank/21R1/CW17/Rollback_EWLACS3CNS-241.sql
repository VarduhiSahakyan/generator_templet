USE `U5G_ACS_BO`;

SET @createdBy = 'W100851';
SET @allPageType ='ALL';
SET @updateState = 'PUSHED_TO_CONFIG';
SET @MaestroVID = (SELECT id FROM `Network` WHERE code = 'VISA');
SET @MaestroVName = (SELECT name FROM `Network` WHERE code = 'VISA');

SET @BankUB = '16900';
SET @helpPageType ='HELP_PAGE';
SET @refusalPageType ='REFUSAL_PAGE';
SET @polingPageType ='POLLING_PAGE';
SET @failurePageType ='FAILURE_PAGE';
SET @otpFormPageType = 'OTP_FORM_PAGE';

SET @otpPhotoTahAuthentMean ='OTP_PHOTOTAN';
SET @mobileAppAuthentMean ='MOBILE_APP';
SET @smsAppAuthentMean ='SMS';
SET @extPassAppAuthentMean ='EXT_PASSWORD_EXT_PASSWORD';

SET @refusalCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_1_REFUSAL'));


SET @textValue = '<b>Informationen über Visa Secure</b></br>Visa Secure ist ein Service von Visa und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;

SET @textValue = '<b>Registrierung für Visa Secure</b></br>Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Consorsbank Visa Card  automatisch für den Visa Secure Service  angemeldet.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 2
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = '<b>Deaktivierung des Visa Secure Service</b></br>Solange Sie ein Girokonto und eine Visa Card bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = '<b>Höhere Sicherheit durch Visa Secure</b></br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = '<b>Falscheingabe der Visa Secure TAN</b></br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Service weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 5
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = 'Schließen';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 11
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = 'Bitte bestätigen Sie folgende Zahlung';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @refusalPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = 'Ihre  Zahlung mit Visa Secure wurde abgelehnt';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 22
AND locale = 'de'
AND pageTypes = @refusalPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = 'Aus Sicherheitsgründen wurde der Einkauf mit Visa Secure abgelehnt. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 23
AND locale = 'de'
AND pageTypes = @refusalPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @mobileAppCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_MOBILE_APP_EXT'));


SET @textValue = '<b>Informationen über Visa Secure</b></br>Visa Secure ist ein Service von Visa und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = '<b>Registrierung für Visa Secure</b></br>Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Consorsbank Visa Card  automatisch für den Visa Secure Service  angemeldet.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 2
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = '<b>Deaktivierung des Visa Secure Service</b></br>Solange Sie ein Girokonto und eine Visa Card bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = '<b>Höhere Sicherheit durch Visa Secure</b></br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = '<b>Falscheingabe der Visa Secure TAN</b></br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Service weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 5
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'Schließen';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 11
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;




SET @textValue = 'Wir haben Ihnen über Ihre Secure<b>Plus</b> App eine Anfrage geschickt. Bitte öffnen Sie die App und geben Sie die Zahlung frei.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'Authentifizierung läuft';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 12
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'Authentifizierung erfolgreich';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 26
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;



SET @textValue = 'Sie haben die Bezahlung abgebrochen';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 14
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;



SET @textValue = 'Falls Sie den Artikel dennoch kaufen möchten, starten Sie den Zahlungsvorgang bitte erneut.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 15
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'Session abgelaufen';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 30
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'Das Zeitlimit wurde überschritten. Aus Sicherheitsgründen wird die Transaktion abgebrochen. Bitte versuchen Sie es erneut. Bei Fragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 31
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'Technischer Fehler';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 32
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'Bitte bestätigen Sie folgende Zahlung';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @failurePageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'Ihr Authentifizierungsverfahren wurde gesperrt';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 16
AND locale = 'de'
AND pageTypes = @failurePageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;



SET @photoTanCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_PHOTO_TAN'));


SET @textValue = '<b>Informationen über Visa Secure</b></br>Visa Secure ist ein Service von Visa und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;

SET @textValue = '<b>Registrierung für Visa Secure</b></br>Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Consorsbank Visa Card  automatisch für den Visa Secure Service  angemeldet.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 2
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = '<b>Deaktivierung des Visa Secure Service</b></br>Solange Sie ein Girokonto und eine Visa Card bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = '<b>Höhere Sicherheit durch Visa Secure</b></br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = '<b>Falscheingabe der Visa Secure TAN</b></br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Service weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 5
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = 'Schließen';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 11
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = 'Scannen Sie bitte jetzt den abgebildeten QR-Code mit Ihrer SecurePlus App oder dem SecurePlus Generator. Geben Sie die generierte QR-TAN ein.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 11
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;

SET @textValue = 'Ihre QR-TAN wird geprüft';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 12
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;

SET @textValue = 'Ungültige  QR-TAN';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 28
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;

SET @textValue = 'Ihre Authentifizierung war erfolgreich';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 26
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = 'Sie haben die Bezahlung abgebrochen';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 14
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = 'Falls Sie den Artikel dennoch kaufen möchten, starten Sie den Zahlungsvorgang bitte erneut.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 15
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = 'Ihre Session ist abgelaufen';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 30
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;



SET @textValue = 'Das Zeitlimit wurde überschritten. Aus Sicherheitsgründen wird die Transaktion abgebrochen. Bitte versuchen Sie es erneut.Bei Fragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 31
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = 'Technischer Fehler';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 32
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = 'Bitte bestätigen Sie folgende Zahlung';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @failurePageType
AND fk_id_customItemSet = @photoTanCustomItemSet;

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @passwordCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_PASSWORD'));

SET @textValue = '<b>Informationen über Visa Secure</b></br>Visa Secure ist ein Service von VISA und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz von der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = '<b>Registrierung für Visa Secure</b></br>Eine separate Registrierung bei VISA ist nicht erforderlich. Sie werden als Inhaber der Consorsbank girocard sowie der VISA Card  automatisch für den Visa Secure Service  angemeldet.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 2
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = '<b>Deaktivierung des Visa Secure Service</b></br>Solange Sie ein Girokonto und eine VISA Card bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = '<b>Höhere Sicherheit durch Visa Secure</b></br>Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren (mobile TAN oder TAN-Generator). Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.</br></br>';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = '<b>Falscheingabe der Visa Secure TAN</b></br>Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre VISA Card behält während der Sperre des TAN-Service weiterhin Ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 5
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = 'Schließen';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 11
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = 'Ihre Session ist abgelaufen';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 30
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Geben Sie <b>zweimal</b> nacheinander die <b>@challenge1</b> Stelle Ihrer 5-stelligen Consorsbank Online PIN ohne Komma und Leerzeichen ein (z. B. „1k1k“).';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 11
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Ihre Transaktion wurde abgebrochen';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 14
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Sie haben den Bezahlvorgang abgebrochen. Falls Sie den Artikel dennoch kaufen wollen, starten Sie den Bezahlvorgang bitte erneut.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 15
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Die PIN Prüfung war erfolgreich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 26
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Es folgt der nächste Authentifizierungsschritt.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 27
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'PIN  fehlerhaft.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 28
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Ihre Session ist abgelaufen';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 30
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Aus Sicherheitsgründen wurde die Transaktion aufgrund Überschreitung des Zeitlimits abgebrochen. Bitte versuchen Sie es erneut.</br>Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 31
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = 'Technischer Fehler';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 32
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = 'Verifizierung Ihrer Zahlung an';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue12 = 'AUTHENTIFIZIERUNG LÄUFT';
SET @textValue13 = 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.';
SET @textValue = 'Kreditkartennummer';

START TRANSACTION;
DELETE FROM CustomItem WHERE value = @textValue12 AND pageTypes = @allPageType AND ordinal = 12 AND fk_id_customItemSet = @passwordCustomItemSet;
DELETE FROM CustomItem WHERE value = @textValue13 AND pageTypes = @allPageType AND ordinal = 13 AND fk_id_customItemSet = @passwordCustomItemSet;

DELETE FROM CustomItem WHERE value = @textValue AND pageTypes = @allPageType AND ordinal = 103 AND fk_id_customItemSet = @mobileAppCustomItemSet;

DELETE FROM CustomItem WHERE value = @textValue AND pageTypes = @allPageType AND ordinal = 103 AND fk_id_customItemSet = @refusalCustomItemSet;
COMMIT;