use U7G_ACS_BO;

set @BankUB = 'UBS';
set @createdBy = 'A707825';

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetINFORefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));

start transaction;

delete from CustomItem
where ordinal in (174, 175)
	and fk_id_customItemSet in (@customItemSetRefusal, @customItemSetMOBILEAPP, @customItemSetSMS, @customItemSetINFORefusal)
	and DTYPE = 'T' and createdBy = @createdBy;

commit;