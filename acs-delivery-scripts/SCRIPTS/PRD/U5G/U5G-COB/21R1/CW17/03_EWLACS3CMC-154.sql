USE U5G_ACS_BO;

SET @pageType = 'APP_VIEW';

SET @customItemSetPASSWORD = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_PASSWORD');

SET @ordinal = 151;
update CustomItem set value = 'Details'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 153;
update CustomItem set value = 'Bitte geben Sie Ihr 3-D Secure Passwort ein.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 154;
update CustomItem set value = 'Weiter'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 156;
update CustomItem set value = 'Ich benötige Hilfe'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 157;
update CustomItem set value = 'Haben Sie Ihr 3-D Secure Passwort vergessen?\n\nSie können sich auf der Internetseite www.commerzbank.de/sicher-einkaufen unter „Jetzt registrieren“ das dafür erforderliche Einmal-Passwort bei uns anfordern.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @pageType and ordinal = @ordinal;


SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_SMS');

SET @ordinal = 151;
update CustomItem set value = 'Bitte bestätigen Sie folgenden Auftrag'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 153;
update CustomItem set value = 'Zur Freigabe bitte die mobileTAN eingeben.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 155;
update CustomItem set value = 'Neue mobileTAN anfordern'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 156;
update CustomItem set value = 'Ich benötige Hilfe'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @pageType and ordinal = @ordinal;

SET @ordinal = 157;
update CustomItem set value = 'Die mobileTAN senden wir Ihnen per SMS.\n\nMöchten Sie Ihre Mobilnummer aktualisieren? Sie können sich auf der Internetseite www.commerzbank.de/sicher-einkaufen unter „Jetzt registrieren“ das dafür erforderliche Einmal-Passwort bei uns anfordern.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @pageType and ordinal = @ordinal;

