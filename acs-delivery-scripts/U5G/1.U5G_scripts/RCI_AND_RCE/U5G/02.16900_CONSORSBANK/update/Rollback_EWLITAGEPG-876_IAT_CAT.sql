USE U5G_ACS_BO;

set @createdBy = 'A758582';

set @subIssuerCode = '16900';
set @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @subIssuerCode, '_01'));

set @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');


INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						`name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
						`sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
						`coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', FALSE, NOW(), '4159322000', 16, FALSE, NULL, '4159329999', FALSE, @profileSetId, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', FALSE, NOW(), '4163691010', 16, FALSE, NULL, '4163699999', FALSE, @profileSetId, @MaestroVID, NULL);

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4159322000' AND b.upperBound='4159329999' AND b.fk_id_profileSet=@profileSetId
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4163691010' AND b.upperBound='4163699999' AND b.fk_id_profileSet=@profileSetId
  AND s.code=@subIssuerCode;


UPDATE `BinRange` SET `upperBound` = 4159321999
				  WHERE fk_id_profileSet = @profileSetId
				  AND `lowerBound` = 4159321000;