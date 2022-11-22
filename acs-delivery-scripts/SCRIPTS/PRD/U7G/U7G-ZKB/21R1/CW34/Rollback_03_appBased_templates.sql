use `U7G_ACS_BO`;
SET @BankB = 'ZKB';

delete from CustomPageLayout where DESCRIPTION like CONCAT('%(', @BankB, ')%');
