USE `U5G_ACS_BO`;


SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_20000_MOBILE_APP_01');

UPDATE `CustomItem` SET VALUE = '' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 160 and pageTypes = 'APP_VIEW' and DTYPE ='T' and locale = 'en';



UPDATE `CustomItem` SET VALUE = '' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 160 and pageTypes = 'APP_VIEW' and DTYPE ='T' and locale = 'fi';



UPDATE `CustomItem` SET VALUE = '' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 160 and pageTypes = 'APP_VIEW' and DTYPE ='T' and locale = 'se';