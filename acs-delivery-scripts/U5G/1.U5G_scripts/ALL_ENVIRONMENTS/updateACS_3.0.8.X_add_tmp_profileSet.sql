ALTER TABLE `ProfileSet`
ADD COLUMN `profileTmp` BIT(1) NOT NULL DEFAULT 0 AFTER `updateState`;
