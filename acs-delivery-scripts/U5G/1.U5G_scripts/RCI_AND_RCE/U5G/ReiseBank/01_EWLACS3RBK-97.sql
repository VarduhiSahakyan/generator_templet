use U5G_ACS_BO;
set @createdBy = 'A707825';
set @issuerId = (select id
				 from Issuer
				 where code = '10300');
set @customItemSetSms = (select id
						 from `CustomItemSet`
						 where `name` = 'customitemset_12000_REISEBANK_SMS_01');

start transaction;

insert into `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
values ('T', @createdBy, NOW(), null, null, null, 'VISA_OTP_SMS_OTP_FORM_PAGE_34_de', 'PUSHED_TO_CONFIG',
		'de', 34, 'OTP_FORM_PAGE', 'SMS wird versendet.', null, null, @customItemSetSms),
	   ('T', @createdBy, NOW(), null, null, null, 'VISA_OTP_SMS_OTP_FORM_PAGE_35_de', 'PUSHED_TO_CONFIG',
		'de', 35, 'OTP_FORM_PAGE',
		'Bitte haben Sie einen kleinen Moment Geduld. Sie werden in Kürze eine SMS erhalten.', null, null,
		@customItemSetSms),
	   ('T', @createdBy, NOW(), null, null, null, 'VISA_OTP_SMS_OTP_FORM_PAGE_34_en', 'PUSHED_TO_CONFIG',
		'en', 34, 'OTP_FORM_PAGE', 'Sending SMS.', null, null, @customItemSetSms),
	   ('T', @createdBy, NOW(), null, null, null, 'VISA_OTP_SMS_OTP_FORM_PAGE_35_en', 'PUSHED_TO_CONFIG',
		'en', 35, 'OTP_FORM_PAGE', 'Please wait. You will receive a new one-time passcode.', null, null,
		@customItemSetSms);

update CustomItem
set value          = '<span class="fa fa-refresh" aria-hidden="true"> </span>request new mTAN',
	lastUpdateBy   = @createdBy,
	lastUpdateDate = now()
where fk_id_customItemSet = @customItemSetSms
  and ordinal = 4
  and locale = 'en';

update SubIssuer
set dateFormat     = 'DD.MM.YYYY HH:mm|CET',
	lastUpdateBy   = @createdBy,
	lastUpdateDate = now()
where fk_id_issuer = @issuerId;

commit;