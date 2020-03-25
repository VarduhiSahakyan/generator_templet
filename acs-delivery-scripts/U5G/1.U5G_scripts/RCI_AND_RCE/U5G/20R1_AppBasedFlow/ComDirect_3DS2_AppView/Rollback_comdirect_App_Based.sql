USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 


SET @customItemSetIdOTPSMS1 = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_16600_SMS_1');
SET @customItemSetIdOTPSMS2 = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_16600_SMS_2');

SET @pageType = 'APP_VIEW';

delete from Image where name like '%comdirect_%.png%';
delete from CustomItem where pageTypes = @pageType and fk_id_customItemSet in (@customItemSetIdOTPSMS1,customItemSetIdOTPSMS2);

set foreign_key_checks = 1; 

commit;