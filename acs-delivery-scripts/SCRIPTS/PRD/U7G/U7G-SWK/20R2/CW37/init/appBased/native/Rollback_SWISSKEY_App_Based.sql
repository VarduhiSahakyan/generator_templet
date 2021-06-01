USE `U7G_ACS_BO`;

start transaction;

set foreign_key_checks = 0;

SET @BankCS = 'CS';
SET @BankNAB = 'NAB';
SET @BankSGKB = 'SGKB';
SET @Banklb_CS = LOWER(@BankCS);
SET @Banklb_NAB = LOWER(@BankNAB);
SET @Banklb_SGKB = LOWER(@BankSGKB);


SET @pageType = 'APP_VIEW';
set @customItemsIds = (select group_concat(id)
                 from `CustomItemSet`
                 where name in (CONCAT('customitemset_', @BankCS, '_MOBILE_APP'),
                                CONCAT('customitemset_', @BankCS, '_SMS'),
                                CONCAT('customitemset_', @BankNAB, '_MOBILE_APP'),
                                CONCAT('customitemset_', @BankNAB, '_SMS'),
                                CONCAT('customitemset_', @BankSGKB, '_MOBILE_APP'),
                                CONCAT('customitemset_', @BankSGKB, '_SMS')
                               ));

set @imageIds = (select group_concat(id)
                 from `Image`
                 where name in (CONCAT(@Banklb_CS, '_small.png'),
                                CONCAT(@Banklb_CS, '_medium.png'),
                                CONCAT(@Banklb_CS, '_large.png'),
                                CONCAT(@Banklb_NAB, '_small.png'),
                                CONCAT(@Banklb_NAB, '_medium.png'),
                                CONCAT(@Banklb_NAB, '_large.png'),
                                CONCAT(@Banklb_SGKB, '_small.png'),
                                CONCAT(@Banklb_SGKB, '_medium.png'),
                                CONCAT(@Banklb_SGKB, '_large.png')
                               ));
delete from Image where find_in_set(id, @imageIds);
delete from CustomItem where pageTypes = @pageType and find_in_set(fk_id_customItemSet, @customItemsIds);

set foreign_key_checks = 1;

commit;