USE U5G_ACS_BO;

SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');

SET @ordinal = 35;
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_OTP_SMS');
update CustomItem set value = 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie eine neue mTAN. Alle vorherigen mTANs sind nicht mehr gültig.'
where fk_id_customItemSet = @customItemSetSMS and ordinal = @ordinal;


SET @ordinal = 34;
SET @customItemSetSMSunified = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_OTP_SMS_UNIFIED');
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES
    ('T',  'A709391', NOW(), null, null, null, 'VISA_OTP_SMS_OTP_FORM_PAGE_34', 'PUSHED_TO_CONFIG',
    'de', @ordinal, 'OTP_FORM_PAGE', 'SMS wird versendet.', @MaestroVID, null, @customItemSetSMSunified),
    ('T',  'A709391', NOW(), null, null, null, 'VISA_OTP_SMS_OTP_FORM_PAGE_34', 'PUSHED_TO_CONFIG',
       'de', @ordinal, 'OTP_FORM_PAGE', 'SMS wird versendet.', @MaestroMID, null, @customItemSetSMSunified);


SET @ordinal = 35;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES
    ('T',  'A709391', NOW(), null, null, null, 'VISA_OTP_SMS_OTP_FORM_PAGE_35', 'PUSHED_TO_CONFIG',
    'de', @ordinal, 'OTP_FORM_PAGE', 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie eine neue mTAN. Alle vorherigen mTANs sind nicht mehr gültig.', @MaestroVID, null, @customItemSetSMSunified),
    ('T',  'A709391', NOW(), null, null, null, 'VISA_OTP_SMS_OTP_FORM_PAGE_35', 'PUSHED_TO_CONFIG',
    'de', @ordinal, 'OTP_FORM_PAGE', 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie eine neue mTAN. Alle vorherigen mTANs sind nicht mehr gültig.', @MaestroMID, null, @customItemSetSMSunified);


