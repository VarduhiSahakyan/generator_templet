-- 08/04/2019
-- FPLACS3-1080
-- adds 2 column to the table SubIssuer: resendOTPThreshold and resendSameOTP

ALTER TABLE `SubIssuer`
ADD COLUMN `resendOTPThreshold` INT(2) NOT NULL DEFAULT 3,
ADD COLUMN `resendSameOTP` BIT(1) NOT NULL DEFAULT 1;