USE U5G_ACS_BO;

SET @bank = 'LBBW';

SET @customItemSetSMS = (SELECT `id` FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @bank, '_OTP_SMS_NORMAL'));

DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` = @customItemSetSMS and `pageTypes` = 'MESSAGE_BODY_NPA' and `ordinal`=0;
