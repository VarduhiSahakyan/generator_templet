use U7G_ACS_BO;
set @issuerCode = '80808';
set @customPageLayoutDesc_appView_OTP_SMS = 'App_View OTP_SMS (RAIFFEISEN)';
set @customPageLayoutDesc_appView_MOBILE_APP = 'App_View TA (RAIFFEISEN)';
set @customPageLayoutDesc_appView_MOBILE_APP_EXT = 'App_View_EXT_App_View (RAIFFEISEN)';

set @pageType_OTP_SMS = 'OTP_SMS_EXT_MESSAGE_APP_VIEW';
set @pageType_MOBILE_APP = 'MOBILE_APP_APP_VIEW';
set @pageType_MOBILE_APP_EXT = 'MOBILE_APP_EXT_APP_VIEW';

set @profileSetID = (select group_concat(ProfileSet.id)
                     from `ProfileSet`,
                          (select SubIssuer.id
                           from `SubIssuer`,
                                (select Issuer.`id`
                                 from `Issuer`
                                 where `code` = @issuerCode) as issuer
                           where `fk_id_issuer` = issuer.id) as subissuers
                     where fk_id_subIssuer = subissuers.id);

set @customPageLayoutID = (select group_concat(id)
                           from `CustomPageLayout`
                           where `pageType` in (@pageType_OTP_SMS, @pageType_MOBILE_APP, @pageType_MOBILE_APP_EXT)
                             and DESCRIPTION in
                                 (@customPageLayoutDesc_appView_OTP_SMS, @customPageLayoutDesc_appView_MOBILE_APP, @customPageLayoutDesc_appView_MOBILE_APP_EXT));

start transaction;

delete
from `CustomPageLayout_ProfileSet`
where find_in_set(customPageLayout_id, @customPageLayoutID)
  and find_in_set(profileSet_id, @profileSetID);

delete
from `CustomComponent`
where find_in_set(`fk_id_layout`, @customPageLayoutID);

delete
from `CustomPageLayout`
where find_in_set(`id`, @customPageLayoutID);

commit;