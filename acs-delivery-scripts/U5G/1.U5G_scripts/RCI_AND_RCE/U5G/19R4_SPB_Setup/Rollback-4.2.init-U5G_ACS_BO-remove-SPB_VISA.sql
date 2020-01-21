USE `U5G_ACS_BO`;

START TRANSACTION;

-- 1. delete from
SET @issuerCode = '16950';
SET @sharedSubIssuerCode = '99999';
SET @subIssuerCode_01 = '15009';
SET @subIssuerCode_02 = '12069';
SET @subIssuerCode_03 = '17509';
SET @subIssuerCode_04 = '17209';
SET @subIssuerCode_05 = '17009';
SET @subIssuerCode_06 = '16009';
SET @subIssuerCode_07 = '17609';
SET @subIssuerCode_08 = '15519';
SET @subIssuerCode_09 = '12509';
SET @subIssuerCode_10 = '13606';

set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_sharedSubissuer = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @sharedSubIssuerCode);
set @id_subissuer_1 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_01);
set @id_subissuer_2 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_02);
set @id_subissuer_3 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_03);
set @id_subissuer_4 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_04);
set @id_subissuer_5 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_05);
set @id_subissuer_6 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_06);
set @id_subissuer_7 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_07);
set @id_subissuer_8 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_08);
set @id_subissuer_9 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_09);
set @id_subissuer_10 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_10);

set @id_sharedProfile_set = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_sharedSubissuer);
set @id_profile_set_1 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer_1);
set @id_profile_set_2 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer_2);
set @id_profile_set_3 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer_3);
set @id_profile_set_4 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer_4);
set @id_profile_set_5 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer_5);
set @id_profile_set_6 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer_6);
set @id_profile_set_7 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer_7);
set @id_profile_set_8 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer_8);
set @id_profile_set_9 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer_9);
set @id_profile_set_10 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer_10);
SET @NetworkID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');

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
                                                                                         (@id_sharedProfile_set,
                                                                                          @id_profile_set_1,
                                                                                          @id_profile_set_2,
                                                                                          @id_profile_set_3,
                                                                                          @id_profile_set_4,
                                                                                          @id_profile_set_5,
                                                                                          @id_profile_set_6,
                                                                                          @id_profile_set_7,
                                                                                          @id_profile_set_8,
                                                                                          @id_profile_set_9,
                                                                                          @id_profile_set_10)
                                                                                     and ci.fk_id_network = @NetworkID
                                                                                  ) as temp);


delete from BinRange_SubIssuer where ID_BINRANGE in (select id from BinRange where FK_ID_PROFILESET in (@id_sharedProfile_set,
                                                                                                        @id_profile_set_1,
                                                                                                        @id_profile_set_2,
                                                                                                        @id_profile_set_3,
                                                                                                        @id_profile_set_4,
                                                                                                        @id_profile_set_5,
                                                                                                        @id_profile_set_6,
                                                                                                        @id_profile_set_7,
                                                                                                        @id_profile_set_8,
                                                                                                        @id_profile_set_9,
                                                                                                        @id_profile_set_10)
                                                                               and fk_id_network = @NetworkID);

delete from BinRange where FK_ID_PROFILESET in (@id_sharedProfile_set,
                                                @id_profile_set_1,
                                                @id_profile_set_2,
                                                @id_profile_set_3,
                                                @id_profile_set_4,
                                                @id_profile_set_5,
                                                @id_profile_set_6,
                                                @id_profile_set_7,
                                                @id_profile_set_8,
                                                @id_profile_set_9,
                                                @id_profile_set_10)
                       and fk_id_network = @NetworkID;
-- delete subissuer and issuer

delete from Network_SubIssuer where ID_SUBISSUER in (@id_sharedSubissuer,
                                                     @id_subissuer_1,
                                                     @id_subissuer_2,
                                                     @id_subissuer_3,
                                                     @id_subissuer_4,
                                                     @id_subissuer_5,
                                                     @id_subissuer_6,
                                                     @id_subissuer_7,
                                                     @id_subissuer_8,
                                                     @id_subissuer_9,
                                                     @id_subissuer_10)
                                and id_network = @NetworkID;
delete from SubIssuerNetworkCrypto where FK_ID_SUBISSUER in (@id_sharedSubissuer,
                                                             @id_subissuer_1,
                                                             @id_subissuer_2,
                                                             @id_subissuer_3,
                                                             @id_subissuer_4,
                                                             @id_subissuer_5,
                                                             @id_subissuer_6,
                                                             @id_subissuer_7,
                                                             @id_subissuer_8,
                                                             @id_subissuer_9,
                                                             @id_subissuer_10)
                                     and fk_id_network = @NetworkID;

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;