USE U7G_ACS_BO;
SET @createdBy ='A757435';
SET @BankB = 'UBS';
SET @BankUB = 'UBS';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'OTP_FORM_PAGE';
set @text = 'Keine Verbindung zur UBS Access App';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 51
                                        AND pageTypes = @currentPageType
                                        AND locale = 'de'
                                        AND `fk_id_customItemSet` = @customItemSetSMS;

set @text = 'No connection to UBS Access App';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 51
                                        AND pageTypes = @currentPageType
                                        AND locale = 'en'
                                        AND `fk_id_customItemSet` = @customItemSetSMS;

set @text = 'La connexion avec l\'app UBS Access est impossible';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 51
                                        AND pageTypes = @currentPageType
                                        AND locale = 'fr'
                                        AND `fk_id_customItemSet` = @customItemSetSMS;

set @text = 'Non fosse possibile stabilire alcun collegamento con l\'app UBS Access';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 51
                                        AND pageTypes = @currentPageType
                                        AND locale = 'it'
                                        AND `fk_id_customItemSet` = @customItemSetSMS;


set @text = 'Keine Verbindung zur UBS Access App möglich.Wir haben Ihnen einen Bestätigungscode an Ihre Mobilnummer für Sicherheitsnachrichten gesendet.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 52
                                        AND pageTypes = @currentPageType
                                        AND locale = 'de'
                                        AND `fk_id_customItemSet` = @customItemSetSMS;

set @text = 'As we did not reach your UBS Access App, we sent a confirmation code to your mobile number for security messages.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 52
                                        AND pageTypes = @currentPageType
                                        AND locale = 'en'
                                        AND `fk_id_customItemSet` = @customItemSetSMS;

set @text = 'La connexion avec l''app UBS Access est impossible, nous vous enverrons un code de confirmation sur votre numéro de téléphone mobile pour les messages de sécurité.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 52
                                        AND pageTypes = @currentPageType
                                        AND locale = 'fr'
                                        AND `fk_id_customItemSet` = @customItemSetSMS;

set @text = 'Il collegamento con l’app UBS Access non è possibile. Le abbiamo inviato un codice di conferma sul suo numero di cellulare per i messaggi di sicurezza.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 52
                                        AND pageTypes = @currentPageType
                                        AND locale = 'it'
                                        AND `fk_id_customItemSet` = @customItemSetSMS;