use U5G_ACS_BO;
set @createdBy = 'A707825';
set @customItemSetSms = (select id
						 from `CustomItemSet`
						 where `name` = 'customitemset_12000_REISEBANK_SMS_01');

start transaction;

set @locale = 'de';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I',@createdBy,NOW(),NULL,NULL,NULL,'Mastercard Logo','PUSHED_TO_CONFIG',@locale,254,'APP_VIEW','MC_SMALL_LOGO',n.id,im.id,@customItemSetSms
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I',
		 @createdBy,NOW(),NULL,NULL,NULL,'Mastercard Logo','PUSHED_TO_CONFIG',@locale,255,'APP_VIEW','MC_MEDIUM_LOGO',n.id,im.id,@customItemSetSms
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I',
		 @createdBy,NOW(),NULL,NULL,NULL,'Mastercard Logo','PUSHED_TO_CONFIG',@locale,256,'APP_VIEW','MC_LARGE_LOGO',n.id,im.id,@customItemSetSms
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';

set @locale = 'en';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I',@createdBy,NOW(),NULL,NULL,NULL,'Mastercard Logo','PUSHED_TO_CONFIG',@locale,254,'APP_VIEW','MC_SMALL_LOGO',n.id,im.id,@customItemSetSms
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I',
		 @createdBy,NOW(),NULL,NULL,NULL,'Mastercard Logo','PUSHED_TO_CONFIG',@locale,255,'APP_VIEW','MC_MEDIUM_LOGO',n.id,im.id,@customItemSetSms
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I',
		 @createdBy,NOW(),NULL,NULL,NULL,'Mastercard Logo','PUSHED_TO_CONFIG',@locale,256,'APP_VIEW','MC_LARGE_LOGO',n.id,im.id,@customItemSetSms
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';

commit;