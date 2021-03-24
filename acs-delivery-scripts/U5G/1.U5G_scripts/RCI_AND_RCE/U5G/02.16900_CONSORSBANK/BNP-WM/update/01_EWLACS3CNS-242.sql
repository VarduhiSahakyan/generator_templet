USE `U5G_ACS_BO`;


SET @helpPageType ='HELP_PAGE';
SET @refusalPageType ='REFUSAL_PAGE';
SET @pollingPageType = 'POLLING_PAGE';
SET @failurePageType = 'FAILURE_PAGE';
SET @otpFormPageType = 'OTP_FORM_PAGE';
SET @BankUB = 'BNP_WM';

SET @refusalCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_1_REFUSAL'));

SET @textValue = '<b>Informationen über Visa Secure</b></br>
Visa Secure ist ein Service von Visa und BNP Paribas Wealth Management - Private Banking, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen oder Ihre Kreditkartendaten bei Händlern abgesichert hinterlegen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;

SET @textValue = '<b>Registrierung für Visa Secure</b></br>
Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Visa Card von BNP Paribas Wealth Management - Private Banking automatisch für den Visa Secure Service angemeldet.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 2
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = '<b>Deaktivierung des Visa Secure Service</b></br>
Solange Sie ein Girokonto und eine Visa Card von BNP Paribas Wealth Management - Private Banking haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = '<b>Höhere Sicherheit durch Visa Secure beim Online-Einkauf</b></br>
Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @refusalCustomItemSet;


SET @textValue = '<b>Falscheingabe der Visa Secure TAN</b></br>
Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr persönliches Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Services weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.';

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


SET @textValue = 'IHR VISA SECURE VORGANG WURDE ABGELEHNT';


UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 22
AND locale = 'de'
AND pageTypes = @refusalPageType
AND fk_id_customItemSet = @refusalCustomItemSet;

SET @textValue = 'Bitte bestätigen Sie folgende Zahlung / Kreditkartendaten';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @refusalPageType
AND fk_id_customItemSet = @refusalCustomItemSet;

SET @textValue = 'Aus Sicherheitsgründen wurde der Visa Secure Vorgang abgelehnt. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 23
AND locale = 'de'
AND pageTypes = @refusalPageType
AND fk_id_customItemSet =  @refusalCustomItemSet;




SET @mobileAppCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_MOBILE_APP_EXT'));

SET @textValue = '<b>Informationen über Visa Secure</b></br>
Visa Secure ist ein Service von Visa und BNP Paribas Wealth Management - Private Banking, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen oder Ihre Kreditkartendaten bei Händlern abgesichert hinterlegen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = '<b>Registrierung für Visa Secure</b></br>
Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Visa Card von BNP Paribas Wealth Management - Private Banking automatisch für den Visa Secure Service angemeldet.';



UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 2
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = '<b>Deaktivierung des Visa Secure Service</b></br>
Solange Sie ein Girokonto und eine Visa Card von BNP Paribas Wealth Management - Private Banking haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = '<b>Höhere Sicherheit durch Visa Secure beim Online-Einkauf</b></br>
Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = '<b>Falscheingabe der Visa Secure TAN</b></br>
Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr persönliches Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Services weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden';

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
AND pageTypes = @pollingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'Das Zeitlimit wurde überschritten. Aus Sicherheitsgründen wird der Vorgang abgebrochen.
Bitte versuchen Sie es erneut. Bei Fragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 13
AND locale = 'de'
AND pageTypes = @pollingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'SIE HABEN DEN VORGANG ABGEBROCHEN';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 14
AND locale = 'de'
AND pageTypes = @pollingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'Falls Sie den Artikel dennoch kaufen oder Ihre Kreditkartendaten bestätigen möchten, starten Sie den Vorgang bitte erneut.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 15
AND locale = 'de'
AND pageTypes = @pollingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'Bitte bestätigen Sie folgende Zahlung / Kreditkartendaten';


UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @pollingPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;



UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @failurePageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @photoTanCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_PHOTO_TAN'));

SET @textValue = '<b>Informationen über Visa Secure</b></br>
Visa Secure ist ein Service von Visa und BNP Paribas Wealth Management - Private Banking, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen oder Ihre Kreditkartendaten bei Händlern abgesichert hinterlegen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;

SET @textValue = '<b>Registrierung für Visa Secure</b></br>
Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Visa Card von BNP Paribas Wealth Management - Private Banking automatisch für den Visa Secure Service angemeldet.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 2
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = '<b>Deaktivierung des Visa Secure Service</b></br>
Solange Sie ein Girokonto und eine Visa Card von BNP Paribas Wealth Management - Private Banking haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = '<b>Höhere Sicherheit durch Visa Secure beim Online-Einkauf</b></br>
Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


SET @textValue = '<b>Falscheingabe der Visa Secure TAN</b></br>
Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr persönliches Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Services weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.';

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


SET @textValue = 'Das Zeitlimit wurde überschritten. Aus Sicherheitsgründen wird der Vorgang abgebrochen. Bitte versuchen Sie es erneut. Bei Fragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 31
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;

SET @textValue = 'Bitte bestätigen Sie folgende Zahlung / Kreditkartendaten';


UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @photoTanCustomItemSet;


UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @failurePageType
AND fk_id_customItemSet = @photoTanCustomItemSet;



SET @passwordCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_PASSWORD'));

SET @textValue = '<b>Informationen über Visa Secure</b></br>
Visa Secure ist ein Service von Visa und BNP Paribas Wealth Management - Private Banking, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor der unberechtigten Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen oder Ihre Kreditkartendaten bei Händlern abgesichert hinterlegen';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = '<b>Registrierung für Visa Secure</b></br>
Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber der Visa Card von BNP Paribas Wealth Management - Private Banking automatisch für den Visa Secure Service angemeldet.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 2
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = '<b>Deaktivierung des Visa Secure Service</b></br>
Solange Sie ein Girokonto und eine Visa Card von BNP Paribas Wealth Management - Private Banking haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = '<b>Höhere Sicherheit durch Visa Secure beim Online-Einkauf</b></br>
Zukünftig öffnet sich bei jedem Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte TAN-Verfahren. Ihr Online-Einkauf wird durch die für den Bezahlvorgang generierte TAN zusätzlich abgesichert.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 4
AND locale = 'de'
AND pageTypes = @helpPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = '<b>Falscheingabe der Visa Secure TAN</b></br>
Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr persönliches Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Card behält während der Sperre des TAN-Services weiterhin ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.';

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


SET @textValue = 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 13
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


SET @textValue = 'PIN FEHLERHAFT';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 28
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


SET @textValue = 'Bitte bestätigen Sie folgende Zahlung / Kreditkartendaten';


UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 1
AND locale = 'de'
AND pageTypes = @failurePageType
AND fk_id_customItemSet = @passwordCustomItemSet;