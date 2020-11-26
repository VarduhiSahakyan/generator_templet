USE `U7G_ACS_BO`;

start transaction;

set foreign_key_checks = 0;

SET @BankBALI = 'BALI';
SET @Banklb_BALI = LOWER(@BankBALI);


SET @pageType = 'APP_VIEW';
set @customItemsIds = (select group_concat(id)
                 from `CustomItemSet`
                 where name in (
                                CONCAT('customitemset_', @BankBALI, '_SMS')
                               ));

set @imageIds = (select group_concat(id)
                 from `Image`
                 where name in (CONCAT(@Banklb_BALI, '_small.png'),
                                CONCAT(@Banklb_BALI, '_medium.png'),
                                CONCAT(@Banklb_BALI, '_large.png')
                               ));
delete from Image where find_in_set(id, @imageIds);
delete from CustomItem where pageTypes = @pageType and find_in_set(fk_id_customItemSet, @customItemsIds);

set foreign_key_checks = 1;

commit;