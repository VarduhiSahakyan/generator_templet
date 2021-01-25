USE U5G_ACS_BO;

SET @customItemSet_PWD = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_PASSWORD_UNIFIED');

delete from CustomItem where fk_id_customItemSet = @customItemSet_PWD and pageTypes = 'APP_VIEW';

SET @customItemSet_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS_UNIFIED');

delete from CustomItem where fk_id_customItemSet = @customItemSet_SMS and pageTypes = 'APP_VIEW';


set @customPageLayoutDesc_PWD = 'PASSWORD_App_View (LBBW)';

set @pageType_appView = 'PASSWORD_APP_VIEW';

set @idAppViewPage_PWD = (select id from `CustomPageLayout` where `pageType` = @pageType_appView and DESCRIPTION = @customPageLayoutDesc_PWD);

SET @profileSetId = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_LBBW_01');


delete from CustomPageLayout_ProfileSet where customPageLayout_id in (@idAppViewPage_PWD) and profileSet_id = @profileSetId;

delete from CustomPageLayout where id = @idAppViewPage_PWD and pageType = @pageType_appView;

delete from CustomComponent where fk_id_layout = @idAppViewPage_PWD;