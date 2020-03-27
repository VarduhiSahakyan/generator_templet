ALTER TABLE `SubIssuer`
    ADD COLUMN `formattedDateJavaFormat` VARCHAR(255) NOT NULL DEFAULT 'dd.MM.yyyy' AFTER `dateFormat`;