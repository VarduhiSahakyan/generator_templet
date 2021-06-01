
USE `U5G_ACS_BO`;

UPDATE `SubIssuer` set `authenticationTimeOut` = 180, `transactionTimeOut` = 300 where `code` = '19450';