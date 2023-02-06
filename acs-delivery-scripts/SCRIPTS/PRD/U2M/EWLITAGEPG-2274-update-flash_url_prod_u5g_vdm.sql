USE `U2M_ACS_MONITOR`;
SET @acsId = "U5G";

-- Valid Sites are Vendome,Brussels
SET @SiteName = 'Vendome';

SET @serviceNameFlash = "flash";
SET @oldUrlFlash = 'ssl-prd-flash.as8677.net';
SET @newUrlFlash = 'ssl-prd-flash.wlp-acs.com';

UPDATE `SERVICE_INFO` SET ADDITIONAL_INFO = REPLACE(ADDITIONAL_INFO, @oldUrlFlash, @newUrlFlash) WHERE ACS_ID = @acsID AND SERVICE_NAME = @serviceNameFlash AND SITE_NAME = @SiteName;
