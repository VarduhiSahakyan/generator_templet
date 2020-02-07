-- deletes the whole etup for OP Bank (Issuer Code 20000)

USE `U5G_ACS_BO`;

start transaction;

-- 1. delete from
set @id_issuer = (SELECT ID from Issuer where CODE = '16600');
set @id_subissuer = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer);
set @id_profile_set = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuer);



-- delete all the custom components
delete from CustomComponent
where ID
      in (select id from (select CC.ID
          from CustomComponent CC, CustomPageLayout CP
          where CC.FK_ID_LAYOUT = CP.ID and CP.DESCRIPTION in
                                            ('Refusal Page (Comdirect)',
                                              'OTP Form Page (Comdirect)',
                                              'Message Banner (Comdirect)',
                                              'Failure Page (Comdirect)',
                                              'Help Page (Comdirect)',
                                              'OTP Phototan Form Page (Comdirect)',
                                              'OTP Itan Form Page (Comdirect)',
                                              'OTP SMS Form Page (Comdirect)')) as temp);

-- delete the profile set / custompage layout mapping
delete from CustomPageLayout_ProfileSet where PROFILESET_ID = @id_profile_set;

delete from CustomPageLayout where DESCRIPTION in
                                            ('Refusal Page (Comdirect)',
                                              'OTP Form Page (Comdirect)',
                                              'Message Banner (Comdirect)',
                                              'Failure Page (Comdirect)',
                                              'Help Page (Comdirect)', 
                                              'OTP Phototan Form Page (Comdirect)',
                                              'OTP Itan Form Page (Comdirect)',
                                              'OTP SMS Form Page (Comdirect)');

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

-- delete conditions
SELECT r.id from Rule r, ProfileSet_Rule pr
                       where pr.ID_RULE = r.id and pr.ID_PROFILESET = @id_profile_set;


SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET = @id_profile_set;

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

delete from CustomItem where fk_id_customItemSet in (select id from CustomItemSet where name like 'customitemset_16600%');

delete from Condition_MeansProcessStatuses where id_condition in ( select id from RuleCondition where name like '%COMDIRECT%');
delete from Condition_TransactionStatuses where id_condition in ( select id from RuleCondition where name like '%COMDIRECT%');

delete from RuleCondition where name like '%COMDIRECT%';

delete from Rule where fk_id_profile in ( select id from Profile
where fk_id_customItemSetCurrent in (select id from CustomItemSet
	where fk_id_subissuer in (select id from SubIssuer where name = 'Comdirect')));

delete from Rule where fk_id_profile in (	select id from Profile where name like '%16600%');

delete from Rule where name like '%Comdirect%' or description like '%Comdirect%';

delete from Profile where name like '%16600%';

delete from CustomItemSet where fk_id_subissuer in (select id from SubIssuer where name = 'Comdirect');

delete from Profile where fk_id_subissuer in (select id from SubIssuer where name = 'Comdirect');

delete from SubIssuer where ID = @id_subissuer;
delete from Issuer where ID = @id_issuer;

delete from MeansProcessStatuses where fk_id_authentMean in (SELECT id from AuthentMeans where name in ('OTP_PHOTOTAN', 'OTP_ITAN', 'PHOTO_TAN', 'I_TAN', 'ACCEPT'));

delete from MeansProcessStatuses where meansProcessStatusType = 'HUB_AUTHENTICATION_MEAN_AVAILABLE';

delete from AuthentMeans where name in ('OTP_PHOTOTAN', 'OTP_ITAN','PHOTO_TAN', 'I_TAN', 'ACCEPT');
  
delete from Image where name in ('Comdirect_Logo');


commit;