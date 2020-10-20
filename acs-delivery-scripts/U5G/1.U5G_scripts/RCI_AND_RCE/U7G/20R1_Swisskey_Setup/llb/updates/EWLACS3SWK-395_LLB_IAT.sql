USE U7G_ACS_BO;

SET @BankB = 'SWISSKEY';
SET @BankUB = 'LLB';
SET @authentMeansPassword = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'PASSWORD');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');

SET @profilePassword = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_Override'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_Override'));

UPDATE `Profile` SET `fk_id_AuthentMeans` = @authentMeansPassword WHERE id = @profilePassword;
UPDATE `Profile` SET `fk_id_AuthentMeans` = @authMeanOTPsms WHERE id = @profileSMS;


UPDATE `CustomPageLayout` SET `pageType` = 'PASSWORD_OTP_FORM_PAGE',
                              description = CONCAT('Password OTP Form Page (', @BankB, ')')
                            WHERE `pageType` = 'EXT_PASSWORD_OTP_FORM_PAGE' AND
                                `description` = CONCAT('EXT Password OTP Form Page (', @BankB, ')')