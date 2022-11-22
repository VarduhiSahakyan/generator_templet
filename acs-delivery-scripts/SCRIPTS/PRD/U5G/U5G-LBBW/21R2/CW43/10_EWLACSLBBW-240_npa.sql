USE U5G_ACS_BO;
SET @updateState =  'PUSHED_TO_CONFIG';
SET @status = 'DEPLOYED_IN_PRODUCTION';
SET @createdBy = 'A757435';
SET @bank = 'LBBW';
SET @subIssuerID = (SELECT `id` FROM `SubIssuer` WHERE `code` = '19550');

SET @customItemSetSMS = (SELECT `id` FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @bank, '_OTP_SMS_NORMAL'));

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', @updateState, 'de', 0, 'MESSAGE_BODY_NPA',
        'Ihre SMS-mTAN für die Zahlung bei @merchant über @amount lautet: @otp', NULL, NULL, @customItemSetSMS);
