USE `U5G_ACS_BO`;

START TRANSACTION;
-- SET FOREIGN_KEY_CHECKS = 0;
-- 1. delete from
SET @issuerCode = '16950';
SET @sharedSubIssuerCode = '16950';

SET @BankB_Shared = 'SPB_sharedBIN';

set @idIssuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @idSharedSubIssuer = (SELECT ID from SubIssuer where code = @sharedSubIssuerCode);

set @idsOtherSubissuers = (SELECT group_concat(distinct(id)) FROM SubIssuer where name like 'SBK_%' or name like 'SPD_%');
set @idSharedProfileSet = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @idSharedSubIssuer);
set @idOtherProfileSets = (SELECT group_concat(distinct(id)) FROM ProfileSet WHERE name like 'PS\_SBK\_%' OR name like 'PS\_SPB\_%');

set @idRules = (SELECT group_concat(distinct(r.id)) FROM Rule r INNER JOIN ProfileSet_Rule psr ON r.id = psr.id_rule INNER JOIN ProfileSet ps ON ps.id = psr.id_profileSet
                WHERE ps.id = @idSharedProfileSet OR find_in_set(ps.id, @idOtherProfileSets));

set @idCryptoConfigs = (SELECT group_concat(distinct(cc.id)) FROM CryptoConfig cc INNER JOIN SubIssuer si on cc.id = si.fk_id_cryptoConfig
                            where (si.id = @idSharedSubIssuer) OR (find_in_set(si.id, @idsOtherSubissuers)));

SELECT @idSharedSubIssuer, @idSharedProfileSet, @idRules;

-- delete the profile set / custompage layout mapping
delete from CustomPageLayout_ProfileSet where profileset_id in
                                              (@idSharedProfileSet) OR find_in_set( profileSet_id, @idOtherProfileSets);

-- delete all the custom components
DELETE FROM CustomComponent WHERE fk_id_layout IN (SELECT id FROM CustomPageLayout WHERE description LIKE '%Spardabank%');
DELETE FROM CustomPageLayout WHERE description LIKE '%Spardabank%';

-- delete profiles for sub issuer

set @id_customitemsets = (select group_concat(distinct(cis.id)) FROM
                              CustomItemSet cis INNER JOIN Profile p ON p.fk_id_customItemSetCurrent = cis.id
                              INNER JOIN Rule r ON p.id = r.fk_id_profile
                              INNER JOIN ProfileSet_Rule psr ON psr.id_rule = r.id
                              INNER JOIN ProfileSet ps ON ps.id = psr.id_profileSet
                          where FIND_IN_SET(ps.id ,@idSharedProfileSet) OR find_in_set( ps.id, @idOtherProfileSets));

update Profile p set p.FK_ID_CUSTOMITEMSETCURRENT = null where find_in_set(FK_ID_CUSTOMITEMSETCURRENT, @id_customitemsets) OR
                                                               fk_id_customItemSetCurrent IN (SELECT id FROM CustomItemSet WHERE name like 'customitemset_SBK%' or name like 'customitemset_SPB%');

DELETE FROM CustomItem where find_in_set(fk_id_customItemSet, @id_customitemsets);
DELETE FROM CustomItem WHERE fk_id_customItemSet IN (SELECT id FROM CustomItemSet cis where name like 'customitemset_SBK%' or name like 'customitemset_SPB%');

DELETE FROM CustomItem WHERE fk_id_customItemSet IS NULL;

delete from CustomItemSet where find_in_set(id, @id_customitemsets);
delete from CustomItemSet WHERE name like 'customitemset_SBK%' or name like 'customitemset_SPB%';
set @id_profiles = (select group_concat(distinct(p.id)) from Profile p,
                                                  Rule r ,
                                                  ProfileSet_Rule pr
                          where  r.FK_ID_PROFILE = p.ID
                                 and pr.ID_RULE = r.ID
                                 and (pr.ID_PROFILESET in
                                     (@idSharedProfileSet) OR find_in_set(pr.id_profileSet, @idOtherProfileSets)));
SELECT @id_profiles;

-- delete conditions
SET @idRules = (SELECT group_concat(distinct(r.id)) from Rule r, ProfileSet_Rule pr
                       where pr.ID_RULE = r.id and (pr.ID_PROFILESET in
                                                   (@idSharedProfileSet) OR find_in_set(pr.id_profileSet, @idOtherProfileSets)));


SET @idConditions = (SELECT group_concat(distinct(rc.id)) from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and find_in_set(r.id, @idRules));

delete from Condition_TransactionStatuses
where find_in_set(ID_CONDITION, @idConditions) ;

delete from Condition_MeansProcessStatuses
where find_in_set(ID_CONDITION, @idConditions);

delete from Thresholds where find_in_set (fk_id_condition, @idConditions);

delete from TransactionValue where find_in_set (fk_id_condition, @idConditions);

delete from RuleCondition where find_in_set(ID, @idConditions);

-- update Rule set FK_ID_PROFILE = NULL where find_in_set(FK_ID_PROFILE, @id_profile);
delete from ProfileSet_Rule where ID_PROFILESET in
                                  (@idSharedProfileSet) OR find_in_set(id_profileSet, @idOtherProfileSets);

DELETE FROM Rule WHERE find_in_set(id, @idRules);

delete from Profile where find_in_set(id, @id_profiles) OR name like 'SPB_sharedBIN%';

-- update Profileset_Rule set ID_RULE = null where find_in_set(ID_RULE, @id_rule);


delete from BinRange_SubIssuer where find_in_set(id_subIssuer, @idSharedSubIssuer);
delete from BinRange_SubIssuer where find_in_set(id_subIssuer, @idsOtherSubissuers);

delete from BinRange where fk_id_profileSet = @idSharedProfileSet OR find_in_set(fk_id_profileSet, @idOtherProfileSets);

delete from ProfileSet where id = @idSharedProfileSet OR find_in_set(id, @idOtherProfileSets) ;
delete from MerchantPivotList where FK_ID_ISSUER = @idIssuer;

-- delete subissuer and issuer

delete from SubIssuerCrypto where FK_ID_SUBISSUER in  (@idSharedSubIssuer);
delete from SubIssuerCrypto where find_in_set(FK_ID_SUBISSUER, @idsOtherSubissuers);

delete from SubIssuerNetworkCrypto where fk_id_subIssuer = @idSharedSubIssuer;
delete from SubIssuerNetworkCrypto where find_in_set(fk_id_subIssuer, @idsOtherSubissuers);

delete from Network_SubIssuer where find_in_set(id_subIssuer, @idSharedSubIssuer);
delete from Network_SubIssuer where find_in_set(id_subIssuer, @idsOtherSubissuers);


delete from BinRange where find_in_set(fk_id_cryptoConfig, @idCryptoConfigs);

delete from SubIssuer where ID in (@idSharedSubIssuer);
delete from SubIssuer where find_in_set(id, @idsOtherSubissuers);

DELETE FROM CryptoConfig WHERE find_in_set(id, @idCryptoConfigs);
DELETE FROM CryptoConfig WHERE description = 'Sparda CryptoConfig';

delete from Issuer where ID = @idIssuer;

delete from Image where name in
                        (@BankB_Shared);

COMMIT;