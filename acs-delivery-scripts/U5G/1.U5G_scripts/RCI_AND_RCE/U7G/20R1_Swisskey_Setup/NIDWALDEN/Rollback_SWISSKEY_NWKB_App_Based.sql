USE `U7G_ACS_BO`;

set foreign_key_checks = 0;

set @BankB = 'SWISSKEY';
set @pageType = 'APP_VIEW';
set @customItemsIds = (select group_concat(id)
                 from `CustomItemSet`
                 where name in (CONCAT('customitemset_', @BankB, '_MOBILE_APP'),
                                CONCAT('customitemset_', @BankB, '_SMS')
                               ));

set @BankB = 'NIDWALDEN';
set @Banklb = LOWER(@BankB);
set @imageIds = (select group_concat(id)
                 from `Image`
                 where name in (CONCAT(@Banklb, '_small.png'),
                                CONCAT(@Banklb, '_medium.png'),
                                CONCAT(@Banklb, '_large.png')
                               ));
delete from Image where find_in_set(id, @imageIds);
delete from CustomItem where pageTypes = @pageType and find_in_set(fk_id_customItemSet, @customItemsIds)
                                                    and value in (CONCAT(@BankB, '_SMALL_LOGO'),
                                                                  CONCAT(@BankB, '_MEDIUM_LOGO'),
                                                                  CONCAT(@BankB, '_LARGE_LOGO'));

set foreign_key_checks = 1;