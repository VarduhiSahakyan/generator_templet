-- LONGTEXT columns cannot have DEFAULT values (cf official doc from mysql)
ALTER TABLE `CustomComponent` CHANGE COLUMN `value` `value` LONGTEXT NULL;