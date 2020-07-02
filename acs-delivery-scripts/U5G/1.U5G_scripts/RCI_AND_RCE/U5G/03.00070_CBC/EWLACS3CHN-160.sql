USE `U5G_ACS_BO`;

SET @createdBy = 'A758582';
SET @issuerCode = '00070';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_00070_SMS' AND `versionNumber` = '2');
SET @pageType = 'REFUSAL_PAGE';


update CustomItem
set name      = replace(name, '_ALL_1_en', concat('_', @pageType, '_1_en')),
	pageTypes = @pageType
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'ALL'
  and ordinal = 1
  and name like '%MASTERCARD_OTP_SMS_ALL_1_en%'
  and DTYPE = 'T';

update CustomItem
set name      = replace(name, '_ALL_2_en', concat('_', @pageType, '_2_en')),
	pageTypes = @pageType
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'ALL'
  and ordinal = 2
  and name like '%MASTERCARD_OTP_SMS_ALL_2_en%'
  and DTYPE = 'T';

update CustomItem
set name      = replace(name, '_ALL_20_en', concat('_', @pageType, '_20_en')),
	pageTypes = @pageType
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'ALL'
  and ordinal = 20
  and name like '%MASTERCARD_OTP_SMS_ALL_20_en%'
  and DTYPE = 'T';

update CustomItem
set name      = replace(name, '_ALL_22_en', concat('_', @pageType, '_22_en')),
	pageTypes = @pageType,
	value = 'Payment refused'
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'ALL'
  and ordinal = 22
  and name like '%MASTERCARD_OTP_SMS_ALL_22_en%'
  and DTYPE = 'T';

update CustomItem
set name      = replace(name, '_ALL_23_en', concat('_', @pageType, '_23_en')),
	pageTypes = @pageType,
	value = 'Your payment with Mastercard SecureCode™ is refused!'
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'ALL'
  and ordinal = 23
  and name like '%MASTERCARD_OTP_SMS_ALL_23_en%'
  and DTYPE = 'T';

update CustomItem
set name      = replace(name, '_ALL_40_en', concat('_', @pageType, '_40_en')),
	pageTypes = @pageType
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'ALL'
  and ordinal = 40
  and name like '%MASTERCARD_OTP_SMS_ALL_40_en%'
  and DTYPE = 'T';

update CustomItem
set name      = replace(name, '_ALL_41_en', concat('_', @pageType, '_41_en')),
	pageTypes = @pageType
where fk_id_customItemSet = @customItemSetSMS
  and pageTypes = 'ALL'
  and ordinal = 41
  and name like '%MASTERCARD_OTP_SMS_ALL_41_en%'
  and DTYPE = 'T';