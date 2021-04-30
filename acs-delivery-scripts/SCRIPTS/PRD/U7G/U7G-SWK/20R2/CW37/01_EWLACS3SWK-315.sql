USE U7G_ACS_BO;

set @bannerTitleDE = 'Freigabe fehlgeschlagen';
set @bannerMessageDE ='Sie haben 3 Mal einen fehlerhaften Freigabe-Code eingegeben. Ihre Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Ihre Karte wird nun aus Sicherheitsgründen während einer kurzen Zeitdauer für Online-Zahlungen blockiert.';
set @bannerTitleEN = 'Approval failed';
set @bannerMessageEN = 'You have entered an incorrect approval code multiple times. Your payment could not be completed and your card was not debited. Your card will now be temporarily blocked for online payments for security reasons.';
set @bannerTitleFR = 'L''activation a échoué';
set @bannerMessageFR = 'Vous avez saisi 3 fois un mauvais code d''activation. Votre paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne.';
set @bannerTitleIT = 'Autenticazione fallita';
set @bannerMessageIT = 'Ha inserito 3 volte il codice di autenticazione errato. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo.';

SET @BankUB = 'CS';
SET @customItemSetSMS_CS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @BankUB = 'NAB';
SET @customItemSetSMS_NAB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @BankUB = 'SGKB';
SET @customItemSetSMS_SGKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @BankUB = 'SOBA';
SET @customItemSetSMS_SOBA = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @BankUB = 'LUKB';
SET @customItemSetSMS_LUKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));


update CustomItem set value = @bannerTitleDE, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'
                                                                                                    and locale = 'de'
                                                                                                    and ordinal = 32
                                                                                                    and pageTypes = 'OTP_FORM_PAGE'
                                                                                                    and fk_id_customItemSet in (@customItemSetSMS_CS,
                                                                                                                               @customItemSetSMS_NAB,
                                                                                                                               @customItemSetSMS_SGKB,
                                                                                                                               @customItemSetSMS_SOBA,
                                                                                                                               @customItemSetSMS_LUKB);

update CustomItem set value = @bannerMessageDE, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'
                                                                                                      and locale = 'de'
                                                                                                      and ordinal = 33
                                                                                                      and pageTypes = 'OTP_FORM_PAGE'
                                                                                                      and fk_id_customItemSet in (@customItemSetSMS_CS,
                                                                                                                               @customItemSetSMS_NAB,
                                                                                                                               @customItemSetSMS_SGKB,
                                                                                                                               @customItemSetSMS_SOBA,
                                                                                                                               @customItemSetSMS_LUKB);

update CustomItem set value = @bannerTitleEN, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'
                                                                                                    and locale = 'en'
                                                                                                    and ordinal = 32
                                                                                                    and pageTypes = 'OTP_FORM_PAGE'
                                                                                                    and fk_id_customItemSet in (@customItemSetSMS_CS,
                                                                                                                               @customItemSetSMS_NAB,
                                                                                                                               @customItemSetSMS_SGKB,
                                                                                                                               @customItemSetSMS_SOBA,
                                                                                                                               @customItemSetSMS_LUKB);
update CustomItem set value = @bannerMessageEN, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'
                                                                                                      and locale = 'en'
                                                                                                      and ordinal = 33
                                                                                                      and pageTypes = 'OTP_FORM_PAGE'
                                                                                                      and fk_id_customItemSet in (@customItemSetSMS_CS,
                                                                                                                               @customItemSetSMS_NAB,
                                                                                                                               @customItemSetSMS_SGKB,
                                                                                                                               @customItemSetSMS_SOBA,
                                                                                                                               @customItemSetSMS_LUKB);

update CustomItem set value = @bannerTitleFR, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'
                                                                                                    and locale = 'fr'
                                                                                                    and ordinal = 32
                                                                                                    and pageTypes = 'OTP_FORM_PAGE'
                                                                                                    and fk_id_customItemSet in (@customItemSetSMS_CS,
                                                                                                                               @customItemSetSMS_NAB,
                                                                                                                               @customItemSetSMS_SGKB,
                                                                                                                               @customItemSetSMS_SOBA,
                                                                                                                               @customItemSetSMS_LUKB);
update CustomItem set value = @bannerMessageFR, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'
                                                                                                      and locale = 'fr'
                                                                                                      and ordinal = 33
                                                                                                      and pageTypes = 'OTP_FORM_PAGE'
                                                                                                      and fk_id_customItemSet in (@customItemSetSMS_CS,
                                                                                                                               @customItemSetSMS_NAB,
                                                                                                                               @customItemSetSMS_SGKB,
                                                                                                                               @customItemSetSMS_SOBA,
                                                                                                                               @customItemSetSMS_LUKB);

update CustomItem set value = @bannerTitleIT, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'
                                                                                                    and locale = 'it'
                                                                                                    and ordinal = 32
                                                                                                    and pageTypes = 'OTP_FORM_PAGE'
                                                                                                    and fk_id_customItemSet in (@customItemSetSMS_CS,
                                                                                                                               @customItemSetSMS_NAB,
                                                                                                                               @customItemSetSMS_SGKB,
                                                                                                                               @customItemSetSMS_SOBA,
                                                                                                                               @customItemSetSMS_LUKB);
update CustomItem set value = @bannerMessageIT, lastUpdateBy = @createdBy ,  lastUpdateDate = now() where DTYPE = 'T'
                                                                                                      and locale = 'it'
                                                                                                      and ordinal = 33
                                                                                                      and pageTypes = 'OTP_FORM_PAGE'
                                                                                                      and fk_id_customItemSet in (@customItemSetSMS_CS,
                                                                                                                               @customItemSetSMS_NAB,
                                                                                                                               @customItemSetSMS_SGKB,
                                                                                                                               @customItemSetSMS_SOBA,
                                                                                                                               @customItemSetSMS_LUKB);

