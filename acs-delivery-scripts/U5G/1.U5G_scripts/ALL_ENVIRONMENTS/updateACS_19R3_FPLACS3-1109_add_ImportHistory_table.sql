CREATE TABLE IF NOT EXISTS `ImportHistory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `author` varchar(255) NOT NULL,
  `importDate` datetime NOT NULL,
  `scope` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='History table for import tool.';
