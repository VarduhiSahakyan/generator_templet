USE `U2M_ACS_MONITOR`;
SET @acsId = "ANY";

SET @serviceNameBabel = "%babel%";
SET @oldUrlBabel = 'ssl-prd-babel.as8677.net';
SET @newUrlBabel = 'ssl-prd-babel.wlp-acs.com';

UPDATE `SERVICE_INFO` SET ADDITIONAL_INFO = REPLACE(ADDITIONAL_INFO, @oldUrlBabel, @newUrlBabel) WHERE ACS_ID = @acsID AND SERVICE_NAME LIKE @serviceNameBabel;
