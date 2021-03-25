USE U5G_ACS_BO;

SET @createdBy ='A709391';
SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @locale = 'de';
SET @currentAuthentMean = 'PASSWORD';
SET @pageType = 'ALL';

SET @customItemSet_LBBW_OTP_PASSWORD = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_PASSWORD_UNIFIED');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@pageType,'_104'), 'PUSHED_TO_CONFIG',
 'de', 104, @pageType, 'Mobilfunknummer', @MaestroVID, NULL, @customItemSet_LBBW_OTP_PASSWORD);


SET @customItemSet_LBBW_OTP_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS');

SET @ordinal = 104;
UPDATE `CustomItem` SET `value` = 'Mobilfunknummer'
WHERE `locale` = @locale
  AND  `ordinal` = @ordinal
  AND `pageTypes` = @pageType
  AND `fk_id_customItemSet` = @customItemSet_LBBW_OTP_SMS;
