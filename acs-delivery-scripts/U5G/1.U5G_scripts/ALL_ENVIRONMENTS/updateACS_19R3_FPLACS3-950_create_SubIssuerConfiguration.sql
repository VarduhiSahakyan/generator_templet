CREATE TABLE `SubIssuer_Configuration` (
	`subIssuerCode` VARCHAR(255) NOT NULL,
	`defaultDelayInExemption` INT(5) NOT NULL DEFAULT '1',
	PRIMARY KEY (`subIssuerCode`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;