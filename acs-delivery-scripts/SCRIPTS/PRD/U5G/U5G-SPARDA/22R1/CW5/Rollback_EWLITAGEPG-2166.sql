USE `U5G_ACS_BO`;

SET @BankUB = 'SPB';
SET @creater = 'W100851';

SET @subIssuerId = (SELECT id FROM SubIssuer WHERE name = 'SPD_sharedBIN');
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_sharedBIN_01'));
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @cryptoConfidId = (SELECT id FROM CryptoConfig WHERE description = 'Sparda CryptoConfig');


INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`, `sharedBinRange`, `updateDSDate`, `upperBound`, `fk_id_network`, `fk_id_profileSet`, `toExport`, `coBrandedCardNetwork`, `fk_id_cryptoConfig`, `serviceCode`)
VALUES
('ACTIVATED', @creater, NOW(), 'PUSHED_TO_CONFIG', false, NULL, '4908040000', 16, true, NULL, '4908049999', @MaestroVID, @ProfileSet, false, NULL, @cryptoConfidId, NULL);

INSERT INTO BinRange_SubIssuer (id_binRange, id_subIssuer)
SELECT br.id, @subIssuerId FROM BinRange br WHERE lowerBound = 4908040000;