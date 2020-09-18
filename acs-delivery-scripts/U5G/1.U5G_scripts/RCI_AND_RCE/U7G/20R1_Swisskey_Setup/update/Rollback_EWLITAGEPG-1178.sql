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