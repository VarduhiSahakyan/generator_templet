USE U7G_ACS_BO;
SET @BankB = 'UBS';
SET @BankUB = 'UBS';
SET @subIssuerCode = '23000';
SET @subIssuerNameAndLabel = 'UBS Switzerland AG';
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);



/********* Refusal Missing Profile *********/
SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB, '_DEFAULT_REFUSAL'));
DELETE FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetRefusal;


SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));
SET @profileRefusalFraud = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REFUSAL_FRAUD'));

UPDATE `Rule` SET `fk_id_profile` = @profileRefusalFraud WHERE `description` = 'REFUSAL_DEFAULT'
                                                           AND `name` = 'REFUSAL (DEFAULT)'
                                                           AND fk_id_profile = @profileRefusal;



DELETE FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuerID
                        AND `description` = 'REFUSAL (DEFAULT)'
                        AND `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL')
                        AND `fk_id_customItemSetCurrent` = @customItemSetRefusal;

DELETE FROM `CustomItemSet` WHERE id = @customItemSetRefusal;



SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'));
UPDATE `Profile` SET `description` = 'REFUSAL (DEFAULT)',
                     `name`= CONCAT(@BankUB,'_DEFAULT_REFUSAL')
                WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud
                  AND `name` = CONCAT(@BankUB,'_REFUSAL_FRAUD');

UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'),
                         `description` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current')
                        WHERE `name` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD');

