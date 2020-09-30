USE U7G_ACS_BO;

SET @customItemSetCSTA = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_CS_MOBILE_APP');
SET @customItemSetCSSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_CS_SMS');
SET @customItemSetNABTA = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_NAB_MOBILE_APP');
SET @customItemSetNABSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_NAB_SMS');
SET @customItemSetSGKBTA = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SGKB_MOBILE_APP');
SET @customItemSetSGKBSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SGKB_SMS');
SET @customItemSetSOBATA = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SOBA_MOBILE_APP');
SET @customItemSetSOBASMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SOBA_SMS');
SET @customItemSetLUKBTA = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LUKB_MOBILE_APP');
SET @customItemSetLUKBSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LUKB_SMS');
SET @customItemSetBALITA = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_BALI_MOBILE_APP');
SET @customItemSetBALISMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_BALI_SMS');
SET @customItemSetBEKBTA = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_BEKB_MOBILE_APP');
SET @customItemSetBEKBSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_BEKB_SMS');
SET @customItemSetGRKBTA = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_GRKB_MOBILE_APP');
SET @customItemSetGRKBSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_GRKB_SMS');
SET @customItemSetLLBTA = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LLB_MOBILE_APP');
SET @customItemSetLLBSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LLB_SMS');
SET @customItemSetTGKBTA = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_TGKB_MOBILE_APP');
SET @customItemSetTGKBSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_TGKB_SMS');

UPDATE `CustomItem` ci SET ci.`value` = replace(ci.value,  '@maskedPan', '@displayedPan')
WHERE `fk_id_customItemSet` in (@customItemSetCSTA,
                               @customItemSetCSSMS,
                               @customItemSetNABTA,
                               @customItemSetNABSMS,
                               @customItemSetSGKBTA,
                               @customItemSetSGKBSMS,
                               @customItemSetSOBATA,
                               @customItemSetSOBASMS,
                               @customItemSetLUKBTA,
                               @customItemSetLUKBSMS,
                               @customItemSetBALITA,
                               @customItemSetBALISMS,
                               @customItemSetBEKBTA,
                               @customItemSetBEKBSMS,
                               @customItemSetGRKBTA,
                               @customItemSetGRKBSMS,
                               @customItemSetLLBTA,
                               @customItemSetLLBSMS,
                               @customItemSetTGKBTA,
                               @customItemSetTGKBSMS
                               )
AND `ordinal` = 152
AND `pageTypes` = 'APP_VIEW';