USE U5G_ACS_BO;

SET @createdBy = 'A758582';

SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');

SET @updateState =  'PUSHED_TO_CONFIG';
SET @currentPageType = 'ALL';
SET @currentAuthentMean = 'REFUSAL';

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_MISSING_AUTHENTICATION_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'BW-Secure ist erforderlich. Bitte gehen Sie auf https://sicheres-bezahlen.bw-bank.de und registrieren Ihre Karte.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'BW-Secure ist erforderlich. Bitte gehen Sie auf https://sicheres-bezahlen.bw-bank.de und registrieren Ihre Karte.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'BW-Secure ist erforderlich. Bitte gehen Sie auf https://sicheres-bezahlen.bw-bank.de und registrieren Ihre Karte.', @MaestroVID, NULL, @customItemSetREFUSAL);


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16500_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Die Zahlung ist nicht möglich. Bitte loggen Sie sich ins Online-Banking der ING ein, um Ihr Freigabeverfahren freizuschalten.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Die Zahlung ist nicht möglich. Bitte loggen Sie sich ins Online-Banking der ING ein, um Ihr Freigabeverfahren freizuschalten.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Die Zahlung ist nicht möglich. Bitte loggen Sie sich ins Online-Banking der ING ein, um Ihr Freigabeverfahren freizuschalten.', @MaestroVID, NULL, @customItemSetREFUSAL);


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18501_PB_2_REFUSAL');

 INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                           `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                           `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
  'de', 1000, @currentPageType, 'Ihr Einkauf kann nicht durchgeführt werden. Sie benötigen dafür ein Sicherheitsverfahren, z.B. „mobileTAN“ oder „BestSign“.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
  'de', 1001, @currentPageType, 'Ihr Einkauf kann nicht durchgeführt werden. Sie benötigen dafür ein Sicherheitsverfahren, z.B. „mobileTAN“ oder „BestSign“.', @MaestroVID, NULL, @customItemSetREFUSAL),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
  'de', 1002, @currentPageType, 'Ihr Einkauf kann nicht durchgeführt werden. Sie benötigen dafür ein Sicherheitsverfahren, z.B. „mobileTAN“ oder „BestSign“.', @MaestroVID, NULL, @customItemSetREFUSAL);


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18502_PB_2_REFUSAL');

 INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                           `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                           `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
  'de', 1000, @currentPageType, 'Ihr Einkauf kann nicht durchgeführt werden. Sie benötigen dafür ein Sicherheitsverfahren, z.B. „mobileTAN“ oder „BestSign“.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
  'de', 1001, @currentPageType, 'Ihr Einkauf kann nicht durchgeführt werden. Sie benötigen dafür ein Sicherheitsverfahren, z.B. „mobileTAN“ oder „BestSign“.', @MaestroVID, NULL, @customItemSetREFUSAL),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
  'de', 1002, @currentPageType, 'Ihr Einkauf kann nicht durchgeführt werden. Sie benötigen dafür ein Sicherheitsverfahren, z.B. „mobileTAN“ oder „BestSign“.', @MaestroVID, NULL, @customItemSetREFUSAL);

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18502_PB_3_REFUSAL');

 INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                           `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                           `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
  'de', 1000, @currentPageType, 'Ihr Einkauf kann nicht durchgeführt werden. Sie benötigen dafür ein Sicherheitsverfahren, z.B. „mobileTAN“ oder „BestSign“.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
  'de', 1001, @currentPageType, 'Ihr Einkauf kann nicht durchgeführt werden. Sie benötigen dafür ein Sicherheitsverfahren, z.B. „mobileTAN“ oder „BestSign“.', @MaestroVID, NULL, @customItemSetREFUSAL),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
  'de', 1002, @currentPageType, 'Ihr Einkauf kann nicht durchgeführt werden. Sie benötigen dafür ein Sicherheitsverfahren, z.B. „mobileTAN“ oder „BestSign“.', @MaestroVID, NULL, @customItemSetREFUSAL);



SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_12000_ReiseBank_MISSING_AUTHENTICATION_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Zahlung nicht ausgeführt. Registrieren Sie sich in der RBMC Secure App für 3D Secure. Infos auf www.reisebank.de/mastercard', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Zahlung nicht ausgeführt. Registrieren Sie sich in der RBMC Secure App für 3D Secure. Infos auf www.reisebank.de/mastercard', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Zahlung nicht ausgeführt. Registrieren Sie sich in der RBMC Secure App für 3D Secure. Infos auf www.reisebank.de/mastercard', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'Payment not executed. Register for 3D Secure in the RBMC Secure App. Info on www.reisebank.de/mastercard', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'Payment not executed. Register for 3D Secure in the RBMC Secure App. Info on www.reisebank.de/mastercard', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'Payment not executed. Register for 3D Secure in the RBMC Secure App. Info on www.reisebank.de/mastercard', @MaestroVID, NULL, @customItemSetREFUSAL);


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_1_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Für diese Transaktion ist eine zusätzliche Authentifizierung erforderlich. Bitte wenden Sie sich an Ihr Betreuungsteam', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Für diese Transaktion ist eine zusätzliche Authentifizierung erforderlich. Bitte wenden Sie sich an Ihr Betreuungsteam', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Für diese Transaktion ist eine zusätzliche Authentifizierung erforderlich. Bitte wenden Sie sich an Ihr Betreuungsteam', @MaestroVID, NULL, @customItemSetREFUSAL);


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_BNP_WM_1_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Für diese Transaktion ist eine zusätzliche Authentifizierung erforderlich. Bitte wenden Sie sich an Ihr Betreuungsteam', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Für diese Transaktion ist eine zusätzliche Authentifizierung erforderlich. Bitte wenden Sie sich an Ihr Betreuungsteam', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Für diese Transaktion ist eine zusätzliche Authentifizierung erforderlich. Bitte wenden Sie sich an Ihr Betreuungsteam', @MaestroVID, NULL, @customItemSetREFUSAL);


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SPB_sharedBIN_DEFAULT_REFUSAL');

 INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                           `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
  'de', 1000, @currentPageType, 'Eine Freigabe der Zahlung ist nicht möglich. Bitte wenden Sie sich an die kontoführende Filiale Ihrer Sparda-Bank.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
  'de', 1001, @currentPageType, 'Eine Freigabe der Zahlung ist nicht möglich. Bitte wenden Sie sich an die kontoführende Filiale Ihrer Sparda-Bank.', @MaestroVID, NULL, @customItemSetREFUSAL),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
  'de', 1002, @currentPageType, 'Eine Freigabe der Zahlung ist nicht möglich. Bitte wenden Sie sich an die kontoführende Filiale Ihrer Sparda-Bank.', @MaestroVID, NULL, @customItemSetREFUSAL);
