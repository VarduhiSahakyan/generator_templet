USE `U5G_ACS_BO`;
SET @createdBy = 'A758582';

SET @BankUB = 'ING';
SET @issuerCode = '16500';

SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerId = (SELECT `id` from SubIssuer where `fk_id_issuer` = @issuerId);

SET @ProfileSetId = (SELECT id FROM `ProfileSet` WHERE `fk_id_subIssuer` = @subIssuerId AND `name` ='PS_16500_01');

DELETE FROM BinRange_SubIssuer WHERE ID_BINRANGE IN (SELECT id FROM BinRange WHERE `fk_id_profileSet` = @ProfileSetId AND `lowerBound` = '4546172000' AND `upperBound` = '4546172999');

DELETE FROM BinRange WHERE `fk_id_profileSet` = @ProfileSetId AND `lowerBound` = '4546172000' AND `upperBound` = '4546172999';