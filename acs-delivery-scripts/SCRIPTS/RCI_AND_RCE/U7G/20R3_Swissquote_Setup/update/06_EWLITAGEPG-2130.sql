USE U7G_ACS_BO;

SET @createdBy = 'A758582';

SET @MaestroVID = NULL;
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');

SET @updateState =  'PUSHED_TO_CONFIG';
SET @currentPageType = 'ALL';
SET @currentAuthentMean = 'REFUSAL';

SET @customItemSetREFUSAL_SQB = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SQB_MISSING_AUTHENTICATION_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie den Payment Card Service Helpdesk unter +41 58 721 93 93.', @MaestroVID, NULL, @customItemSetREFUSAL_SQB),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'The payment cannot be processed. Please contact the Payment Card Service Helpdesk on +41 58 721 93 93.', @MaestroVID, NULL, @customItemSetREFUSAL_SQB),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'it', 1000, @currentPageType, 'La transazione non è andata a buon fine. Si prega di contattare il Payment Card Service Helpdesk al numero +41 58 721 93 93.', @MaestroVID, NULL, @customItemSetREFUSAL_SQB),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'fr', 1000, @currentPageType, 'La transaction n''a pas abouti. Veuillez contacter le Payment Card Service Helpdesk au +41 58 721 93 93.', @MaestroVID, NULL, @customItemSetREFUSAL_SQB),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie den Payment Card Service Helpdesk unter +41 58 721 93 93.', @MaestroVID, NULL, @customItemSetREFUSAL_SQB),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'The payment cannot be processed. Please contact the Payment Card Service Helpdesk on +41 58 721 93 93.', @MaestroVID, NULL, @customItemSetREFUSAL_SQB),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'it', 1001, @currentPageType, 'La transazione non è andata a buon fine. Si prega di contattare il Payment Card Service Helpdesk al numero +41 58 721 93 93.', @MaestroVID, NULL, @customItemSetREFUSAL_SQB),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'fr', 1001, @currentPageType, 'La transaction n''a pas abouti. Veuillez contacter le Payment Card Service Helpdesk au +41 58 721 93 93.', @MaestroVID, NULL, @customItemSetREFUSAL_SQB),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie den Payment Card Service Helpdesk unter +41 58 721 93 93.', @MaestroVID, NULL, @customItemSetREFUSAL_SQB),
   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'The payment cannot be processed. Please contact the Payment Card Service Helpdesk on +41 58 721 93 93.', @MaestroVID, NULL, @customItemSetREFUSAL_SQB),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'it', 1002, @currentPageType, 'La transazione non è andata a buon fine. Si prega di contattare il Payment Card Service Helpdesk al numero +41 58 721 93 93.', @MaestroVID, NULL, @customItemSetREFUSAL_SQB),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'fr', 1002, @currentPageType, 'La transaction n''a pas abouti. Veuillez contacter le Payment Card Service Helpdesk au +41 58 721 93 93.', @MaestroVID, NULL, @customItemSetREFUSAL_SQB);