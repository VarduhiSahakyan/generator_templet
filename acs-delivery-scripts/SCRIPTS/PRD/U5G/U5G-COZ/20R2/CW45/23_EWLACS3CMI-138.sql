
USE `U5G_ACS_BO`;

SET @subIssuerId  = (SELECT `id` FROM `SubIssuer` WHERE `code` = '19440');

SET @profileId = (SELECT `id` FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuerId AND `name` = 'COZ_PASSWORD_01');

UPDATE `Profile` SET `dataEntryFormat` = '45:(:ALPHA_MAJ:1)&(:ALPHA_MIN:1)&(:DIGIT:1)' where `id` = @profileId;
