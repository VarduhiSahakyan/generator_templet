USE U7G_ACS_BO;

SET @customItemSetLLBPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LLB_PASSWORD');

UPDATE `CustomItem` ci SET ci.`value` = replace(ci.value,  '@maskedPan', '@displayedPan')
WHERE `fk_id_customItemSet` in (@customItemSetLLBPassword)
  AND `ordinal` = 152
  AND `pageTypes` = 'APP_VIEW';