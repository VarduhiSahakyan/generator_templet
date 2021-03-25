USE U5G_ACS_BO;

SET @locale = 'de';
SET @pageType = 'ALL';
SET @ordinal = 104;

SET @customItemSet_LBBW_OTP_PASSWORD = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_PASSWORD_UNIFIED');
delete from CustomItem where fk_id_customItemSet = @customItemSet_LBBW_OTP_PASSWORD and ordinal = @ordinal and pageTypes = @pageType;


SET @customItemSet_LBBW_OTP_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS');
UPDATE `CustomItem` SET `value` = 'Telefonnummer'
WHERE `locale` = @locale
  AND  `ordinal` = @ordinal
  AND `pageTypes` = @pageType
  AND `fk_id_customItemSet` = @customItemSet_LBBW_OTP_SMS;

