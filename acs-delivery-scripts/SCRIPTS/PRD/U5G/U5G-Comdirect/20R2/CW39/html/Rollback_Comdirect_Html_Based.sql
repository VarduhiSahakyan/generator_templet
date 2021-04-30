USE `U5G_ACS_BO`;

set @customPageLayoutDesc_appView = 'App_View OTP_SMS (Comdirect)';
set @profileSetName = 'PS_Comdirect_01';
set @pageType = 'OTP_SMS_EXT_MESSAGE_APP_VIEW';

SET @profileSetID = (SELECT id FROM `ProfileSet` WHERE `name` = @profileSetName);

SET @customPageLayoutID = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageType and DESCRIPTION = @customPageLayoutDesc_appView) ;

DELETE FROM `CustomPageLayout_ProfileSet` WHERE customPageLayout_id = @customPageLayoutID and profileSet_id = @profileSetID;

DELETE FROM `CustomComponent` WHERE `fk_id_layout` = @customPageLayoutID;

DELETE FROM `CustomPageLayout` where `id` = @customPageLayoutID;


