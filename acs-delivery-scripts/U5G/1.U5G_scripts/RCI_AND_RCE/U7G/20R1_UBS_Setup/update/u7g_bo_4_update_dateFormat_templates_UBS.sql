
USE U7G_ACS_BO;

SET @subIssuerNameAndLabel = 'UBS Switzerland AG';
SET @subIssuerCode = '23000';
SET @dateFormat = 'DD.MM.YYYY';
SET @maskParam = '•,0,4';

UPDATE `SubIssuer`
SET `dateFormat` = @dateFormat, `maskParams` = @maskParam 
WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel;