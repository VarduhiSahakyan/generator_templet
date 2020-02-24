
ALTER TABLE `SubIssuer`
    ADD COLUMN `combinedAuthenticationAllowed` BIT(1) NOT NULL DEFAULT FALSE;