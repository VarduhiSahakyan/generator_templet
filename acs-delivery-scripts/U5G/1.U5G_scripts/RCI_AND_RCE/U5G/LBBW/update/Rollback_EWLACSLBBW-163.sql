USE U5G_ACS_BO;

-- Password --
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_PASSWORD_UNIFIED');
delete from CustomItem where fk_id_customItemSet = @customItemSetPassword and pageTypes = 'OTP_FORM_PAGE' and ordinal in (34, 35);


SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_OTP_SMS');
SET @ordinal = 35;
update CustomItem set value = 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie eine neue mTAN.'
where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal;