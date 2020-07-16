USE `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0; 

SET @customItemSetIdMOBILEAPP = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_BNP_WM_MOBILE_APP_EXT');
SET @pageType = 'APP_VIEW';

delete from Image where name like '%bnp_wm_%.png%';
delete from CustomItem where pageTypes = @pageType and fk_id_customItemSet in (@customItemSetIdMOBILEAPP);

set foreign_key_checks = 1; 

commit;