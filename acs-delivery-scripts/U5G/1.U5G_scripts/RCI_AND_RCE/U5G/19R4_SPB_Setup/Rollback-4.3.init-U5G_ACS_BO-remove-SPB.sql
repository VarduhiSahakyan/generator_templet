USE `U5G_ACS_BO`;

START TRANSACTION;
SET FOREIGN_KEY_CHECKS = 0;
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

SET @BankB_Shared = 'SPB_sharedBIN';
SET @BankB_01 = 'SBK_Hessen';
SET @BankB_02 = 'SBK_Hamburg';
SET @BankB_03 = 'SBK_Ostbayern';
SET @BankB_04 = 'SBK_Augsburg';
SET @BankB_05 = 'SBK_München';
SET @BankB_06 = 'SBK_Baden-Württemberg';
SET @BankB_07 = 'SBK_Nürnberg';
SET @BankB_08 = 'SBK_Südwest ';
SET @BankB_09 = 'SBK_Hannover';
SET @BankB_10 = 'SBK_West';

SET @BankUB_Shared = 'SPB_sharedBIN';
SET @BankUB_01 = 'SBK_Hessen';
SET @BankUB_02 = 'SBK_Hamburg';
SET @BankUB_03 = 'SBK_Ostbayern';
SET @BankUB_04 = 'SBK_Augsburg';
SET @BankUB_05 = 'SBK_München';
SET @BankUB_06 = 'SBK_Baden-Württemberg';
SET @BankUB_07 = 'SBK_Nürnberg';
SET @BankUB_08 = 'SBK_Südwest ';
SET @BankUB_09 = 'SBK_Hannover';
SET @BankUB_10 = 'SBK_West';


set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_sharedSubIssuer = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @sharedSubIssuerCode);
set @id_subIssuer_1 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_01);
set @id_subIssuer_2 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_02);
set @id_subIssuer_3 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_03);
set @id_subIssuer_4 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_04);
set @id_subIssuer_5 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_05);
set @id_subIssuer_6 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_06);
set @id_subIssuer_7 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_07);
set @id_subIssuer_8 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_08);
set @id_subIssuer_9 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_09);
set @id_subIssuer_10 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode_10);

set @id_sharedProfile_set = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_sharedSubIssuer);
set @id_profile_set_1 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subIssuer_1);
set @id_profile_set_2 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subIssuer_2);
set @id_profile_set_3 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subIssuer_3);
set @id_profile_set_4 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subIssuer_4);
set @id_profile_set_5 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subIssuer_5);
set @id_profile_set_6 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subIssuer_6);
set @id_profile_set_7 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subIssuer_7);
set @id_profile_set_8 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subIssuer_8);
set @id_profile_set_9 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subIssuer_9);
set @id_profile_set_10 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subIssuer_10);

-- delete all the custom components
delete from CustomComponent
where ID in (select id
             from (select CC.ID
                   from CustomComponent CC,
                        CustomPageLayout CP
                   where CC.FK_ID_LAYOUT = CP.ID
                     and (
                           CP.DESCRIPTION like CONCAT('%(', @BankB_Shared, ')%') or
                           CP.DESCRIPTION like CONCAT('%(', @BankB_01, ')%') or
                           CP.DESCRIPTION like CONCAT('%(', @BankB_02, ')%') or
                           CP.DESCRIPTION like CONCAT('%(', @BankB_03, ')%') or
                           CP.DESCRIPTION like CONCAT('%(', @BankB_04, ')%') or
                           CP.DESCRIPTION like CONCAT('%(', @BankB_05, ')%') or
                           CP.DESCRIPTION like CONCAT('%(', @BankB_06, ')%') or
                           CP.DESCRIPTION like CONCAT('%(', @BankB_07, ')%') or
                           CP.DESCRIPTION like CONCAT('%(', @BankB_08, ')%') or
                           CP.DESCRIPTION like CONCAT('%(', @BankB_09, ')%') or
                           CP.DESCRIPTION like CONCAT('%(', @BankB_10, ')%')
                       )
                  ) as temp);

-- delete the profile set / custompage layout mapping

delete from CustomPageLayout_ProfileSet where PROFILESET_ID in
                                              (@id_sharedProfile_set, @id_profile_set_1,
                                               @id_profile_set_2, @id_profile_set_3, @id_profile_set_4,
                                               @id_profile_set_5, @id_profile_set_6, @id_profile_set_7,
                                               @id_profile_set_8, @id_profile_set_9, @id_profile_set_10);

delete from CustomPageLayout where DESCRIPTION like CONCAT('%(', @BankB_Shared, ')%')
                                or DESCRIPTION like CONCAT('%(', @BankB_01, ')%')
                                or DESCRIPTION like CONCAT('%(', @BankB_02, ')%')
                                or DESCRIPTION like CONCAT('%(', @BankB_03, ')%')
                                or DESCRIPTION like CONCAT('%(', @BankB_04, ')%')
                                or DESCRIPTION like CONCAT('%(', @BankB_05, ')%')
                                or DESCRIPTION like CONCAT('%(', @BankB_06, ')%')
                                or DESCRIPTION like CONCAT('%(', @BankB_07, ')%')
                                or DESCRIPTION like CONCAT('%(', @BankB_08, ')%')
                                or DESCRIPTION like CONCAT('%(', @BankB_09, ')%')
                                or DESCRIPTION like CONCAT('%(', @BankB_10, ')%');

-- delete profiles for sub issuer
set @id_customitemsets = (select group_concat(cis.id) from CustomItemSet cis,
                                                           Profile p,
                                                           Rule r ,
                                                           ProfileSet_Rule pr
                          where  p.FK_ID_CUSTOMITEMSETCURRENT = cis.id
                                 and r.FK_ID_PROFILE = p.ID
                                 and pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET in
                                     (@id_sharedProfile_set, @id_profile_set_1, @id_profile_set_2,
                                      @id_profile_set_3, @id_profile_set_4, @id_profile_set_5, @id_profile_set_6,
                                      @id_profile_set_7, @id_profile_set_8, @id_profile_set_9, @id_profile_set_10));

update Profile p set p.FK_ID_CUSTOMITEMSETCURRENT = null where find_in_set(FK_ID_CUSTOMITEMSETCURRENT, @id_customitemsets);
delete from CustomItemSet where find_in_set(id, @id_customitemsets);
delete from CustomItemSet where name like CONCAT('customitemset_', @BankUB_Shared, '%')
                             or name like CONCAT('customitemset_', @BankUB_01, '%')
                             or name like CONCAT('customitemset_', @BankUB_02, '%')
                             or name like CONCAT('customitemset_', @BankUB_03, '%')
                             or name like CONCAT('customitemset_', @BankUB_04, '%')
                             or name like CONCAT('customitemset_', @BankUB_05, '%')
                             or name like CONCAT('customitemset_', @BankUB_06, '%')
                             or name like CONCAT('customitemset_', @BankUB_07, '%')
                             or name like CONCAT('customitemset_', @BankUB_08, '%')
                             or name like CONCAT('customitemset_', @BankUB_09, '%')
                             or name like CONCAT('customitemset_', @BankUB_10, '%');

set @id_profile = (select group_concat(p.id) from Profile p,
                                                  Rule r ,
                                                  ProfileSet_Rule pr
                          where  r.FK_ID_PROFILE = p.ID
                                 and pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET in
                                     (@id_sharedProfile_set, @id_profile_set_1, @id_profile_set_2,
                                      @id_profile_set_3, @id_profile_set_4, @id_profile_set_5, @id_profile_set_6,
                                      @id_profile_set_7, @id_profile_set_8, @id_profile_set_9, @id_profile_set_10));

set @id_rule = (select group_concat(r.id) from Rule r ,
                                               ProfileSet_Rule pr
                          where  pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET in
                                     (@id_sharedProfile_set, @id_profile_set_1, @id_profile_set_2,
                                      @id_profile_set_3, @id_profile_set_4, @id_profile_set_5, @id_profile_set_6,
                                      @id_profile_set_7, @id_profile_set_8, @id_profile_set_9, @id_profile_set_10));

-- delete conditions
SELECT r.id from Rule r, ProfileSet_Rule pr
                       where pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                   (@id_sharedProfile_set, @id_profile_set_1,
                                                    @id_profile_set_2, @id_profile_set_3, @id_profile_set_4,
                                                    @id_profile_set_5, @id_profile_set_6, @id_profile_set_7,
                                                    @id_profile_set_8, @id_profile_set_9, @id_profile_set_10);


SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@id_sharedProfile_set,
                                                                             @id_profile_set_1, @id_profile_set_2,
                                                                             @id_profile_set_3, @id_profile_set_4,
                                                                             @id_profile_set_5, @id_profile_set_6,
                                                                             @id_profile_set_7, @id_profile_set_8,
                                                                             @id_profile_set_9, @id_profile_set_10);

delete from Condition_TransactionStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@id_sharedProfile_set,
                                                                             @id_profile_set_1, @id_profile_set_2,
                                                                             @id_profile_set_3, @id_profile_set_4,
                                                                             @id_profile_set_5, @id_profile_set_6,
                                                                             @id_profile_set_7, @id_profile_set_8,
                                                                             @id_profile_set_9, @id_profile_set_10));

delete from Condition_MeansProcessStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@id_sharedProfile_set,
                                                                             @id_profile_set_1, @id_profile_set_2,
                                                                             @id_profile_set_3, @id_profile_set_4,
                                                                             @id_profile_set_5, @id_profile_set_6,
                                                                             @id_profile_set_7, @id_profile_set_8,
                                                                             @id_profile_set_9, @id_profile_set_10));

delete from RuleCondition where ID in (SELECT id from (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@id_sharedProfile_set,
                                                                             @id_profile_set_1, @id_profile_set_2,
                                                                             @id_profile_set_3, @id_profile_set_4,
                                                                             @id_profile_set_5, @id_profile_set_6,
                                                                             @id_profile_set_7, @id_profile_set_8,
                                                                             @id_profile_set_9,
                                                                             @id_profile_set_10)) as temp);


-- update Rule set FK_ID_PROFILE = NULL where find_in_set(FK_ID_PROFILE, @id_profile);

delete from Profile where find_in_set(id, @id_profile);

set @id_rule = (select group_concat(r.id) from Rule r , ProfileSet_Rule pr
                          where  pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET in
                                     (@id_sharedProfile_set, @id_profile_set_1, @id_profile_set_2,
                                      @id_profile_set_3, @id_profile_set_4, @id_profile_set_5, @id_profile_set_6,
                                      @id_profile_set_7, @id_profile_set_8, @id_profile_set_9, @id_profile_set_10));

-- update Profileset_Rule set ID_RULE = null where find_in_set(ID_RULE, @id_rule);

delete from ProfileSet_Rule where ID_PROFILESET in
                                  (@id_sharedProfile_set, @id_profile_set_1, @id_profile_set_2,
                                   @id_profile_set_3, @id_profile_set_4, @id_profile_set_5, @id_profile_set_6,
                                   @id_profile_set_7, @id_profile_set_8, @id_profile_set_9, @id_profile_set_10);
delete from Rule where find_in_set(id, @id_rule);


delete from ProfileSet where id in (@id_sharedProfile_set, @id_profile_set_1, @id_profile_set_2,
                                    @id_profile_set_3, @id_profile_set_4, @id_profile_set_5, @id_profile_set_6,
                                    @id_profile_set_7, @id_profile_set_8, @id_profile_set_9, @id_profile_set_10);
delete from MerchantPivotList where FK_ID_ISSUER = @id_issuer;

-- delete subissuer and issuer
delete from SubIssuerCrypto where FK_ID_SUBISSUER in
                                  (@id_sharedSubIssuer, @id_subIssuer_1, @id_subIssuer_2,
                                   @id_subIssuer_3, @id_subIssuer_4, @id_subIssuer_5, @id_subIssuer_6, @id_subIssuer_7,
                                   @id_subIssuer_8, @id_subIssuer_9, @id_subIssuer_10);
delete from SubIssuer where ID in
                            (@id_sharedSubIssuer, @id_subIssuer_1, @id_subIssuer_2, @id_subIssuer_3,
                             @id_subIssuer_4, @id_subIssuer_5, @id_subIssuer_6, @id_subIssuer_7, @id_subIssuer_8,
                             @id_subIssuer_9, @id_subIssuer_10);
delete from Issuer where ID = @id_issuer;

delete from Image where name in
                        (@BankB_Shared, @BankB_01, @BankB_02, @BankB_03, @BankB_04, @BankB_05, @BankB_06,
                         @BankB_07, @BankB_08, @BankB_09, @BankB_10);
SET FOREIGN_KEY_CHECKS = 1;
COMMIT;