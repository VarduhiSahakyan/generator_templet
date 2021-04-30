USE U5G_ACS_BO;

SET @createdBy ='A709391';
SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
/* Elements for the profile DEFAULT_REFUSAL : */
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_1_REFUSAL');

SET @ordinal = 23;
update CustomItem set value = 'Bitte aktivieren Sie Ihre Kreditkarte im Online Banking oder wenden Sie sich an den Ansprechpartner in Ihrer Filiale.'
where fk_id_customItemSet = @customItemSetREFUSAL and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 1;
SET @itemNameVisa = 'VISA_REFUSAL_REFUSAL_PAGE_1';
SET @itemNameMaster = 'MASTERCARD_REFUSAL_REFUSAL_PAGE_1';
update CustomItem set value = 'Nähere Informationen zu diesem Bezahl-Verfahren finden Sie in Ihrem Online Banking.'
where fk_id_customItemSet = @customItemSetREFUSAL and ordinal = @ordinal and name in (@itemNameVisa, @itemNameMaster);

delete from CustomItem where fk_id_customItemSet = @customItemSetREFUSAL and ordinal in (32,33,175) and pageTypes = @currentPageType;

/* Elements for the profile MOBILE_APP : */

SET @currentAuthentMean = 'MOBILE_APP_EXT';
SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_MOBILE_APP');
SET @currentPageType = 'POLLING_PAGE';

SET @ordinal = 13;
update CustomItem set value = ''
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 2;
update CustomItem set value = '<b>Bitte bestätigen Sie folgende Zahlung</b>'
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 1;
update CustomItem set value = '<b>Freigabe mit photoTAN-Push. Jetzt die photoTAN-App starten und die Zahlung dort freigeben.</b>'
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 26;
update CustomItem set value = 'Authentifizierung erfolgreich'
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 27;
update CustomItem set value = 'Sie werden automatisch zum Händler weitergeleitet.'
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal;

/* Elements for the profile PASSWORD : */

SET @currentAuthentMean = 'PASSWORD';
SET @customItemSetPASSWORD = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_PASSWORD');
SET @currentPageType = 'OTP_FORM_PAGE';

SET @ordinal = 2;
update CustomItem set value = '<b>Bitte bestätigen Sie folgende Zahlung</b>'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 1;
update CustomItem set value = '<b>Bitte geben Sie Ihre Online Banking PIN ein:</b>'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 42;
update CustomItem set value = 'Freigeben'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 29;
update CustomItem set value = 'Sie haben eine ungültige PIN eingegeben. Bitte versuchen Sie es erneut. Anzahl verbleibender Versuche: @trialsLeft'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 26;
update CustomItem set value = 'Authentifizierung wird fortgesetzt.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

delete from CustomItem where fk_id_customItemSet = @customItemSetPASSWORD and ordinal = 174 and pageTypes = @currentPageType;
delete from CustomItem where fk_id_customItemSet = @customItemSetPASSWORD and ordinal = 175 and pageTypes = @currentPageType;

/* Elements for the FAILURE page, for PASSWORD Profile */
SET @currentPageType = 'FAILURE_PAGE';
SET @ordinal = 17;
update CustomItem set value = 'Die Zahlung konnte nicht abgeschlossen werden. Zur Freischaltung Ihrer PIN rufen Sie bitte die Nr. 069 / 5 8000 8000 an.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

delete from CustomItem where fk_id_customItemSet = @customItemSetPASSWORD and ordinal = 175 and pageTypes = @currentPageType;

/* Elements for the profile PHOTOTAN : */

SET @currentAuthentMean = 'PHOTO_TAN';
SET @customItemSetPhotoTAN = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_COZ_PHOTOTAN'));
SET @currentPageType = 'OTP_FORM_PAGE';

SET @ordinal = 1;
update CustomItem set value = '<b>Freigabe durch photoTAN:</b>'
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 26;
update CustomItem set value = 'Authentifizierung erfolgreich'
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 27;
update CustomItem set value = 'Sie werden automatisch zum Händler weitergeleitet.'
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal;

delete from CustomItem where fk_id_customItemSet = @customItemSetPhotoTAN and ordinal = 175 and pageTypes = @currentPageType;

SET @currentPageType = 'FAILURE_PAGE';
SET @ordinal = 17;
update CustomItem set value = 'Die Zahlung konnte nicht abgeschlossen werden. Zur Freischaltung Ihres TAN-Verfahrens rufen Sie bitte die Nr. 069 / 5 8000 8000 an.'
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal;

-- SMS --
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_SMS');
SET @currentPageType = 'OTP_FORM_PAGE';

SET @ordinal = 1;
update CustomItem set value = '<b>Freigabe durch mobileTAN:</b>'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 34;
update CustomItem set value = 'mobileTAN wird versendet.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 26;
update CustomItem set value = 'Authentifizierung erfolgreich'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 27;
update CustomItem set value = 'Sie werden automatisch zum Händler weitergeleitet.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

delete from CustomItem where fk_id_customItemSet = @customItemSetSMS and ordinal = 174 and pageTypes = @currentPageType;

delete from CustomItem where fk_id_customItemSet = @customItemSetSMS and ordinal = 175 and pageTypes = @currentPageType;
