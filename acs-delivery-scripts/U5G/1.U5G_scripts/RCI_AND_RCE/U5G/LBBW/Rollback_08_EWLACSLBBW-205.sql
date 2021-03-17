USE U5G_ACS_BO;

SET @locale = 'de';
SET @customItemSet_LBBW_OTP_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS');

SET @pageType ='OTP_FORM_PAGE';
SET @text = 'Aus Sicherheitsgründen wurde die Transaktion abgebrochen. Der Einkauf wurde nicht durchgeführt. Bitte versuchen Sie es erneut.';

UPDATE `CustomItem` SET `value` = @text
WHERE `locale` = @locale
  AND  `ordinal` = 31
  AND `pageTypes` = @pageType
  AND `fk_id_customItemSet` = @customItemSet_LBBW_OTP_SMS;