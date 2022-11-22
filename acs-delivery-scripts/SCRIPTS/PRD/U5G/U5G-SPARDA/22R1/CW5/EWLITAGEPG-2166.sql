USE `U5G_ACS_BO`;

SET @BankUB = 'SPB';


SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_sharedBIN_01'));
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');

SET @binRangeID = (SELECT id FROM BinRange WHERE lowerBound = '4908040000' AND upperBound = '4908049999' AND fk_id_profileSet = @ProfileSet AND fk_id_network = @MaestroVID);

DELETE FROM BinRange_SubIssuer WHERE id_binRange = @binRangeID;

DELETE FROM BinRange WHERE id = @binRangeID;