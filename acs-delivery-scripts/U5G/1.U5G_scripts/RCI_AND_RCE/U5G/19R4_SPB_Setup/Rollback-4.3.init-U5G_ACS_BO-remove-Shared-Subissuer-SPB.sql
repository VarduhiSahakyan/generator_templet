USE `U5G_ACS_BO`;

START TRANSACTION;
-- SET FOREIGN_KEY_CHECKS = 0;
-- 1. delete from
SET @issuerCode = '16950';
SET @sharedSubIssuerCode = '16950';

SET @BankB_Shared = 'SPB_sharedBIN';

set @idIssuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @idSharedSubIssuer = (SELECT ID from SubIssuer where code = @sharedSubIssuerCode);

set @idsOtherSubissuers = (SELECT group_concat(id) FROM SubIssuer where name like 'SBK_%');
set @idSharedProfileSet = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @idSharedSubIssuer);

set @idRules = (SELECT group_concat(r.id) FROM Rule r INNER JOIN ProfileSet_Rule psr ON r.id = psr.id_rule INNER JOIN ProfileSet ps ON ps.id = psr.id_profileSet
                WHERE ps.id = @idSharedProfileSet);

set @idCryptoConfigs = (SELECT group_concat(cc.id) FROM CryptoConfig cc INNER JOIN SubIssuer si on cc.id = si.fk_id_cryptoConfig
                            where (si.id = @idSharedSubIssuer) OR (find_in_set(si.id, @idsOtherSubissuers)));

SELECT @idSharedSubIssuer, @idSharedProfileSet, @idRules;

-- delete the profile set / custompage layout mapping
delete from CustomPageLayout_ProfileSet where PROFILESET_ID in
                                              (@idSharedProfileSet);

-- delete all the custom components
DELETE FROM CustomComponent WHERE fk_id_layout IN (SELECT id FROM CustomPageLayout WHERE description LIKE '%Spardabank%');
DELETE FROM CustomPageLayout WHERE description LIKE '%Spardabank%';

-- delete profiles for sub issuer

set @id_customitemsets = (select group_concat(cis.id) from CustomItemSet cis,
                                                           Profile p,
                                                           Rule r ,
                                                           ProfileSet_Rule pr
                          where  (p.FK_ID_CUSTOMITEMSETCURRENT = cis.id
                                    and r.FK_ID_PROFILE = p.ID
                                 and pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET in
                                     (@idSharedProfileSet)) OR
                         (p.name like 'SPB_sharedBIN%' AND p.id = r.fk_id_profile AND p.fk_id_customItemSetCurrent = cis.id));

update Profile p set p.FK_ID_CUSTOMITEMSETCURRENT = null where find_in_set(FK_ID_CUSTOMITEMSETCURRENT, @id_customitemsets);

SELECT @id_customitemsets;
DELETE FROM CustomItem where fk_id_customItemSet in (SELECT id FROM CustomItemSet where name like 'customitemset_SPB_sharedBIN%');

DELETE FROM CustomItem WHERE find_in_set(fk_id_customItemSet, @id_customitemsets);

delete from CustomItemSet where find_in_set(id, @id_customitemsets);
delete from CustomItemSet where name like CONCAT('customitemset_', @BankB_Shared, '%');

set @id_profile = (select group_concat(p.id) from Profile p,
                                                  Rule r ,
                                                  ProfileSet_Rule pr
                          where  r.FK_ID_PROFILE = p.ID
                                 and pr.ID_RULE = r.ID
                                 and pr.ID_PROFILESET in
                                     (@idSharedProfileSet));
-- delete conditions
SELECT r.id from Rule r, ProfileSet_Rule pr
                       where pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                   (@idSharedProfileSet);


SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@idSharedProfileSet);

delete from Condition_TransactionStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@idSharedProfileSet));

delete from Condition_MeansProcessStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@idSharedProfileSet));

delete from RuleCondition where ID in (SELECT id from (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@idSharedProfileSet)) as temp);


-- update Rule set FK_ID_PROFILE = NULL where find_in_set(FK_ID_PROFILE, @id_profile);
delete from ProfileSet_Rule where ID_PROFILESET in
                                  (@idSharedProfileSet);

DELETE FROM Rule WHERE find_in_set(id, @idRules);

delete from Profile where find_in_set(id, @id_profile) OR name like 'SPB_sharedBIN%';

-- update Profileset_Rule set ID_RULE = null where find_in_set(ID_RULE, @id_rule);

delete from BinRange where fk_id_profileSet = @idSharedProfileSet;

delete from ProfileSet where id in (@idSharedProfileSet);
delete from MerchantPivotList where FK_ID_ISSUER = @idIssuer;

-- delete subissuer and issuer

delete from SubIssuerCrypto where FK_ID_SUBISSUER in
                                  (@idSharedSubIssuer);
delete from SubIssuerCrypto where find_in_set(FK_ID_SUBISSUER, @idsOtherSubissuers);

delete from SubIssuerNetworkCrypto where fk_id_subIssuer = @idSharedSubIssuer;
delete from SubIssuerNetworkCrypto where find_in_set(fk_id_subIssuer, @idsOtherSubissuers);

delete from Network_SubIssuer where find_in_set(id_subIssuer, @idSharedSubIssuer);
delete from Network_SubIssuer where find_in_set(id_subIssuer, @idsOtherSubissuers);

delete from BinRange_SubIssuer where find_in_set(id_subIssuer, @idSharedSubIssuer);
delete from BinRange_SubIssuer where find_in_set(id_subIssuer, @idsOtherSubissuers);


delete from BinRange where find_in_set(fk_id_cryptoConfig, @idCryptoConfigs);

delete from SubIssuer where ID in (@idSharedSubIssuer);
delete from SubIssuer where find_in_set(id, @idsOtherSubissuers);

DELETE FROM CryptoConfig WHERE find_in_set(id, @idCryptoConfigs);

delete from Issuer where ID = @idIssuer;

delete from Image where name in
                        (@BankB_Shared);

COMMIT;