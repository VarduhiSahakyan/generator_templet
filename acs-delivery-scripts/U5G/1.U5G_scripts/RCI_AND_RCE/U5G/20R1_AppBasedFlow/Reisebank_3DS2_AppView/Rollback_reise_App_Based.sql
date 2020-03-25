USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 


SET @customItemSetIdOTPSMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_12000_REISEBANK_SMS_01');

SET @pageType = 'APP_VIEW';

delete from Image where name like '%reise_%.png%';
delete from CustomItem where pageTypes = @pageType and fk_id_customItemSet in (@customItemSetIdOTPSMS);

set foreign_key_checks = 1; 

commit;