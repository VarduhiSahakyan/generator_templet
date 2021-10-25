USE U5G_ACS_BO;

SET @createdBy = 'A757435';

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_DEFAULT_REFUSAL');
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_12000_REISEBANK_DEFAULT_REFUSAL');
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_DEFAULT_REFUSAL');

SET @customItemSetREFUSAL_LBBW = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_DEFAULT_REFUSAL');
SET @customItemSetREFUSAL_Reisebank = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_12000_REISEBANK_DEFAULT_REFUSAL');
SET @customItemSetREFUSAL_SPB = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_DEFAULT_REFUSAL');


DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` IN (@customItemSetREFUSAL_LBBW,
                                                         @customItemSetREFUSAL_Reisebank,
                                                         @customItemSetREFUSAL_SPB) AND
        `ordinal` IN (1000, 1001, 1002);

