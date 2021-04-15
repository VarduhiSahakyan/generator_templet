USE U5G_ACS_BO;

SET @createdBy ='A709391';
SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

/* Elements for the profile DEFAULT_REFUSAL : */
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_1_REFUSAL');

SET @ordinal = 23;
update CustomItem set value = 'Bitte registrieren Sie Ihre Kreditkarte für das sichere Einkaufen auf der folgenden Internetseite: <b>www.commerzbank.de/sicher-einkaufen > Jetzt registrieren</b>'
where fk_id_customItemSet = @customItemSetREFUSAL and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 1;
SET @itemNameVisa = 'VISA_REFUSAL_REFUSAL_PAGE_1';
SET @itemNameMaster = 'MASTERCARD_REFUSAL_REFUSAL_PAGE_1';
update CustomItem set value = '<b>Infos zum sicheren Einkaufen im Internet finden Sie ebenfalls unter www.commerzbank.de/sicher-einkaufen</b>'
where fk_id_customItemSet = @customItemSetREFUSAL and ordinal = @ordinal and name in (@itemNameVisa, @itemNameMaster);

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

/* Elements for the profile PASSWORD : */

SET @currentPageType = 'OTP_FORM_PAGE';
SET @currentAuthentMean = 'PASSWORD';
SET @customItemSetPASSWORD = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_PASSWORD');

SET @ordinal = 1;
update CustomItem set value = '<b>Bitte geben Sie zunächst Ihr 3-D Secure Passwort ein.</b>'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 2;
update CustomItem set value = '<b>Details</b>'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 13;
update CustomItem set value = 'Bitte warten Sie einige Sekunden. Ihre Eingabe wird geprüft. '
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 26;
update CustomItem set value = '<b>Authentifizierung erfolgreich -</b>'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 27;
update CustomItem set value = 'Sie werden automatisch zum Händler weitergeleitet. Bitte lassen Sie das Browserfenster geöffnet!'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 42;
update CustomItem set value = 'Weiter'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 31;
update CustomItem set value = 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Transaktion abgebrochen. Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 33;
update CustomItem set value = 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.'
where fk_id_customItemSet = @customItemSetPASSWORD  and ordinal = @ordinal;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetPASSWORD);

/* Elements for the FAILURE page, for Password Profile */

SET @currentPageType = 'FAILURE_PAGE';

SET @ordinal = 17;
update CustomItem set value = 'Der Auftrag konnte nicht ausgeführt werden. Bitte versuchen Sie es später erneut. '
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetPASSWORD);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihre Zahlung konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @MaestroVID, NULL, @customItemSetPASSWORD);


/* Elements for the profile SMS : */

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_SMS');

SET @currentAuthentMean = 'OTP_SMS';
SET @currentPageType = 'OTP_FORM_PAGE';

SET @ordinal = 1;
update CustomItem set value = '<b>Zur Freigabe bitte die mobileTAN eingeben, die Sie per SMS erhalten haben.</b>'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 2;
update CustomItem set value = '<b>Bitte bestätigen Sie folgenden Auftrag</b>'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 26;
update CustomItem set value = '<b>Authentifizierung erfolgreich -</b>'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 27;
update CustomItem set value = 'Sie werden automatisch zum Händler weitergeleitet. Bitte lassen Sie das Browserfenster geöffnet!'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetSMS);

SET @ordinal = 28;
update CustomItem set value = 'Ungültige Eingabe'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 29;
update CustomItem set value = 'Sie haben  ein ungültiges 3-D Secure Passwort  oder eine ungültige mobileTAN eingegeben. Bitte versuchen Sie es erneut. Anzahl verbleibender Versuche: @trialsLeft'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Schließen', @MaestroVID, NULL, @customItemSetSMS);

SET @ordinal = 31;
update CustomItem set value = 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Transaktion abgebrochen. Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 33;
update CustomItem set value = 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

/* Elements for the FAILURE page, for SMS Profile */

SET @currentPageType = 'FAILURE_PAGE';

SET @ordinal = 17;
update CustomItem set value = 'Der Auftrag konnte nicht ausgeführt werden. Bitte versuchen Sie es später erneut. '
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetSMS);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihre Zahlung konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @MaestroVID, NULL, @customItemSetSMS);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetSMS);
