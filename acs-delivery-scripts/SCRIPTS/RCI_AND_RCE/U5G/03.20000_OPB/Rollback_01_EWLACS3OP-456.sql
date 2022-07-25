USE `U5G_ACS_BO`;

SET @customItemSetMobileAPP = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_20000_MOBILE_APP_01');

SET @pageType = 'APP_VIEW';

-- English --
SET @locale = 'en';

UPDATE `CustomItem` SET `value` = 'Confirm with Mobile key. Then return to this app and continue.\n\nMerchant: @merchantName\nAmount: @amount\nCard: @displayedPan\n'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 152
  AND fk_id_customItemSet = @customItemSetMobileAPP;


UPDATE `CustomItem` SET `value` = 'First confirm identification with Mobile key on OP-mobile or OP Business mobile. Then return to this app and continue.\n\nMerchant: @merchantName\nAmount: @amount\nCard: @displayedPan\n'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 160
  AND fk_id_customItemSet = @customItemSetMobileAPP;

-- FI --
SET @locale = 'fi';

UPDATE `CustomItem` SET `value` = 'Vahvista Mobiiliavaimella. Palaa sen jälkeen tähän sovellukseen ja jatka.\n\nVerkkokauppa: @merchantName\nSumma: @amount\nKortti:  @displayedPan\n'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 152
  AND fk_id_customItemSet = @customItemSetMobileAPP;


UPDATE `CustomItem` SET `value` = 'Vahvista tunnistautuminen ensin Mobiiliavaimella OP-mobiilissa tai OP-yritysmobiilissa. Palaa sen jälkeen tähän sovellukseen ja jatka.\n\nVerkkokauppa: @merchantName\nSumma: @amount\nKortti: @displayedPan\n'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 160
  AND fk_id_customItemSet = @customItemSetMobileAPP;

-- SW --
SET @locale = 'se';

UPDATE `CustomItem` SET `value` = 'Bekräfta med Mobilnyckeln. Kom därefter tillbaka till den här appen och fortsätt.\n\nNätbutik: @merchantName\nBelopp: @amount\nKort: @displayedPan\n'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 152
  AND fk_id_customItemSet = @customItemSetMobileAPP;

UPDATE `CustomItem` SET `value` = 'Bekräfta först identifieringen med Mobilnyckeln i OP-mobilen eller OP-företagsmobilen. Kom därefter tillbaka till den här appen och fortsätt. \n\nNätbutik: @merchantName\nBelopp:  @amount\nKort: @displayedPan\n'
WHERE locale = @locale
  AND pageTypes = @pageType
  AND ordinal = 160
  AND fk_id_customItemSet = @customItemSetMobileAPP;
