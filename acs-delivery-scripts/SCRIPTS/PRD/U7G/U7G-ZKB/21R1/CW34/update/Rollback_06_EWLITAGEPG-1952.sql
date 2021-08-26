USE `U7G_ACS_BO`;

SET @BankUB = 'ZKB';

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));

SET @refusalPageType = 'REFUSAL_PAGE';

UPDATE CustomItem SET value = '''Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte. '
WHERE locale = 'fr' AND ordinal = 2 AND pageTypes = @refusalPageType AND fk_id_customItemSet = @customItemSetREFUSAL;


SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS_EXT'));

SET @otpFormPagePageType = 'OTP_FORM_PAGE';

UPDATE CustomItem SET value = '''Vous avez saisi 3 fois un mauvais code d''activation. Votre paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne. '
WHERE locale = 'fr' AND ordinal = 23 AND pageTypes = @otpFormPagePageType AND fk_id_customItemSet = @customItemSetSMS;

UPDATE CustomItem SET value = '''Ha inserito 3 volte il codice di autenticazione errato. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo. '
WHERE locale = 'it' AND ordinal = 23 AND pageTypes = @otpFormPagePageType AND fk_id_customItemSet = @customItemSetSMS;

UPDATE CustomItem SET value = '''È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.'
WHERE locale = 'it' AND ordinal = 31 AND pageTypes = @otpFormPagePageType AND fk_id_customItemSet = @customItemSetSMS;

UPDATE CustomItem SET value = 'We did not reach your Access App.'
WHERE locale = 'en' AND ordinal = 51 AND pageTypes = @otpFormPagePageType AND fk_id_customItemSet = @customItemSetSMS;

UPDATE CustomItem SET value = 'We sent an approval code to your mobile phone, which you can use to confirm the payment.'
WHERE locale = 'en' AND ordinal = 52 AND pageTypes = @otpFormPagePageType AND fk_id_customItemSet = @customItemSetSMS;

SET @failurePagePageType = 'FAILURE_PAGE';
UPDATE CustomItem SET value = '''Ha inserito 3 volte il codice di autenticazione errato. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo. '
WHERE locale = 'it' AND ordinal = 17 AND pageTypes = @failurePagePageType AND fk_id_customItemSet = @customItemSetSMS;



SET @customItemSetMobileAppExt = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));

SET @pollingPagePageType = 'POLLING_PAGE';

UPDATE CustomItem SET value = '''Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement. '
WHERE locale = 'fr' AND ordinal = 15 AND pageTypes = @pollingPagePageType AND fk_id_customItemSet = @customItemSetMobileAppExt;

UPDATE CustomItem SET value = '''Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement.'
WHERE locale = 'fr' AND ordinal = 31 AND pageTypes = @pollingPagePageType AND fk_id_customItemSet = @customItemSetMobileAppExt;

UPDATE CustomItem SET value = '''En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.'
WHERE locale = 'fr' AND ordinal = 33 AND pageTypes = @pollingPagePageType AND fk_id_customItemSet = @customItemSetMobileAppExt;

UPDATE CustomItem SET value = '''Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento. '
WHERE locale = 'it' AND ordinal = 15 AND pageTypes = @pollingPagePageType AND fk_id_customItemSet = @customItemSetMobileAppExt;

UPDATE CustomItem SET value = '''È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento. '
WHERE locale = 'it' AND ordinal = 31 AND pageTypes = @pollingPagePageType AND fk_id_customItemSet = @customItemSetMobileAppExt;

UPDATE CustomItem SET value = '''Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente. '
WHERE locale = 'it' AND ordinal = 33 AND pageTypes = @pollingPagePageType AND fk_id_customItemSet = @customItemSetMobileAppExt;


SET @customItemSetMISSING = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));

UPDATE CustomItem SET value = '''Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte.'
WHERE locale = 'fr' AND ordinal = 2 AND pageTypes = @refusalPageType AND fk_id_customItemSet = @customItemSetMISSING;


SET @customItemSetBackupRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_BACKUP_REFUSAL'));

UPDATE CustomItem SET value = '''Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte. '
WHERE locale = 'fr' AND ordinal = 2 AND pageTypes = @refusalPageType AND fk_id_customItemSet = @customItemSetBackupRefusal;

