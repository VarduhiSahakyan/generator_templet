USE U7G_ACS_BO;
SET @BankB = 'SWISSKEY';
SET @BankCS = 'CS';
SET @BankNAB = 'NAB';
SET @BankSGKB = 'SGKB';
SET @BankSOBA = 'SOBA';
SET @BankLUKB = 'LUKB';
SET @BankBALI = 'BALI';
SET @BankBEKB = 'BEKB';
SET @BankGRKB = 'GRKB';
SET @BankLLB = 'LLB';
SET @BankTGKB = 'TGKB';
SET @subIssuerCode_CS = '48350';
SET @subIssuerCode_NAB = '58810';
SET @subIssuerCode_SGKB = '78100';
SET @subIssuerCode_SOBA = '83340';
SET @subIssuerCode_LUKB = '77800';
SET @subIssuerCode_BALI = '87310';
SET @subIssuerCode_BEKB = '79000';
SET @subIssuerCode_GRKB = '77400';
SET @subIssuerCode_LLB = '88000';
SET @subIssuerCode_TGKB = '78400';
SET @subIssuerNameAndLabel_CS = 'Crédit Suisse AG';
SET @subIssuerNameAndLabel_NAB = 'Neue Aargauer Bank';
SET @subIssuerNameAndLabel_SGKB = 'St. Galler Kantonalbank AG';
SET @subIssuerNameAndLabel_SOBA = 'Baloise Bank SoBa AG';
SET @subIssuerNameAndLabel_LUKB = 'Luzerner KB AG';
SET @subIssuerNameAndLabel_BALI = 'Bank Linth LLB AG';
SET @subIssuerNameAndLabel_BEKB = 'Berner KB AG';
SET @subIssuerNameAndLabel_GRKB = 'Graubündner Kantonalbank';
SET @subIssuerNameAndLabel_LLB = 'Liechtensteinische Landesbank AG';
SET @subIssuerNameAndLabel_TGKB = 'Thurgauer Kantonalbank';
SET @subIssuerID_CS = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode_CS AND `name` = @subIssuerNameAndLabel_CS);
SET @subIssuerID_NAB = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode_NAB AND `name` = @subIssuerNameAndLabel_NAB);
SET @subIssuerID_SGKB = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode_SGKB AND `name` = @subIssuerNameAndLabel_SGKB);
SET @subIssuerID_SOBA = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode_SOBA AND `name` = @subIssuerNameAndLabel_SOBA);
SET @subIssuerID_LUKB = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode_LUKB AND `name` = @subIssuerNameAndLabel_LUKB);
SET @subIssuerID_BALI = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode_BALI AND `name` = @subIssuerNameAndLabel_BALI);
SET @subIssuerID_BEKB = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode_BEKB AND `name` = @subIssuerNameAndLabel_BEKB);
SET @subIssuerID_GRKB = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode_GRKB AND `name` = @subIssuerNameAndLabel_GRKB);
SET @subIssuerID_LLB = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode_LLB AND `name` = @subIssuerNameAndLabel_LLB);
SET @subIssuerID_TGKB = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode_TGKB AND `name` = @subIssuerNameAndLabel_TGKB);


SET @customItemSetMissingRefusal_CS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankCS, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetMissingRefusal_NAB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankNAB, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetMissingRefusal_SGKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankSGKB, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetMissingRefusal_SOBA = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankSOBA, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetMissingRefusal_LUKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankLUKB, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetMissingRefusal_BALI = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankBALI, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetMissingRefusal_BEKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankBEKB, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetMissingRefusal_GRKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankGRKB, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetMissingRefusal_LLB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankLLB, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetMissingRefusal_TGKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankTGKB, '_MISSING_AUTHENTICATION_REFUSAL'));

SET @currentPageType = 'REFUSAL_PAGE';
set @text = 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
										AND pageTypes = @currentPageType
										AND locale = 'de'
										AND `fk_id_customItemSet` IN (@customItemSetMissingRefusal_CS,
																	  @customItemSetMissingRefusal_NAB,
																	  @customItemSetMissingRefusal_SGKB,
																	  @customItemSetMissingRefusal_SOBA,
																	  @customItemSetMissingRefusal_LUKB,
																	  @customItemSetMissingRefusal_BALI,
																	  @customItemSetMissingRefusal_BEKB,
																	  @customItemSetMissingRefusal_GRKB,
																	  @customItemSetMissingRefusal_LLB,
																	  @customItemSetMissingRefusal_TGKB);

set @text = 'Payment not completed – card is not registered for 3D Secure.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
										AND pageTypes = @currentPageType
										AND locale = 'en'
										AND `fk_id_customItemSet` IN (@customItemSetMissingRefusal_CS,
																	  @customItemSetMissingRefusal_NAB,
																	  @customItemSetMissingRefusal_SGKB,
																	  @customItemSetMissingRefusal_SOBA,
																	  @customItemSetMissingRefusal_LUKB,
																	  @customItemSetMissingRefusal_BALI,
																	  @customItemSetMissingRefusal_BEKB,
																	  @customItemSetMissingRefusal_GRKB,
																	  @customItemSetMissingRefusal_LLB,
																	  @customItemSetMissingRefusal_TGKB);
set @text = 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
										AND pageTypes = @currentPageType
										AND locale = 'fr'
										AND `fk_id_customItemSet` IN (@customItemSetMissingRefusal_CS,
																	  @customItemSetMissingRefusal_NAB,
																	  @customItemSetMissingRefusal_SGKB,
																	  @customItemSetMissingRefusal_SOBA,
																	  @customItemSetMissingRefusal_LUKB,
																	  @customItemSetMissingRefusal_BALI,
																	  @customItemSetMissingRefusal_BEKB,
																	  @customItemSetMissingRefusal_GRKB,
																	  @customItemSetMissingRefusal_LLB,
																	  @customItemSetMissingRefusal_TGKB);
set @text = 'Pagamento non eseguito - La carta non è registrata per 3D Secure';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
										AND pageTypes = @currentPageType
										AND locale = 'it'
										AND `fk_id_customItemSet` IN (@customItemSetMissingRefusal_CS,
																	  @customItemSetMissingRefusal_NAB,
																	  @customItemSetMissingRefusal_SGKB,
																	  @customItemSetMissingRefusal_SOBA,
																	  @customItemSetMissingRefusal_LUKB,
																	  @customItemSetMissingRefusal_BALI,
																	  @customItemSetMissingRefusal_BEKB,
																	  @customItemSetMissingRefusal_GRKB,
																	  @customItemSetMissingRefusal_LLB,
																	  @customItemSetMissingRefusal_TGKB);

set @text = 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
										AND pageTypes = @currentPageType
										AND locale = 'de'
										AND `fk_id_customItemSet` IN (@customItemSetMissingRefusal_CS,
																	  @customItemSetMissingRefusal_NAB,
																	  @customItemSetMissingRefusal_SGKB,
																	  @customItemSetMissingRefusal_SOBA,
																	  @customItemSetMissingRefusal_LUKB,
																	  @customItemSetMissingRefusal_BALI,
																	  @customItemSetMissingRefusal_BEKB,
																	  @customItemSetMissingRefusal_GRKB,
																	  @customItemSetMissingRefusal_LLB,
																	  @customItemSetMissingRefusal_TGKB);
set @text = 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
										AND pageTypes = @currentPageType
										AND locale = 'en'
										AND `fk_id_customItemSet` IN (@customItemSetMissingRefusal_CS,
																	  @customItemSetMissingRefusal_NAB,
																	  @customItemSetMissingRefusal_SGKB,
																	  @customItemSetMissingRefusal_SOBA,
																	  @customItemSetMissingRefusal_LUKB,
																	  @customItemSetMissingRefusal_BALI,
																	  @customItemSetMissingRefusal_BEKB,
																	  @customItemSetMissingRefusal_GRKB,
																	  @customItemSetMissingRefusal_LLB,
																	  @customItemSetMissingRefusal_TGKB);
set @text = 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
										AND pageTypes = @currentPageType
										AND locale = 'fr'
										AND `fk_id_customItemSet` IN (@customItemSetMissingRefusal_CS,
																	  @customItemSetMissingRefusal_NAB,
																	  @customItemSetMissingRefusal_SGKB,
																	  @customItemSetMissingRefusal_SOBA,
																	  @customItemSetMissingRefusal_LUKB,
																	  @customItemSetMissingRefusal_BALI,
																	  @customItemSetMissingRefusal_BEKB,
																	  @customItemSetMissingRefusal_GRKB,
																	  @customItemSetMissingRefusal_LLB,
																	  @customItemSetMissingRefusal_TGKB);
set @text = 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
										AND pageTypes = @currentPageType
										AND locale = 'it'
										AND `fk_id_customItemSet` IN (@customItemSetMissingRefusal_CS,
																	  @customItemSetMissingRefusal_NAB,
																	  @customItemSetMissingRefusal_SGKB,
																	  @customItemSetMissingRefusal_SOBA,
																	  @customItemSetMissingRefusal_LUKB,
																	  @customItemSetMissingRefusal_BALI,
																	  @customItemSetMissingRefusal_BEKB,
																	  @customItemSetMissingRefusal_GRKB,
																	  @customItemSetMissingRefusal_LLB,
																	  @customItemSetMissingRefusal_TGKB);



/********* Refusal Missing Profile *********/
SET @customItemSetRefusal_CS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankCS, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusal_NAB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankNAB, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusal_SGKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankSGKB, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusal_SOBA = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankSOBA, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusal_LUKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankLUKB, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusal_BALI = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankBALI, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusal_BEKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankBEKB, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusal_GRKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankGRKB, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusal_LLB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankLLB, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusal_TGKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankTGKB, '_DEFAULT_REFUSAL'));
DELETE FROM `CustomItem` WHERE fk_id_customItemSet IN (@customItemSetRefusal_CS,
													   @customItemSetRefusal_NAB,
													   @customItemSetRefusal_SGKB,
													   @customItemSetRefusal_SOBA,
													   @customItemSetRefusal_LUKB,
													   @customItemSetRefusal_BALI,
													   @customItemSetRefusal_BEKB,
													   @customItemSetRefusal_GRKB,
													   @customItemSetRefusal_LLB,
													   @customItemSetRefusal_TGKB);


SET @profileRefusal_CS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankCS, '_DEFAULT_REFUSAL'));
SET @profileRefusal_NAB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankNAB, '_DEFAULT_REFUSAL'));
SET @profileRefusal_SGKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankSGKB, '_DEFAULT_REFUSAL'));
SET @profileRefusal_SOBA = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankSOBA, '_DEFAULT_REFUSAL'));
SET @profileRefusal_LUKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankLUKB, '_DEFAULT_REFUSAL'));
SET @profileRefusal_BALI = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankBALI, '_DEFAULT_REFUSAL'));
SET @profileRefusal_BEKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankBEKB, '_DEFAULT_REFUSAL'));
SET @profileRefusal_GRKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankGRKB, '_DEFAULT_REFUSAL'));
SET @profileRefusal_LLB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankLLB, '_DEFAULT_REFUSAL'));
SET @profileRefusal_TGKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankTGKB, '_DEFAULT_REFUSAL'));
SET @profileRefusalFraud_CS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankCS, '_REFUSAL_FRAUD'));
SET @profileRefusalFraud_NAB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankNAB, '_REFUSAL_FRAUD'));
SET @profileRefusalFraud_SGKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankSGKB, '_REFUSAL_FRAUD'));
SET @profileRefusalFraud_SOBA = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankSOBA, '_REFUSAL_FRAUD'));
SET @profileRefusalFraud_LUKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankLUKB, '_REFUSAL_FRAUD'));
SET @profileRefusalFraud_BALI = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankBALI, '_REFUSAL_FRAUD'));
SET @profileRefusalFraud_BEKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankBEKB, '_REFUSAL_FRAUD'));
SET @profileRefusalFraud_GRKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankGRKB, '_REFUSAL_FRAUD'));
SET @profileRefusalFraud_LLB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankLLB, '_REFUSAL_FRAUD'));
SET @profileRefusalFraud_TGKB = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankTGKB, '_REFUSAL_FRAUD'));

UPDATE `Rule` SET `fk_id_profile` = @profileRefusalFraud_CS WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusal_CS;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusalFraud_NAB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusal_NAB;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusalFraud_SGKB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusal_SGKB;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusalFraud_SOBA WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusal_SOBA;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusalFraud_LUKB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusal_LUKB;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusalFraud_BALI WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusal_BALI;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusalFraud_BEKB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusal_BEKB;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusalFraud_GRKB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusal_GRKB;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusalFraud_LLB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusal_LLB;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusalFraud_TGKB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusal_TGKB;


DELETE FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuerID_CS
						AND `description` = 'REFUSAL (DEFAULT)'
						AND `name` = CONCAT(@BankCS,'_DEFAULT_REFUSAL')
						AND `fk_id_customItemSetCurrent` = @customItemSetRefusal_CS;
DELETE FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuerID_NAB
						AND `description` = 'REFUSAL (DEFAULT)'
						AND `name` = CONCAT(@BankNAB,'_DEFAULT_REFUSAL')
						AND `fk_id_customItemSetCurrent` = @customItemSetRefusal_NAB;
DELETE FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuerID_SGKB
						AND `description` = 'REFUSAL (DEFAULT)'
						AND `name` = CONCAT(@BankSGKB,'_DEFAULT_REFUSAL')
						AND `fk_id_customItemSetCurrent` = @customItemSetRefusal_SGKB;
DELETE FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuerID_SOBA
						AND `description` = 'REFUSAL (DEFAULT)'
						AND `name` = CONCAT(@BankSOBA,'_DEFAULT_REFUSAL')
						AND `fk_id_customItemSetCurrent` = @customItemSetRefusal_SOBA;
DELETE FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuerID_LUKB
						AND `description` = 'REFUSAL (DEFAULT)'
						AND `name` = CONCAT(@BankLUKB,'_DEFAULT_REFUSAL')
						AND `fk_id_customItemSetCurrent` = @customItemSetRefusal_LUKB;
DELETE FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuerID_BALI
						AND `description` = 'REFUSAL (DEFAULT)'
						AND `name` = CONCAT(@BankBALI,'_DEFAULT_REFUSAL')
						AND `fk_id_customItemSetCurrent` = @customItemSetRefusal_BALI;
DELETE FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuerID_BEKB
						AND `description` = 'REFUSAL (DEFAULT)'
						AND `name` = CONCAT(@BankBEKB,'_DEFAULT_REFUSAL')
						AND `fk_id_customItemSetCurrent` = @customItemSetRefusal_BEKB;
DELETE FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuerID_GRKB
						AND `description` = 'REFUSAL (DEFAULT)'
						AND `name` = CONCAT(@BankGRKB,'_DEFAULT_REFUSAL')
						AND `fk_id_customItemSetCurrent` = @customItemSetRefusal_GRKB;
DELETE FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuerID_LLB
						AND `description` = 'REFUSAL (DEFAULT)'
						AND `name` = CONCAT(@BankLLB,'_DEFAULT_REFUSAL')
						AND `fk_id_customItemSetCurrent` = @customItemSetRefusal_LLB;
DELETE FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuerID_TGKB
						AND `description` = 'REFUSAL (DEFAULT)'
						AND `name` = CONCAT(@BankTGKB,'_DEFAULT_REFUSAL')
						AND `fk_id_customItemSetCurrent` = @customItemSetRefusal_TGKB;

DELETE FROM `CustomItemSet` WHERE id IN (@customItemSetRefusal_CS,
										 @customItemSetRefusal_NAB,
										 @customItemSetRefusal_SGKB,
										 @customItemSetRefusal_SOBA,
										 @customItemSetRefusal_LUKB,
										 @customItemSetRefusal_BALI,
										 @customItemSetRefusal_BEKB,
										 @customItemSetRefusal_GRKB,
										 @customItemSetRefusal_LLB,
										 @customItemSetRefusal_TGKB);



SET @customItemSetRefusalFraud_CS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankCS, '_REFUSAL_FRAUD'));
SET @customItemSetRefusalFraud_NAB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankNAB, '_REFUSAL_FRAUD'));
SET @customItemSetRefusalFraud_SGKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankSGKB, '_REFUSAL_FRAUD'));
SET @customItemSetRefusalFraud_SOBA = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankSOBA, '_REFUSAL_FRAUD'));
SET @customItemSetRefusalFraud_LUKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankLUKB, '_REFUSAL_FRAUD'));
SET @customItemSetRefusalFraud_BALI = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankBALI, '_REFUSAL_FRAUD'));
SET @customItemSetRefusalFraud_BEKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankBEKB, '_REFUSAL_FRAUD'));
SET @customItemSetRefusalFraud_GRKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankGRKB, '_REFUSAL_FRAUD'));
SET @customItemSetRefusalFraud_LLB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankLLB, '_REFUSAL_FRAUD'));
SET @customItemSetRefusalFraud_TGKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankTGKB, '_REFUSAL_FRAUD'));
UPDATE `Profile` SET `description` = 'REFUSAL (DEFAULT)',
					 `name`= CONCAT(@BankCS,'_DEFAULT_REFUSAL')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud_CS
				  AND `name` = CONCAT(@BankCS,'_REFUSAL_FRAUD');
UPDATE `Profile` SET `description` = 'REFUSAL (DEFAULT)',
					 `name`= CONCAT(@BankNAB,'_DEFAULT_REFUSAL')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud_NAB
				  AND `name` = CONCAT(@BankNAB,'_REFUSAL_FRAUD');
UPDATE `Profile` SET `description` = 'REFUSAL (DEFAULT)',
					 `name`= CONCAT(@BankSGKB,'_DEFAULT_REFUSAL')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud_SGKB
				  AND `name` = CONCAT(@BankSGKB,'_REFUSAL_FRAUD');
UPDATE `Profile` SET `description` = 'REFUSAL (DEFAULT)',
					 `name`= CONCAT(@BankSOBA,'_DEFAULT_REFUSAL')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud_SOBA
				  AND `name` = CONCAT(@BankSOBA,'_REFUSAL_FRAUD');
UPDATE `Profile` SET `description` = 'REFUSAL (DEFAULT)',
					 `name`= CONCAT(@BankLUKB,'_DEFAULT_REFUSAL')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud_LUKB
				  AND `name` = CONCAT(@BankLUKB,'_REFUSAL_FRAUD');
UPDATE `Profile` SET `description` = 'REFUSAL (DEFAULT)',
					 `name`= CONCAT(@BankBALI,'_DEFAULT_REFUSAL')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud_BALI
				  AND `name` = CONCAT(@BankBALI,'_REFUSAL_FRAUD');
UPDATE `Profile` SET `description` = 'REFUSAL (DEFAULT)',
					 `name`= CONCAT(@BankBEKB,'_DEFAULT_REFUSAL')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud_BEKB
				  AND `name` = CONCAT(@BankBEKB,'_REFUSAL_FRAUD');
UPDATE `Profile` SET `description` = 'REFUSAL (DEFAULT)',
					 `name`= CONCAT(@BankGRKB,'_DEFAULT_REFUSAL')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud_GRKB
				  AND `name` = CONCAT(@BankGRKB,'_REFUSAL_FRAUD');
UPDATE `Profile` SET `description` = 'REFUSAL (DEFAULT)',
					 `name`= CONCAT(@BankLLB,'_DEFAULT_REFUSAL')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud_LLB
				  AND `name` = CONCAT(@BankLLB,'_REFUSAL_FRAUD');
UPDATE `Profile` SET `description` = 'REFUSAL (DEFAULT)',
					 `name`= CONCAT(@BankTGKB,'_DEFAULT_REFUSAL')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusalFraud_TGKB
				  AND `name` = CONCAT(@BankTGKB,'_REFUSAL_FRAUD');

UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankCS, '_DEFAULT_REFUSAL'),
						 `description` = CONCAT('customitemset_', @BankCS, '_DEFAULT_REFUSAL_Current')
						WHERE `name` = CONCAT('customitemset_', @BankCS, '_REFUSAL_FRAUD');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankNAB, '_DEFAULT_REFUSAL'),
						 `description` = CONCAT('customitemset_', @BankNAB, '_DEFAULT_REFUSAL_Current')
						WHERE `name` = CONCAT('customitemset_', @BankNAB, '_REFUSAL_FRAUD');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankSGKB, '_DEFAULT_REFUSAL'),
						 `description` = CONCAT('customitemset_', @BankSGKB, '_DEFAULT_REFUSAL_Current')
						WHERE `name` = CONCAT('customitemset_', @BankSGKB, '_REFUSAL_FRAUD');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankSOBA, '_DEFAULT_REFUSAL'),
						 `description` = CONCAT('customitemset_', @BankSOBA, '_DEFAULT_REFUSAL_Current')
						WHERE `name` = CONCAT('customitemset_', @BankSOBA, '_REFUSAL_FRAUD');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankLUKB, '_DEFAULT_REFUSAL'),
						 `description` = CONCAT('customitemset_', @BankLUKB, '_DEFAULT_REFUSAL_Current')
						WHERE `name` = CONCAT('customitemset_', @BankLUKB, '_REFUSAL_FRAUD');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankBALI, '_DEFAULT_REFUSAL'),
						 `description` = CONCAT('customitemset_', @BankBALI, '_DEFAULT_REFUSAL_Current')
						WHERE `name` = CONCAT('customitemset_', @BankBALI, '_REFUSAL_FRAUD');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankBEKB, '_DEFAULT_REFUSAL'),
						 `description` = CONCAT('customitemset_', @BankBEKB, '_DEFAULT_REFUSAL_Current')
						WHERE `name` = CONCAT('customitemset_', @BankBEKB, '_REFUSAL_FRAUD');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankGRKB, '_DEFAULT_REFUSAL'),
						 `description` = CONCAT('customitemset_', @BankGRKB, '_DEFAULT_REFUSAL_Current')
						WHERE `name` = CONCAT('customitemset_', @BankGRKB, '_REFUSAL_FRAUD');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankLLB, '_DEFAULT_REFUSAL'),
						 `description` = CONCAT('customitemset_', @BankLLB, '_DEFAULT_REFUSAL_Current')
						WHERE `name` = CONCAT('customitemset_', @BankLLB, '_REFUSAL_FRAUD');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankTGKB, '_DEFAULT_REFUSAL'),
						 `description` = CONCAT('customitemset_', @BankTGKB, '_DEFAULT_REFUSAL_Current')
						WHERE `name` = CONCAT('customitemset_', @BankTGKB, '_REFUSAL_FRAUD');


SET @BankB = 'SWISSKEY';
SET @layoutIdRefusalPage =(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('INFO Refusal Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '<style>
	div#optGblPage {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 14px;
	}
	#optGblPage .warn {
		background-color: #3399ff
	}
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 40%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderCenter {
		width: 30%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 30%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: flex-end;
	}
	#issuerLogo {
		max-height: 64px;
		max-width: 100%;
	}
	#networkLogo {
		max-height: 65px;
		max-width: 100%;
	}
	#i18n > button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#i18n-container {
		width: 100%;
		clear: both;
	}
	#i18n-inner {
		display: block;
		margin-left: auto;
		margin-right: auto;
		clear: both;
	}
	#i18n > button {
		background: transparent;
		color: #557a8e;
		border: none;
		box-shadow: none;
	}
	#i18n > button.active {
		background: #06446c !important;
		color: #ffffff !important;
		border-radius: 5px !important;
	}
	div#green-banner {
		height: 50px !important;
		background-color: #ada398;
		border-bottom: 5px solid #ada398;
		width: 100%;
	}
	.paragraph {
		text-align: left;
		margin-bottom: 10px;
	}
	.paragraphDescription {
		text-align: left;
	}
	.leftColumn {
		width: 40%;
		display: block;
		float: left;
		padding-top: 1.5em;
		padding-bottom: 1.5em;
		padding-right: 1em;
	}
	.rightColumn {
		width: 60%;
		margin-left: 40%;
		display: block;
		text-align: left;
		padding: 20px 10px;
	}
	.contentRow {
		width: 100%;
		padding: 1em;
		padding: 0px;
		padding-top: 1em;
		clear: both;
		font-size: 12px;
		color: #000000;
	}
	side-menu div.text-center {
		text-align: center;
	}
	div.side-menu div.menu-title::before {
		display: inline;
	}
	div.side-menu div.menu-title::after {
		display: inline;
	}
	div.side-menu div.menu-title {
		display: inline;
		text-align: left;
		font-size: 14px;
		color: #000000;
	}
	div.side-menu div.menu-elements {
		margin-top: 5px;
		display: grid;
	}
	div#message-controls {
		text-align: center;
		padding-bottom: 10px;
		padding-top: 0px;
	}
	div#footer {
		padding-top: 12px;
		padding-bottom: 12px;
		width: 100%;
		background-color: #ada398;
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
	}
	div#footer #helpButton button span:before {
		content: '''';
	}
	div#footer #cancelButton button span:before {
		content: '''';
	}
	div#footer #helpButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-position-y: -1px;
		background-size: 115%;
		display: inline-block;
	}
	div#footer #cancelButton button span.fa {
		background-image: url(data:image/png;base64,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);
		width: 24px;
		height: 26px;
		background-position-y: 1px;
		background-size: contain;
		display: inline-block;
		margin-left: 3px;
	}
	div#footer {
		padding-top: 12px;
		padding-bottom: 12px;
		clear: both;
		width: 100%;
		background-color: #f0f0f0;
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
	}
	#helpButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0, 0, 0, .25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
	}
	#cancelButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0, 0, 0, .25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
	}
	#cancelButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#helpButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:hover:enabled {
		border-color: rgba(255, 106, 16, .75);
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align: 8px;
	}
	#helpButton button:hover {
		border-color: rgba(255, 106, 16, .75);
	}
	#helpButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#helpButton button custom-text {
		vertical-align: 8px;
	}
	#helpCloseButton button {
		padding-left: 0px !important;
	}
	#helpCloseButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	@media all and (max-width: 1610px) {
		#pageHeader {height: 96px;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#pageHeader {height: 96px;}
		#issuerLogo {max-height: 55px; }
		#networkLogo {max-height: 55px; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size: 24px; }
		#pageHeader {height: 90px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		#optGblPage { font-size: 14px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 60px;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size: 18px; }
		#optGblPage { font-size: 14px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; }
		.rightColumn { margin-left: 0px; display: block; float: none; width: 100%; margin-top: 65px;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size: 16px; }
		div.side-menu div.menu-title { display: inline; }
		#optGblPage { font-size: 14px;}
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 75px;}
	}
	@media all and (max-width: 347px) {
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.rightColumn { margin-top: 85px; }
	}
	@media all and (max-width: 309px) {
		.rightColumn { margin-top: 115px; }
	}
	@media all and (max-width: 250px) {
		.rightColumn { margin-top: 120px; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderCenter" ng-style="style" class="ng-scope"></div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>
	<message-banner display-type="''1''" heading-attr="''network_means_pageType_22''" message-attr="''network_means_pageType_23''" close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''" show=true ></message-banner>
	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<div class="contentRow">
		<div class="leftColumn">
			<side-menu menu-title="''network_means_pageType_11''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
			</div>
			<div class="paragraphDescription">
				<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
			</div>
			<div class="paragraphDescription">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		</div>
	</div>
</div>
' WHERE `fk_id_layout` = @layoutIdRefusalPage;
