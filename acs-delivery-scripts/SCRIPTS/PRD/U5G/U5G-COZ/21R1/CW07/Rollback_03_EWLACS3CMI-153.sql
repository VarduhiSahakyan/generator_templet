
USE `U5G_ACS_BO`;

UPDATE `SubIssuer` set `authenticationTimeOut` = 120, `transactionTimeOut` = 300  where `code` = '19440';
