USE U5G_ACS_BO;

SET @createdBy = 'A709391';
SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

SET @authentMean = 'PASSWORD';
SET @pageType = 'OTP_FORM_PAGE';
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_PASSWORD_UNIFIED');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@authentMean,'_',@pageType,'_28'), 'PUSHED_TO_CONFIG',
 'de', 28, @pageType, 'Ungültige Eingabe(n)', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@authentMean,'_',@pageType,'_29'), 'PUSHED_TO_CONFIG',
 'de', 29, @pageType, 'Das eingegebene Passwort und/oder die mTAN war(en) nicht korrekt. Bitte prüfen Sie die Eingaben und versuchen Sie es erneut. Sie haben noch @trialsLeft Versuche.', @MaestroVID, NULL, @customItemSetPassword);


SET @customItemSetSMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS');

SET @ordinal = 28;
SET @text = 'Ungültige Eingabe(n)';
UPDATE `CustomItem` SET `value` = @text
WHERE fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal and pageTypes = @pageType;

SET @ordinal = 29;
SET @text = 'Das eingegebene Passwort und/oder die mTAN war(en) nicht korrekt. Bitte prüfen Sie die Eingaben und versuchen Sie es erneut. Sie haben noch @trialsLeft Versuche.';
UPDATE `CustomItem` SET `value` = @text
WHERE fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal and pageTypes = @pageType;