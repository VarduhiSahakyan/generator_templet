USE U7G_ACS_BO;

SET @currencyFormat = null;

SET @issuerId_SWISSKEY = (SELECT `id` FROM `Issuer` WHERE `code` = 41001);
SET @issuerId_UBS = (SELECT `id` FROM `Issuer` WHERE `code` = 23000);
UPDATE `SubIssuer` SET `currencyFormat` = @currencyFormat WHERE `fk_id_issuer` IN (@issuerId_SWISSKEY, @issuerId_UBS);