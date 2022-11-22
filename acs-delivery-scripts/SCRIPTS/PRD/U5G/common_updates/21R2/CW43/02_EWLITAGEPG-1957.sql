
USE `U5G_ACS_BO`;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT ci.DTYPE, ci.createdBy, ci.creationDate, ci.description, ci.lastUpdateBy, ci.lastUpdateDate, ci.name, ci.updateState, ci.locale, ci.ordinal, 'MESSAGE_BODY_NPA', ci.value, ci.fk_id_network, ci.fk_id_image, ci.fk_id_customItemSet FROM `CustomItem` ci WHERE ci.ordinal=0 AND ci.pageTypes='MESSAGE_BODY';

