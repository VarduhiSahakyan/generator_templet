USE U7G_ACS_BO;

SET @subIssuerNameAndLabel = 'Liechtensteinische Landesbank AG';
SET @subIssuerCode = '88000';
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

UPDATE `SubIssuer` SET `combinedAuthenticationAllowed` = TRUE WHERE `id` = @subIssuerID;