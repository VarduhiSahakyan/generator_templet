USE `U5G_ACS_BO`;

SET @createdBy = 'A758582';

SET @BankUB = '16900';
SET @helpPageType ='HELP_PAGE';
SET @refusalCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_1_REFUSAL'));

DELETE FROM `CustomItem` WHERE pageTypes = @helpPageType and fk_id_customItemSet = @refusalCustomItemSet;