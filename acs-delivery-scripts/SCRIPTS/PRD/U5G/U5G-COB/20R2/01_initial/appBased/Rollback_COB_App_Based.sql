USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @customItemSetIdOTPSMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_COB_SMS');
SET @customItemSetIdPSWD = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_COB_PASSWORD');
SET @pageType = 'APP_VIEW';

delete from Image where name like '%cob_%.png%';
delete from CustomItem where pageTypes = @pageType and fk_id_customItemSet in (@customItemSetIdOTPSMS, @customItemSetIdPSWD);

set foreign_key_checks = 1; 

commit;