USE `U7G_ACS_BO`;

SET @customItemSetSMSOverride = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_UNIFIED_SMS_OVERRIDE');
SET @customItemSetSMSEXT = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_SMS');

SET @pageOTP = 'OTP_FORM_PAGE';

UPDATE `CustomItem` SET value = '<b>Zahlungsfreigabe mit SMS-Code</b>'
WHERE locale = 'de' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Um die Zahlung zu bestätigen, haben wir Ihnen einen SMS-Code an Ihre Handynummer geschickt. '
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Überprüfen Sie die Zahlungsdetails, geben Sie den 6-stelligen SMS-Code unten ein und klicken Sie auf "Bestätigen".'
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- Resend --
UPDATE `CustomItem` SET value = 'Sie erhalten in Kürze einen neuen SMS-Code an Ihre Handynummer.'
WHERE locale = 'de' and  `ordinal` = 35 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- SMS EXT Fallback --
UPDATE `CustomItem` SET value = 'Um die Zahlung zu bestätigen, haben wir Ihnen einen SMS-Code an Ihre Handynummer geschickt, da die Verbindung zur App zur Zeit nicht möglich ist. '
WHERE locale = 'de' and  `ordinal` = 52 and pageTypes = @pageHelp and fk_id_customItemSet in (@customItemSetSMSEXT );

-- Success --
UPDATE `CustomItem` SET value = 'Sie haben die Zahlungsfreigabe bestätigt. Ihre Zahlung wird jetzt verarbeitet. Warten Sie, bis Sie automatisch weitergeleitet werden.  '
WHERE locale = 'de' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Zurück zum Online-Shop'
WHERE locale = 'de' and  `ordinal` = 175 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- Timeout --
UPDATE `CustomItem` SET value = 'Es ist zu viel Zeit verstrichen bis zu Ihrer Bestätigung und Freigabe der Zahlung. Aus Sicherheitsgründen wurde der Zahlungsvorgang abgebrochen. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut. '
WHERE locale = 'de' and  `ordinal` = 31 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- Help --
SET @pageHelp = 'HELP_PAGE';
UPDATE `CustomItem` SET value = 'Um die Sicherheit von Online-Zahlungen zu erhöhen, hat Ihre Bank die zweistufige Authentifizierung eingeführt.  '
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Bitte bestätigen Sie die Zahlung mit dem einmaligen SMS-Code, der an Ihre registrierte Handynummer gesendet wurde. Bei Fragen oder Änderungen Ihrer Handynummer wenden Sie sich bitte an Ihre Bank.'
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );


-- PWD --

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_UNIFIED_PASSWORD');

-- Main --
UPDATE `CustomItem` SET value = 'Bitte prüfen Sie die Zahlungsdetails und bestätigen Sie die Zahlung durch Eingabe Ihres persönlichen Passworts.'
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Bestätigen'
WHERE locale = 'de' and  `ordinal` = 42 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

-- Success --
UPDATE `CustomItem` SET value = 'Sie haben die Zahlungsfreigabe bestätigt. Die Zahlung wird jetzt verarbeitet. Warten Sie, bis Sie automatisch weitergeleitet werden. '
WHERE locale = 'de' and  `ordinal` = 27 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Zurück zum Online-Shop'
WHERE locale = 'de' and  `ordinal` = 175 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

-- Timeout --
UPDATE `CustomItem` SET value = 'Es ist zu viel Zeit verstrichen bis zu Ihrer Bestätigung und Freigabe der Zahlung. Aus Sicherheitsgründen wurde der Zahlungsvorgang abgebrochen. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut.'
WHERE locale = 'de' and  `ordinal` = 31 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;


-- TA --

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_MOBILE_APP');

SET @pagePolling = 'POLLING_PAGE';

-- Timeout --
UPDATE `CustomItem` SET value = 'Es ist zu viel Zeit verstrichen bis zu Ihrer Bestätigung und Freigabe der Zahlung. Aus Sicherheitsgründen wurde der Zahlungsvorgang abgebrochen. Die Zahlung wurde nicht ausgeführt und Ihre Karte nicht belastet. Wenn Sie mit dem Kauf fortfahren möchten, gehen Sie bitte zurück zum Online-Shop und versuchen Sie es erneut. '
WHERE locale = 'de' and  `ordinal` = 31 and pageTypes = @pagePolling and fk_id_customItemSet = @customItemSetMobileApp;

-- Help --
SET @pageHelp = 'HELP_PAGE';
UPDATE `CustomItem` SET value = 'Um die Sicherheit bei Online-Zahlung zu erhöhen, hat Ihre Bank ein zweistufiges Authentifikationsverfahren eingeführt. '
WHERE locale = 'de' and  `ordinal` = 2 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'ie können Online-Zahlungen auf Ihrem Mobiltelefon in der von Ihrer Bank für 3D Secure zur Verfügung gestellten App freigeben. Bei Fragen oder Unklarheiten wenden Sie sich bitte an Ihre Bank.'
WHERE locale = 'de' and  `ordinal` = 3 and pageTypes = @pageHelp and fk_id_customItemSet = @customItemSetMobileApp;




-- Native App Based --

SET @pageAppView = 'APP_VIEW';

-- SMS --
SET @customItemSetSMSOverride = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_UNIFIED_SMS_OVERRIDE');
SET @customItemSetSMSEXT = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_SMS');

UPDATE `CustomItem` SET value = 'Zahlungsfreigabe mit SMS-Code '
WHERE locale = 'de' and  `ordinal` = 151 and pageTypes = @pageAppView and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Wir haben Ihnen zur Bestätigung der Zahlung einen SMS-Code an Ihre Handynummer geschickt. Prüfen Sie die Zahlungsdetails und bestätigen Sie die Zahlung durch Eingabe des erhaltenen Codes.'
WHERE locale = 'de' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'SMS-Code bitte hier eingeben: '
WHERE locale = 'de' and  `ordinal` = 153 and pageTypes = @pageAppView and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Bestätigen'
WHERE locale = 'de' and  `ordinal` = 154 and pageTypes = @pageAppView and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Neuen Code anfordern'
WHERE locale = 'de' and  `ordinal` = 155 and pageTypes = @pageAppView and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Der eingegebene SMS-Code ist nicht korrekt. Geben Sie den Code erneut ein oder fordern Sie einen neuen Code an.'
WHERE locale = 'de' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

-- PWD --

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_UNIFIED_PASSWORD');

UPDATE `CustomItem` SET value = 'Bitte prüfen Sie die Zahlungsdetails und bestätigen Sie die Zahlung durch Eingabe Ihres persönlichen Passworts.\n\n Sie bezahlen dem Händler  @merchantName den Betrag von @amount am @formattedDate.'
WHERE locale = 'de' and  `ordinal` = 152 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Persönliches Passwort eingeben:'
WHERE locale = 'de' and  `ordinal` = 153 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Bestätigen'
WHERE locale = 'de' and  `ordinal` = 154 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Neuen SMS-Code anfordern'
WHERE locale = 'de' and  `ordinal` = 155 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetPassword;

-- TA --

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_MOBILE_APP');

UPDATE `CustomItem` SET value = 'Zahlung mit der App freigeben'
WHERE locale = 'de' and  `ordinal` = 151 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Die Freigabe der Zahlung mit der App auf Ihrem Mobiltelefon ist fehlgeschlagen. Die Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Bitte versuchen Sie es erneut. '
WHERE locale = 'de' and  `ordinal` = 160 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;

UPDATE `CustomItem` SET value = 'Weiter'
WHERE locale = 'de' and  `ordinal` = 165 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Next'
WHERE locale = 'en' and  `ordinal` = 165 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Continuer'
WHERE locale = 'fr' and  `ordinal` = 165 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
UPDATE `CustomItem` SET value = 'Avanti'
WHERE locale = 'it' and  `ordinal` = 165 and pageTypes = @pageAppView and fk_id_customItemSet = @customItemSetMobileApp;
