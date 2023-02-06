USE `U7G_ACS_BO`;

SELECT * from `Network`;


SET @nameVisa = 'VISA';
SET @displayNameVisa = 'VISA™';
SET @solutionVisa = 'Visa Secure';
SET @dsRefNumber = '3DS_LOA_DIS_VISA_020200_00474'; 

UPDATE `Network` SET `name` =  @nameVisa, `displayName` =  @displayNameVisa, `solution` =  @solutionVisa, `secondaryDsReferenceNumber` =  @dsRefNumber WHERE `code` = 'VISA';

SET @nameMC = 'MASTERCARD';
SET @displayNameMC = 'MASTERCARD©';
SET @solutionMC = 'Mastercard ID Check';
SET @dsRefNumber = '3DS_LOA_DIS_MAST_020200_00281'; 

UPDATE `Network` SET `name` =  @nameMC, `displayName` =  @displayNameMC, `solution` =  @solutionMC, `dsReferenceNumber` =  @dsRefNumber WHERE `code` = 'MASTERCARD';

SELECT * from `Network`;
