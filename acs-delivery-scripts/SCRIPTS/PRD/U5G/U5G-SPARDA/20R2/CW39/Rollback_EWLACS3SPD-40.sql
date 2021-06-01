
USE `U5G_ACS_BO`;

SET @currentPageType = 'REFUSAL_PAGE';
SET @customItemSetTERefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_','SPB_sharedBIN','_TE_REFUSAL'));
SET @customItemSetFERefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_','SPB_sharedBIN','_FE_REFUSAL'));

UPDATE CustomItem SET VALUE = 'Der Vorgang konnte nicht durchgeführt werden.' WHERE pageTypes = @currentPageType AND fk_id_customItemSet in (@customItemSetTERefusal,@customItemSetFERefusal) AND ordinal = 22 and DTYPE='T';

UPDATE CustomItem SET VALUE = 'Bitte aktivieren Sie Ihre Kreditkarte im Online Banking oder wenden Sie sich an den Berater in Ihrer Filiale.' WHERE pageTypes = @currentPageType AND fk_id_customItemSet in (@customItemSetTERefusal,@customItemSetFERefusal) AND ordinal = 23 and DTYPE='T';