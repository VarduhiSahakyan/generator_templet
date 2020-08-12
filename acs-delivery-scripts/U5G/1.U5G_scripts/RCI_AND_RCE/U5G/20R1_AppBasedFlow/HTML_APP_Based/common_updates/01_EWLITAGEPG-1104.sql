USE U5G_ACS_BO;

SET @idAppViewPage = (SELECT group_concat(id)
                      FROM `CustomPageLayout`
                      WHERE `pageType` LIKE ('%APP_VIEW%'));

UPDATE `CustomComponent` cc SET cc.value = replace(cc.value, 'white-space: normal;', '') WHERE find_in_set(fk_id_layout, @idAppViewPage);
UPDATE `CustomComponent` cc SET cc.value = replace(cc.value, 'white-space: pre-wrap;', '') WHERE find_in_set(fk_id_layout, @idAppViewPage);