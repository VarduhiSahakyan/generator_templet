USE U5G_ACS_BO;

SET @createdBy ='A709391';
SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @dtype = 'T';
/* Elements for the profile DEFAULT_REFUSAL : */
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_1_REFUSAL');

SET @ordinal = 1;
SET @itemNameVisa = 'VISA_REFUSAL_REFUSAL_PAGE_1';
SET @itemNameMaster = 'MASTERCARD_REFUSAL_REFUSAL_PAGE_1';
update CustomItem set value = 'Nähere Informationen zu diesem Bezahl-Verfahren finden Sie in Ihrem Online Banking unter der Rubrik „Sicherheit“.'
where fk_id_customItemSet = @customItemSetREFUSAL and ordinal = @ordinal and DTYPE = @dtype and name in (@itemNameVisa, @itemNameMaster);

SET @ordinal = 23;
update CustomItem set value = 'Bitte aktivieren Sie Ihre Kreditkarte im Commerzbank Online Banking unter „Persönlicher Bereich“ – „Zusatzdienste“ oder rufen Sie uns unter der Nr. 069 / 5 8000 8000 an. Gerne können Sie auch Ihre Filiale zum Online Banking ansprechen.'
where fk_id_customItemSet = @customItemSetREFUSAL and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetREFUSAL);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @MaestroVID, NULL, @customItemSetREFUSAL);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetREFUSAL);


/* Elements for the profile MOBILE_APP : */

SET @currentPageType = 'POLLING_PAGE';
SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_MOBILE_APP');

SET @ordinal = 1;
update CustomItem set value = 'Freigabe mit photoTAN-Push in der Commerzbank photoTAN-App.'
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 2;
update CustomItem set value = '<b>Details</b>'
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 12;
update CustomItem set value = ''
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 13;
update CustomItem set value = 'Bitte öffnen Sie die Commerzbank photoTAN-App und geben Sie dort folgenden Auftrag frei: '
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 14;
update CustomItem set value = 'Die Transaktion wurde abgebrochen.'
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 15;
update CustomItem set value = 'Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten. '
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 26;
update CustomItem set value = 'Authentifizierung erfolgreich – Sie werden automatisch zum Händler weitergeleitet.'
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 27;
update CustomItem set value = 'Bitte lassen Sie das Browserfenster geöffnet!'
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 31;
update CustomItem set value = 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Transaktion abgebrochen. Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten.'
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 33;
update CustomItem set value = 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.'
where fk_id_customItemSet = @customItemSetMOBILEAPP and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

/* FAILURE page, for Mobile App Profile */

SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetMOBILEAPP);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @MaestroVID, NULL, @customItemSetMOBILEAPP);


/* Elements for the profile PASSWORD : */

SET @currentPageType = 'OTP_FORM_PAGE';
SET @currentAuthentMean = 'EXT_PASSWORD';
SET @customItemSetPASSWORD = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_PASSWORD');

SET @ordinal = 2;
update CustomItem set value = '<b>Details</b>'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 1;
update CustomItem set value = 'Bitte geben Sie Ihre Commerzbank Online Banking PIN ein.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 14;
update CustomItem set value = 'Die Transaktion wurde abgebrochen.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 15;
update CustomItem set value = 'Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten. '
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 42;
update CustomItem set value = 'Weiter'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 29;
update CustomItem set value = 'Sie haben eine ungültige Online Banking PIN eingegeben. Bitte versuchen Sie es erneut. Anzahl verbleibender Versuche: @trialsLeft'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 26;
update CustomItem set value = 'Authentifizierung wird fortgesetzt. Bitte warten Sie einige Sekunden.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 31;
update CustomItem set value = 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Transaktion abgebrochen. Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 33;
update CustomItem set value = 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Schließen', @MaestroVID, NULL, @customItemSetPASSWORD);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetPASSWORD);

/* FAILURE page, for PASSWORD Profile */
SET @currentPageType = 'FAILURE_PAGE';

SET @ordinal = 17;
update CustomItem set value = 'Die Transaktion konnte nicht abgeschlossen werden. Zur Freischaltung Ihrer Online Banking PIN rufen Sie bitte die Nr. 069 / 5 8000 8000 an.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetPASSWORD);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @MaestroVID, NULL, @customItemSetPASSWORD);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetPASSWORD);

/* Elements for the profile PHOTOTAN : */
SET @currentPageType = 'OTP_FORM_PAGE';
SET @currentAuthentMean = 'PHOTO_TAN';
SET @customItemSetPhotoTAN = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_PHOTOTAN');

SET @ordinal = 1;
update CustomItem set value = 'Freigabe mit photoTAN-Scan.<br>Bitte die Grafik scannen und die angezeigte photoTAN hier eingeben.'
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 2;
update CustomItem set value = '<b>Bitte bestätigen Sie folgenden Auftrag</b>'
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 14;
update CustomItem set value = 'Die Transaktion wurde abgebrochen.'
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 15;
update CustomItem set value = 'Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten. '
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 26;
update CustomItem set value = 'Authentifizierung erfolgreich – Sie werden automatisch zum Händler weitergeleitet.'
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 27;
update CustomItem set value = 'Bitte lassen Sie das Browserfenster geöffnet!'
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 31;
update CustomItem set value = 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Transaktion abgebrochen. Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten.'
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 33;
update CustomItem set value = 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.'
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetPhotoTAN);

/* FAILURE page, for PHOTOTAN Profile */
SET @currentPageType = 'FAILURE_PAGE';
SET @ordinal = 17;
update CustomItem set value = 'Die Transaktion konnte nicht abgeschlossen werden. Zur Freischaltung Ihrer Online Banking PIN rufen Sie bitte die Nr. 069 / 5 8000 8000 an.'
where fk_id_customItemSet = @customItemSetPhotoTAN and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetPhotoTAN);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @MaestroVID, NULL, @customItemSetPhotoTAN);


-- SMS --
SET @currentPageType = 'OTP_FORM_PAGE';
SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_SMS');

SET @ordinal = 1;
update CustomItem set value = 'Zur Freigabe die mobileTAN eingeben, die Sie per SMS erhalten haben.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 2;
update CustomItem set value = '<b>Bitte bestätigen Sie folgenden Auftrag</b>'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 14;
update CustomItem set value = 'Die Transaktion wurde abgebrochen.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 15;
update CustomItem set value = 'Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten. '
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 26;
update CustomItem set value = 'Authentifizierung erfolgreich – Sie werden automatisch zum Händler weitergeleitet.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 27;
update CustomItem set value = 'Bitte lassen Sie das Browserfenster geöffnet!'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 31;
update CustomItem set value = 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Transaktion abgebrochen. Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 33;
update CustomItem set value = 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

SET @ordinal = 34;
update CustomItem set value = 'mobileTAN wird per SMS versendet.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Schließen', @MaestroVID, NULL, @customItemSetSMS);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetSMS);

/* FAILURE page, for SMS Profile */

SET @currentPageType = 'FAILURE_PAGE';

SET @ordinal = 17;
update CustomItem set value = 'Der Auftrag konnte nicht ausgeführt werden. Zur Freischaltung Ihrer Online Banking PIN rufen Sie bitte die Nr. 069 / 5 8000 8000 an.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal and DTYPE = @dtype;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetSMS);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @MaestroVID, NULL, @customItemSetSMS);
