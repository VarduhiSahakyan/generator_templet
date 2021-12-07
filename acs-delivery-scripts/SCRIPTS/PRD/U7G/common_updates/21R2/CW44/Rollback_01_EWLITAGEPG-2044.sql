USE U7G_ACS_BO;

SET @createdBy = 'A758582';


SET @customItemSetREFUSAL_UBS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_UBS_MISSING_AUTHENTICATION_REFUSAL');
SET @customItemSetREFUSAL_SWISSKEY = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_MISSING_AUTHENTICATION_REFUSAL');
SET @customItemSetREFUSAL_SWISSKEY_Unified = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_UNIFIED_MISSING_AUTHENTICATION_REFUSAL');
SET @customItemSetREFUSAL_RCH = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_RCH_MISSING_AUTHENTICATION_REFUSAL');
SET @customItemSetREFUSAL_ZKB = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_ZKB_MISSING_AUTHENTICATION_REFUSAL');
SET @customItemSetREFUSAL_BCV = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_BCV_MISSING_AUTHENTICATION_REFUSAL');


DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` IN (@customItemSetREFUSAL_UBS,
                                                         @customItemSetREFUSAL_SWISSKEY,
                                                         @customItemSetREFUSAL_SWISSKEY_Unified,
                                                         @customItemSetREFUSAL_RCH,
                                                         @customItemSetREFUSAL_ZKB,
                                                         @customItemSetREFUSAL_BCV) AND
                                            `ordinal` IN (1000, 1001, 1002);

