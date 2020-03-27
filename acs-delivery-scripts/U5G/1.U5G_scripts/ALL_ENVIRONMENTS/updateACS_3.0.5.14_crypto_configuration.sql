CREATE TABLE IF NOT EXISTS `CryptoConfig` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `protocolOne` TEXT NOT NULL,
  `protocolTwo` TEXT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

ALTER TABLE SubIssuer ADD COLUMN fk_id_cryptoConfig INT(11) DEFAULT NULL AFTER twoStepCancellation;
ALTER TABLE SubIssuer ADD FOREIGN KEY (fk_id_cryptoConfig) REFERENCES CryptoConfig(id);

ALTER TABLE BinRange ADD COLUMN fk_id_cryptoConfig INT(11) DEFAULT NULL AFTER coBrandedCardNetwork;
ALTER TABLE BinRange ADD FOREIGN KEY (fk_id_cryptoConfig) REFERENCES CryptoConfig(id);