USE U7G_ACS_BO;

SET @currencyFormat = '{
                            "useAlphaCurrencySymbol":true,
                            "currencySymbolPosition":"LEFT"
                        }';


SET @subIssuerNameAndLabelUBS = 'UBS Switzerland AG';
SET @subIssuerCodeUBS = '23000';
SET @subIssuerIDUBS = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCodeUBS AND `name` = @subIssuerNameAndLabelUBS);

UPDATE `SubIssuer` SET `currencyFormat` = @currencyFormat WHERE `id` = @subIssuerIDUBS;