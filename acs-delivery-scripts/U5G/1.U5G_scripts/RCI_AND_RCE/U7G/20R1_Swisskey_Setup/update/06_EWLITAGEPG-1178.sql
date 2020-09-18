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
SET @createdBy = 'A758582';
SET @updateState =  'PUSHED_TO_CONFIG';
SET @status = 'DEPLOYED_IN_PRODUCTION';


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
UPDATE `Profile` SET `description` = 'REFUSAL (FRAUD)',
					 `name`= CONCAT(@BankCS,'_REFUSAL_FRAUD')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusal_CS
				  AND `name` = CONCAT(@BankCS,'_DEFAULT_REFUSAL');
UPDATE `Profile` SET `description` = 'REFUSAL (FRAUD)',
					 `name`= CONCAT(@BankNAB,'_REFUSAL_FRAUD')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusal_NAB
				  AND `name` = CONCAT(@BankNAB,'_DEFAULT_REFUSAL');
UPDATE `Profile` SET `description` = 'REFUSAL (FRAUD)',
					 `name`= CONCAT(@BankSGKB,'_REFUSAL_FRAUD')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusal_SGKB
				  AND `name` = CONCAT(@BankSGKB,'_DEFAULT_REFUSAL');
UPDATE `Profile` SET `description` = 'REFUSAL (FRAUD)',
					 `name`= CONCAT(@BankSOBA,'_REFUSAL_FRAUD')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusal_SOBA
				  AND `name` = CONCAT(@BankSOBA,'_DEFAULT_REFUSAL');
UPDATE `Profile` SET `description` = 'REFUSAL (FRAUD)',
					 `name`= CONCAT(@BankLUKB,'_REFUSAL_FRAUD')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusal_LUKB
				  AND `name` = CONCAT(@BankLUKB,'_DEFAULT_REFUSAL');
UPDATE `Profile` SET `description` = 'REFUSAL (FRAUD)',
					 `name`= CONCAT(@BankBALI,'_REFUSAL_FRAUD')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusal_BALI
				  AND `name` = CONCAT(@BankBALI,'_DEFAULT_REFUSAL');
UPDATE `Profile` SET `description` = 'REFUSAL (FRAUD)',
					 `name`= CONCAT(@BankBEKB,'_REFUSAL_FRAUD')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusal_BEKB
				  AND `name` = CONCAT(@BankBEKB,'_DEFAULT_REFUSAL');
UPDATE `Profile` SET `description` = 'REFUSAL (FRAUD)',
					 `name`= CONCAT(@BankGRKB,'_REFUSAL_FRAUD')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusal_GRKB
				  AND `name` = CONCAT(@BankGRKB,'_DEFAULT_REFUSAL');
UPDATE `Profile` SET `description` = 'REFUSAL (FRAUD)',
					 `name`= CONCAT(@BankLLB,'_REFUSAL_FRAUD')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusal_LLB
				  AND `name` = CONCAT(@BankLLB,'_DEFAULT_REFUSAL');
UPDATE `Profile` SET `description` = 'REFUSAL (FRAUD)',
					 `name`= CONCAT(@BankTGKB,'_REFUSAL_FRAUD')
				WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusal_TGKB
				  AND `name` = CONCAT(@BankTGKB,'_DEFAULT_REFUSAL');

UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankCS, '_REFUSAL_FRAUD') ,
						 `description` = CONCAT('customitemset_', @BankCS, '_REFUSAL_FRAUD_Current')
						WHERE `name` = CONCAT('customitemset_', @BankCS, '_DEFAULT_REFUSAL');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankNAB, '_REFUSAL_FRAUD') ,
						 `description` = CONCAT('customitemset_', @BankNAB, '_REFUSAL_FRAUD_Current')
						WHERE `name` = CONCAT('customitemset_', @BankNAB, '_DEFAULT_REFUSAL');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankSGKB, '_REFUSAL_FRAUD') ,
						 `description` = CONCAT('customitemset_', @BankSGKB, '_REFUSAL_FRAUD_Current')
						WHERE `name` = CONCAT('customitemset_', @BankSGKB, '_DEFAULT_REFUSAL');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankSOBA, '_REFUSAL_FRAUD') ,
						 `description` = CONCAT('customitemset_', @BankSOBA, '_REFUSAL_FRAUD_Current')
						WHERE `name` = CONCAT('customitemset_', @BankSOBA, '_DEFAULT_REFUSAL');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankLUKB, '_REFUSAL_FRAUD') ,
						 `description` = CONCAT('customitemset_', @BankLUKB, '_REFUSAL_FRAUD_Current')
						WHERE `name` = CONCAT('customitemset_', @BankLUKB, '_DEFAULT_REFUSAL');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankBALI, '_REFUSAL_FRAUD') ,
						 `description` = CONCAT('customitemset_', @BankBALI, '_REFUSAL_FRAUD_Current')
						WHERE `name` = CONCAT('customitemset_', @BankBALI, '_DEFAULT_REFUSAL');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankBEKB, '_REFUSAL_FRAUD') ,
						 `description` = CONCAT('customitemset_', @BankBEKB, '_REFUSAL_FRAUD_Current')
						WHERE `name` = CONCAT('customitemset_', @BankBEKB, '_DEFAULT_REFUSAL');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankGRKB, '_REFUSAL_FRAUD') ,
						 `description` = CONCAT('customitemset_', @BankGRKB, '_REFUSAL_FRAUD_Current')
						WHERE `name` = CONCAT('customitemset_', @BankGRKB, '_DEFAULT_REFUSAL');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankLLB, '_REFUSAL_FRAUD') ,
						 `description` = CONCAT('customitemset_', @BankLLB, '_REFUSAL_FRAUD_Current')
						WHERE `name` = CONCAT('customitemset_', @BankLLB, '_DEFAULT_REFUSAL');
UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankTGKB, '_REFUSAL_FRAUD') ,
						 `description` = CONCAT('customitemset_', @BankTGKB, '_REFUSAL_FRAUD_Current')
						WHERE `name` = CONCAT('customitemset_', @BankTGKB, '_DEFAULT_REFUSAL');

/* CustomItemSet */
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
SET @status = 'DEPLOYED_IN_PRODUCTION';
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankCS, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankCS, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID_CS),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankNAB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankNAB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID_NAB),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankSGKB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankSGKB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID_SGKB),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankSOBA, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankSOBA, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID_SOBA),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankLUKB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankLUKB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID_LUKB),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankBALI, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankBALI, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID_BALI),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankBEKB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankBEKB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID_BEKB),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankGRKB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankGRKB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID_GRKB),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankLLB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankLLB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID_LLB),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankTGKB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankTGKB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID_TGKB);


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

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					   `updateState`, `maxAttempts`, `dataEntryFormat`, `dataEntryAllowedPattern`,`fk_id_authentMeans`,
					   `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
					   `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankCS,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal_CS, NULL, NULL, @subIssuerID_CS),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankNAB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal_NAB, NULL, NULL, @subIssuerID_NAB),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankSGKB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal_SGKB, NULL, NULL, @subIssuerID_SGKB),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankSOBA,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal_SOBA, NULL, NULL, @subIssuerID_SOBA),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankLUKB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal_LUKB, NULL, NULL, @subIssuerID_LUKB),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankBALI,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal_BALI, NULL, NULL, @subIssuerID_BALI),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankBEKB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal_BEKB, NULL, NULL, @subIssuerID_BEKB),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankGRKB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal_GRKB, NULL, NULL, @subIssuerID_GRKB),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankLLB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal_LLB, NULL, NULL, @subIssuerID_LLB),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankTGKB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal_TGKB, NULL, NULL, @subIssuerID_TGKB);


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

UPDATE `Rule` SET `fk_id_profile` = @profileRefusal_CS WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusalFraud_CS;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusal_NAB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusalFraud_NAB;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusal_SGKB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusalFraud_SGKB;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusal_SOBA WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusalFraud_SOBA;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusal_LUKB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusalFraud_LUKB;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusal_BALI WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusalFraud_BALI;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusal_BEKB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusalFraud_BEKB;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusal_GRKB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusalFraud_GRKB;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusal_LLB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusalFraud_LLB;
UPDATE `Rule` SET `fk_id_profile` = @profileRefusal_TGKB WHERE `description` = 'REFUSAL_DEFAULT'
														   AND `name` = 'REFUSAL (DEFAULT)'
														   AND fk_id_profile = @profileRefusalFraud_TGKB;


/********* Refusal Missing Profile *********/
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

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusal_CS FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusalFraud_CS;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusal_NAB FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusalFraud_NAB;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusal_SGKB FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusalFraud_SGKB;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusal_SOBA FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusalFraud_SOBA;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusal_LUKB FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusalFraud_LUKB;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusal_BALI FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusalFraud_BALI;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusal_BEKB FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusalFraud_BEKB;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusal_GRKB FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusalFraud_GRKB;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusal_LLB FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusalFraud_LLB;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusal_TGKB FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusalFraud_TGKB;


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
set @text = 'Zahlung nicht ausgeführt';
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

set @text = 'Payment not completed';
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
set @text = 'Le paiement n''a pas été effectué';
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
set @text = 'Pagamento non eseguito';
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

set @text = 'Ihre Karte ist aus Sicherheitsgründen während einer kurzen Zeitdauer für Online-Zahlungen blockiert.';
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
set @text = 'Your card is temporarily blocked for online payments for security reasons.';
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
set @text = 'Pour des raisons de sécurité, votre carte est bloquée, pour une courte durée,  pour les paiements en ligne.';
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
set @text = 'Per motivi di sicurezza la sua carta è bloccata per i pagamenti online per un breve periodo di tempo.';
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