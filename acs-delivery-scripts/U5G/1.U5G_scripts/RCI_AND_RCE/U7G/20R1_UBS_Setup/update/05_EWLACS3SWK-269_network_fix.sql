use U7G_ACS_BO;

start transaction;
update CustomItem
set fk_id_network = null
where fk_id_customItemSet in (select id
							  from CustomItemSet
							  where name in ('customitemset_UBS_SMS', 'customitemset_UBS_MOBILE_APP_EXT',
											 'customitemset_UBS_DEFAULT_REFUSAL',
											 'customitemset_UBS_MISSING_AUTHENTICATION_REFUSAL'))
  and ordinal = 174
  and DTYPE = 'T';

commit;