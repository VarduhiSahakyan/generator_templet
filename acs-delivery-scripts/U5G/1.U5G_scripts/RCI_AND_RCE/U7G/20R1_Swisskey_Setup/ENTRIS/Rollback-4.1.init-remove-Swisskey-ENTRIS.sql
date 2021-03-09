USE `U7G_ACS_BO`;

SET @BankB = 'SWISSKEY';

SET @BankUB_ENTRIS = 'ENTRIS';

SET @IssuerCode = '41001';
SET @SubIssuerCodeENTRIS = '69900';

START TRANSACTION;

set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_subIssuer_entris = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeENTRIS);
set @NetworkMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');


SET FOREIGN_KEY_CHECKS = 0;
-- delete CustomItem
delete from CustomItem where name = 'Bank Logo' and ordinal = @SubIssuerCodeENTRIS and value = @BankUB_ENTRIS and pageTypes = 'ALL';

-- delete Network_SubIssuer
delete from Network_SubIssuer where ID_SUBISSUER in (@id_subIssuer_entris)
                                and id_network = @NetworkMID;


-- delete BinRange_SubIssuer and BinRange
delete from BinRange_SubIssuer where ID_BINRANGE in (select id from BinRange where lowerBound = '5352220000' and upperBound = '5352220099'
                                                                               and fk_id_network = @NetworkMID);

delete from BinRange where lowerBound = '5352220000' and upperBound = '5352220099'
                       and fk_id_network = @NetworkMID;

-- delete subissuer and issuer
delete from SubIssuer where ID in
                            (@id_subIssuer_entris);

delete from Image where name in
                        (@BankUB_ENTRIS);



SET FOREIGN_KEY_CHECKS = 1;
COMMIT;