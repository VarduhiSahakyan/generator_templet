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


SET @textValue = 'IHR AUTHENTIFIZIERUNGSVERFAHREN WURDE GESPERRT';
UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 16
  AND locale = 'de'
  AND pageTypes = @failurePageType
  AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'Beachten Sie bitte, dass aus Sicherheitsgründen aufgrund mehrfach falscher Authentifizierung Ihr Authentifizierungs-Verfahren gesperrt wurde. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';
UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 17
  AND locale = 'de'
  AND pageTypes = @failurePageType
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

SET @textValue = 'Das Zeitlimit wurde überschritten. Aus Sicherheitsgründen wird der Vorgang abgebrochen. Bitte versuchen Sie es erneut. Bei Fragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';
UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 31
AND locale = 'de'
AND pageTypes = @pollingPageType
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


SET @textValue = 'IHR AUTHENTIFIZIERUNGSVERFAHREN WURDE GESPERRT';
UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 16
  AND locale = 'de'
  AND pageTypes = @failurePageType
  AND fk_id_customItemSet = @photoTanCustomItemSet;

SET @textValue = 'Beachten Sie bitte, dass aus Sicherheitsgründen aufgrund mehrfach falscher Authentifizierung Ihr Authentifizierungs-Verfahren gesperrt wurde. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';
UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 17
  AND locale = 'de'
  AND pageTypes = @failurePageType
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


SET @textValue = 'IHR AUTHENTIFIZIERUNGSVERFAHREN WURDE GESPERRT';
UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 16
  AND locale = 'de'
  AND pageTypes = @failurePageType
  AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Beachten Sie bitte, dass aus Sicherheitsgründen aufgrund mehrfach falscher Authentifizierung Ihr Authentifizierungs-Verfahren gesperrt wurde. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.';
UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 17
  AND locale = 'de'
  AND pageTypes = @failurePageType
  AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = 'Weiter';
UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 18
AND locale = 'de'
AND pageTypes = @otpFormPageType
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


UPDATE `CustomItem` SET `value` = 'Schließen' WHERE `fk_id_customItemSet` in (@passwordCustomItemSet, @mobileAppCustomItemSet, @photoTanCustomItemSet, @refusalCustomItemSet) and
                                           `ordinal` = 174;


SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('EXT Password OTP Form Page (', @BankUB, ')%') );

UPDATE CustomComponent SET value = '

<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_301_FONT_TITLE''"
			 font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_304_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_304_FONT_TITLE''"
			 font-key="''network_means_pageType_304_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_305_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_305_FONT_TITLE''"
			 font-key="''network_means_pageType_305_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_306_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_306_FONT_TITLE''"
			 font-key="''network_means_pageType_306_FONT_DATA''"></custom-font>

<style>
	@font-face {
		font-family: "BNPPSans";
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
	#main-container {
		font-family: BNPPSans;
		font-size: 15px;
		width: 480px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 10px;
		padding-right: 10px;
	}
	#main-container #issuerLogo {
		max-height: 72px;
		padding-left: 0px;
		padding-right: 0px;
	}
	#main-container #networkLogo {
		max-height: 33px;
		max-width: 100%;
	}
	#main-container #pageHeader {
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 100%;
		height: 76px;
		padding-bottom: 4px;
		margin-top: 8px;
		margin-bottom: 0px;
		border-bottom: 1px solid #dcdcdc;
	}
	#main-container #pageHeaderLeft {
		text-align: left;
	}
	#main-container #pageHeaderRight {
		text-align: right;
	}
	#main-container .clear {
		clear: both;
		display: block;
	}
    #contentHeader{
        padding-top: 7px;
    }
	#main-container #content #contentHeader custom-text.ng-isolate-scope {
		font-family: BNPPSans;
		font-size: 25px;
		font-weight: bold;
		text-align: center;
		color: #403f3d;
	}
	span.col-sm-6.col-xs-6.text-left.padding-left {
		font-family: BNPPSans;
	}
	.side-menu .text-left, .side-menu .text-right {
		font-family: BNPPSans;
		padding-right: 5px;
		padding-left: 5px;
		font-size: 15px;
		color: #403f3d;
	}
	.btn {
		border-radius: 0px;
	}
	#main-container #content #contentMain {
		background-color: #f7f7f7;
		border-radius: 1em;
		padding: 1em;
		display: flex;
		flex-direction: column;
	}
	#main-container #content #contentMain span.custom-text.ng-binding {
		font-family: BNPPSans;
		font-size: 15px;
		font-weight: normal;
		text-align: center;
	}
	#main-container #content {
		text-align: left;
		background-color: #f7f7f7;
	}
	#main-container #content h2 {
		font-family: BNPPSansLight;
		font-size: 25px;
		line-height: 0.8;
		margin-top: 0px;
		margin-bottom: 0.25em;
	}
	#main-container message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	#main-container .menu-title {
		display: none;
	}
	#main-container #content #contentMain .flex-right {
		align-self: flex-end;
	}
	#main-container #otp-input {
		display: flex;
		flex-direction: row;
		justify-content: flex-end;
		margin-top: 10px;
		align-self: flex-end;
	}
	input {
		border: 1px solid #d1d1d1;
		color: #464646;
		padding: 7px 10px 5px;
		height: 20px;
		box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
	}
	#main-container .input-label {
		display: flex;
		flex-direction: row;
		align-items: center;
	}
	#main-container .otp-input input {
		margin-left: 16px;
	}
	#main-container #otp-input span {
		padding-right: 10px;
		display : none;
	}
	#main-container #otp-input input:focus {
		outline: none;
	}
	#main-container #footer {
		background-image: none;
		height: 100%;
		width: 100%;
		background-color: #f7f7f7;
		border-radius: 1em;
		clear: both;
	}
	#main-container .contact {
		width: 70%;
		order: 1;
		font-weight: bold;
	}
	#main-container #footer .contact custom-text.ng-isolate-scope {
		text-align: center;
		color: #403f3d;
	}
	#main-container #footer .help-area .help-link #helpButton .btn-default {
		background-color: #5b7f95;
	}
	#main-container #helpButton button span {
		font-family: BNPPSans;
		font-size: 15px;
		font-weight: normal;
		text-align: center;
		color: white;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 2px;
		background-color: #5b7f95;
	}
	#main-container #helpButton .fa-info {
		display: none;
	}
	#main-container .help-link {
		width: 30%;
		order: 2;
		text-align: right;
	}
	#main-container #footer:after {
		content: '''';
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .extra-small {
		font-size: 12px;
	}
	#main-container #footer .small {
		font-size: 0.8em;
		font-weight: normal;
	}
	#main-container #footer .bold {
		font-family: BNPPSans;
		font-size: 15px;
		font-weight: bold;
		color: #403f3d;
	}
	#main-container #footer .grey {
		color: #6b6b6b;
		font-weight: normal;
	}
	#main-container #footer #copyright {
		width: 100%;
		border-top: 1px solid #6b6b6b;
		padding-top: 0.5em;
		padding-bottom: 1em;
		display: flex;
		flex-direction: row;
	}
	#main-container #footer #copyright custom-text.ng-isolate-scope {
		font-weight: normal;
		text-align: center;
		color: #403f3d;
	}
	#main-container #footer #copyright div:nth-child(1) {
		order: 1;
		text-align: left;
		width: 50%;
		padding-left: 12px;
	}
	#main-container #footer #copyright div:nth-child(2) {
		order: 2;
		text-align: right;
		width: 50%;
		padding-right: 12px;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding: 16px;
	}
	#main-container .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-xs-12 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .row .left {
		float: left;
		width: 180px;
		text-align: right;
	}
	#main-container .row .left span {
		margin-right: 0.5em
	}
	#main-container .row .back-link {
		text-align: left;
		float: left;
	}
	#main-container .row .back-link button {
		font-family: BNPPSans;
		font-size: 15px;
		border-style: none;
		padding: 0px;
		background-color: #f7f7f7;
		color: #5b7f95;
	}
	#main-container .row button:hover:enabled {
		background-color: #5b7f95;
	}
	#main-container .row .back-link span {
		text-align: left;
		margin-left: 0.5em;
		color: #749bb3;
	}
	#main-container .row .back-link span.fa-ban {
		display: none;
	}
	#main-container .row .submit-btn {
		text-align: right;
		float: right;
	}
	#main-container #val-button-container {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	#main-container #validateButton button {
		font-family: BNPPSans;
		font-size: 15px;
		height: 30px;
		line-height: 1.0;
		background: #5b7f95;
		box-shadow: none;
		border: 0px;
		color: #fff;
		width: 163px;
	}
	#main-container #validateButton span.fa-check-square {
		display: none;
	}
</style>
<div id="main-container" class="ng-style="style" class="ng-scope">
	<div id="headerLayout">
		<div id="pageHeader" >
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>
	<div id="content">
			<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
			<div id="contentHeader">
				<h2><custom-text custom-text-key="''network_means_pageType_1''"></custom-text></h2>
			</div>
			<div  id="transactionDetails">
					<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					<span class="clear"></span>
			</div>
			<div id="contentMain">
				<h2><custom-text custom-text-key="''network_means_pageType_3''"></custom-text></h2>
				<custom-text custom-text-key="''network_means_pageType_11''" id="paragraph1"></custom-text>
					<div id="otp-input">
						<custom-text custom-text-key="''network_means_pageType_53''"></custom-text>
						<pwd-form ></pwd-form>
					</div>
					<div class="flex-right">
						<div id="val-button-container">
							<val-button id="validateButton" val-label="''network_means_pageType_18''"></val-button>
						</div>
					</div>
			</div>

			<div id="form-controls">
				<div class="row">
					<div class="submit-btn">
					</div>
					<div class="back-link">
						<span class="fa fa-angle-left"></span><cancel-button cn-label="''network_means_pageType_4''"></cancel-button>
				   </div>
				</div>
			</div>
		</div>
		<div id="footer">
			<div class="help-area">
				<div class="help-link">
					<help help-label="''network_means_pageType_5''" id="helpButton" class="helpButtonClass"></help>
					<span class="fa fa-angle-right"></span>
				</div>
				<div class="contact">
					<div class="line bottom-margin">
						<custom-text custom-text-key="''network_means_pageType_6''"></custom-text>
					</div>
					<div class="line small bold">
						<div class=""><custom-text custom-text-key="''network_means_pageType_7''"></custom-text></div>
					</div>
					<div class="line small grey">
						<div class=""><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></div>
					</div>
				</div>
			</div>
			<div id="copyright" class="extra-small">
				<div><span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span></div>
				<div><span><custom-text custom-text-key="''network_means_pageType_10''"></custom-text></span></div>
			</div>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @layoutId;