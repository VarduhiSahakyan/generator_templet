use U5G_ACS_BO;
set @issuerId = (select id
				 from Issuer
				 where code = '10300');
set @customItemSetSms = (select id
						 from `CustomItemSet`
						 where `name` = 'customitemset_12000_REISEBANK_SMS_01');
start transaction;
delete
from CustomItem
where DTYPE = 'T'
  and ordinal in (34, 35)
  and pageTypes = 'OTP_FORM_PAGE'
  and fk_id_customItemSet = @customItemSetSms;
update CustomItem
set value = '<span class="fa fa-refresh" aria-hidden="true"> </span>mTan neu anfordern'
where fk_id_customItemSet = @customItemSetSms
  and ordinal = 4
  and locale = 'en';

update SubIssuer
set dateFormat = 'lll|GMT'
where fk_id_issuer = @issuerId;

commit;