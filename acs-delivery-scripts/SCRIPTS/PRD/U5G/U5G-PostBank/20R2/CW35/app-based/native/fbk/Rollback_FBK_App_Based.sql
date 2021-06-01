USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @customItemSetIdMOBILEAPP = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18502_PB_TA');
SET @customItemSetIdMOBILEAPPCHOICE = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18502_PB_TA_Choice');
SET @customItemSetIdOTPSMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18502_PB_SMS');
SET @customItemSetIdOTPSMSCHOICE = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18502_PB_SMS_Choice');
SET @customItemSetIdPSWD = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18502_PB_PASSWORD');
SET @customItemSetIdPSWDCHOICE = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18502_PB_PASSWORD_Choice');
SET @customItemSetIdAUTHENTMEANSCHOICE = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18502_PB_UNDEFINED');
SET @pageType = 'APP_VIEW';
SET @pageTypeMeans = 'APP_VIEW_MEAN_SELECT';

delete from Image where name like '%postbank_%.png%';
delete from CustomItem where pageTypes = @pageType and fk_id_customItemSet in (@customItemSetIdMOBILEAPP, @customItemSetIdOTPSMS, @customItemSetIdPSWD,@customItemSetIdPSWDCHOICE, @customItemSetIdMOBILEAPPCHOICE,@customItemSetIdOTPSMSCHOICE);

delete from CustomItem where pageTypes = @pageTypeMeans and fk_id_customItemSet in (@customItemSetIdAUTHENTMEANSCHOICE);


set foreign_key_checks = 1; 

commit;