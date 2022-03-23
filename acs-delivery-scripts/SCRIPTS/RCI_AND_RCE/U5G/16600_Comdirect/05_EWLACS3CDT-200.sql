USE U5G_ACS_BO;

SET @pageType = 'APP_VIEW';
SET @subissuerId = (SELECT id from SubIssuer WHERE code = 16600);
SET @customItemSetID = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_16600_PASSWORD' and fk_id_subIssuer = @subissuerId);
SET @appCustomItemSetID = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_16600_APP_1' and fk_id_subIssuer = @subissuerId);

SET @textValue = 'Ungültige Eingabe \n \nSie haben eine ungültige PIN eingegeben.\r\nBitte versuchen Sie es erneut.';

UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetID AND pageTypes = @pageType AND ordinal = 160;


SET @textValue = 'Öffnen Sie zunächst die photoTAN App und geben Sie die folgende Anfrage frei. Nach der Freigabe klicken Sie unten bitte auf „Weiter“.\n \nHändler: @merchant\n Betrag: @amount\nDatum: @formattedDate\nKartennummer: @displayedPan';

UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @appCustomItemSetID AND pageTypes = @pageType AND ordinal = 160;
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @appCustomItemSetID AND pageTypes = @pageType AND ordinal = 152;