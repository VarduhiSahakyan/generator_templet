CREATE TABLE `TransactionValue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `reversed` bit(1) DEFAULT NULL,
  `transactionValueType` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `fk_id_condition` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_4joqr3sx6fv1nqkw82918v1f0` (`fk_id_condition`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;