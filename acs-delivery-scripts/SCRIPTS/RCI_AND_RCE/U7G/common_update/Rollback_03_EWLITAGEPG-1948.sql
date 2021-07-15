USE U7G_ACS_BO;

SET @BankUB = 'ZKB';
SET @refusalPageType = 'REFUSAL_PAGE';
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));

UPDATE `CustomItem` SET `value` = 'Aus Sicherheitsgründen wurde Ihre Transaktion nicht ausgeführt. Ihre Karte wurde nicht belastet.'
WHERE `ordinal` = 230 AND
      `fk_id_customItemSet` = @customItemSetREFUSAL AND
      `locale` = 'de' AND
      `pageTypes` = @refusalPageType;

UPDATE `CustomItem` SET `value` = 'For security reasons, your transaction was not completed and your card not debited.'
WHERE `ordinal` = 230 AND
      `fk_id_customItemSet` = @customItemSetREFUSAL AND
      `locale` = 'en' AND
      `pageTypes` = @refusalPageType;

UPDATE `CustomItem` SET `value` = 'Pour des raisons de sécurité, votre transaction n''a pas été exécutée. Votre carte n''a pas été débitée.'
WHERE `ordinal` = 230 AND
      `fk_id_customItemSet` = @customItemSetREFUSAL AND
      `locale` = 'fr' AND
      `pageTypes` = @refusalPageType;

UPDATE `CustomItem` SET `value` = 'Per ragioni di sicurezza, la tua transazione non è stata eseguita. La sua carta non è stata addebitata.'
WHERE `ordinal` = 230 AND
      `fk_id_customItemSet` = @customItemSetREFUSAL AND
      `locale` = 'it' AND
      `pageTypes` = @refusalPageType;


SET @BankUB = 'RCH';
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));

UPDATE `CustomItem` SET `value` = 'Aus Sicherheitsgründen wurde Ihre Transaktion nicht ausgeführt. Ihre Karte wurde nicht belastet.'
WHERE `ordinal` = 230 AND
      `fk_id_customItemSet` = @customItemSetREFUSAL AND
      `locale` = 'de' AND
      `pageTypes` = @refusalPageType;

UPDATE `CustomItem` SET `value` = 'For security reasons, your transaction was not completed and your card not debited.'
WHERE `ordinal` = 230 AND
      `fk_id_customItemSet` = @customItemSetREFUSAL AND
      `locale` = 'en' AND
      `pageTypes` = @refusalPageType;

UPDATE `CustomItem` SET `value` = 'Pour des raisons de sécurité, votre transaction n''a pas été exécutée. Votre carte n''a pas été débitée.'
WHERE `ordinal` = 230 AND
      `fk_id_customItemSet` = @customItemSetREFUSAL AND
      `locale` = 'fr' AND
      `pageTypes` = @refusalPageType;

UPDATE `CustomItem` SET `value` = 'Per ragioni di sicurezza, la tua transazione non è stata eseguita. La sua carta non è stata addebitata.'
WHERE `ordinal` = 230 AND
      `fk_id_customItemSet` = @customItemSetREFUSAL AND
      `locale` = 'it' AND
      `pageTypes` = @refusalPageType;