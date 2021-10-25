USE U5G_ACS_BO;

SET @createdBy = 'A758582';


SET @customItemSetREFUSAL_LBBW = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_MISSING_AUTHENTICATION_REFUSAL');
SET @customItemSetREFUSAL_ING = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16500_REFUSAL');
SET @customItemSetREFUSAL_PB_18501 = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18501_PB_2_REFUSAL');
SET @customItemSetREFUSAL_PB_18502 = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18502_PB_2_REFUSAL');
SET @customItemSetREFUSAL_PB_18502_3 = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18502_PB_3_REFUSAL');
SET @customItemSetREFUSAL_Reisebank = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_12000_ReiseBank_MISSING_AUTHENTICATION_REFUSAL');
SET @customItemSetREFUSAL_Consorsebank = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_1_REFUSAL');
SET @customItemSetREFUSAL_BNP_WM = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_BNP_WM_1_REFUSAL');
SET @customItemSetREFUSAL_SPB = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SPB_sharedBIN_DEFAULT_REFUSAL');


DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` IN (@customItemSetREFUSAL_LBBW,
                                                         @customItemSetREFUSAL_ING,
                                                         @customItemSetREFUSAL_PB_18501,
                                                         @customItemSetREFUSAL_PB_18502,
														 @customItemSetREFUSAL_PB_18502_3,
                                                         @customItemSetREFUSAL_Reisebank,
                                                         @customItemSetREFUSAL_Consorsebank,
                                                         @customItemSetREFUSAL_BNP_WM,
                                                         @customItemSetREFUSAL_SPB) AND
                                            `ordinal` IN (1000, 1001, 1002);

