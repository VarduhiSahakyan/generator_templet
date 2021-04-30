USE `U5G_ACS_BO`;

SET @createdBy = 'A758582';
SET @issuerCode = '00070';

SET @profileSMS = (SELECT fk_id_customItemSetCurrent FROM `Profile` WHERE `name` = '00070_SMS_01');
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE id = @profileSMS);
SET @pageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `backgroundColor`, `borderStyle`, `textColor`, `fk_id_network`, `fk_id_image`, `fk_id_font`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_REFUSAL_PAGE_22_en', 'PUSHED_TO_CONFIG', 'en', 22, @pageType, 'Payment refused', NULL, NULL, NULL, 2, NULL, NULL, @customItemSetSMS),
	('T', @createdBy, NOW(), NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_REFUSAL_PAGE_23_en', 'PUSHED_TO_CONFIG', 'en', 23, @pageType, 'Your payment with Mastercard SecureCode™ is refused!', NULL, NULL, NULL, 2, NULL, NULL, @customItemSetSMS);