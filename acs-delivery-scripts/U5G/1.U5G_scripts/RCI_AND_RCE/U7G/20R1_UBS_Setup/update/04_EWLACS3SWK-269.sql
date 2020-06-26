use U7G_ACS_BO;

set @pageType = 'OTP_FORM_PAGE';
start transaction;

update CustomItem
set name      = replace(name, '_ALL_174', concat('_', @pageType, '_174')),
	pageTypes = @pageType
where fk_id_customItemSet in (select id from CustomItemSet where name = 'customitemset_UBS_SMS')
  and pageTypes = 'ALL'
  and ordinal = 174
  and name like '%_OTP_SMS_EXT_MESSAGE_ALL_174'
  and DTYPE = 'T';

set @pageType = 'POLLING_PAGE';
update CustomItem
set name      = replace(name, '_ALL_174', concat('_', @pageType, '_174')),
	pageTypes = @pageType
where fk_id_customItemSet in (select id from CustomItemSet where name = 'customitemset_UBS_MOBILE_APP_EXT')
  and pageTypes = 'ALL'
  and ordinal = 174
  and name like '%_MOBILE_APP_EXT_ALL_174'
  and DTYPE = 'T';


set @pageType = 'REFUSAL_PAGE';
update CustomItem
set name      = replace(name, '_ALL_174', concat('_', @pageType, '_174')),
	pageTypes = @pageType
where fk_id_customItemSet in (select id
							  from CustomItemSet
							  where name in ('customitemset_UBS_DEFAULT_REFUSAL',
											 'customitemset_UBS_MISSING_AUTHENTICATION_REFUSAL'))
  and pageTypes = 'ALL'
  and ordinal = 174
  and name like '%VISA_REFUSAL_ALL_174'
  and DTYPE = 'T';

commit;