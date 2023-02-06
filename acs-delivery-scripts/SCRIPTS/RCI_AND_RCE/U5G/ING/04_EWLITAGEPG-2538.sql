USE `U5G_ACS_BO`;
SET @createdBy = 'A670775';

SET @BankUB = 'ING';
SET @issuerCode = '16500';
SET @subIssuerCode = '16500';
SET @LowerBnd='4546174000';
SET @UpperBnd= '4546174999';

SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerId = (SELECT `id` from SubIssuer where `fk_id_issuer` = @issuerId);

SET @ProfileSetId = (SELECT id FROM `ProfileSet` WHERE `fk_id_subIssuer` = @subIssuerId AND `name` ='PS_16500_01');
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						`name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
						`sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
						`coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', FALSE, NOW(), @LowerBnd, 16, FALSE, NULL,  @UpperBnd, FALSE, @ProfileSetId, @MaestroVID, NULL);

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4546174000' AND b.upperBound='4546174999' AND b.fk_id_profileSet=@ProfileSetId
  AND s.code=@subIssuerCode;