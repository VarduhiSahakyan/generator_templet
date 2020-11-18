USE U7G_ACS_BO;
SET @subIssuerNameAndLabel = 'Raiffeisenbank Schweiz';
SET @subIssuerCode = '80808';
SET @BankUB = 'RCH';
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

UPDATE `Profile` SET `maxAttempts` = 4 WHERE `name` = CONCAT(@BankUB,'_ACCEPT');
UPDATE `Profile` SET `maxAttempts` = 4 WHERE `name` = CONCAT(@BankUB,'_DECLINE');

SET @profileMOBILEAPP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_APP_01'));
SET @profileMOBILEAPPEXT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_APP_EXT_01'));

SET @ruleMobileAppnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_APP (NORMAL)' AND `fk_id_profile` = @profileMOBILEAPP);
SET @ruleMobileAppEXT = (SELECT id FROM `Rule` WHERE `description` = 'OTP_APP_EXT' AND `fk_id_profile` = @profileMOBILEAPPEXT);

UPDATE `Rule` SET `description` = 'OTP_APP(FALLBACK)',
                  `orderRule` = 6,
                  `name` = 'TA (FALLBACK)' WHERE `id` = @ruleMobileAppnormal ;

UPDATE `Rule` SET `description` = 'OTP_APP_EXT(NORMAL)',
                  `orderRule` = 5,
                  `name` = 'OOB (NORMAL)' WHERE `id` = @ruleMobileAppEXT ;


UPDATE `RuleCondition` SET `name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP')  WHERE `name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL');
UPDATE `RuleCondition` SET `name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT')  WHERE `name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_FALLBACK');
UPDATE `RuleCondition` SET `name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT')  WHERE `name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_FALLBACK');


