ALTER TABLE `SubIssuer` ADD COLUMN `authentMeans` TEXT NULL;
UPDATE SubIssuer sb, Issuer i SET sb.authentMeans=i.authentMeans WHERE sb.fk_id_issuer = i.id;
ALTER TABLE Issuer DROP COLUMN authentMeans;