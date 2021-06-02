USE `U5G_ACS_BO`;

SET @BankB = 'EWB';
SET @appViewPageDescription = CONCAT('OTP_SMS_App_View (', @BankB ,')');
SET @pageType = 'OTP_SMS_APP_VIEW';

SET FOREIGN_KEY_CHECKS = 0;

SET @appViewPageId=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageType and `description` = @appViewPageDescription);

DELETE FROM CustomComponent WHERE `fk_id_layout` = @appViewPageId;

DELETE FROM CustomPageLayout_ProfileSet WHERE `customPageLayout_id` = @appViewPageId;

DELETE FROM CustomPageLayout WHERE `description` = @appViewPageDescription ;

SET FOREIGN_KEY_CHECKS = 1;