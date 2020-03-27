
ALTER TABLE `SubIssuer_Configuration`
ADD COLUMN `authDataAddition` BIT(1) NOT NULL DEFAULT 0 AFTER `defaultDelayInExemption`;
