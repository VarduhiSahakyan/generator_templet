USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @customItemSetIdMOBILEAPP = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_SPB_sharedBIN_MOBILE_APP_EXT');
SET @customItemSetIdMOBILEAPPChoice = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_SPB_sharedBIN_MOBILE_APP_EXT_CHOICE');
SET @customItemSetIdOTPSMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_SPB_sharedBIN_SMS');
SET @customItemSetIdOTPSMSChoice = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_SPB_sharedBIN_SMS_CHOICE');
SET @customItemSetIdPSWD = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_SPB_sharedBIN_PASSWORD');
SET @customItemSetIdAUTHENTMEANSCHOICE = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_SPB_sharedBIN_SMS_APP');
SET @pageType = 'APP_VIEW';

delete from Image where name like '%sparda%.png%';
delete from CustomItem where pageTypes = @pageType and fk_id_customItemSet in (@customItemSetIdMOBILEAPP, @customItemSetIdOTPSMS, @customItemSetIdPSWD,@customItemSetIdMOBILEAPPChoice,@customItemSetIdOTPSMSChoice);

delete from CustomItem where pageTypes = 'APP_VIEW_MEAN_SELECT' and fk_id_customItemSet in (@customItemSetIdAUTHENTMEANSCHOICE);

delete from CustomItem where pageTypes = 'APP_VIEW_DEVICE_SELECT' and fk_id_customItemSet in (@customItemSetIdMOBILEAPP,@customItemSetIdMOBILEAPPChoice);

set foreign_key_checks = 1; 

commit;