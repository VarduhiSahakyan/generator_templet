USE `U5G_ACS_BO`;

SET @customItemSetDescription = 'customitemset_16900_PHOTO_TAN_Current';
SET @customItemSetName = 'customitemset_16900_PHOTO_TAN';
SET @codeSubIssuer = '16900';

SET @idSubIssuer = (SELECT id FROM `SubIssuer` WHERE `code` = @codeSubIssuer);
SET @idAuthMeans = (SELECT id FROM `AuthentMeans` WHERE `name` = 'PHOTO_TAN');

--  11. CustomItemSet
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `name`, `updateState`, `status`, `fk_id_subIssuer`, `versionNumber`)
VALUES ('A169318', NOW(), @customItemSetDescription, @customItemSetName, 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', @idSubIssuer, 1);

SET @idCustomItemSet = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetName);

SET @profileName = '16900_PHOTO_TAN_01';
SET @profileDescription = 'Authentication by Photo Tan';

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `name`,
                       `updateState`, `maxAttempts`, dataEntryFormat, dataEntryAllowedPattern, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`)
VALUES  ('A169318', NOW(), @profileDescription, @profileName, 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '8:(:DIGIT:1)', @idAuthMeans, @idCustomItemSet, NULL, NULL, @idSubIssuer);
