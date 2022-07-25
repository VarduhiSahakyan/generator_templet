USE U2M_ACS_MONITOR;
SET @acsId = "ANY";

-- Valid Sites are Vendome,Brussels
SET @SiteName = 'Vendome'; 

SET @newURL = 'https://ssl-prd-babel.wlp-acs.com';
SET @oldURL = 'https://ssl-prd-babel.as8677.net';

UPDATE `SERVICE_INFO` SET ADDITIONAL_INFO = REPLACE(ADDITIONAL_INFO, @oldURL, @newURL) WHERE ACS_ID = @acsID AND SERVICE_NAME LIKE '%babel%' AND SITE_NAME = @SiteName;