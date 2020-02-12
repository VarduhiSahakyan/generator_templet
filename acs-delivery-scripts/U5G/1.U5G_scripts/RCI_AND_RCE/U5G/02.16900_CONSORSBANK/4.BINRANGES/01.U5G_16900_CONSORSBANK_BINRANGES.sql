USE `U5G_ACS_BO`;

SET @idSubIssuer = (SELECT id FROM `SubIssuer` WHERE `code` = '16900');
SET @idVisaNetwork = (SELECT id FROM `Network` WHERE `code` = 'VISA');
SET @idProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_16900_01');

/* 8. BinRange */

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`, `sharedBinRange`, `updateDSDate`, `upperBound`, `fk_id_network`, `fk_id_profileSet`, `toExport`, `coBrandedCardNetwork`, `fk_id_cryptoConfig`, `serviceCode`)
VALUES
('ACTIVATED', 'A169318', NOW(), 'PUSHED_TO_CONFIG', false, NULL, '4159321000', 16, false, NULL, '4159321499', @idVisaNetwork, @idProfileSet, false, NULL, NULL, NULL),
('ACTIVATED', 'A169318', NOW(), 'PUSHED_TO_CONFIG', false, NULL, '4163691000', 16, false, NULL, '4163691009', @idVisaNetwork, @idProfileSet, false, NULL, NULL, NULL),
('ACTIVATED', 'A169318', NOW(), 'PUSHED_TO_CONFIG', false, NULL, '4163698000', 16, false, NULL, '4163698009', @idVisaNetwork, @idProfileSet, false, NULL, NULL, NULL);

SELECT @idSubIssuer;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
SELECT id, @idSubIssuer FROM BinRange WHERE (lowerBound='4159321000' AND upperBound='4159321499')
                               OR (lowerBound='4163691000' AND upperBound='4163691009')
                                         OR (lowerBound='4163698000' AND upperBound='4163698009')
                                         AND fk_id_profileSet = @idProfileSet;

