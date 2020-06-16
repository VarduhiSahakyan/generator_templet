USE `U5G_ACS_BO`;

SET @createdBy = 'InitPhase';
SET @issuerCode = '00070';

SET @idCustomItemSet = (SELECT id from `CustomItemSet` where `description` = 'customitemset_00070_1_REFUSAL_Current');

UPDATE `CustomItem` SET `value` = 'Your Mastercard SecureCode™ authentication has failed.' WHERE `ordinal` = 1 and `pageTypes` = 'REFUSAL_PAGE' and `locale`='en' and `name`='MASTERCARD_REFUSAL_REFUSAL_PAGE_1_en' and `fk_id_customItemSet` = @idCustomItemSet;	
UPDATE `CustomItem` SET `value` = 'Help Page' WHERE `ordinal` = 41 and `pageTypes` = 'REFUSAL_PAGE' and `locale`='en' and `name`='MASTERCARD_REFUSAL_REFUSAL_PAGE_41_en' and `fk_id_customItemSet` = @idCustomItemSet;
UPDATE `CustomItem` SET `value` = 'Your Mastercard SecureCode™ authentication has failed.' WHERE `ordinal` = 23 and `pageTypes` = 'REFUSAL_PAGE' and `locale`='en' and `name`='MASTERCARD_REFUSAL_REFUSAL_PAGE_23' and `fk_id_customItemSet` = @idCustomItemSet;

