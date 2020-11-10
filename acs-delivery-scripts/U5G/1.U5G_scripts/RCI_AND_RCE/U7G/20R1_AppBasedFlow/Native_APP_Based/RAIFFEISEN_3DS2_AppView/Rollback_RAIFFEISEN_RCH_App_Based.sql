USE `U7G_ACS_BO`;

start transaction;

set foreign_key_checks = 0;

SET @BankRCH = 'RCH';
SET @Banklb_RCH = LOWER(@BankRCH);

SET @pageType = 'APP_VIEW';
set @customItemsIds = (select group_concat(id)
                       from `CustomItemSet`
                       where name in (CONCAT('customitemset_', @BankRCH, '_MOBILE_APP'),
                                      CONCAT('customitemset_', @BankB, '_MOBILE_APP_EXT'),
                                      CONCAT('customitemset_', @BankRCH, '_SMS')
                           ));

set @imageIds = (select group_concat(id)
                 from `Image`
                 where name in (CONCAT(@Banklb_RCH, '_small.png'),
                                CONCAT(@Banklb_RCH, '_medium.png'),
                                CONCAT(@Banklb_RCH, '_large.png')
                     ));
delete from Image where find_in_set(id, @imageIds);
delete from CustomItem where pageTypes = @pageType and find_in_set(fk_id_customItemSet, @customItemsIds);

set foreign_key_checks = 1;

commit;