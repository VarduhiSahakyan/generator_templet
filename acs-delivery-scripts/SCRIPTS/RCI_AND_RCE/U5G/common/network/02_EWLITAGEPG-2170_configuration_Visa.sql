USE U5G_ACS_BO;

SELECT * FROM Network;

UPDATE Network SET dsReferenceNumber = 'VISA.V 17 0003', displayName = 'VISA™'
WHERE code = 'VISA';

SELECT * FROM Network;
