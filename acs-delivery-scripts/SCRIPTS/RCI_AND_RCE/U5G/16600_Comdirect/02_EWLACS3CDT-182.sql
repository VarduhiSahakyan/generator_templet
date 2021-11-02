USE U5G_ACS_BO;

SET @createdBy = 'W100851';
SET @bankUB = '16600';
SET @appViewPageType = 'APP_VIEW';

SET @passwordCustomSetId = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@bankUB,'_PASSWORD'));
SET @SMS01CustomSetId = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@bankUB,'_SMS_1'));
SET @SMS02CustomSetId = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@bankUB,'_SMS_2'));
SET @mobileAppCustomSetId = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@bankUB,'_APP_1'));


SET @textValue = 'Bitte bestätigen Sie folgende Anfrage';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @passwordCustomSetId AND ordinal = 151 AND pageTypes = @appViewPageType;

SET @textValue = 'Weiter';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @passwordCustomSetId AND ordinal =154 AND pageTypes = @appViewPageType;

SET @textValue = 'Informationen zur starken Kundenauthentifizierung finden Sie unter www.comdirect.de/faq/online-zahlungen';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @passwordCustomSetId AND ordinal =157 AND pageTypes = @appViewPageType;

SET @textValue = 'Bitte bestätigen Sie folgende Anfrage';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @SMS01CustomSetId AND ordinal =151 AND pageTypes = @appViewPageType;
UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @SMS02CustomSetId AND ordinal =151 AND pageTypes = @appViewPageType;

SET @textValue = 'Informationen zur starken Kundenauthentifizierung finden Sie unter www.comdirect.de/faq/online-zahlungen';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @SMS01CustomSetId AND ordinal =157 AND pageTypes = @appViewPageType;
UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @SMS02CustomSetId AND ordinal =157 AND pageTypes = @appViewPageType;

SET @textValue = 'Weiter';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @mobileAppCustomSetId  AND ordinal =165 AND pageTypes = @appViewPageType;

SET @textValue = 'Informationen zur starken Kundenauthentifizierung finden Sie unter www.comdirect.de/faq/online-zahlungen';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @mobileAppCustomSetId  AND ordinal =157 AND pageTypes = @appViewPageType;

SET @textValue = 'Öffnen Sie zunächst die photoTAN App und geben Sie die folgende Anfrage frei. Nach der Freigabe klicken Sie unten bitte auf „Weiter“.\n\nHändler: @merchant\nBetrag: @amount\nDatum: @formattedDate\nKartennummer: @maskedPan\n';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @mobileAppCustomSetId  AND ordinal =152 AND pageTypes = @appViewPageType;

SET @textValue = 'Zugang gesperrt';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @mobileAppCustomSetId  AND ordinal =151 AND pageTypes = @appViewPageType;

SET @textValue = 'Ihr Kontozugang wurde aus Sicherheitsgründen gesperrt.\nZur Entsperrung rufen Sie uns bitte an unter 04106 – 708 25 00. Geben Sie keine Zugangsdaten am Servicecomputer ein. Sie werden automatisch an einen Kundenbetreuer weitergeleitet.';

UPDATE CustomItem SET value = @textValue WHERE  fk_id_customItemSet = @mobileAppCustomSetId  AND ordinal =160 AND pageTypes = @appViewPageType;