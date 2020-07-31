use U7G_ACS_BO;
set @BankUB = 'LLB';
set @pageType = 'EXT_PASSWORD_APP_VIEW';
set @customPageLayoutDesc_appView = 'EXT_PASSWORD_App_View (ING)';
set @profileSetName = concat('PS_', @BankUB, '_01');
set @profileSetID = (select group_concat(id)
				   from `ProfileSet`
				   where `name` = @profileSetName);

set @customPageLayoutID = (select group_concat(id)
						   from `CustomPageLayout`
						   where `pageType` in (@pageType)
							 and DESCRIPTION in
								 (@customPageLayoutDesc_appView));

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
