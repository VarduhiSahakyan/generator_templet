USE `U7G_ACS_BO`;

set foreign_key_checks = 0;

set @BankB = 'BEKB';
set @Banklb = LOWER(@BankB);

set @pageType = 'APP_VIEW';
set @customItemsIds = (select group_concat(id)
                 from `CustomItemSet`
                 where name in (CONCAT('customitemset_', @BankB, '_MOBILE_APP'),
                                CONCAT('customitemset_', @BankB, '_SMS')
                               ));

set @imageIds = (select group_concat(id)
                 from `Image`
                 where name in (CONCAT(@Banklb, '_small.png'),
                                CONCAT(@Banklb, '_medium.png'),
                                CONCAT(@Banklb, '_large.png')
                               ));
delete from Image where find_in_set(id, @imageIds);
delete from CustomItem where pageTypes = @pageType and find_in_set(fk_id_customItemSet, @customItemsIds);

set foreign_key_checks = 1;