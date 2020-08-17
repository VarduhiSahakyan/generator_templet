USE U5G_ACS_BO;

set @binRangeId = ( SELECT `id` FROM BinRange
                    where fk_id_network = (select `id`
					   from `Network`
					   where `code` = 'VISA')
                          and fk_id_profileSet is NULL
                          and lowerBound = 4163690000
                          and upperBound = 4163699999
                        );

DELETE FROM `BinRange_SubIssuer` WHERE `id_binRange` = @binRangeId;

DELETE FROM `BinRange` WHERE `id` = @binRangeId;
