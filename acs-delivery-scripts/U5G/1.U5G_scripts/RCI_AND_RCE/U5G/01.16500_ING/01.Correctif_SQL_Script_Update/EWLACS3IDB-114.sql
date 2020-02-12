USE `U5G_ACS_BO`;

set @subIssuerCode = '16500';

set @customITemSetPhotoTan= (SELECT `id` from `CustomItemSet` where `name`= 'customitemset_16500_PHOTO_TAN' );


SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @currentPageType = 'HELP_PAGE';
SET @locale = 'de';

UPDATE `CustomItem`
SET `value` = ''
WHERE `ordinal` = 1 and `pageTypes`= @currentPageType  and `locale` = @locale and `fk_id_customItemSet`= @customITemSetPhotoTan;


UPDATE `CustomItem`
SET `value` = 'VISA Secure ist ein zusätzliches Freigabeverfahren für sichere Einkäufe im Internet. Dafür arbeitet VISA Secure automatisch mit dem Freigabeverfahren, das Sie auch für unser Internetbanking gewählt haben.'
WHERE `ordinal` = 2 and `pageTypes`= @currentPageType  and `locale` = @locale and `fk_id_customItemSet`= @customITemSetPhotoTan;