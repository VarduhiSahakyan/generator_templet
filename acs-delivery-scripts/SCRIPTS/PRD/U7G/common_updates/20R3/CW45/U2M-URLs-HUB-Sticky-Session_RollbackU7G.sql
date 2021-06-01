
USE `U2M_ACS_MONITOR`;

DELETE FROM `SERVICE_INFO` WHERE `SERVICE_NAME` IN ('authent.hub.seclin', 'authent.hub.vendome') and `ACS_ID` IN ('U7G');
