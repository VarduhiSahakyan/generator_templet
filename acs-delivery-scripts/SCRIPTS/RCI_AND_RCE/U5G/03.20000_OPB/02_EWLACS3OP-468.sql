USE U5G_ACS_BO;

SET @profileSetId = (SELECT `id` FROM `ProfileSet` WHERE `name` = 'PS_20000_SMS_OP');

UPDATE `BinRange` SET `fk_id_cryptoConfig` = 6 WHERE `fk_id_profileSet` = @profileSetId;
