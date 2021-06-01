USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @idAppViewPageSMS=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_SMS_APP_VIEW' and DESCRIPTION = 'SMS_App_View (VW)') ;
SET @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_VW_01');


delete from CustomPageLayout_ProfileSet where customPageLayout_id in(@idAppViewPageSMS) and profileSet_id =@profileSetId;
delete from CustomComponent where fk_id_layout in (@idAppViewPageSMS);

delete from CustomPageLayout where pageType like '%OTP_SMS_APP_VIEW%' and description like '%SMS_App_View (VW)%';


set foreign_key_checks = 1; 

commit;