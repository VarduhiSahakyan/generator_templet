ALTER TABLE `SubIssuer`
ADD COLUMN `trustedBeneficiariesAllowed` BIT(1) NOT NULL DEFAULT b'0';