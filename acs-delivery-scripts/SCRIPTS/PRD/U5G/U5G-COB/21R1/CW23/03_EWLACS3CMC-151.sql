USE U5G_ACS_BO;

SET @customItemSetPASSWORD = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_PASSWORD');

SET @currentPageType = 'OTP_FORM_PAGE';

SET @ordinal = 12;
update CustomItem set value = 'Bitte warten Sie einige Sekunden.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 13;
update CustomItem set value = 'Ihre Eingabe wird geprüft.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 14;
update CustomItem set value = 'Die Transaktion wurde abgebrochen.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 15;
update CustomItem set value = 'Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;


-- SMS --
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_SMS');

SET @currentPageType = 'OTP_FORM_PAGE';

SET @ordinal = 12;
update CustomItem set value = 'Bitte warten Sie einige Sekunden.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 13;
update CustomItem set value = 'Ihre Eingabe wird geprüft.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 14;
update CustomItem set value = 'Die Transaktion wurde abgebrochen.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 15;
update CustomItem set value = 'Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;