USE `U5G_ACS_BO`;

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_1_REFUSAL');
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_SMS');
SET @customItemSetAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_MOBILE_APP_EXT');
SET @customItemSetPhotoTAN = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_PHOTO_TAN');
SET @customItemSetPWD = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16900_PASSWORD');

SET @ordinal = 7;

UPDATE CustomItem SET value = 'Mo-So: 7:00 Uhr - 22:30 Uhr'
WHERE ordinal = @ordinal AND fk_id_customItemSet  in (@customItemSetRefusal, @customItemSetSMS, @customItemSetAPP, @customItemSetPhotoTAN, @customItemSetPWD);