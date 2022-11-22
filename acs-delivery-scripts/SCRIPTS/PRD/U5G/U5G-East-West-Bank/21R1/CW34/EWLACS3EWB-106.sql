USE `U5G_ACS_BO`;

SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_EWB_SMS');
SET @ordinal = 153;
SET @text = 'Recognize & approve thru password submission';

UPDATE `CustomItem` SET VALUE = @text  WHERE fk_id_customItemSet = @customItemSetId AND ordinal = @ordinal AND pageTypes = 'APP_VIEW' and DTYPE ='T';