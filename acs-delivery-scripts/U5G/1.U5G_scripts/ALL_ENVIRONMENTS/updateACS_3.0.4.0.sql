ALTER TABLE `BinRange`
ADD COLUMN `toExport` BIT(1) NOT NULL DEFAULT 0 AFTER `fk_id_profileSet`;