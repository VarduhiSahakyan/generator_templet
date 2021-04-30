USE U5G_ACS_BO;

SET @locale = 'en';
SET @username = 'W100851';
SET @customItemSetMOBILE_APP = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_20000_MOBILE_APP_01');
SET @pageType_APP_VIEW = 'APP_VIEW';
SET @textName =  CONCAT('MASTERCARD_OOB_APP_VIEW_160_', @locale) ;


SET @text = 'First confirm identification with Mobile key on OP-mobile or OP Business mobile. Remember to check the confirmation request details. Then select Continue.';

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


SET @text = 'Vahvista tunnistautuminen  ensin Mobiiliavaimella OP-mobiilissa tai OP-yritysmobiilissa. Muista tarkistaa vahvistuspyynnön tiedot. Valitse sitten Jatka.';

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


SET @text = 'Bekräfta först identifieringen med Mobilnyckeln i OP-mobilen eller OP-företagsmobilen. Kom ihåg att kontrollera uppgifterna i bekräftelsebegäran. Välj sedan Fortsätt.';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `name` = @textName
					AND `pageTypes` = @pageType_APP_VIEW
					AND `fk_id_customItemSet` = @customItemSetMOBILE_APP;