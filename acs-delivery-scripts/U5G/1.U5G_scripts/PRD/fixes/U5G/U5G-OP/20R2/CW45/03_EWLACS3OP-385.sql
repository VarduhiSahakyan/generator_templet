USE `U5G_ACS_BO`;


SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_20000_MOBILE_APP_01');

UPDATE `CustomItem` SET VALUE = '1.Open OP-mobile or OP Business mobile. If the confirmation request didn’t open, tap Confirm with Mobile key.\n2.Check the information.\n3. Confirm with Mobile key PIN.\n\nMerchant: @merchant\nAmount: @amount\nCard: @displayedPan\n\nIn case of problems, call OP customer service at 0100 0500 (local call ch./mobile ch.).' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 160 and pageTypes = 'APP_VIEW' and DTYPE ='T' and locale = 'en';



UPDATE `CustomItem` SET VALUE = '1. Avaa OP-mobiili tai OP-yritysmobiili. Jos vahvistuspyyntö ei auennut , valitse Vahvista Mobiiliavaimella.\n2. Tarkista tiedot.\n3. Vahvista Mobiiliavain-PINillä.\n\nVerkkokauppa: @merchant\nSumma: @amount\nKortti: @displayedPan\n\nOngelmatilanteissa ota yhteyttä OP:n asiakaspalveluun p. 0100 0500 (pvm/mpm).' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 160 and pageTypes = 'APP_VIEW' and DTYPE ='T' and locale = 'fi';



UPDATE `CustomItem` SET VALUE = '1. Öppna OP-mobilen eller OP-företagsmobilen. Om bekräftelsebegäran inte öppnas, välj Bekräfta med Mobilnyckel.\n2. Kontrollera uppgifterna.\n3. Bekräfta med Mobilnyckel-PIN.\n\nNätbutik : @merchant\nBelopp : @amount\nKort: @displayedPan\n\nVid problem kontakta vid behov OP kundtjänsten 0100 0500 (lna/msa)' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 160 and pageTypes = 'APP_VIEW' and DTYPE ='T' and locale = 'se';