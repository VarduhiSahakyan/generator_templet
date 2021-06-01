USE U5G_ACS_BO;

set @BankUB = 'BNP_WM';
set @updateBy = 'A757435';
start transaction;
update BinRange
set upperBound     = '4163698999',
	lastUpdateBy   = @updateBy,
	lastUpdateDate = now()
where fk_id_network = (select `id`
					   from `Network`
					   where `code` = 'VISA')
  and fk_id_profileSet = (select id
						  from `ProfileSet`
						  where `name` = CONCAT('PS_', @BankUB, '_01'));
commit;