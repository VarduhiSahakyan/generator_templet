-- deletes the whole etup for OP Bank (Issuer Code 20000)

USE `U5G_ACS_BO`;

start transaction;

-- 1. delete from
SET @issuerCode = '00006';
SET @subIssuerCode = '00006';
set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_subissuer = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode);
set @id_profile_set = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer);
SET @MaestroJID = (SELECT `id` FROM `Network` WHERE `code` = 'JCB');

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
                                                     and pr.ID_PROFILESET = @id_profile_set
                                                     and ci.fk_id_network = @MaestroJID
                                                     ) as temp);


delete from BinRange_SubIssuer where ID_BINRANGE in (select id from BinRange where FK_ID_PROFILESET = @id_profile_set and fk_id_network = @MaestroJID);

delete from BinRange where FK_ID_PROFILESET = @id_profile_set and fk_id_network = @MaestroJID;
-- delete subissuer and issuer

delete from Network_SubIssuer where ID_SUBISSUER = @id_subissuer and id_network = @MaestroJID;
delete from SubIssuerNetworkCrypto where FK_ID_SUBISSUER = @id_subissuer and fk_id_network = @MaestroJID;

set foreign_key_checks = 0;
delete from Network where code = 'JCB';
delete from Image where name in ('JCB_LOGO');
set foreign_key_checks = 1;

commit;