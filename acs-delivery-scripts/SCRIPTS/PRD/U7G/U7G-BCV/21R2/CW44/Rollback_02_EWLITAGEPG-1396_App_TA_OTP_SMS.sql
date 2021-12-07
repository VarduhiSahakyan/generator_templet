USE `U7G_ACS_BO`;

SET @bank = 'BCV';
SET @bankl = LOWER(@bank);

SET @pageType = 'APP_VIEW';
set @customItemsIds = (select group_concat(id)
                       from `CustomItemSet`
                       where name in (CONCAT('customitemset_', @bank, '_MOBILE_APP'),
                                      CONCAT('customitemset_', @bank, '_SMS')));

set @imageIds = (select group_concat(id)
                 from `Image`
                 where name in (CONCAT(@bankl, '_small.png'),
                                CONCAT(@bankl, '_medium.png'),
                                CONCAT(@bankl, '_large.png')
                     ));

delete from CustomItem where pageTypes = @pageType and find_in_set(fk_id_customItemSet, @customItemsIds);

-- delete from Image where find_in_set(id, @imageIds);