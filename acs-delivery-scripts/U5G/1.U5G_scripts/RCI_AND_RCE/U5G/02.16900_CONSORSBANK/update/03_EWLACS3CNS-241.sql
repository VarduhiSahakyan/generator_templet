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


SET @textValue = '<b>Informationen über Visa Secure</b></br>
Visa Secure ist ein Service von Visa und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor unberechtigter Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen oder Ihre Kreditkartendaten bei Händlern abgesichert hinterlegen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;

SET @textValue = '<b>Registrierung für Visa Secure</b></br>
Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber einer Consorsbank Visa Karte automatisch für den Visa Secure Service angemeldet.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 2
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = '<b>Deaktivierung des Visa Secure Service</b></br>
Solange Sie ein Girokonto und eine Visa Karte bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = '<b>Höhere Sicherheit durch Visa Secure beim Online-Einkauf</b></br>
Zukünftig öffnet sich beim Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte Autorisierungsverfahren. Ihr Online-Einkauf wird durch Ihre Autorisierung zusätzlich abgesichert.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = '<b>Falscheingabe der Visa Secure TAN</b></br>
Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Karte behält während der Sperre des TAN-Service weiterhin Ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.';

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


SET @textValue = 'Bitte bestätigen Sie folgende Zahlung / Kreditkartendaten';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @refusalPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = 'IHR VISA SECURE VORGANG WURDE ABGELEHNT';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 22
AND locale = 'de'
AND pageTypes = @refusalPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = 'Aus Sicherheitsgründen wurde der Visa Secure Vorgang abgelehnt. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 23
AND locale = 'de'
AND pageTypes = @refusalPageType
AND fk_id_customItemSet = @refusalCustomItemSet;

SET @textValue = 'Kreditkartennummer';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpPhotoTahAuthentMean,'_',@allPageType,'_103'), @updateState,
 'de', 103, @allPageType,  @textValue, @MaestroVID, NULL, @refusalCustomItemSet);


SET @mobileAppCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_MOBILE_APP_EXT'));


SET @textValue = '<b>Informationen über Visa Secure</b></br>
Visa Secure ist ein Service von Visa und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor unberechtigter Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen oder Ihre Kreditkartendaten bei Händlern abgesichert hinterlegen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = '<b>Registrierung für Visa Secure</b></br>
Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber einer Consorsbank Visa Karte automatisch für den Visa Secure Service angemeldet.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 2
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = '<b>Deaktivierung des Visa Secure Service</b></br>
Solange Sie ein Girokonto und eine Visa Karte bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = '<b>Höhere Sicherheit durch Visa Secure beim Online-Einkauf</b></br>
Zukünftig öffnet sich beim Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte Autorisierungsverfahren. Ihr Online-Einkauf wird durch Ihre Autorisierung zusätzlich abgesichert.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = '<b>Falscheingabe der Visa Secure TAN</b></br>
Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Karte behält während der Sperre des TAN-Service weiterhin Ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.';

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




SET @textValue = 'Wir haben Ihnen über Ihre SecurePlus App eine Anfrage geschickt. Bitte öffnen Sie die App und geben Sie die Zahlung / Kreditkartendaten frei.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'AUTHENTIFIZIERUNG LÄUFT';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 12
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'AUTHENTIFIZIERUNG ERFOLGREICH';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 26
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;



SET @textValue = 'SIE HABEN DEN VORGANG ABGEBROCHEN';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 14
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;



SET @textValue = 'Falls Sie den Artikel dennoch kaufen oder Ihre Kreditkartendaten bestätigen möchten, starten Sie den Vorgang bitte erneut.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 15
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'IHRE SESSION IST ABGELAUFEN';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 30
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'Das Zeitlimit wurde überschritten. Aus Sicherheitsgründen wird der Vorgang abgebrochen. Bitte versuchen Sie es erneut. Bei Fragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 31
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'TECHNISCHER FEHLER';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 32
AND locale = 'de'
AND pageTypes = @polingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'Bitte bestätigen Sie folgende Zahlung / Kreditkartendaten';

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

SET @textValue = 'IHR AUTHENTIFIZIERUNGSVERFAHREN WURDE GESPERRT';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 16
AND locale = 'de'
AND pageTypes = @failurePageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;



SET @textValue = 'Kreditkartennummer';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@mobileAppAuthentMean,'_',@allPageType,'_103'), @updateState,
 'de', 103, @allPageType,  @textValue, @MaestroVID, NULL, @mobileAppCustomItemSet);



SET @photoTanCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_PHOTO_TAN'));


SET @textValue = '<b>Informationen über Visa Secure</b></br>
Visa Secure ist ein Service von Visa und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor unberechtigter Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen oder Ihre Kreditkartendaten bei Händlern abgesichert hinterlegen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;

SET @textValue = '<b>Registrierung für Visa Secure</b></br>
Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber einer Consorsbank Visa Karte automatisch für den Visa Secure Service angemeldet.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 2
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = '<b>Deaktivierung des Visa Secure Service</b></br>
Solange Sie ein Girokonto und eine Visa Karte bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = '<b>Höhere Sicherheit durch Visa Secure beim Online-Einkauf</b></br>
Zukünftig öffnet sich beim Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte Autorisierungsverfahren. Ihr Online-Einkauf wird durch Ihre Autorisierung zusätzlich abgesichert.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = '<b>Falscheingabe der Visa Secure TAN</b></br>
Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Karte behält während der Sperre des TAN-Service weiterhin Ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.';

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

SET @textValue = 'IHRE QR-TAN WIRD GEPRÜFT';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 12
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;

SET @textValue = 'UNGÜLTIGE QR-TAN';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 28
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;

SET @textValue = 'IHRE AUTHENTIFIZIERUNG WAR ERFOLGREICH';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 26
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = 'SIE HABEN DEN VORGANG ABGEBROCHEN';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 14
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = 'Falls Sie den Artikel dennoch kaufen oder Ihre Kreditkartendaten bestätigen möchten, starten Sie den Vorgang bitte erneut.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 15
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = 'IHRE SESSION IST ABGELAUFEN';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 30
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;



SET @textValue = 'Das Zeitlimit wurde überschritten. Aus Sicherheitsgründen wird der Vorgang abgebrochen. Bitte versuchen Sie es erneut. Bei Fragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 31
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = 'TECHNISCHER FEHLER';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 32
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = 'Bitte bestätigen Sie folgende Zahlung / Kreditkartendaten';

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

SET @textValue = '<b>Informationen über Visa Secure</b></br>
Visa Secure ist ein Service von Visa und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor unberechtigter Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen oder Ihre Kreditkartendaten bei Händlern abgesichert hinterlegen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = '<b>Registrierung für Visa Secure</b></br>
Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber einer Consorsbank Visa Karte automatisch für den Visa Secure Service angemeldet.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 2
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = '<b>Deaktivierung des Visa Secure Service</b></br>
Solange Sie ein Girokonto und eine Visa Karte bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = '<b>Höhere Sicherheit durch Visa Secure beim Online-Einkauf</b></br>
Zukünftig öffnet sich beim Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte Autorisierungsverfahren. Ihr Online-Einkauf wird durch Ihre Autorisierung zusätzlich abgesichert.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = '<b>Falscheingabe der Visa Secure TAN</b></br>
Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Karte behält während der Sperre des TAN-Service weiterhin Ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.';

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


SET @textValue = 'Bestätigung mit der Consorsbank Online PIN';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 30
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Bitte geben Sie *zweimal* nacheinander die 299 Stelle Ihrer 5-stelligen Consorsbank Online PIN ohne Komma und Leerzeichen ein (z. B. "1k1k!).';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 11
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'IHR VORGANG WURDE ABGEBROCHEN';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 14
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Falls Sie den Artikel dennoch kaufen oder Ihre Kreditkartendaten bestätigen möchten, starten Sie den Vorgang bitte erneut.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 15
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'DIE PIN PRÜFUNG WAR ERFOLGREICH';

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

SET @textValue = 'PIN FEHLERHAFT';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 28
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'IHRE SESSION IST ABGELAUFEN';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 30
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Das Zeitlimit wurde überschritten. Aus Sicherheitsgründen wird der Vorgang abgebrochen. Bitte versuchen Sie es erneut. Bei Fragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 31
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = 'TECHNISCHER FEHLER';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 32
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = 'Bitte bestätigen Sie folgende Zahlung / Kreditkartendaten';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue12 = 'AUTHENTIFIZIERUNG LÄUFT';
SET @textValue13 = 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@extPassAppAuthentMean,'_',@otpFormPageType,'_12'), @updateState,
 'de', 12, @allPageType,  @textValue12, @MaestroVID, NULL, @passwordCustomItemSet),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@extPassAppAuthentMean,'_',@otpFormPageType,'_13'), @updateState,
 'de', 13, @allPageType,  @textValue13, @MaestroVID, NULL, @passwordCustomItemSet);