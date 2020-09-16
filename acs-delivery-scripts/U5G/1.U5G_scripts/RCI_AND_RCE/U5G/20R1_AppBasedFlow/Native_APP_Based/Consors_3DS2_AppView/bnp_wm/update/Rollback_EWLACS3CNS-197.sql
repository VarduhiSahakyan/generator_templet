USE `U5G_ACS_BO`;

SET @locale = 'de';
SET @username = 'A758582';
SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_BNP_WM_MOBILE_APP_EXT');
SET @pageType = 'APP_VIEW';

SET @ordinal = 156;
SET @text = 'Hilfe';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes` = @pageType
					AND `fk_id_customItemSet` = @customItemSetId;
