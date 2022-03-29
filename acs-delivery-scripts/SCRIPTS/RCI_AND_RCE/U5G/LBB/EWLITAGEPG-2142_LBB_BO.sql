USE `U5G_ACS_BO`;

SET @createdBy = 'W100851';

SET @BankB_1 = 'Landesbank Berlin';
SET @IssuerCode = '19600';
SET @SubIssuerCode_1 = '19600';


set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_subissuer_1 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCode_1);

set @id_profile_set_1 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer_1);

SET @NetworkVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @NetworkMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @NetworkJCB = (SELECT `id` FROM `Network` WHERE `code` = 'JCB');

SET FOREIGN_KEY_CHECKS = 0;
-- delete Crypto Config
DELETE FROM CryptoConfig WHERE description = 'CryptoConfig for LBB';

-- delete Crypto Config for Paybox and VW_AUDI
DELETE FROM CryptoConfig WHERE description = 'CryptoConfig for Paybox';
DELETE FROM CryptoConfig WHERE description = 'CryptoConfig for VW_AUDI';

-- delete custom items for sub issuer
SET @customItemSetIds = (SELECT group_concat(id) FROM CustomItemSet where fk_id_subIssuer = @id_subissuer_1);
DELETE FROM CustomItem WHERE find_in_set(fk_id_customItemSet, @customItemSetIds);

delete from BinRange_SubIssuer where ID_BINRANGE in (select id from BinRange where FK_ID_PROFILESET in (@id_profile_set_1) and fk_id_network in (@NetworkVID, @NetworkMID, @NetworkJCB));

delete from BinRange where FK_ID_PROFILESET in (@id_profile_set_1) and fk_id_network in (@NetworkVID, @NetworkMID,@NetworkJCB);

delete from Network_SubIssuer where ID_SUBISSUER in (@id_subissuer_1) and id_network in (@NetworkVID, @NetworkMID,@NetworkJCB);

SET @pageLayoutIds = (SELECT group_concat(id) FROM CustomPageLayout WHERE description like CONCAT('%',@BankB_1,'%'));
DELETE from CustomComponent where find_in_set(fk_id_layout, @pageLayoutIds);

-- delete the profile set / custompage layout mapping
delete from CustomPageLayout_ProfileSet where PROFILESET_ID in (@id_profile_set_1);

delete from CustomPageLayout where DESCRIPTION like CONCAT('%',@BankB_1,'%');

-- delete profiles for sub issuer
set @id_customitemsets = (select group_concat(cis.id) from CustomItemSet cis,
                                                           Profile p,
                                                           Rule r ,
                                                           ProfileSet_Rule pr
                          where  p.FK_ID_CUSTOMITEMSETCURRENT = cis.id
                            and r.FK_ID_PROFILE = p.ID
                            and pr.ID_RULE = r.ID
                            and pr.ID_PROFILESET in (@id_profile_set_1));

update Profile p set p.FK_ID_CUSTOMITEMSETCURRENT = null where find_in_set(FK_ID_CUSTOMITEMSETCURRENT, @id_customitemsets);

delete from CustomItemSet where find_in_set(id, @id_customitemsets);
delete from CustomItemSet where fk_id_subIssuer in (@id_subissuer_1);

set @id_rule = (select group_concat(r.id) from Rule r , ProfileSet_Rule pr
                where  pr.ID_RULE = r.ID
                  and pr.ID_PROFILESET in (@id_profile_set_1));

-- delete conditions
delete from Condition_TransactionStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in (@id_profile_set_1));

delete from Condition_MeansProcessStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in (@id_profile_set_1));

delete from RuleCondition where ID in (SELECT id from (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                                                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                                                            (@id_profile_set_1)) as temp);

set @id_profile = (select group_concat(p.id) from Profile p, Rule r , ProfileSet_Rule pr
                   where  r.FK_ID_PROFILE = p.ID
                     and pr.ID_RULE = r.ID
                     and pr.ID_PROFILESET in (@id_profile_set_1));
delete from Profile where find_in_set(id, @id_profile);

delete from ProfileSet_Rule where ID_PROFILESET in (@id_profile_set_1);

delete from Rule where find_in_set(id, @id_rule);

delete from ProfileSet where id in (@id_profile_set_1);

delete from MerchantPivotList where FK_ID_ISSUER = @id_issuer;

delete from SpecificReports_Issuer where id_issuer = @id_issuer;

-- delete subissuer and issuer
delete from SubIssuer where ID in (@id_subIssuer_1);

delete from Issuer where ID = @id_issuer;

delete from Image where name like  '%LBB_LOGO%';

SET FOREIGN_KEY_CHECKS = 1;
