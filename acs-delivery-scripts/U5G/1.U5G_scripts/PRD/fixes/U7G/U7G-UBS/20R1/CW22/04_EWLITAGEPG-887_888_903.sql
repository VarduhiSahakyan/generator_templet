use U7G_ACS_BO;

set @authentMeansIDs = (select group_concat(id)
						from AuthentMeans
						where name not in ('REFUSAL', 'UNDEFINED', 'INFO', 'ACCEPT'));

set @customItemSetIDs = (select group_concat(fk_id_customItemSetCurrent)
						 from Profile
						 where find_in_set(fk_id_AuthentMeans, @authentMeansIDs));
start transaction;
delete
from CustomItem
where find_in_set(fk_id_customItemSet, @customItemSetIDs)
  and pageTypes = 'REFUSAL_PAGE';
commit;

set @ruleIDs = (select group_concat(id order by id)
				from Rule
				where description not like '%_ACCEPT%' and description not like '%_DECLINE%');
set @ruleConditionIDs = (select group_concat(id order by id)
						 from RuleCondition
						 where find_in_set(fk_id_rule, @ruleIDs));


set @transactionStatusesIDs = (select group_concat(id)
							   from TransactionStatuses
							   where transactionStatusType in ('ALWAYS_ACCEPT', 'ALWAYS_DECLINE') and reversed = true);
start transaction;
delete
from Condition_TransactionStatuses
where find_in_set(id_condition, @ruleConditionIDs)
  and find_in_set(id_transactionStatuses, @transactionStatusesIDs);
commit;


/*===========================================INFO_TABLE======================================
This code fragment shows brief information about future elements that will be deleted, for example, you can see from which profile the current text will be deleted and so on ...

select CONCAT(SubIssuer.code, ' - ', SubIssuer.name) as Issuer,
	   info.profile_name,
	   info.text,
	   info.pageTypes,
	   info.text_code,
	   info.uniqeId
from SubIssuer,
	 (select Profile.fk_id_subIssuer,
			 Profile.name      as profile_name,
			 deleteItems.value as text,
			 deleteItems.pageTypes,
			 deleteItems.name  as text_code,
			 deleteItems.id    as uniqeId
	  from Profile,
		   (select CustomItem.fk_id_customItemSet,
				   CustomItem.value,
				   CustomItem.pageTypes,
				   CustomItem.name,
				   CustomItem.id
			from CustomItem,
				 (select fk_id_customItemSetCurrent
				  from Profile,
					   (select id
						from AuthentMeans
						where name not in ('REFUSAL', 'UNDEFINED', 'INFO', 'ACCEPT')) authentMeansIDs
				  where fk_id_AuthentMeans = authentMeansIDs.id) as customItemSetIDs
			where fk_id_customItemSet = customItemSetIDs.fk_id_customItemSetCurrent
			  and pageTypes = 'REFUSAL_PAGE') as deleteItems
	  where fk_id_customItemSetCurrent = deleteItems.fk_id_customItemSet) as info
where id = info.fk_id_subIssuer
order by SubIssuer.name;
===========================================END_OF_INFO_TABLE======================================*/