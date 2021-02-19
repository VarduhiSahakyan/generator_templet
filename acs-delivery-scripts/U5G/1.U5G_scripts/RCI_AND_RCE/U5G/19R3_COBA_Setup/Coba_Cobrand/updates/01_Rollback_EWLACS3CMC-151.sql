USE U5G_ACS_BO;

/* REFUSAL : */
SET @currentPageType = 'REFUSAL_PAGE';
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_1_REFUSAL');
SET @ordinal = 23;
update CustomItem set value = 'Bitte registrieren Sie Ihre Kreditkarte für das sichere Einkaufen unter commerzbank.de/sicher-einkaufen'
where fk_id_customItemSet = @customItemSetREFUSAL and pageTypes = @currentPageType and ordinal = @ordinal;

delete from CustomItem where fk_id_customItemSet = @customItemSetREFUSAL and ordinal = 175 and pageTypes = @currentPageType;

SET @ordinal = 1;
SET @itemNameVisa = 'VISA_REFUSAL_REFUSAL_PAGE_1';
SET @itemNameMaster = 'MASTERCARD_REFUSAL_REFUSAL_PAGE_1';
update CustomItem set value = 'Infos zum sicheren Einkaufen im Internet finden Sie ebenfalls unter commerzbank.de/sicher-einkaufen'
where fk_id_customItemSet = @customItemSetREFUSAL and ordinal = @ordinal and name in (@itemNameVisa, @itemNameMaster);

SET @ordinal = 33;
update CustomItem set value = 'Ein technischer Fehler ist aufgetreten, Ihre Zahlung konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.'
where fk_id_customItemSet = @customItemSetREFUSAL and pageTypes = @currentPageType and ordinal = @ordinal;

/* Elements for the profile PASSWORD : */
SET @currentPageType = 'OTP_FORM_PAGE';
SET @currentAuthentMean = 'PASSWORD';
SET @customItemSetPASSWORD = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_PASSWORD');

SET @ordinal = 1;
update CustomItem set value = '<b>Bitte geben Sie Ihr 3-D Secure Passwort ein:</b>'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 2;
update CustomItem set value = '<b>Bitte bestätigen Sie folgende Zahlung:</b>'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 42;
update CustomItem set value = 'Freigeben'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 175;
delete from CustomItem where fk_id_customItemSet = @customItemSetPASSWORD and ordinal = @ordinal and pageTypes = @currentPageType;

/* Elements for the profile SMS : */

SET @currentAuthentMean = 'OTP_SMS';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_SMS');

SET @ordinal = 1;
update CustomItem set value = '<b>Freigabe durch mobileTAN:</b>'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 26;
update CustomItem set value = 'Authentifizierung erfolgreich'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 27;
update CustomItem set value = 'Sie werden automatisch zum Händler weitergeleitet.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 28;
update CustomItem set value = 'Ungültige mobileTAN'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 29;
update CustomItem set value = 'Sie haben eine ungültige mobileTAN eingegeben. Bitte versuchen Sie es erneut. Anzahl verbleibender Versuche: @trialsLeft '
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 175;
delete from CustomItem where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal and pageTypes = @currentPageType;

SET @ordinal = 174;
delete from CustomItem where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal and pageTypes = @currentPageType;

/* Elements for the FAILURE page, for SMS Profile */

SET @currentPageType = 'FAILURE_PAGE';
SET @ordinal = 175;
delete from CustomItem where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal and pageTypes = @currentPageType;

