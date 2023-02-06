USE U5G_ACS_BO;

SET @authentMeanRefusal = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'REFUSAL');

UPDATE `Profile` SET `fk_id_AuthentMeans` = @authentMeanRefusal WHERE `name` = '18500_PB_Shared_DEFAULT_REFUSAL';