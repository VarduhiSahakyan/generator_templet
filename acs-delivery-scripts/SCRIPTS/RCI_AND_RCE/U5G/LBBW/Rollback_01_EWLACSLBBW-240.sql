USE U5G_ACS_BO;

SET @bank = 'LBBW';

SET @customItemSetSMS = (SELECT `id` FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @bank, '_OTP_SMS_NORMAL'));

UPDATE `Profile` SET `fk_id_customItemSetCurrent` = null WHERE `name` = 'LBBW_SMS_01';

DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = 'MESSAGE_BODY';

DELETE FROM `CustomItemSet` WHERE `id` = @customItemSetSMS;



