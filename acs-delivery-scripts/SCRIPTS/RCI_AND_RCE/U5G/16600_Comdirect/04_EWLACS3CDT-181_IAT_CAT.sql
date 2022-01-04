USE U5G_ACS_BO;

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_PASSWORD');
SET @pageType = 'OTP_FORM_PAGE';



SET @ordinal = 12;
SET @textValue = 'Authentifizierung wird fortgesetzt';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 13;
SET @textValue = 'Bitte warten Sie einen Moment. Im nächsten Schritt wird eine TAN abgefragt.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;