USE `U5G_ACS_BO`;

SET @updateBy = 'A707825';
SET @BankUB = 'EWB';

START TRANSACTION;
UPDATE CustomItem
SET value = REPLACE(value, 'Verified by Visa', 'Visa Secure')
WHERE fk_id_customItemSet IN (SELECT id
							  FROM `CustomItemSet`
							  WHERE `name` IN (CONCAT('customitemset_', @BankUB, '_1_REFUSAL'),
											   CONCAT('customitemset_', @BankUB, '_SMS')))
  AND value LIKE '%Verified by Visa%'
  AND DTYPE = 'T';

COMMIT;