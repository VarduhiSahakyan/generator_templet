USE `U5G_ACS_BO`;

SET @createdBy = 'InitPhase';
SET @issuerCode = '00070';

SET @idCustomItemSet = (SELECT max(id) from `CustomItemSet` where `description` = 'customitemset_00070_SMS_Current');


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `backgroundColor`, `borderStyle`, `textColor`, `fk_id_network`, `fk_id_image`, `fk_id_font`, `fk_id_customItemSet`)
VALUES 	('T', @createdBy, '2020-06-04 19:35:00', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_ALL_1_en', 'PUSHED_TO_CONFIG', 'en', 1, 'ALL', 'Your Mastercard SecureCode™ authentication has failed.', NULL, NULL, NULL, 2, NULL, NULL, @idCustomItemSet);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `backgroundColor`, `borderStyle`, `textColor`, `fk_id_network`, `fk_id_image`, `fk_id_font`, `fk_id_customItemSet`)
VALUES 	('T', @createdBy, '2020-06-04 19:35:00', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_ALL_2_en', 'PUSHED_TO_CONFIG', 'en', 2, 'ALL', 'Please call China Bank Customer Service 24/7 Hotline at +632 888-55-888.', NULL, NULL, NULL, 2, NULL, NULL, @idCustomItemSet);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `backgroundColor`, `borderStyle`, `textColor`, `fk_id_network`, `fk_id_image`, `fk_id_font`, `fk_id_customItemSet`)
VALUES 	('T', @createdBy, '2020-06-04 19:35:00', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_ALL_20_en', 'PUSHED_TO_CONFIG', 'en', 20, 'ALL', '', NULL, NULL, NULL, 2, NULL, NULL, @idCustomItemSet);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `backgroundColor`, `borderStyle`, `textColor`, `fk_id_network`, `fk_id_image`, `fk_id_font`, `fk_id_customItemSet`)
VALUES 	('T', @createdBy, '2020-06-04 19:35:00', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_ALL_40_en', 'PUSHED_TO_CONFIG', 'en', 40, 'ALL', 'Cancel my purchase', NULL, NULL, NULL, 2, NULL, NULL, @idCustomItemSet);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `backgroundColor`, `borderStyle`, `textColor`, `fk_id_network`, `fk_id_image`, `fk_id_font`, `fk_id_customItemSet`)
VALUES 	('T', @createdBy, '2020-06-04 19:35:00', NULL, NULL, NULL, 'MASTERCARD_OTP_SMS_ALL_41_en', 'PUSHED_TO_CONFIG', 'en', 41, 'ALL', 'Help Page', NULL, NULL, NULL, 2, NULL, NULL, @idCustomItemSet);
