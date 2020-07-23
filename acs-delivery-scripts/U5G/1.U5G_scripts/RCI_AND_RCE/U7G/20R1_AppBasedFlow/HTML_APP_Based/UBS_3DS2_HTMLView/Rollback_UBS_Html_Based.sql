use U7G_ACS_BO;
set @issuerCode = '23000';
set @customPageLayoutDesc_appView_OTP_SMS = 'App_View OTP_SMS (UBS)';
set @customPageLayoutDesc_appView_MOBILE_APP = 'App_View TA (UBS)';
SET @customPageLayoutDesc_appView = 'LANGUAGE_Choice_App_View (UBS)';

set @pageType_OTP_SMS = 'OTP_SMS_EXT_MESSAGE_APP_VIEW';
set @pageType_MOBILE_APP = 'MOBILE_APP_EXT_APP_VIEW';
set @pageType_LANGUAGE_SELECT = 'APP_VIEW_LANGUAGE_SELECT';

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
						   where `pageType` in (@pageType_OTP_SMS, @pageType_MOBILE_APP, @pageType_LANGUAGE_SELECT)
							 and DESCRIPTION in
								 (@customPageLayoutDesc_appView_OTP_SMS,
								  @customPageLayoutDesc_appView_MOBILE_APP,
								  @customPageLayoutDesc_appView));

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