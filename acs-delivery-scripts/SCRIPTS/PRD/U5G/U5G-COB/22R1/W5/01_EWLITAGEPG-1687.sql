USE U5G_ACS_BO;
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_SMS');
SET @customItemSetPWD = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_PASSWORD');
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');

UPDATE `CustomItem` set `locale` = 'en' WHERE `fk_id_customItemSet` in (@customItemSetSMS, @customItemSetPWD) AND
                                              `fk_id_network` = @MaestroVID AND
                                              `pageTypes` = 'MESSAGE_BODY';

UPDATE `CustomItem` set `fk_id_network` = NULL WHERE `fk_id_customItemSet` in (@customItemSetSMS, @customItemSetPWD) AND
                                                     `pageTypes` = 'MESSAGE_BODY';