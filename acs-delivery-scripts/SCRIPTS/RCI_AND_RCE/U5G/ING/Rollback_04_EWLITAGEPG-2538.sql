USE `U5G_ACS_BO`;
SET @LowerBnd='4546174000';
SET @UpperBnd= '4546174999';

SELECT * FROM `BinRange_SubIssuer` where `id_binRange`= (select id from `BinRange` where `lowerBound`= @LowerBnd AND `upperBound`=@UpperBnd);
DELETE FROM `BinRange_SubIssuer` where `id_binRange`= (select id from `BinRange` where `lowerBound`= @LowerBnd AND `upperBound`=@UpperBnd);
SELECT * FROM `BinRange_SubIssuer` where `id_binRange`= (select id from `BinRange` where `lowerBound`= @LowerBnd AND `upperBound`=@UpperBnd);

select * from `BinRange` where `lowerBound`= @LowerBnd AND `upperBound`=@UpperBnd;
DELETE from `BinRange` where `lowerBound`= @LowerBnd AND `upperBound`=@UpperBnd;
select * from `BinRange` where `lowerBound`= @LowerBnd AND `upperBound`=@UpperBnd;