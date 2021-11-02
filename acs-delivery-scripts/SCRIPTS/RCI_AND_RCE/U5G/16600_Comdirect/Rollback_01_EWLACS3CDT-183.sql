USE U5G_ACS_BO;

SET @issuerId = (SELECT id FROM Issuer WHERE name = 'Comdirect' AND code = '16600');

UPDATE SubIssuer SET authenticationTimeOut = 120 where fk_id_issuer = @issuerId;