USE U5G_ACS_BO;

SET @customItemSet_LBBW_OTP_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS');

SET @pageType ='MESSAGE_BODY';

SET @ordinal = 0;
SET @text = 'Ihre SMS-mTAN für die Zahlung bei @merchant über @amount lautet: @otp';
UPDATE `CustomItem` SET `value` = @text
WHERE fk_id_customItemSet = @customItemSet_LBBW_OTP_SMS and ordinal = @ordinal and pageTypes = @pageType;