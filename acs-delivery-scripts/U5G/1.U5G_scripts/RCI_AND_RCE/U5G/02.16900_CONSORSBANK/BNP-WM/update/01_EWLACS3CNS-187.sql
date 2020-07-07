USE `U5G_ACS_BO`;

SET @BankB = '16900';
SET @BankUB = 'BNP_WM';

SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @customItemSetPASSWORD = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'));
SET @currentPageType = 'OTP_FORM_PAGE';
SET @currentAuthentMean = 'EXT_PASSWORD';

UPDATE `CustomItem` SET `value` = 'Bitte bestätigen Sie Ihre Zahlung. Geben Sie dazu die <b>@challenge1</b> Stelle Ihrer 5-stelligen Online-PIN hintereinander und ohne Kommastellen ein.'
					WHERE `fk_id_customItemSet` = @customItemSetPASSWORD
					AND `name` = CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11')
					AND `locale` = 'de';