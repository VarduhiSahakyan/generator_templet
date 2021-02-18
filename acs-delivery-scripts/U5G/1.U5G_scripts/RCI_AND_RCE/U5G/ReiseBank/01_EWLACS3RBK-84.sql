USE `U5G_ACS_BO`;

SET @createdBy ='A758582';
SET @BankUB = 'ReiseBank';
SET @subIssuerCode = '12000';

SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@subIssuerCode, '_', @BankUB, '_SMS_01'));
SET @currentAuthentMean = 'OTP_SMS';
SET @currentPageType = 'OTP_FORM_PAGE';




INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'de', 12, @currentPageType, 'Authentifizierung wird durchgeführt', @MaestroMID, NULL, @customItemSetSMS);