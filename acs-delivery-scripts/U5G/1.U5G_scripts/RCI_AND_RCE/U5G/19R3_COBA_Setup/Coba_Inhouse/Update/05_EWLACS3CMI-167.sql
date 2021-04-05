USE `U5G_ACS_BO`;

SET @BankUB = 'COZ';
SET @appViewPageType = 'APP_VIEW';
SET @otpFormPageType = 'OTP_FORM_PAGE';

SET @passwordCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_PASSWORD'));
SET @smsCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_SMS'));
SET @mobileAppCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_MOBILE_APP'));

SET @textValue = 'Details';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 151
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @passwordCustomItemSet;



SET @textValue = 'Bitte geben Sie Ihre Online Banking PIN ein.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 153
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Weiter';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 154
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @passwordCustomItemSet;

SET @textValue = 'Ich benötige Hilfe';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 156
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @passwordCustomItemSet;



SET @textValue = 'Bitte geben Sie hier Ihre Online Banking PIN ein, die Sie auch für den Login auf www.commerzbank.de verwenden.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 157
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


SET @textValue = 'Sie haben eine ungültige Online Banking PIN eingegeben. Bitte versuchen Sie es erneut.
Anzahl verbleibender Versuche: @trialsLeft';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 29
AND locale = 'de'
AND pageTypes = @otpFormPageType
AND fk_id_customItemSet = @passwordCustomItemSet;


# mTan changes

SET @textValue = 'Bitte bestätigen Sie folgenden Auftrag';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 151
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @smsCustomItemSet;


SET @textValue = 'Zur Freigabe bitte die mobileTAN eingeben.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 153
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @smsCustomItemSet;



SET @textValue = 'Ich benötige Hilfe';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 156
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @smsCustomItemSet;

SET @textValue = 'Die mobileTAN senden wir Ihnen per SMS an Ihre hinterlegte Mobilnummer.  Eine Aktualisierung können Sie im Online-Banking unter www.commerzbank.de > &quot;Persönlicher Bereich&quot;, &quot;Verwaltung: PIN, TAN, Benutzername&quot;, &quot;TAN-Einstellungen verwalten&quot; vornehmen.';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 157
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @smsCustomItemSet;

# pushTAN

SET @textValue = 'Freigabe mit photoTAN-Push';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 151
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'Bitte öffnen Sie die Commerzbank photoTAN-App und geben Sie dort folgenden Auftrag frei. Nach der Freigabe klicken Sie unten bitte auf &quot;Fortfahren&quot;.
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


SET @textValue = 'Ich benötige Hilfe';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 156
AND locale = 'de'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @mobileAppCustomItemSet;


SET @textValue = 'Wir haben Ihnen einen Auftrag zur Freigabe an Ihre photoTAN-App gesendet. Bitte öffnen Sie die Commerzbank photoTAN-App auf Ihrem Smartphone und geben die Zahlung dort frei. Klicken Sie erst anschließend hier auf &quot;Fortfahren&quot;.';

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