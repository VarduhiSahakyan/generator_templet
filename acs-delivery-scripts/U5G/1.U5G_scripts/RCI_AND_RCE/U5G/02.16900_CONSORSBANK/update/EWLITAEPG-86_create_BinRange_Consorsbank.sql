USE U5G_ACS_BO;

SET @createdBy ='A757435';

SET @subIssuerCode = '16900';
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @subIssuerCode, '_01'));

SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						`name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
						`sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
						`coBrandedCardNetwork`) VALUES
  ('TEST_BIN', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', FALSE, NOW(), '4163698000', 16, FALSE, NULL, '4163698009', FALSE, @ProfileSet, @MaestroVID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4163698000' AND b.upperBound='4163698009' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;
