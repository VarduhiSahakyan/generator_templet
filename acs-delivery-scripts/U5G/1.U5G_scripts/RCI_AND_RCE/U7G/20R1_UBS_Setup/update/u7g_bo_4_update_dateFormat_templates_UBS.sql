USE U7G_ACS_BO;

SET @subIssuerNameAndLabel = 'UBS Switzerland AG';
SET @subIssuerCode = '23000';
SET @dateFormat = 'DD.MM.YYYY';

UPDATE `SubIssuer`
SET `dateFormat` = @dateFormat
WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel;