USE `U5G_ACS_BO`;


SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18501_PB_MOBILE_APP');

UPDATE `CustomItem` SET VALUE = '' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 160 and pageTypes = 'APP_VIEW' and DTYPE ='T';


SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18501_PB_MOBILE_APP_Choice');

UPDATE `CustomItem` SET VALUE = '' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 160 and pageTypes = 'APP_VIEW' and DTYPE ='T';

