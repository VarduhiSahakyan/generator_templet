USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @idAppViewPagePassword=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'PASSWORD_APP_VIEW' and DESCRIPTION = 'PASSWORD_APP_VIEW (FBK)');
SET @idAppViewPageSMS=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_SMS_APP_VIEW' and DESCRIPTION = 'SMS_App_View (FBK)') ;
SET @idAppViewPageTA=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_APP_VIEW' and DESCRIPTION = 'MOBILE_APP_APP_VIEW (FBK)') ;
SET @idAppViewPageCHOICE=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'UNDEFINED_APP_VIEW' and DESCRIPTION = 'Choice_App_View (FBK)') ;
SET @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_18502_PB_01');


delete from CustomPageLayout_ProfileSet where customPageLayout_id in(@idAppViewPageSMS,@idAppViewPageTA,@idAppViewPagePassword,@idAppViewPageCHOICE) and profileSet_id =@profileSetId;
delete from CustomComponent where fk_id_layout in (@idAppViewPageSMS,@idAppViewPageTA,@idAppViewPagePassword,@idAppViewPageCHOICE);

delete from CustomPageLayout where pageType like '%OTP_SMS_APP_VIEW%' and description like '%SMS_App_View (FBK)%';
delete from CustomPageLayout where pageType like '%PASSWORD_APP_VIEW%' and description like '%PASSWORD_APP_VIEW (FBK)%';
delete from CustomPageLayout where pageType like '%MOBILE_APP_APP_VIEW%' and description like '%MOBILE_APP_APP_VIEW (FBK)%';
delete from CustomPageLayout where pageType like '%UNDEFINED_APP_VIEW%' and description like '%Choice_App_View (FBK)%';


set foreign_key_checks = 1; 

commit;