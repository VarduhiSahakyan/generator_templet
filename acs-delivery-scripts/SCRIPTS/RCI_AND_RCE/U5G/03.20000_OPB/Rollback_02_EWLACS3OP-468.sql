USE U5G_ACS_BO;

SET @profileSetId = (SELECT `id` FROM `ProfileSet` WHERE `name` = 'PS_20000_SMS_OP');
SET @binRangeWithCrypto = (SELECT `id` FROM `BinRange` WHERE `lowerBound` = '4010430000' AND
                                                             `upperBound` = '4010439999');

UPDATE `BinRange` SET `fk_id_cryptoConfig` = NULL WHERE `fk_id_profileSet` = @profileSetId AND
                                                        `id` != @binRangeWithCrypto;
