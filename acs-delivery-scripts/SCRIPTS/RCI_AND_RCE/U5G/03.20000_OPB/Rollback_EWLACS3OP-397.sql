USE U5G_ACS_BO;

SET @locale = 'en';
SET @username = 'W100851';
SET @customItemSetMOBILE_APP = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_20000_MOBILE_APP_01');
SET @pageType_APP_VIEW = 'APP_VIEW';
SET @textName =  CONCAT('MASTERCARD_OOB_APP_VIEW_160_', @locale) ;


SET @text = '1. Open OP-mobile or OP Business mobile. If the confirmation request didn’t open, tap Confirm with Mobile key.
2. Check the information.
3. Confirm with Mobile key PIN.

Merchant: @merchant
Amount: @amount
Card: @displayedPan

In case of problems, call OP customer service at 0100 0500 (local call ch./mobile ch.).';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `name` = @textName
					AND `pageTypes` = @pageType_APP_VIEW
					AND `fk_id_customItemSet` = @customItemSetMOBILE_APP;

SET @locale = 'fi';
SET @username = 'W100851';
SET @customItemSetMOBILE_APP = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_20000_MOBILE_APP_01');
SET @pageType_APP_VIEW = 'APP_VIEW';
SET @textName =  CONCAT('MASTERCARD_OOB_APP_VIEW_160_', @locale) ;


SET @text = '1. Avaa OP-mobiili tai OP-yritysmobiili. Jos vahvistuspyyntö ei auennut , valitse Vahvista Mobiiliavaimella.
2. Tarkista tiedot.
3. Vahvista Mobiiliavain-PINillä.

Verkkokauppa: @merchant
Summa: @amount
Kortti: @displayedPan

Ongelmatilanteissa ota yhteyttä OP:n asiakaspalveluun p. 0100 0500 (pvm/mpm).';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `name` = @textName
					AND `pageTypes` = @pageType_APP_VIEW
					AND `fk_id_customItemSet` = @customItemSetMOBILE_APP;


SET @locale = 'se';
SET @username = 'W100851';
SET @customItemSetMOBILE_APP = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_20000_MOBILE_APP_01');
SET @pageType_APP_VIEW = 'APP_VIEW';
SET @textName =  CONCAT('MASTERCARD_OOB_APP_VIEW_160_', @locale) ;


SET @text = '1. Öppna OP-mobilen eller OP-företagsmobilen. Om bekräftelsebegäran inte öppnas, välj Bekräfta med Mobilnyckel.
2. Kontrollera uppgifterna.
3. Bekräfta med Mobilnyckel-PIN.

Nätbutik : @merchant
Belopp : @amount
Kort: @displayedPan

Vid problem kontakta vid behov OP kundtjänsten 0100 0500 (lna/msa)';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `name` = @textName
					AND `pageTypes` = @pageType_APP_VIEW
					AND `fk_id_customItemSet` = @customItemSetMOBILE_APP;



