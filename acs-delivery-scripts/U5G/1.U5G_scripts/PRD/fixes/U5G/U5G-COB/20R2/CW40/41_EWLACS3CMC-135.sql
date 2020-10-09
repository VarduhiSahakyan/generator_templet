USE `U5G_ACS_BO`;

SET @createdBy = 'InitPhase';
SET @issuerCode = '19450';

UPDATE `SubIssuer` set `resendOTPThreshold` = 3 , `resendSameOTP` = TRUE 
Where `code` = @issuerCode;