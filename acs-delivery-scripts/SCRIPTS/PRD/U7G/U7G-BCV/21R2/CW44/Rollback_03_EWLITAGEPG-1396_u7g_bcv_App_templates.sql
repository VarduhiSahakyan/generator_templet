use `U7G_ACS_BO`;
SET @bank = 'BCV';

delete from CustomPageLayout where DESCRIPTION like CONCAT('%(', @bank, ')%');
