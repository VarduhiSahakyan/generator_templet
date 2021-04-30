USE `U5G_ACS_BO`;

SET @createdBy ='A758582';

SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_SPB_sharedBIN_DEFAULT_REFUSAL');
SET @pageTypes = 'REFUSAL_PAGE';
SET @ordinal = 22;
SET @value = 'Eine Freigabe der Zahlung ist nicht möglich.';

UPDATE `CustomItem` SET VALUE =@value  WHERE fk_id_customItemSet = @customItemSetId
                                        AND ordinal = @ordinal
                                        AND pageTypes = @pageTypes;

SET @ordinal = 23;
SET @value = 'Bitte wenden Sie sich an die kontoführende Filiale Ihrer Sparda-Bank.';

UPDATE `CustomItem` SET VALUE =@value  WHERE fk_id_customItemSet = @customItemSetId
                                        AND ordinal = @ordinal
                                        AND pageTypes = @pageTypes;