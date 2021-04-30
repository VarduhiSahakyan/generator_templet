USE `U5G_ACS_BO`;


SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_SPB_sharedBIN_SMS_APP');

UPDATE `CustomItem` SET VALUE = 'Schritt 2: Freigabe per SpardaSecureApp' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 151 and pageTypes = 'APP_VIEW_MEAN_SELECT' and DTYPE ='T';