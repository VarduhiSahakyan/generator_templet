-- deletes the whole etup for OP Bank (Issuer Code 20000)

USE `U5G_ACS_BO`;

start transaction;

-- 1. delete from
SET @issuerCode = '19440';
SET @subIssuerCode = '19440';
set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_subissuer = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode);
set @id_profile_set = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer);
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET FOREIGN_KEY_CHECKS=0;
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
                                                     and ci.fk_id_network = @MaestroVID
                                                     ) as temp);


delete from BinRange_SubIssuer where ID_BINRANGE in (select id from BinRange where FK_ID_PROFILESET = @id_profile_set and fk_id_network = @MaestroVID);

delete from BinRange where FK_ID_PROFILESET = @id_profile_set and fk_id_network = @MaestroVID;
-- delete subissuer and issuer

delete from Network_SubIssuer where ID_SUBISSUER = @id_subissuer and id_network = @MaestroVID;
delete from SubIssuerNetworkCrypto where FK_ID_SUBISSUER = @id_subissuer and fk_id_network = @MaestroVID;
SET FOREIGN_KEY_CHECKS=1;
commit;