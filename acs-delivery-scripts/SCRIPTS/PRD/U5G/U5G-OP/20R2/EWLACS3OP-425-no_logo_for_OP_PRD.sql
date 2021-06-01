USE U5G_ACS_BO;

DELETE FROM CustomItem where fk_id_customItemSet IN (SELECT id FROM `CustomItemSet` where `name` IN ('customitemset_20000_OPENID_NORMAL_01', 'customitemset_20000_OPENID_CHOICE_01')) and DTYPE='I' and ordinal=1 and fk_id_image IN (SELECT i.id FROM `Image` i WHERE i.name IN ('op_large.png','op_medium.png','op_small.png','OPOPID_Logo'));
