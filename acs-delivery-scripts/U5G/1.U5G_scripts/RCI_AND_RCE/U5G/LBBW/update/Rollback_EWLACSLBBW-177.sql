USE U5G_ACS_BO;

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_PASSWORD_UNIFIED');

SET @currentPageType = 'OTP_FORM_PAGE';
SET @ordinal = 26;
delete from CustomItem where fk_id_customItemSet = @customItemSetPassword and  ordinal = @ordinal and pageTypes = @currentPageType;
SET @ordinal = 27;
delete from CustomItem where fk_id_customItemSet = @customItemSetPassword and  ordinal = @ordinal and pageTypes = @currentPageType;

SET @currentPageType = 'FAILURE_PAGE';
SET @ordinal = 16;
delete from CustomItem where fk_id_customItemSet = @customItemSetPassword and  ordinal = @ordinal and pageTypes = @currentPageType;
SET @ordinal = 17;
delete from CustomItem where fk_id_customItemSet = @customItemSetPassword and  ordinal = @ordinal and pageTypes = @currentPageType;

SET @currentPageType = 'OTP_FORM_PAGE';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_OTP_SMS_UNIFIED');

SET @ordinal = 28;
update CustomItem set value = 'Fehler: mTAN falsch eingegeben.Bitte Eingabe wiederholen!'
where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal and pageTypes = @currentPageType;

SET @ordinal = 29;
update CustomItem set value = 'Die eingegebene mTAN ist nicht korrekt. Falls Sie eine neue mTAN anfordern wollen, nutzen Sie bitte den Button "mTAN neu anfordern". Anzahl verbleibender Versuche: @trialsLeft.'
where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal and pageTypes = @currentPageType;