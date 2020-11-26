USE `U7G_ACS_BO`;

SET @BankB = 'SWISSKEY';

SET @BankUB_LLB = 'LLB';

SET @IssuerCode = '41001';
SET @SubIssuerCodeLLB = '88000';


set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_subIssuerLLB = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeLLB);

set @id_profile_setLLB = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subIssuerLLB);

SET FOREIGN_KEY_CHECKS = 0;

-- delete the profile set / custompage layout mapping

delete from CustomPageLayout_ProfileSet where PROFILESET_ID in
                                              (@id_profile_setLLB);

-- delete profiles for sub issuer
set @id_customitemsets = (select group_concat(cis.id) from CustomItemSet cis,
                                                           Profile p,
                                                           Rule r ,
                                                           ProfileSet_Rule pr
                          where  p.FK_ID_CUSTOMITEMSETCURRENT = cis.id
                                 and r.FK_ID_PROFILE = p.ID
                                 and pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET in
                                     (@id_profile_setLLB));

update Profile p set p.FK_ID_CUSTOMITEMSETCURRENT = null where find_in_set(FK_ID_CUSTOMITEMSETCURRENT, @id_customitemsets);
delete from CustomItemSet where find_in_set(id, @id_customitemsets);
delete from CustomItemSet where name like CONCAT('customitemset_', @BankUB_LLB, '%');

set @id_profile = (select group_concat(p.id) from Profile p,
                                                  Rule r ,
                                                  ProfileSet_Rule pr
                          where  r.FK_ID_PROFILE = p.ID
                                 and pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET in
                                     (@id_profile_setLLB));

set @id_rule = (select group_concat(r.id) from Rule r ,
                                               ProfileSet_Rule pr
                          where  pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET in
                                     (@id_profile_setLLB));

-- delete conditions
SELECT r.id from Rule r, ProfileSet_Rule pr
                       where pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                   (@id_profile_setLLB);


SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@id_profile_setLLB);

delete from Condition_TransactionStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@id_profile_setLLB));

delete from Condition_MeansProcessStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@id_profile_setLLB));

delete from RuleCondition where ID in (SELECT id from (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@id_profile_setLLB)) as temp);


-- update Rule set FK_ID_PROFILE = NULL where find_in_set(FK_ID_PROFILE, @id_profile);

delete from Profile where find_in_set(id, @id_profile);

set @id_rule = (select group_concat(r.id) from Rule r , ProfileSet_Rule pr
                          where  pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET in
                                     (@id_profile_setLLB));

-- update Profileset_Rule set ID_RULE = null where find_in_set(ID_RULE, @id_rule);

delete from ProfileSet_Rule where ID_PROFILESET in
                                  (@id_profile_setLLB);
delete from Rule where find_in_set(id, @id_rule);


delete from ProfileSet where id in (@id_profile_setLLB);

-- delete subissuer and issuer
delete from SubIssuerCrypto where FK_ID_SUBISSUER in
                                  (@id_subIssuerLLB);
delete from SubIssuer where ID in
                            (@id_subIssuerLLB);

delete from Image where name in
                        (@BankUB_LLB);
SET FOREIGN_KEY_CHECKS = 1;