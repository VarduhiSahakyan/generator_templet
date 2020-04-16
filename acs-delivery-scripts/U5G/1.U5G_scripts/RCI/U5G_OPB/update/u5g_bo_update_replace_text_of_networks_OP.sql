use `U5G_ACS_BO`;

start transaction;

update CustomItem
set value = replace(replace(value, 'Mastercard SecureCode', 'Mastercard Identity Check'), 'Verified by Visa', 'VisaSecure')
where fk_id_customItemSet in (select id from CustomItemSet where name like 'customitemset_20000_%')
  and (value like '%Verified by Visa%' or value like '%Mastercard SecureCode%')
  and pageTypes = 'HELP_PAGE'
  and DTYPE = 'T';

commit;