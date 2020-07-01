use U7G_ACS_BO;

set @BankUB = 'LUKB';

start transaction;
update BinRange
set upperBound     = '4395902099',
	lastUpdateBy   = null,
	lastUpdateDate = null
where fk_id_network = (select `id`
					   from `Network`
					   where `code` = 'VISA')
  and fk_id_profileSet = (select id
						  from `ProfileSet`
						  where `name` = CONCAT('PS_', @BankUB, '_01'));
commit;