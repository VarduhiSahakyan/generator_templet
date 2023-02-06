USE `U7G_ACS_BO`;

SELECT * from `Network`;


SET @nameVisa = 'VISA';
SET @displayNameVisa = '';
SET @solutionVisa = 'Verified by VISA';
SET @dsRefNumber = NULL; 

UPDATE `Network` SET `name` =  @nameVisa, `displayName` =  @displayNameVisa, `solution` =  @solutionVisa, `secondaryDsReferenceNumber` =  @dsRefNumber WHERE `code` = 'VISA';

SET @nameMC = 'MASTERCARD';
SET @displayNameMC = '';
SET @solutionMC = 'Mastercard ID Check';
SET @dsRefNumber = '3DS_LOA_DIS_MAST_020100_00038'; 

UPDATE `Network` SET `name` =  @nameMC, `displayName` =  @displayNameMC, `solution` =  @solutionMC, `dsReferenceNumber` =  @dsRefNumber WHERE `code` = 'MASTERCARD';

SELECT * from `Network`;

