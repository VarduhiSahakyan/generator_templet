USE U7G_ACS_BO;

SET @BankUB = 'ZKB';
SET @customItemSetMISSING = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @refusalPageType = 'REFUSAL_PAGE';

UPDATE `CustomItem` SET `value` = 'Le paiement n''a pas été effectué' WHERE `fk_id_customItemSet` = @customItemSetMISSING AND
                                                                            `locale` = 'fr' AND
                                                                            `ordinal` = 22 AND
                                                                            `pageTypes` = @refusalPageType;
