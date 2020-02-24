
-- deletes the whole etup for ReiseBank (Issuer Code 20000)

USE `U5G_ACS_BO`;

start transaction;

-- 1. delete from
set @id_issuer = (SELECT ID from Issuer where CODE = '10300');
select @id_issuer;

set @id_subissuer = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer);
select @id_subissuer;

set @id_profile_set = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer);

-- delete all the custom components
delete from CustomComponent
where ID
      in (select id from (select CC.ID
          from CustomComponent CC, CustomPageLayout CP
          where CC.FK_ID_LAYOUT = CP.ID and CP.DESCRIPTION in
                                            ('Message Banner (ReiseBank)',
'Refusal Page (ReiseBank)',
'Help Page (ReiseBank)',
'OTP Form Page (ReiseBank)',
'Hamburger Menu (ReiseBank)')) as temp);

-- delete the profile set / custompage layout mapping
delete from CustomPageLayout_ProfileSet where PROFILESET_ID = @id_profile_set;

delete from CustomPageLayout where DESCRIPTION in
                                            ('Message Banner (ReiseBank)',
'Failure Page (ReiseBank)',
'Refusal Page (ReiseBank)',
'Help Page (ReiseBank)',
'OTP Form Page (ReiseBank)',
'Hamburger Menu (ReiseBank)');

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
                                                     ) as temp);


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


delete from Condition_TransactionStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET = @id_profile_set);

delete from Condition_MeansProcessStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET = @id_profile_set);

delete from RuleCondition where ID in (SELECT id from (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET = @id_profile_set) as temp);

set foreign_key_checks = 0;

-- update Rule set FK_ID_PROFILE = NULL where find_in_set(FK_ID_PROFILE, @id_profile);

delete from Profile where find_in_set(id, @id_profile);

set @id_rule = (select group_concat(r.id) from Rule r , ProfileSet_Rule pr
                          where  pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET = @id_profile_set);

-- update Profileset_Rule set ID_RULE = null where find_in_set(ID_RULE, @id_rule);

delete from ProfileSet_Rule where ID_PROFILESET = @id_profile_set;
delete from Rule where find_in_set(id, @id_rule);

set foreign_key_checks = 1;

delete from BinRange_SubIssuer where ID_BINRANGE in (select id from BinRange where FK_ID_PROFILESET = @id_profile_set);

delete from BinRange where FK_ID_PROFILESET = @id_profile_set;
delete from ProfileSet where id = @id_profile_set;

-- delete subissuer and issuer

delete from Network_SubIssuer where ID_SUBISSUER = @id_subissuer;
delete from SubIssuerCrypto where FK_ID_SUBISSUER = @id_subissuer;
delete from SubIssuerNetworkCrypto where FK_ID_SUBISSUER = @id_subissuer;

delete from SubIssuer where ID = @id_subissuer;

delete from Issuer where ID = @id_issuer;

delete from Image where name in ('REISEBANK_LOGO');

commit;