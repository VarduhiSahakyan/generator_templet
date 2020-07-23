USE U5G_ACS_BO;


SET @BankB = 'OP';
SET @Banklb = LOWER(@BankB);

set foreign_key_checks = 0;
# remove CustomItems
SET @pageType = 'APP_VIEW_LANGUAGE_SELECT';
set @customItemsIds = (select group_concat(id)
                 from `CustomItemSet`
                 where name in ('customitemset_20000_MOBILE_APP_01'));

delete from CustomItem where pageTypes = @pageType and find_in_set(fk_id_customItemSet, @customItemsIds);


#remove template for language choice
set @issuerCode = '20000';

SET @customPageLayoutDesc_appView = 'LANGUAGE_Choice_App_View (OP)';

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
						   where `pageType` in (@pageType_LANGUAGE_SELECT)
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


UPDATE `SubIssuer` SET `displayLanguageSelectPage` = false WHERE `code` = '20000';

set foreign_key_checks = 1;