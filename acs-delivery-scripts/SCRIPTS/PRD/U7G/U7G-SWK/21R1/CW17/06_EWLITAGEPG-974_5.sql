USE `U7G_ACS_BO`;

SET @BankUB_01 = 'CS';
SET @BankUB_02 = 'NAB';
SET @BankUB_03 = 'SGKB';
SET @BankUB_04 = 'SOBA';
SET @BankUB_05 = 'LUKB';
SET @BankUB_06 = 'BALI';
SET @BankUB_07 = 'BEKB';
SET @BankUB_08 = 'GRKB';
SET @BankUB_09 = 'LLB';
SET @BankUB_10 = 'TGKB';

SET @IssuerCode = '41001';
SET @SubIssuerCodeCS = '48350';
SET @SubIssuerCodeNAB = '58810';
SET @SubIssuerCodeSGKB = '78100';
SET @SubIssuerCodeSOBA = '83340';
SET @SubIssuerCodeLUKB = '77800';
SET @SubIssuerCodeBALI = '87310';
SET @SubIssuerCodeBEKB = '79000';
SET @SubIssuerCodeGRKB = '77400';
SET @SubIssuerCodeLLB = '88000';
SET @SubIssuerCodeTGKB = '78400';


set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_subIssuer_1 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeCS);
set @id_subIssuer_2 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeNAB);
set @id_subIssuer_3 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeSGKB);
set @id_subIssuer_4 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeSOBA);
set @id_subIssuer_5 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeLUKB);
set @id_subIssuer_6 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeBALI);
set @id_subIssuer_7 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeBEKB);
set @id_subIssuer_8 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeGRKB);
set @id_subIssuer_9 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeLLB);
set @id_subIssuer_10 = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeTGKB);

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

SET @NetworkMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @NetworkVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');

SET FOREIGN_KEY_CHECKS = 0;

-- delete from CustomItem
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
                                                                                         (@id_profile_set_1,
                                                                                          @id_profile_set_2,
                                                                                          @id_profile_set_3,
                                                                                          @id_profile_set_4,
                                                                                          @id_profile_set_5,
                                                                                          @id_profile_set_6,
                                                                                          @id_profile_set_7,
                                                                                          @id_profile_set_8,
                                                                                          @id_profile_set_9,
                                                                                          @id_profile_set_10
                                                                                         )
                                                                                     and (ci.fk_id_network is NULL or ci.fk_id_network IN (@NetworkMID, @NetworkVID))
                                                                                  ) as temp);

-- delete the profile set / custompage layout mapping

delete from CustomPageLayout_ProfileSet where PROFILESET_ID in
                                              (@id_profile_set_1,
                                               @id_profile_set_2,
                                               @id_profile_set_3,
                                               @id_profile_set_4,
                                               @id_profile_set_5,
                                               @id_profile_set_6,
                                               @id_profile_set_7,
                                               @id_profile_set_8,
                                               @id_profile_set_9,
                                               @id_profile_set_10
                                              );


-- delete profiles for sub issuer
set @id_customitemsets = (select group_concat(cis.id) from CustomItemSet cis,
                                                           Profile p,
                                                           Rule r ,
                                                           ProfileSet_Rule pr
                          where  p.FK_ID_CUSTOMITEMSETCURRENT = cis.id
                            and r.FK_ID_PROFILE = p.ID
                            and pr.ID_RULE = r.ID
                            and pr.ID_PROFILESET in
                                (@id_profile_set_1,
                                 @id_profile_set_2,
                                 @id_profile_set_3,
                                 @id_profile_set_4,
                                 @id_profile_set_5,
                                 @id_profile_set_6,
                                 @id_profile_set_7,
                                 @id_profile_set_8,
                                 @id_profile_set_9,
                                 @id_profile_set_10
                                ));

update Profile p set p.FK_ID_CUSTOMITEMSETCURRENT = null where find_in_set(FK_ID_CUSTOMITEMSETCURRENT, @id_customitemsets);
delete from CustomItemSet where find_in_set(id, @id_customitemsets);
delete from CustomItemSet where name like CONCAT('customitemset_', @BankUB_01, '%')
                                    AND CONCAT('customitemset_', @BankUB_02, '%')
                                    AND CONCAT('customitemset_', @BankUB_03, '%')
                                    AND CONCAT('customitemset_', @BankUB_04, '%')
                                    AND CONCAT('customitemset_', @BankUB_05, '%')
                                    AND CONCAT('customitemset_', @BankUB_06, '%')
                                    AND CONCAT('customitemset_', @BankUB_07, '%')
                                    AND CONCAT('customitemset_', @BankUB_08, '%')
                                    AND CONCAT('customitemset_', @BankUB_09, '%')
                                    AND CONCAT('customitemset_', @BankUB_10, '%');

set @id_profile = (select group_concat(p.id) from Profile p,
                                                  Rule r ,
                                                  ProfileSet_Rule pr
                   where  r.FK_ID_PROFILE = p.ID
                     and pr.ID_RULE = r.ID
                     and pr.ID_PROFILESET in
                         (@id_profile_set_1,
                          @id_profile_set_2,
                          @id_profile_set_3,
                          @id_profile_set_4,
                          @id_profile_set_5,
                          @id_profile_set_6,
                          @id_profile_set_7,
                          @id_profile_set_8,
                          @id_profile_set_9,
                          @id_profile_set_10
                         ));

set @id_rule = (select group_concat(r.id) from Rule r ,
                                               ProfileSet_Rule pr
                where  pr.ID_RULE = r.ID
                  and pr.ID_PROFILESET in
                      (@id_profile_set_1,
                       @id_profile_set_2,
                       @id_profile_set_3,
                       @id_profile_set_4,
                       @id_profile_set_5,
                       @id_profile_set_6,
                       @id_profile_set_7,
                       @id_profile_set_8,
                       @id_profile_set_9,
                       @id_profile_set_10
                      ));

-- delete conditions
SELECT r.id from Rule r, ProfileSet_Rule pr
where pr.ID_RULE = r.id and pr.ID_PROFILESET in
                            (@id_profile_set_1,
                             @id_profile_set_2,
                             @id_profile_set_3,
                             @id_profile_set_4,
                             @id_profile_set_5,
                             @id_profile_set_6,
                             @id_profile_set_7,
                             @id_profile_set_8,
                             @id_profile_set_9,
                             @id_profile_set_10
                            );


SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                     (@id_profile_set_1,
                                                      @id_profile_set_2,
                                                      @id_profile_set_3,
                                                      @id_profile_set_4,
                                                      @id_profile_set_5,
                                                      @id_profile_set_6,
                                                      @id_profile_set_7,
                                                      @id_profile_set_8,
                                                      @id_profile_set_9,
                                                      @id_profile_set_10
                                                     );

delete from Condition_TransactionStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@id_profile_set_1,
                                                                             @id_profile_set_2,
                                                                             @id_profile_set_3,
                                                                             @id_profile_set_4,
                                                                             @id_profile_set_5,
                                                                             @id_profile_set_6,
                                                                             @id_profile_set_7,
                                                                             @id_profile_set_8,
                                                                             @id_profile_set_9,
                                                                             @id_profile_set_10
                                                                            ));

delete from Condition_MeansProcessStatuses
where ID_CONDITION in (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                            (@id_profile_set_1,
                                                                             @id_profile_set_2,
                                                                             @id_profile_set_3,
                                                                             @id_profile_set_4,
                                                                             @id_profile_set_5,
                                                                             @id_profile_set_6,
                                                                             @id_profile_set_7,
                                                                             @id_profile_set_8,
                                                                             @id_profile_set_9,
                                                                             @id_profile_set_10
                                                                            ));

delete from RuleCondition where ID in (SELECT id from (SELECT rc.id from RuleCondition rc, Rule r, ProfileSet_Rule pr
                                                       where rc.FK_ID_RULE = r.id and pr.ID_RULE = r.id and pr.ID_PROFILESET in
                                                                                                            (@id_profile_set_1,
                                                                                                             @id_profile_set_2,
                                                                                                             @id_profile_set_3,
                                                                                                             @id_profile_set_4,
                                                                                                             @id_profile_set_5,
                                                                                                             @id_profile_set_6,
                                                                                                             @id_profile_set_7,
                                                                                                             @id_profile_set_8,
                                                                                                             @id_profile_set_9,
                                                                                                             @id_profile_set_10
                                                                                                            )) as temp);



delete from Profile where find_in_set(id, @id_profile);

-- Delete from ProfileSet_Rule
set @id_rule = (select group_concat(r.id) from Rule r , ProfileSet_Rule pr
                where  pr.ID_RULE = r.ID
                  and pr.ID_PROFILESET in
                      (@id_profile_set_1,
                       @id_profile_set_2,
                       @id_profile_set_3,
                       @id_profile_set_4,
                       @id_profile_set_5,
                       @id_profile_set_6,
                       @id_profile_set_7,
                       @id_profile_set_8,
                       @id_profile_set_9,
                       @id_profile_set_10
                      ));

delete from ProfileSet_Rule where ID_PROFILESET in (@id_profile_set_1,
                                    @id_profile_set_2,
                                    @id_profile_set_3,
                                    @id_profile_set_4,
                                    @id_profile_set_5,
                                    @id_profile_set_6,
                                    @id_profile_set_7,
                                    @id_profile_set_8,
                                    @id_profile_set_9,
                                    @id_profile_set_10
                                                   );
delete from Rule where find_in_set(id, @id_rule);

-- Delete from ProfileSet
delete from ProfileSet where id in (@id_profile_set_1,
                                    @id_profile_set_2,
                                    @id_profile_set_3,
                                    @id_profile_set_4,
                                    @id_profile_set_5,
                                    @id_profile_set_6,
                                    @id_profile_set_7,
                                    @id_profile_set_8,
                                    @id_profile_set_9,
                                    @id_profile_set_10
                                   );

SET FOREIGN_KEY_CHECKS = 1;
