USE U5G_ACS_BO;


SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_00070_SMS');
SET @appViewPageType = 'APP_VIEW';


SET @textValue = 'Click Submit to confirm & approve transaction';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 153
AND locale = 'en'
AND pageTypes = @appViewPageType
AND fk_id_customItemSet = @customItemSetSMS;