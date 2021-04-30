USE U7G_ACS_BO;

SET @currencyFormat = '{
							"useAlphaCurrencySymbol":true,
							"currencySymbolPosition":"LEFT",
							"decimalDelimiter":".",
							"thousandDelimiter":"''"
						}';

SET @issuerId_SWISSKEY = (SELECT `id` FROM `Issuer` WHERE `code` = 41001);
UPDATE `SubIssuer` SET `currencyFormat` = @currencyFormat WHERE `fk_id_issuer` = @issuerId_SWISSKEY;


SET @issuerId_UBS = (SELECT `id` FROM `Issuer` WHERE `code` = 23000);
SET @currencyFormat = '{
							"useAlphaCurrencySymbol":true,
							"currencySymbolPosition":"LEFT",
							"decimalDelimiter":".",
							"thousandDelimiter":","
						}';
UPDATE `SubIssuer` SET `currencyFormat` = @currencyFormat WHERE `fk_id_issuer` = @issuerId_UBS;