USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @customItemSetIdMOBILEAPP = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_16500_MOBILE_APP');
SET @customItemSetIdOTPSMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_16500_ING_SMS');
SET @customItemSetIdPSWD = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_16500_PASSWORD');
SET @pageType = 'APP_VIEW';
SET @pageTypeDevice = 'APP_VIEW_DEVICE_SELECT';

delete from Image where name like '%ing_%.png%';
delete from CustomItem where pageTypes = @pageType and fk_id_customItemSet in (@customItemSetIdMOBILEAPP, @customItemSetIdOTPSMS, @customItemSetIdPSWD);
delete from CustomItem where pageTypes = @pageTypeDevice and fk_id_customItemSet in (@customItemSetIdMOBILEAPP);

set foreign_key_checks = 1; 

commit;