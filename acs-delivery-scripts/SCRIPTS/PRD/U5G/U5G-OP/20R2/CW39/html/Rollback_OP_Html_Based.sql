USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @idAppViewPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_EXT_APP_VIEW' and DESCRIPTION = 'MOBILE_APP_EXT_App_View (OP)') ;
SET @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_20000_SMS_OP');


delete from CustomPageLayout_ProfileSet where customPageLayout_id =@idAppViewPage and profileSet_id =@profileSetId;
delete from CustomComponent where fk_id_layout = @idAppViewPage;
delete from CustomPageLayout where pageType like '%MOBILE_APP_EXT_APP_VIEW%' and description like '%MOBILE_APP_EXT_App_View (OP)%';


set foreign_key_checks = 1; 

commit;