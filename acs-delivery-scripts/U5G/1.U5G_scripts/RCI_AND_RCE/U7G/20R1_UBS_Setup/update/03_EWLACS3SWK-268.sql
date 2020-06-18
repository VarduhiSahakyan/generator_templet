use U7G_ACS_BO;
set @updateBy = 'A707825';
set @subIssuerNameAndLabel = 'UBS Switzerland AG';
set @subIssuerCode = '23000';
set @subIssuerID = (select id
					from `SubIssuer`
					where `code` = @subIssuerCode
					  and `name` = @subIssuerNameAndLabel);

set @customItemSets = (select group_concat(id)
					   from CustomItemSet
					   where fk_id_subIssuer = @subIssuerID);
start transaction;
update CustomItem
set value        = 'Nº di cell',
	lastUpdateBy = @updateBy,
    lastUpdateDate = now()
where find_in_set(fk_id_customItemSet, @customItemSets)
  and locale = 'it'
  and value = 'Numero di cellulare'
  and ordinal = 104
  and DTYPE = 'T';
commit;