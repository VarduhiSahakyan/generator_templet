USE U5G_ACS_BO;

SELECT * FROM Network;

UPDATE Network SET dsReferenceNumber = NULL, displayName = ''
WHERE code = 'MASTERCARD';

SELECT * FROM Network;
