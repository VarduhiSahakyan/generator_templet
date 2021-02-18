USE U5G_ACS_BO;


SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_OTP_SMS_UNIFIED');

SET @ordinal = 35;
update CustomItem set value = 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie eine neue mTAN.'
where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal;