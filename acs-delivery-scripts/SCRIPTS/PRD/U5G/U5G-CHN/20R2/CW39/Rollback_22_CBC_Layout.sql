USE `U5G_ACS_BO`;

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_00070_01');

SET @idAppViewPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_SMS_APP_VIEW' and DESCRIPTION = 'SMS_App_View (CBC)') ;

DELETE FROM `CustomPageLayout_ProfileSet` WHERE customPageLayout_id = @idAppViewPage and profileSet_id = @ProfileSet;

DELETE FROM `CustomComponent` WHERE `fk_id_layout` = @idAppViewPage;

DELETE FROM `CustomPageLayout` where `id` = @idAppViewPage;