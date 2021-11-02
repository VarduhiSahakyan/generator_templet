USE U5G_ACS_BO;

SET @createdBy = 'W100851';
SET @bankUB = '16600';
SET @appViewPageType = 'APP_VIEW';

SET @passwordCustomSetId = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@bankUB,'_PASSWORD'));
SET @SMS01CustomSetId = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@bankUB,'_SMS_1'));
SET @SMS02CustomSetId = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@bankUB,'_SMS_2'));
SET @mobileAppCustomSetId = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@bankUB,'_APP_1'));


SET @textValue = 'Bitte bestätigen Sie folgende Zahlung';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @passwordCustomSetId AND ordinal = 151 AND pageTypes = @appViewPageType;

SET @textValue = 'Freigeben';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @passwordCustomSetId AND ordinal =154 AND pageTypes = @appViewPageType;

SET @textValue = 'Nähere Informationen zur starken Kundenauthentifizierung finden Sie unter www.comdirect.de.';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @passwordCustomSetId AND ordinal =157 AND pageTypes = @appViewPageType;

SET @textValue = 'Bitte bestätigen Sie folgende Zahlung:';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @SMS01CustomSetId AND ordinal =151 AND pageTypes = @appViewPageType;
UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @SMS02CustomSetId AND ordinal =151 AND pageTypes = @appViewPageType;

SET @textValue = 'SMS gesendet an Mobilnummer: @device';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @SMS01CustomSetId AND ordinal =157 AND pageTypes = @appViewPageType;
UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @SMS02CustomSetId AND ordinal =157 AND pageTypes = @appViewPageType;

SET @textValue = 'Fortfahren';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @mobileAppCustomSetId  AND ordinal =165 AND pageTypes = @appViewPageType;

SET @textValue = 'Nähere Informationen zur starken Kundenauthentifizierung finden Sie unter www.comdirect.de.';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @mobileAppCustomSetId  AND ordinal =157 AND pageTypes = @appViewPageType;

SET @textValue = 'Öffnen Sie jetzt die photoTAN App und geben Sie dort die Zahlung frei. Nach der Freigabe klicken Sie unten bitte auf "Fortfahren":\n\nHändler: @merchant\nBetrag: @amount\nDatum: @formattedDate\nKartennummer: @maskedPan\n';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @mobileAppCustomSetId  AND ordinal =152 AND pageTypes = @appViewPageType;

SET @textValue = 'Freigabe mit photoTAN App';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @mobileAppCustomSetId  AND ordinal =151 AND pageTypes = @appViewPageType;

SET @textValue = 'Der Zugang wurde gesperrt.\nAus Sicherheitsgründen haben wir Ihren Zugang zu Visa Secure und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 – 708 25 00';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @mobileAppCustomSetId  AND ordinal =160 AND pageTypes = @appViewPageType;