USE U5G_ACS_BO;

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_PASSWORD');
SET @pageTypeHelp = 'HELP_PAGE';

SET @textValue = '<I>Sie können sich auf der Internetseite www.commerzbank.de/sicher-einkaufen unter „Jetzt registrieren“ das dafür erforderliche Einmal-Passwort bei uns anfordern.</I> ';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @pageTypeHelp
AND fk_id_customItemSet = @customItemSetPassword;