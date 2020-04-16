use `U5G_ACS_BO`;

start transaction;
set @masterOld ='Mastercard SecureCode';
set @masterNew ='Mastercard Identity Check';
set @visaOld ='Verified by Visa';
set @visaNew ='VisaSecure';
update CustomItem
set value = replace(replace(value, @masterOld, @masterNew), @visaOld, @visaNew)
where fk_id_customItemSet in (select id from CustomItemSet where name like 'customitemset_20000_%')
  and (value like CONCAT('%',@visaOld,'%') or value like CONCAT('%',@masterOld,'%'))
  and pageTypes = 'HELP_PAGE'
  and DTYPE = 'T';

commit;