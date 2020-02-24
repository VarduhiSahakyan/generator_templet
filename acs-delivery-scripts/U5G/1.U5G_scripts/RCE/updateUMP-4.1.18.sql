ALTER TABLE ROLE
ADD COLUMN `ROLE_PARENT` BIGINT NULL DEFAULT NULL AFTER `ROLE_PROTECTED`;

UPDATE ROLE SET ROLE_PARENT = null WHERE ROLE_NAME = 'SUPER_ADMIN_WORLDLINE'; -- Role sans role parent (Le père de tous les roles)
UPDATE ROLE SET ROLE_PARENT = 37 WHERE ROLE_NAME = 'ADMIN_WORLDLINE'; -- Role parent : SUPER_ADMIN_WORLDLINE
UPDATE ROLE SET ROLE_PARENT = 6 WHERE ROLE_NAME = 'ADMIN_CA-PS'; -- Role parent : ADMIN_WORLDLINE
UPDATE ROLE SET ROLE_PARENT = 6 WHERE ROLE_NAME = 'ADMIN_30006'; -- Role parent : ADMIN_WORLDLINE
UPDATE ROLE SET ROLE_PARENT = 6 WHERE ROLE_NAME = 'ADMIN_30006_14806'; -- Role parent : ADMIN_WORLDLINE
UPDATE ROLE SET ROLE_PARENT = 6 WHERE ROLE_NAME = 'HELPDESK_WORLDLINE'; -- Role parent : ADMIN_WORLDLINE
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_CA-PS'; -- Role parent : CA-PS
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_30006'; -- Role parent : CA-PS
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_30006_14806'; -- Role parent : CA-PS
UPDATE ROLE SET ROLE_PARENT = 6 WHERE ROLE_NAME = 'ADMIN_30002'; -- Role parent : ADMIN_WORLDLINE
UPDATE ROLE SET ROLE_PARENT = 6 WHERE ROLE_NAME = 'ADMIN_30006_17806'; -- Role parent : ADMIN_WORLDLINE

UPDATE ROLE SET ROLE_PARENT = 6 WHERE ROLE_NAME = 'ADMIN_NPS'; -- Role parent : ADMIN_WORLDLINE
UPDATE ROLE SET ROLE_PARENT = 38 WHERE ROLE_NAME = 'ADMIN_30007'; -- Role parent : ADMIN_NPS
UPDATE ROLE SET ROLE_PARENT = 38 WHERE ROLE_NAME = 'ADMIN_19505'; -- Role parent : ADMIN_NPS
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_30006_12736'; -- Role parent : CA-PS
UPDATE ROLE SET ROLE_PARENT = 38 WHERE ROLE_NAME = 'COMMERCANT_TEST_NPS'; -- Role parent : ADMIN_NPS
UPDATE ROLE SET ROLE_PARENT = 6 WHERE ROLE_NAME = 'HELPDESK_BANQUE'; -- Role parent : ADMIN_WORLDLINE
UPDATE ROLE SET ROLE_PARENT = 6 WHERE ROLE_NAME = 'ADMIN_BANQUE'; -- Role parent : ADMIN_WORLDLINE
UPDATE ROLE SET ROLE_PARENT = 6 WHERE ROLE_NAME = 'ADMIN_BANQUE2'; -- Role parent : ADMIN_WORLDLINE
UPDATE ROLE SET ROLE_PARENT = 6 WHERE ROLE_NAME = 'HELPDESK_test_subissuer'; -- Role parent : ADMIN_WORLDLINE
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_30006_CACF'; -- Role parent : CA-PS
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_30006_12906'; -- Role parent : CA-PS
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_30006_16806'; -- Role parent : CA-PS
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_30006_12739'; -- Role parent : CA-PS
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_30006_14006'; -- Role parent : CA-PS
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_30006_17106'; -- Role parent : CA-PS
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_30006_18206'; -- Role parent : CA-PS
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_30006_19806'; -- Role parent : CA-PS
UPDATE ROLE SET ROLE_PARENT = 6 WHERE ROLE_NAME = 'ADMIN_XXX'; -- Role parent : ADMIN_WORLDLINE
UPDATE ROLE SET ROLE_PARENT = 9 WHERE ROLE_NAME = 'HELPDESK_30006_13106'; -- Role parent : CA-PS