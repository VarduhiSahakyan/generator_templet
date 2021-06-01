use U5G_ACS_BO;
set @issuerId = (select id
				 from Issuer
				 where code = '10300');
set @customItemSetSms = (select id
						 from `CustomItemSet`
						 where `name` = 'customitemset_12000_REISEBANK_SMS_01');
set @networkId = (select id
				  from Network
				  where code = 'MASTERCARD');

start transaction;
delete
from CustomItem
where DTYPE = 'I'
  and name = 'Mastercard Logo'
  and ordinal in (254, 255, 256)
  and pageTypes = 'APP_VIEW'
  and locale in ('de', 'en')
  and fk_id_network = @networkId
  and fk_id_customItemSet = @customItemSetSms;
commit;