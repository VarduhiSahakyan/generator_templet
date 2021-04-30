use U7G_ACS_BO;

set @bannerTitleDE = 'Technischer Fehler';
set @bannerMessageDE = 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.';
set @bannerTitleEN = 'Technical error';
set @bannerMessageEN = 'A technical error has occurred and your purchase could not be made. Please try again later.';
set @bannerTitleFR = 'Erreur technique';
set @bannerMessageFR = 'Une erreur technique est survenue et votre achat n’a pas pu être finalisé. Veuillez réessayer.';
set @bannerTitleIT = 'Problema tecnico';
set @bannerMessageIT = 'Si è verificato un errore tecnico e il suo acquisto non può essere concluso. La preghiamo di riprovare più tardi.';

set @networkName = (select `name` from `Network` where `code` = 'VISA');

set @failurePageType = 'FAILURE_PAGE';
set @otpSmsAuthentMean = 'OTP_SMS_EXT_MESSAGE';
set @mobileAppAuthentMean = 'MOBILE_APP_EXT';

set @customItemSetSMS = (select id from CustomItemSet where name = 'customitemset_UBS_SMS');
set @customItemSetMobileApp = (select id from CustomItemSet where name = 'customitemset_UBS_MOBILE_APP_EXT');

start transaction;

update CustomItem set value = @bannerTitleDE, lastUpdateBy = null ,  lastUpdateDate = null where DTYPE = 'T'  and locale = 'de'  and ordinal = 32  and pageTypes = 'OTP_FORM_PAGE'  and fk_id_customItemSet = @customItemSetSMS;
update CustomItem set value = @bannerMessageDE, lastUpdateBy = null ,  lastUpdateDate = null where DTYPE = 'T'  and locale = 'de'  and ordinal = 33  and pageTypes = 'OTP_FORM_PAGE'  and fk_id_customItemSet = @customItemSetSMS;

update CustomItem set value = @bannerTitleEN, lastUpdateBy = null ,  lastUpdateDate = null where DTYPE = 'T'  and locale = 'en'  and ordinal = 32  and pageTypes = 'OTP_FORM_PAGE'  and fk_id_customItemSet = @customItemSetSMS;
update CustomItem set value = @bannerMessageEN, lastUpdateBy = null ,  lastUpdateDate = null where DTYPE = 'T'  and locale = 'en'  and ordinal = 33  and pageTypes = 'OTP_FORM_PAGE'  and fk_id_customItemSet = @customItemSetSMS;

update CustomItem set value = @bannerTitleFR, lastUpdateBy = null ,  lastUpdateDate = null where DTYPE = 'T'  and locale = 'fr'  and ordinal = 32    and pageTypes = 'OTP_FORM_PAGE'and fk_id_customItemSet = @customItemSetSMS;
update CustomItem set value = @bannerMessageFR, lastUpdateBy = null ,  lastUpdateDate = null where DTYPE = 'T'  and locale = 'fr'  and ordinal = 33    and pageTypes = 'OTP_FORM_PAGE'and fk_id_customItemSet = @customItemSetSMS;

update CustomItem set value = @bannerTitleIT, lastUpdateBy = null ,  lastUpdateDate = null where DTYPE = 'T'  and locale = 'it'  and ordinal = 32    and pageTypes = 'OTP_FORM_PAGE'and fk_id_customItemSet = @customItemSetSMS;
update CustomItem set value = @bannerMessageIT, lastUpdateBy = null ,  lastUpdateDate = null where DTYPE = 'T'  and locale = 'it'  and ordinal = 33    and pageTypes = 'OTP_FORM_PAGE'and fk_id_customItemSet = @customItemSetSMS;

delete
from CustomItem
where DTYPE = 'T'
  and ordinal in (32, 33)
  and pageTypes = @failurePageType
  and name in (concat(@networkName, '_', @otpSmsAuthentMean, '_', @failurePageType, '_32'),
			   concat(@networkName, '_', @otpSmsAuthentMean, '_', @failurePageType, '_33'),
			   concat(@networkName, '_', @mobileAppAuthentMean, '_', @failurePageType, '_32'),
			   concat(@networkName, '_', @mobileAppAuthentMean, '_', @failurePageType, '_33')
	)
  and fk_id_customItemSet in (@customItemSetSMS, @customItemSetMobileApp);

commit;