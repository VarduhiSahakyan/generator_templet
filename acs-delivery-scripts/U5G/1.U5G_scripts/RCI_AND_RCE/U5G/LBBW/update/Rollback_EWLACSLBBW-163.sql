USE U5G_ACS_BO;

SET @ordinal = 35;
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_OTP_SMS');

update CustomItem set value = 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie eine neue mTAN.'
where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal;


SET @customItemSetSMSunified = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_OTP_SMS_UNIFIED');

delete from CustomItem where fk_id_customItemSet = @customItemSetSMSunified and ordinal in (34, 35);