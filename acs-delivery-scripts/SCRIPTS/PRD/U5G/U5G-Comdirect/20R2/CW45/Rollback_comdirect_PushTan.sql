use `U5G_ACS_BO`;

start transaction;

set foreign_key_checks = 0;


set @customItemSetIdApp = (select id from CustomItemSet where name = 'customitemset_16600_APP_1');

set @pageType = 'APP_VIEW';

delete from CustomItem where pageTypes = @pageType and fk_id_customItemSet = @customItemSetIdApp;

set foreign_key_checks = 1;

commit;