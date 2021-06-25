USE `U7G_ACS_BO`;

SET @BankUB = 'RCH';

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');

UPDATE BinRange SET lowerBound = '4395900000' ,	  upperBound = '4395901999' WHERE fk_id_network = @MaestroVID AND fk_id_profileSet = @ProfileSet  AND lowerBound = '4273470500' AND upperBound = '4273470599';