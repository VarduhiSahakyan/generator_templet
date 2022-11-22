USE `U5G_ACS_BO`;

SET @customItemSetMobileAPP = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_20000_MOBILE_APP_01');

SET @pageType = 'APP_VIEW';

SET @locale = 'en';

UPDATE `CustomItem` SET `value` = 'Confirm with Mobile key'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 151
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = '1.Open OP-mobile or OP Business mobile. If the confirmation request didn’t open, tap Confirm with Mobile key.\n2.Check the information.\n3.Confirm with Mobile key PIN.\nMerchant: @merchantName\nAmount: @amount\nCard: @displayedPan\n\nIn case of problems, call OP customer service at 0100 0500 (local call ch./mobile ch.).'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 152
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = 'More information at op.fi. VisaSecure and Mastercard Identity Check protect your card from unauthorised payment transactions by ensuring that the card belongs to the person who is being authenticated. The service is provided for OP by equensWorldline.'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 157
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = 'First confirm identification with Mobile key on OP-mobile or OP Business mobile. Remember to check the confirmation request details. Then select Continue.'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 160
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = 'Continue'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 165
  AND fk_id_customItemSet = @customItemSetMobileAPP;

SET @locale = 'fi';

UPDATE `CustomItem` SET `value` = 'Vahvista Mobiiliavaimella'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 151
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = '1. Avaa OP-mobiili tai OP-yritysmobiili. Jos vahvistuspyyntö ei auennut , valitse Vahvista Mobiiliavaimella.\n2. Tarkista tiedot.\n3. Vahvista Mobiiliavain-PINillä.\nVerkkokauppa: @merchantName\nSumma: @amount\nKortti: @displayedPan\n\nOngelmatilanteissa ota yhteyttä OP:n asiakaspalveluun p. 0100 0500 (pvm/mpm).'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 152
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = 'Lisätietoja op.fi-palvelusta.VisaSecure ja Mastercard Identity Check -palvelu suojaa korttisi luvattomilta maksutapahtumilta varmistamalla, että kortti ja asiakkaan tunnistautuminen kuuluvat samalle henkilölle. OP:lle palvelun tuottaa equensWorldline. '
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 157
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = 'Vahvista tunnistautuminen  ensin Mobiiliavaimella OP-mobiilissa tai OP-yritysmobiilissa. Muista tarkistaa vahvistuspyynnön tiedot. Valitse sitten Jatka.'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 160
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = 'Jatka'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 165
  AND fk_id_customItemSet = @customItemSetMobileAPP;

-- SW --
SET @locale = 'se';

UPDATE `CustomItem` SET `value` = 'Bekräfta med Mobilnyckel'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 151
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = '1. Öppna OP-mobilen eller OP-företagsmobilen. Om bekräftelsebegäran inte öppnas, välj Bekräfta med Mobilnyckel.\n2. Kontrollera uppgifterna.\n3. Bekräfta med Mobilnyckel-PIN.\n\nNätbutik : @merchantName\nBelopp : @amount\nKort: @displayedPan\n\nVid problem kontakta vid behov OP kundtjänsten 0100 0500 (lna/msa)'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 152
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = 'Mer information på op.fi.Tjänsten VisaSecure och Mastercard Identity Check skyddar ditt kort mot obehöriga betalningstransaktioner genom att försäkra att kortet och kundens identifiering tillhör samma person. Tjänsten produceras för OP av equensWorldline.  '
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 157
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = 'Bekräfta först identifieringen med Mobilnyckeln i OP-mobilen eller OP-företagsmobilen. Kom ihåg att kontrollera uppgifterna i bekräftelsebegäran. Välj sedan Fortsätt.'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 160
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = 'Fortsätt'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 165
  AND fk_id_customItemSet = @customItemSetMobileAPP;