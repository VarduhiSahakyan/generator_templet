USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @idAppViewPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_EXT_APP_VIEW' and DESCRIPTION = 'MOBILE_APP_EXT_App_View (Consors)') ;
SET @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_16900_01');


delete from CustomPageLayout_ProfileSet where customPageLayout_id =@idAppViewPage and profileSet_id =@profileSetId;
delete from CustomComponent where fk_id_layout = @idAppViewPage;
delete from CustomPageLayout where pageType like '%MOBILE_APP_EXT_APP_VIEW%' and description like '%MOBILE_APP_EXT_App_View (Consors)%';


set foreign_key_checks = 1; 

commit;