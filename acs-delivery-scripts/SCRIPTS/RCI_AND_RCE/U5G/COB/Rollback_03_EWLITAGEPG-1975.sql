USE U5G_ACS_BO;

SET @createdBy = 'A758582';

SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

SET @updateState =  'PUSHED_TO_CONFIG';
SET @currentPageType = 'ALL';
SET @currentAuthentMean = 'REFUSAL';

SET @customItemSetREFUSAL_COB = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_MISSING_AUTHENT_REFUSAL');
SET @customItemSetREFUSAL_COZ = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_MISSING_AUTHENT_REFUSAL');

DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` IN (@customItemSetREFUSAL_COB, @customItemSetREFUSAL_COZ) AND
                                `ordinal` IN (1000, 1001, 1002);

