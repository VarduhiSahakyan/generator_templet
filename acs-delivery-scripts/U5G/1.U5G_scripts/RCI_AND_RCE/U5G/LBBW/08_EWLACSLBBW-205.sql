USE U5G_ACS_BO;

SET @locale = 'de';
SET @customItemSet_LBBW_OTP_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS');

SET @pageType ='OTP_FORM_PAGE';

SET @ordinal = 31;
SET @text = 'Aus Sicherheitsgründen wurde die Zahlung abgebrochen, da die Bestätigung nicht in der erforderlichen Zeit erfolgt ist. Der Kauf wurde nicht durchgeführt. Bitte versuchen Sie es erneut.';
UPDATE `CustomItem` SET `value` = @text
WHERE `locale` = @locale
  AND  `ordinal` = @ordinal
  AND `pageTypes` = @pageType
  AND `fk_id_customItemSet` = @customItemSet_LBBW_OTP_SMS;