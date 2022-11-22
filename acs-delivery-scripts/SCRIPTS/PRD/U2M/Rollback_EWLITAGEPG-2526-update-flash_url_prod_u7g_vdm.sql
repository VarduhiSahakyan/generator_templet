USE `U2M_ACS_MONITOR`;
SET @acsId = "U7G";

-- Valid Sites are Vendome,Brussels
SET @SiteName = 'Vendome';

SET @serviceNameFlash = "flash";
SET @oldUrlFlash = 'ssl-prd-flash2-vdm.as8677.net';
SET @newUrlFlash = 'ssl-prd-flash.wlp-acs.com';

UPDATE `SERVICE_INFO` SET ADDITIONAL_INFO = REPLACE(ADDITIONAL_INFO, @newUrlFlash, @oldUrlFlash) WHERE ACS_ID = @acsID AND SERVICE_NAME = @serviceNameFlash AND SITE_NAME = @SiteName;
