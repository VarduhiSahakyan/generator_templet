use U7G_ACS_BO;
set @issuerCode = '41001';
set @customPageLayoutDesc_appView_Password = 'App_View OTP_SMS_PWD_OTP (SWISSKEY)';

set @pageType_Password = 'OTP_SMS_APP_VIEW';


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
						   where `pageType` in (@pageType_Password)
							 and DESCRIPTION in
								 (@customPageLayoutDesc_appView_Password));

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