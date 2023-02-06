USE `U7G_ACS_BO`;

SET @createdBy = 'A758582';
SET @BankB = 'SWISSQUOTE';
SET @BankUB = 'SQB';

UPDATE `Profile` SET `maxAttempts` = 3 WHERE `name` = CONCAT(@BankUB,'_ACCEPT')
                                        OR `name` = CONCAT(@BankUB,'_DECLINE')
                                        OR `name` = CONCAT(@BankUB,'_SMS_01');