USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @idAppViewPageTA=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_APP_VIEW' and DESCRIPTION = 'TA_App_View (LBBW)') ;
SET @idAppViewPageSMS=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_SMS_APP_VIEW' and DESCRIPTION = 'SMS_App_View (LBBW)') ;
SET @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_LBBW_01');



delete from CustomPageLayout_ProfileSet where customPageLayout_id in(@idAppViewPageSMS,@idAppViewPageTA) and profileSet_id =@profileSetId;
delete from CustomComponent where fk_id_layout in (@idAppViewPageSMS,@idAppViewPageTA);

delete from CustomPageLayout where pageType like '%OTP_SMS_APP_VIEW%' and description like '%SMS_App_View (LBBW)%';
delete from CustomPageLayout where pageType like '%MOBILE_APP_APP_VIEW%' and description like '%TA_App_View (LBBW)%';


set foreign_key_checks = 1; 

commit;