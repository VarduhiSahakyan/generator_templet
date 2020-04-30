USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @idAppViewPagePassword=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'PASSWORD_APP_VIEW' and DESCRIPTION = 'PASSWORD_APP_VIEW (COB)');
SET @idAppViewPageSMS=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_SMS_APP_VIEW' and DESCRIPTION = 'SMS_App_View (COB)') ;
SET @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_COB_01');


delete from CustomPageLayout_ProfileSet where customPageLayout_id in(@idAppViewPageSMS,@idAppViewPagePassword) and profileSet_id =@profileSetId;
delete from CustomComponent where fk_id_layout in (@idAppViewPageSMS,@idAppViewPagePassword);

delete from CustomPageLayout where pageType like '%OTP_SMS_APP_VIEW%' and description like '%SMS_App_View (COB)%';
delete from CustomPageLayout where pageType like '%PASSWORD_APP_VIEW%' and description like '%PASSWORD_APP_VIEW (COB)%';


set foreign_key_checks = 1; 

commit;