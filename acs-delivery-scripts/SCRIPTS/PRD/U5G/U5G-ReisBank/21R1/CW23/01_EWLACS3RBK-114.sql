USE U5G_ACS_BO;

# RBK-114
SET @locale = 'en';
SET @username = 'W100851';
SET @customItemSet_LBBW_OTP_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_12000_REISEBANK_SMS_01');
SET @pageType_OTP_FORM_PAGE ='OTP_FORM_PAGE';

SET @text = 'The SMS authentication will no longer be supported and therefore will be switched off. To continue using
Mastercard® Identity Check™ and to be able to make payments on the Internet please register for the RBMC Secure App.
You can download the RBMC Secure App free of charge from the App Store and Google Play.';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND	 `ordinal` = 3
					AND `pageTypes` = @pageType_OTP_FORM_PAGE
					AND `fk_id_customItemSet` = @customItemSet_LBBW_OTP_SMS;

SET @locale = 'de';
SET @text = 'Die Authentifizierung per SMS wird in Kürze nicht mehr unterstützt und daher abgeschaltet. Um Mastercard®
Identity Check™ weiterhin zu nutzen und Zahlungen im Internet durchführen zu können, registrieren Sie sich bitte umgehend
für die RBMC Secure App. Die RBMC Secure App können Sie kostenfrei im App Store und bei Google Play herunterladen.';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND	 `ordinal` = 3
					AND `pageTypes` =@pageType_OTP_FORM_PAGE
					AND `fk_id_customItemSet` = @customItemSet_LBBW_OTP_SMS;

