USE `U5G_ACS_BO`;

SET @customItemSetPSWD ='customitemset_SPB_sharedBIN_PASSWORD';

SET @customItemSetPSWDId = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetPSWD);

UPDATE `U5G_ACS_BO`.`CustomItem` SET `value`= 'Bitte geben Sie Ihre PIN für das SpardaOnline-Banking zur dargestellten Kundenummer ein, um den Bezahlvorgang zu bestätigen.' WHERE fk_id_customItemSet IN (@customItemSetPSWDId) AND pageTypes = 'APP_VIEW' AND ordinal = 152;