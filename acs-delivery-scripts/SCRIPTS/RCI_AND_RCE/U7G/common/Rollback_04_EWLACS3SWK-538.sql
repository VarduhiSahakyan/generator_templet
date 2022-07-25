USE U7G_ACS_BO;

UPDATE `SubIssuer` SET `authenticationTimeOut` = 120;
UPDATE `SubIssuer` SET `authenticationTimeOut` = 180 WHERE `code` = 23000;
UPDATE `SubIssuer` SET `authenticationTimeOut` = 300 WHERE `code` = 77800;

