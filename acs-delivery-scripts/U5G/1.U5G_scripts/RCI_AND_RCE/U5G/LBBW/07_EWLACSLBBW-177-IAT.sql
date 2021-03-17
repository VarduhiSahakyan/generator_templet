USE U5G_ACS_BO;

SET @createdBy = 'A709391';
SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

SET @currentAuthentMean = 'PASSWORD';
SET @currentPageType = 'OTP_FORM_PAGE';
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_PASSWORD_UNIFIED');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'de', 26, @currentPageType, 'Vorgang erfolgreich bestätigt mit BW-Secure', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'de', 27, @currentPageType, 'Die Zahlung wird nun geprüft und abschließend vom Händler weiterberarbeitet.', @MaestroVID, NULL, @customItemSetPassword);

SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'de', 16, @currentPageType, 'Zahlungsabbruch', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'de', 17, @currentPageType, 'Sie haben zu oft ungültige Daten eingegeben. Zu Ihrer Sicherheit wird der Zahlungsvorgang daher abgebrochen. Bitte versuchen Sie es erneut.', @MaestroVID, NULL, @customItemSetPassword);


SET @currentPageType = 'OTP_FORM_PAGE';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_OTP_SMS');

SET @ordinal = 28;
update CustomItem set value = 'Ungültige Eingabe(n)'
where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal and pageTypes = @currentPageType;

SET @ordinal = 29;
update CustomItem set value = 'Das eingegebene Passwort und/oder die mTAN war(en) nicht korrekt. Bitte prüfen Sie die Eingaben und versuchen Sie es erneut.'
where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal and pageTypes = @currentPageType;


SET @currentPageType = 'FAILURE_PAGE';

SET @ordinal = 16;
update CustomItem set value = 'Zahlungsabbruch'
where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal and pageTypes = @currentPageType;

SET @ordinal = 17;
update CustomItem set value = 'Sie haben zu oft ungültige Daten eingegeben. Zu Ihrer Sicherheit wird der Zahlungsvorgang daher abgebrochen. Bitte versuchen Sie es erneut.'
where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal and pageTypes = @currentPageType;



