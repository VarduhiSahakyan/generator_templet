USE U5G_ACS_BO;
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_SMS');
SET @customItemSetPWD = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_PASSWORD');
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');

UPDATE `CustomItem` set `fk_id_network` = @MaestroVID WHERE `fk_id_customItemSet` in (@customItemSetSMS, @customItemSetPWD) AND
                                              `locale` = 'en' AND
                                              `pageTypes` = 'MESSAGE_BODY';

UPDATE `CustomItem` set `fk_id_network` = @MaestroMID WHERE `fk_id_customItemSet` in (@customItemSetSMS, @customItemSetPWD) AND
                                              `locale` = 'de' AND
                                              `pageTypes` = 'MESSAGE_BODY';

UPDATE `CustomItem` set `locale` = 'de' WHERE `fk_id_customItemSet` in (@customItemSetSMS, @customItemSetPWD) AND
                                                     `pageTypes` = 'MESSAGE_BODY';