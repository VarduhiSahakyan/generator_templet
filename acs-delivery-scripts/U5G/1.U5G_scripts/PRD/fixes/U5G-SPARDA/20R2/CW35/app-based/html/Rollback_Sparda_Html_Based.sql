USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @idAppViewPageChoice=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'UNDEFINED_APP_VIEW_MEAN_SELECT' and DESCRIPTION = 'Choice_App_View (SPARDA)');
SET @idAppViewPageSMS=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_SMS_EXT_MESSAGE_APP_VIEW' and DESCRIPTION = 'SMS_App_View (SPARDA)') ;
SET @idAppViewPageTA=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_EXT_APP_VIEW' and DESCRIPTION = 'MOBILE_APP_EXT_APP_VIEW (SPARDA)') ;
SET @idAppViewPageTADeviceChoice=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_EXT_APP_VIEW_DEVICE_SELECT' and DESCRIPTION = 'MOBILE_APP_EXT_DEVICE_Choice_App_View (SPARDA)') ;
SET @idAppViewPagePassword=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'EXT_PASSWORD_APP_VIEW' and DESCRIPTION = 'EXT_PASSWORD_APP_VIEW (SPARDA)') ;
SET @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_SPB_sharedBIN_01');


delete from CustomPageLayout_ProfileSet where customPageLayout_id in(@idAppViewPageSMS,@idAppViewPageTA,@idAppViewPageChoice,@idAppViewPagePassword,@idAppViewPageTADeviceChoice) and profileSet_id =@profileSetId;
delete from CustomComponent where fk_id_layout in (@idAppViewPageSMS,@idAppViewPageTA,@idAppViewPageChoice,@idAppViewPagePassword,@idAppViewPageTADeviceChoice);

delete from CustomPageLayout where pageType like '%OTP_SMS_EXT_MESSAGE_APP_VIEW%' and description like '%SMS_App_View (SPARDA)%';
delete from CustomPageLayout where pageType like '%UNDEFINED_APP_VIEW_MEAN_SELECT%' and description like '%Choice_App_View (SPARDA)%';
delete from CustomPageLayout where pageType like '%MOBILE_APP_EXT_App_View%' and description like '%MOBILE_APP_EXT_App_View (SPARDA)%';
delete from CustomPageLayout where pageType like '%MOBILE_APP_EXT_APP_VIEW_DEVICE_SELECT%' and description like '%MOBILE_APP_EXT_DEVICE_Choice_App_View (SPARDA)%';
delete from CustomPageLayout where pageType like '%EXT_PASSWORD_APP_VIEW%' and description like '%EXT_PASSWORD_APP_VIEW (SPARDA)%';

set foreign_key_checks = 1; 

commit;