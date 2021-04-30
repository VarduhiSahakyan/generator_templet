USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @customItemSetIdMOBILEAPP = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_MOBILE_APP');
SET @customItemSetIdOTPSMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS');
SET @pageType = 'APP_VIEW';

delete from Image where name like '%lbbw_%.png%';
delete from CustomItem where pageTypes = @pageType and fk_id_customItemSet in (@customItemSetIdMOBILEAPP, @customItemSetIdOTPSMS);

set foreign_key_checks = 1; 

commit;