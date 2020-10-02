USE `U7G_ACS_BO`;

SET @BankB = 'SWISSQUOTE';

SET @BankUB_01 = 'SQN';

SET @IssuerCode = '00601';
SET @SubIssuerCodeA = '00601';

START TRANSACTION;

set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_subIssuer_1 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeA);

set @id_profile_set_1 = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subIssuer_1);

SET FOREIGN_KEY_CHECKS = 0;

-- delete all the custom components
delete from CustomComponent
where ID in (select id
             from (select CC.ID
                   from CustomComponent CC,
                        CustomPageLayout CP
                   where CC.FK_ID_LAYOUT = CP.ID
                     and (CP.DESCRIPTION like CONCAT('%(', @BankB, ')%'))) as temp);

-- delete the profile set / custompage layout mapping
delete from CustomPageLayout_ProfileSet where PROFILESET_ID in (@id_profile_set_1);

delete from CustomPageLayout where DESCRIPTION like CONCAT('%(', @BankB, ')%');

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
delete from CustomItemSet where name like CONCAT('customitemset_', @BankUB_01, '%');

set @id_profile = (select group_concat(p.id) from Profile p,
                                                  Rule r ,
                                                  ProfileSet_Rule pr
                   where  r.FK_ID_PROFILE = p.ID
                     and pr.ID_RULE = r.ID
                     and pr.ID_PROFILESET in (@id_profile_set_1));

set @id_rule = (select group_concat(r.id) from Rule r , ProfileSet_Rule pr
                where  pr.ID_RULE = r.ID
                  and pr.ID_PROFILESET in (@id_profile_set_1));

-- delete conditions
SELECT r.id from Rule r, ProfileSet_Rule pr
where pr.ID_RULE = r.id and pr.ID_PROFILESET in (@id_profile_set_1);

SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in (@id_profile_set_1);

delete from Condition_TransactionStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in (@id_profile_set_1));

delete from Condition_MeansProcessStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in (@id_profile_set_1));

delete from RuleCondition where ID in (SELECT id from (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                                                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                                                            (@id_profile_set_1)) as temp);

delete from Profile where find_in_set(id, @id_profile);

set @id_rule = (select group_concat(r.id) from Rule r , ProfileSet_Rule pr
                where  pr.ID_RULE = r.ID and pr.ID_PROFILESET in (@id_profile_set_1));

-- update Profileset_Rule set ID_RULE = null where find_in_set(ID_RULE, @id_rule);

delete from ProfileSet_Rule where ID_PROFILESET in (@id_profile_set_1);

delete from Rule where find_in_set(id, @id_rule);

delete from ProfileSet where id in (@id_profile_set_1);

delete from MerchantPivotList where FK_ID_ISSUER = @id_issuer;

-- delete subissuer and issuer
delete from SubIssuerCrypto where FK_ID_SUBISSUER in (@id_subIssuer_1);

delete from SubIssuer where ID in (@id_subIssuer_1);

delete from Issuer where ID = @id_issuer;

delete from Image where name in (@BankUB_01);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;