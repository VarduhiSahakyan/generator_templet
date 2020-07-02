USE `U5G_ACS_BO`;

SET @createdBy = 'A758582';
SET @issuerCode = '00070';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_00070_SMS' AND `versionNumber` = '2');
SET @pageType = 'ALL';


update CustomItem
set name      = replace(name, '_REFUSAL_PAGE_1_en', '_ALL_1_en'),
	pageTypes = @pageType
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'REFUSAL_PAGE'
  and ordinal = 1
  and name like '%MASTERCARD_OTP_SMS_REFUSAL_PAGE_1_en%'
  and DTYPE = 'T';

update CustomItem
set name      = replace(name, '_REFUSAL_PAGE_2_en', '_ALL_2_en'),
	pageTypes = @pageType
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'REFUSAL_PAGE'
  and ordinal = 2
  and name like '%MASTERCARD_OTP_SMS_REFUSAL_PAGE_2_en%'
  and DTYPE = 'T';

update CustomItem
set name      = replace(name, '_REFUSAL_PAGE_20_en', '_ALL_20_en'),
	pageTypes = @pageType
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'REFUSAL_PAGE'
  and ordinal = 20
  and name like '%MASTERCARD_OTP_SMS_REFUSAL_PAGE_20_en%'
  and DTYPE = 'T';

update CustomItem
set name      = replace(name, '_REFUSAL_PAGE_22_en', '_ALL_22_en'),
	pageTypes = @pageType
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'REFUSAL_PAGE'
  and ordinal = 22
  and name like '%MASTERCARD_OTP_SMS_REFUSAL_PAGE_22_en%'
  and DTYPE = 'T';

update CustomItem
set name      = replace(name, '_REFUSAL_PAGE_23_en', '_ALL_23_en'),
	pageTypes = @pageType
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'REFUSAL_PAGE'
  and ordinal = 23
  and name like '%MASTERCARD_OTP_SMS_REFUSAL_PAGE_23_en%'
  and DTYPE = 'T';

update CustomItem
set name      = replace(name, '_REFUSAL_PAGE_40_en', '_ALL_40_en'),
	pageTypes = @pageType
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'REFUSAL_PAGE'
  and ordinal = 40
  and name like '%MASTERCARD_OTP_SMS_REFUSAL_PAGE_40_en%'
  and DTYPE = 'T';

update CustomItem
set name      = replace(name, '_REFUSAL_PAGE_41_en', '_ALL_41_en'),
	pageTypes = @pageType
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'REFUSAL_PAGE'
  and ordinal = 41
  and name like '%MASTERCARD_OTP_SMS_REFUSAL_PAGE_41_en%'
  and DTYPE = 'T';