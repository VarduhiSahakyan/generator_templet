USE U7G_ACS_BO;

SET @subIssuerCS = 'Crédit Suisse AG';
SET @subIssuerNAB = 'Neue Aargauer Bank';
SET @subIssuerSOBA = 'Baloise Bank SoBa AG';
SET @subIssuerLUKB = 'Luzerner KB AG';

UPDATE `SubIssuer` SET `userChoiceAllowed` = false
				   WHERE `name` = @subIssuerCS
					  OR `name` = @subIssuerNAB
					  OR `name` = @subIssuerSOBA
					  OR `name` = @subIssuerLUKB;