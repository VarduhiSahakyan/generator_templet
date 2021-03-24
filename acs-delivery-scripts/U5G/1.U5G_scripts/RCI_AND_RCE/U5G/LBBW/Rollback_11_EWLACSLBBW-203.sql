USE U5G_ACS_BO;

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_PASSWORD_UNIFIED');

SET @pageType = 'OTP_FORM_PAGE';

delete from CustomItem where fk_id_customItemSet = @customItemSetPassword and pageTypes = @pageType and ordinal in (28, 29);