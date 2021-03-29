USE U5G_ACS_BO;

SET @pageType ='MESSAGE_BODY';

SET @ordinal = 0;
SET @text = 'Ihre SMS-mTAN für die Zahlung bei @merchant über @amount lautet: @otp';

SET @customItemSet_LBBW_OTP_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS');
UPDATE `CustomItem` SET `value` = @text
WHERE fk_id_customItemSet = @customItemSet_LBBW_OTP_SMS and ordinal = @ordinal and pageTypes = @pageType;


SET @customItemSet_LBBW_PWD = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_PASSWORD_UNIFIED');
UPDATE `CustomItem` SET `value` = @text
WHERE fk_id_customItemSet = @customItemSet_LBBW_PWD and ordinal = @ordinal and pageTypes = @pageType;
