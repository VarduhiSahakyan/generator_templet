USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @idAppViewPagePassword=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'EXT_PASSWORD_APP_VIEW' and DESCRIPTION = 'EXT_PASSWORD_APP_VIEW (ING)');
SET @idAppViewPageSMS=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_SMS_EXT_MESSAGE_APP_VIEW' and DESCRIPTION = 'SMS_App_View (ING)') ;
SET @idAppViewPageTA=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_EXT_APP_VIEW' and DESCRIPTION = 'MOBILE_APP_EXT_App_View (ING)') ;
SET @idAppViewPageDeviceChoiceTA=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_EXT_APP_VIEW_DEVICE_SELECT' and DESCRIPTION = 'DEVICE_Choice_App_View (ING)') ;
SET @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_16500_01');


delete from CustomPageLayout_ProfileSet where customPageLayout_id in(@idAppViewPageSMS,@idAppViewPageTA,@idAppViewPagePassword,@idAppViewPageDeviceChoiceTA) and profileSet_id =@profileSetId;
delete from CustomComponent where fk_id_layout in (@idAppViewPageSMS,@idAppViewPageTA,@idAppViewPagePassword,@idAppViewPageDeviceChoiceTA);

delete from CustomPageLayout where pageType like '%OTP_SMS_EXT_MESSAGE_APP_VIEW%' and description like '%SMS_App_View (ING)%';
delete from CustomPageLayout where pageType like '%EXT_PASSWORD_APP_VIEW%' and description like '%EXT_PASSWORD_APP_VIEW (ING)%';
delete from CustomPageLayout where pageType like '%MOBILE_APP_EXT_APP_VIEW%' and description like '%MOBILE_APP_EXT_App_View (ING)%';
delete from CustomPageLayout where pageType like '%MOBILE_APP_EXT_APP_VIEW_DEVICE_SELECT%' and description like '%DEVICE_Choice_App_View (ING)%';


set foreign_key_checks = 1; 

commit;