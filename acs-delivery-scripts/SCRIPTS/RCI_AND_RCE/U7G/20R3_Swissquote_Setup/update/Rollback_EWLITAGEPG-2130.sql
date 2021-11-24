USE U7G_ACS_BO;

SET @createdBy = 'A758582';

SET @customItemSetREFUSAL_SQB = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SQB_MISSING_AUTHENTICATION_REFUSAL');

DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` = @customItemSetREFUSAL_SQB AND
                                            `ordinal` IN (1000, 1001, 1002);