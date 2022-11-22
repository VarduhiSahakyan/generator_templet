USE U5G_ACS_BO;

SELECT * FROM Network;

UPDATE Network SET displayName = ''
WHERE code = 'JCB';

SELECT * FROM Network;
