use U7G_ACS_BO;

SET @subIssuerCode = 23000;

SET @subIssuerId = (SELECT id FROM SubIssuer WHERE code = @subIssuerCode);

SET @customItemSetName = 'customitemset_UBS_SMS';

SET @customItemSetId = (SELECT id FROM CustomItemSet where name = @customItemSetName AND fk_id_subIssuer = @subIssuerId);

UPDATE CustomItem SET value = 'N° de portable' WHERE fk_id_customItemSet = @customItemSetId AND ordinal = 104 AND locale = 'fr';