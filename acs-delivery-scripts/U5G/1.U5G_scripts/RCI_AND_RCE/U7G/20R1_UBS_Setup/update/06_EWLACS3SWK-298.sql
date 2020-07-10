use U7G_ACS_BO;
SET @createdBy ='A707825';

set @bannerTitleDE = 'Eingabe fehlgeschlagen';
set @bannerMessageDE ='Ihre drei Eingabeversuche sind fehlgeschlagen. Bitte fordern Sie einen neuen Code an, um die Zahlung auszuführen.';
set @bannerTitleEN = 'Entry failed';
set @bannerMessageEN = 'Your three attempts to enter the code have failed. Please request a new code to execute the payment.';
set @bannerTitleFR = 'Échec de la saisie';
set @bannerMessageFR = 'Vos trois tentatives de saisie ont échoué. Veuillez demander un nouveau code pour effectuer le paiement.';
set @bannerTitleIT = 'Inserimento fallito';
set @bannerMessageIT = 'I suoi tre tentativi di inserimento sono falliti. Si prega di richiedere un nuovo codice per eseguire il pagamento.';

set @technicalErrorTitleDE = 'Technischer Fehler';
set @technicalErrorMessageDE = 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.';
set @technicalErrorTitleEN = 'Technical error';
set @technicalErrorMessageEN = 'A technical error has occurred and your purchase could not be made. Please try again later.';
set @technicalErrorTitleFR = 'Erreur technique';
set @technicalErrorMessageFR = 'Une erreur technique est survenue et votre achat n’a pas pu être finalisé. Veuillez réessayer.';
set @technicalErrorTitleIT = 'Problema tecnico';
set @technicalErrorMessageIT = 'Si è verificato un errore tecnico e il suo acquisto non può essere concluso. La preghiamo di riprovare più tardi.';

set @networkName = (select `name` from `Network` where `code` = 'VISA');

set @failurePageType = 'FAILURE_PAGE';
set @otpSmsAuthentMean = 'OTP_SMS_EXT_MESSAGE';
set @mobileAppAuthentMean = 'MOBILE_APP_EXT';

set @customItemSetSMS = (select id from CustomItemSet where name = 'customitemset_UBS_SMS');
set @customItemSetMobileApp = (select id from CustomItemSet where name = 'customitemset_UBS_MOBILE_APP_EXT');

start transaction;

update CustomItem set value = @bannerTitleDE, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'  and locale = 'de'  and ordinal = 32  and pageTypes = 'OTP_FORM_PAGE'  and fk_id_customItemSet = @customItemSetSMS;
update CustomItem set value = @bannerMessageDE, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'  and locale = 'de'  and ordinal = 33  and pageTypes = 'OTP_FORM_PAGE'  and fk_id_customItemSet = @customItemSetSMS;

update CustomItem set value = @bannerTitleEN, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'  and locale = 'en'  and ordinal = 32  and pageTypes = 'OTP_FORM_PAGE'  and fk_id_customItemSet = @customItemSetSMS;
update CustomItem set value = @bannerMessageEN, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'  and locale = 'en'  and ordinal = 33  and pageTypes = 'OTP_FORM_PAGE'  and fk_id_customItemSet = @customItemSetSMS;

update CustomItem set value = @bannerTitleFR, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'  and locale = 'fr'  and ordinal = 32    and pageTypes = 'OTP_FORM_PAGE'and fk_id_customItemSet = @customItemSetSMS;
update CustomItem set value = @bannerMessageFR, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'  and locale = 'fr'  and ordinal = 33    and pageTypes = 'OTP_FORM_PAGE'and fk_id_customItemSet = @customItemSetSMS;

update CustomItem set value = @bannerTitleIT, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'  and locale = 'it'  and ordinal = 32    and pageTypes = 'OTP_FORM_PAGE'and fk_id_customItemSet = @customItemSetSMS;
update CustomItem set value = @bannerMessageIT, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'  and locale = 'it'  and ordinal = 33    and pageTypes = 'OTP_FORM_PAGE'and fk_id_customItemSet = @customItemSetSMS;

insert into `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,`name`, `updateState`,
						  `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
values
   ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@otpSmsAuthentMean,'_',@failurePageType,'_32'), 'PUSHED_TO_CONFIG',
	'de', 32, @failurePageType, @technicalErrorTitleDE, null, null, @customItemSetSMS),
  ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@otpSmsAuthentMean,'_',@failurePageType,'_33'), 'PUSHED_TO_CONFIG',
   'de', 33, @failurePageType, @technicalErrorMessageDE, null, null, @customItemSetSMS),
   ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@otpSmsAuthentMean,'_',@failurePageType,'_32'), 'PUSHED_TO_CONFIG',
	'en', 32, @failurePageType, @technicalErrorTitleEN, null, null, @customItemSetSMS),
  ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@otpSmsAuthentMean,'_',@failurePageType,'_33'), 'PUSHED_TO_CONFIG',
   'en', 33, @failurePageType, @technicalErrorMessageEN, null, null, @customItemSetSMS),
   ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@otpSmsAuthentMean,'_',@failurePageType,'_32'), 'PUSHED_TO_CONFIG',
	'fr', 32, @failurePageType, @technicalErrorTitleFR, null, null, @customItemSetSMS),
  ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@otpSmsAuthentMean,'_',@failurePageType,'_33'), 'PUSHED_TO_CONFIG',
   'fr', 33, @failurePageType, @technicalErrorMessageFR, null, null, @customItemSetSMS),
   ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@otpSmsAuthentMean,'_',@failurePageType,'_32'), 'PUSHED_TO_CONFIG',
	'it', 32, @failurePageType, @technicalErrorTitleIT, null, null, @customItemSetSMS),
  ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@otpSmsAuthentMean,'_',@failurePageType,'_33'), 'PUSHED_TO_CONFIG',
   'it', 33, @failurePageType, @technicalErrorMessageIT, null, null, @customItemSetSMS);

insert into `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,`name`, `updateState`,
						  `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
values
   ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@mobileAppAuthentMean,'_',@failurePageType,'_32'), 'PUSHED_TO_CONFIG',
	'de', 32, @failurePageType, @technicalErrorTitleDE, null, null, @customItemSetMobileApp),
  ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@mobileAppAuthentMean,'_',@failurePageType,'_33'), 'PUSHED_TO_CONFIG',
   'de', 33, @failurePageType, @technicalErrorMessageDE, null, null, @customItemSetMobileApp),
   ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@mobileAppAuthentMean,'_',@failurePageType,'_32'), 'PUSHED_TO_CONFIG',
	'en', 32, @failurePageType, @technicalErrorTitleEN, null, null, @customItemSetMobileApp),
  ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@mobileAppAuthentMean,'_',@failurePageType,'_33'), 'PUSHED_TO_CONFIG',
   'en', 33, @failurePageType, @technicalErrorMessageEN, null, null, @customItemSetMobileApp),
   ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@mobileAppAuthentMean,'_',@failurePageType,'_32'), 'PUSHED_TO_CONFIG',
	'fr', 32, @failurePageType, @technicalErrorTitleFR, null, null, @customItemSetMobileApp),
  ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@mobileAppAuthentMean,'_',@failurePageType,'_33'), 'PUSHED_TO_CONFIG',
   'fr', 33, @failurePageType, @technicalErrorMessageFR, null, null, @customItemSetMobileApp),
   ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@mobileAppAuthentMean,'_',@failurePageType,'_32'), 'PUSHED_TO_CONFIG',
	'it', 32, @failurePageType, @technicalErrorTitleIT, null, null, @customItemSetMobileApp),
  ('T', @createdBy, now(), null, null, null, concat(@networkName,'_',@mobileAppAuthentMean,'_',@failurePageType,'_33'), 'PUSHED_TO_CONFIG',
   'it', 33, @failurePageType, @technicalErrorMessageIT, null, null, @customItemSetMobileApp);

commit;