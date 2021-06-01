-- deletes the whole etup for OP Bank (Issuer Code 20000)

USE `U5G_ACS_BO`;

start transaction;

-- 1. delete from
SET @issuerCode = '19440';
SET @subIssuerCode = '19440';
SET @BankB = 'Commerzbank AG';
SET @BankUB = 'COZ';
set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_subissuer = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @subIssuerCode);
set @id_profile_set = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer);
SET FOREIGN_KEY_CHECKS=0;
-- delete all the custom components
delete from CustomComponent
where ID
      in (select id from (select CC.ID
          from CustomComponent CC, CustomPageLayout CP
          where CC.FK_ID_LAYOUT = CP.ID and CP.DESCRIPTION 
									like CONCAT('%(',@BankB, ')%')) as temp);

-- delete the profile set / custompage layout mapping
delete from CustomPageLayout_ProfileSet where PROFILESET_ID = @id_profile_set;

delete from CustomPageLayout where DESCRIPTION like CONCAT('%(',@BankB, ')%');

-- delete profiles and custom items set for sub issuer

set @id_customitemsets = (select group_concat(cis.id) from CustomItemSet cis,
                                                           Profile p,
                                                           Rule r ,
                                                           ProfileSet_Rule pr
                          where  p.FK_ID_CUSTOMITEMSETCURRENT = cis.id
                                 and r.FK_ID_PROFILE = p.ID
                                 and pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET = @id_profile_set);

update Profile p set p.FK_ID_CUSTOMITEMSETCURRENT = null where find_in_set(FK_ID_CUSTOMITEMSETCURRENT, @id_customitemsets);
delete from CustomItemSet where find_in_set(id, @id_customitemsets);
delete from CustomItemSet where name like CONCAT('customitemset_', @BankUB, '%');

set @id_profile = (select group_concat(p.id) from Profile p,
                                                  Rule r ,
                                                  ProfileSet_Rule pr
                          where  r.FK_ID_PROFILE = p.ID
                                 and pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET = @id_profile_set);

set @id_rule = (select group_concat(r.id) from Rule r ,
                                               ProfileSet_Rule pr
                          where  pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET = @id_profile_set);

-- delete conditions

delete from Condition_TransactionStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET = @id_profile_set);

delete from Condition_MeansProcessStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET = @id_profile_set);

delete from RuleCondition where ID in (SELECT id from (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET = @id_profile_set) as temp);

-- update Rule set FK_ID_PROFILE = NULL where find_in_set(FK_ID_PROFILE, @id_profile);

delete from Profile where find_in_set(id, @id_profile);

set @id_rule = (select group_concat(r.id) from Rule r , ProfileSet_Rule pr
                          where  pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET = @id_profile_set);

-- update Profileset_Rule set ID_RULE = null where find_in_set(ID_RULE, @id_rule);

delete from ProfileSet_Rule where ID_PROFILESET = @id_profile_set;
delete from Rule where find_in_set(id, @id_rule);

delete from ProfileSet where id = @id_profile_set;
delete from MerchantPivotList where FK_ID_SUBISSUER = @id_subissuer;
-- delete subissuer and issuer

delete from SubIssuerCrypto where FK_ID_SUBISSUER = @id_subissuer;

delete from SubIssuer where ID = @id_subissuer;
delete from Issuer where ID = @id_issuer;
delete from Image where name in (@BankB);
SET FOREIGN_KEY_CHECKS=1;
commit;