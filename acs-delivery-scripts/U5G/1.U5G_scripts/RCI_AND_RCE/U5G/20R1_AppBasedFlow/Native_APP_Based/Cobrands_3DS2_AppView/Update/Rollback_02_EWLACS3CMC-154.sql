USE U5G_ACS_BO;

SET @pageType = 'APP_VIEW';

SET @customItemSetPASSWORD = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_PASSWORD');

SET @ordinal = 151;
update CustomItem set value = 'Bitte bestätigen Sie folgende Zahlung.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 153;
update CustomItem set value = 'Bitte geben Sie Ihr 3-D Secure Passwort ein:'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 154;
update CustomItem set value = 'Freigeben'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 156;
update CustomItem set value = 'Hilfe'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 157;
update CustomItem set value = 'Infos zum sicheren Einkaufen im Internet finden Sie unter commerzbank.de/sicher-einkaufen'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @pageType and ordinal = @ordinal;


SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_SMS');

SET @ordinal = 151;
update CustomItem set value = 'Bitte bestätigen Sie folgende Zahlung.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 153;
update CustomItem set value = 'Freigabe durch mobileTAN:'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 155;
update CustomItem set value = 'Neue Mobile TAN anfordern'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 156;
update CustomItem set value = 'Hilfe'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 157;
update CustomItem set value = 'Infos zum sicheren Einkaufen im Internet finden Sie unter commerzbank.de/sicher-einkaufen '
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @pageType and ordinal = @ordinal;

