
USE `U5G_ACS_BO`;

SET @currentPageType = 'REFUSAL_PAGE';
SET @customItemSetTERefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_','SPB_sharedBIN','_TE_REFUSAL'));
SET @customItemSetFERefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_','SPB_sharedBIN','_FE_REFUSAL'));

UPDATE CustomItem SET VALUE = 'Eine Freigabe der Zahlung ist nicht möglich.' WHERE pageTypes = @currentPageType AND fk_id_customItemSet in (@customItemSetTERefusal,@customItemSetFERefusal) AND ordinal = 22 and DTYPE='T';

UPDATE CustomItem SET VALUE = 'Bitte wenden Sie sich an die kontoführende Filiale Ihrer Sparda-Bank.' WHERE pageTypes = @currentPageType AND fk_id_customItemSet in (@customItemSetTERefusal,@customItemSetFERefusal) AND ordinal = 23 and DTYPE='T';