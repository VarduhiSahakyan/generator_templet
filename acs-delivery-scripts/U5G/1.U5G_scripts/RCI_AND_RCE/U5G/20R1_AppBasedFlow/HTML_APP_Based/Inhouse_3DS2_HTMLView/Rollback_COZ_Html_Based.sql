USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @idAppViewPagePassword=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'EXT_PASSWORD_APP_VIEW' and DESCRIPTION = 'EXT_PASSWORD_APP_VIEW (COZ)');
SET @idAppViewPageSMS=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_SMS_EXT_MESSAGE_APP_VIEW' and DESCRIPTION = 'SMS_App_View (COZ)') ;
SET @idAppViewPageTA=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_EXT_APP_VIEW' and DESCRIPTION = 'MOBILE_APP_EXT_App_View (COZ)') ;
SET @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_COZ_01');


delete from CustomPageLayout_ProfileSet where customPageLayout_id in(@idAppViewPageSMS,@idAppViewPageTA,@idAppViewPagePassword) and profileSet_id =@profileSetId;
delete from CustomComponent where fk_id_layout in (@idAppViewPageSMS,@idAppViewPageTA,@idAppViewPagePassword);

delete from CustomPageLayout where pageType like '%OTP_SMS_EXT_MESSAGE_APP_VIEW%' and description like '%SMS_App_View (COZ)%';
delete from CustomPageLayout where pageType like '%EXT_PASSWORD_APP_VIEW%' and description like '%EXT_PASSWORD_APP_VIEW (COZ)%';
delete from CustomPageLayout where pageType like '%MOBILE_APP_EXT_APP_VIEW%' and description like '%MOBILE_APP_EXT_App_View (COZ)%';


set foreign_key_checks = 1; 

commit;