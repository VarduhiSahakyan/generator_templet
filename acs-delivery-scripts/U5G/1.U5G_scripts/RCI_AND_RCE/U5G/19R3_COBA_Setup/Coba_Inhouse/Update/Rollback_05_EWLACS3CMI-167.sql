USE `U5G_ACS_BO`;

SET @BankUB = 'COZ';
SET @appViewPageType = 'APP_VIEW';
SET @otpFormPageType = 'OTP_FORM_PAGE';

SET @passwordCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_PASSWORD'));
SET @smsCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_SMS'));
SET @mobileAppCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_MOBILE_APP'));


SET @textValue = 'Bitte bestätigen Sie folgende Zahlung.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 151
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = 'Bitte geben Sie Ihre Online Banking PIN ein:';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 153
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @passwordCustomItemSet;



SET @textValue = 'Freigeben';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 154
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = 'Hilfe';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 156
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @passwordCustomItemSet;



SET @textValue = 'Nähere Informationen zu diesem Bezahl-Verfahren finden Sie in Ihrem Online Banking.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 157
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = 'Sie haben eine ungültige PIN eingegeben. Bitte versuchen Sie es erneut.
         Anzahl verbleibender Versuche: @trialsLeft';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 29
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;



# mTan changes

SET @textValue = 'Bitte bestätigen Sie folgende Zahlung.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 151
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @smsCustomItemSet;


SET @textValue = 'Freigabe durch mobileTAN:';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 153
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @smsCustomItemSet;

SET @textValue = 'Hilfe';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 156
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @smsCustomItemSet;

SET @textValue = 'Nähere Informationen zu diesem Bezahl-Verfahren finden Sie in Ihrem Online Banking.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 157
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @smsCustomItemSet;


UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 157
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @smsCustomItemSet;


# pushTAN

SET @textValue = 'Freigabe mit photoTAN-Push.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 151
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'Jetzt die photoTAN-App starten und die Zahlung dort freigeben.Nach der Freigabe klicken Sie unten bitte auf „Fortfahren“.
Händler: @merchant
Betrag: @amount
Datum: @formattedDate
Kartennummer: @displayedPan';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 152
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'Hilfe';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 156
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'Nähere Informationen zu diesem Bezahl-Verfahren finden Sie in Ihrem Online Banking.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 157
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'Fortfahren';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 165
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;

SET @textValue = 'Ungültige Eingabe \n\nSie haben  eine ungültige PIN eingegeben.\r\nBitte versuchen Sie es erneut. Anzahl verbleibender Versuche:@trialsLeft';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 160
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Ungültige Eingabe \n\nSie haben eine ungültige mobileTAN eingegeben.\r\nBitte versuchen Sie es erneut.Anzahl verbleibender Versuche: @trialsLeft';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 160
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @smsCustomItemSet;

SET @textValue = 'Bitte starten Sie die photoTAN-App und geben Sie die Zahlung dort frei. Im Anschluss bitte hier fortfahren.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 160
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;