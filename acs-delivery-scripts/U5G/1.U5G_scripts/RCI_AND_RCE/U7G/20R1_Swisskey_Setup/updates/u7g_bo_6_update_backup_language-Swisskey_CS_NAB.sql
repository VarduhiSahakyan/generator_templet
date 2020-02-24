use U7G_ACS_BO;

SET @backUpLanguages = 'en,fr,it';

SET @subIssuerCodeCS = '48350';
SET @subIssuerCodeNAB = '58810';


UPDATE SubIssuer SET backupLanguages = @backUpLanguages WHERE `code` = @subIssuerCodeCS;
UPDATE SubIssuer SET backupLanguages = @backUpLanguages WHERE `code` = @subIssuerCodeNAB;
