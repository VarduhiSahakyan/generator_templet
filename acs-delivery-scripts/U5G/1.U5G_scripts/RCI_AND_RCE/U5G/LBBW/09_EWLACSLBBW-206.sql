USE U5G_ACS_BO;

SET @locale = 'de';

SET @customItemSet_LBBW_OTP_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS');
SET @customItemSet_LBBW_OTP_PASSWORD = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_PASSWORD_UNIFIED');

SET @pageType = 'FAILURE_PAGE';

SET @ordinal = 1;
UPDATE `CustomItem` SET `value` = ''
WHERE `locale` = @locale
  AND  `ordinal` = @ordinal
  AND `pageTypes` = @pageType
  AND `fk_id_customItemSet` in (@customItemSet_LBBW_OTP_SMS, @customItemSet_LBBW_OTP_PASSWORD);