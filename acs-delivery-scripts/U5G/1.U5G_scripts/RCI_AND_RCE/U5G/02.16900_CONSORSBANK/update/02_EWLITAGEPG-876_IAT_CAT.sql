USE U5G_ACS_BO;

set @updateBy = 'A758582';
set @subIssuerId = (SELECT `id` FROM `SubIssuer` WHERE code = '16900');
set @profileSetId = (SELECT `id` FROM `ProfileSet` WHERE fk_id_subIssuer = @subIssuerId);

set @binRangeId_1 = ( SELECT `id` FROM BinRange
					where fk_id_network = (select `id`
					   from `Network`
					   where `code` = 'VISA')
						  and fk_id_profileSet = @profileSetId
						  and lowerBound = 4159322000
						  and upperBound = 4159329999
						);

set @binRangeId_2 = ( SELECT `id` FROM BinRange
					where fk_id_network = (select `id`
					   from `Network`
					   where `code` = 'VISA')
						  and fk_id_profileSet = @profileSetId
						  and lowerBound = 4163691010
						  and upperBound = 4163699999
						);

DELETE FROM `BinRange_SubIssuer` WHERE `id_binRange` IN (@binRangeId_1, @binRangeId_2);

DELETE FROM `BinRange` WHERE `id` IN (@binRangeId_1, @binRangeId_2);

UPDATE `BinRange` SET `upperBound` = 4159321499
				  WHERE fk_id_profileSet = @profileSetId
				  AND `lowerBound` = 4159321000;
