USE `U7G_ACS_BO`;

SET @BankB = 'SWISSKEY';

SET @IssuerCode = '41001';
SET @SubIssuerCodeLLB = '88000';

set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_subissuerLLB = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeLLB);

set @id_profile_setLLB = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuerLLB);

SET @NetworkVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @NetworkID = NULL;

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
                                                                                         (@id_profile_setLLB)
                                                                                     and (ci.fk_id_network is NULL or ci.fk_id_network = @NetworkVID)
                                                                                  ) as temp);


delete from BinRange_SubIssuer where ID_BINRANGE in (select id from BinRange where FK_ID_PROFILESET in (@id_profile_setLLB)
                                                                               and fk_id_network = @NetworkVID);

delete from BinRange where FK_ID_PROFILESET in (@id_profile_setLLB)
                       and fk_id_network = @NetworkVID;
-- delete subissuer and issuer

delete from Network_SubIssuer where ID_SUBISSUER in (@id_subissuerLLB)
                                and id_network = @NetworkVID;
delete from SubIssuerNetworkCrypto where FK_ID_SUBISSUER in (@id_subissuerLLB)
                                     and fk_id_network = @NetworkVID;

SET FOREIGN_KEY_CHECKS = 1;