USE `U5G_ACS_BO`;

DELETE FROM `CustomItem` WHERE `ordinal` IN (254, 255, 256)
						   AND pageTypes = 'APP_VIEW'
						   AND DTYPE = 'I';
