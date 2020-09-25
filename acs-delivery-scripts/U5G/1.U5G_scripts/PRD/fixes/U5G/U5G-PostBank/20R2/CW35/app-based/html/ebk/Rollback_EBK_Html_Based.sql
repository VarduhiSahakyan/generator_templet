USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @idAppViewPageChoice=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'UNDEFINED_APP_VIEW_MEAN_SELECT' and DESCRIPTION = 'Choice_App_View (EBK)');
SET @idAppViewPageSMS=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_SMS_EXT_MESSAGE_APP_VIEW' and DESCRIPTION = 'SMS_App_View (EBK)') ;
SET @idAppViewPageSMSDeviceChoice=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_SMS_EXT_MESSAGE_APP_VIEW_DEVICE_SELECT' and DESCRIPTION = 'SMS_DEVICE_Choice_App_View (EBK)') ;
SET @idAppViewPageTA=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_EXT_App_View' and DESCRIPTION = 'MOBILE_APP_EXT_App_View (EBK)') ;
SET @idAppViewPageTADeviceChoice=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_EXT_APP_VIEW_DEVICE_SELECT' and DESCRIPTION = 'MOBILE_APP_EXT_DEVICE_Choice_App_View (EBK)') ;
SET @idAppViewPageKBA=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'KBA_APP_VIEW' and DESCRIPTION = 'KBA_APP_VIEW (EBK)') ;
SET @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_18501_PB_01');


delete from CustomPageLayout_ProfileSet where customPageLayout_id in(@idAppViewPageSMS,@idAppViewPageTA,@idAppViewPageChoice,@idAppViewPageKBA,@idAppViewPageSMSDeviceChoice,@idAppViewPageTADeviceChoice) and profileSet_id =@profileSetId;
delete from CustomComponent where fk_id_layout in (@idAppViewPageSMS,@idAppViewPageTA,@idAppViewPageChoice,@idAppViewPageKBA,@idAppViewPageSMSDeviceChoice,@idAppViewPageTADeviceChoice);

delete from CustomPageLayout where pageType like '%OTP_SMS_EXT_MESSAGE_APP_VIEW%' and description like '%SMS_App_View (EBK)%';
delete from CustomPageLayout where pageType like '%OTP_SMS_EXT_MESSAGE_APP_VIEW_DEVICE_SELECT%' and description like '%SMS_DEVICE_Choice_App_View (EBK)%';
delete from CustomPageLayout where pageType like '%UNDEFINED_APP_VIEW_MEAN_SELECT%' and description like '%Choice_App_View (EBK)%';
delete from CustomPageLayout where pageType like '%MOBILE_APP_EXT_App_View%' and description like '%MOBILE_APP_EXT_App_View (EBK)%';
delete from CustomPageLayout where pageType like '%MOBILE_APP_EXT_APP_VIEW_DEVICE_SELECT%' and description like '%MOBILE_APP_EXT_DEVICE_Choice_App_View (EBK)%';
delete from CustomPageLayout where pageType like '%KBA_APP_VIEW%' and description like '%KBA_APP_VIEW (EBK)%';

set foreign_key_checks = 1; 

commit;