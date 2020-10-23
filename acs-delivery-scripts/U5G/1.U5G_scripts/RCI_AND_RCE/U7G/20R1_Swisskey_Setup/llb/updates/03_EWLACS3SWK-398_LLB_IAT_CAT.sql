USE U7G_ACS_BO;

SET @BankB = 'SWISSKEY';
SET @BankUB = 'LLB';

UPDATE `CustomPageLayout` SET `pageType` = 'PASSWORD_APP_VIEW',
                              `description` = 'App_View PASSWORD (SWISSKEY)'
                        where `pageType` = 'EXT_PASSWORD_APP_VIEW' AND
                              `description` = 'App_View EXT_PASSWORD (SWISSKEY)' ;