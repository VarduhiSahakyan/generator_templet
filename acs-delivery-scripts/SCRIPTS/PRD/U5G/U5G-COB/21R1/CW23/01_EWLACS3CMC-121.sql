USE U5G_ACS_BO;

SET @cisCOBRefusal = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_1_REFUSAL');
SET @cisCOBPassword = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_PASSWORD');
SET @cisCOBInfo = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_MISSING_AUTHENT_REFUSAL');

SET @cisCOZRefusal = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_1_REFUSAL');
SET @cisCOZSms = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_SMS');
SET @cisCOZInfo = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_MISSING_AUTHENT_REFUSAL');


UPDATE `CustomItem` SET `value` = 'SMS gesendet an' WHERE fk_id_customItemSet in (@cisCOBRefusal,
                                                                                  @cisCOBPassword,
                                                                                  @cisCOBInfo,
                                                                                  @cisCOZRefusal,
                                                                                  @cisCOZSms,
                                                                                  @cisCOZInfo) AND
                                                          `ordinal` = 104 AND
                                                          `pageTypes` = 'ALL';