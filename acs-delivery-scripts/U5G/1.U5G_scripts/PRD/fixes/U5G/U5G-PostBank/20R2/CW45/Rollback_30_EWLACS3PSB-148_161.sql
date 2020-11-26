USE `U5G_ACS_BO`;

SET @locale = "de";
SET @idCustomItemSetSMSFBK =(SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18502_PB_SMS_Choice');
SET @idCustomItemSetTAFBK =(SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18502_PB_TA_Choice');

DELETE FROM `CustomItem` 
WHERE `ordinal` = 9 and `pageTypes` = 'APP_VIEW_MEAN_SELECT' and `fk_id_customItemSet` = @idCustomItemSetTAFBK;

DELETE FROM `CustomItem` 
WHERE `ordinal` = 9 and `pageTypes` = 'APP_VIEW_MEAN_SELECT' and `fk_id_customItemSet` = @idCustomItemSetSMSFBK;


SET @idCustomItemSetSMSEBK =(SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18501_PB_SMS_Choice');
SET @idCustomItemSetTAEBK =(SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18501_PB_MOBILE_APP_Choice');

DELETE FROM `CustomItem` 
WHERE `ordinal` = 9 and `pageTypes` = 'APP_VIEW_MEAN_SELECT' and `fk_id_customItemSet` = @idCustomItemSetTAEBK;

DELETE FROM `CustomItem` 
WHERE `ordinal` = 9 and `pageTypes` = 'APP_VIEW_MEAN_SELECT' and `fk_id_customItemSet` = @idCustomItemSetSMSEBK;

