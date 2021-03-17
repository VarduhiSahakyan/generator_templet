USE U5G_ACS_BO;

SET @locale = 'de';

SET @customItemSet_LBBW_OTP_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS_UNIFIED');
SET @customItemSet_LBBW_OTP_PASSWORD = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_PASSWORD_UNIFIED');

SET @pageType = 'FAILURE_PAGE';

UPDATE `CustomItem` SET `value` = 'Unseren 24-Stunden Service erreichen Sie jederzeit unter +49 69-66571333.'
WHERE `locale` = @locale
  AND  `ordinal` = 1
  AND `pageTypes` = @pageType
  AND `fk_id_customItemSet` in (@customItemSet_LBBW_OTP_SMS, @customItemSet_LBBW_OTP_PASSWORD);