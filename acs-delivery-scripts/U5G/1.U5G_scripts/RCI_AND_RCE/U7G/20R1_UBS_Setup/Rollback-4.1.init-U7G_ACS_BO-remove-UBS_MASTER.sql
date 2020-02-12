USE `U7G_ACS_BO`;

SET @BankB = 'UBS';

SET @IssuerCode = '23000';
SET @SubIssuerCodeA = '23000';

START TRANSACTION;

set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_subissuer_1 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeA);

set @id_profile_set_1 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer_1);
SET @NetworkID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');

SET FOREIGN_KEY_CHECKS = 0;
-- delete profiles and custom items for sub issuer

delete from CustomItem where FK_ID_CUSTOMITEMSET IS NULL OR id in (select id from (select ci.id from CustomItem ci,
                                                                                                     CustomItemSet cis,
                                                                                                     Profile p,
                                                                                                     Rule r,
                                                                                                     ProfileSet_Rule pr
                                                                                   where ci.FK_ID_CUSTOMITEMSET = cis.ID
                                                                                     and p.FK_ID_CUSTOMITEMSETCURRENT = cis.id
                                                                                     and r.FK_ID_PROFILE = p.ID
                                                                                     and pr.ID_RULE = r.ID
                                                                                     and pr.ID_PROFILESET in
                                                                                         (@id_profile_set_1)
                                                                                     and ci.fk_id_network = @NetworkID
                                                                                  ) as temp);


delete from BinRange_SubIssuer where ID_BINRANGE in (select id from BinRange where FK_ID_PROFILESET in (@id_profile_set_1)
                                                                               and fk_id_network = @NetworkID);

delete from BinRange where FK_ID_PROFILESET in (@id_profile_set_1)
                       and fk_id_network = @NetworkID;
-- delete subissuer and issuer

delete from Network_SubIssuer where ID_SUBISSUER in (@id_subissuer_1)
                                and id_network = @NetworkID;
delete from SubIssuerNetworkCrypto where FK_ID_SUBISSUER in (@id_subissuer_1)
                                     and fk_id_network = @NetworkID;

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;