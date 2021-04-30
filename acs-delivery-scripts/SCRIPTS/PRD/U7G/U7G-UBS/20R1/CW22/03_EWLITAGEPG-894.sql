USE U7G_ACS_BO;

set @BankUB = 'UBS';
set @createdBy = 'A757435';

SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

SET @currentAuthentMean = 'MOBILE_APP_EXT';
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, '', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'de', 16, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'de', 17, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'de', 40, @currentPageType, 'OK', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'de', 41, @currentPageType, '<a href="http://www.ubs.com/eb0055-de" target="_blank">Hilfe</a>', @MaestroVID, NULL, @customItemSetMobileApp);

/********* EN_START *********/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'en', 1, @currentPageType, '', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'en', 2, @currentPageType, '', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'en', 16, @currentPageType, 'Technical error', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'en', 17, @currentPageType, 'A technical error has occurred and your purchase could not be made. Please try again later.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'en', 40, @currentPageType, 'OK', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'en', 41, @currentPageType, '<a href="http://www.ubs.com/eb0055-en" target="_blank">Help</a>', @MaestroVID, NULL, @customItemSetMobileApp);
/********* EN_END *********/

/********* FR_START *********/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'fr', 1, @currentPageType, '', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'fr', 2, @currentPageType, '', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'fr', 16, @currentPageType, 'Erreur technique', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'fr', 17, @currentPageType, 'Une erreur technique est survenue et votre achat n’a pas pu être finalisé. Veuillez réessayer.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'fr', 40, @currentPageType, 'OK', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'fr', 41, @currentPageType, '<a href="http://www.ubs.com/eb0055-fr" target="_blank">Aide</a>', @MaestroVID, NULL, @customItemSetMobileApp);
/********* FR_END *********/

/********* IT_START *********/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'it', 1, @currentPageType, '', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'it', 2, @currentPageType, '', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'it', 16, @currentPageType, 'Problema tecnico', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'it', 17, @currentPageType, 'Si è verificato un errore tecnico e il suo acquisto non può essere concluso. La preghiamo di riprovare più tardi.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'it', 40, @currentPageType, 'OK', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'it', 41, @currentPageType, '<a href="http://www.ubs.com/eb0055-it" target="_blank">Aiuto</a>', @MaestroVID, NULL, @customItemSetMobileApp);
/********* IT_END *********/
