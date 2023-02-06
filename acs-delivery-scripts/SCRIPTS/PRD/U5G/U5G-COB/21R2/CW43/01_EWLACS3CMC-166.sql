USE U5G_ACS_BO;

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_PASSWORD');
SET @pageTypeHelp = 'HELP_PAGE';

SET @textValue = '<I>Sie können sich auf der Internetseite www.commerzbank.de/sicher-einkaufen unter „Jetzt registrieren“ ein Einmal-Passwort bei uns anfordern. Mit diesem Einmal-Passwort können Sie dann ein neues 3-D Secure Passwort bei uns hinterlegen.</I> ';

UPDATE CustomItem
SET value = @textValue
WHERE ordinal = 3
AND locale = 'de'
AND pageTypes = @pageTypeHelp
AND fk_id_customItemSet = @customItemSetPassword;