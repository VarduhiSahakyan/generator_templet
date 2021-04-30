USE `U7G_ACS_BO`;

SET @BankB = 'TGKB';
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_SMS'));

SET @pageType = 'APP_VIEW';
SET @networkMC = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');

UPDATE CustomItem SET name = 'Mastercard Logo', value = 'MC_SMALL_LOGO', fk_id_network = @networkMC
    WHERE fk_id_customItemSet = @customItemSetId AND ordinal = 254 AND pageTypes = @pageType;

UPDATE CustomItem SET name = 'Mastercard Logo', value = 'MC_MEDIUM_LOGO', fk_id_network = @networkMC
    WHERE fk_id_customItemSet = @customItemSetId AND ordinal = 255 AND pageTypes = @pageType;

UPDATE CustomItem SET name = 'Mastercard Logo', value = 'MC_LARGE_LOGO', fk_id_network = @networkMC
    WHERE fk_id_customItemSet = @customItemSetId AND ordinal = 256 AND pageTypes = @pageType;
