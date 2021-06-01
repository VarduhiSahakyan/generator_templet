USE U5G_ACS_BO;

set @updateBy = 'A757435';
set @subIssuerId = (SELECT `id` FROM `SubIssuer` WHERE code = '16900');
set @profileSetId = (SELECT `id` FROM `ProfileSet` WHERE fk_id_subIssuer = @subIssuerId);

set @binRangeId = ( SELECT `id` FROM BinRange
                    where fk_id_network = (select `id`
					   from `Network`
					   where `code` = 'VISA')
                          and fk_id_profileSet = @profileSetId
                          and lowerBound = 4163698000
                          and upperBound = 4163698009
                        );

DELETE FROM `BinRange_SubIssuer` WHERE `id_binRange` = @binRangeId;

DELETE FROM `BinRange` WHERE `id` = @binRangeId;
